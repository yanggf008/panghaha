import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class PictureScreen extends StatefulWidget {
  PictureScreen({Key, key}) : super(key: key);
  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  VideoPlayerController _videoController;

  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    // TODO: implement initState
    _videoController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
    );
    _initializeVideoPlayerFuture = _videoController.initialize();
    _videoController.setLooping(true);
    super.initState();
  }

  @override
  void dispose(){
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return AspectRatio(aspectRatio: _videoController.value.aspectRatio);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
          }),
          FloatingActionButton(
              onPressed: (){
                setState(() {
                  if(_videoController.value.isPlaying){
                    _videoController.pause();
                  } else {
                    _videoController.play();
                  }
                });
              },
            child: Icon(
              _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow
            ),
          )
        ],
      )
    );
  }
}
