From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ALSA: ASoC V2: restrict sample rate and size
	in Freescale MPC8610 sound drivers
Date: Mon,  4 Aug 2008 11:31:46 -0500
Message-ID: <1217867506-19730-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 857D9243D9
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 18:31:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Freescale MPC8610 SSI device has the option of using one clock for both
transmit and receive (synchronous mode), or independent clocks (asynchronous).
The SSI driver, however, programs the SSI into synchronous mode and then
tries to program the clock registers independently.  The result is that the
wrong sample size is usually generated during recording.

This patch fixes the discrepancy by restricting the sample rate and sample size
of the playback and capture streams.  The SSI driver remembers which stream
is opened first.  When a second stream is opened, that stream is constrained
to the same sample rate and size as the first stream.

The spinlock used to protect SCR was also removed, because it just made the
code more complicated.

A future version of this driver will lift the sample size restriction.
Supporting independent sample rates is more difficult, because only certain
codecs provide dual independent clocks.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for ASoC V2.  A similar patch for ASoC V1 has already been
posted and applied.

 sound/soc/fsl/fsl_ssi.c |  122 +++++++++++++++++++++++++++++++----------------
 sound/soc/fsl/fsl_ssi.h |    3 +-
 2 files changed, 82 insertions(+), 43 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index bcb1880..4858ff1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -241,18 +241,13 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 * SSI needs to be disabled before updating the registers we set
 		 * here.
 		 */
-		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+		out_be32(&ssi->scr, 0);
 
 		/*
 		 * Program the SSI into I2S Slave Non-Network Synchronous mode.
-		 * Also enable the transmit and receive FIFO.  Make sure TE and
-		 * RE are disabled.
-		 *
-		 * FIXME: Little-endian samples require a different shift dir
+		 * Also enable the transmit and receive FIFO.
 		 */
-		clrsetbits_be32(&ssi->scr, CCSR_SSI_SCR_I2S_MODE_MASK |
-			CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
-			CCSR_SSI_SCR_TFR_CLK_DIS |
+		setbits32(&ssi->scr, CCSR_SSI_SCR_TFR_CLK_DIS |
 			CCSR_SSI_SCR_I2S_MODE_SLAVE | CCSR_SSI_SCR_SYN);
 
 		out_be32(&ssi->stcr,
@@ -286,8 +281,6 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		out_be32(&ssi->sfcsr,
 			 CCSR_SSI_SFCSR_TFWM0(6) | CCSR_SSI_SFCSR_RFWM0(2));
 
-		spin_unlock(&ssi_info->lock);
-
 		/*
 		 * We keep the SSI disabled because if we enable it, then the
 		 * DMA controller will start.  It's not supposed to start until
@@ -299,6 +292,45 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 */
 	}
 
+	if (!ssi_info->master_stream)
+		ssi_info->master_stream = substream;
+	else {
+		/* This is the slave stream open, so we need to impose sample
+		 * rate and sample size constraints.  Note that this can cause a
+		 * race condition if the slave stream is opened before the
+		 * master stream is fully initialized.
+		 *
+		 * We provide some protection by checking to make sure the
+		 * master stream is initialized, but it's not perfect.  ALSA
+		 * sometimes re-initializes the driver with a different sample
+		 * rate or size.  If the slave stream is opened before the
+		 * master stream has received its final parameters, then the
+		 * slave stream may be constrained to the wrong sample rate or
+		 * size.
+		 */
+		struct snd_pcm_runtime *first_runtime =
+			ssi_info->master_stream->runtime;
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
+
+		ssi_info->slave_stream = substream;
+	}
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		ssi_info->playback = 1;
 	else
@@ -325,38 +357,20 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 static int fsl_ssi_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
-	struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
-	uint32_t wl;
-	u32 scr;
-	u32 sxccr;
 
-	wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
-
-	spin_lock(&ssi_info->lock);
-
-	scr = in_be32(&ssi->scr);
+	if (substream == ssi_info->master_stream) {
+		struct snd_pcm_runtime *runtime = substream->runtime;
+		struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
+		u32 wl;
 
-	/* If the SSI is currently enabled, then we want to keep it disabled for
-	 * as short as time as possible, so we pre-calculate all the values for
-	 * the appropriate registers, and then program them rapidly.
-	 */
+		/* The SSI should always be disabled at this points (SSIEN=0) */
+		wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		sxccr = (in_be32(&ssi->stccr) & ~CCSR_SSI_SxCCR_WL_MASK) | wl;
-		out_be32(&ssi->scr, scr & ~CCSR_SSI_SCR_SSIEN);
-		out_be32(&ssi->stccr, sxccr);
-		out_be32(&ssi->scr, scr);
-	} else {
-		sxccr = (in_be32(&ssi->srccr) & ~CCSR_SSI_SxCCR_WL_MASK) | wl;
-		out_be32(&ssi->scr, scr & ~CCSR_SSI_SCR_SSIEN);
-		out_be32(&ssi->srccr, sxccr);
-		out_be32(&ssi->scr, scr);
+		/* In synchronous mode, the SSI uses STCCR for capture */
+		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 	}
 
-	spin_unlock(&ssi_info->lock);
-
 	return 0;
 }
 
@@ -368,6 +382,23 @@ static int fsl_ssi_prepare(struct snd_pcm_substream *substream,
  *
  * The DMA channel is in external master start and pause mode, which
  * means the SSI completely controls the flow of data.
+ *
+ * The SSI is disabled and re-enabled to reset its connection to the DMA
+ * controller.  The SSI communicates with the DMA controller when it is
+ * enabled, even if the SCR.TE and SCR.RE bits are zero.  This means that
+ * the DMA controller must be programmed (at least partially) for playback
+ * *and* capture, before the SSI is enabled.
+ *
+ * This is a problem for simultaneous playback and capture, because the
+ * streams are not created at the same time.  If playback is started first,
+ * then the DMA controller will not be programmed correctly for capture when
+ * the SSI is enabled for playback.
+ *
+ * The solution is to temporary disable the SSI when starting playback or
+ * capture, even if capture or playback is already running.  When the SSI is
+ * re-enabled, the first stream will continue, so it will still be
+ * programmed correctly.  The SSI will also tell the DMA controller to start
+ * operations for the second stream.
  */
 static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_dai *cpu_dai)
@@ -380,12 +411,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		spin_lock(&ssi_info->lock);
-
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 			setbits32(&ssi->scr,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
-		else {
+		} else {
+			clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 			setbits32(&ssi->scr,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
 
@@ -396,8 +427,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			 */
 			mdelay(1);
 		}
-
-		spin_unlock(&ssi_info->lock);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -431,6 +460,15 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	else
 		ssi_info->capture = 0;
 
+	/* If we're closing the master stream, then the slave stream becomes
+	 * the new master.  If there is no slave stream, then slave_stream is
+	   NULL, so this code still works. */
+	if (ssi_info->master_stream == substream)
+		ssi_info->master_stream = ssi_info->slave_stream;
+
+	/* Either way, there is no slave stream any more. */
+	ssi_info->slave_stream = NULL;
+
 	/*
 	 * If this is the last active substream, disable the SSI and release
 	 * the IRQ.
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 91af81c..160b8bc 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -226,7 +226,8 @@ struct fsl_ssi_info {
 	unsigned int irq;
 	unsigned int playback;
 	unsigned int capture;
-	spinlock_t lock;
+	struct snd_pcm_substream *master_stream;
+	struct snd_pcm_substream *slave_stream;
 	struct snd_soc_dai *dai;
 	struct device_attribute dev_attr;
 	u32 pmuxcr;
-- 
1.5.5
