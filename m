From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH 1/5] emu10k1 SB Live: Master volume and front channels via
 fxbus 8,9
Date: Mon, 21 Feb 2005 20:44:58 +0100
Message-ID: <421A3A3A.6070009@glocalnet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010801080903030706010005"
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4C43915A
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 20:45:03 +0100 (MET)
Received: from mulder.hem.za.org (unknown [84.217.26.207])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id DD0BB57F53
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 20:45:02 +0100 (MET)
Received: from skinner.hem.za.org ([192.168.0.2])
	by mulder.hem.za.org with esmtp (Exim 4.34)
	id 1D3JUL-0000Zs-NI
	for alsa-devel@alsa-project.org; Mon, 21 Feb 2005 20:45:01 +0100
Received: from localhost ([127.0.0.1])
	by skinner.hem.za.org with esmtp (Exim 4.34)
	id 1D3JUI-0001a8-WC
	for alsa-devel@alsa-project.org; Mon, 21 Feb 2005 20:44:59 +0100
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
--------------010801080903030706010005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is the first in a set of five patches that add master volume and 
switch controls and front pcm channels via fxbus 8,9 to SB Live.

master_volume.patch:

Adds "Master Digital Playback Volume" which controls all six pcm 
playback channels.

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>

--------------010801080903030706010005
Content-Type: text/x-patch;
 name="master_volume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="master_volume.patch"

diff -u alsa-kernel/pci/emu10k1/emufx.c alsa-kernel/pci/emu10k1/emufx.c
--- alsa-kernel/pci/emu10k1/emufx.c	21 Feb 2005 13:33:30 -0000
+++ alsa-kernel/pci/emu10k1/emufx.c	21 Feb 2005 13:33:52 -0000
@@ -934,7 +934,7 @@
 	return err;
 }
 
-#define SND_EMU10K1_GPR_CONTROLS	41
+#define SND_EMU10K1_GPR_CONTROLS	43
 #define SND_EMU10K1_INPUTS		10
 #define SND_EMU10K1_PLAYBACK_CHANNELS	8
 #define SND_EMU10K1_CAPTURE_CHANNELS	4
@@ -1780,6 +1780,19 @@
 	}
 
 	/*
+	 * Master Volume
+	 */
+	for (z = 0; z < 6; z++) {
+		SWITCH(icode, &ptr, playback + z, playback + z, gpr + 0);
+		VOLUME(icode, &ptr, playback + z, playback + z, gpr + 1);
+	}
+
+	snd_emu10k1_init_mono_onoff_control(controls + i++, "Master Digital Playback Switch", gpr + 0, 0);
+	snd_emu10k1_init_mono_control(controls + i++, "Master Digital Playback Volume", gpr + 1, 0);
+	gpr += 2;
+
+
+	/*
 	 *  Process tone control
 	 */
 	OP(icode, &ptr, iACC3, GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 0), GPR(playback + 0), C_00000000, C_00000000); /* left */

--------------010801080903030706010005--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
