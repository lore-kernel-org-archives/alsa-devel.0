From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: various (mostly trivial) small cleanups
Date: Sat, 12 Mar 2005 16:04:15 -0500
Message-ID: <1110661456.7723.13.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+dfZVXPf7KOTEI/aQu5G"
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
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--=-+dfZVXPf7KOTEI/aQu5G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These patches fix a few minor issues with the emu10k1 driver that would
be good to get fixed before the ALSA 1.0.9 release.  All are 100% safe
to apply, they do not change the functionality at all.

emu10k1-improve-device-names.patch: give the subdevices descriptive
names, like "ADC Capture/Standard PCM Playback" instead of "EMU10K1" for
hw:x,0 and "Multichannel Capture/PT Playback" instead of "EMU10K1 EFX"
for hw:x,2.  Now that qjackctl enumerates the devices automatically,
this is a significant usability improvement.

remove-voice-alloc-printk.patch: silence the "BUG (or not enough
voices)" message.  This does not in fact represent a bug; it's a normal
ocurrence when the wavetable synth is in use.

The next two patches add my copyright for adding the multichannel PCM
support to emupcm.c and emumixer.c.

The final patch adds Clemens Ladisch to the copyright on timer.c, rather
than just saying "Copied from similar code by CL".  This has been
bugging me for a while, since I just copied and pasted from the ymfpci
driver & changed the registers.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-+dfZVXPf7KOTEI/aQu5G
Content-Disposition: attachment; filename=emu10k1-improve-device-names.patch
Content-Type: text/x-patch; name=emu10k1-improve-device-names.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.42
diff -u -r1.42 emupcm.c
--- alsa/alsa-kernel/pci/emu10k1/emupcm.c	9 Mar 2005 11:12:10 -0000	1.42
+++ alsa/alsa-kernel/pci/emu10k1/emupcm.c	11 Mar 2005 00:13:02 -0000
@@ -1273,7 +1273,7 @@
 
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
-	strcpy(pcm->name, "EMU10K1");
+	strcpy(pcm->name, "ADC Capture/Standard PCM Playback");
 	emu->pcm = pcm;
 
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; substream; substream = substream->next)
@@ -1308,7 +1308,7 @@
 
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
-	strcpy(pcm->name, "EMU10K1 multichannel EFX");
+	strcpy(pcm->name, "Multichannel Playback");
 	emu->pcm = pcm;
 
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; substream; substream = substream->next)
@@ -1357,7 +1357,7 @@
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_emu10k1_capture_mic_ops);
 
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "EMU10K1 MIC");
+	strcpy(pcm->name, "Mic Capture");
 	emu->pcm_mic = pcm;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
@@ -1695,7 +1695,7 @@
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_emu10k1_capture_efx_ops);
 
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "EMU10K1 EFX");
+	strcpy(pcm->name, "Multichannel Capture/PT Playback");
 	emu->pcm_efx = pcm;
 	if (rpcm)
 		*rpcm = pcm;

--=-+dfZVXPf7KOTEI/aQu5G
Content-Disposition: attachment; filename=remove-voice-alloc-printk.patch
Content-Type: text/x-patch; name=remove-voice-alloc-printk.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/voice.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/voice.c,v
retrieving revision 1.7
diff -u -r1.7 voice.c
--- alsa/alsa-kernel/pci/emu10k1/voice.c	18 Feb 2005 10:21:10 -0000	1.7
+++ alsa/alsa-kernel/pci/emu10k1/voice.c	11 Mar 2005 05:20:42 -0000
@@ -81,12 +81,8 @@
 		}
 	}
 	
-	if (first_voice == last_voice) {
-		printk("BUG (or not enough voices), number %d, next free %d!\n",
-				number,
-				emu->next_free_voice);
+	if (first_voice == last_voice)
 		return -ENOMEM;
-	}	
 	
 	for (i=0; i < number; i++) {
 		voice = &emu->voices[(first_voice + i) % NUM_G];

--=-+dfZVXPf7KOTEI/aQu5G
Content-Disposition: attachment; filename=emupcm-copyright-fix.patch
Content-Type: text/x-patch; name=emupcm-copyright-fix.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.43
diff -u -r1.43 emupcm.c
--- alsa/alsa-kernel/pci/emu10k1/emupcm.c	11 Mar 2005 16:32:21 -0000	1.43
+++ alsa/alsa-kernel/pci/emu10k1/emupcm.c	12 Mar 2005 20:48:01 -0000
@@ -2,6 +2,7 @@
  *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
  *                   Creative Labs, Inc.
  *  Routines for control of EMU10K1 chips / PCM routines
+ *  Multichannel PCM support Copyright (c) Lee Revell <rlrevell@joe-job.com>
  *
  *  BUGS:
  *    --

--=-+dfZVXPf7KOTEI/aQu5G
Content-Disposition: attachment; filename=emumixer-copyright-fix.patch
Content-Type: text/x-patch; name=emumixer-copyright-fix.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.30
diff -u -r1.30 emumixer.c
--- alsa/alsa-kernel/pci/emu10k1/emumixer.c	16 Feb 2005 10:25:36 -0000	1.30
+++ alsa/alsa-kernel/pci/emu10k1/emumixer.c	12 Mar 2005 20:50:03 -0000
@@ -3,6 +3,7 @@
  *                   Takashi Iwai <tiwai@suse.de>
  *                   Creative Labs, Inc.
  *  Routines for control of EMU10K1 chips / mixer routines
+ *  Multichannel PCM support Copyright (c) Lee Revell <rlrevell@joe-job.com>
  *
  *  BUGS:
  *    --

--=-+dfZVXPf7KOTEI/aQu5G
Content-Disposition: attachment; filename=timer-copyright-fix.patch
Content-Type: text/x-patch; name=timer-copyright-fix.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/timer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/timer.c,v
retrieving revision 1.1
diff -u -r1.1 timer.c
--- alsa/alsa-kernel/pci/emu10k1/timer.c	10 Nov 2004 09:49:12 -0000	1.1
+++ alsa/alsa-kernel/pci/emu10k1/timer.c	12 Mar 2005 20:48:16 -0000
@@ -1,10 +1,8 @@
 /*
  *  Copyright (c) by Lee Revell <rlrevell@joe-job.com>
- *  
+ *                   Clemens Ladisch <clemens@ladisch.de>
  *  Routines for control of EMU10K1 chips
  *
- *  Copied from similar code by Clemens Ladisch in the ymfpci driver
- * 
  *  BUGS:
  *    --
  *

--=-+dfZVXPf7KOTEI/aQu5G--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
