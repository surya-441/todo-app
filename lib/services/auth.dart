import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_1/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create a user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
  //sign in anonymouly
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);    
    } catch (e) {
        print(e.toString());
        return null;
    }
  }

  //sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
      }catch(e) {
        print(e.toString());
        return null;
      }
  }
  //register with email
  Future regiterWithEmailAndPassword(String email, String password) async {
      try {
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
      }catch(e) {
        print(e.toString());
        return null;
      }
  }
  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e) {
      print(e.toString());
      return null;
    }
  }
}