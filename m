From: andi@lisas.de
Subject: [patch 5/6] sound azt3328: use proper private_data
 hookup for codec identification
Date: Mon, 27 Dec 2010 21:17:26 +0100
Message-ID: <20101227201726.GF28432@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 273AC24701
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 21:17:27 +0100 (CET)
Content-Disposition: inline; filename=codec_modularity_etc
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

ChangeLog:
- much improved implementation due to clean codec hierarchy
- preparation for potential per-codec spinlock change

NOTE: additionally removes a chip->pcm[codec_type] NULL ptr check
(due to it requiring access to external chip struct),
however I believe this to be ok since this condition should not occur
and most drivers don't check against that either.

Signed-off-by: Andreas Mohr <andi@lisas.de>

Index: linux-2.6/sound/pci/azt3328.c
===================================================================
--- linux-2.6.orig/sound/pci/azt3328.c	2010-12-27 14:29:18.816184335 -0500
+++ linux-2.6/sound/pci/azt3328.c	2010-12-27 14:29:21.132851001 -0500
@@ -292,14 +292,6 @@ static int seqtimer_scaling = 128;
 module_param(seqtimer_scaling, int, 0444);
 MODULE_PARM_DESC(seqtimer_scaling, "Set 1024000Hz sequencer timer scale factor (lockup danger!). Default 128.");
 
-struct snd_azf3328_codec_data {
-	unsigned long io_base;
-	unsigned int dma_base; /* helper to avoid an indirection in hotpath */
-	struct snd_pcm_substream *substream;
-	bool running;
-	const char *name;
-};
-
 enum snd_azf3328_codec_type {
   /* warning: fixed indices (also used for bitmask checks!) */
   AZF_CODEC_PLAYBACK = 0,
@@ -307,6 +299,16 @@ enum snd_azf3328_codec_type {
   AZF_CODEC_I2S_OUT = 2,
 };
 
+struct snd_azf3328_codec_data {
+	unsigned long io_base; /* keep first! (avoid offset calc) */
+	unsigned int dma_base; /* helper to avoid an indirection in hotpath */
+	spinlock_t *lock; /* TODO: convert to our own per-codec lock member */
+	struct snd_pcm_substream *substream;
+	bool running;
+	enum snd_azf3328_codec_type type;
+	const char *name;
+};
+
 struct snd_azf3328 {
 	/* often-used fields towards beginning, then grouped */
 
@@ -949,15 +951,13 @@ snd_azf3328_hw_free(struct snd_pcm_subst
 }
 
 static void
-snd_azf3328_codec_setfmt(struct snd_azf3328 *chip,
-			       enum snd_azf3328_codec_type codec_type,
+snd_azf3328_codec_setfmt(struct snd_azf3328_codec_data *codec,
 			       enum azf_freq_t bitrate,
 			       unsigned int format_width,
 			       unsigned int channels
 )
 {
 	unsigned long flags;
-	const struct snd_azf3328_codec_data *codec = &chip->codecs[codec_type];
 	u16 val = 0xff00;
 	u8 freq = 0;
 
@@ -1007,7 +1007,7 @@ snd_azf3328_codec_setfmt(struct snd_azf3
 	if (format_width == 16)
 		val |= SOUNDFORMAT_FLAG_16BIT;
 
-	spin_lock_irqsave(&chip->reg_lock, flags);
+	spin_lock_irqsave(codec->lock, flags);
 
 	/* set bitrate/format */
 	snd_azf3328_codec_outw(codec, IDX_IO_CODEC_SOUNDFORMAT, val);
@@ -1020,7 +1020,7 @@ snd_azf3328_codec_setfmt(struct snd_azf3
 	 * FIXME: does this have some side effects for full-duplex
 	 * or other dramatic side effects? */
 	/* do it for non-capture codecs only */
-	if (codec_type == AZF_CODEC_PLAYBACK)
+	if (codec->type != AZF_CODEC_CAPTURE)
 		snd_azf3328_codec_outw(codec, IDX_IO_CODEC_DMA_FLAGS,
 			snd_azf3328_codec_inw(codec, IDX_IO_CODEC_DMA_FLAGS) |
 			DMA_RUN_SOMETHING1 |
@@ -1030,20 +1030,19 @@ snd_azf3328_codec_setfmt(struct snd_azf3
 			DMA_SOMETHING_ELSE
 		);
 
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	spin_unlock_irqrestore(codec->lock, flags);
 	snd_azf3328_dbgcallleave();
 }
 
 static inline void
-snd_azf3328_codec_setfmt_lowpower(struct snd_azf3328 *chip,
-			    enum snd_azf3328_codec_type codec_type
+snd_azf3328_codec_setfmt_lowpower(struct snd_azf3328_codec_data *codec
 )
 {
 	/* choose lowest frequency for low power consumption.
 	 * While this will cause louder noise due to rather coarse frequency,
 	 * it should never matter since output should always
 	 * get disabled properly when idle anyway. */
-	snd_azf3328_codec_setfmt(chip, codec_type, AZF_FREQ_4000, 8, 1);
+	snd_azf3328_codec_setfmt(codec, AZF_FREQ_4000, 8, 1);
 }
 
 static void
@@ -1117,23 +1116,18 @@ snd_azf3328_ctrl_codec_activity(struct s
 		/* ...and adjust clock, too
 		 * (reduce noise and power consumption) */
 		if (!enable)
-			snd_azf3328_codec_setfmt_lowpower(
-				chip,
-				codec_type
-			);
+			snd_azf3328_codec_setfmt_lowpower(codec);
 		codec->running = enable;
 	}
 }
 
 static void
-snd_azf3328_codec_setdmaa(struct snd_azf3328 *chip,
-				enum snd_azf3328_codec_type codec_type,
+snd_azf3328_codec_setdmaa(struct snd_azf3328_codec_data *codec,
 				unsigned long addr,
 				unsigned int count,
 				unsigned int size
 )
 {
-	const struct snd_azf3328_codec_data *codec = &chip->codecs[codec_type];
 	snd_azf3328_dbgcallenter();
 	if (!codec->running) {
 		/* AZF3328 uses a two buffer pointer DMA transfer approach */
@@ -1152,22 +1146,22 @@ snd_azf3328_codec_setdmaa(struct snd_azf
 
 		/* build combined I/O buffer length word */
 		lengths = (count_areas << 16) | (count_areas);
-		spin_lock_irqsave(&chip->reg_lock, flags);
+		spin_lock_irqsave(codec->lock, flags);
 		snd_azf3328_codec_outl(codec, IDX_IO_CODEC_DMA_START_1, addr);
 		snd_azf3328_codec_outl(codec, IDX_IO_CODEC_DMA_START_2,
 								addr_area2);
 		snd_azf3328_codec_outl(codec, IDX_IO_CODEC_DMA_LENGTHS,
 								lengths);
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
+		spin_unlock_irqrestore(codec->lock, flags);
 	}
 	snd_azf3328_dbgcallleave();
 }
 
 static int
-snd_azf3328_codec_prepare(struct snd_pcm_substream *substream)
+snd_azf3328_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_azf3328_codec *codec = runtime->private_data;
+	struct snd_azf3328_codec_data *codec = runtime->private_data;
 #if 0
         unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
@@ -1178,11 +1172,11 @@ snd_azf3328_codec_prepare(struct snd_pcm
 	codec->dma_base = runtime->dma_addr;
 
 #if 0
-	snd_azf3328_codec_setfmt(chip, AZF_CODEC_...,
+	snd_azf3328_codec_setfmt(codec,
 		runtime->rate,
 		snd_pcm_format_width(runtime->format),
 		runtime->channels);
-	snd_azf3328_codec_setdmaa(chip, AZF_CODEC_...,
+	snd_azf3328_codec_setdmaa(codec,
 					runtime->dma_addr, count, size);
 #endif
 	snd_azf3328_dbgcallleave();
@@ -1190,24 +1184,23 @@ snd_azf3328_codec_prepare(struct snd_pcm
 }
 
 static int
-snd_azf3328_codec_trigger(enum snd_azf3328_codec_type codec_type,
-			struct snd_pcm_substream *substream, int cmd)
+snd_azf3328_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_azf3328 *chip = snd_pcm_substream_chip(substream);
-	const struct snd_azf3328_codec_data *codec = &chip->codecs[codec_type];
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_azf3328_codec_data *codec = runtime->private_data;
 	int result = 0;
 	u16 flags1;
 	bool previously_muted = 0;
-	bool is_playback_codec = (AZF_CODEC_PLAYBACK == codec_type);
+	bool is_main_mixer_playback_codec = (AZF_CODEC_PLAYBACK == codec->type);
 
-	snd_azf3328_dbgcalls("snd_azf3328_codec_trigger cmd %d\n", cmd);
+	snd_azf3328_dbgcalls("snd_azf3328_pcm_trigger cmd %d\n", cmd);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_azf3328_dbgcodec("START %s\n", codec->name);
 
-		if (is_playback_codec) {
+		if (is_main_mixer_playback_codec) {
 			/* mute WaveOut (avoid clicking during setup) */
 			previously_muted =
 				snd_azf3328_mixer_set_mute(
@@ -1215,12 +1208,12 @@ snd_azf3328_codec_trigger(enum snd_azf33
 				);
 		}
 
-		snd_azf3328_codec_setfmt(chip, codec_type,
+		snd_azf3328_codec_setfmt(codec,
 			runtime->rate,
 			snd_pcm_format_width(runtime->format),
 			runtime->channels);
 
-		spin_lock(&chip->reg_lock);
+		spin_lock(codec->lock);
 		/* first, remember current value: */
 		flags1 = snd_azf3328_codec_inw(codec, IDX_IO_CODEC_DMA_FLAGS);
 
@@ -1230,14 +1223,14 @@ snd_azf3328_codec_trigger(enum snd_azf33
 
 		/* FIXME: clear interrupts or what??? */
 		snd_azf3328_codec_outw(codec, IDX_IO_CODEC_IRQTYPE, 0xffff);
-		spin_unlock(&chip->reg_lock);
+		spin_unlock(codec->lock);
 
-		snd_azf3328_codec_setdmaa(chip, codec_type, runtime->dma_addr,
+		snd_azf3328_codec_setdmaa(codec, runtime->dma_addr,
 			snd_pcm_lib_period_bytes(substream),
 			snd_pcm_lib_buffer_bytes(substream)
 		);
 
-		spin_lock(&chip->reg_lock);
+		spin_lock(codec->lock);
 #ifdef WIN9X
 		/* FIXME: enable playback/recording??? */
 		flags1 |= DMA_RUN_SOMETHING1 | DMA_RUN_SOMETHING2;
@@ -1261,10 +1254,10 @@ snd_azf3328_codec_trigger(enum snd_azf33
 			DMA_EPILOGUE_SOMETHING |
 			DMA_SOMETHING_ELSE);
 #endif
-		spin_unlock(&chip->reg_lock);
-		snd_azf3328_ctrl_codec_activity(chip, codec_type, 1);
+		spin_unlock(codec->lock);
+		snd_azf3328_ctrl_codec_activity(chip, codec->type, 1);
 
-		if (is_playback_codec) {
+		if (is_main_mixer_playback_codec) {
 			/* now unmute WaveOut */
 			if (!previously_muted)
 				snd_azf3328_mixer_set_mute(
@@ -1277,19 +1270,19 @@ snd_azf3328_codec_trigger(enum snd_azf33
 	case SNDRV_PCM_TRIGGER_RESUME:
 		snd_azf3328_dbgcodec("RESUME %s\n", codec->name);
 		/* resume codec if we were active */
-		spin_lock(&chip->reg_lock);
+		spin_lock(codec->lock);
 		if (codec->running)
 			snd_azf3328_codec_outw(codec, IDX_IO_CODEC_DMA_FLAGS,
 				snd_azf3328_codec_inw(
 					codec, IDX_IO_CODEC_DMA_FLAGS
 				) | DMA_RESUME
 			);
-		spin_unlock(&chip->reg_lock);
+		spin_unlock(codec->lock);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		snd_azf3328_dbgcodec("STOP %s\n", codec->name);
 
-		if (is_playback_codec) {
+		if (is_main_mixer_playback_codec) {
 			/* mute WaveOut (avoid clicking during setup) */
 			previously_muted =
 				snd_azf3328_mixer_set_mute(
@@ -1297,7 +1290,7 @@ snd_azf3328_codec_trigger(enum snd_azf33
 				);
 		}
 
-		spin_lock(&chip->reg_lock);
+		spin_lock(codec->lock);
 		/* first, remember current value: */
 		flags1 = snd_azf3328_codec_inw(codec, IDX_IO_CODEC_DMA_FLAGS);
 
@@ -1312,10 +1305,10 @@ snd_azf3328_codec_trigger(enum snd_azf33
 
 		flags1 &= ~DMA_RUN_SOMETHING1;
 		snd_azf3328_codec_outw(codec, IDX_IO_CODEC_DMA_FLAGS, flags1);
-		spin_unlock(&chip->reg_lock);
-		snd_azf3328_ctrl_codec_activity(chip, codec_type, 0);
+		spin_unlock(codec->lock);
+		snd_azf3328_ctrl_codec_activity(chip, codec->type, 0);
 
-		if (is_playback_codec) {
+		if (is_main_mixer_playback_codec) {
 			/* now unmute WaveOut */
 			if (!previously_muted)
 				snd_azf3328_mixer_set_mute(
@@ -1349,31 +1342,12 @@ snd_azf3328_codec_trigger(enum snd_azf33
 	return result;
 }
 
-static int
-snd_azf3328_codec_playback_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	return snd_azf3328_codec_trigger(AZF_CODEC_PLAYBACK, substream, cmd);
-}
-
-static int
-snd_azf3328_codec_capture_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	return snd_azf3328_codec_trigger(AZF_CODEC_CAPTURE, substream, cmd);
-}
-
-static int
-snd_azf3328_codec_i2s_out_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	return snd_azf3328_codec_trigger(AZF_CODEC_I2S_OUT, substream, cmd);
-}
-
 static snd_pcm_uframes_t
-snd_azf3328_codec_pointer(struct snd_pcm_substream *substream,
-			  enum snd_azf3328_codec_type codec_type
+snd_azf3328_pcm_pointer(struct snd_pcm_substream *substream
 )
 {
-	const struct snd_azf3328 *chip = snd_pcm_substream_chip(substream);
-	const struct snd_azf3328_codec_data *codec = &chip->codecs[codec_type];
+	const struct snd_azf3328_codec_data *codec =
+		substream->runtime->private_data;
 	unsigned long result;
 	snd_pcm_uframes_t frmres;
 
@@ -1391,24 +1365,6 @@ snd_azf3328_codec_pointer(struct snd_pcm
 	return frmres;
 }
 
-static snd_pcm_uframes_t
-snd_azf3328_codec_playback_pointer(struct snd_pcm_substream *substream)
-{
-	return snd_azf3328_codec_pointer(substream, AZF_CODEC_PLAYBACK);
-}
-
-static snd_pcm_uframes_t
-snd_azf3328_codec_capture_pointer(struct snd_pcm_substream *substream)
-{
-	return snd_azf3328_codec_pointer(substream, AZF_CODEC_CAPTURE);
-}
-
-static snd_pcm_uframes_t
-snd_azf3328_codec_i2s_out_pointer(struct snd_pcm_substream *substream)
-{
-	return snd_azf3328_codec_pointer(substream, AZF_CODEC_I2S_OUT);
-}
-
 /******************************************************************/
 
 #ifdef SUPPORT_GAMEPORT
@@ -1642,29 +1598,29 @@ snd_azf3328_irq_log_unknown_type(u8 whic
 }
 
 static inline void
-snd_azf3328_codec_interrupt(struct snd_azf3328 *chip, u8 status)
+snd_azf3328_pcm_interrupt(const struct snd_azf3328_codec_data *first_codec,
+			  u8 status
+)
 {
 	u8 which;
 	enum snd_azf3328_codec_type codec_type;
-	const struct snd_azf3328_codec_data *codec;
+	const struct snd_azf3328_codec_data *codec = first_codec;
 
 	for (codec_type = AZF_CODEC_PLAYBACK;
 		 codec_type <= AZF_CODEC_I2S_OUT;
-			 ++codec_type) {
+			 ++codec_type, ++codec) {
 
 		/* skip codec if there's no interrupt for it */
 		if (!(status & (1 << codec_type)))
 			continue;
 
-		codec = &chip->codecs[codec_type];
-
-		spin_lock(&chip->reg_lock);
+		spin_lock(codec->lock);
 		which = snd_azf3328_codec_inb(codec, IDX_IO_CODEC_IRQTYPE);
 		/* ack all IRQ types immediately */
 		snd_azf3328_codec_outb(codec, IDX_IO_CODEC_IRQTYPE, which);
-		spin_unlock(&chip->reg_lock);
+		spin_unlock(codec->lock);
 
-		if ((chip->pcm[codec_type]) && (codec->substream)) {
+		if (codec->substream) {
 			snd_pcm_period_elapsed(codec->substream);
 			snd_azf3328_dbgcodec("%s period done (#%x), @ %x\n",
 				codec->name,
@@ -1719,7 +1675,7 @@ snd_azf3328_interrupt(int irq, void *dev
 	}
 
 	if (status & (IRQ_PLAYBACK|IRQ_RECORDING|IRQ_I2S_OUT))
-		snd_azf3328_codec_interrupt(chip, status);
+		snd_azf3328_pcm_interrupt(chip->codecs, status);
 
 	if (status & IRQ_GAMEPORT)
 		snd_azf3328_gameport_interrupt(chip);
@@ -1807,101 +1763,85 @@ snd_azf3328_pcm_open(struct snd_pcm_subs
 {
 	struct snd_azf3328 *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_azf3328_codec_data *codec = &chip->codecs[codec_type];
 
 	snd_azf3328_dbgcallenter();
-	chip->codecs[codec_type].substream = substream;
+	codec->substream = substream;
 
 	/* same parameters for all our codecs - at least we think so... */
 	runtime->hw = snd_azf3328_hardware;
 
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &snd_azf3328_hw_constraints_rates);
+	runtime->private_data = codec;
 	snd_azf3328_dbgcallleave();
 	return 0;
 }
 
 static int
-snd_azf3328_playback_open(struct snd_pcm_substream *substream)
+snd_azf3328_pcm_playback_open(struct snd_pcm_substream *substream)
 {
 	return snd_azf3328_pcm_open(substream, AZF_CODEC_PLAYBACK);
 }
 
 static int
-snd_azf3328_capture_open(struct snd_pcm_substream *substream)
+snd_azf3328_pcm_capture_open(struct snd_pcm_substream *substream)
 {
 	return snd_azf3328_pcm_open(substream, AZF_CODEC_CAPTURE);
 }
 
 static int
-snd_azf3328_i2s_out_open(struct snd_pcm_substream *substream)
+snd_azf3328_pcm_i2s_out_open(struct snd_pcm_substream *substream)
 {
 	return snd_azf3328_pcm_open(substream, AZF_CODEC_I2S_OUT);
 }
 
 static int
-snd_azf3328_pcm_close(struct snd_pcm_substream *substream,
-		      enum snd_azf3328_codec_type codec_type
+snd_azf3328_pcm_close(struct snd_pcm_substream *substream
 )
 {
-	struct snd_azf3328 *chip = snd_pcm_substream_chip(substream);
+	struct snd_azf3328_codec_data *codec =
+		substream->runtime->private_data;
 
 	snd_azf3328_dbgcallenter();
-	chip->codecs[codec_type].substream = NULL;
+	codec->substream = NULL;
 	snd_azf3328_dbgcallleave();
 	return 0;
 }
 
-static int
-snd_azf3328_playback_close(struct snd_pcm_substream *substream)
-{
-	return snd_azf3328_pcm_close(substream, AZF_CODEC_PLAYBACK);
-}
-
-static int
-snd_azf3328_capture_close(struct snd_pcm_substream *substream)
-{
-	return snd_azf3328_pcm_close(substream, AZF_CODEC_CAPTURE);
-}
-
-static int
-snd_azf3328_i2s_out_close(struct snd_pcm_substream *substream)
-{
-	return snd_azf3328_pcm_close(substream, AZF_CODEC_I2S_OUT);
-}
-
 /******************************************************************/
 
 static struct snd_pcm_ops snd_azf3328_playback_ops = {
-	.open =		snd_azf3328_playback_open,
-	.close =	snd_azf3328_playback_close,
+	.open =		snd_azf3328_pcm_playback_open,
+	.close =	snd_azf3328_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_azf3328_hw_params,
 	.hw_free =	snd_azf3328_hw_free,
-	.prepare =	snd_azf3328_codec_prepare,
-	.trigger =	snd_azf3328_codec_playback_trigger,
-	.pointer =	snd_azf3328_codec_playback_pointer
+	.prepare =	snd_azf3328_pcm_prepare,
+	.trigger =	snd_azf3328_pcm_trigger,
+	.pointer =	snd_azf3328_pcm_pointer
 };
 
 static struct snd_pcm_ops snd_azf3328_capture_ops = {
-	.open =		snd_azf3328_capture_open,
-	.close =	snd_azf3328_capture_close,
+	.open =		snd_azf3328_pcm_capture_open,
+	.close =	snd_azf3328_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_azf3328_hw_params,
 	.hw_free =	snd_azf3328_hw_free,
-	.prepare =	snd_azf3328_codec_prepare,
-	.trigger =	snd_azf3328_codec_capture_trigger,
-	.pointer =	snd_azf3328_codec_capture_pointer
+	.prepare =	snd_azf3328_pcm_prepare,
+	.trigger =	snd_azf3328_pcm_trigger,
+	.pointer =	snd_azf3328_pcm_pointer
 };
 
 static struct snd_pcm_ops snd_azf3328_i2s_out_ops = {
-	.open =		snd_azf3328_i2s_out_open,
-	.close =	snd_azf3328_i2s_out_close,
+	.open =		snd_azf3328_pcm_i2s_out_open,
+	.close =	snd_azf3328_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_azf3328_hw_params,
 	.hw_free =	snd_azf3328_hw_free,
-	.prepare =	snd_azf3328_codec_prepare,
-	.trigger =	snd_azf3328_codec_i2s_out_trigger,
-	.pointer =	snd_azf3328_codec_i2s_out_pointer
+	.prepare =	snd_azf3328_pcm_prepare,
+	.trigger =	snd_azf3328_pcm_trigger,
+	.pointer =	snd_azf3328_pcm_pointer
 };
 
 static int __devinit
@@ -2198,7 +2138,7 @@ snd_azf3328_create(struct snd_card *card
 	};
 	u8 dma_init;
 	enum snd_azf3328_codec_type codec_type;
-	struct snd_azf3328_codec *codec_setup;
+	struct snd_azf3328_codec_data *codec_setup;
 
 	*rchip = NULL;
 
@@ -2238,14 +2178,20 @@ snd_azf3328_create(struct snd_card *card
 
 	codec_setup = &chip->codecs[AZF_CODEC_PLAYBACK];
 	codec_setup->io_base = chip->ctrl_io + AZF_IO_OFFS_CODEC_PLAYBACK;
+	codec_setup->lock = &chip->reg_lock;
+	codec_setup->type = AZF_CODEC_PLAYBACK;
 	codec_setup->name = "PLAYBACK";
 
 	codec_setup = &chip->codecs[AZF_CODEC_CAPTURE];
 	codec_setup->io_base = chip->ctrl_io + AZF_IO_OFFS_CODEC_CAPTURE;
+	codec_setup->lock = &chip->reg_lock;
+	codec_setup->type = AZF_CODEC_CAPTURE;
 	codec_setup->name = "CAPTURE";
 
 	codec_setup = &chip->codecs[AZF_CODEC_I2S_OUT];
 	codec_setup->io_base = chip->ctrl_io + AZF_IO_OFFS_CODEC_I2S_OUT;
+	codec_setup->lock = &chip->reg_lock;
+	codec_setup->type = AZF_CODEC_I2S_OUT;
 	codec_setup->name = "I2S_OUT";
 
 	if (request_irq(pci->irq, snd_azf3328_interrupt,
@@ -2283,10 +2229,10 @@ snd_azf3328_create(struct snd_card *card
 		codec->running = 1;
 		snd_azf3328_ctrl_codec_activity(chip, codec_type, 0);
 
-		spin_lock_irq(&chip->reg_lock);
+		spin_lock_irq(codec->lock);
 		snd_azf3328_codec_outb(codec, IDX_IO_CODEC_DMA_FLAGS,
 						 dma_init);
-		spin_unlock_irq(&chip->reg_lock);
+		spin_unlock_irq(codec->lock);
 	}
 
 	snd_card_set_dev(card, &pci->dev);

-- 
