From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: [PATCH] remove emu10k1 pops/clicks at the   beginning and end
 of playback (fwd)
Date: Sat, 05 Mar 2005 09:29:26 +0100
Message-ID: <d0bqba$esi$1@sea.gmane.org>
References: <Pine.LNX.4.58.0503040932460.1739@pnote.perex-int.cz> <1109960235.6442.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080002000600040102080205"
In-Reply-To: <1109960235.6442.9.camel@mindpipe>
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
--------------080002000600040102080205
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:
> On Fri, 2005-03-04 at 22:30 +0100, Jindrich Makovicka wrote:
> 
>>> Lee Revell wrote:
>>
>>>> > It's not that the cciss register is buggy, it's just poorly understood.
>>
>>> 
>>> I don't mean the register alone, I mean the way ALSA sets it.
>>> 
>>
>>>> > See US patent 6138207 for the exact function of the cache control
>>>> > circuitry.  I can't get my brain around it, but maybe you can.
>>>> > 
>>>> > http://patft.uspto.gov/netacgi/nph-Parser?u=/netahtml/srchnum.htm&Sect1=PTO1&Sect2=HITOFF&p=1&r=1&l=50&f=G&d=PALL&s1=6138207.WKU.&OS=PN/6138207&RS=PN/6138207
>>
>>> 
>>> Thanks for the brain food, but today I am too tired to dive in  :) 
>>> 
>>
>>>> > Have you tried leaving the cciss setting alone, and just increasing cs
>>>> > to 16, which should cause it to silence the entire cache, not just the
>>>> > beginning?
>>
>>> 
>>> When I leave cciss alone, audio still heavily pops (16bit at the end, 
>>> 8bit at the beginning). When I change cciss the way OSS driver has it, 
>>> which I believe is correct, there is still a slight pop at the end for 
>>> both. After decreasing cciss a bit (4 samples), the pop at the end seems 
>>> to be gone. Unfortunately I cannot test it on other cards than my SB 1024.
>>> 
>>> My current patch is attached (applies to 2.6.11-mm1). I also moved cciss 
>>> setting to one place and made invalidate_cache honor the "extra" flag - 
>>> if extra is on, it does not invalidate the second channel.
>>> 
> 
> 
> OK, sounds good.
> 
> You will have to generate the patch against ALSA CVS.  This will require
> updating it to support the multichannel device, which is made up of 16
> mono channels, 16 bit, 48KHz only  (plus an extra voice for timing).
> Should be easy.
> 
> Then, repost it to alsa-devel.

So, as the the above patch appeared to be rather a proof of concept, 
here is the (hopefully) correct fix. It changes the following:

- CCIS setting, which was previously "upside down" is fixed and modified 
to supress the pop at the end

- CCIS values are now in one spot to allow tweaking

- invalidate_cache now purges complete cache for both channels.

Big thanks to Lee for his advices.

I don't see any reason the patch shouldn't apply to CVS, as the only 
change with wider impact is in invalidate_cache arguments, and all 
callers are updated.

Best regards,
-- 
Jindrich Makovicka

--------------080002000600040102080205
Content-Type: text/plain;
 name="emupcm.c.diff2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emupcm.c.diff2"

--- emupcm.c.orig	2005-03-02 09:40:37.000000000 +0100
+++ emupcm.c	2005-03-05 09:13:09.074485436 +0100
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
@@ -598,7 +615,7 @@
 	return 0;
 }
 
-static void snd_emu10k1_playback_invalidate_cache(emu10k1_t *emu, emu10k1_voice_t *evoice)
+static void snd_emu10k1_playback_invalidate_cache(emu10k1_t *emu, int extra, emu10k1_voice_t *evoice)
 {
 	snd_pcm_runtime_t *runtime;
 	unsigned int voice, i, ccis, cra = 64, cs, sample;
@@ -608,27 +625,26 @@
 	runtime = evoice->epcm->substream->runtime;
 	voice = evoice->number;
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
+	cs = 16;
+	ccis = emu10k1_ccis(!extra && runtime->channels == 2, sample == 0);
+	for (i = 0; i < cs; i++) {
 		snd_emu10k1_ptr_write(emu, CD0 + i, voice, sample);
-		
+		if (!extra && runtime->channels == 2) {
+			snd_emu10k1_ptr_write(emu, CD0 + i, voice + 1, sample);
+		}
+	}
 	// reset cache
 	snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice, 0);
 	snd_emu10k1_ptr_write(emu, CCR_READADDRESS, voice, cra);
-	if (runtime->channels == 2) {
+	if (!extra && runtime->channels == 2) {
 		snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice + 1, 0);
 		snd_emu10k1_ptr_write(emu, CCR_READADDRESS, voice + 1, cra);
 	}
 	// fill cache
 	snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice, ccis);
+	if (!extra && runtime->channels == 2) {
+		snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice+1, ccis);
+	}
 }
 
 static void snd_emu10k1_playback_prepare_voice(emu10k1_t *emu, emu10k1_voice_t *evoice, int master, int extra)
@@ -707,8 +723,8 @@
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
@@ -836,9 +852,9 @@
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

--------------080002000600040102080205--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
