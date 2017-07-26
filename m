From: srinivas.kandagatla@linaro.org
Subject: [PATCH v1 3/6] ASoC: codecs: msm8916-wcd-analog: move
	codec reset to probe
Date: Wed, 26 Jul 2017 02:35:09 +0200
Message-ID: <20170726003512.18965-4-srinivas.kandagatla@linaro.org>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D9DAF267393
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 02:35:30 +0200 (CEST)
Received: by mail-io0-f169.google.com with SMTP id g35so29488165ioi.3
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 17:35:30 -0700 (PDT)
In-Reply-To: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch move the codec reset code from dai ops to codec probe, so
that the codec is not held in reset when headset detection block is
still active.

Without this patch the codec block will be in reset as long as its not
actively used, which means headset events will not be functional if the
codec dai is not actively used.

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
