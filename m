From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9860: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:41:55 +0000
Message-ID: <E1elDQh-0004u3-Gw@debutante>
References: <87tvv5z50g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C8439267833
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:41:57 +0100 (CET)
In-Reply-To: <87tvv5z50g.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9860: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fbf60d9727d544c5c9676b5e9a1baab0704cc9ed Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:04:07 +0000
Subject: [PATCH] ASoC: max9860: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 1	->	.idle_bias_on = 0
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9860.c | 70 ++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index a2dc6a47f466..5bbf889ad98e 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -261,8 +261,8 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max9860_priv *max9860 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max9860_priv *max9860 = snd_soc_component_get_drvdata(component);
 	u8 master;
 	u8 ifc1a = 0;
 	u8 ifc1b = 0;
@@ -270,7 +270,7 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 	unsigned long n;
 	int ret;
 
-	dev_dbg(codec->dev, "hw_params %u Hz, %u channels\n",
+	dev_dbg(component->dev, "hw_params %u Hz, %u channels\n",
 		params_rate(params),
 		params_channels(params));
 
@@ -306,7 +306,7 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		if (params_width(params) != 16) {
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"DSP_A works for 16 bits per sample only.\n");
 			return -EINVAL;
 		}
@@ -315,7 +315,7 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		if (params_width(params) != 16) {
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"DSP_B works for 16 bits per sample only.\n");
 			return -EINVAL;
 		}
@@ -352,16 +352,16 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	dev_dbg(codec->dev, "IFC1A  %02x\n", ifc1a);
+	dev_dbg(component->dev, "IFC1A  %02x\n", ifc1a);
 	ret = regmap_write(max9860->regmap, MAX9860_IFC1A, ifc1a);
 	if (ret) {
-		dev_err(codec->dev, "Failed to set IFC1A: %d\n", ret);
+		dev_err(component->dev, "Failed to set IFC1A: %d\n", ret);
 		return ret;
 	}
-	dev_dbg(codec->dev, "IFC1B  %02x\n", ifc1b);
+	dev_dbg(component->dev, "IFC1B  %02x\n", ifc1b);
 	ret = regmap_write(max9860->regmap, MAX9860_IFC1B, ifc1b);
 	if (ret) {
-		dev_err(codec->dev, "Failed to set IFC1B: %d\n", ret);
+		dev_err(component->dev, "Failed to set IFC1B: %d\n", ret);
 		return ret;
 	}
 
@@ -417,33 +417,33 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	sysclk |= max9860->psclk;
-	dev_dbg(codec->dev, "SYSCLK %02x\n", sysclk);
+	dev_dbg(component->dev, "SYSCLK %02x\n", sysclk);
 	ret = regmap_write(max9860->regmap,
 			   MAX9860_SYSCLK, sysclk);
 	if (ret) {
-		dev_err(codec->dev, "Failed to set SYSCLK: %d\n", ret);
+		dev_err(component->dev, "Failed to set SYSCLK: %d\n", ret);
 		return ret;
 	}
-	dev_dbg(codec->dev, "N %lu\n", n);
+	dev_dbg(component->dev, "N %lu\n", n);
 	ret = regmap_write(max9860->regmap,
 			   MAX9860_AUDIOCLKHIGH, n >> 8);
 	if (ret) {
-		dev_err(codec->dev, "Failed to set NHI: %d\n", ret);
+		dev_err(component->dev, "Failed to set NHI: %d\n", ret);
 		return ret;
 	}
 	ret = regmap_write(max9860->regmap,
 			   MAX9860_AUDIOCLKLOW, n & 0xff);
 	if (ret) {
-		dev_err(codec->dev, "Failed to set NLO: %d\n", ret);
+		dev_err(component->dev, "Failed to set NLO: %d\n", ret);
 		return ret;
 	}
 
 	if (!master) {
-		dev_dbg(codec->dev, "Enable PLL\n");
+		dev_dbg(component->dev, "Enable PLL\n");
 		ret = regmap_update_bits(max9860->regmap, MAX9860_AUDIOCLKHIGH,
 					 MAX9860_PLL, MAX9860_PLL);
 		if (ret) {
-			dev_err(codec->dev, "Failed to enable PLL: %d\n", ret);
+			dev_err(component->dev, "Failed to enable PLL: %d\n", ret);
 			return ret;
 		}
 	}
@@ -453,8 +453,8 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 
 static int max9860_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max9860_priv *max9860 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max9860_priv *max9860 = snd_soc_component_get_drvdata(component);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -500,10 +500,10 @@ static struct snd_soc_dai_driver max9860_dai = {
 	.symmetric_rates = 1,
 };
 
-static int max9860_set_bias_level(struct snd_soc_codec *codec,
+static int max9860_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
-	struct max9860_priv *max9860 = dev_get_drvdata(codec->dev);
+	struct max9860_priv *max9860 = dev_get_drvdata(component->dev);
 	int ret;
 
 	switch (level) {
@@ -515,7 +515,7 @@ static int max9860_set_bias_level(struct snd_soc_codec *codec,
 		ret = regmap_update_bits(max9860->regmap, MAX9860_PWRMAN,
 					 MAX9860_SHDN, MAX9860_SHDN);
 		if (ret) {
-			dev_err(codec->dev, "Failed to remove SHDN: %d\n", ret);
+			dev_err(component->dev, "Failed to remove SHDN: %d\n", ret);
 			return ret;
 		}
 		break;
@@ -524,7 +524,7 @@ static int max9860_set_bias_level(struct snd_soc_codec *codec,
 		ret = regmap_update_bits(max9860->regmap, MAX9860_PWRMAN,
 					 MAX9860_SHDN, 0);
 		if (ret) {
-			dev_err(codec->dev, "Failed to request SHDN: %d\n",
+			dev_err(component->dev, "Failed to request SHDN: %d\n",
 				ret);
 			return ret;
 		}
@@ -534,18 +534,17 @@ static int max9860_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static const struct snd_soc_codec_driver max9860_codec_driver = {
-	.set_bias_level = max9860_set_bias_level,
-	.idle_bias_off = true,
-
-	.component_driver = {
-		.controls		= max9860_controls,
-		.num_controls		= ARRAY_SIZE(max9860_controls),
-		.dapm_widgets		= max9860_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(max9860_dapm_widgets),
-		.dapm_routes		= max9860_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(max9860_dapm_routes),
-	},
+static const struct snd_soc_component_driver max9860_component_driver = {
+	.set_bias_level		= max9860_set_bias_level,
+	.controls		= max9860_controls,
+	.num_controls		= ARRAY_SIZE(max9860_controls),
+	.dapm_widgets		= max9860_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max9860_dapm_widgets),
+	.dapm_routes		= max9860_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(max9860_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 #ifdef CONFIG_PM
@@ -698,7 +697,7 @@ static int max9860_probe(struct i2c_client *i2c,
 	pm_runtime_enable(dev);
 	pm_runtime_idle(dev);
 
-	ret = snd_soc_register_codec(dev, &max9860_codec_driver,
+	ret = devm_snd_soc_register_component(dev, &max9860_component_driver,
 				     &max9860_dai, 1);
 	if (ret) {
 		dev_err(dev, "Failed to register CODEC: %d\n", ret);
@@ -719,7 +718,6 @@ static int max9860_remove(struct i2c_client *i2c)
 	struct device *dev = &i2c->dev;
 	struct max9860_priv *max9860 = dev_get_drvdata(dev);
 
-	snd_soc_unregister_codec(dev);
 	pm_runtime_disable(dev);
 	regulator_disable(max9860->dvddio);
 	return 0;
-- 
2.16.1
