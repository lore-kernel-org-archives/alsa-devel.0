From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.30] ASoC: optimize init sequence of
	Freescale MPC8610 sound drivers
Date: Thu,  5 Feb 2009 17:56:02 -0600
Message-ID: <1233878162-30569-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 03C0A24356
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 00:56:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

In the Freescale MPC8610 sound drivers, relocate all code from the _prepare
functions into the corresponding _hw_params functions.  These drivers assumed
that the sample size is known in the _prepare function and not in the
_hw_params function, but this is not true.

Move the code in fsl_dma_prepare() into fsl_dma_hw_param().  Create
fsl_ssi_hw_params() and move the code from fsl_ssi_prepare() into it.

Turn off snooping for DMA operations to/from I/O registers, since that's not
necessary.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c |  178 ++++++++++++++++++++++------------------------
 sound/soc/fsl/fsl_ssi.c |   19 +++---
 2 files changed, 94 insertions(+), 103 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 64993ed..58a3fa4 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -464,11 +464,7 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 		sizeof(struct fsl_dma_link_descriptor);
 
 	for (i = 0; i < NUM_DMA_LINKS; i++) {
-		struct fsl_dma_link_descriptor *link = &dma_private->link[i];
-
-		link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
-		link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
-		link->next = cpu_to_be64(temp_link);
+		dma_private->link[i].next = cpu_to_be64(temp_link);
 
 		temp_link += sizeof(struct fsl_dma_link_descriptor);
 	}
@@ -525,79 +521,9 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
  * This function obtains hardware parameters about the opened stream and
  * programs the DMA controller accordingly.
  *
- * Note that due to a quirk of the SSI's STX register, the target address
- * for the DMA operations depends on the sample size.  So we don't program
- * the dest_addr (for playback -- source_addr for capture) fields in the
- * link descriptors here.  We do that in fsl_dma_prepare()
- */
-static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct fsl_dma_private *dma_private = runtime->private_data;
-
-	dma_addr_t temp_addr;   /* Pointer to next period */
-
-	unsigned int i;
-
-	/* Get all the parameters we need */
-	size_t buffer_size = params_buffer_bytes(hw_params);
-	size_t period_size = params_period_bytes(hw_params);
-
-	/* Initialize our DMA tracking variables */
-	dma_private->period_size = period_size;
-	dma_private->num_periods = params_periods(hw_params);
-	dma_private->dma_buf_end = dma_private->dma_buf_phys + buffer_size;
-	dma_private->dma_buf_next = dma_private->dma_buf_phys +
-		(NUM_DMA_LINKS * period_size);
-	if (dma_private->dma_buf_next >= dma_private->dma_buf_end)
-		dma_private->dma_buf_next = dma_private->dma_buf_phys;
-
-	/*
-	 * The actual address in STX0 (destination for playback, source for
-	 * capture) is based on the sample size, but we don't know the sample
-	 * size in this function, so we'll have to adjust that later.  See
-	 * comments in fsl_dma_prepare().
-	 *
-	 * The DMA controller does not have a cache, so the CPU does not
-	 * need to tell it to flush its cache.  However, the DMA
-	 * controller does need to tell the CPU to flush its cache.
-	 * That's what the SNOOP bit does.
-	 *
-	 * Also, even though the DMA controller supports 36-bit addressing, for
-	 * simplicity we currently support only 32-bit addresses for the audio
-	 * buffer itself.
-	 */
-	temp_addr = substream->dma_buffer.addr;
-
-	for (i = 0; i < NUM_DMA_LINKS; i++) {
-		struct fsl_dma_link_descriptor *link = &dma_private->link[i];
-
-		link->count = cpu_to_be32(period_size);
-
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			link->source_addr = cpu_to_be32(temp_addr);
-		else
-			link->dest_addr = cpu_to_be32(temp_addr);
-
-		temp_addr += period_size;
-	}
-
-	return 0;
-}
-
-/**
- * fsl_dma_prepare - prepare the DMA registers for playback.
- *
- * This function is called after the specifics of the audio data are known,
- * i.e. snd_pcm_runtime is initialized.
- *
- * In this function, we finish programming the registers of the DMA
- * controller that are dependent on the sample size.
- *
- * One of the drawbacks with big-endian is that when copying integers of
- * different sizes to a fixed-sized register, the address to which the
- * integer must be copied is dependent on the size of the integer.
+ * One drawback of big-endian is that when copying integers of different
+ * sizes to a fixed-sized register, the address to which the integer must be
+ * copied is dependent on the size of the integer.
  *
  * For example, if P is the address of a 32-bit register, and X is a 32-bit
  * integer, then X should be copied to address P.  However, if X is a 16-bit
@@ -613,22 +539,58 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
  * and 8 bytes at a time).  So we do not support packed 24-bit samples.
  * 24-bit data must be padded to 32 bits.
  */
-static int fsl_dma_prepare(struct snd_pcm_substream *substream)
+static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
+
+	/* Number of bits per sample */
+	unsigned int sample_size =
+		snd_pcm_format_physical_width(params_format(hw_params));
+
+	/* Number of bytes per frame */
+	unsigned int frame_size = 2 * (sample_size / 8);
+
+	/* Bus address of SSI STX register */
+	dma_addr_t ssi_sxx_phys = dma_private->ssi_sxx_phys;
+
+	/* Size of the DMA buffer, in bytes */
+	size_t buffer_size = params_buffer_bytes(hw_params);
+
+	/* Number of bytes per period */
+	size_t period_size = params_period_bytes(hw_params);
+
+	/* Pointer to next period */
+	dma_addr_t temp_addr = substream->dma_buffer.addr;
+
+	/* Pointer to DMA controller */
 	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
-	u32 mr;
+
+	u32 mr; /* DMA Mode Register */
+
 	unsigned int i;
-	dma_addr_t ssi_sxx_phys;	/* Bus address of SSI STX register */
-	unsigned int frame_size;	/* Number of bytes per frame */
 
-	ssi_sxx_phys = dma_private->ssi_sxx_phys;
+	/* Initialize our DMA tracking variables */
+	dma_private->period_size = period_size;
+	dma_private->num_periods = params_periods(hw_params);
+	dma_private->dma_buf_end = dma_private->dma_buf_phys + buffer_size;
+	dma_private->dma_buf_next = dma_private->dma_buf_phys +
+		(NUM_DMA_LINKS * period_size);
+
+	if (dma_private->dma_buf_next >= dma_private->dma_buf_end)
+		/* This happens if the number of periods == NUM_DMA_LINKS */
+		dma_private->dma_buf_next = dma_private->dma_buf_phys;
 
 	mr = in_be32(&dma_channel->mr) & ~(CCSR_DMA_MR_BWC_MASK |
 		  CCSR_DMA_MR_SAHTS_MASK | CCSR_DMA_MR_DAHTS_MASK);
 
-	switch (runtime->sample_bits) {
+	/* Due to a quirk of the SSI's STX register, the target address
+	 * for the DMA operations depends on the sample size.  So we calculate
+	 * that offset here.  While we're at it, also tell the DMA controller
+	 * how much data to transfer per sample.
+	 */
+	switch (sample_size) {
 	case 8:
 		mr |= CCSR_DMA_MR_DAHTS_1 | CCSR_DMA_MR_SAHTS_1;
 		ssi_sxx_phys += 3;
@@ -641,12 +603,12 @@ static int fsl_dma_prepare(struct snd_pcm_substream *substream)
 		mr |= CCSR_DMA_MR_DAHTS_4 | CCSR_DMA_MR_SAHTS_4;
 		break;
 	default:
+		/* We should never get here */
 		dev_err(substream->pcm->card->dev,
-			"unsupported sample size %u\n", runtime->sample_bits);
+			"unsupported sample size %u\n", sample_size);
 		return -EINVAL;
 	}
 
-	frame_size = runtime->frame_bits / 8;
 	/*
 	 * BWC should always be a multiple of the frame size.  BWC determines
 	 * how many bytes are sent/received before the DMA controller checks the
@@ -655,7 +617,6 @@ static int fsl_dma_prepare(struct snd_pcm_substream *substream)
 	 * capture, the receive FIFO is triggered when it contains one frame, so
 	 * we want to receive one frame at a time.
 	 */
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		mr |= CCSR_DMA_MR_BWC(2 * frame_size);
 	else
@@ -663,16 +624,48 @@ static int fsl_dma_prepare(struct snd_pcm_substream *substream)
 
 	out_be32(&dma_channel->mr, mr);
 
-	/*
-	 * Program the address of the DMA transfer to/from the SSI.
-	 */
 	for (i = 0; i < NUM_DMA_LINKS; i++) {
 		struct fsl_dma_link_descriptor *link = &dma_private->link[i];
 
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		link->count = cpu_to_be32(period_size);
+
+		/* Even though the DMA controller supports 36-bit addressing,
+		 * for simplicity we allow only 32-bit addresses for the audio
+		 * buffer itself.  This was enforced in fsl_dma_new() with the
+		 * DMA mask.
+		 *
+		 * The snoop bit tells the DMA controller whether it should tell
+		 * the ECM to snoop during a read or write to an address. For
+		 * audio, we use DMA to transfer data between memory and an I/O
+		 * device (the SSI's STX0 or SRX0 register). Snooping is only
+		 * needed if there is a cache, so we need to snoop memory
+		 * addresses only.  For playback, that means we snoop the source
+		 * but not the destination.  For capture, we snoop the
+		 * destination but not the source.
+		 *
+		 * Note that failing to snoop properly is unlikely to cause
+		 * cache incoherency if the period size is larger than the
+		 * size of L1 cache.  This is because filling in one period will
+		 * flush out the data for the previous period.  So if you
+		 * increased period_bytes_min to a large enough size, you might
+		 * get more performance by not snooping, and you'll still be
+		 * okay.
+		 */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			link->source_addr = cpu_to_be32(temp_addr);
+			link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
+
 			link->dest_addr = cpu_to_be32(ssi_sxx_phys);
-		else
+			link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_NOSNOOP);
+		} else {
 			link->source_addr = cpu_to_be32(ssi_sxx_phys);
+			link->source_attr = cpu_to_be32(CCSR_DMA_ATR_NOSNOOP);
+
+			link->dest_addr = cpu_to_be32(temp_addr);
+			link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
+		}
+
+		temp_addr += period_size;
 	}
 
 	return 0;
@@ -808,7 +801,6 @@ static struct snd_pcm_ops fsl_dma_ops = {
 	.ioctl  	= snd_pcm_lib_ioctl,
 	.hw_params      = fsl_dma_hw_params,
 	.hw_free	= fsl_dma_hw_free,
-	.prepare	= fsl_dma_prepare,
 	.pointer	= fsl_dma_pointer,
 };
 
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c6d6eb7..6844009 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -400,7 +400,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 }
 
 /**
- * fsl_ssi_prepare: prepare the SSI.
+ * fsl_ssi_hw_params - program the sample size
  *
  * Most of the SSI registers have been programmed in the startup function,
  * but the word length must be programmed here.  Unfortunately, programming
@@ -412,20 +412,19 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
  * Note: The SxCCR.DC and SxCCR.PM bits are only used if the SSI is the
  * clock master.
  */
-static int fsl_ssi_prepare(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *dai)
+static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
-
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct fsl_ssi_private *ssi_private = cpu_dai->private_data;
 
 	if (substream == ssi_private->first_stream) {
+		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+		unsigned int sample_size =
+			snd_pcm_format_width(params_format(hw_params));
 		u32 wl;
 
 		/* The SSI should always be disabled at this points (SSIEN=0) */
-		wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
+		wl = CCSR_SSI_SxCCR_WL(sample_size);
 
 		/* In synchronous mode, the SSI uses STCCR for capture */
 		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
@@ -579,7 +578,7 @@ static struct snd_soc_dai fsl_ssi_dai_template = {
 	},
 	.ops = {
 		.startup = fsl_ssi_startup,
-		.prepare = fsl_ssi_prepare,
+		.hw_params = fsl_ssi_hw_params,
 		.shutdown = fsl_ssi_shutdown,
 		.trigger = fsl_ssi_trigger,
 		.set_sysclk = fsl_ssi_set_sysclk,
-- 
1.5.5
