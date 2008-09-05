From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ALSA: ASoC V2: optimize init sequence of
	Freescale MPC8610 sound drivers
Date: Fri,  5 Sep 2008 15:51:28 -0500
Message-ID: <1220647888-30550-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id EA2D8246E3
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 22:51:36 +0200 (CEST)
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

Some comment blocks were not near the code they reference, so they were moved.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for ASoC V2 only.

 sound/soc/fsl/fsl_dma.c |  283 ++++++++++++++++++++++-------------------------
 sound/soc/fsl/fsl_ssi.c |   20 ++--
 2 files changed, 141 insertions(+), 162 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 5da0069..8821289 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -319,9 +319,66 @@ error:
 }
 
 /**
- * fsl_dma_open: open a new substream.
+ * fsl_dma_open: open a new substream and allocate DMA resources for it
  *
  * Each substream has its own DMA buffer.
+ *
+ * ALSA divides the DMA buffer into N periods.  We create NUM_DMA_LINKS link
+ * descriptors that cycle from one period to the next.  For example, if
+ * there are six periods and two link descriptors, this is how they look
+ * before playback starts:
+ *
+ *      	   The last link descriptor
+ *   ____________  points back to the first
+ *  |   	 |
+ *  V   	 |
+ *  ___    ___   |
+ * |   |->|   |->|
+ * |___|  |___|
+ *   |      |
+ *   |      |
+ *   V      V
+ *  _________________________________________
+ * |      |      |      |      |      |      |  The DMA buffer is
+ * |      |      |      |      |      |      |    divided into 6 parts
+ * |______|______|______|______|______|______|
+ *
+ * and here's how they look after the first period is finished playing:
+ *
+ *   ____________
+ *  |   	 |
+ *  V   	 |
+ *  ___    ___   |
+ * |   |->|   |->|
+ * |___|  |___|
+ *   |      |
+ *   |______________
+ *          |       |
+ *          V       V
+ *  _________________________________________
+ * |      |      |      |      |      |      |
+ * |      |      |      |      |      |      |
+ * |______|______|______|______|______|______|
+ *
+ * The first link descriptor now points to the third period.  The DMA
+ * controller is currently playing the second period.  When it finishes, it
+ * will jump back to the first descriptor and play the third period.
+ *
+ * There are four reasons we do this:
+ *
+ * 1. The only way to get the DMA controller to automatically restart the
+ *    transfer when it gets to the end of the buffer is to use chaining
+ *    mode.  Basic direct mode doesn't offer that feature.
+ * 2. We need to receive an interrupt at the end of every period.  The DMA
+ *    controller can generate an interrupt at the end of every link transfer
+ *    (aka segment).  Making each period into a DMA segment will give us the
+ *    interrupts we need.
+ * 3. By creating only two link descriptors, regardless of the number of
+ *    periods, we do not need to reallocate the link descriptors if the
+ *    number of periods changes.
+ * 4. All of the audio data is still stored in a single, contiguous DMA
+ *    buffer, which is what ALSA expects.  We're just dividing it into
+ *    contiguous parts, and creating a link descriptor for each one.
  */
 static int fsl_dma_open(struct snd_pcm_substream *substream)
 {
@@ -370,8 +427,8 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	dma_private->ld_buf_phys = ld_buf_phys;
 	dma_private->dma_buf_phys = substream->dma_buffer.addr;
 
-	ret = request_irq(dma_private->dma_info->irq,
-		fsl_dma_isr, 0, "DMA", dma_private);
+	ret = request_irq(dma_private->dma_info->irq, fsl_dma_isr, 0,
+		"fsl-audio-dma", dma_private);
 	if (ret) {
 		dev_err(substream->pcm->card->dev,
 			"can't register ISR for IRQ %u (ret=%i)\n",
@@ -393,17 +450,14 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	temp_link = dma_private->ld_buf_phys +
 		sizeof(struct fsl_dma_link_descriptor);
 
-	for (i = 0; i < NUM_DMA_LINKS; i++) {
-		struct fsl_dma_link_descriptor *link = &dma_private->link[i];
-
-		link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
-		link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
-		link->next = cpu_to_be64(temp_link);
+	for (i = 0; i < NUM_DMA_LINKS - 1; i++) {
+		dma_private->link[i].next = cpu_to_be64(temp_link);
 
 		temp_link += sizeof(struct fsl_dma_link_descriptor);
 	}
 	/* The last link descriptor points to the first */
-	dma_private->link[i - 1].next = cpu_to_be64(dma_private->ld_buf_phys);
+	dma_private->link[NUM_DMA_LINKS - 1].next =
+		cpu_to_be64(dma_private->ld_buf_phys);
 
 	/* Tell the DMA controller where the first link descriptor is */
 	out_be32(&dma_channel->clndar,
@@ -417,11 +471,7 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	/*
 	 * Program the mode register for interrupts, external master control,
 	 * and source/destination hold.  Also clear the Channel Abort bit.
-	 */
-	mr = in_be32(&dma_channel->mr) &
-		~(CCSR_DMA_MR_CA | CCSR_DMA_MR_DAHE | CCSR_DMA_MR_SAHE);
-
-	/*
+	 *
 	 * We want External Master Start and External Master Pause enabled,
 	 * because the SSI is controlling the DMA controller.  We want the DMA
 	 * controller to be set up in advance, and then we signal only the SSI
@@ -436,7 +486,7 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	 * We want Error Interrupt enabled, so that we can get an error if
 	 * the DMA controller is mis-programmed somehow.
 	 */
-	mr |= CCSR_DMA_MR_EOSIE | CCSR_DMA_MR_EIE | CCSR_DMA_MR_EMP_EN |
+	mr = CCSR_DMA_MR_EOSIE | CCSR_DMA_MR_EIE | CCSR_DMA_MR_EMP_EN |
 		CCSR_DMA_MR_EMS_EN;
 
 	/* For playback, we want the destination address to be held.  For
@@ -450,78 +500,47 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 }
 
 /**
- * fsl_dma_hw_params: allocate the DMA buffer and the DMA link descriptors.
- *
- * ALSA divides the DMA buffer into N periods.  We create NUM_DMA_LINKS link
- * descriptors that ping-pong from one period to the next.  For example, if
- * there are six periods and two link descriptors, this is how they look
- * before playback starts:
- *
- *      	   The last link descriptor
- *   ____________  points back to the first
- *  |   	 |
- *  V   	 |
- *  ___    ___   |
- * |   |->|   |->|
- * |___|  |___|
- *   |      |
- *   |      |
- *   V      V
- *  _________________________________________
- * |      |      |      |      |      |      |  The DMA buffer is
- * |      |      |      |      |      |      |    divided into 6 parts
- * |______|______|______|______|______|______|
+ * fsl_dma_hw_params: program the audio paramters into the DMA controller
  *
- * and here's how they look after the first period is finished playing:
+ * This function takes the audio parameters (period size, sample size, etc)
+ * and finishes programming the DMA controller accordingly.
  *
- *   ____________
- *  |   	 |
- *  V   	 |
- *  ___    ___   |
- * |   |->|   |->|
- * |___|  |___|
- *   |      |
- *   |______________
- *          |       |
- *          V       V
- *  _________________________________________
- * |      |      |      |      |      |      |
- * |      |      |      |      |      |      |
- * |______|______|______|______|______|______|
+ * The actual address in STX0 (destination for playback, source for capture)
+ * is based on the sample size.
  *
- * The first link descriptor now points to the third period.  The DMA
- * controller is currently playing the second period.  When it finishes, it
- * will jump back to the first descriptor and play the third period.
+ * One of the drawbacks with big-endian is that when copying integers of
+ * different sizes to a fixed-sized register, the address to which the
+ * integer must be copied is dependent on the size of the integer.
  *
- * There are four reasons we do this:
+ * For example, if P is the address of a 32-bit register, and X is a 32-bit
+ * integer, then X should be copied to address P.  However, if X is a 16-bit
+ * integer, then it should be copied to P+2.  If X is an 8-bit register,
+ * then it should be copied to P+3.
  *
- * 1. The only way to get the DMA controller to automatically restart the
- *    transfer when it gets to the end of the buffer is to use chaining
- *    mode.  Basic direct mode doesn't offer that feature.
- * 2. We need to receive an interrupt at the end of every period.  The DMA
- *    controller can generate an interrupt at the end of every link transfer
- *    (aka segment).  Making each period into a DMA segment will give us the
- *    interrupts we need.
- * 3. By creating only two link descriptors, regardless of the number of
- *    periods, we do not need to reallocate the link descriptors if the
- *    number of periods changes.
- * 4. All of the audio data is still stored in a single, contiguous DMA
- *    buffer, which is what ALSA expects.  We're just dividing it into
- *    contiguous parts, and creating a link descriptor for each one.
+ * So for playback of 8-bit samples, the DMA controller must transfer single
+ * bytes from the DMA buffer to the last byte of the STX0 register, i.e.
+ * offset by 3 bytes. For 16-bit samples, the offset is two bytes.
  *
- * Note that due to a quirk of the SSI's STX register, the target address
- * for the DMA operations depends on the sample size.  So we don't program
- * the dest_addr (for playback -- source_addr for capture) fields in the
- * link descriptors here.  We do that in fsl_dma_prepare()
+ * For 24-bit samples, the offset is 1 byte.  However, the DMA controller
+ * does not support 3-byte copies (the DAHTS register supports only 1, 2, 4,
+ * and 8 bytes at a time).  So we do not support packed 24-bit samples.
+ * 24-bit data must be padded to 32 bits.
  */
 static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
+	struct ccsr_dma_channel __iomem *dma_channel =
+		dma_private->dma_info->channel;
+
+	dma_addr_t ssi_sxx_phys;    /* Bus address of SSI STX register */
 
 	dma_addr_t temp_addr;   /* Pointer to next period */
+	uint32_t mr;
 
+	unsigned int sample_size;	/* Number of bits per sample */
+	unsigned int frame_size;	/* Number of bytes per frame */
 	unsigned int i;
 
 	/* Get all the parameters we need */
@@ -537,83 +556,16 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 	if (dma_private->dma_buf_next >= dma_private->dma_buf_end)
 		dma_private->dma_buf_next = dma_private->dma_buf_phys;
 
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
- *
- * For example, if P is the address of a 32-bit register, and X is a 32-bit
- * integer, then X should be copied to address P.  However, if X is a 16-bit
- * integer, then it should be copied to P+2.  If X is an 8-bit register,
- * then it should be copied to P+3.
- *
- * So for playback of 8-bit samples, the DMA controller must transfer single
- * bytes from the DMA buffer to the last byte of the STX0 register, i.e.
- * offset by 3 bytes. For 16-bit samples, the offset is two bytes.
- *
- * For 24-bit samples, the offset is 1 byte.  However, the DMA controller
- * does not support 3-byte copies (the DAHTS register supports only 1, 2, 4,
- * and 8 bytes at a time).  So we do not support packed 24-bit samples.
- * 24-bit data must be padded to 32 bits.
- */
-static int fsl_dma_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct fsl_dma_private *dma_private = runtime->private_data;
-	struct ccsr_dma_channel __iomem *dma_channel =
-		dma_private->dma_info->channel;
-	uint32_t mr;
-	unsigned int i;
-	dma_addr_t ssi_sxx_phys;	/* Bus address of SSI STX register */
-	unsigned int frame_size;	/* Number of bytes per frame */
+	/* Program the sample size and I/O address into the DMA controller  */
 
 	ssi_sxx_phys = dma_private->dma_info->ssi_sxx_phys;
 
 	mr = in_be32(&dma_channel->mr) & ~(CCSR_DMA_MR_BWC_MASK |
 		  CCSR_DMA_MR_SAHTS_MASK | CCSR_DMA_MR_DAHTS_MASK);
 
-	switch (runtime->sample_bits) {
+	sample_size = snd_pcm_format_physical_width(params_format(hw_params));
+
+	switch (sample_size) {
 	case 8:
 		mr |= CCSR_DMA_MR_DAHTS_1 | CCSR_DMA_MR_SAHTS_1;
 		ssi_sxx_phys += 3;
@@ -631,7 +583,8 @@ static int fsl_dma_prepare(struct snd_pcm_substream *substream)
 		return -EINVAL;
 	}
 
-	frame_size = runtime->frame_bits / 8;
+	frame_size = 2 * (sample_size / 8);
+
 	/*
 	 * BWC should always be a multiple of the frame size.  BWC determines
 	 * how many bytes are sent/received before the DMA controller checks the
@@ -648,16 +601,45 @@ static int fsl_dma_prepare(struct snd_pcm_substream *substream)
 
 	out_be32(&dma_channel->mr, mr);
 
-	/*
-	 * Program the address of the DMA transfer to/from the SSI.
-	 */
+	temp_addr = substream->dma_buffer.addr;
+
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
+		 * Note that this is unlikely to cause cache incoherency unless
+		 * the DMA buffer is smaller than the size of L1 cache.
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
@@ -800,7 +782,6 @@ static struct snd_pcm_ops fsl_dma_ops = {
 	.ioctl  	= snd_pcm_lib_ioctl,
 	.hw_params      = fsl_dma_hw_params,
 	.hw_free	= fsl_dma_hw_free,
-	.prepare	= fsl_dma_prepare,
 	.pointer	= fsl_dma_pointer,
 };
 
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 319cc97..fc52d30 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -344,30 +344,28 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 }
 
 /**
- * fsl_ssi_prepare: prepare the SSI.
+ * fsl_ssi_hw_params: program the sample size
  *
  * Most of the SSI registers have been programmed in the startup function,
- * but the word length must be programmed here.  Unfortunately, programming
- * the SxCCR.WL bits requires the SSI to be temporarily disabled.  This can
- * cause a problem with supporting simultaneous playback and capture.  If
- * the SSI is already playing a stream, then that stream may be temporarily
- * stopped when you start capture.
+ * but the word length must be programmed here.  Since we support
+ * synchronous mode only, only the master stream can program STCRR[WL].
  *
  * Note: The SxCCR.DC and SxCCR.PM bits are only used if the SSI is the
  * clock master.
  */
-static int fsl_ssi_prepare(struct snd_pcm_substream *substream,
-	struct snd_soc_dai *cpu_dai)
+static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
 
 	if (substream == ssi_info->master_stream) {
-		struct snd_pcm_runtime *runtime = substream->runtime;
 		struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
+		unsigned int sample_size =
+			snd_pcm_format_width(params_format(hw_params));
 		u32 wl;
 
 		/* The SSI should always be disabled at this points (SSIEN=0) */
-		wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
+		wl = CCSR_SSI_SxCCR_WL(sample_size);
 
 		/* In synchronous mode, the SSI uses STCCR for capture */
 		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
@@ -588,7 +586,7 @@ static struct snd_soc_dai_caps capture = {
 
 static struct snd_soc_dai_ops ops = {
 	.startup	= fsl_ssi_startup,
-	.prepare	= fsl_ssi_prepare,
+	.hw_params	= fsl_ssi_hw_params,
 	.shutdown	= fsl_ssi_shutdown,
 	.trigger	= fsl_ssi_trigger,
 
-- 
1.5.5
