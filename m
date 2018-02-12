From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau1373: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:40:24 +0000
Message-ID: <E1elDPE-0004ig-Rc@debutante>
References: <87d11tz4pj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F02B0267351
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:40:26 +0100 (CET)
In-Reply-To: <87d11tz4pj.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: adau1373: replace codec to component

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

>From 0d12540cd83c111cfa3ed9a17bf981134187d8c3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:10:39 +0000
Subject: [PATCH] ASoC: adau1373: replace codec to component

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
 sound/soc/codecs/adau1373.c | 84 ++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index a865945d776a..f22ff9f6ab47 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -549,8 +549,8 @@ static const struct snd_kcontrol_new adau1373_drc_controls[] = {
 static int adau1373_pll_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
 	unsigned int pll_id = w->name[3] - '1';
 	unsigned int val;
 
@@ -821,8 +821,8 @@ static const struct snd_soc_dapm_widget adau1373_dapm_widgets[] = {
 static int adau1373_check_aif_clk(struct snd_soc_dapm_widget *source,
 	struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
 	unsigned int dai;
 	const char *clk;
 
@@ -842,8 +842,8 @@ static int adau1373_check_aif_clk(struct snd_soc_dapm_widget *source,
 static int adau1373_check_src(struct snd_soc_dapm_widget *source,
 	struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
 	unsigned int dai;
 
 	dai = sink->name[3] - '1';
@@ -1031,8 +1031,8 @@ static const struct snd_soc_dapm_route adau1373_dapm_routes[] = {
 static int adau1373_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
 	struct adau1373_dai *adau1373_dai = &adau1373->dais[dai->id];
 	unsigned int div;
 	unsigned int freq;
@@ -1098,8 +1098,8 @@ static int adau1373_hw_params(struct snd_pcm_substream *substream,
 
 static int adau1373_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
 	struct adau1373_dai *adau1373_dai = &adau1373->dais[dai->id];
 	unsigned int ctrl;
 
@@ -1158,7 +1158,7 @@ static int adau1373_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int adau1373_set_dai_sysclk(struct snd_soc_dai *dai,
 	int clk_id, unsigned int freq, int dir)
 {
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(dai->codec);
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(dai->component);
 	struct adau1373_dai *adau1373_dai = &adau1373->dais[dai->id];
 
 	switch (clk_id) {
@@ -1250,10 +1250,10 @@ static struct snd_soc_dai_driver adau1373_dai_driver[] = {
 	},
 };
 
-static int adau1373_set_pll(struct snd_soc_codec *codec, int pll_id,
+static int adau1373_set_pll(struct snd_soc_component *component, int pll_id,
 	int source, unsigned int freq_in, unsigned int freq_out)
 {
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
 	unsigned int dpll_div = 0;
 	uint8_t pll_regs[5];
 	int ret;
@@ -1348,10 +1348,10 @@ static bool adau1373_valid_micbias(enum adau1373_micbias_voltage micbias)
 	return false;
 }
 
-static int adau1373_probe(struct snd_soc_codec *codec)
+static int adau1373_probe(struct snd_soc_component *component)
 {
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
-	struct adau1373_platform_data *pdata = codec->dev->platform_data;
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
+	struct adau1373_platform_data *pdata = component->dev->platform_data;
 	bool lineout_differential = false;
 	unsigned int val;
 	int i;
@@ -1369,7 +1369,7 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 				pdata->drc_setting[i]);
 		}
 
-		snd_soc_add_codec_controls(codec, adau1373_drc_controls,
+		snd_soc_add_component_controls(component, adau1373_drc_controls,
 			pdata->num_drc);
 
 		val = 0;
@@ -1394,7 +1394,7 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 	}
 
 	if (!lineout_differential) {
-		snd_soc_add_codec_controls(codec, adau1373_lineout2_controls,
+		snd_soc_add_component_controls(component, adau1373_lineout2_controls,
 			ARRAY_SIZE(adau1373_lineout2_controls));
 	}
 
@@ -1404,10 +1404,10 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int adau1373_set_bias_level(struct snd_soc_codec *codec,
+static int adau1373_set_bias_level(struct snd_soc_component *component,
 	enum snd_soc_bias_level level)
 {
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1426,9 +1426,9 @@ static int adau1373_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int adau1373_resume(struct snd_soc_codec *codec)
+static int adau1373_resume(struct snd_soc_component *component)
 {
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	struct adau1373 *adau1373 = snd_soc_component_get_drvdata(component);
 
 	regcache_sync(adau1373->regmap);
 
@@ -1458,22 +1458,20 @@ static const struct regmap_config adau1373_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(adau1373_reg_defaults),
 };
 
-static const struct snd_soc_codec_driver adau1373_codec_driver = {
-	.probe =	adau1373_probe,
-	.resume =	adau1373_resume,
-	.set_bias_level = adau1373_set_bias_level,
-	.idle_bias_off = true,
-
-	.set_pll = adau1373_set_pll,
-
-	.component_driver = {
-		.controls		= adau1373_controls,
-		.num_controls		= ARRAY_SIZE(adau1373_controls),
-		.dapm_widgets		= adau1373_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(adau1373_dapm_widgets),
-		.dapm_routes		= adau1373_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(adau1373_dapm_routes),
-	},
+static const struct snd_soc_component_driver adau1373_component_driver = {
+	.probe			= adau1373_probe,
+	.resume			= adau1373_resume,
+	.set_bias_level		= adau1373_set_bias_level,
+	.set_pll		= adau1373_set_pll,
+	.controls		= adau1373_controls,
+	.num_controls		= ARRAY_SIZE(adau1373_controls),
+	.dapm_widgets		= adau1373_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(adau1373_dapm_widgets),
+	.dapm_routes		= adau1373_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(adau1373_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int adau1373_i2c_probe(struct i2c_client *client,
@@ -1495,17 +1493,12 @@ static int adau1373_i2c_probe(struct i2c_client *client,
 
 	dev_set_drvdata(&client->dev, adau1373);
 
-	ret = snd_soc_register_codec(&client->dev, &adau1373_codec_driver,
+	ret = devm_snd_soc_register_component(&client->dev,
+			&adau1373_component_driver,
 			adau1373_dai_driver, ARRAY_SIZE(adau1373_dai_driver));
 	return ret;
 }
 
-static int adau1373_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id adau1373_i2c_id[] = {
 	{ "adau1373", 0 },
 	{ }
@@ -1517,7 +1510,6 @@ static struct i2c_driver adau1373_i2c_driver = {
 		.name = "adau1373",
 	},
 	.probe = adau1373_i2c_probe,
-	.remove = adau1373_i2c_remove,
 	.id_table = adau1373_i2c_id,
 };
 
-- 
2.16.1
