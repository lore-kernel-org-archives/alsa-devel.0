From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: [Patch] emufx.c mixer control names
Date: Fri, 16 Jul 2004 16:35:20 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S26221AbUGPNfU/20040716133520Z+4941@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Hello. Below is the patch for changing the emu10k1 mixer control
names. The patch is against alsa-driver-1.0.0pre3 because I have
had no time to repatch later versions. Note that I also fixed
the missing emu10k1 control bug on my own; it is included in the
patch.

After patching the alsamixer shows the following names; there is
still a minor problem.
 Line2/Mic2 LiveDrive
 Line2/Mic2 LiveDrive Capture
 Aux2 LiveDrive       % should be "Aux2 LiveDrive Capture"
 Aux2 LiveDrive 1     % should be "Aux2 LiveDrive"

Why Aux2 is displayed wrong? It looks like "Capture" ending is added
by alsamixer.c but why it handles Line2/Mic2 and Aux2 differently?

Juhana

 == diff -u ==

--- emufx.c.orig	Fri Nov  7 19:52:01 2003
+++ emufx.c	Sat Nov 29 10:28:26 2003
@@ -1911,19 +1911,19 @@
 	}
 	
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_LINE1_L)|(1<<EXTIN_LINE1_R))) {
-		/* Line LiveDrive Playback Volume */
+		/* Line2/Mic2 LiveDrive Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_LINE1_L + z, gpr + z);
-		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Playback Volume", gpr, 0);
+		snd_emu10k1_init_stereo_control(controls + i++, "Line2/Mic2 LiveDrive Playback Volume", gpr, 0);
 		gpr += 2;
 	
-		/* Line LiveDrive Capture Volume + Switch */
+		/* Line2/Mic2 LiveDrive Capture Volume + Switch */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_LINE1_L + z, gpr + 2 + z);
 			VOLUME_ADD(icode, &ptr, capture + z, tmp + 0, gpr + z);
 		}
-		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Capture Volume", gpr, 0);
-		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line LiveDrive Capture Switch", gpr + 2, 0);
+		snd_emu10k1_init_stereo_control(controls + i++, "Line2/Mic2 LiveDrive Capture Volume", gpr, 0);
+		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line2/Mic2 LiveDrive Capture Switch", gpr + 2, 0);
 		gpr += 4;
 	}
 	
@@ -1945,20 +1945,20 @@
 	}
 	
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_LINE2_L)|(1<<EXTIN_LINE2_R))) {
-		/* Line LiveDrive Playback Volume */
+		/* Aux2 LiveDrive Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_LINE2_L + z, gpr + z);
-		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Playback Volume", gpr, 0);
+		snd_emu10k1_init_stereo_control(controls + i++, "Aux2 LiveDrive Playback Volume", gpr, 0);
 		controls[i-1].id.index = 1;
 		gpr += 2;
 	
-		/* Line LiveDrive Capture Volume */
+		/* Aux2 LiveDrive Capture Volume */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_LINE2_L + z, gpr + 2 + z);
 			VOLUME_ADD(icode, &ptr, capture + z, tmp + 0, gpr + z);
 		}
-		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Capture Volume", gpr, 0);
-		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line LiveDrive Capture Switch", gpr + 2, 0);
+		snd_emu10k1_init_stereo_control(controls + i++, "Aux2 LiveDrive Capture Volume", gpr, 0);
+		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Aux2 LiveDrive Capture Switch", gpr + 2, 0);
 		controls[i-1].id.index = 1;
 		gpr += 4;
 	}

 == end ==


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
