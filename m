From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 7/9] ASoC: fsl-ssi: Drop ac97 specific trigger function
Date: Mon, 25 Nov 2013 12:13:43 +0100
Message-ID: <1385378025-1262-8-git-send-email-mpa@pengutronix.de>
References: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
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
index 21b300c..cf55da0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -850,6 +850,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -913,59 +919,6 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
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
@@ -982,7 +935,7 @@ static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = &fsl_ssi_ac97_dai_ops,
+	.ops = &fsl_ssi_dai_ops,
 };
 
 
-- 
1.8.4.2
