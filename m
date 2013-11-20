From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 7/8] ASoC: fsl-ssi: Drop ac97 specific trigger
	function
Date: Wed, 20 Nov 2013 10:04:21 +0100
Message-ID: <1384938262-20554-8-git-send-email-mpa@pengutronix.de>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2529E261AED
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 10:04:53 +0100 (CET)
In-Reply-To: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The normal trigger function can now be used for AC97. Drop AC97 trigger
function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 61 ++++++-------------------------------------------
 1 file changed, 7 insertions(+), 54 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c2bd7cd..4d155af 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -854,6 +854,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
+	if (ssi_private->imx_ac97) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
+		else
+			write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
+	}
 
 	return 0;
 }
@@ -917,59 +923,6 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 	.name		= "fsl-ssi",
 };
 
-/**
- * fsl_ssi_ac97_trigger: start and stop the AC97 receive/transmit.
- *
- * This function is called by ALSA to start, stop, pause, and resume the
- * transfer of data.
- */
-static int fsl_ssi_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
-			   struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(
-			rtd->cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_TIE |
-					CCSR_SSI_SIER_TFE0_EN);
-		else
-			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_RIE |
-					CCSR_SSI_SIER_RFF0_EN);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_TIE |
-					CCSR_SSI_SIER_TFE0_EN, 0);
-		else
-			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_RIE |
-					CCSR_SSI_SIER_RFF0_EN, 0);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
-	else
-		write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
-
-	return 0;
-}
-
-static const struct snd_soc_dai_ops fsl_ssi_ac97_dai_ops = {
-	.startup	= fsl_ssi_startup,
-	.shutdown	= fsl_ssi_shutdown,
-	.trigger	= fsl_ssi_ac97_trigger,
-};
-
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.ac97_control = 1,
 	.playback = {
@@ -986,7 +939,7 @@ static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = &fsl_ssi_ac97_dai_ops,
+	.ops = &fsl_ssi_dai_ops,
 };
 
 
-- 
1.8.4.2
