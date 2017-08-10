From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-analog: move codec reset to probe" to the asoc tree
Date: Thu, 10 Aug 2017 16:42:02 +0100
Message-ID: <E1dfpb0-0001gO-0K@finisterre>
References: <20170726003512.18965-4-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726003512.18965-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd-analog: move codec reset to probe

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 52981e29eedf6e90ee381c2c1a64be1848d3353e Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 Aug 2017 18:49:23 +0200
Subject: [PATCH] ASoC: codecs: msm8916-wcd-analog: move codec reset to probe

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index a78802920c3c..f9a74ff2ce99 100644
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
2.13.2
