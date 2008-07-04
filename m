From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 1/2] ALSA: soc - fsl_ssi.c fix audio capture
Date: Fri, 4 Jul 2008 19:43:46 +0400
Message-ID: <20080704154346.GA27136@polina.dev.rtsoft.ru>
References: <20080704154313.GA11635@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by alsa0.perex.cz (Postfix) with ESMTP id E36D424A8B
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 17:43:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080704154313.GA11635@polina.dev.rtsoft.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since we're using SSI in synchronous mode, the STCCR register controls
both the receive and transmit sections. So, when we're trying to record
anything, stccr register does not get initialized, thus the output file
filled with the white noise.

Fix this by initializing the STCCR for both playback and capture.

Also use hw_params and hw_free callbacks, so that we won't fail at the
last moment, thus applications could negotiate.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 sound/soc/fsl/fsl_ssi.c |   69 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 145ad13..07b19ed 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -69,6 +69,8 @@
  * @ssi_phys: physical address of the SSI registers
  * @irq: IRQ of this SSI
  * @dev: struct device pointer
+ * @master_substream: substream that owns hw params
+ * @width: format width that master substream has configured
  * @playback: the number of playback streams opened
  * @capture: the number of capture streams opened
  * @cpu_dai: the CPU DAI for this device
@@ -81,6 +83,8 @@ struct fsl_ssi_private {
 	dma_addr_t ssi_phys;
 	unsigned int irq;
 	struct device *dev;
+	struct snd_pcm_substream *master_substream;
+	unsigned int width;
 	unsigned int playback;
 	unsigned int capture;
 	struct snd_soc_cpu_dai cpu_dai;
@@ -367,22 +371,24 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream)
  */
 static int fsl_ssi_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
 
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-	u32 wl;
-
-	wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
+	u32 wl = CCSR_SSI_SxCCR_WL(ssi_private->width);
 
 	clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
-	else
-		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
-
+	/*
+	 * MPC8610 spec says: "The STCCR register is dedicated to the transmit
+	 * section, and the SRCCR register is dedicated to the receive section
+	 * except in Synchronous mode, in which the STCCR register controls
+	 * both the receive and transmit sections."
+	 * So, the width for TX and RX should match, otherwise we're busy with
+	 * either TX or RX. Also, STCK and SRCK lines could be wired together,
+	 * so we also program the SRCCR, so that TX and RX will not conflict.
+	 */
+	clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+	clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 	setbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 
 	return 0;
@@ -461,6 +467,8 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream)
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
 		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, 0);
+		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, 0);
 
 		free_irq(ssi_private->irq, ssi_private);
 	}
@@ -503,6 +511,45 @@ static int fsl_ssi_set_fmt(struct snd_soc_cpu_dai *cpu_dai, unsigned int format)
 	return (format == SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
 }
 
+static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+	unsigned int width = snd_pcm_format_width(params_format(params));
+
+	/*
+	 * If there is no hw_params' master substream, first one becomes
+	 * master. All other substreams must comply with the format width
+	 * of the master substream.
+	 */
+	if (!ssi_private->master_substream)
+		ssi_private->master_substream = substream;
+	else if (ssi_private->master_substream != substream &&
+			ssi_private->width != width)
+		return -EINVAL;
+	/*
+	 * hw_params callback can be issued multiple times with different
+	 * params, for example when an application negotiates the parameters.
+	 */
+	ssi_private->width = width;
+	return 0;
+}
+
+static int fsl_ssi_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+
+	/*
+	 * Master substream don't want to own the hw params anymore, so from
+	 * now on other streams could do their own params.
+	 */
+	if (ssi_private->master_substream == substream)
+		ssi_private->master_substream = NULL;
+	return 0;
+}
+
 /**
  * fsl_ssi_dai_template: template CPU DAI for the SSI
  */
@@ -522,6 +569,8 @@ static struct snd_soc_cpu_dai fsl_ssi_dai_template = {
 	},
 	.ops = {
 		.startup = fsl_ssi_startup,
+		.hw_params = fsl_ssi_hw_params,
+		.hw_free = fsl_ssi_hw_free,
 		.prepare = fsl_ssi_prepare,
 		.shutdown = fsl_ssi_shutdown,
 		.trigger = fsl_ssi_trigger,
-- 
1.5.5.4
