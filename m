From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: change "Music" to "Synth" in mixer control names.
Date: Tue, 28 Dec 2004 20:24:13 -0500
Message-ID: <1104283454.27377.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This patch changes "Music" to "Synth" in the mixer control names, in
order to make it clear that these controls affect the wavetable synth.
"Music" is confusing and could equally well refer to PCM, plus the
Windows drivers (kX and Creative) call it "Synth" so users expect this.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa-2.6.10-rc2/alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.66
diff -u -r1.66 emufx.c
--- alsa-2.6.10-rc2/alsa-kernel/pci/emu10k1/emufx.c	23 Nov 2004 15:11:54 -0000	1.66
+++ alsa-2.6.10-rc2/alsa-kernel/pci/emu10k1/emufx.c	29 Dec 2004 01:20:21 -0000
@@ -1065,10 +1065,10 @@
 	snd_emu10k1_init_stereo_control(&controls[nctl++], "Wave Playback Volume", gpr, 100);
 	gpr += 2;
 
-	/* Music Playback */
+	/* Synth Playback */
 	A_OP(icode, &ptr, iMAC0, A_GPR(stereo_mix+0), A_GPR(stereo_mix+0), A_GPR(gpr), A_FXBUS(FXBUS_MIDI_LEFT));
 	A_OP(icode, &ptr, iMAC0, A_GPR(stereo_mix+1), A_GPR(stereo_mix+1), A_GPR(gpr+1), A_FXBUS(FXBUS_MIDI_RIGHT));
-	snd_emu10k1_init_stereo_control(&controls[nctl++], "Music Playback Volume", gpr, 100);
+	snd_emu10k1_init_stereo_control(&controls[nctl++], "Synth Playback Volume", gpr, 100);
 	gpr += 2;
 
 	/* Wave (PCM) Capture */
@@ -1077,10 +1077,10 @@
 	snd_emu10k1_init_stereo_control(&controls[nctl++], "PCM Capture Volume", gpr, 0);
 	gpr += 2;
 
-	/* Music Capture */
+	/* Synth Capture */
 	A_OP(icode, &ptr, iMAC0, A_GPR(capture+0), A_GPR(capture+0), A_GPR(gpr), A_FXBUS(FXBUS_MIDI_LEFT));
 	A_OP(icode, &ptr, iMAC0, A_GPR(capture+1), A_GPR(capture+1), A_GPR(gpr+1), A_FXBUS(FXBUS_MIDI_RIGHT));
-	snd_emu10k1_init_stereo_control(&controls[nctl++], "Music Capture Volume", gpr, 0);
+	snd_emu10k1_init_stereo_control(&controls[nctl++], "Synth Capture Volume", gpr, 0);
 	gpr += 2;
 
 	/*
@@ -1608,19 +1608,19 @@
 	snd_emu10k1_init_stereo_onoff_control(controls + i++, "Wave Capture Switch", gpr + 2, 0);
 	gpr += 4;
 
-	/* Music Playback Volume */
+	/* Synth Playback Volume */
 	for (z = 0; z < 2; z++)
 		VOLUME_ADD(icode, &ptr, playback + z, 2 + z, gpr + z);
-	snd_emu10k1_init_stereo_control(controls + i++, "Music Playback Volume", gpr, 100);
+	snd_emu10k1_init_stereo_control(controls + i++, "Synth Playback Volume", gpr, 100);
 	gpr += 2;
 
-	/* Music Capture Volume + Switch */
+	/* Synth Capture Volume + Switch */
 	for (z = 0; z < 2; z++) {
 		SWITCH(icode, &ptr, tmp + 0, 2 + z, gpr + 2 + z);
 		VOLUME_ADD(icode, &ptr, capture + z, tmp + 0, gpr + z);
 	}
-	snd_emu10k1_init_stereo_control(controls + i++, "Music Capture Volume", gpr, 0);
-	snd_emu10k1_init_stereo_onoff_control(controls + i++, "Music Capture Switch", gpr + 2, 0);
+	snd_emu10k1_init_stereo_control(controls + i++, "Synth Capture Volume", gpr, 0);
+	snd_emu10k1_init_stereo_onoff_control(controls + i++, "Synth Capture Switch", gpr + 2, 0);
 	gpr += 4;
 
 	/* Surround Digital Playback Volume (renamed later without Digital) */




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
