From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] audigyls.c updated to version 0.0.14
Date: Thu, 22 Jul 2004 14:41:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40FFC422.6030809@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070108060000040206000604"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 20066240
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2004 15:41:56 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-33.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1Bndpa-0003C7-0X
	for alsa-devel@alsa-project.org; Thu, 22 Jul 2004 14:41:54 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070108060000040206000604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch against the alsa-driver cvs for the AudigyLS.
There is also a patch for alsa-lib AudigyLS.conf file.

Changelog:
0.0.12
   Correct interrupt timing. interrupt at end of period,
   instead of in the middle of a playback period.
   Remove redundent "voice" handling.
0.0.13
   Single trigger call for multi channels.
0.0.14
   Set limits based on what the sound card hardware can do.
   playback periods_min=2, periods_max=8
   capture hw constraints require period_size = n * 64 bytes.
   playback hw constraints require period_size = n * 64 bytes.




--------------070108060000040206000604
Content-Type: text/plain;
 name="alsa-lib.audigyls.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib.audigyls.diff.txt"

Index: alsa-lib/src/conf/cards/AudigyLS.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/AudigyLS.conf,v
retrieving revision 1.3
diff -u -r1.3 AudigyLS.conf
--- alsa-lib/src/conf/cards/AudigyLS.conf	28 Jun 2004 10:26:45 -0000	1.3
+++ alsa-lib/src/conf/cards/AudigyLS.conf	22 Jul 2004 13:36:38 -0000
@@ -152,14 +152,14 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "PCM Front Volume"
+				name "SPDIF Front Volume"
 				index 0
 				lock true
 				preserve true
 				value [ 207 207 ]   # Puts 0x30303030 in the Volume register. 0xff - 0x30 = 0xcf = 207
 			}
 			{
-				name "Analog/Digital Output Jack"
+				name "SPDIF Out"
 				lock true
 				preserve true
 				value 0

--------------070108060000040206000604
Content-Type: text/plain;
 name="alsa-driver.audigyls.c.0.0.14.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver.audigyls.c.0.0.14.diff.txt"

Index: alsa-driver/pci/emu10k1/audigyls.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/audigyls.c,v
retrieving revision 1.9
diff -u -r1.9 audigyls.c
--- alsa-driver/pci/emu10k1/audigyls.c	12 Jul 2004 14:27:12 -0000	1.9
+++ alsa-driver/pci/emu10k1/audigyls.c	22 Jul 2004 13:23:06 -0000
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) by James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver AUDIGYLS chips
- *  Version: 0.0.11
+ *  Version: 0.0.14
  *
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
@@ -50,9 +50,19 @@
  *    Fix AC3 output.
  *    Enable S32_LE format support.
  *  0.0.10
- *    Enable 48000 and 96000 rates. (Rates other that these do not work, even with "plug:front".)
+ *    Enable playback 48000 and 96000 rates. (Rates other that these do not work, even with "plug:front".)
  *  0.0.11
  *    Add Model name recognition.
+ *  0.0.12
+ *    Correct interrupt timing. interrupt at end of period, instead of in the middle of a playback period.
+ *    Remove redundent "voice" handling.
+ *  0.0.13
+ *    Single trigger call for multi channels.
+ *  0.0.14
+ *    Set limits based on what the sound card hardware can do.
+ *    playback periods_min=2, periods_max=8
+ *    capture hw constraints require period_size = n * 64 bytes.
+ *    playback hw constraints require period_size = n * 64 bytes.
  *
  *  BUGS:
  *    Some stability problems when unloading the snd-audigyls kernel module.
@@ -60,7 +70,7 @@
  *
  *  TODO:
  *    4 Capture channels, only one implemented so far.
- *    Other rates apart from 48khz not implemented.
+ *    Other capture rates apart from 48khz not implemented.
  *    MIDI
  *    --
  *  GENERAL INFO:
@@ -145,8 +155,11 @@
 #define HCFG			0x14		/* Hardware config register			*/
 						/* 0x1000 causes AC3 to fails. Maybe it effects 24 bit output. */
 
-#define HCFG_8_CHANNEL		0x00000200	/* 1 = 8 channels, 0 = 2 channels per substream. */
-#define HCFG_S32_LE		0x00000800	/* 1 = S32_LE, 0 = S16_LE */
+#define HCFG_24KHZ_CAPTURE	0x10000000	/* Set 24khz capture rate. */
+#define HCFG_8_CHANNEL_CAPTURE	0x00000100	/* 1 = 8 channels, 0 = 2 channels per substream.*/
+#define HCFG_8_CHANNEL_PLAY	0x00000200	/* 1 = 8 channels, 0 = 2 channels per substream.*/
+#define HCFG_CAPTURE_MUTE	0x00000400	/* 1 = Mute caputre, 0 = capture normal.        */
+#define HCFG_S32_LE		0x00000800	/* 1 = S32_LE, 0 = S16_LE                       */
 #define HCFG_LOCKSOUNDCACHE	0x00000008	/* 1 = Cancel bustmaster accesses to soundcache */
 						/* NOTE: This should generally never be used.  	*/
 #define HCFG_AUDIOENABLE	0x00000001	/* 0 = CODECs transmit zero-valued samples	*/
@@ -186,6 +199,7 @@
 #define BASIC_INTERRUPT         0x40		/* Used by both playback and capture interrupt handler */
 						/* Playback (0x1<<channel_id) */
 						/* Capture  (0x100<<channel_id) */
+						/* Playback sample rate 96000 = 0x20000 */
 /* The Digital out jack is shared with the Center/LFE Analogue output. 
  * The jack has 4 poles. I will call 1 - Tip, 2 - Next to 1, 3 - Next to 2, 4 - Next to 3
  * For Analogue: 1 -> Center Speaker, 2 -> Sub Woofer, 3 -> Ground, 4 -> Ground
@@ -247,8 +261,8 @@
 #define CAPTURE_SOURCE_CHANNEL3 0x000f0000	/* 3 - Mic in, Line in, TAD in, Aux in. */
 #define CAPTURE_SOURCE_LOOPBACK 0x0000ffff	/* Default 0x00e4 */
 
-#define CAPTURE_VOLUME1         0x61            /* Capture  volume per voice */
-#define CAPTURE_VOLUME2         0x62            /* Capture  volume per voice */
+#define CAPTURE_VOLUME1         0x61            /* Capture  volume per channel */
+#define CAPTURE_VOLUME2         0x62            /* Capture  volume per channel */
 
 #define PLAYBACK_ROUTING1       0x63            /* Playback routing. Effects AC3 output. Default 0x32765410 */
 #define ROUTING1_REAR           0x77000000      /* Channel_id 0 sends to 10, Channel_id 1 sends to 32 */
@@ -258,12 +272,12 @@
 
 #define PLAYBACK_ROUTING2       0x64            /* Unknown Routing. Effects AC3 output. Default 0x76767676 */
 #define PLAYBACK_MUTE           0x65            /* Unknown. While playing 0x0, while silent 0x00fc0000 */
-#define PLAYBACK_VOLUME1        0x66            /* Playback volume per voice. Set to the same PLAYBACK_VOLUME(0x6a) */
+#define PLAYBACK_VOLUME1        0x66            /* Playback volume per channel. Set to the same PLAYBACK_VOLUME(0x6a) */
 						/* PLAYBACK_VOLUME1 must be set to 30303030 for SPDIF AC3 Playback */
 #define CAPTURE_ROUTING1        0x67            /* Playback Routing. Default 0x32765410 */
 #define CAPTURE_ROUTING2        0x68            /* Unknown Routing. Default 0x76767676 */
 #define CAPTURE_MUTE            0x69            /* Unknown. While capturing 0x0, while silent 0x00fc0000 */
-#define PLAYBACK_VOLUME2        0x6a            /* Playback volume per voice. Does not effect AC3 output */
+#define PLAYBACK_VOLUME2        0x6a            /* Playback volume per channel. Does not effect AC3 output */
 #define UNKNOWN6b               0x6b            /* Unknown. Readonly. Default 00400000 00400000 00400000 00400000 */
 #define UART1                   0x6c            /* Uart, used in setting sample rates, bits per sample etc. */
 #define UART2                   0x6d            /* Uart, used in setting sample rates, bits per sample etc. */
@@ -281,8 +295,20 @@
 #define CHIP_VERSION            0x74            /* P17 Chip version. Channel_id 0 only. Default 00000071 */
 #define EXTENDED_INT_MASK       0x75            /* Used by both playback and capture interrupt handler */
 						/* Sets which Interrupts are enabled. */
+						/* 0x00000001 = Half period. Playback.
+						 * 0x00000010 = Full period. Playback.
+						 * 0x00010000 = Half buffer. Capture.
+						 * 0x00100000 = Full buffer. Capture.
+						 * Capture can only do 2 periods.
+						 */
 #define EXTENDED_INT            0x76            /* Used by both playback and capture interrupt handler */
 						/* Shows which interrupts are active at the moment. */
+						/* 0x00000001 = Half period. Playback.
+						 * 0x00000010 = Full period. Playback.
+						 * 0x00010000 = Half buffer. Capture.
+						 * 0x00100000 = Full buffer. Capture.
+						 * Capture can only do 2 periods.
+						 */
 #define COUNTER77               0x77		/* Counter range 0 to 0x3fffff, 192000 counts per second. */
 #define COUNTER78               0x78		/* Counter range 0 to 0x3fffff, 44100 counts per second. */
 #define EXTENDED_INT_TIMER      0x79            /* Channel_id 0 only. Used by both playback and capture interrupt handler */
@@ -297,20 +323,10 @@
 #define CONTROL_CENTER_LFE_CHANNEL 1
 #define CONTROL_UNKNOWN_CHANNEL 2
 
-typedef struct snd_audigyls_voice audigyls_voice_t;
 typedef struct snd_audigyls_channel audigyls_channel_t;
 typedef struct snd_audigyls audigyls_t;
 typedef struct snd_audigyls_pcm audigyls_pcm_t;
 
-struct snd_audigyls_voice {
-	audigyls_t *emu;
-	int number;
-	int use;
-	void (*interrupt)(audigyls_t *emu, audigyls_voice_t *pvoice);
-  
-	audigyls_pcm_t *epcm;
-};
-
 struct snd_audigyls_channel {
 	audigyls_t *emu;
 	int number;
@@ -323,7 +339,6 @@
 struct snd_audigyls_pcm {
 	audigyls_t *emu;
 	snd_pcm_substream_t *substream;
-	audigyls_voice_t *voice;
         int channel_id;
 	unsigned short running;
 };
@@ -352,12 +367,10 @@
 	unsigned short model;		/* subsystem id */
 
 	spinlock_t emu_lock;
-	spinlock_t voice_lock;
 
 	ac97_t *ac97;
 	snd_pcm_t *pcm;
 
-	audigyls_voice_t voices[4];
 	audigyls_channel_t channels[4];
 	audigyls_channel_t capture_channel;
 	u32 spdif_bits[4];             /* s/pdif out setup */
@@ -384,7 +397,7 @@
 	.period_bytes_min =	64,
 	.period_bytes_max =	(16*1024),
 	.periods_min =		2,
-	.periods_max =		16,
+	.periods_max =		8,
 	.fifo_size =		0,
 };
 
@@ -450,54 +463,6 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
-static int voice_alloc(audigyls_t *emu, audigyls_voice_t **rvoice)
-{
-	audigyls_voice_t *voice;
-	int idx;
-
-	*rvoice = NULL;
-	for (idx = 0; idx < 4; idx ++) {
-		voice = &emu->voices[idx];
-		if (voice->use)
-			continue;
-		voice->use = 1;
-		*rvoice = voice;
-		return 0;
-	}
-	return -ENOMEM;
-}
-
-static int snd_audigyls_voice_alloc(audigyls_t *emu, audigyls_voice_t **rvoice)
-{
-	unsigned long flags;
-	int result;
-  
-	snd_assert(rvoice != NULL, return -EINVAL);
-
-	spin_lock_irqsave(&emu->voice_lock, flags);
-  
-	result = voice_alloc(emu, rvoice);
-
-	spin_unlock_irqrestore(&emu->voice_lock, flags);
-  
-	return result;
-}
-
-static int snd_audigyls_voice_free(audigyls_t *emu, audigyls_voice_t *pvoice)
-{
-	unsigned long flags;
-  
-	snd_assert(pvoice != NULL, return -EINVAL);
-	spin_lock_irqsave(&emu->voice_lock, flags);
-
-	pvoice->interrupt = NULL;
-	pvoice->use = 0;
-	pvoice->epcm = NULL;
-
-	spin_unlock_irqrestore(&emu->voice_lock, flags);
-	return 0;
-}
-
 static void snd_audigyls_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
 	audigyls_pcm_t *epcm = runtime->private_data;
@@ -507,30 +472,6 @@
 	}
 }
 
-static void snd_audigyls_pcm_interrupt(audigyls_t *emu, audigyls_voice_t *voice)
-{
-	audigyls_pcm_t *epcm;
-  
-	if ((epcm = voice->epcm) == NULL)
-		return;
-	if (epcm->substream == NULL)
-		return;
-	snd_pcm_period_elapsed(epcm->substream);
-}
-
-#if 0  /* not used */
-static void snd_audigyls_pcm_channel_interrupt(audigyls_t *emu, audigyls_voice_t *voice)
-{
-	audigyls_pcm_t *epcm;
-	if ((epcm = voice->epcm) == NULL)
-		return;
-	if (epcm->substream == NULL)
-		return;
-	snd_pcm_period_elapsed(epcm->substream);
-}
-#endif
-
-
 /* open_playback callback */
 static int snd_audigyls_pcm_open_playback_channel(snd_pcm_substream_t *substream, int channel_id)
 {
@@ -538,6 +479,7 @@
         audigyls_channel_t *channel = &(chip->channels[channel_id]);
 	audigyls_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
+	int err;
 
 	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
 
@@ -559,6 +501,10 @@
         //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
         //channel->interrupt = snd_audigyls_pcm_channel_interrupt;
         channel->epcm=epcm;
+	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+                return err;
+	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
+                return err;
 	return 0;
 }
 
@@ -600,6 +546,7 @@
         audigyls_channel_t *channel = &(chip->capture_channel);
 	audigyls_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
+	int err;
 
 	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL) {
@@ -622,6 +569,11 @@
         //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
         //channel->interrupt = snd_audigyls_pcm_channel_interrupt;
         channel->epcm=epcm;
+	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+                return err;
+	//snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
+	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
+                return err;
 	return 0;
 }
 
@@ -645,17 +597,6 @@
 static int snd_audigyls_pcm_hw_params_playback(snd_pcm_substream_t *substream,
 				      snd_pcm_hw_params_t * hw_params)
 {
-	int err;
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	audigyls_pcm_t *epcm = runtime->private_data;
-
-	if (! epcm->voice) {
-		if ((err = snd_audigyls_voice_alloc(epcm->emu, &epcm->voice)) < 0)
-			return err;
-		epcm->voice->epcm = epcm;
-		epcm->voice->interrupt = snd_audigyls_pcm_interrupt;
-	}
-
 	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
 }
@@ -663,18 +604,6 @@
 /* hw_free callback */
 static int snd_audigyls_pcm_hw_free_playback(snd_pcm_substream_t *substream)
 {
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	audigyls_pcm_t *epcm;
-
-	if (runtime->private_data == NULL)
-		return 0;
-	epcm = runtime->private_data;
-
-	if (epcm->voice) {
-		snd_audigyls_voice_free(epcm->emu, epcm->voice);
-		epcm->voice = NULL;
-	}
-
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -689,11 +618,6 @@
 /* hw_free callback */
 static int snd_audigyls_pcm_hw_free_capture(snd_pcm_substream_t *substream)
 {
-	snd_pcm_runtime_t *runtime = substream->runtime;
-
-	if (runtime->private_data == NULL)
-		return 0;
-
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -703,8 +627,8 @@
 	audigyls_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	audigyls_pcm_t *epcm = runtime->private_data;
-	int voice = voice=epcm->channel_id;
-	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*voice));
+	int channel = epcm->channel_id;
+	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*channel));
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
 	u32 hcfg_mask = 0x00000800; /* We only know what bits 17 and 19 do. */
 	u32 hcfg_set = 0x00000000;
@@ -714,7 +638,7 @@
 	u32 reg40;
 	int i;
 	
-        snd_printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
+        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
         //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
 	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
 	switch (runtime->rate) {
@@ -752,14 +676,14 @@
 		table_base[(i*2)+1]=period_size_bytes<<16;
 	}
  
-	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_ADDR, voice, emu->buffer.addr+(8*16*voice));
-	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_SIZE, voice, (runtime->periods - 1) << 19);
-	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_PTR, voice, 0);
-	snd_audigyls_ptr_write(emu, PLAYBACK_DMA_ADDR, voice, runtime->dma_addr);
-	snd_audigyls_ptr_write(emu, PLAYBACK_PERIOD_SIZE, voice, frames_to_bytes(runtime, runtime->period_size)<<16); // buffer size in bytes
-	snd_audigyls_ptr_write(emu, PLAYBACK_POINTER, voice, 0);
-	snd_audigyls_ptr_write(emu, 0x07, voice, 0x0);
-	snd_audigyls_ptr_write(emu, 0x08, voice, 0);
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_ADDR, channel, emu->buffer.addr+(8*16*channel));
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_SIZE, channel, (runtime->periods - 1) << 19);
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_PTR, channel, 0);
+	snd_audigyls_ptr_write(emu, PLAYBACK_DMA_ADDR, channel, runtime->dma_addr);
+	snd_audigyls_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, frames_to_bytes(runtime, runtime->period_size)<<16); // buffer size in bytes
+	snd_audigyls_ptr_write(emu, PLAYBACK_POINTER, channel, 0);
+	snd_audigyls_ptr_write(emu, 0x07, channel, 0x0);
+	snd_audigyls_ptr_write(emu, 0x08, channel, 0);
         snd_audigyls_ptr_write(emu, PLAYBACK_MUTE, 0x0, 0x0); /* Unmute output */
 #if 0
 	snd_audigyls_ptr_write(emu, SPCS0, 0,
@@ -769,10 +693,6 @@
 			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT );
 	}
 #endif
-	//snd_audigyls_ptr_write(emu, SPCS0, 0, 0x2108006);
-	//snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, 0x33); /* Routing of some sort */
-	//snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, 0x11 << voice); /* Routing of some sort */
-	snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) | (0x11<<voice));
 
 	return 0;
 }
@@ -783,14 +703,12 @@
 	audigyls_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	audigyls_pcm_t *epcm = runtime->private_data;
-	int voice = epcm->voice->number;
-        voice=epcm->channel_id;
-        //printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
-	snd_audigyls_ptr_write(emu, 0x13, voice, 0);
-	snd_audigyls_ptr_write(emu, CAPTURE_DMA_ADDR, voice, runtime->dma_addr);
-	snd_audigyls_ptr_write(emu, CAPTURE_BUFFER_SIZE, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
-	snd_audigyls_ptr_write(emu, CAPTURE_POINTER, voice, 0);
-	snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) | (0x110000<<voice));
+	int channel = epcm->channel_id;
+        //printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
+	snd_audigyls_ptr_write(emu, 0x13, channel, 0);
+	snd_audigyls_ptr_write(emu, CAPTURE_DMA_ADDR, channel, runtime->dma_addr);
+	snd_audigyls_ptr_write(emu, CAPTURE_BUFFER_SIZE, channel, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
+	snd_audigyls_ptr_write(emu, CAPTURE_POINTER, channel, 0);
 
 	return 0;
 }
@@ -800,21 +718,46 @@
 				    int cmd)
 {
 	audigyls_t *emu = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	audigyls_pcm_t *epcm = runtime->private_data;
-	int channel = epcm->voice->number;
+	snd_pcm_runtime_t *runtime;
+	audigyls_pcm_t *epcm;
+	int channel;
 	int result = 0;
-        channel=epcm->channel_id;
+	struct list_head *pos;
+        snd_pcm_substream_t *s;
+	u32 basic = 0;
+	u32 extended = 0;
+	int running=0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0)|(0x1<<channel));
-		epcm->running = 1;
+		running=1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0) & ~(0x1<<channel));
-		snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) & ~(0x11<<channel));
-		epcm->running = 0;
+	default:
+		running=0;
+		break;
+	}
+        snd_pcm_group_for_each(pos, substream) {
+                s = snd_pcm_group_substream_entry(pos);
+		runtime = s->runtime;
+		epcm = runtime->private_data;
+		channel = epcm->channel_id;
+		//snd_printk("channel=%d\n",channel);
+		epcm->running = running;
+		basic |= (0x1<<channel);
+		extended |= (0x10<<channel);
+                snd_pcm_trigger_done(s, substream);
+        }
+	//snd_printk("basic=0x%x, extended=0x%x\n",basic, extended);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) | (extended));
+		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0)|(basic));
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0) & ~(basic));
+		snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) & ~(extended));
 		break;
 	default:
 		result = -EINVAL;
@@ -830,12 +773,12 @@
 	audigyls_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	audigyls_pcm_t *epcm = runtime->private_data;
-	int channel = epcm->voice->number;
+	int channel = epcm->channel_id;
 	int result = 0;
-        channel=epcm->channel_id;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) | (0x110000<<channel));
 		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0)|(0x100<<channel));
 		epcm->running = 1;
 		break;
@@ -859,8 +802,7 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	audigyls_pcm_t *epcm = runtime->private_data;
 	snd_pcm_uframes_t ptr, ptr1, ptr2,ptr3,ptr4 = 0;
-	int channel = epcm->voice->number;
-        channel=epcm->channel_id;
+	int channel = epcm->channel_id;
 
 	if (!epcm->running)
 		return 0;
@@ -887,8 +829,7 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	audigyls_pcm_t *epcm = runtime->private_data;
 	snd_pcm_uframes_t ptr, ptr1, ptr2 = 0;
-	int channel = epcm->voice->number;
-        channel=epcm->channel_id;
+	int channel = channel=epcm->channel_id;
 
 	if (!epcm->running)
 		return 0;
@@ -1064,8 +1005,9 @@
 	if (! status)
 		return IRQ_NONE;
 
-	//printk(KERN_INFO "interrupt status = %08x, chip=%p, channel=%p\n", status,chip, chip->channels);
         stat76 = snd_audigyls_ptr_read(chip, EXTENDED_INT, 0);
+	//snd_printk("interrupt status = 0x%08x, stat76=0x%08x\n", status, stat76);
+	//snd_printk("ptr=0x%08x\n",snd_audigyls_ptr_read(chip, PLAYBACK_POINTER, 0));
 	//mask = IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP;
         mask = 0x11; /* 0x1 for one half, 0x10 for the other half period. */
 	for(i = 0; i < 4; i++) {
@@ -1076,8 +1018,6 @@
                           snd_pcm_period_elapsed(pchannel->epcm->substream);
 	                //printk(KERN_INFO "interrupt [%d] used\n", i);
                         }
-			//if(pvoice->use && pvoice->interrupt)
-		//		pvoice->interrupt(chip, pvoice);
 		}
 	        //printk(KERN_INFO "channel=%p\n",pchannel);
 	        //printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number);
@@ -1199,7 +1139,6 @@
 	chip->irq = -1;
 
 	spin_lock_init(&chip->emu_lock);
-	spin_lock_init(&chip->voice_lock);
   
 	chip->port = pci_resource_start(pci, 0);
 	if ((chip->res_port = request_region(chip->port, 0x20,
@@ -1239,11 +1178,6 @@
 
 	outl(0, chip->port + INTE);
 
-	for(ch = 0; ch < 4; ch++) {
-		chip->voices[ch].emu = chip;
-		chip->voices[ch].number = ch;
-	}
-
 	/*
 	 *  Init to 0x02109204 :
 	 *  Clock accuracy    = 0     (1000ppm)
@@ -1317,6 +1251,8 @@
 	for(ch = 0; ch < 4; ch++) {
 		snd_audigyls_ptr_write(chip, CAPTURE_VOLUME1, ch, 0x30303030); /* Only high 16 bits matter */
 		snd_audigyls_ptr_write(chip, CAPTURE_VOLUME2, ch, 0x30303030);
+		//snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0x40404040); /* Mute */
+		//snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0x40404040); /* Mute */
 		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0xffffffff); /* Mute */
 		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0xffffffff); /* Mute */
 	}

--------------070108060000040206000604--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
