From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH 5/5] emu10k1 SB Live: Master volume and front channels via
 fxbus 8,9
Date: Mon, 21 Feb 2005 20:45:12 +0100
Message-ID: <421A3A48.9030701@glocalnet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070408000206060000030703"
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 046A815A
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 20:45:14 +0100 (MET)
Received: from mulder.hem.za.org (unknown [84.217.26.207])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id A177457F54
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 20:45:13 +0100 (MET)
Received: from skinner.hem.za.org ([192.168.0.2])
	by mulder.hem.za.org with esmtp (Exim 4.34)
	id 1D3JUX-0000aC-1x
	for alsa-devel@alsa-project.org; Mon, 21 Feb 2005 20:45:13 +0100
Received: from localhost ([127.0.0.1])
	by skinner.hem.za.org with esmtp (Exim 4.34)
	id 1D3JUW-0001ab-SS
	for alsa-devel@alsa-project.org; Mon, 21 Feb 2005 20:45:12 +0100
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
--------------070408000206060000030703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

wave_volume.patch:

Renames the "Wave" volume control to "Wave Front" and adds "Wave" which 
controls all six channels.

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>

--------------070408000206060000030703
Content-Type: text/x-patch;
 name="wave_volume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wave_volume.patch"

diff -u alsa-kernel/pci/emu10k1/emufx.c alsa-kernel/pci/emu10k1/emufx.c
--- alsa-kernel/pci/emu10k1/emufx.c	21 Feb 2005 13:34:35 -0000
+++ alsa-kernel/pci/emu10k1/emufx.c	21 Feb 2005 13:34:49 -0000
@@ -934,7 +934,7 @@
 	return err;
 }
 
-#define SND_EMU10K1_GPR_CONTROLS	46
+#define SND_EMU10K1_GPR_CONTROLS	47
 #define SND_EMU10K1_INPUTS		12
 #define SND_EMU10K1_PLAYBACK_CHANNELS	8
 #define SND_EMU10K1_CAPTURE_CHANNELS	4
@@ -1596,18 +1596,24 @@
 
 	/* Wave Playback Volume */
 	for (z = 0; z < 2; z++)
-		VOLUME(icode, &ptr, playback + z, z, gpr + z);
+		VOLUME(icode, &ptr, tmp + 2 + z, z, gpr + z);
 	snd_emu10k1_init_stereo_control(controls + i++, "Wave Playback Volume", gpr, 100);
 	gpr += 2;
 
+	/* Wave Front Playback Volume */
+	for (z = 0; z < 2; z++)
+		VOLUME(icode, &ptr, playback + z, tmp + 2 + z, gpr + z);
+	snd_emu10k1_init_stereo_control(controls + i++, "Wave Front Playback Volume", gpr, 100);
+	gpr += 2;
+
 	/* Wave Surround Playback Volume */
 	for (z = 0; z < 2; z++)
-		VOLUME(icode, &ptr, playback + 2 + z, z, gpr + z);
+		VOLUME(icode, &ptr, playback + 2 + z, tmp + 2 + z, gpr + z);
 	snd_emu10k1_init_stereo_control(controls + i++, "Wave Surround Playback Volume", gpr, 0);
 	gpr += 2;
 	
 	/* Wave Center/LFE Playback Volume */
-	OP(icode, &ptr, iACC3, GPR(tmp + 0), FXBUS(FXBUS_PCM_LEFT), FXBUS(FXBUS_PCM_RIGHT), C_00000000);
+	OP(icode, &ptr, iACC3, GPR(tmp + 0), GPR(tmp + 2), GPR(tmp + 3), C_00000000);
 	OP(icode, &ptr, iMACINT0, GPR(tmp + 0), C_00000000, GPR(tmp + 0), C_00000002);
 	VOLUME(icode, &ptr, playback + 4, tmp + 0, gpr);
 	snd_emu10k1_init_mono_control(controls + i++, "Wave Center Playback Volume", gpr++, 0);

--------------070408000206060000030703--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
