From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] [v2] asoc/multi-component: fsl: add support
	for variable SSI FIFO depth
Date: Fri, 6 Aug 2010 12:16:12 -0500
Message-ID: <1281114972-21450-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 42ECF10394B
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 19:16:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Add code that programs the DMA and SSI controllers differently based on the
FIFO depth of the SSI.

The SSI devices on the MPC8610 and the P1022 are identical in every way except
one: the transmit and receive FIFO depth.  On the MPC8610, the depth is eight.
On the P1022, it's fifteen.  The device tree nodes for the SSI include a
"fsl,fifo-depth" property that specifies the FIFO depth.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c |   67 +++++++++++++++++++++++++++++++++++-----------
 sound/soc/fsl/fsl_ssi.c |   25 +++++++++++++++--
 2 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 57774cb..dfe1cb9 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -60,6 +60,7 @@ struct dma_object {
 	struct snd_soc_platform_driver dai;
 	dma_addr_t ssi_stx_phys;
 	dma_addr_t ssi_srx_phys;
+	unsigned int ssi_fifo_depth;
 	struct ccsr_dma_channel __iomem *channel;
 	unsigned int irq;
 	bool assigned;
@@ -99,6 +100,7 @@ struct fsl_dma_private {
 	unsigned int irq;
 	struct snd_pcm_substream *substream;
 	dma_addr_t ssi_sxx_phys;
+	unsigned int ssi_fifo_depth;
 	dma_addr_t ld_buf_phys;
 	unsigned int current_link;
 	dma_addr_t dma_buf_phys;
@@ -431,6 +433,7 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	else
 		dma_private->ssi_sxx_phys = dma->ssi_srx_phys;
 
+	dma_private->ssi_fifo_depth = dma->ssi_fifo_depth;
 	dma_private->dma_channel = dma->channel;
 	dma_private->irq = dma->irq;
 	dma_private->substream = substream;
@@ -544,11 +547,11 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 	struct device *dev = rtd->platform->dev;
 
 	/* Number of bits per sample */
-	unsigned int sample_size =
+	unsigned int sample_bits =
 		snd_pcm_format_physical_width(params_format(hw_params));
 
 	/* Number of bytes per frame */
-	unsigned int frame_size = 2 * (sample_size / 8);
+	unsigned int sample_bytes = sample_bits / 8;
 
 	/* Bus address of SSI STX register */
 	dma_addr_t ssi_sxx_phys = dma_private->ssi_sxx_phys;
@@ -588,7 +591,7 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 	 * that offset here.  While we're at it, also tell the DMA controller
 	 * how much data to transfer per sample.
 	 */
-	switch (sample_size) {
+	switch (sample_bits) {
 	case 8:
 		mr |= CCSR_DMA_MR_DAHTS_1 | CCSR_DMA_MR_SAHTS_1;
 		ssi_sxx_phys += 3;
@@ -602,22 +605,42 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		/* We should never get here */
-		dev_err(dev, "unsupported sample size %u\n", sample_size);
+		dev_err(dev, "unsupported sample size %u\n", sample_bits);
 		return -EINVAL;
 	}
 
 	/*
-	 * BWC should always be a multiple of the frame size.  BWC determines
-	 * how many bytes are sent/received before the DMA controller checks the
-	 * SSI to see if it needs to stop.  For playback, the transmit FIFO can
-	 * hold three frames, so we want to send two frames at a time. For
-	 * capture, the receive FIFO is triggered when it contains one frame, so
-	 * we want to receive one frame at a time.
+	 * BWC determines how many bytes are sent/received before the DMA
+	 * controller checks the SSI to see if it needs to stop. BWC should
+	 * always be a multiple of the frame size, so that we always transmit
+	 * whole frames.  Each frame occupies two slots in the FIFO.  The
+	 * parameter for CCSR_DMA_MR_BWC() is rounded down the next power of two
+	 * (MR[BWC] can only represent even powers of two).
+	 *
+	 * To simplify the process, we set BWC to the largest value that is
+	 * less than or equal to the FIFO watermark.  For playback, this ensures
+	 * that we transfer the maximum amount without overrunning the FIFO.
+	 * For capture, this ensures that we transfer the maximum amount without
+	 * underrunning the FIFO.
+	 *
+	 * f = SSI FIFO depth
+	 * w = SSI watermark value (which equals f - 2)
+	 * b = DMA bandwidth count (in bytes)
+	 * s = sample size (in bytes, which equals frame_size * 2)
+	 *
+	 * For playback, we never transmit more than the transmit FIFO
+	 * watermark, otherwise we might write more data than the FIFO can hold.
+	 * The watermark is equal to the FIFO depth minus two.
+	 *
+	 * For capture, two equations must hold:
+	 *	w > f - (b / s)
+	 *	w >= b / s
+	 *
+	 * So, b > 2 * s, but b must also be <= s * w.  To simplify, we set
+	 * b = s * w, which is equal to
+	 *      (dma_private->ssi_fifo_depth - 2) * sample_bytes.
 	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		mr |= CCSR_DMA_MR_BWC(2 * frame_size);
-	else
-		mr |= CCSR_DMA_MR_BWC(frame_size);
+	mr |= CCSR_DMA_MR_BWC((dma_private->ssi_fifo_depth - 2) * sample_bytes);
 
 	out_be32(&dma_channel->mr, mr);
 
@@ -871,6 +894,7 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 	struct device_node *np = of_dev->dev.of_node;
 	struct device_node *ssi_np;
 	struct resource res;
+	const uint32_t *iprop;
 	int ret;
 
 	/* Find the SSI node that points to us. */
@@ -881,15 +905,17 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 	}
 
 	ret = of_address_to_resource(ssi_np, 0, &res);
-	of_node_put(ssi_np);
 	if (ret) {
-		dev_err(&of_dev->dev, "could not determine device resources\n");
+		dev_err(&of_dev->dev, "could not determine resources for %s\n",
+			ssi_np->full_name);
+		of_node_put(ssi_np);
 		return ret;
 	}
 
 	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
 	if (!dma) {
 		dev_err(&of_dev->dev, "could not allocate dma object\n");
+		of_node_put(ssi_np);
 		return -ENOMEM;
 	}
 
@@ -902,6 +928,15 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 	dma->ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
 	dma->ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);
 
+	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
+	if (iprop)
+		dma->ssi_fifo_depth = *iprop;
+	else
+                /* Older 8610 DTs didn't have the fifo-depth property */
+		dma->ssi_fifo_depth = 8;
+
+	of_node_put(ssi_np);
+
 	ret = snd_soc_register_platform(&of_dev->dev, &dma->dai);
 	if (ret) {
 		dev_err(&of_dev->dev, "could not register platform\n");
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 00e3e62..c377dd2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -93,6 +93,7 @@ struct fsl_ssi_private {
 	unsigned int playback;
 	unsigned int capture;
 	int asynchronous;
+	unsigned int fifo_depth;
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct device_attribute dev_attr;
 	struct platform_device *pdev;
@@ -337,11 +338,20 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 
 		/*
 		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
-		 * don't use FIFO 1.  Since the SSI only supports stereo, the
-		 * watermark should never be an odd number.
+		 * don't use FIFO 1.  We program the transmit water to signal a
+		 * DMA transfer if there are only two (or fewer) elements left
+		 * in the FIFO.  Two elements equals one frame (left channel,
+		 * right channel).  This value, however, depends on the depth of
+		 * the transmit buffer.
+		 *
+		 * We program the receive FIFO to notify us if at least two
+		 * elements (one frame) have been written to the FIFO.  We could
+		 * make this value larger (and maybe we should), but this way
+		 * data will be written to memory as soon as it's available.
 		 */
 		out_be32(&ssi->sfcsr,
-			 CCSR_SSI_SFCSR_TFWM0(6) | CCSR_SSI_SFCSR_RFWM0(2));
+			CCSR_SSI_SFCSR_TFWM0(ssi_private->fifo_depth - 2) |
+			CCSR_SSI_SFCSR_RFWM0(ssi_private->fifo_depth - 2));
 
 		/*
 		 * We keep the SSI disabled because if we enable it, then the
@@ -622,6 +632,7 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	struct device_attribute *dev_attr = NULL;
 	struct device_node *np = of_dev->dev.of_node;
 	const char *p, *sprop;
+	const uint32_t *iprop;
 	struct resource res;
 	char name[64];
 
@@ -671,6 +682,14 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	else
 		ssi_private->cpu_dai_drv.symmetric_rates = 1;
 
+	/* Determine the FIFO depth. */
+	iprop = of_get_property(np, "fsl,fifo-depth", NULL);
+	if (iprop)
+		ssi_private->fifo_depth = *iprop;
+	else
+                /* Older 8610 DTs didn't have the fifo-depth property */
+		ssi_private->fifo_depth = 8;
+
 	/* Initialize the the device_attribute structure */
 	dev_attr = &ssi_private->dev_attr;
 	dev_attr->attr.name = "statistics";
-- 
1.7.0.1
