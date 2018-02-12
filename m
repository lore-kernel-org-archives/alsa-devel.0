From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adav80x: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:40:39 +0000
Message-ID: <E1elDPT-0004kP-L3@debutante>
References: <87efm9z4qf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01AEC267BB4
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:40:42 +0100 (CET)
In-Reply-To: <87efm9z4qf.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: adav80x: replace codec to component

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

>From a05655877f8f514431158a3f406ae10b4b6c4af3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:10:06 +0000
Subject: [PATCH] ASoC: adav80x: replace codec to component

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
 sound/soc/codecs/adav801.c |   7 ---
 sound/soc/codecs/adav803.c |   7 ---
 sound/soc/codecs/adav80x.c | 130 ++++++++++++++++++++++-----------------------
 3 files changed, 65 insertions(+), 79 deletions(-)

diff --git a/sound/soc/codecs/adav801.c b/sound/soc/codecs/adav801.c
index 055f1228c2b4..d82f79dd1b38 100644
--- a/sound/soc/codecs/adav801.c
+++ b/sound/soc/codecs/adav801.c
@@ -30,18 +30,11 @@ static int adav80x_spi_probe(struct spi_device *spi)
 	return adav80x_bus_probe(&spi->dev, devm_regmap_init_spi(spi, &config));
 }
 
-static int adav80x_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static struct spi_driver adav80x_spi_driver = {
 	.driver = {
 		.name	= "adav801",
 	},
 	.probe		= adav80x_spi_probe,
-	.remove		= adav80x_spi_remove,
 	.id_table	= adav80x_spi_id,
 };
 module_spi_driver(adav80x_spi_driver);
diff --git a/sound/soc/codecs/adav803.c b/sound/soc/codecs/adav803.c
index 52881faedcf6..deb14bc0f1f7 100644
--- a/sound/soc/codecs/adav803.c
+++ b/sound/soc/codecs/adav803.c
@@ -27,18 +27,11 @@ static int adav803_probe(struct i2c_client *client,
 		devm_regmap_init_i2c(client, &adav80x_regmap_config));
 }
 
-static int adav803_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static struct i2c_driver adav803_driver = {
 	.driver = {
 		.name = "adav803",
 	},
 	.probe = adav803_probe,
-	.remove = adav803_remove,
 	.id_table = adav803_id,
 };
 module_i2c_driver(adav803_driver);
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index da7ca81f47cf..db21ecbe0762 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -212,8 +212,8 @@ static const struct snd_soc_dapm_widget adav80x_dapm_widgets[] = {
 static int adav80x_dapm_sysclk_check(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	const char *clk;
 
 	switch (adav80x->clk_src) {
@@ -236,8 +236,8 @@ static int adav80x_dapm_sysclk_check(struct snd_soc_dapm_widget *source,
 static int adav80x_dapm_pll_check(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 
 	return adav80x->pll_src == ADAV80X_PLL_SRC_XTAL;
 }
@@ -281,9 +281,9 @@ static const struct snd_soc_dapm_route adav80x_dapm_routes[] = {
 	{ "AIFAUXIN", NULL, "SYSCLK" },
 };
 
-static int adav80x_set_deemph(struct snd_soc_codec *codec)
+static int adav80x_set_deemph(struct snd_soc_component *component)
 {
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	if (adav80x->deemph) {
@@ -315,8 +315,8 @@ static int adav80x_set_deemph(struct snd_soc_codec *codec)
 static int adav80x_put_deemph(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int deemph = ucontrol->value.integer.value[0];
 
 	if (deemph > 1)
@@ -324,14 +324,14 @@ static int adav80x_put_deemph(struct snd_kcontrol *kcontrol,
 
 	adav80x->deemph = deemph;
 
-	return adav80x_set_deemph(codec);
+	return adav80x_set_deemph(component);
 }
 
 static int adav80x_get_deemph(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = adav80x->deemph;
 	return 0;
@@ -365,8 +365,8 @@ static unsigned int adav80x_port_ctrl_regs[2][2] = {
 
 static int adav80x_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int capture = 0x00;
 	unsigned int playback = 0x00;
 
@@ -415,10 +415,10 @@ static int adav80x_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static int adav80x_set_adc_clock(struct snd_soc_codec *codec,
+static int adav80x_set_adc_clock(struct snd_soc_component *component,
 		unsigned int sample_rate)
 {
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	if (sample_rate <= 48000)
@@ -432,10 +432,10 @@ static int adav80x_set_adc_clock(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int adav80x_set_dac_clock(struct snd_soc_codec *codec,
+static int adav80x_set_dac_clock(struct snd_soc_component *component,
 		unsigned int sample_rate)
 {
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	if (sample_rate <= 48000)
@@ -450,10 +450,10 @@ static int adav80x_set_dac_clock(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int adav80x_set_capture_pcm_format(struct snd_soc_codec *codec,
+static int adav80x_set_capture_pcm_format(struct snd_soc_component *component,
 		struct snd_soc_dai *dai, struct snd_pcm_hw_params *params)
 {
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	switch (params_width(params)) {
@@ -479,10 +479,10 @@ static int adav80x_set_capture_pcm_format(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int adav80x_set_playback_pcm_format(struct snd_soc_codec *codec,
+static int adav80x_set_playback_pcm_format(struct snd_soc_component *component,
 		struct snd_soc_dai *dai, struct snd_pcm_hw_params *params)
 {
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	if (adav80x->dai_fmt[dai->id] != SND_SOC_DAIFMT_RIGHT_J)
@@ -514,32 +514,32 @@ static int adav80x_set_playback_pcm_format(struct snd_soc_codec *codec,
 static int adav80x_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int rate = params_rate(params);
 
 	if (rate * 256 != adav80x->sysclk)
 		return -EINVAL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adav80x_set_playback_pcm_format(codec, dai, params);
-		adav80x_set_dac_clock(codec, rate);
+		adav80x_set_playback_pcm_format(component, dai, params);
+		adav80x_set_dac_clock(component, rate);
 	} else {
-		adav80x_set_capture_pcm_format(codec, dai, params);
-		adav80x_set_adc_clock(codec, rate);
+		adav80x_set_capture_pcm_format(component, dai, params);
+		adav80x_set_adc_clock(component, rate);
 	}
 	adav80x->rate = rate;
-	adav80x_set_deemph(codec);
+	adav80x_set_deemph(component);
 
 	return 0;
 }
 
-static int adav80x_set_sysclk(struct snd_soc_codec *codec,
+static int adav80x_set_sysclk(struct snd_soc_component *component,
 			      int clk_id, int source,
 			      unsigned int freq, int dir)
 {
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	if (dir == SND_SOC_CLOCK_IN) {
 		switch (clk_id) {
@@ -619,11 +619,11 @@ static int adav80x_set_sysclk(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int adav80x_set_pll(struct snd_soc_codec *codec, int pll_id,
+static int adav80x_set_pll(struct snd_soc_component *component, int pll_id,
 		int source, unsigned int freq_in, unsigned int freq_out)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int pll_ctrl1 = 0;
 	unsigned int pll_ctrl2 = 0;
 	unsigned int pll_src;
@@ -694,10 +694,10 @@ static int adav80x_set_pll(struct snd_soc_codec *codec, int pll_id,
 	return 0;
 }
 
-static int adav80x_set_bias_level(struct snd_soc_codec *codec,
+static int adav80x_set_bias_level(struct snd_soc_component *component,
 		enum snd_soc_bias_level level)
 {
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 	unsigned int mask = ADAV80X_DAC_CTRL1_PD;
 
 	switch (level) {
@@ -722,10 +722,10 @@ static int adav80x_set_bias_level(struct snd_soc_codec *codec,
 static int adav80x_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 
-	if (!snd_soc_codec_is_active(codec) || !adav80x->rate)
+	if (!snd_soc_component_is_active(component) || !adav80x->rate)
 		return 0;
 
 	return snd_pcm_hw_constraint_single(substream->runtime,
@@ -735,10 +735,10 @@ static int adav80x_dai_startup(struct snd_pcm_substream *substream,
 static void adav80x_dai_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 
-	if (!snd_soc_codec_is_active(codec))
+	if (!snd_soc_component_is_active(component))
 		adav80x->rate = 0;
 }
 
@@ -799,10 +799,10 @@ static struct snd_soc_dai_driver adav80x_dais[] = {
 	},
 };
 
-static int adav80x_probe(struct snd_soc_codec *codec)
+static int adav80x_probe(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 
 	/* Force PLLs on for SYSCLK output */
 	snd_soc_dapm_force_enable_pin(dapm, "PLL1");
@@ -816,32 +816,32 @@ static int adav80x_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int adav80x_resume(struct snd_soc_codec *codec)
+static int adav80x_resume(struct snd_soc_component *component)
 {
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	struct adav80x *adav80x = snd_soc_component_get_drvdata(component);
 
 	regcache_sync(adav80x->regmap);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver adav80x_codec_driver = {
-	.probe = adav80x_probe,
-	.resume = adav80x_resume,
-	.set_bias_level = adav80x_set_bias_level,
-	.suspend_bias_off = true,
-
-	.set_pll = adav80x_set_pll,
-	.set_sysclk = adav80x_set_sysclk,
-
-	.component_driver = {
-		.controls		= adav80x_controls,
-		.num_controls		= ARRAY_SIZE(adav80x_controls),
-		.dapm_widgets		= adav80x_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(adav80x_dapm_widgets),
-		.dapm_routes		= adav80x_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(adav80x_dapm_routes),
-	},
+static const struct snd_soc_component_driver adav80x_component_driver = {
+	.probe			= adav80x_probe,
+	.resume			= adav80x_resume,
+	.set_bias_level		= adav80x_set_bias_level,
+	.set_pll		= adav80x_set_pll,
+	.set_sysclk		= adav80x_set_sysclk,
+	.controls		= adav80x_controls,
+	.num_controls		= ARRAY_SIZE(adav80x_controls),
+	.dapm_widgets		= adav80x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(adav80x_dapm_widgets),
+	.dapm_routes		= adav80x_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(adav80x_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 int adav80x_bus_probe(struct device *dev, struct regmap *regmap)
@@ -858,7 +858,7 @@ int adav80x_bus_probe(struct device *dev, struct regmap *regmap)
 	dev_set_drvdata(dev, adav80x);
 	adav80x->regmap = regmap;
 
-	return snd_soc_register_codec(dev, &adav80x_codec_driver,
+	return devm_snd_soc_register_component(dev, &adav80x_component_driver,
 		adav80x_dais, ARRAY_SIZE(adav80x_dais));
 }
 EXPORT_SYMBOL_GPL(adav80x_bus_probe);
-- 
2.16.1
