From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ad193x: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:30 +0000
Message-ID: <E1elDNO-0004JF-WD@debutante>
References: <874ln5xpgc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 46E96267ABA
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:33 +0100 (CET)
In-Reply-To: <874ln5xpgc.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ad193x: replace codec to component

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

>From 89cea5c9a9f3dc487f39997801ff5191f2375369 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:25:29 +0000
Subject: [PATCH] ASoC: ad193x: replace codec to component

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
 sound/soc/codecs/ad193x-i2c.c |  7 -------
 sound/soc/codecs/ad193x-spi.c |  7 -------
 sound/soc/codecs/ad193x.c     | 46 ++++++++++++++++++++++---------------------
 3 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/ad193x-i2c.c b/sound/soc/codecs/ad193x-i2c.c
index 171313664bc8..b9551334f6b4 100644
--- a/sound/soc/codecs/ad193x-i2c.c
+++ b/sound/soc/codecs/ad193x-i2c.c
@@ -35,18 +35,11 @@ static int ad193x_i2c_probe(struct i2c_client *client,
 			    (enum ad193x_type)id->driver_data);
 }
 
-static int ad193x_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static struct i2c_driver ad193x_i2c_driver = {
 	.driver = {
 		.name = "ad193x",
 	},
 	.probe    = ad193x_i2c_probe,
-	.remove   = ad193x_i2c_remove,
 	.id_table = ad193x_id,
 };
 module_i2c_driver(ad193x_i2c_driver);
diff --git a/sound/soc/codecs/ad193x-spi.c b/sound/soc/codecs/ad193x-spi.c
index 23c28573bdb7..3c1394a803b8 100644
--- a/sound/soc/codecs/ad193x-spi.c
+++ b/sound/soc/codecs/ad193x-spi.c
@@ -29,12 +29,6 @@ static int ad193x_spi_probe(struct spi_device *spi)
 			    (enum ad193x_type)id->driver_data);
 }
 
-static int ad193x_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static const struct spi_device_id ad193x_spi_id[] = {
 	{ "ad193x", AD193X },
 	{ "ad1933", AD1933 },
@@ -51,7 +45,6 @@ static struct spi_driver ad193x_spi_driver = {
 		.name	= "ad193x",
 	},
 	.probe		= ad193x_spi_probe,
-	.remove		= ad193x_spi_remove,
 	.id_table	= ad193x_spi_id,
 };
 module_spi_driver(ad193x_spi_driver);
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index d10988eec0c1..4b60ebee491d 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -130,7 +130,7 @@ static inline bool ad193x_has_adc(const struct ad193x_priv *ad193x)
 
 static int ad193x_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(dai->codec);
+	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(dai->component);
 
 	if (mute)
 		regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL2,
@@ -146,7 +146,7 @@ static int ad193x_mute(struct snd_soc_dai *dai, int mute)
 static int ad193x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots, int width)
 {
-	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(dai->codec);
+	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(dai->component);
 	unsigned int channels;
 
 	switch (slots) {
@@ -179,7 +179,7 @@ static int ad193x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec_dai->codec);
+	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(codec_dai->component);
 	unsigned int adc_serfmt = 0;
 	unsigned int adc_fmt = 0;
 	unsigned int dac_fmt = 0;
@@ -257,8 +257,8 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int ad193x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
 	switch (freq) {
 	case 12288000:
 	case 18432000:
@@ -275,8 +275,8 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	int word_len = 0, master_rate = 0;
-	struct snd_soc_codec *codec = dai->codec;
-	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
 
 	/* bit size */
 	switch (params_width(params)) {
@@ -351,10 +351,10 @@ static struct snd_soc_dai_driver ad193x_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
-static int ad193x_codec_probe(struct snd_soc_codec *codec)
+static int ad193x_component_probe(struct snd_soc_component *component)
 {
-	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	int num, ret;
 
 	/* default setting for ad193x */
@@ -382,7 +382,7 @@ static int ad193x_codec_probe(struct snd_soc_codec *codec)
 	if (ad193x_has_adc(ad193x)) {
 		/* add adc controls */
 		num = ARRAY_SIZE(ad193x_adc_snd_controls);
-		ret = snd_soc_add_codec_controls(codec,
+		ret = snd_soc_add_component_controls(component,
 						 ad193x_adc_snd_controls,
 						 num);
 		if (ret)
@@ -408,16 +408,18 @@ static int ad193x_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_ad193x = {
-	.probe = ad193x_codec_probe,
-	.component_driver = {
-		.controls		= ad193x_snd_controls,
-		.num_controls		= ARRAY_SIZE(ad193x_snd_controls),
-		.dapm_widgets		= ad193x_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ad193x_dapm_widgets),
-		.dapm_routes		= audio_paths,
-		.num_dapm_routes	= ARRAY_SIZE(audio_paths),
-	},
+static const struct snd_soc_component_driver soc_component_dev_ad193x = {
+	.probe			= ad193x_component_probe,
+	.controls		= ad193x_snd_controls,
+	.num_controls		= ARRAY_SIZE(ad193x_snd_controls),
+	.dapm_widgets		= ad193x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ad193x_dapm_widgets),
+	.dapm_routes		= audio_paths,
+	.num_dapm_routes	= ARRAY_SIZE(audio_paths),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 const struct regmap_config ad193x_regmap_config = {
@@ -442,7 +444,7 @@ int ad193x_probe(struct device *dev, struct regmap *regmap,
 
 	dev_set_drvdata(dev, ad193x);
 
-	return snd_soc_register_codec(dev, &soc_codec_dev_ad193x,
+	return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
 		&ad193x_dai, 1);
 }
 EXPORT_SYMBOL_GPL(ad193x_probe);
-- 
2.16.1
