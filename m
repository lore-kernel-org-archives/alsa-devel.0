From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]us428control.patch.0.4.1
Date: Tue, 2 Dec 2003 19:01:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312021901.33642.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9NNz/wP89Q5hqTk"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_9NNz/wP89Q5hqTk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

Two Segmentation fault spots cleared.

Please commit. Thanks,
Karsten

--Boundary-00=_9NNz/wP89Q5hqTk
Content-Type: text/x-diff;
  charset="us-ascii";
  name="us428control.patch.0.4.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="us428control.patch.0.4.1"

Index: alsa-tools/us428control/Cus428State.cc
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428State.cc,v
retrieving revision 1.2
diff -u -r1.2 Cus428State.cc
--- alsa-tools/us428control/Cus428State.cc	24 Oct 2003 14:01:45 -0000	1.2
+++ alsa-tools/us428control/Cus428State.cc	2 Dec 2003 17:41:06 -0000
@@ -38,7 +38,8 @@
 
 void Cus428State::InitDevice(void)
 {
-	SliderChangedTo(eFaderM, ((unsigned char*)(us428ctls_sharedmem->CtlSnapShot + us428ctls_sharedmem->CtlSnapShotLast))[eFaderM]);
+	if (us428ctls_sharedmem->CtlSnapShotLast >= 0)
+		SliderChangedTo(eFaderM, ((unsigned char*)(us428ctls_sharedmem->CtlSnapShot + us428ctls_sharedmem->CtlSnapShotLast))[eFaderM]);
 }
 
 
Index: alsa-tools/us428control/Cus428_ctls.cc
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428_ctls.cc,v
retrieving revision 1.2
diff -u -r1.2 Cus428_ctls.cc
--- alsa-tools/us428control/Cus428_ctls.cc	24 Oct 2003 14:01:45 -0000	1.2
+++ alsa-tools/us428control/Cus428_ctls.cc	2 Dec 2003 17:41:06 -0000
@@ -36,26 +36,29 @@
 }
 
 void 
-Cus428_ctls::analyse(Cus428_ctls& Previous, unsigned n)
+Cus428_ctls::analyse(Cus428_ctls *Previous, unsigned n)
 {
+	Cus428_ctls *PreviousL = Previous ? Previous : new Cus428_ctls();
 	OneState->Set_us428_ctls(this);
 	for (; n < 9; n++) {			//Sliders
-		char Diff = ((unsigned char*)this)[n] - ((unsigned char*)&Previous)[n];
+		char Diff = DiffValAt(PreviousL, n);
 		if (Diff)
-			OneState->SliderChangedTo(n, ((unsigned char*)this)[n]);		
+			OneState->SliderChangedTo(n, ValAt(n));		
 	}
 	for (; n < 16; n++) {			//Knobs
-		unsigned char Diff = ((unsigned char*)this)[n] ^ ((unsigned char*)&Previous)[n];
+		unsigned char Diff = DiffBitAt(PreviousL, n);
 		unsigned o = 0;
 		while (o < 8) {
 			if (Diff & (1 << o))
-				OneState->KnobChangedTo((Cus428State::eKnobs)(8*n + o), ((unsigned char*)this)[n] & (1 << o));
+				OneState->KnobChangedTo((Cus428State::eKnobs)(8*n + o), ValAt(n) & (1 << o));
 			++o;
 		}
 	}
 	for (; n < sizeof(*this); n++) {	//wheels
-		char Diff = ((unsigned char*)this)[ n] - ((unsigned char*)&Previous)[n];
+		char Diff = DiffValAt(PreviousL, n);
 		if (Diff)
 			OneState->WheelChangedTo((E_In84)n, Diff);				
-	}	
+	}
+	if (0 == Previous)
+		delete PreviousL;
 }
Index: alsa-tools/us428control/Cus428_ctls.h
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428_ctls.h,v
retrieving revision 1.2
diff -u -r1.2 Cus428_ctls.h
--- alsa-tools/us428control/Cus428_ctls.h	24 Oct 2003 14:01:45 -0000	1.2
+++ alsa-tools/us428control/Cus428_ctls.h	2 Dec 2003 17:41:06 -0000
@@ -25,10 +25,23 @@
 
 class Cus428_ctls: public us428_ctls{
  public:
+	Cus428_ctls() {
+		memset(this, 0, sizeof(*this));
+	}
 	void dump(int n = 0);
-	void analyse(Cus428_ctls& Previous, unsigned n = 0);
+	void analyse(Cus428_ctls *Previous, unsigned n = 0);
 	bool Knob( int K) {
 		return ((char*)this)[K / 8] & (1 << K % 8);
+	}
+ protected:
+	unsigned char ValAt(int i) {
+		return ((unsigned char*)this)[i];
+	}
+	unsigned char DiffValAt(Cus428_ctls *Other, int i) {
+		return ValAt(i) - Other->ValAt(i);
+	}
+	unsigned char DiffBitAt(Cus428_ctls *Other, int i) {
+		return ValAt(i) ^ Other->ValAt(i);
 	}
 };
 
Index: alsa-tools/us428control/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/configure.in,v
retrieving revision 1.4
diff -u -r1.4 configure.in
--- alsa-tools/us428control/configure.in	25 Nov 2003 17:14:03 -0000	1.4
+++ alsa-tools/us428control/configure.in	2 Dec 2003 17:41:06 -0000
@@ -1,5 +1,5 @@
 AC_INIT(us428control.cc)
-AM_INIT_AUTOMAKE(us428control, 0.4)
+AM_INIT_AUTOMAKE(us428control, 0.4.1)
 AC_PROG_CXX
 AC_PROG_INSTALL
 AC_HEADER_STDC
Index: alsa-tools/us428control/us428control.cc
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/us428control.cc,v
retrieving revision 1.2
diff -u -r1.2 us428control.cc
--- alsa-tools/us428control/us428control.cc	24 Oct 2003 14:01:45 -0000	1.2
+++ alsa-tools/us428control/us428control.cc	2 Dec 2003 17:41:06 -0000
@@ -121,14 +121,16 @@
 		if (verbose > 1)
 			printf("Last is %i\n", Last);
 		while (us428ctls_sharedmem->CtlSnapShotRed != Last) {
+			static Cus428_ctls *Red = 0;
 			int Read = us428ctls_sharedmem->CtlSnapShotRed + 1;
-			if (Read >= N_us428_ctl_BUFS)
+			if (Read >= N_us428_ctl_BUFS || Read < 0)
 				Read = 0;
 			Cus428_ctls* PCtlSnapShot = ((Cus428_ctls*)(us428ctls_sharedmem->CtlSnapShot)) + Read;
 			int DiffAt = us428ctls_sharedmem->CtlSnapShotDiffersAt[Read];
 			if (verbose > 1)
 				PCtlSnapShot->dump(DiffAt);
-			PCtlSnapShot->analyse(((Cus428_ctls*)(us428ctls_sharedmem->CtlSnapShot))[us428ctls_sharedmem->CtlSnapShotRed], DiffAt );
+			PCtlSnapShot->analyse(Red, DiffAt);
+			Red = PCtlSnapShot;
 			us428ctls_sharedmem->CtlSnapShotRed = Read;
 		}
 	}

--Boundary-00=_9NNz/wP89Q5hqTk--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
