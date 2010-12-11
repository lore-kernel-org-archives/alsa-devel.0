From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2 07/16] ASoC: twl6040: Fix PCM error handling
	ops
Date: Fri, 10 Dec 2010 21:05:54 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225D6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BF521039A9
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 04:05:56 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch moves all the PCM error handling for clock config
out of trigger() and startup() and into prepare().

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |   55 +++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index d15ea44..a89e7b8 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -865,23 +865,6 @@ static int twl6040_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = rtd->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
-	if (!priv->sysclk) {
-		dev_err(codec->dev,
-			"no mclk configured, call set_sysclk() on init\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * capture is not supported at 17.64 MHz,
-	 * it's reserved for headset low-power playback scenario
-	 */
-	if ((priv->sysclk == 17640000) && substream->stream) {
-		dev_err(codec->dev,
-			"capture mode is not supported at %dHz\n",
-			priv->sysclk);
-		return -EINVAL;
-	}
-
 	snd_pcm_hw_constraint_list(substream->runtime, 0,
 				SNDRV_PCM_HW_PARAM_RATE,
 				priv->sysclk_constraints);
@@ -925,31 +908,37 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int twl6040_trigger(struct snd_pcm_substream *substream,
-			int cmd, struct snd_soc_dai *dai)
+static int twl6040_prepare(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-		/*
-		 * low-power playback mode is restricted
-		 * for headset path only
-		 */
-		if ((priv->sysclk == 17640000) && priv->non_lp) {
+	if (!priv->sysclk) {
+		dev_err(codec->dev,
+			"no mclk configured, call set_sysclk() on init\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * capture is not supported at 17.64 MHz,
+	 * it's reserved for headset low-power playback scenario
+	 */
+	if ((priv->sysclk == 17640000) &&
+			substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		dev_err(codec->dev,
+			"capture mode is not supported at %dHz\n",
+			priv->sysclk);
+		return -EINVAL;
+	}
+
+	if ((priv->sysclk == 17640000) && priv->non_lp) {
 			dev_err(codec->dev,
 				"some enabled paths aren't supported at %dHz\n",
 				priv->sysclk);
 			return -EPERM;
-		}
-		break;
-	default:
-		break;
 	}
-
 	return 0;
 }
 
@@ -1063,7 +1052,7 @@ static int twl6040_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static struct snd_soc_dai_ops twl6040_dai_ops = {
 	.startup	= twl6040_startup,
 	.hw_params	= twl6040_hw_params,
-	.trigger	= twl6040_trigger,
+	.prepare	= twl6040_prepare,
 	.set_sysclk	= twl6040_set_dai_sysclk,
 };
 
-- 
1.7.0.4
