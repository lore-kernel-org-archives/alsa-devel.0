From: Markus Pargmann <mpa@pengutronix.de>
Subject: [RFC 8/9] ASoC: fsl-ssi: Drop ac97 specific trigger
	function
Date: Fri, 15 Nov 2013 16:49:43 +0100
Message-ID: <1384530584-31273-9-git-send-email-mpa@pengutronix.de>
References: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A466A2652C5
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 16:52:36 +0100 (CET)
In-Reply-To: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
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
 sound/soc/fsl/fsl_ssi.c | 50 +------------------------------------------------
 1 file changed, 1 insertion(+), 49 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2728b97..9a960b8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -915,54 +915,6 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
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
@@ -979,7 +931,7 @@ static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = &fsl_ssi_ac97_dai_ops,
+	.ops = &fsl_ssi_dai_ops,
 };
 
 
-- 
1.8.4.2
