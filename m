From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: [PATCH] remove emu10k1 pops/clicks at the       beginning and
 end of playback (fwd)
Date: Sat, 05 Mar 2005 20:08:40 +0100
Message-ID: <d0cvpo$a90$1@sea.gmane.org>
References: <Pine.LNX.4.58.0503040932460.1739@pnote.perex-int.cz> <1109960235.6442.9.camel@mindpipe> <d0bqba$esi$1@sea.gmane.org> <4229925C.6020009@superbug.co.uk> <d0c5th$a56$1@sea.gmane.org> <4229C434.6090005@superbug.co.uk> <4229C630.8040600@kmlinux.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070105020202010008040707"
In-Reply-To: <4229C630.8040600@kmlinux.fjfi.cvut.cz>
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

This is a multi-part message in MIME format.
--------------070105020202010008040707
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Here is one more update of the patch. This version clears only a part of 
the cache, saving some register writes. Tested for few hours, no pops so 
far. But it might be better to use brute force anyway.

-- 
Jindrich Makovicka

--------------070105020202010008040707
Content-Type: text/plain;
 name="emupcm.c.diff3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emupcm.c.diff3"

--- emupcm.c.orig	2005-03-04 17:04:32.000000000 +0100
+++ emupcm.c	2005-03-05 14:21:36.932147794 +0100
@@ -250,6 +250,22 @@
 		return CCCA_INTERPROM_2;
 }
 
+/*
+ * calculate cache invalidate size 
+ *
+ * stereo: channel is stereo
+ * w_16: using 16bit samples
+ *
+ * returns: cache invalidate size in samples
+ */
+static int inline emu10k1_ccis(int stereo, int w_16)
+{
+	if (w_16) {
+		return stereo ? 24 : 26;
+	} else {
+		return stereo ? 24*2 : 26*2;
+	}
+}
 
 static void snd_emu10k1_pcm_init_voice(emu10k1_t *emu,
 				       int master, int extra,
@@ -304,9 +320,7 @@
 		memcpy(send_amount, &mix->send_volume[tmp][0], 8);
 	}
 
-	ccis = stereo ? 28 : 30;
-	if (w_16)
-		ccis *= 2;
+	ccis = emu10k1_ccis(stereo, w_16);
 	
 	if (master) {
 		evoice->epcm->ccca_start_addr = start_addr + ccis;
@@ -473,11 +487,14 @@
 
 	start_addr = epcm->start_addr;
 	end_addr = snd_pcm_lib_period_bytes(substream);
-	if (runtime->channels == 2)
+	if (runtime->channels == 2) {
+		start_addr >>= 1;
 		end_addr >>= 1;
+	}
 	end_addr += start_addr;
 	snd_emu10k1_pcm_init_voice(emu, 1, 1, epcm->extra,
 				   start_addr, end_addr);
+	start_addr = epcm->start_addr;
 	end_addr = epcm->start_addr + snd_pcm_lib_buffer_bytes(substream);
 	snd_emu10k1_pcm_init_voice(emu, 1, 0, epcm->voices[0],
 				   start_addr, end_addr);
@@ -598,37 +615,39 @@
 	return 0;
 }
 
-static void snd_emu10k1_playback_invalidate_cache(emu10k1_t *emu, emu10k1_voice_t *evoice)
+static void snd_emu10k1_playback_invalidate_cache(emu10k1_t *emu, int extra, emu10k1_voice_t *evoice)
 {
 	snd_pcm_runtime_t *runtime;
-	unsigned int voice, i, ccis, cra = 64, cs, sample;
+	unsigned int voice, stereo, i, ccis, cra = 64, cs, sample;
 
 	if (evoice == NULL)
 		return;
 	runtime = evoice->epcm->substream->runtime;
 	voice = evoice->number;
+	stereo = (!extra && runtime->channels == 2);
 	sample = snd_pcm_format_width(runtime->format) == 16 ? 0 : 0x80808080;
-	if (runtime->channels == 2) {
-		ccis = 28;
-		cs = 4;
-	} else {
-		ccis = 30;
-		cs = 2;
-	}
-	if (sample == 0)	/* 16-bit */
-		ccis *= 2;
-	for (i = 0; i < cs; i++)
+	ccis = emu10k1_ccis(stereo, sample == 0);
+	// set cs to 2 * number of cache registers beside the invalidated
+	cs = (sample == 0) ? (32-ccis) : (64-ccis+1) >> 1;
+	if (cs > 16) cs = 16;
+	for (i = 0; i < cs; i++) {
 		snd_emu10k1_ptr_write(emu, CD0 + i, voice, sample);
-		
+		if (stereo) {
+			snd_emu10k1_ptr_write(emu, CD0 + i, voice + 1, sample);
+		}
+	}
 	// reset cache
 	snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice, 0);
 	snd_emu10k1_ptr_write(emu, CCR_READADDRESS, voice, cra);
-	if (runtime->channels == 2) {
+	if (stereo) {
 		snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice + 1, 0);
 		snd_emu10k1_ptr_write(emu, CCR_READADDRESS, voice + 1, cra);
 	}
 	// fill cache
 	snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice, ccis);
+	if (stereo) {
+		snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice+1, ccis);
+	}
 }
 
 static void snd_emu10k1_playback_prepare_voice(emu10k1_t *emu, emu10k1_voice_t *evoice, int master, int extra)
@@ -707,8 +726,8 @@
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_emu10k1_playback_invalidate_cache(emu, epcm->extra);	/* do we need this? */
-		snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[0]);
+		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);	/* do we need this? */
+		snd_emu10k1_playback_invalidate_cache(emu, 0, epcm->voices[0]);
 		/* follow thru */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[0], 1, 0);
@@ -836,9 +855,9 @@
 	case SNDRV_PCM_TRIGGER_START:
 		// prepare voices
 		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
-			snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[i]);
+			snd_emu10k1_playback_invalidate_cache(emu, 0, epcm->voices[i]);
 		}
-		snd_emu10k1_playback_invalidate_cache(emu, epcm->extra);
+		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);
 
 		/* follow thru */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:

--------------070105020202010008040707--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
