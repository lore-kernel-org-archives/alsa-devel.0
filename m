From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]us428control.patch.0.3
Date: Thu, 23 Oct 2003 19:30:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310231930.35795.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7ABm/TEikjOzMho"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_7ABm/TEikjOzMho
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

This has more features:
- PCM-Volume adjusted to MasteVolumeSlider setting at device start.
- Direct Monitoring Functions adjustable directly on the US428
- Alsa Sequencer Output port for applications to receive the US428 sliders 
etc.

please add the missing files attached + commit the patch.

Danke,
Karsten

--Boundary-00=_7ABm/TEikjOzMho
Content-Type: text/x-diff;
  charset="us-ascii";
  name="us428control.patch.0.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="us428control.patch.0.3"

Index: alsa-tools/us428control/Cus428State.cc
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428State.cc,v
retrieving revision 1.1
diff -u -r1.1 Cus428State.cc
--- alsa-tools/us428control/Cus428State.cc	6 Oct 2003 15:57:24 -0000	1.1
+++ alsa-tools/us428control/Cus428State.cc	23 Oct 2003 17:01:45 -0000
@@ -20,12 +20,14 @@
 
 #include <stdio.h>
 #include <string.h>
-#include "Cus428State.h"
+#include <alsa/asoundlib.h>
+#include "Cus428Midi.h"
 
 extern int verbose;
 
-void
-us428_lights::init_us428_lights()
+
+
+void us428_lights::init_us428_lights()
 {
 	int i = 0;
 	memset(this, 0, sizeof(*this));
@@ -33,8 +35,14 @@
 		Light[ i].Offset = i + 0x19;
 }
 
-int 
-Cus428State::LightSend()
+
+void Cus428State::InitDevice(void)
+{
+	SliderChangedTo(eFaderM, ((unsigned char*)(us428ctls_sharedmem->CtlSnapShot + us428ctls_sharedmem->CtlSnapShotLast))[eFaderM]);
+}
+
+
+int Cus428State::LightSend()
 {
 	int Next = us428ctls_sharedmem->p4outLast + 1;
 	if(Next < 0  ||  Next >= N_us428_p4out_BUFS)
@@ -44,14 +52,8 @@
 	return us428ctls_sharedmem->p4outLast = Next;
 }
 
-void 
-Cus428State::SliderChangedTo(int S, unsigned char New)
+void Cus428State::SendVolume(usX2Y_volume &V)
 {
-	if ((S >= eFader4 || S < 0) && S != eFaderM)
-		return;
-
-	usX2Y_volume V;
-	V.SetTo(S, New);
 	int Next = us428ctls_sharedmem->p4outLast + 1;
 	if (Next < 0  ||  Next >= N_us428_p4out_BUFS)
 		Next = 0;
@@ -60,24 +62,107 @@
 	us428ctls_sharedmem->p4outLast = Next;
 }
 
+void Cus428State::SliderChangedTo(int S, unsigned char New)
+{
+	if (StateInputMonitor() && S <= eFader3
+	    || S == eFaderM) {
+		usX2Y_volume &V = Volume[S >= eFader4 ? eFader4 : S];
+		V.SetTo(S, New);
+		if (S == eFaderM || !LightIs(eL_Mute0 + S))
+			SendVolume(V);
+	} else
+		Midi.SendMidiControl(0x40 + S, ((unsigned char*)us428_ctls)[S] / 2);
+
+}
 
-void 
-Cus428State::KnobChangedTo(eKnobs K, bool V)
+
+void Cus428State::KnobChangedTo(eKnobs K, bool V)
 {
-	switch (K) {  
-	case eK_InputMonitor:
-		if (verbose > 1)
-			printf("Knob InputMonitor now %i", V);
+	switch (K & ~(StateInputMonitor() ? 3 : -1)) {
+	case eK_Select0:
 		if (V) {
-			LightSet(eL_InputMonitor, ! LightIs(eL_InputMonitor));
+			int S = eL_Select0 + (K & 7);
+			Light[eL_Select0 / 8].Value = 0;
+			LightSet(S, !LightIs(S));
 			LightSend();
 		}
-		if (verbose > 1)
-			printf(" Light is %i\n", LightIs(eL_InputMonitor));
+		break;
+	case eK_Mute0:
+		if (V) {
+			int M = eL_Mute0 + (K & 7);
+			LightSet(M, !LightIs(M));
+			LightSend();
+			if (StateInputMonitor()) {
+				usX2Y_volume V = Volume[M - eL_Mute0];
+				if (LightIs(M))
+					V.LH = V.LL = V.RL = V.RH = 0;
+				SendVolume(V);
+			}
+		}
 		break;
 	default:
-		if (verbose > 1)
-			printf("Knob %i now %i\n", K, V);
+		switch (K) {
+		case eK_InputMonitor:
+			if (verbose > 1)
+				printf("Knob InputMonitor now %i", V);
+			if (V) {
+				if (StateInputMonitor()) {
+					SelectInputMonitor = Light[0].Value;
+					MuteInputMonitor = Light[2].Value;
+				} else {
+					Select = Light[0].Value;
+					Mute = Light[2].Value;
+				}
+				LightSet(eL_InputMonitor, ! StateInputMonitor());
+				Light[0].Value = StateInputMonitor() ? SelectInputMonitor : Select;
+				Light[2].Value = StateInputMonitor() ? MuteInputMonitor : Mute;
+				LightSend();
+			}
+			if (verbose > 1)
+				printf(" Light is %i\n", LightIs(eL_InputMonitor));
+			break;
+		default:
+			if (verbose > 1)
+				printf("Knob %i now %i\n", K, V);
+			Midi.SendMidiControl(K, V);
+		}
 	}
 }
 
+
+void Cus428State::WheelChangedTo(E_In84 W, char Diff)
+{
+	char Param;
+	switch (W) {
+	case eWheelPan:
+		if (StateInputMonitor() && Light[0].Value) {
+			int index = 0;
+
+			while( index < 4 && (1 << index) !=  Light[0].Value)
+				index++;
+
+			if (index >= 4)
+				return;
+
+			Volume[index].PanTo(Diff, us428_ctls->Knob(eK_SET));
+			if (!LightIs(eL_Mute0 + index))
+				SendVolume(Volume[index]);
+			return;
+		}
+		Param = 0x4D;
+		break;
+	case eWheelGain:
+		Param = 0x48;
+		break;
+	case eWheelFreq:
+		Param = 0x49;
+		break;
+	case eWheelQ:
+		Param = 0x4A;
+		break;
+	case eWheel:
+		Param = 0x60;
+		break;
+	}
+	Midi.SendMidiControl(Param, ((unsigned char*)us428_ctls)[W]);
+}
Index: alsa-tools/us428control/Cus428State.h
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428State.h,v
retrieving revision 1.1
diff -u -r1.1 Cus428State.h
--- alsa-tools/us428control/Cus428State.h	6 Oct 2003 15:57:24 -0000	1.1
+++ alsa-tools/us428control/Cus428State.h	23 Oct 2003 17:01:45 -0000
@@ -23,24 +23,79 @@
 
 #include "Cus428_ctls.h"
 
-class Cus428State: public us428_lights, public Cus428_ctls{
+class Cus428State: public us428_lights{
  public:
 	Cus428State(struct us428ctls_sharedmem* Pus428ctls_sharedmem)
 		:us428ctls_sharedmem(Pus428ctls_sharedmem)
+		,MuteInputMonitor(0)
+		,Mute(0)
+		,us428_ctls(0)
 		{
 			init_us428_lights();
+			for (int v = 0; v < 5; ++v) {
+				Volume[v].init(v);
+			}
 		}
 	enum eKnobs{
-		eK_RECORD = 72,
-		eK_PLAY = 73,
+		eK_RECORD =	72,
+		eK_PLAY,
 		eK_STOP,
-		eK_InputMonitor = 80
+		eK_FFWD,
+		eK_REW,
+		eK_SOLO,
+		eK_REC,
+		eK_NULL,
+		eK_InputMonitor,	// = 80
+		eK_BANK_L,
+		eK_BANK_R,
+		eK_LOCATE_L,
+		eK_LOCATE_R,
+		eK_SET =	85,
+		eK_INPUTCD =	87,
+		eK_HIGH =	90,
+		eK_HIMID,
+		eK_LOWMID,
+		eK_LOW,
+		eK_Select0 =	96,
+		eK_Mute0 =	104,
+		eK_Mute1,
+		eK_Mute2,
+		eK_Mute3,
+		eK_Mute4,
+		eK_Mute5,
+		eK_Mute6,
+		eK_Mute7,
+		eK_AUX1 =	120,
+		eK_AUX2,
+		eK_AUX3,
+		eK_AUX4,
+		eK_ASGN,
+		eK_F1,
+		eK_F2,
+		eK_F3,
 	};
+	void InitDevice(void);
 	void KnobChangedTo(eKnobs K, bool V);
 	void SliderChangedTo(int S, unsigned char New);
+	void WheelChangedTo(E_In84 W, char Diff);
+	Cus428_ctls *Set_us428_ctls(Cus428_ctls *New) {
+		Cus428_ctls *Old = us428_ctls;
+		us428_ctls = New;
+		return Old;
+	}
  private:
 	int LightSend();
+	void SendVolume(usX2Y_volume &V);
 	struct us428ctls_sharedmem* us428ctls_sharedmem;
+	bool   StateInputMonitor() {
+		return  LightIs(eL_InputMonitor);
+	}
+	usX2Y_volume_t	Volume[5];
+	char		MuteInputMonitor,
+			Mute,
+			SelectInputMonitor,
+			Select;
+	Cus428_ctls	*us428_ctls;
 };
 
 extern Cus428State* OneState;
Index: alsa-tools/us428control/Cus428_ctls.cc
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428_ctls.cc,v
retrieving revision 1.1
diff -u -r1.1 Cus428_ctls.cc
--- alsa-tools/us428control/Cus428_ctls.cc	6 Oct 2003 15:57:24 -0000	1.1
+++ alsa-tools/us428control/Cus428_ctls.cc	23 Oct 2003 17:01:45 -0000
@@ -31,27 +31,31 @@
 	for (int m = 0; m < n; m++)
 		printf("   ");
 	for (; n < sizeof(*this); n++)
-		printf("%02hhX ", ((char*)this)[ n]);
+		printf("%02hhX ", ((char*)this)[n]);
 	printf("\n");
 }
 
 void 
 Cus428_ctls::analyse(Cus428_ctls& Previous, unsigned n)
 {
-	for (; n < 9; n++) {		//Sliders
-		char Diff = ((unsigned char*)this)[ n] - ((unsigned char*)&Previous)[ n];
+	OneState->Set_us428_ctls(this);
+	for (; n < 9; n++) {			//Sliders
+		char Diff = ((unsigned char*)this)[n] - ((unsigned char*)&Previous)[n];
 		if (Diff)
-			OneState->SliderChangedTo(n, ((unsigned char*)this)[ n]);		
+			OneState->SliderChangedTo(n, ((unsigned char*)this)[n]);		
 	}
-	for (; n < 16; n++) {		//Knobs
-		unsigned char Diff = ((unsigned char*)this)[ n] ^ ((unsigned char*)&Previous)[ n];
+	for (; n < 16; n++) {			//Knobs
+		unsigned char Diff = ((unsigned char*)this)[n] ^ ((unsigned char*)&Previous)[n];
 		unsigned o = 0;
 		while (o < 8) {
 			if (Diff & (1 << o))
-				OneState->KnobChangedTo((Cus428State::eKnobs)(8*n + o), ((unsigned char*)this)[ n] & (1 << o));
+				OneState->KnobChangedTo((Cus428State::eKnobs)(8*n + o), ((unsigned char*)this)[n] & (1 << o));
 			++o;
 		}
 	}
-	for (; n < sizeof(*this); n++)
-		;			//wheels
+	for (; n < sizeof(*this); n++) {	//wheels
+		char Diff = ((unsigned char*)this)[ n] - ((unsigned char*)&Previous)[n];
+		if (Diff)
+			OneState->WheelChangedTo((E_In84)n, Diff);				
+	}	
 }
Index: alsa-tools/us428control/Cus428_ctls.h
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428_ctls.h,v
retrieving revision 1.1
diff -u -r1.1 Cus428_ctls.h
--- alsa-tools/us428control/Cus428_ctls.h	6 Oct 2003 15:57:24 -0000	1.1
+++ alsa-tools/us428control/Cus428_ctls.h	23 Oct 2003 17:01:46 -0000
@@ -27,6 +27,9 @@
  public:
 	void dump(int n = 0);
 	void analyse(Cus428_ctls& Previous, unsigned n = 0);
+	bool Knob( int K) {
+		return ((char*)this)[K / 8] & (1 << K % 8);
+	}
 };
 
 #endif
Index: alsa-tools/us428control/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Makefile.am,v
retrieving revision 1.1
diff -u -r1.1 Makefile.am
--- alsa-tools/us428control/Makefile.am	6 Oct 2003 15:57:24 -0000	1.1
+++ alsa-tools/us428control/Makefile.am	23 Oct 2003 17:01:46 -0000
@@ -3,8 +3,7 @@
 
 bin_PROGRAMS = us428control
 
-us428control_SOURCES = us428control.cc Cus428State.cc Cus428_ctls.cc
-us428control_HEADERS = Cus428State.h Cus428_ctls.h usbus428ctldefs.h
+us428control_SOURCES = us428control.cc Cus428State.cc Cus428_ctls.cc Cus428Midi.cc
 
 EXTRA_DIST = depcomp
 
Index: alsa-tools/us428control/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/configure.in,v
retrieving revision 1.1
diff -u -r1.1 configure.in
--- alsa-tools/us428control/configure.in	6 Oct 2003 15:57:24 -0000	1.1
+++ alsa-tools/us428control/configure.in	23 Oct 2003 17:01:46 -0000
@@ -1,5 +1,5 @@
 AC_INIT(us428control.cc)
-AM_INIT_AUTOMAKE(us428control, 0.1)
+AM_INIT_AUTOMAKE(us428control, 0.3)
 AC_PROG_CXX
 AC_PROG_INSTALL
 AC_HEADER_STDC
Index: alsa-tools/us428control/us428control.cc
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/us428control.cc,v
retrieving revision 1.1
diff -u -r1.1 us428control.cc
--- alsa-tools/us428control/us428control.cc	6 Oct 2003 15:57:24 -0000	1.1
+++ alsa-tools/us428control/us428control.cc	23 Oct 2003 17:01:46 -0000
@@ -31,6 +31,7 @@
 #include <alsa/asoundlib.h>
 #include "Cus428_ctls.h"
 #include "Cus428State.h"
+#include "Cus428Midi.h"
 
 
 #define PROGNAME		"us428control"
@@ -41,6 +42,8 @@
 
 int verbose = 1;
 
+Cus428Midi Midi;
+
 
 static void error(const char *fmt, ...)
 {
@@ -56,7 +59,7 @@
 
 static void usage(void)
 {
-	printf("Tascam US-428 Contol\n");
+	printf("Tascam US-428 Control\n");
 	printf("version %s\n", VERSION);
 	printf("usage: "PROGNAME" [-v verbosity_level 0..2] [-c card] [-D device] [-u usb-device]\n");
 }
@@ -104,8 +107,10 @@
 		perror("mmap failed:");
 		return -ENOMEM;
 	}
+	Midi.CreatePorts();
 	us428ctls_sharedmem->CtlSnapShotRed = us428ctls_sharedmem->CtlSnapShotLast;
 	OneState = new Cus428State(us428ctls_sharedmem);
+	OneState->InitDevice();
 	while (1) {
 		int x = poll(&pfds,1,-1);
 		if (verbose > 1 || pfds.revents & (POLLERR|POLLHUP))
Index: alsa-tools/us428control/usbus428ctldefs.h
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/usbus428ctldefs.h,v
retrieving revision 1.1
diff -u -r1.1 usbus428ctldefs.h
--- alsa-tools/us428control/usbus428ctldefs.h	6 Oct 2003 15:57:24 -0000	1.1
+++ alsa-tools/us428control/usbus428ctldefs.h	23 Oct 2003 17:01:46 -0000
@@ -17,7 +17,12 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-enum E_In84{
+#ifdef __cplusplus
+#include <string.h>
+extern int verbose;
+#endif
+
+enum E_In84 {
 	eFader0 = 0,
 	eFader1,
 	eFader2,
@@ -76,18 +81,63 @@
 };
 
 typedef struct usX2Y_volume {
-	unsigned char Channel,
-		LH,
-		LL,
-		RH,
-		RL;
+	unsigned char	Channel,
+			LH,
+			LL,
+			RH,
+			RL;
+	unsigned char	Slider;
+	char		Pan,
+			Mute;
 #ifdef __cplusplus
 	public:
+	void init(unsigned char _Channel) {
+		memset(this, 0, sizeof(*this));
+		Channel = _Channel;
+	}
 	int Scale(){return 0x40;}
+
+	void calculate() {
+		int lPan = (int)Pan * Slider / 0x80;
+		int ValL = (Slider - lPan) * Scale();
+		LH = ValL >> 8;
+		LL = ValL;
+		int ValR = (Slider + lPan) * Scale();
+		RH = ValR >> 8;
+		RL = ValR;
+		if (2 < verbose)
+			printf("S=% 3i, P=% 3i, lP=% 3i, VL=%05i, VR=%05i\n", (int)Slider, (int)Pan, (int)lPan, ValL, ValR);
+	}
+
 	void SetTo(unsigned char _Channel, int RawValue){
+		Slider = RawValue;
 		Channel = eFaderM == _Channel ? 4 : _Channel;
-		LH = RH = (RawValue *= Scale()) >> 8;
-		LL = RL = RawValue;
+		calculate();
+	}
+	void PanTo(int RawValue, bool Grob) {
+		int NewPan;
+		if (Grob) {
+			static int GrobVals[] = {-128, -64, 0, 64, 127};
+			int i = 4;
+			while (i >= 0 && GrobVals[i] > Pan) 
+				i--;
+			if (GrobVals[i] != Pan  &&  RawValue < 0)
+				i++;
+
+			if (i >= 0) {
+				if ((i += RawValue) >= 0  &&  i < 5)
+					NewPan = GrobVals[i];
+				else
+					return;
+			}
+
+		} else {
+			NewPan = Pan + RawValue;
+		}
+		if (NewPan < -128  ||  NewPan > 127)
+			return;
+		Pan = NewPan;
+		calculate();
 	}
 #endif
 } usX2Y_volume_t;
@@ -97,16 +147,18 @@
 #ifdef __cplusplus
 	public:
 	enum eLight{
+		eL_Select0 = 0,
+		eL_Mute0 = 16,
 		eL_InputMonitor = 25
 	};
-	bool LightIs(eLight L){
+	bool LightIs(int L){
 		return Light[L / 8].Value & (1 << (L % 8));
 	}
-	void LightSet(eLight L, bool Value){
+	void LightSet(int L, bool Value){
 		if (Value)
 			Light[L / 8].Value |= (1 << (L % 8));
 		else
-			Light[L / 8].Value &= (~1 << (L % 8));
+			Light[L / 8].Value &= ~(1 << (L % 8));
 	}
 	void init_us428_lights();
 #endif

--Boundary-00=_7ABm/TEikjOzMho
Content-Type: text/x-c++src;
  charset="us-ascii";
  name="Cus428Midi.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Cus428Midi.cc"

#include <alsa/asoundlib.h>
#include "Cus428Midi.h"


char Cus428Midi::KnobParam[] = {
	0x17,
	0x16,
	0x15,
	0x14,
	0x13,
	0x2A,
	0x29,
	0x28,
	-1,
	0x10,
	0x11,
	0x18,
	0x19,
	0x1A,
	-1,
	-1,
	-1,
	-1,
	0x2C,
	0x2D,
	0x2E,
	0x2F,
	-1,
	-1,
	0x20,
	0x21,
	0x22,
	0x23,
	0x24,
	0x25,
	0x26,
	0x27,
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	0x30,
	0x31,
	0x32,
	0x33,
	0x34,
	0x35,
	0x36,
	0x37,
	};

--Boundary-00=_7ABm/TEikjOzMho
Content-Type: text/x-chdr;
  charset="us-ascii";
  name="Cus428Midi.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Cus428Midi.h"

#include <sound/asequencer.h>
#include "Cus428State.h"

class Cus428Midi {
 public:
	Cus428Midi():
		Seq(0){}

	int CreatePorts(){
		int Err;
		if (0 <= (Err = snd_seq_open(&Seq, "default", SND_SEQ_OPEN_DUPLEX, SND_SEQ_NONBLOCK))) {
			snd_seq_set_client_name(Seq, "US-428");
			Err = snd_seq_create_simple_port(Seq, "Controls",
							 SNDRV_SEQ_PORT_CAP_READ
							 //|SNDRV_SEQ_PORT_CAP_WRITE	FIXME: Next Step is to make Lights switchable
							 |SNDRV_SEQ_PORT_CAP_SUBS_READ
							 /*|SNDRV_SEQ_PORT_CAP_SUBS_WRITE*/,
							 SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC);
			if (Err >= 0) {
				Port = Err;
				snd_seq_ev_clear(&Ev);
				snd_seq_ev_set_direct(&Ev);
				snd_seq_ev_set_source(&Ev, Port);
				snd_seq_ev_set_subs(&Ev);
			}
		}
		return Err;
	}

	int SendMidiControl(char Param, char Val){
		snd_seq_ev_set_controller(&Ev, 15, Param, Val & 0x7F);
		SubMitEvent();
		return 0;
	} 

	int SendMidiControl(Cus428State::eKnobs K, bool Down){
		return SendMidiControl(KnobParam[K - Cus428State::eK_RECORD], Down ? 0x7F : 0);
	}

 private:
	snd_seq_t *Seq;
	int Port;
	snd_seq_event_t Ev;
	int SubMitEvent(){
		snd_seq_event_output(Seq, &Ev);
		snd_seq_drain_output(Seq);
		return 0;
	}
	static char KnobParam[];
};

extern Cus428Midi Midi;

--Boundary-00=_7ABm/TEikjOzMho--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
