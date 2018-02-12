From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zx_aud96p22: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:37:17 +0000
Message-ID: <E1elDMD-000404-5H@debutante>
References: <874ln5waf6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DA2B2678F3
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:37:19 +0100 (CET)
In-Reply-To: <874ln5waf6.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: zx_aud96p22: replace codec to component

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

>From 755d440bcfdf5ff38a14a326d6dd78126466ef1f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:35:34 +0000
Subject: [PATCH] ASoC: zx_aud96p22: replace codec to component

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
 sound/soc/codecs/zx_aud96p22.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
index ca1932d13738..7a2d6eaf1786 100644
--- a/sound/soc/codecs/zx_aud96p22.c
+++ b/sound/soc/codecs/zx_aud96p22.c
@@ -57,8 +57,8 @@ struct aud96p22_priv {
 static int aud96p22_adc_event(struct snd_soc_dapm_widget *w,
 			      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct aud96p22_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct aud96p22_priv *priv = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = priv->regmap;
 
 	if (event != SND_SOC_DAPM_POST_PMU)
@@ -74,8 +74,8 @@ static int aud96p22_adc_event(struct snd_soc_dapm_widget *w,
 static int aud96p22_dac_event(struct snd_soc_dapm_widget *w,
 			      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct aud96p22_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct aud96p22_priv *priv = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = priv->regmap;
 
 	if (event != SND_SOC_DAPM_POST_PMU)
@@ -261,20 +261,22 @@ static const struct snd_soc_dapm_route aud96p22_dapm_routes[] = {
 	{ "LINEOUTMN", NULL, "LD2" },
 };
 
-static const struct snd_soc_codec_driver aud96p22_driver = {
-	.component_driver = {
-		.controls = aud96p22_snd_controls,
-		.num_controls = ARRAY_SIZE(aud96p22_snd_controls),
-		.dapm_widgets = aud96p22_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(aud96p22_dapm_widgets),
-		.dapm_routes = aud96p22_dapm_routes,
-		.num_dapm_routes = ARRAY_SIZE(aud96p22_dapm_routes),
-	},
+static const struct snd_soc_component_driver aud96p22_driver = {
+	.controls		= aud96p22_snd_controls,
+	.num_controls		= ARRAY_SIZE(aud96p22_snd_controls),
+	.dapm_widgets		= aud96p22_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(aud96p22_dapm_widgets),
+	.dapm_routes		= aud96p22_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(aud96p22_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int aud96p22_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct aud96p22_priv *priv = snd_soc_codec_get_drvdata(dai->codec);
+	struct aud96p22_priv *priv = snd_soc_component_get_drvdata(dai->component);
 	struct regmap *regmap = priv->regmap;
 	unsigned int val;
 
@@ -367,9 +369,9 @@ static int aud96p22_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, priv);
 
-	ret = snd_soc_register_codec(dev, &aud96p22_driver, &aud96p22_dai, 1);
+	ret = devm_snd_soc_register_component(dev, &aud96p22_driver, &aud96p22_dai, 1);
 	if (ret) {
-		dev_err(dev, "failed to register codec: %d\n", ret);
+		dev_err(dev, "failed to register component: %d\n", ret);
 		return ret;
 	}
 
@@ -378,7 +380,6 @@ static int aud96p22_i2c_probe(struct i2c_client *i2c,
 
 static int aud96p22_i2c_remove(struct i2c_client *i2c)
 {
-	snd_soc_unregister_codec(&i2c->dev);
 	return 0;
 }
 
-- 
2.16.1
