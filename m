From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH] emu10k1 SB Live: Front channels independent of default pcm
Date: Wed, 23 Feb 2005 15:58:52 +0100
Message-ID: <421C9A2C.7000708@glocalnet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090601000701040507090000"
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1D4C31E3
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 15:58:52 +0100 (MET)
Received: from mulder.hem.za.org (unknown [84.217.31.130])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 731C358DFD
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 15:58:52 +0100 (MET)
Received: from skinner.hem.za.org ([192.168.0.2])
	by mulder.hem.za.org with esmtp (Exim 4.34)
	id 1D3xyW-0006rQ-Sp
	for alsa-devel@alsa-project.org; Wed, 23 Feb 2005 15:58:52 +0100
Received: from localhost ([127.0.0.1])
	by skinner.hem.za.org with esmtp (Exim 4.34)
	id 1D3xyW-0006ew-Dt
	for alsa-devel@alsa-project.org; Wed, 23 Feb 2005 15:58:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090601000701040507090000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

These patches add front channels that are independent of the default pcm
output. It will also reduce the difference between the SB Live and
Audigy drivers. One potential problem is that the changed configuration
file can't be used with an unpatched driver. Then you won't get any
  front output during multichannel playback.

front_fx_v2.patch:

Adds left and right front channel inputs using fxbus 8 and 9 and "Front"
playback and capture controls.

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>

front_config_v2.patch:

Routes front channels via fxbus 8 and 9 instead of fxbus 0 and 1. This
makes the front and default pcm outputs independent of each other, as in 
the Audigy driver.

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>


--------------090601000701040507090000
Content-Type: text/x-patch;
 name="front_config_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="front_config_v2.patch"

--- alsa-lib/src/conf/cards/EMU10K1.conf	16 Feb 2005 11:47:05 -0000	1.14
+++ alsa-lib/src/conf/cards/EMU10K1.conf	23 Feb 2005 10:32:19 -0000
@@ -9,9 +9,29 @@
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
+				name "EMU10K1 PCM Send Volume"
+				index { @func private_pcm_subdevice }
+				lock true
+				value [ 255 255 0 0 255 0 0 0 0 255 0 0 ]
+			}
+			{
+				name "EMU10K1 PCM Send Routing"
+				index { @func private_pcm_subdevice }
+				lock true
+				value [ 8 9 0 0 8 9 0 0 8 9 0 0 ]
+			}
+		]
+	}
 }	
 
 <confdir:pcm/rear.conf>
@@ -31,13 +51,6 @@
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
 				name "EMU10K1 PCM Send Volume"
 				index { @func private_pcm_subdevice }
 				lock true
@@ -64,18 +77,6 @@
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


--------------090601000701040507090000
Content-Type: text/x-patch;
 name="front_fx_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="front_fx_v2.patch"

--- alsa-kernel/pci/emu10k1/emufx.c	17 Feb 2005 14:51:52 -0000	1.69
+++ alsa-kernel/pci/emu10k1/emufx.c	23 Feb 2005 10:31:40 -0000
@@ -934,8 +934,8 @@
 	return err;
 }
 
-#define SND_EMU10K1_GPR_CONTROLS	41
-#define SND_EMU10K1_INPUTS		10
+#define SND_EMU10K1_GPR_CONTROLS	44
+#define SND_EMU10K1_INPUTS		12
 #define SND_EMU10K1_PLAYBACK_CHANNELS	8
 #define SND_EMU10K1_CAPTURE_CHANNELS	4
 
@@ -1489,7 +1489,7 @@
 
 	strcpy(icode->name, "SB Live! FX8010 code for ALSA v1.2 by Jaroslav Kysela");
 	ptr = 0; i = 0;
-	/* we have 10 inputs */
+	/* we have 12 inputs */
 	playback = SND_EMU10K1_INPUTS;
 	/* we have 6 playback channels and tone control doubles */
 	capture = playback + (SND_EMU10K1_PLAYBACK_CHANNELS * 2);
@@ -1513,6 +1513,8 @@
 	OP(icode, &ptr, iMACINT0, GPR(7), C_00000000, FXBUS(FXBUS_PCM_LFE), C_00000004);
 	OP(icode, &ptr, iMACINT0, GPR(8), C_00000000, C_00000000, C_00000000);	/* S/PDIF left */
 	OP(icode, &ptr, iMACINT0, GPR(9), C_00000000, C_00000000, C_00000000);	/* S/PDIF right */
+	OP(icode, &ptr, iMACINT0, GPR(10), C_00000000, FXBUS(FXBUS_PCM_LEFT_FRONT), C_00000004);
+	OP(icode, &ptr, iMACINT0, GPR(11), C_00000000, FXBUS(FXBUS_PCM_RIGHT_FRONT), C_00000004);
 
 	/* Raw S/PDIF PCM */
 	ipcm->substream = 0;
@@ -1659,6 +1661,21 @@
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


--------------090601000701040507090000--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
