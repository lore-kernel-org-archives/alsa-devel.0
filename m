From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: [PATCH] us428control 0.4.5
Date: Wed, 14 Feb 2007 22:43:27 +0000
Message-ID: <45D3908F.6050009@rncbc.org>
References: <20070205065636.GA1652@elte.hu>	<200702051525.49465.fzu@wemgehoertderstaat.de>	<45CD2002.7070802@rncbc.org>
	<45CDE6B9.80804@rncbc.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020205070406000800050800"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45CDE6B9.80804@rncbc.org>
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
Cc: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>, Karsten Wiese <fzu@wemgehoertderstaat.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020205070406000800050800
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This makes it. Here goes my latest tentative (but not necessarily the
last) for a new us428control incarnation, the Tascam US-428/224 control
utility, as for inclusion in the alsa-tools subtree.

Patch to alsa-tools/us428control is attached and a standalone tarball is
also provided through a personal url [1].

Notice of changes:

- A new command line option indicates which interface model is actually
present (-m us428|us224|mixxx) -- nb. the mixxx mode is actually
orthogonal to the us428 and us224 ones, which are in turn both mutually
exclusive, so that more than one -m option can be specified in the same
command line, for compatibility sake; default to us428 mode, of course.

- New BANK switching allows for mapping to a maximum of 32 (!) logical
channel-tracks. This introduces effective BANK L/R button functionality.
Under the default us428 mode it now offers a total of 4 switchable banks
(or layers) for the available 8 fader-channels; while in the new us224
mode, one can switch across 8 banks of 4 fader-channels each. Each
fader-channel maps sequentially (0-31) to a logical track in your DAW,
when connected in a MMC closed-loop. This only applies when not in INPUT
MONITOR mode.

- SELECT, REC, MUTE and SOLO state LEDs/buttons/channel functionality
are now split into INPUT MONITOR and BANK modes, so that each bank
(layer) has its own state. INPUT MONITOR mode gets its own independent
state, which is the only that affects the audio interface channel signal
volume (via respective faders) through the internal hardware mixer --
nb. this special mode deals exclusively to channel/faders 0 and 1 (A/B)
and eventually to 2 and 3 (C/D) which are only available on the US-428
and made accessible through modprobe'ing snd-usb-usx2y with nrpacks=1
and thus made usable via the special hwdep "rawusb" interface mode (ie.
hw:N,2).

- The new track-channel mapping gets effectively signaled through
correspondent but rather experimental MMC MASKED WRITE sub-commands for
RECORD, MUTE and SOLO arming. It is important to note that this late
SOLO sub-command is just some MMC implementation mockup of mine, as I
believe there's no support whatsoever for just that from the official
MIDI MMC RP-013 document (which I don't even have access to date:)
However, I've been prototyping around with this, to my own amusement and
home-brew audio/MIDI sequencer, qtractor [2].

- NULL fader switch LED is now switchable on/off, but not actually of
any usefulness at this time ;)

I have tried to maintain all previous functionality as it were. Of
course I only tested this new stuff over my own US-224, for which it
surely needs the '-m us224' command-line option. This is also proposedto
be specified in a correspondent udev rule, for all this to work
correctly OOTB for the US-224 at least. US-428 owners don't need to
bother ;)

[1] http://www.rncbc.org/usx2y/us428control-0.4.5-5.tar.gz
[2] http://qtractor.sourceforge.net

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

--------------020205070406000800050800
Content-Type: text/x-patch;
 name="us428control-0.4.5-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="us428control-0.4.5-5.patch"

diff -dupr us428control-0.4.4-0/configure.in us428control-0.4.5-5/configure.in
--- us428control-0.4.4-0/configure.in	2006-12-07 14:27:24.000000000 +0000
+++ us428control-0.4.5-5/configure.in	2007-02-09 18:01:59.000000000 +0000
@@ -1,5 +1,5 @@
 AC_INIT(us428control.cc)
-AM_INIT_AUTOMAKE(us428control, 0.4.4)
+AM_INIT_AUTOMAKE(us428control, 0.4.5)
 AC_PROG_CXX
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff -dupr us428control-0.4.4-0/Cus428Midi.cc us428control-0.4.5-5/Cus428Midi.cc
--- us428control-0.4.4-0/Cus428Midi.cc	2006-12-07 14:27:24.000000000 +0000
+++ us428control-0.4.5-5/Cus428Midi.cc	2007-02-13 18:39:14.000000000 +0000
@@ -2,6 +2,7 @@
 /*
  *
  * Copyright (c) 2003 by Karsten Wiese <annabellesgarden@yahoo.de>
+ * Copyright (c) 2004-2007 by Rui Nuno Capela <rncbc@rncbc.org>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -140,6 +141,11 @@ void Cus428Midi::ProcessMidiEvents()
 						fprintf(stderr, "LOCATE.\n");
 					OneState->LocateWheel(&data[7]);
 					break;
+				case MMC_CMD_MASKED_WRITE:
+					if (verbose > 1)
+						fprintf(stderr, "MASKED WRITE.\n");
+					OneState->MaskedWrite(&data[6]);
+					break;
 				case MMC_CMD_MMC_RESET:
 					if (verbose > 1)
 						fprintf(stderr, "MMC RESET.\n");
diff -dupr us428control-0.4.4-0/Cus428Midi.h us428control-0.4.5-5/Cus428Midi.h
--- us428control-0.4.4-0/Cus428Midi.h	2006-12-07 14:27:24.000000000 +0000
+++ us428control-0.4.5-5/Cus428Midi.h	2007-02-14 18:20:57.000000000 +0000
@@ -2,6 +2,7 @@
 /*
  *
  * Copyright (c) 2003 by Karsten Wiese <annabellesgarden@yahoo.de>
+ * Copyright (c) 2004-2007 by Rui Nuno Capela <rncbc@rncbc.org>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -61,6 +62,11 @@
 #define MMC_CMD_WAIT                    0x7c
 #define MMC_CMD_RESUME                  0x7f
 
+// Available MMC Masked Write sub-commands (information fields).
+#define MMC_CIF_TRACK_RECORD            0x4f
+#define MMC_CIF_TRACK_MUTE              0x62
+#define MMC_CIF_TRACK_SOLO              0x66 // Custom-implementation ;)
+
 
 class Cus428Midi {
 public:
diff -dupr us428control-0.4.4-0/Cus428State.cc us428control-0.4.5-5/Cus428State.cc
--- us428control-0.4.4-0/Cus428State.cc	2006-12-07 14:27:24.000000000 +0000
+++ us428control-0.4.5-5/Cus428State.cc	2007-02-14 18:18:53.000000000 +0000
@@ -3,6 +3,7 @@
  * Controller for Tascam US-X2Y
  *
  * Copyright (c) 2003 by Karsten Wiese <annabellesgarden@yahoo.de>
+ * Copyright (c) 2004-2007 by Rui Nuno Capela <rncbc@rncbc.org>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -84,9 +85,9 @@ void Cus428State::SliderChangedTo(int S,
 		V.SetTo(S, New);
 		if (S == eFaderM || !LightIs(eL_Mute0 + S))
 			SendVolume(V);
-	}
-	else
+	} else {
 		UserSliderChangedTo(S, New);
+	}
 }
 
 void Cus428State::UserKnobChangedTo(eKnobs K, bool V)
@@ -132,12 +133,12 @@ void Cus428State::UserKnobChangedTo(eKno
 		break;
 	case eK_SET:
 		if (verbose > 1)
-			printf("Knob SET now %i", V);
+			printf("Knob SET now %i\n", V);
 		bSetLocate = V;
 		break;
 	case eK_LOCATE_L:
 		if (verbose > 1)
-			printf("Knob LOCATE_L now %i", V);
+			printf("Knob LOCATE_L now %i\n", V);
 		if (V) {
 			if (bSetLocate)
 				aWheel_L = aWheel;
@@ -149,7 +150,7 @@ void Cus428State::UserKnobChangedTo(eKno
 		break;
 	case eK_LOCATE_R:
 		if (verbose > 1)
-			printf("Knob LOCATE_R now %i", V);
+			printf("Knob LOCATE_R now %i\n", V);
 		if (V) {
 			if (bSetLocate)
 				aWheel_R = aWheel;
@@ -159,6 +160,118 @@ void Cus428State::UserKnobChangedTo(eKno
 			}
 		}
 		break;
+	case eK_REC:
+		if (verbose > 1)
+			printf("Knob REC now %i\n", V);
+		bSetRecord = V;
+		break;
+	case eK_SOLO:
+		if (verbose > 1)
+			printf("Knob SOLO now %i", V);
+		if (V) {
+			bool bSolo = ! LightIs(eL_Solo);
+			if (StateInputMonitor()) {
+				if (bSolo) {
+					MuteInputMonitor = Light[2].Value;
+					Light[2].Value = SoloInputMonitor;
+				} else {
+					SoloInputMonitor = Light[2].Value;
+					Light[2].Value = MuteInputMonitor;
+				}
+			} else {
+				if (bSolo) {
+					Mute[aBank] = Light[2].Value;
+					Light[2].Value = Solo[aBank];
+				} else {
+					Solo[aBank] = Light[2].Value;
+					Light[2].Value = Mute[aBank];
+				}
+			}
+			LightSet(eL_Solo, bSolo);
+			LightSend();
+		}
+		if (verbose > 1)
+			printf(" Light is %i\n", LightIs(eL_Solo));
+		break;
+	case eK_NULL:
+		if (verbose > 1)
+			printf("Knob NULL now %i", V);
+		if (V) {
+			bool bNull = ! LightIs(eL_Null);
+			LightSet(eL_Null, bNull);
+			LightSend();
+		}
+		if (verbose > 1)
+			printf(" Light is %i\n", LightIs(eL_Null));
+		break;
+	case eK_BANK_L:
+		if (verbose > 1)
+			printf("Knob BANK_L now %i", V);
+		if (V) {
+			if (aBank > 0) {
+				bool bInputMonitor = StateInputMonitor();
+				bool bSolo = LightIs(eL_Solo);
+				if (!bInputMonitor) {
+					Select[aBank] = Light[0].Value;
+					Rec[aBank] = Light[1].Value;
+					if (bSolo) {
+						Solo[aBank] = Light[2].Value;
+					} else {
+						Mute[aBank] = Light[2].Value;
+					}
+				}
+				aBank--;
+				if (!bInputMonitor) {
+					Light[0].Value = Select[aBank];
+					Light[1].Value = Rec[aBank];
+					if (bSolo) {
+						Light[2].Value = Solo[aBank];
+					} else {
+						Light[2].Value = Mute[aBank];
+					}
+				}
+			}
+			LightSet(eL_BankL, (aBank == 0));
+			LightSet(eL_BankR, (aBank == cBanks - 1));
+			LightSend();
+		}
+		if (verbose > 1)
+			printf(" Light is %i\n", LightIs(eL_BankL));
+		break;
+	case eK_BANK_R:
+		if (verbose > 1)
+			printf("Knob BANK_R now %i", V);
+		if (V) {
+			if (aBank < 3) {
+				bool bInputMonitor = StateInputMonitor();
+				bool bSolo = LightIs(eL_Solo);
+				if (!bInputMonitor) {
+					Select[aBank] = Light[0].Value;
+					Rec[aBank] = Light[1].Value;
+					if (bSolo) {
+						Solo[aBank] = Light[2].Value;
+					} else {
+						Mute[aBank] = Light[2].Value;
+					}
+				}
+				aBank++;
+				if (!bInputMonitor) {
+					Light[0].Value = Select[aBank];
+					Light[1].Value = Rec[aBank];
+					if (bSolo) {
+						Light[2].Value = Solo[aBank];
+					} else {
+						Light[2].Value = Mute[aBank];
+					}
+				}
+			}
+			LightSet(eL_BankL, (aBank == 0));
+			LightSet(eL_BankR, (aBank == cBanks - 1));
+			LightSend();
+		}
+		if (verbose > 1)
+			printf(" Light is %i\n", LightIs(eL_BankR));
+		break;
 	default:
 		if (verbose > 1)
 			printf("Knob %i now %i\n", K, V);
@@ -169,12 +282,21 @@ void Cus428State::UserKnobChangedTo(eKno
 
 void Cus428State::KnobChangedTo(eKnobs K, bool V)
 {
-	switch (K & ~(StateInputMonitor() ? 3 : -1)) {
+//	switch (K & ~(StateInputMonitor() ? 3 : -1)) {
+	switch (K & ~3) {
 	case eK_Select0:
 		if (V) {
 			int S = eL_Select0 + (K & 7);
 			Light[eL_Select0 / 8].Value = 0;
 			LightSet(S, !LightIs(S));
+			if (bSetRecord) {
+				int R = eL_Rec0 + (K & 7);
+				LightSet(R, !LightIs(R));
+				if (!StateInputMonitor()) {
+					SendMaskedWrite(MMC_CIF_TRACK_RECORD,
+						Y * aBank + (K & 7), LightIs(R));
+				}
+			}
 			LightSend();
 		}
 		break;
@@ -184,10 +306,27 @@ void Cus428State::KnobChangedTo(eKnobs K
 			LightSet(M, !LightIs(M));
 			LightSend();
 			if (StateInputMonitor()) {
-				usX2Y_volume V = Volume[M - eL_Mute0];
-				if (LightIs(M))
-					V.LH = V.LL = V.RL = V.RH = 0;
-				SendVolume(V);
+				if (LightIs(eL_Solo)) {
+					for (int i = 0; i < 8; ++i) {
+						usX2Y_volume V = Volume[i];
+						if (!LightIs(eL_Mute0 + i) || (MuteInputMonitor & (1 << i)))
+							V.LH = V.LL = V.RL = V.RH = 0;
+						SendVolume(V);
+					}
+				} else {
+					usX2Y_volume V = Volume[M - eL_Mute0];
+					if (LightIs(M))
+						V.LH = V.LL = V.RL = V.RH = 0;
+					SendVolume(V);
+				}
+			} else {
+				if (LightIs(eL_Solo)) {
+					SendMaskedWrite(MMC_CIF_TRACK_SOLO,
+						Y * aBank + (K & 7), LightIs(M));
+				} else {
+					SendMaskedWrite(MMC_CIF_TRACK_MUTE,
+						Y * aBank + (K & 7), LightIs(M));
+				}
 			}
 		}
 		break;
@@ -196,16 +335,33 @@ void Cus428State::KnobChangedTo(eKnobs K
 			if (verbose > 1)
 				printf("Knob InputMonitor now %i", V);
 			if (V) {
-				if (StateInputMonitor()) {
-					SelectInputMonitor = Light[0].Value;
-					MuteInputMonitor = Light[2].Value;
+				bool bInputMonitor = ! StateInputMonitor();
+				if (bInputMonitor) {
+					Select[aBank] = Light[0].Value;
+					Rec[aBank] = Light[1].Value;
+					Light[0].Value = SelectInputMonitor;
+					Light[1].Value = RecInputMonitor;
+					if (LightIs(eL_Solo)) {
+						Solo[aBank] = Light[2].Value;
+						Light[2].Value = SoloInputMonitor;
+					} else {
+						Mute[aBank] = Light[2].Value;
+						Light[2].Value = MuteInputMonitor;
+					}
 				} else {
-					Select = Light[0].Value;
-					Mute = Light[2].Value;
+					SelectInputMonitor = Light[0].Value;
+					RecInputMonitor = Light[1].Value;
+					Light[0].Value = Select[aBank];
+					Light[1].Value = Rec[aBank];
+					if (LightIs(eL_Solo)) {
+						SoloInputMonitor = Light[2].Value;
+						Light[2].Value = Solo[aBank];
+					} else {
+						MuteInputMonitor = Light[2].Value;
+						Light[2].Value = Mute[aBank];
+					}
 				}
-				LightSet(eL_InputMonitor, ! StateInputMonitor());
-				Light[0].Value = StateInputMonitor() ? SelectInputMonitor : Select;
-				Light[2].Value = StateInputMonitor() ? MuteInputMonitor : Mute;
+				LightSet(eL_InputMonitor, bInputMonitor);
 				LightSend();
 			}
 			if (verbose > 1)
@@ -232,8 +388,8 @@ void Cus428State::UserWheelChangedTo(E_I
 		Param = 0x4A;
 		break;
 	case eWheel:
-	        Param = 0x60;
-	        // Update the absolute wheel position.
+		Param = 0x60;
+		// Update the absolute wheel position.
 		WheelDelta((int) ((unsigned char *) us428_ctls)[W]);
 		break;
 	}
@@ -242,21 +398,18 @@ void Cus428State::UserWheelChangedTo(E_I
 
 void Cus428State::WheelChangedTo(E_In84 W, char Diff)
 {
-	if (W == eWheelPan && StateInputMonitor() && Light[0].Value)
-		{
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
+	if (W == eWheelPan && StateInputMonitor() && Light[0].Value) {
+		int index = 0;
+		while( index < 4 && (1 << index) !=  Light[0].Value)
+			index++;
+		if (index >= 4)
 			return;
-		}
+		Volume[index].PanTo(Diff, us428_ctls->Knob(eK_SET));
+		if (!LightIs(eL_Mute0 + index))
+			SendVolume(Volume[index]);
+		return;
+	}
+
 	UserWheelChangedTo(W, Diff);
 }
 
@@ -265,9 +418,9 @@ void Cus428State::WheelChangedTo(E_In84 
 void Cus428State::LocateWheel ( unsigned char *tc )
 {
 	aWheel  = (60 * 60 * 30) * (int) tc[0]		// hh - hours    [0..23]
-		+ (     60 * 30) * (int) tc[1]		// mm - minutes  [0..59]
-		+ (          30) * (int) tc[2]		// ss - seconds  [0..59]
-		+                  (int) tc[3];		// ff - frames   [0..29]
+			+ (     60 * 30) * (int) tc[1]		// mm - minutes  [0..59]
+			+ (          30) * (int) tc[2]		// ss - seconds  [0..59]
+			+                  (int) tc[3];		// ff - frames   [0..29]
 }
 
 
@@ -426,6 +579,7 @@ void Cus428State::TransportSet ( unsigne
 	TransportSend();
 }
 
+
 // Update transport status lights.
 void Cus428State::TransportSend()
 {
@@ -447,6 +601,7 @@ void Cus428State::TransportSend()
 	LightSend();
 }
 
+
 // Reset MMC state.
 void Cus428State::MmcReset()
 {
@@ -454,13 +609,101 @@ void Cus428State::MmcReset()
 	aWheel = aWheel_L = aWheel_R = 0;
 	aWheelSpeed = 0;
 	bSetLocate = false;
+	bSetRecord = false;
 	uTransport = 0;
 
 	TransportSend();
 	LocateSend();
 }
 
-Cus428StateMixxx::Cus428StateMixxx(struct us428ctls_sharedmem* Pus428ctls_sharedmem):Cus428State(Pus428ctls_sharedmem)
+
+// Process MMC maked-write sub-command.
+void Cus428State::MaskedWrite ( unsigned char *data )
+{
+	// data[0] - sub-command / information field.
+	// data[1] - target track bitmap byte address.
+	// data[2] - bitmap changed mask.
+	// data[3] - bitmap changed value.
+
+	int track = (data[1] > 0 ? (data[1] * 7) : 0) - 5;
+	for (int i = 0; i < 7; ++i) {
+		int mask = (1 << i);
+		if (data[2] & mask) {
+			// Only touch tracks that have the "mask" bit set.
+			int enable = (data[3] & mask);
+			int bank = (track / Y);
+			int N = (track % Y);
+			switch (data[0]) {
+			case MMC_CIF_TRACK_RECORD:
+				if (verbose > 1)
+					fprintf(stderr, "TRACK RECORD(%d, %d).\n", track, enable);
+				if (!StateInputMonitor() && bank >= 0 && bank < cBanks) {
+					if (bank == aBank) {
+						LightSet(eL_Rec0 + N, enable);
+						LightSend();
+					} else if (enable) {
+						Rec[bank] |=  (1 << N);
+					} else {
+						Rec[bank] &= ~(1 << N);
+					}
+				}
+				break;
+			case MMC_CIF_TRACK_MUTE:
+				if (verbose > 1)
+					fprintf(stderr, "TRACK MUTE(%d, %d).\n", track, enable);
+				if (!StateInputMonitor() && bank >= 0 && bank < cBanks) {
+					if (bank == aBank && !LightIs(eL_Solo)) {
+						LightSet(eL_Mute0 + N, enable);
+						LightSend();
+					} else if (enable) {
+						Mute[bank] |=  (1 << N);
+					} else {
+						Mute[bank] &= ~(1 << N);
+					}
+				}
+				break;
+			case MMC_CIF_TRACK_SOLO:
+				if (verbose > 1)
+					fprintf(stderr, "TRACK SOLO(%d, %d).\n", track, enable);
+				if (!StateInputMonitor() && bank >= 0 && bank < cBanks) {
+					if (bank == aBank && LightIs(eL_Solo)) {
+						LightSet(eL_Mute0 + N, enable);
+						LightSend();
+					} else if (enable) {
+						Solo[bank] |=  (1 << N);
+					} else {
+						Solo[bank] &= ~(1 << N);
+					}
+				}
+				break;
+			default:
+				break;
+			}
+		}
+		track++;
+	}
+}
+
+
+// Send own MMC masked-write subcommand.
+void Cus428State::SendMaskedWrite ( unsigned char scmd, int track, bool V )
+{
+	unsigned char data[4];
+	int mask = (1 << (track < 2 ? track + 5 : (track - 2) % 7));
+
+	data[0] = scmd;
+	data[1] = (unsigned char) (track < 2 ? 0 : 1 + (track - 2) / 7);
+	data[2] = (unsigned char) mask;
+	data[3] = (unsigned char) (V ? mask : 0);
+
+	Midi.SendMmcCommand(MMC_CMD_MASKED_WRITE, &data[0], sizeof(data));
+}
+
+
+
+Cus428StateMixxx::Cus428StateMixxx(
+	struct us428ctls_sharedmem* Pus428ctls_sharedmem, int y)
+	: Cus428State(Pus428ctls_sharedmem, y)
 {
 	focus = 0;
 	eq = 0;
@@ -476,26 +719,26 @@ void Cus428StateMixxx::UserKnobChangedTo
 	switch (K) {
 	case eK_BANK_L:
 		if (verbose > 1)
-			printf("Knob BANK_L now %i", V);
+			printf("Knob BANK_L now %i\n", V);
 		if (V) LightSet(eL_BankL, !LightIs(eL_BankL));
 		LightSend();
 		Midi.SendMidiNote(0, 51, V ? 127 : 0);
 		break;
 	case eK_BANK_R:
 		if (verbose > 1)
-			printf("Knob BANK_R now %i", V);
+			printf("Knob BANK_R now %i\n", V);
 		if (V) LightSet(eL_BankR, !LightIs(eL_BankR));
 		LightSend();
 		Midi.SendMidiNote(1, 51, V ? 127 : 0);
 		break;
 	case eK_REW:
 		if (verbose > 1)
-			printf("Knob REW now %i", V);
+			printf("Knob REW now %i\n", V);
 		Midi.SendMidiNote(focus, 60, V ? 127 : 0);
 		break;
 	case eK_FFWD:
 		if (verbose > 1)
-			printf("Knob FFWD now %i", V);
+			printf("Knob FFWD now %i\n", V);
 		Midi.SendMidiNote(focus, 61, V ? 127 : 0);
 		break;
 	case eK_STOP:
@@ -505,17 +748,17 @@ void Cus428StateMixxx::UserKnobChangedTo
 		break;
 	case eK_PLAY:
 		if (verbose > 1)
-			printf("Knob PLAY now %i", V);
+			printf("Knob PLAY now %i\n", V);
 		Midi.SendMidiNote(focus, 63, V ? 127 : 0);
 		break;
 	case eK_RECORD:
 		if (verbose > 1)
-			printf("Knob RECORD now %i", V);
+			printf("Knob RECORD now %i\n", V);
 		Midi.SendMidiNote(focus, 64, V ? 127 : 0);
 		break;
 	case eK_LOW:
 		if (verbose > 1)
-			printf("Knob LOW now %i", V);
+			printf("Knob LOW now %i\n", V);
 		if (V)
 			{
 				eq = 0;
@@ -528,7 +771,7 @@ void Cus428StateMixxx::UserKnobChangedTo
 		break;
 	case eK_LOWMID:
 		if (verbose > 1)
-			printf("Knob LOWMID now %i", V);
+			printf("Knob LOWMID now %i\n", V);
 		if (V)
 			{
 				eq = 1;
@@ -541,7 +784,7 @@ void Cus428StateMixxx::UserKnobChangedTo
 		break;
 	case eK_HIMID:
 		if (verbose > 1)
-			printf("Knob HIMID now %i", V);
+			printf("Knob HIMID now %i\n", V);
 		if (V)
 			{
 				eq = 2;
@@ -554,7 +797,7 @@ void Cus428StateMixxx::UserKnobChangedTo
 		break;
 	case eK_HIGH:
 		if (verbose > 1)
-			printf("Knob HIGH now %i", V);
+			printf("Knob HIGH now %i\n", V);
 		if (V)
 			{
 				eq = 3;
@@ -567,19 +810,19 @@ void Cus428StateMixxx::UserKnobChangedTo
 		break;
 	case eK_SET:
 		if (verbose > 1)
-			printf("Knob SET now %i", V);
+			printf("Knob SET now %i\n", V);
 		Midi.SendMidiNote(focus, 65, V ? 127 : 0);
 		break;
 	case eK_LOCATE_L:
 		if (verbose > 1)
-			printf("Knob LOCATE_L now %i", V);
+			printf("Knob LOCATE_L now %i\n", V);
 		if (V) {
 			focus = 0;
 		}
 		break;
 	case eK_LOCATE_R:
 		if (verbose > 1)
-			printf("Knob LOCATE_R now %i", V);
+			printf("Knob LOCATE_R now %i\n", V);
 		if (V) {
 			focus = 1;
 		}
diff -dupr us428control-0.4.4-0/Cus428State.h us428control-0.4.5-5/Cus428State.h
--- us428control-0.4.4-0/Cus428State.h	2006-12-07 14:27:24.000000000 +0000
+++ us428control-0.4.5-5/Cus428State.h	2007-02-14 18:15:55.000000000 +0000
@@ -3,6 +3,7 @@
  * Controller for Tascam US-X2Y
  *
  * Copyright (c) 2003 by Karsten Wiese <annabellesgarden@yahoo.de>
+ * Copyright (c) 2004-2007 by Rui Nuno Capela <rncbc@rncbc.org>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -24,29 +25,50 @@
 
 #include "Cus428_ctls.h"
 
-class Cus428State: public us428_lights{
+class Cus428State: public us428_lights
+{
 public:
-	Cus428State(struct us428ctls_sharedmem* Pus428ctls_sharedmem)
-		:us428ctls_sharedmem(Pus428ctls_sharedmem)
+
+	// Constructor.
+	Cus428State(struct us428ctls_sharedmem* Pus428ctls_sharedmem, int y = 8)
+		:us428ctls_sharedmem(Pus428ctls_sharedmem),Y(y)
+		,us428_ctls(0)
 		,MuteInputMonitor(0)
-		,Mute(0)
+		,SoloInputMonitor(0)
+		,RecInputMonitor(0)
 		,SelectInputMonitor(0)
-		,Select(0)
-		,us428_ctls(0)
+		,aBank(0)
+		,cBanks(32 / y)
 		,W0(0)
 		,aWheel(0)
 		,aWheel_L(0)
 		,aWheel_R(0)
 		,bSetLocate(false)
+		,bSetRecord(false)
 		,uTransport(0)
 		,aWheelSpeed(0)
 	{
+		Mute = new unsigned char [cBanks];
+		Solo = new unsigned char [cBanks];
+		Rec = new unsigned char [cBanks];
+		Select = new unsigned char [cBanks];
+		for (int i = 0; i < cBanks; ++i)
+			Mute[i] = Solo[i] = Rec[i] = Select[i] = 0;
 		init_us428_lights();
 		for (int v = 0; v < 5; ++v) {
 			Volume[v].init(v);
 		}
 	}
-	enum eKnobs{
+
+	// Destructor.
+	virtual ~Cus428State() {
+		delete Select;
+		delete Rec;
+		delete Solo;
+		delete Mute;
+	}
+
+	enum eKnobs {
 		eK_RECORD =	72,
 		eK_PLAY,
 		eK_STOP,
@@ -84,6 +106,7 @@ public:
 		eK_F2,
 		eK_F3,
 	};
+
 	void InitDevice(void);
 
 	void KnobChangedTo(eKnobs K, bool V);
@@ -108,9 +131,13 @@ public:
 	void TransportToggle(unsigned char T);
 	void TransportSet(unsigned char T, bool V);
 	void TransportSend();
+	// Process masked-write sub-command.
+	void MaskedWrite(unsigned char *data);
 	// Reset internal MMC state.
 	void MmcReset();
+
 protected:
+
 	void SendVolume(usX2Y_volume &V);
 	struct us428ctls_sharedmem* us428ctls_sharedmem;
 	bool StateInputMonitor() {
@@ -124,13 +151,19 @@ protected:
 	void WheelShuttle(int dW);
 	// Get the curent wheel timecode.
 	void LocateTimecode(unsigned char *tc);
+	// Send own MMC masked-write subcommand.
+	void SendMaskedWrite(unsigned char scmd, int track, bool V);
 
 	usX2Y_volume_t	Volume[5];
-	char		MuteInputMonitor,
-		Mute,
-		SelectInputMonitor,
-		Select;
 	Cus428_ctls	*us428_ctls;
+	// To hold channel light-mode states.
+	unsigned char
+		MuteInputMonitor,	*Mute,
+		SoloInputMonitor,	*Solo,
+		RecInputMonitor,	*Rec,
+		SelectInputMonitor,	*Select;
+	// The current selected bank, maximum number of bank/layers.
+	int aBank, cBanks;
 	// Differential wheel tracking.
 	int W0;
 	// Some way to convert wheel (absolute) position into hh:mm:ss:ff:fr
@@ -140,16 +173,20 @@ protected:
 	int aWheel_R;
 	// SET knob state.
 	bool bSetLocate;
+	// REC knob state.
+	bool bSetRecord;
 	// Last/current transport state.
 	unsigned char uTransport;
 	// Shuttle wheel absolute speed.
 	int aWheelSpeed;
+	// The official number of faders (channels per bank)
+	int Y;
 };
 
 
 class Cus428StateMixxx: public Cus428State{
 public:
-	Cus428StateMixxx(struct us428ctls_sharedmem* Pus428ctls_sharedmem);
+	Cus428StateMixxx(struct us428ctls_sharedmem* Pus428ctls_sharedmem, int y);
 	void UserKnobChangedTo(eKnobs K, bool V);
 	void UserSliderChangedTo(int S, unsigned char New);
 	void UserWheelChangedTo(E_In84 W, char Diff);
diff -dupr us428control-0.4.4-0/us428control.cc us428control-0.4.5-5/us428control.cc
--- us428control-0.4.4-0/us428control.cc	2006-12-07 14:27:24.000000000 +0000
+++ us428control-0.4.5-5/us428control.cc	2007-02-14 18:38:07.000000000 +0000
@@ -3,6 +3,7 @@
  * Controller for Tascam US-X2Y
  *
  * Copyright (c) 2003 by Karsten Wiese <annabellesgarden@yahoo.de>
+ * Copyright (c) 2004-2007 by Rui Nuno Capela <rncbc@rncbc.org>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -63,7 +64,7 @@ static void usage(void)
 	printf("Tascam US-428 Control\n");
 	printf("version %s\n", VERSION);
 	printf("usage: "PROGNAME" [-v verbosity_level 0..2] [-c card] [-D device] [-u usb-device] [-m mode]\n");
-	printf("mode is one of (native, mixxx)\n");
+	printf("mode is one of (us224, us428, mixxx)\n");
 }
 /*
  * check the name id of the given hwdep handle
@@ -85,7 +86,7 @@ static int check_hwinfo(snd_hwdep_t *hw,
 	return 0; /* ok */
 }
 
-int US428Control(const char* DevName, int mode)
+int US428Control(const char* DevName, int mode, int y)
 {
 	snd_hwdep_t		*hw;
 	int			err;
@@ -95,7 +96,8 @@ int US428Control(const char* DevName, in
 	int npfd, pollrc;
 
 	if ((err = snd_hwdep_open(&hw, DevName, O_RDWR)) < 0) {
-		error("cannot open hwdep %s\n", DevName);
+		if (verbose > 1)
+			error("cannot open hwdep %s\n", DevName);
 		return err;
 	}
 
@@ -105,6 +107,9 @@ int US428Control(const char* DevName, in
 		return -ENODEV;
 	}
 
+	if (verbose > 0)
+		fprintf(stderr, PROGNAME ": US-X2Y-compatible card found on hwdep %s\n", DevName);
+
 	Midi.CreatePorts();
 
 	npfd = snd_seq_poll_descriptors_count(Midi.Seq, POLLIN) + 1;
@@ -118,11 +123,12 @@ int US428Control(const char* DevName, in
 		snd_hwdep_close(hw);
 		return -ENOMEM;
 	}
+
 	us428ctls_sharedmem->CtlSnapShotRed = us428ctls_sharedmem->CtlSnapShotLast;
 	if (mode == 1)
-		OneState = new Cus428StateMixxx(us428ctls_sharedmem);
+		OneState = new Cus428StateMixxx(us428ctls_sharedmem, y);
 	else
-		OneState = new Cus428State(us428ctls_sharedmem);
+		OneState = new Cus428State(us428ctls_sharedmem, y);
 
 	OneState->InitDevice();
 
@@ -131,7 +137,7 @@ int US428Control(const char* DevName, in
 			if (verbose > 1 || pfds[0].revents & (POLLERR|POLLHUP))
 				printf("poll returned 0x%X\n", pfds[0].revents);
 			if (pfds[0].revents & (POLLERR|POLLHUP))
-				return -ENXIO;
+				return 0; /* -ENXIO; */
 			int Last = us428ctls_sharedmem->CtlSnapShotLast;
 			if (verbose > 1)
 				printf("Last is %i\n", Last);
@@ -158,6 +164,7 @@ int US428Control(const char* DevName, in
 int main (int argc, char *argv[])
 {
 	int c;
+	int y = 8;
 	int mode = 0;
 	int card = -1;
 	char	*device_name = NULL,
@@ -179,6 +186,12 @@ int main (int argc, char *argv[])
 			verbose = atoi(optarg);
 			break;
 		case 'm':
+			if (!strcmp(optarg, "us224"))
+				y = 4;
+			else
+			if (!strcmp(optarg, "us428"))
+				y = 8;
+			else
 			if (!strcmp(optarg, "mixxx"))
 				mode = 1;
 			break;
@@ -201,24 +214,28 @@ int main (int argc, char *argv[])
 		}
 	}
 	if (device_name) {
-		return US428Control(device_name, mode) != 0;
+		return US428Control(device_name, mode, y) != 0;
 	}
 	if (card >= 0) {
 		sprintf(name, "hw:%d", card);
-		return US428Control(name, mode) != 0;
+		return US428Control(name, mode, y) != 0;
 	}
 
 	/* probe the all cards */
 	for (c = 0; c < SND_CARDS; c++) {
 		//	verbose--;
 		sprintf(name, "hw:%d", c);
-		if (!US428Control(name, mode))
+		if (US428Control(name, mode, y) == 0) {
 			card = c;
+			break;
+		}
 	}
+
 	if (card < 0) {
 		fprintf(stderr, PROGNAME ": no US-X2Y-compatible cards found\n");
 		return 1;
 	}
+
 	return 0;
 }
 

--------------020205070406000800050800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020205070406000800050800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020205070406000800050800--
