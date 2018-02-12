From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: jz4740: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:34:25 +0000
Message-ID: <E1elDJR-0003iK-Mx@debutante>
References: <87efm9uvha.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1CC2676B4
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:34:27 +0100 (CET)
In-Reply-To: <87efm9uvha.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: jz4740: replace codec to component

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

>From b48e6ef3a1db8527d0c99e578f3dd3ee40a2d573 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:43:36 +0000
Subject: [PATCH] ASoC: jz4740: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4740.c | 50 +++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 6324ccdc8a5c..9395b583432c 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -157,7 +157,7 @@ static const struct snd_soc_dapm_route jz4740_codec_dapm_routes[] = {
 static int jz4740_codec_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(dai->codec);
+	struct jz4740_codec *jz4740_codec = snd_soc_component_get_drvdata(dai->component);
 	uint32_t val;
 
 	switch (params_rate(params)) {
@@ -236,10 +236,10 @@ static void jz4740_codec_wakeup(struct regmap *regmap)
 	regcache_sync(regmap);
 }
 
-static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
+static int jz4740_codec_set_bias_level(struct snd_soc_component *component,
 	enum snd_soc_bias_level level)
 {
-	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(codec);
+	struct jz4740_codec *jz4740_codec = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = jz4740_codec->regmap;
 	unsigned int mask;
 	unsigned int value;
@@ -257,7 +257,7 @@ static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* The only way to clear the suspend flag is to reset the codec */
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
 			jz4740_codec_wakeup(regmap);
 
 		mask = JZ4740_CODEC_1_VREF_DISABLE |
@@ -283,9 +283,9 @@ static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
+static int jz4740_codec_dev_probe(struct snd_soc_component *component)
 {
-	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(codec);
+	struct jz4740_codec *jz4740_codec = snd_soc_component_get_drvdata(component);
 
 	regmap_update_bits(jz4740_codec->regmap, JZ4740_REG_CODEC_1,
 			JZ4740_CODEC_1_SW2_ENABLE, JZ4740_CODEC_1_SW2_ENABLE);
@@ -293,19 +293,21 @@ static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
-	.probe = jz4740_codec_dev_probe,
-	.set_bias_level = jz4740_codec_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= jz4740_codec_controls,
-		.num_controls		= ARRAY_SIZE(jz4740_codec_controls),
-		.dapm_widgets		= jz4740_codec_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(jz4740_codec_dapm_widgets),
-		.dapm_routes		= jz4740_codec_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(jz4740_codec_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_codec_dev_jz4740_codec = {
+	.probe			= jz4740_codec_dev_probe,
+	.set_bias_level		= jz4740_codec_set_bias_level,
+	.controls		= jz4740_codec_controls,
+	.num_controls		= ARRAY_SIZE(jz4740_codec_controls),
+	.dapm_widgets		= jz4740_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(jz4740_codec_dapm_widgets),
+	.dapm_routes		= jz4740_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(jz4740_codec_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+
 };
 
 static const struct regmap_config jz4740_codec_regmap_config = {
@@ -343,7 +345,7 @@ static int jz4740_codec_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, jz4740_codec);
 
-	ret = snd_soc_register_codec(&pdev->dev,
+	ret = devm_snd_soc_register_component(&pdev->dev,
 			&soc_codec_dev_jz4740_codec, &jz4740_codec_dai, 1);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to register codec\n");
@@ -351,16 +353,8 @@ static int jz4740_codec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int jz4740_codec_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-
-	return 0;
-}
-
 static struct platform_driver jz4740_codec_driver = {
 	.probe = jz4740_codec_probe,
-	.remove = jz4740_codec_remove,
 	.driver = {
 		.name = "jz4740-codec",
 	},
-- 
2.16.1
