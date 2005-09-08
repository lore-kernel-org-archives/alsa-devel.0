From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH] emu10k1: Front channels via fxbus 8 and 9
Date: Fri, 9 Sep 2005 00:01:56 +0200
Message-ID: <20050908220155.GA28152@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm resending my patches that add front channels that can be used independently
of the "default" pcm device. I think the patches are really useful. When
you use the current SB Live driver it will automatically mute "Wave Surround",
"Wave Center" and "Wave LFE" when playing 5.1, since otherwise the front signal
would be played on all channels. With these patches this isn't necessary
since the "front" device is routed to the front outputs only.

One potential problem is that you won't get any front output during
5.1 playback if you use an old EMU10K1.conf with a patched driver.

Regards,
Mikael Magnusson

front_fx_v3.patch:

Adds left and right front channel outputs using fxbus 8 and 9 and "Front"
playback and capture volume controls.

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>

front_config_v3.patch:

Routes front channels via fxbus 8 and 9 instead of fxbus 0 and 1. This
makes the front and default devices independent of each other, and
"Wave Surround", "Wave Center" and "Wave LFE" don't have to be muted
during 5.1 playback. 

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="front_fx_v3.patch"

Index: alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.76
diff -u -r1.76 emufx.c
--- alsa-kernel/pci/emu10k1/emufx.c	5 Sep 2005 09:35:22 -0000	1.76
+++ alsa-kernel/pci/emu10k1/emufx.c	8 Sep 2005 15:59:45 -0000
@@ -964,8 +964,8 @@
 	return err;
 }
 
-#define SND_EMU10K1_GPR_CONTROLS	41
-#define SND_EMU10K1_INPUTS		10
+#define SND_EMU10K1_GPR_CONTROLS	44
+#define SND_EMU10K1_INPUTS		12
 #define SND_EMU10K1_PLAYBACK_CHANNELS	8
 #define SND_EMU10K1_CAPTURE_CHANNELS	4
 
@@ -1527,7 +1527,7 @@
 
 	strcpy(icode->name, "SB Live! FX8010 code for ALSA v1.2 by Jaroslav Kysela");
 	ptr = 0; i = 0;
-	/* we have 10 inputs */
+	/* we have 12 inputs */
 	playback = SND_EMU10K1_INPUTS;
 	/* we have 6 playback channels and tone control doubles */
 	capture = playback + (SND_EMU10K1_PLAYBACK_CHANNELS * 2);
@@ -1551,6 +1551,8 @@
 	OP(icode, &ptr, iMACINT0, GPR(7), C_00000000, FXBUS(FXBUS_PCM_LFE), C_00000004);
 	OP(icode, &ptr, iMACINT0, GPR(8), C_00000000, C_00000000, C_00000000);	/* S/PDIF left */
 	OP(icode, &ptr, iMACINT0, GPR(9), C_00000000, C_00000000, C_00000000);	/* S/PDIF right */
+	OP(icode, &ptr, iMACINT0, GPR(10), C_00000000, FXBUS(FXBUS_PCM_LEFT_FRONT), C_00000004);
+	OP(icode, &ptr, iMACINT0, GPR(11), C_00000000, FXBUS(FXBUS_PCM_RIGHT_FRONT), C_00000004);
 
 	/* Raw S/PDIF PCM */
 	ipcm->substream = 0;
@@ -1697,6 +1699,21 @@
 	VOLUME_ADD(icode, &ptr, playback + 5, 7, gpr);
 	snd_emu10k1_init_mono_control(controls + i++, "LFE Digital Playback Volume", gpr++, 100);
 
+	/* Front Playback Volume */
+	for (z = 0; z < 2; z++)
+		VOLUME_ADD(icode, &ptr, playback + z, 10 + z, gpr + z);
+	snd_emu10k1_init_stereo_control(controls + i++, "Front Playback Volume", gpr, 100);
+	gpr += 2;
+
+	/* Front Capture Volume + Switch */
+	for (z = 0; z < 2; z++) {
+		SWITCH(icode, &ptr, tmp + 0, 10 + z, gpr + 2);
+		VOLUME_ADD(icode, &ptr, capture + z, tmp + 0, gpr + z);
+	}
+	snd_emu10k1_init_stereo_control(controls + i++, "Front Capture Volume", gpr, 0);
+	snd_emu10k1_init_mono_onoff_control(controls + i++, "Front Capture Switch", gpr + 2, 0);
+	gpr += 3;
+
 	/*
 	 *  Process inputs
 	 */

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="front_config_v3.patch"

Index: alsa-lib/src/conf/cards/EMU10K1.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/EMU10K1.conf,v
retrieving revision 1.16
diff -u -r1.16 EMU10K1.conf
--- alsa-lib/src/conf/cards/EMU10K1.conf	3 Aug 2005 12:50:32 -0000	1.16
+++ alsa-lib/src/conf/cards/EMU10K1.conf	8 Sep 2005 16:11:50 -0000
@@ -9,9 +9,51 @@
 	@args.CARD {
 		type string
 	}
-	type hw
-	card $CARD
-	device 0
+	type hooks
+	slave.pcm {
+		type hw
+		card $CARD
+		device 0
+	}
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				interface PCM
+				device 0
+				name "EMU10K1 PCM Send Volume"
+				index { @func private_pcm_subdevice }
+				lock true
+				optional true
+				value [ 255 255 0 0 255 0 0 0 0 255 0 0 ]
+			}
+			{
+				# for compatibility with older drivers
+				name "EMU10K1 PCM Send Volume"
+				index { @func private_pcm_subdevice }
+				lock true
+				optional true
+				value [ 255 255 0 0 255 0 0 0 0 255 0 0 ]
+			}
+			{
+				interface PCM
+				device 0
+				name "EMU10K1 PCM Send Routing"
+				index { @func private_pcm_subdevice }
+				lock true
+				optional true
+				value [ 8 9 0 0 8 9 0 0 8 9 0 0 ]
+			}
+			{
+				# for compatibility with older drivers
+				name "EMU10K1 PCM Send Routing"
+				index { @func private_pcm_subdevice }
+				lock true
+				optional true
+				value [ 8 9 0 0 8 9 0 0 8 9 0 0 ]
+			}
+		]
+	}
 }	
 
 <confdir:pcm/rear.conf>
@@ -31,13 +73,6 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "Wave Surround Playback Volume"
-				preserve true
-				# don't lock a global control
-				# lock true
-				value [ 0 0 ]
-			}
-			{
 				interface PCM
 				device 0
 				name "EMU10K1 PCM Send Volume"
@@ -75,18 +110,6 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "Wave Center Playback Volume"
-				preserve true
- 				# lock true
-				value 0
-			}
-			{
-				name "Wave LFE Playback Volume"
-				preserve true
-				# lock true
-				value 0
-			}
-			{
 				name "Headphone Center Playback Switch"
 				index 1
 				preserve true

--uAKRQypu60I7Lcqm--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
