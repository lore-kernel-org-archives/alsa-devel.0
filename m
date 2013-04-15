From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/17] ASoC: imx: Setup dma data in DAI probe
Date: Mon, 15 Apr 2013 19:19:58 +0200
Message-ID: <1366046404-8759-12-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id AE822265263
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:25 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

This allows us to access the DAI DMA data when we create the PCM. We'll use
this when converting imx to generic DMA engine PCM driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/fsl_ssi.c | 19 +++++++++++++------
 sound/soc/fsl/imx-ssi.c | 22 ++++------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 42366d7..0f0bed6 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -425,12 +425,6 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		ssi_private->second_stream = substream;
 	}
 
-	if (ssi_private->ssi_on_imx)
-		snd_soc_dai_set_dma_data(dai, substream,
-			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-				&ssi_private->dma_params_tx :
-				&ssi_private->dma_params_rx);
-
 	return 0;
 }
 
@@ -552,6 +546,18 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	}
 }
 
+static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(dai);
+
+	if (ssi_private->ssi_on_imx) {
+		dai->playback_dma_data = &ssi_private->dma_params_tx;
+		dai->capture_dma_data = &ssi_private->dma_params_rx;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
 	.hw_params	= fsl_ssi_hw_params,
@@ -561,6 +567,7 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 
 /* Template for the CPU dai driver structure */
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
+	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		/* The SSI does not support monaural audio. */
 		.channels_min = 2,
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 4ce2d60..902fab0 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -232,23 +232,6 @@ static int imx_ssi_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
-static int imx_ssi_startup(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *cpu_dai)
-{
-	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
-	struct snd_dmaengine_dai_dma_data *dma_data;
-
-	/* Tx/Rx config */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = &ssi->dma_params_tx;
-	else
-		dma_data = &ssi->dma_params_rx;
-
-	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
-
-	return 0;
-}
-
 /*
  * Should only be called when port is inactive (i.e. SSIEN = 0),
  * although can be called multiple times by upper layers.
@@ -353,7 +336,6 @@ static int imx_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 }
 
 static const struct snd_soc_dai_ops imx_ssi_pcm_dai_ops = {
-	.startup	= imx_ssi_startup,
 	.hw_params	= imx_ssi_hw_params,
 	.set_fmt	= imx_ssi_set_dai_fmt,
 	.set_clkdiv	= imx_ssi_set_dai_clkdiv,
@@ -373,6 +355,10 @@ static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
 		SSI_SFCSR_RFWM0(ssi->dma_params_rx.maxburst);
 	writel(val, ssi->base + SSI_SFCSR);
 
+	/* Tx/Rx config */
+	dai->playback_dma_data = &ssi->dma_params_tx;
+	dai->capture_dma_data = &ssi->dma_params_rx;
+
 	return 0;
 }
 
-- 
1.8.0
