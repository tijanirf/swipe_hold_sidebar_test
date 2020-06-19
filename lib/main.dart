import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: MyHomePage(title: 'Swipe-Hold SideBar Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final PageController _pageController = PageController();
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  bool _swipe = false;

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      swipe: true,
      colorTransitionChild: Colors.white, // default Color.black54
      colorTransitionScaffold: Colors.transparent, // default Color.black54
      leftChild: MySideBar(
        innerDrawerKey: _innerDrawerKey,
      ),
      rightChild: MyNotification(
        innerDrawerKey: _innerDrawerKey,
      ),
      leftAnimationType: InnerDrawerAnimation.linear,
      rightAnimationType: InnerDrawerAnimation.linear,
      offset: IDOffset.only(
        bottom: 0,
        right: 1,
        left: 0.5,
      ),
      scale: IDOffset.horizontal(0.7),
      backgroundDecoration: BoxDecoration(color: Colors.white),
      borderRadius: 50,
      scaffold: MyDashboard(),
    );
  }
}

class MySideBar extends StatefulWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  const MySideBar({Key key, this.innerDrawerKey}) : super(key: key);

  @override
  _MySideBarState createState() => _MySideBarState();
}

class _MySideBarState extends State<MySideBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: Icon(Icons.close),
              onTap: () {
                widget.innerDrawerKey.currentState.toggle();
              },
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 50,
          ),
          child: Column(
            children: <Widget>[
              Text(
                'My SideBar',
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                onPressed: () => print('=== pressed'),
                child: Text('Button 1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyNotification extends StatelessWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  const MyNotification({Key key, this.innerDrawerKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => innerDrawerKey.currentState.toggle(),
          child: Icon(Icons.arrow_back),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.blueAccent,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            'My Notification',
          ),
        ),
      ),
    );
  }
}

class MyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            'My Dashboard',
          ),
        ),
      ),
    );
  }
}

class MyDashboardWithGesture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (horizontalDrag) {
        print('====== ${horizontalDrag.primaryDelta}');
        if (horizontalDrag.primaryDelta < 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MyNotification()));
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              'My Dashboard',
            ),
          ),
        ),
      ),
    );
  }
}
