From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 1/5] ASoC: codecs: msm8916-wcd-analog: move codec reset to probe
Date: Wed,  9 Aug 2017 18:49:23 +0200
Message-ID: <20170809164927.19663-2-srinivas.kandagatla@linaro.org>
References: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: damien.riegel@savoirfairelinux.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch move the codec reset code from dai ops to codec probe, so
that the codec is not held in reset when headset detection block is
still active.

Without this patch the codec block will be in reset as long as its not
actively used, which means headset events will not be functional if the
codec dai is not actively used. Point to note is that the headset
detection blocks will work in low power when there is no active audio
usecase and switch to micbias source when audio usecase is active.

Existing dapms should put the codec in low power state anyway when there
is no audio usecase.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 5710fd4..6606954 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -536,6 +536,9 @@ static int pm8916_wcd_analog_probe(struct snd_soc_codec *codec)
 		snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
 			      wcd_reg_defaults_2_0[reg].def);
 
+	snd_soc_update_bits(codec, CDC_D_CDC_RST_CTL,
+			    RST_CTL_DIG_SW_RST_N_MASK,
+			    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
 	return 0;
 }
 
@@ -543,6 +546,9 @@ static int pm8916_wcd_analog_remove(struct snd_soc_codec *codec)
 {
 	struct pm8916_wcd_analog_priv *priv = dev_get_drvdata(codec->dev);
 
+	snd_soc_update_bits(codec, CDC_D_CDC_RST_CTL,
+			    RST_CTL_DIG_SW_RST_N_MASK, 0);
+
 	return regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
 				      priv->supplies);
 }
@@ -736,28 +742,6 @@ static struct regmap *pm8916_get_regmap(struct device *dev)
 	return dev_get_regmap(dev->parent, NULL);
 }
 
-static int pm8916_wcd_analog_startup(struct snd_pcm_substream *substream,
-				      struct snd_soc_dai *dai)
-{
-	snd_soc_update_bits(dai->codec, CDC_D_CDC_RST_CTL,
-			    RST_CTL_DIG_SW_RST_N_MASK,
-			    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
-
-	return 0;
-}
-
-static void pm8916_wcd_analog_shutdown(struct snd_pcm_substream *substream,
-					 struct snd_soc_dai *dai)
-{
-	snd_soc_update_bits(dai->codec, CDC_D_CDC_RST_CTL,
-			    RST_CTL_DIG_SW_RST_N_MASK, 0);
-}
-
-static struct snd_soc_dai_ops pm8916_wcd_analog_dai_ops = {
-	.startup = pm8916_wcd_analog_startup,
-	.shutdown = pm8916_wcd_analog_shutdown,
-};
-
 static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 	[0] = {
 	       .name = "pm8916_wcd_analog_pdm_rx",
@@ -769,7 +753,6 @@ static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 			    .channels_min = 1,
 			    .channels_max = 3,
 			    },
-	       .ops = &pm8916_wcd_analog_dai_ops,
 	       },
 	[1] = {
 	       .name = "pm8916_wcd_analog_pdm_tx",
@@ -781,7 +764,6 @@ static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 			   .channels_min = 1,
 			   .channels_max = 4,
 			   },
-	       .ops = &pm8916_wcd_analog_dai_ops,
 	       },
 };
 
-- 
2.9.3
