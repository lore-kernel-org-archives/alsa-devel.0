From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] asoc: restrict sample rate and size in
	Freescale MPC8610 sound drivers
Date: Mon, 28 Jul 2008 14:41:10 -0500
Message-ID: <1217274070-10537-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 1813624787
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jul 2008 21:41:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

The Freescale MPC8610 SSI device has the option of using one clock for both
transmit and receive (synchronous mode), or independent clocks (asynchronous).
The SSI driver, however, programs the SSI into synchronous mode and then
tries to program the clock registers independently.  The result is that the wrong
sample size is usually generated during recording.

This patch fixes the discrepancy by restricting the sample rate and sample size
of the playback and capture streams.  The SSI driver remembers which stream
is opened first.  When a second stream is opened, that stream is constrained
to the same sample rate and size as the first stream.

A future version of this driver will lift the sample size restriction.
Supporting independent sample rates is more difficult, because only certain
codecs provide dual independent clocks.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Please apply this patch for 2.6.26.1 and for 2.6.27-rc1.  Without this patch,
recording on the MPC8610 is just plain broken, so it is a must-fix for 2.6.26.

 sound/soc/fsl/fsl_dma.c |    7 ++++-
 sound/soc/fsl/fsl_ssi.c |   66 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index da2bc59..7ceea2b 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -132,12 +132,17 @@ struct fsl_dma_private {
  * Since each link descriptor has a 32-bit byte count field, we set
  * period_bytes_max to the largest 32-bit number.  We also have no maximum
  * number of periods.
+ *
+ * Note that we specify SNDRV_PCM_INFO_JOINT_DUPLEX here, but only because a
+ * limitation in the SSI driver requires the sample rates for playback and
+ * capture to be the same.
  */
 static const struct snd_pcm_hardware fsl_dma_hardware = {
 
 	.info   		= SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_MMAP |
-				  SNDRV_PCM_INFO_MMAP_VALID,
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_JOINT_DUPLEX,
 	.formats		= FSLDMA_PCM_FORMATS,
 	.rates  		= FSLDMA_PCM_RATES,
 	.rate_min       	= 5512,
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 71bff33..da71876 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -67,6 +67,7 @@
  * @ssi: pointer to the SSI's registers
  * @ssi_phys: physical address of the SSI registers
  * @irq: IRQ of this SSI
+ * @first_stream: stream ID of first stream to program hardware
  * @dev: struct device pointer
  * @playback: the number of playback streams opened
  * @capture: the number of capture streams opened
@@ -79,6 +80,7 @@ struct fsl_ssi_private {
 	struct ccsr_ssi __iomem *ssi;
 	dma_addr_t ssi_phys;
 	unsigned int irq;
+	struct snd_pcm_substream *first_stream;
 	struct device *dev;
 	unsigned int playback;
 	unsigned int capture;
@@ -283,6 +285,8 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream)
 			return ret;
 		}
 
+		ssi_private->first_stream = substream;
+
 		/*
 		 * Section 16.5 of the MPC8610 reference manual says that the
 		 * SSI needs to be disabled before updating the registers we set
@@ -340,6 +344,44 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream)
 		 * this is bad is because at this point, the PCM driver has not
 		 * finished initializing the DMA controller.
 		 */
+
+	} else {
+		/* This is not the first stream open, so we need to impose
+		 * sample rate and maybe sample size constraints.  Note that
+		 * this can cause a race condition if the second stream is
+		 * opened before the first stream is fully initialized.
+		 *
+		 * We provide some protection by checking to make sure the first
+		 * stream is initialized, but it's not perfect.  ALSA sometimes
+		 * re-initializes the driver with a different sample rate or
+		 * size.  If the second stream is opened before the first stream
+		 * has received its final parameters, then the second stream may
+		 * be constrained to the wrong sample rate or size.
+		 *
+		 * FIXME: This code does not handle opening and closing streams
+		 * repeatedly.  If you open two streams and then close the first
+		 * one, you may not be able to open another stream until you
+		 * close the second one as well.
+		 */
+		struct snd_pcm_runtime *first_runtime =
+			ssi_private->first_stream->runtime;
+
+		if (!first_runtime->rate || !first_runtime->sample_bits) {
+			dev_err(substream->pcm->card->dev,
+				"set sample rate and size in %s stream first\n",
+				substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+				? "capture" : "playback");
+			return -EAGAIN;
+		}
+
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_RATE,
+			first_runtime->rate, first_runtime->rate);
+
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+			first_runtime->sample_bits,
+			first_runtime->sample_bits);
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -371,18 +413,16 @@ static int fsl_ssi_prepare(struct snd_pcm_substream *substream)
 	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
 
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-	u32 wl;
 
-	wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
+	if (substream == ssi_private->first_stream) {
+		u32 wl;
 
-	clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+		/* The SSI should always be disabled at this points (SSIEN=0) */
+		wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		/* In synchronous mode, the SSI uses STCCR for capture */
 		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
-	else
-		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
-
-	setbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+	}
 
 	return 0;
 }
@@ -407,9 +447,13 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			setbits32(&ssi->scr, CCSR_SSI_SCR_TE);
+			clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+			setbits32(&ssi->scr,
+				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
 		} else {
-			setbits32(&ssi->scr, CCSR_SSI_SCR_RE);
+			clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+			setbits32(&ssi->scr,
+				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
 
 			/*
 			 * I think we need this delay to allow time for the SSI
@@ -462,6 +506,8 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream)
 		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 
 		free_irq(ssi_private->irq, ssi_private);
+
+		ssi_private->first_stream = NULL;
 	}
 }
 
-- 
1.5.5
