From: GESTES Cedric <ctaf.audio@laposte.net>
Subject: [PATCH] us428control support for mixxx
Date: Sun, 01 Oct 2006 10:20:30 +0200
Message-ID: <451F7A4E.6040804@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030901020401060602090403"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030901020401060602090403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch allow to change the midi mapping of the us428, the new 
mapping is used with mixxx.
To use the new mapping:
./us428control -m mixxx

I have splitted the class who does the mapping, it is more easy to add 
new mapping now.
Furthermore I need to find a way to communicate with the program, to 
change mapping on the fly.
Cause currently us428control is launched from udev, and to change the 
mapping you should kill the previous us428control and launch another.

I already posted an older version on the bug tracker, but I had'nt have 
response for it. (with different addrese cause gmail bounce my mail to 
sf.net)
thanks.

Signed-off-by: Cedric GESTES <ctaf.audio@laposte.net>



--------------030901020401060602090403
Content-Type: text/x-patch;
 name="us428control-mixxx-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="us428control-mixxx-v3.patch"

diff -r 7f7a0bf510a4 us428control/Cus428Midi.h
--- a/us428control/Cus428Midi.h	Tue Sep 12 15:35:53 2006 +0200
+++ b/us428control/Cus428Midi.h	Sat Sep 30 18:05:42 2006 +0200
@@ -87,14 +87,23 @@ class Cus428Midi {
 		return Err;
 	}
 
-	int SendMidiControl(char Param, char Val){
-		snd_seq_ev_set_controller(&Ev, 15, Param, Val & 0x7F);
+	int SendMidiControl(char Channel, char Param, char Val){
+		snd_seq_ev_set_controller(&Ev, Channel, Param, Val & 0x7F);
 		SubMitEvent();
 		return 0;
-	} 
+	}
 
-	int SendMidiControl(Cus428State::eKnobs K, bool Down){
-		return SendMidiControl(KnobParam[K - Cus428State::eK_RECORD], Down ? 0x7F : 0);
+	int SendMidiNote(char Channel, char Note, char Val){
+    if (!Val)
+      snd_seq_ev_set_noteoff(&Ev, Channel, Note, Val & 0x7F);
+    else
+      snd_seq_ev_set_noteon(&Ev, Channel, Note, Val & 0x7F);
+		SubMitEvent();
+		return 0;
+	}
+
+	int SendMidiControl(char Channel, Cus428State::eKnobs K, bool Down){
+		return SendMidiControl(Channel, KnobParam[K - Cus428State::eK_RECORD], Down ? 0x7F : 0);
 	}
 
 	// To parse and dispatch input MIDI events.
diff -r 7f7a0bf510a4 us428control/Cus428State.cc
--- a/us428control/Cus428State.cc	Tue Sep 12 15:35:53 2006 +0200
+++ b/us428control/Cus428State.cc	Sat Sep 30 18:05:42 2006 +0200
@@ -46,7 +46,6 @@ void Cus428State::InitDevice(void)
 		SliderChangedTo(eFaderM, ((unsigned char*)(us428ctls_sharedmem->CtlSnapShot + us428ctls_sharedmem->CtlSnapShotLast))[eFaderM]);
 }
 
-
 int Cus428State::LightSend()
 {
 	int Next = us428ctls_sharedmem->p4outLast + 1;
@@ -57,6 +56,11 @@ int Cus428State::LightSend()
 	return us428ctls_sharedmem->p4outLast = Next;
 }
 
+void Cus428State::SliderSend(int S)
+{
+	Midi.SendMidiControl(15, 0x40 + S, ((unsigned char*)us428_ctls)[S] / 2);
+}
+
 void Cus428State::SendVolume(usX2Y_volume &V)
 {
 	int Next = us428ctls_sharedmem->p4outLast + 1;
@@ -67,22 +71,100 @@ void Cus428State::SendVolume(usX2Y_volum
 	us428ctls_sharedmem->p4outLast = Next;
 }
 
+void Cus428State::UserSliderChangedTo(int S, unsigned char New)
+{
+  SliderSend(S);
+}
+
 void Cus428State::SliderChangedTo(int S, unsigned char New)
 {
-	if (StateInputMonitor() && S <= eFader3
-	    || S == eFaderM) {
+	if (StateInputMonitor() && S <= eFader3 || S == eFaderM) {
 		usX2Y_volume &V = Volume[S >= eFader4 ? eFader4 : S];
 		V.SetTo(S, New);
 		if (S == eFaderM || !LightIs(eL_Mute0 + S))
 			SendVolume(V);
 	}
-	else SliderSend(S);
-}
-
-void Cus428State::SliderSend(int S)
-{
-	Midi.SendMidiControl(0x40 + S, ((unsigned char*)us428_ctls)[S] / 2);
-}
+	else
+    UserSliderChangedTo(S, New);
+}
+
+void Cus428State::UserKnobChangedTo(eKnobs K, bool V)
+{
+		switch (K) {
+		case eK_STOP:
+			if (verbose > 1)
+				printf("Knob STOP now %i\n", V);
+			if (V) TransportToggle(T_STOP);
+			Midi.SendMidiControl(15, K, V);
+			break;
+		case eK_PLAY:
+			if (verbose > 1)
+				printf("Knob PLAY now %i", V);
+			if (V) TransportToggle(T_PLAY);
+			if (verbose > 1)
+				printf(" Light is %i\n", LightIs(eL_Play));
+			Midi.SendMidiControl(15, K, V);
+			break;
+		case eK_REW:
+			if (verbose > 1)
+				printf("Knob REW now %i", V);
+			if (V) TransportToggle(T_REW);
+			if (verbose > 1)
+				printf(" Light is %i\n", LightIs(eL_Rew));
+			Midi.SendMidiControl(15, K, V);
+			break;
+		case eK_FFWD:
+			if (verbose > 1)
+				printf("Knob FFWD now %i", V);
+			if (V) TransportToggle(T_F_FWD);
+			if (verbose > 1)
+				printf(" Light is %i\n", LightIs(eL_FFwd));
+			Midi.SendMidiControl(15, K, V);
+			break;
+		case eK_RECORD:
+			if (verbose > 1)
+				printf("Knob RECORD now %i", V);
+			if (V) TransportToggle(T_RECORD);
+			if (verbose > 1)
+				printf(" Light is %i\n", LightIs(eL_Record));
+			Midi.SendMidiControl(15, K, V);
+			break;
+		case eK_SET:
+			if (verbose > 1)
+				printf("Knob SET now %i", V);
+			bSetLocate = V;
+			break;
+		case eK_LOCATE_L:
+			if (verbose > 1)
+				printf("Knob LOCATE_L now %i", V);
+			if (V) {
+				if (bSetLocate)
+					aWheel_L = aWheel;
+				else {
+					aWheel = aWheel_L;
+					LocateSend();
+				}
+			}
+			break;
+		case eK_LOCATE_R:
+			if (verbose > 1)
+				printf("Knob LOCATE_R now %i", V);
+			if (V) {
+				if (bSetLocate)
+					aWheel_R = aWheel;
+				else {
+					aWheel = aWheel_R;
+					LocateSend();
+				}
+			}
+			break;
+		default:
+			if (verbose > 1)
+				printf("Knob %i now %i\n", K, V);
+			Midi.SendMidiControl(15, K, V);
+		}
+}
+
 
 void Cus428State::KnobChangedTo(eKnobs K, bool V)
 {
@@ -109,121 +191,36 @@ void Cus428State::KnobChangedTo(eKnobs K
 		}
 		break;
 	default:
-		switch (K) {
-		case eK_STOP:
-			if (verbose > 1)
-				printf("Knob STOP now %i\n", V);
-			if (V) TransportToggle(T_STOP);
-			Midi.SendMidiControl(K, V);
-			break;
-		case eK_PLAY:
-			if (verbose > 1)
-				printf("Knob PLAY now %i", V);
-			if (V) TransportToggle(T_PLAY);
-			if (verbose > 1)
-				printf(" Light is %i\n", LightIs(eL_Play));
-			Midi.SendMidiControl(K, V);
-			break;
-		case eK_REW:
-			if (verbose > 1)
-				printf("Knob REW now %i", V);
-			if (V) TransportToggle(T_REW);
-			if (verbose > 1)
-				printf(" Light is %i\n", LightIs(eL_Rew));
-			Midi.SendMidiControl(K, V);
-			break;
-		case eK_FFWD:
-			if (verbose > 1)
-				printf("Knob FFWD now %i", V);
-			if (V) TransportToggle(T_F_FWD);
-			if (verbose > 1)
-				printf(" Light is %i\n", LightIs(eL_FFwd));
-			Midi.SendMidiControl(K, V);
-			break;
-		case eK_RECORD:
-			if (verbose > 1)
-				printf("Knob RECORD now %i", V);
-			if (V) TransportToggle(T_RECORD);
-			if (verbose > 1)
-				printf(" Light is %i\n", LightIs(eL_Record));
-			Midi.SendMidiControl(K, V);
-			break;
-		case eK_SET:
-			if (verbose > 1)
-				printf("Knob SET now %i", V);
-			bSetLocate = V;
-			break;
-		case eK_LOCATE_L:
-			if (verbose > 1)
-				printf("Knob LOCATE_L now %i", V);
-			if (V) {
-				if (bSetLocate)
-					aWheel_L = aWheel;
-				else {
-					aWheel = aWheel_L;
-					LocateSend();
-				}
-			}
-			break;
-		case eK_LOCATE_R:
-			if (verbose > 1)
-				printf("Knob LOCATE_R now %i", V);
-			if (V) {
-				if (bSetLocate)
-					aWheel_R = aWheel;
-				else {
-					aWheel = aWheel_R;
-					LocateSend();
-				}
-			}
-			break;
-		case eK_InputMonitor:
-			if (verbose > 1)
-				printf("Knob InputMonitor now %i", V);
-			if (V) {
-				if (StateInputMonitor()) {
-					SelectInputMonitor = Light[0].Value;
-					MuteInputMonitor = Light[2].Value;
-				} else {
-					Select = Light[0].Value;
-					Mute = Light[2].Value;
-				}
-				LightSet(eL_InputMonitor, ! StateInputMonitor());
-				Light[0].Value = StateInputMonitor() ? SelectInputMonitor : Select;
-				Light[2].Value = StateInputMonitor() ? MuteInputMonitor : Mute;
-				LightSend();
-			}
-			if (verbose > 1)
-				printf(" Light is %i\n", LightIs(eL_InputMonitor));
-			break;
-		default:
-			if (verbose > 1)
-				printf("Knob %i now %i\n", K, V);
-			Midi.SendMidiControl(K, V);
-		}
+	  if (K == eK_InputMonitor)
+      {
+        if (verbose > 1)
+          printf("Knob InputMonitor now %i", V);
+        if (V) {
+          if (StateInputMonitor()) {
+            SelectInputMonitor = Light[0].Value;
+            MuteInputMonitor = Light[2].Value;
+          } else {
+            Select = Light[0].Value;
+            Mute = Light[2].Value;
+          }
+          LightSet(eL_InputMonitor, ! StateInputMonitor());
+          Light[0].Value = StateInputMonitor() ? SelectInputMonitor : Select;
+          Light[2].Value = StateInputMonitor() ? MuteInputMonitor : Mute;
+          LightSend();
+        }
+        if (verbose > 1)
+          printf(" Light is %i\n", LightIs(eL_InputMonitor));
+      }
+    else
+      UserKnobChangedTo(K, V);
 	}
 }
 
-
-void Cus428State::WheelChangedTo(E_In84 W, char Diff)
+void Cus428State::UserWheelChangedTo(E_In84 W, char Diff)
 {
 	char Param;
 	switch (W) {
 	case eWheelPan:
-		if (StateInputMonitor() && Light[0].Value) {
-			int index = 0;
-
-			while( index < 4 && (1 << index) !=  Light[0].Value)
-				index++;
-
-			if (index >= 4)
-				return;
-
-			Volume[index].PanTo(Diff, us428_ctls->Knob(eK_SET));
-			if (!LightIs(eL_Mute0 + index))
-				SendVolume(Volume[index]);
-			return;
-		}
 		Param = 0x4D;
 		break;
 	case eWheelGain:
@@ -241,7 +238,27 @@ void Cus428State::WheelChangedTo(E_In84 
 		WheelDelta((int) ((unsigned char *) us428_ctls)[W]);
 		break;
 	}
-	Midi.SendMidiControl(Param, ((unsigned char *) us428_ctls)[W]);
+	Midi.SendMidiControl(15, Param, ((unsigned char *) us428_ctls)[W]);
+}
+
+void Cus428State::WheelChangedTo(E_In84 W, char Diff)
+{
+  if (W == eWheelPan && StateInputMonitor() && Light[0].Value)
+    {
+      int index = 0;
+
+      while( index < 4 && (1 << index) !=  Light[0].Value)
+        index++;
+
+      if (index >= 4)
+        return;
+
+      Volume[index].PanTo(Diff, us428_ctls->Knob(eK_SET));
+      if (!LightIs(eL_Mute0 + index))
+        SendVolume(Volume[index]);
+      return;
+    }
+  UserWheelChangedTo(W, Diff);
 }
 
 
@@ -444,3 +461,174 @@ void Cus428State::MmcReset()
 	LocateSend();
 }
 
+Cus428StateMixxx::Cus428StateMixxx(struct us428ctls_sharedmem* Pus428ctls_sharedmem):Cus428State(Pus428ctls_sharedmem)
+{
+  focus = 0;
+  eq = 0;
+  LightSet(eL_Low, 1);
+  LightSet(eL_LowMid, 0);
+  LightSet(eL_HiMid, 0);
+  LightSet(eL_High, 0);
+  LightSend();
+}
+
+void Cus428StateMixxx::UserKnobChangedTo(eKnobs K, bool V)
+{
+	switch (K) {
+  case eK_BANK_L:
+    if (verbose > 1)
+      printf("Knob BANK_L now %i", V);
+    if (V) LightSet(eL_BankL, !LightIs(eL_BankL));
+    LightSend();
+    Midi.SendMidiNote(0, 51, V ? 127 : 0);
+    break;
+  case eK_BANK_R:
+    if (verbose > 1)
+      printf("Knob BANK_R now %i", V);
+    if (V) LightSet(eL_BankR, !LightIs(eL_BankR));
+    LightSend();
+    Midi.SendMidiNote(1, 51, V ? 127 : 0);
+    break;
+  case eK_REW:
+    if (verbose > 1)
+      printf("Knob REW now %i", V);
+    Midi.SendMidiNote(focus, 60, V ? 127 : 0);
+    break;
+  case eK_FFWD:
+    if (verbose > 1)
+      printf("Knob FFWD now %i", V);
+    Midi.SendMidiNote(focus, 61, V ? 127 : 0);
+    break;
+  case eK_STOP:
+    if (verbose > 1)
+      printf("Knob STOP now %i\n", V);
+    Midi.SendMidiNote(focus, 62, V ? 127 : 0);
+    break;
+  case eK_PLAY:
+    if (verbose > 1)
+      printf("Knob PLAY now %i", V);
+    Midi.SendMidiNote(focus, 63, V ? 127 : 0);
+    break;
+  case eK_RECORD:
+    if (verbose > 1)
+      printf("Knob RECORD now %i", V);
+    Midi.SendMidiNote(focus, 64, V ? 127 : 0);
+    break;
+  case eK_LOW:
+    if (verbose > 1)
+      printf("Knob LOW now %i", V);
+    if (V)
+      {
+        eq = 0;
+        LightSet(eL_Low, 1);
+        LightSet(eL_LowMid, 0);
+        LightSet(eL_HiMid, 0);
+        LightSet(eL_High, 0);
+        LightSend();
+      }
+    break;
+  case eK_LOWMID:
+    if (verbose > 1)
+      printf("Knob LOWMID now %i", V);
+    if (V)
+      {
+        eq = 1;
+        LightSet(eL_Low, 0);
+        LightSet(eL_LowMid, 1);
+        LightSet(eL_HiMid, 0);
+        LightSet(eL_High, 0);
+        LightSend();
+      }
+    break;
+  case eK_HIMID:
+    if (verbose > 1)
+      printf("Knob HIMID now %i", V);
+    if (V)
+      {
+        eq = 2;
+        LightSet(eL_Low, 0);
+        LightSet(eL_LowMid, 0);
+        LightSet(eL_HiMid, 1);
+        LightSet(eL_High, 0);
+        LightSend();
+      }
+    break;
+  case eK_HIGH:
+    if (verbose > 1)
+      printf("Knob HIGH now %i", V);
+    if (V)
+      {
+        eq = 3;
+        LightSet(eL_Low, 0);
+        LightSet(eL_LowMid, 0);
+        LightSet(eL_HiMid, 0);
+        LightSet(eL_High, 1);
+        LightSend();
+      }
+    break;
+  case eK_SET:
+    if (verbose > 1)
+      printf("Knob SET now %i", V);
+    Midi.SendMidiNote(focus, 65, V ? 127 : 0);
+    break;
+  case eK_LOCATE_L:
+    if (verbose > 1)
+      printf("Knob LOCATE_L now %i", V);
+    if (V) {
+      focus = 0;
+    }
+    break;
+  case eK_LOCATE_R:
+    if (verbose > 1)
+      printf("Knob LOCATE_R now %i", V);
+    if (V) {
+      focus = 1;
+    }
+    break;
+  default:
+    if (verbose > 1)
+      printf("Knob %i now %i\n", K, V);
+    Midi.SendMidiNote(0, K, V);
+  }
+}
+
+void Cus428StateMixxx::UserSliderChangedTo(int S, unsigned char New)
+{
+  //  if (verbose > 1)
+  //  printf("Slider : %d - %d - %d\n", S, New, ((unsigned char*)us428_ctls)[S]);
+	Midi.SendMidiControl(0, 0x40 + S, ((unsigned char*)us428_ctls)[S] / 2);
+}
+
+void Cus428StateMixxx::UserWheelChangedTo(E_In84 W, char Diff)
+{
+	char Param;
+  char Value;
+  char Channel;
+  //if (verbose > 1)
+  //  printf("Slider : %d - %d - %d\n", W, Diff, ((unsigned char *) us428_ctls)[W]);
+
+  Channel = 0;
+	switch (W) {
+	case eWheelGain:
+		Param = 0x48 + eq * 4;
+		break;
+	case eWheelFreq:
+		Param = 0x49 + eq * 4;
+		break;
+	case eWheelQ:
+		Param = 0x4A + eq * 4;
+		break;
+	case eWheelPan:
+		Param = 0x4B + eq * 4;
+		break;
+	case eWheel:
+		Param = 0x60;
+    Channel = focus;
+		// Update the absolute wheel position.
+		//WheelDelta((int) ((unsigned char *) us428_ctls)[W]);
+		break;
+	}
+  Value = 64 + Diff;
+	Midi.SendMidiControl(Channel, Param, Value);
+  //	Midi.SendMidiControl(0, Param, ((unsigned char *) us428_ctls)[W]);
+}
diff -r 7f7a0bf510a4 us428control/Cus428State.h
--- a/us428control/Cus428State.h	Tue Sep 12 15:35:53 2006 +0200
+++ b/us428control/Cus428State.h	Sat Sep 30 18:05:42 2006 +0200
@@ -84,10 +84,15 @@ class Cus428State: public us428_lights{
 		eK_F3,
 	};
 	void InitDevice(void);
+
 	void KnobChangedTo(eKnobs K, bool V);
 	void SliderChangedTo(int S, unsigned char New);
+	void WheelChangedTo(E_In84 W, char Diff);
+	virtual void UserSliderChangedTo(int S, unsigned char New);
+	virtual void UserWheelChangedTo(E_In84 W, char Diff);
+  virtual void UserKnobChangedTo(eKnobs K, bool V);
+
 	void SliderSend(int S);
-	void WheelChangedTo(E_In84 W, char Diff);
 	Cus428_ctls *Set_us428_ctls(Cus428_ctls *New) {
 		Cus428_ctls *Old = us428_ctls;
 		us428_ctls = New;
@@ -104,7 +109,7 @@ class Cus428State: public us428_lights{
 	void TransportSend();
 	// Reset internal MMC state.
 	void MmcReset();
- private:
+ protected:
 	void SendVolume(usX2Y_volume &V);
 	struct us428ctls_sharedmem* us428ctls_sharedmem;
 	bool StateInputMonitor() {
@@ -140,6 +145,18 @@ class Cus428State: public us428_lights{
 	int aWheelSpeed;
 };
 
+
+class Cus428StateMixxx: public Cus428State{
+public:
+  Cus428StateMixxx(struct us428ctls_sharedmem* Pus428ctls_sharedmem);
+  void UserKnobChangedTo(eKnobs K, bool V);
+	void UserSliderChangedTo(int S, unsigned char New);
+	void UserWheelChangedTo(E_In84 W, char Diff);
+protected:
+  int focus;
+  int eq;
+};
+
 extern Cus428State* OneState;
 
 #endif
diff -r 7f7a0bf510a4 us428control/us428control.cc
--- a/us428control/us428control.cc	Tue Sep 12 15:35:53 2006 +0200
+++ b/us428control/us428control.cc	Sat Sep 30 18:05:42 2006 +0200
@@ -61,7 +61,8 @@ static void usage(void)
 {
 	printf("Tascam US-428 Control\n");
 	printf("version %s\n", VERSION);
-	printf("usage: "PROGNAME" [-v verbosity_level 0..2] [-c card] [-D device] [-u usb-device]\n");
+	printf("usage: "PROGNAME" [-v verbosity_level 0..2] [-c card] [-D device] [-u usb-device] [-m mode]\n");
+  printf("mode is one of (native, mixxx)\n");
 }
 /*
  * check the name id of the given hwdep handle
@@ -76,14 +77,14 @@ static int check_hwinfo(snd_hwdep_t *hw,
 		return err;
 	if (strcmp(snd_hwdep_info_get_id(info), id))
 		return -ENODEV;
-	if (usb_dev_name) 
+	if (usb_dev_name)
 		if (strcmp(snd_hwdep_info_get_name(info), usb_dev_name))
 			return -ENODEV;
 
 	return 0; /* ok */
 }
 
-int US428Control(const char* DevName)
+int US428Control(const char* DevName, int mode)
 {
 	snd_hwdep_t		*hw;
 	int			err;
@@ -117,7 +118,11 @@ int US428Control(const char* DevName)
 		return -ENOMEM;
 	}
 	us428ctls_sharedmem->CtlSnapShotRed = us428ctls_sharedmem->CtlSnapShotLast;
-	OneState = new Cus428State(us428ctls_sharedmem);
+  if (mode == 1)
+    OneState = new Cus428StateMixxx(us428ctls_sharedmem);
+  else
+    OneState = new Cus428State(us428ctls_sharedmem);
+
 	OneState->InitDevice();
 
 	while ((pollrc = poll(pfds, npfd, 60000)) >= 0) {
@@ -152,12 +157,13 @@ int main (int argc, char *argv[])
 int main (int argc, char *argv[])
 {
 	int c;
+  int mode = 0;
 	int card = -1;
 	char	*device_name = NULL,
 		*usb_device_name = getenv("DEVICE");
 	char name[64];
 
-	while ((c = getopt(argc, argv, "c:D:u:v:")) != -1) {
+	while ((c = getopt(argc, argv, "c:D:u:v:m:")) != -1) {
 		switch (c) {
 		case 'c':
 			card = atoi(optarg);
@@ -171,6 +177,10 @@ int main (int argc, char *argv[])
 		case 'v':
 			verbose = atoi(optarg);
 			break;
+    case 'm':
+      if (!strcmp(optarg, "mixxx"))
+        mode = 1;
+      break;
 		default:
 			usage();
 			return 1;
@@ -190,18 +200,18 @@ int main (int argc, char *argv[])
 		}
 	}
 	if (device_name) {
-		return US428Control(device_name) != 0;
+		return US428Control(device_name, mode) != 0;
 	}
 	if (card >= 0) {
 		sprintf(name, "hw:%d", card);
-		return US428Control(name) != 0;
+		return US428Control(name, mode) != 0;
 	}
 
 	/* probe the all cards */
 	for (c = 0; c < SND_CARDS; c++) {
 	//	verbose--;
 		sprintf(name, "hw:%d", c);
-		if (! US428Control(name))
+		if (!US428Control(name, mode))
 			card = c;
 	}
 	if (card < 0) {
diff -r 7f7a0bf510a4 us428control/usbus428ctldefs.h
--- a/us428control/usbus428ctldefs.h	Tue Sep 12 15:35:53 2006 +0200
+++ b/us428control/usbus428ctldefs.h	Sat Sep 30 18:05:42 2006 +0200
@@ -64,7 +64,7 @@ struct us428_ctls{
 	unsigned char 	Select;
 	unsigned char   Mute;
 	unsigned char   UNKNOWN;
-	unsigned char   Switch;	     
+	unsigned char   Switch;
 	unsigned char   Wheel[5];
 };
 
@@ -119,7 +119,7 @@ typedef struct usX2Y_volume {
 		if (Grob) {
 			static int GrobVals[] = {-128, -64, 0, 64, 127};
 			int i = 4;
-			while (i >= 0 && GrobVals[i] > Pan) 
+			while (i >= 0 && GrobVals[i] > Pan)
 				i--;
 			if (GrobVals[i] != Pan  &&  RawValue < 0)
 				i++;
@@ -158,7 +158,12 @@ struct us428_lights{
 		eL_FFwd = 29,
 		eL_Play = 30,
 		eL_Record = 31,
-		eL_Null
+    eL_AnalogDigital = 32,
+		eL_Null = 34,
+    eL_Low = 36,
+    eL_LowMid = 37,
+    eL_HiMid = 38,
+    eL_High = 39
 	};
 	bool LightIs(int L){
 		return Light[L / 8].Value & (1 << (L % 8));

--------------030901020401060602090403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030901020401060602090403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------030901020401060602090403--
