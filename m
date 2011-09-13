From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 3/3] ASoC: improve asynchronous mode support in
	the fsl_ssi driver
Date: Tue, 13 Sep 2011 12:59:37 -0500
Message-ID: <1315936777-27994-3-git-send-email-timur@freescale.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A44B103984
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 19:59:47 +0200 (CEST)
In-Reply-To: <1315936777-27994-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Freescale SSI audio controller supports "synchronous" and "asynchronous"
modes.  In synchronous mode, playback and capture use the same input clock,
so sample rates must be the same during simultaneous playback and capture.
Unfortunately, the code which supports asynchronous mode is just broken in
various ways.  In particular, it was constraining sample sizes as well as
the sample rate.

The fix also allows us to simplify the code by eliminating the 'asynchronous',
'playback', and 'capture' variables that were used to keep track of playback
and capture streams.

Unfortunately, it turns out that simulataneous playback and record does not
actually work on the only platform that supports asynchronous mode: the
Freescale P1022DS reference board.  If a second stream is started, the SSI
grinds to halt for both streams.  This is true even if the P1022 is configured
for synchronous mode, so it's likely a hardware problem that needs to be
worked around.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c |  145 ++++++++++++++++++++++-------------------------
 1 files changed, 68 insertions(+), 77 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 06ac2b9..0268cf9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -78,7 +78,6 @@
  * @second_stream: pointer to second stream
  * @playback: the number of playback streams opened
  * @capture: the number of capture streams opened
- * @asynchronous: 0=synchronous mode, 1=asynchronous mode
  * @cpu_dai: the CPU DAI for this device
  * @dev_attr: the sysfs device attribute structure
  * @stats: SSI statistics
@@ -90,9 +89,6 @@ struct fsl_ssi_private {
 	unsigned int irq;
 	struct snd_pcm_substream *first_stream;
 	struct snd_pcm_substream *second_stream;
-	unsigned int playback;
-	unsigned int capture;
-	int asynchronous;
 	unsigned int fifo_depth;
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct device_attribute dev_attr;
@@ -281,15 +277,19 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct fsl_ssi_private *ssi_private =
+		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
 
 	/*
 	 * If this is the first stream opened, then request the IRQ
 	 * and initialize the SSI registers.
 	 */
-	if (!ssi_private->playback && !ssi_private->capture) {
+	if (!ssi_private->first_stream) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
+		ssi_private->first_stream = substream;
+
 		/*
 		 * Section 16.5 of the MPC8610 reference manual says that the
 		 * SSI needs to be disabled before updating the registers we set
@@ -306,7 +306,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		clrsetbits_be32(&ssi->scr,
 			CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
 			CCSR_SSI_SCR_TFR_CLK_DIS | CCSR_SSI_SCR_I2S_MODE_SLAVE
-			| (ssi_private->asynchronous ? 0 : CCSR_SSI_SCR_SYN));
+			| (synchronous ? CCSR_SSI_SCR_SYN : 0));
 
 		out_be32(&ssi->stcr,
 			 CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
@@ -323,7 +323,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 * master.
 		 */
 
-		/* 4. Enable the interrupts and DMA requests */
+		/* Enable the interrupts and DMA requests */
 		out_be32(&ssi->sier, SIER_FLAGS);
 
 		/*
@@ -352,58 +352,47 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 * this is bad is because at this point, the PCM driver has not
 		 * finished initializing the DMA controller.
 		 */
-	}
-
-	if (!ssi_private->first_stream)
-		ssi_private->first_stream = substream;
-	else {
-		/* This is the second stream open, so we need to impose sample
-		 * rate and maybe sample size constraints.  Note that this can
-		 * cause a race condition if the second stream is opened before
-		 * the first stream is fully initialized.
-		 *
-		 * We provide some protection by checking to make sure the first
-		 * stream is initialized, but it's not perfect.  ALSA sometimes
-		 * re-initializes the driver with a different sample rate or
-		 * size.  If the second stream is opened before the first stream
-		 * has received its final parameters, then the second stream may
-		 * be constrained to the wrong sample rate or size.
-		 *
-		 * FIXME: This code does not handle opening and closing streams
-		 * repeatedly.  If you open two streams and then close the first
-		 * one, you may not be able to open another stream until you
-		 * close the second one as well.
-		 */
-		struct snd_pcm_runtime *first_runtime =
-			ssi_private->first_stream->runtime;
-
-		if (!first_runtime->sample_bits) {
-			dev_err(substream->pcm->card->dev,
-				"set sample size in %s stream first\n",
-				substream->stream == SNDRV_PCM_STREAM_PLAYBACK
-				? "capture" : "playback");
-			return -EAGAIN;
-		}
+	} else {
+		if (synchronous) {
+			struct snd_pcm_runtime *first_runtime =
+				ssi_private->first_stream->runtime;
+			/*
+			 * This is the second stream open, and we're in
+			 * synchronous mode, so we need to impose sample
+			 * sample size constraints. This is because STCCR is
+			 * used for playback and capture in synchronous mode,
+			 * so there's no way to specify different word
+			 * lengths.
+			 *
+			 * Note that this can cause a race condition if the
+			 * second stream is opened before the first stream is
+			 * fully initialized.  We provide some protection by
+			 * checking to make sure the first stream is
+			 * initialized, but it's not perfect.  ALSA sometimes
+			 * re-initializes the driver with a different sample
+			 * rate or size.  If the second stream is opened
+			 * before the first stream has received its final
+			 * parameters, then the second stream may be
+			 * constrained to the wrong sample rate or size.
+			 */
+			if (!first_runtime->sample_bits) {
+				dev_err(substream->pcm->card->dev,
+					"set sample size in %s stream first\n",
+					substream->stream ==
+					SNDRV_PCM_STREAM_PLAYBACK
+					? "capture" : "playback");
+				return -EAGAIN;
+			}
 
-		/* If we're in synchronous mode, then we need to constrain
-		 * the sample size as well.  We don't support independent sample
-		 * rates in asynchronous mode.
-		 */
-		if (!ssi_private->asynchronous)
 			snd_pcm_hw_constraint_minmax(substream->runtime,
 				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				first_runtime->sample_bits,
 				first_runtime->sample_bits);
+		}
 
 		ssi_private->second_stream = substream;
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ssi_private->playback++;
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		ssi_private->capture++;
-
 	return 0;
 }
 
@@ -424,24 +413,35 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	unsigned int sample_size =
+		snd_pcm_format_width(params_format(hw_params));
+	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
+	int enabled = in_be32(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
 
-	if (substream == ssi_private->first_stream) {
-		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-		unsigned int sample_size =
-			snd_pcm_format_width(params_format(hw_params));
-		u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
+	/*
+	 * If we're in synchronous mode, and the SSI is already enabled,
+	 * then STCCR is already set properly.
+	 */
+	if (enabled && ssi_private->cpu_dai_drv.symmetric_rates)
+		return 0;
 
-		/* The SSI should always be disabled at this points (SSIEN=0) */
+	/*
+	 * FIXME: The documentation says that SxCCR[WL] should not be
+	 * modified while the SSI is enabled.  The only time this can
+	 * happen is if we're trying to do simultaneous playback and
+	 * capture in asynchronous mode.  Unfortunately, I have been enable
+	 * to get that to work at all on the P1022DS.  Therefore, we don't
+	 * bother to disable/enable the SSI when setting SxCCR[WL], because
+	 * the SSI will stop anyway.  Maybe one day, this will get fixed.
+	 */
 
-		/* In synchronous mode, the SSI uses STCCR for capture */
-		if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
-		    !ssi_private->asynchronous)
-			clrsetbits_be32(&ssi->stccr,
-					CCSR_SSI_SxCCR_WL_MASK, wl);
-		else
-			clrsetbits_be32(&ssi->srccr,
-					CCSR_SSI_SxCCR_WL_MASK, wl);
-	}
+	/* In synchronous mode, the SSI uses STCCR for capture */
+	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
+	    ssi_private->cpu_dai_drv.symmetric_rates)
+		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+	else
+		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 
 	return 0;
 }
@@ -464,7 +464,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			setbits32(&ssi->scr,
@@ -500,12 +499,6 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ssi_private->playback--;
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		ssi_private->capture--;
-
 	if (ssi_private->first_stream == substream)
 		ssi_private->first_stream = ssi_private->second_stream;
 
@@ -514,7 +507,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	/*
 	 * If this is the last active substream, disable the SSI.
 	 */
-	if (!ssi_private->playback && !ssi_private->capture) {
+	if (!ssi_private->first_stream) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
 		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
@@ -688,9 +681,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	/* Are the RX and the TX clocks locked? */
-	if (of_find_property(np, "fsl,ssi-asynchronous", NULL))
-		ssi_private->asynchronous = 1;
-	else
+	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL))
 		ssi_private->cpu_dai_drv.symmetric_rates = 1;
 
 	/* Determine the FIFO depth. */
-- 
1.7.3.4
