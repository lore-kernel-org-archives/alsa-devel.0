From: Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] remove emu10k1 pops/clicks at the beginning and end of
 playback (fwd)
Date: Fri, 4 Mar 2005 09:33:34 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503040932460.1739@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=------------000006000700020707070806
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CA33819D
	for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2005 09:43:53 +0100 (MET)
Content-ID: <Pine.LNX.4.58.0503040932490.1739@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------000006000700020707070806
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.58.0503040932491.1739@pnote.perex-int.cz>

Hi,

	could emu10k1 hackers review this patch?

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

---------- Forwarded message ----------
Date: Fri, 04 Mar 2005 09:17:15 +0100
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
To: perex@suse.cz
Subject: [PATCH] remove emu10k1 pops/clicks at the beginning and end of
    playback

Hello,

I experienced very annoying pops and clicks et the end (and sometimes at 
the beginning) of audio playback with ALSA. This is especially bad for 
UI sounds like instant mesaging beeps.

I don't know emu10k architecture much, but there seems to be a bug with 
buffer setup for 16bit samples (as the pop doesn't occur for 8bit) - 
this causes the pop at the end, and also improper purging of the cache - 
which causes a pop at the beginning when playing 16bit sample after an 
8bit one and vice versa.

The attached patch fixes the issue for me. It changes the calculation of 
the start address offset for 16bit samples (previously it was multiplied 
by 2, while the start and end addresses were divided), and it purges all 
cache registers for both channels in invalidate_cache.

Best regards,
-- 
Jindrich Makovicka
--------------000006000700020707070806
Content-Type: TEXT/X-PATCH; NAME="emupcm.c.patch"
Content-ID: <Pine.LNX.4.58.0503040932492.1739@pnote.perex-int.cz>
Content-Description: 
Content-Disposition: INLINE; FILENAME="emupcm.c.patch"

--- emupcm.c.orig	2005-03-01 11:18:37.000000000 +0100
+++ emupcm.c	2005-03-03 23:28:07.158769431 +0100
@@ -276,7 +276,7 @@
 	if (master) {
 		unsigned int ccis = stereo ? 28 : 30;
 		if (w_16)
-			ccis *= 2;
+			ccis >>= 1;
 		evoice->epcm->ccca_start_addr = start_addr + ccis;
 		if (extra) {
 			start_addr += ccis;
@@ -490,15 +490,19 @@
 	sample = snd_pcm_format_width(runtime->format) == 16 ? 0 : 0x80808080;
 	if (runtime->channels > 1) {
 		ccis = 28;
-		cs = 4;
+		cs = 16;
 	} else {
 		ccis = 30;
-		cs = 2;
+		cs = 16;
 	}
 	if (sample == 0)	/* 16-bit */
 		ccis *= 2;
-	for (i = 0; i < cs; i++)
-		snd_emu10k1_ptr_write(emu, CD0 + i, voice, sample);
+	for (i = 0; i < cs; i++) {
+    		snd_emu10k1_ptr_write(emu, CD0 + i, voice, sample);
+    		if (runtime->channels > 1) {
+        		snd_emu10k1_ptr_write(emu, CD0 + i, voice + 1, sample);
+		}
+	}
 	// reset cache
 	snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice, 0);
 	snd_emu10k1_ptr_write(emu, CCR_READADDRESS, voice, cra);
@@ -508,6 +512,9 @@
 	}
 	// fill cache
 	snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice, ccis);
+	if (runtime->channels > 1) {
+		snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice + 1, ccis);
+	}
 }
 
 static void snd_emu10k1_playback_prepare_voice(emu10k1_t *emu, emu10k1_voice_t *evoice, int master, int extra)

--------------000006000700020707070806--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
