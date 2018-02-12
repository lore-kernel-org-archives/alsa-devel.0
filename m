From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:42:57 +0000
Message-ID: <E1elDRh-0004zN-F9@debutante>
References: <87372p1fju.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B47C4267865
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:42:59 +0100 (CET)
In-Reply-To: <87372p1fju.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: cs53l30: replace codec to component

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

>From 534cf41c0c09e5c7b7aee706abcd3812ef17ae89 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:00:28 +0000
Subject: [PATCH] ASoC: cs53l30: replace codec to component

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
 sound/soc/codecs/cs53l30.c | 57 ++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index c7edf2df5e36..8995ea45b4ca 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -549,7 +549,7 @@ static int cs53l30_get_mclk_coeff(int mclk_rate, int srate)
 static int cs53l30_set_sysclk(struct snd_soc_dai *dai,
 			      int clk_id, unsigned int freq, int dir)
 {
-	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+	struct cs53l30_private *priv = snd_soc_component_get_drvdata(dai->component);
 	int mclkx_coeff;
 	u32 mclk_rate;
 
@@ -572,7 +572,7 @@ static int cs53l30_set_sysclk(struct snd_soc_dai *dai,
 
 static int cs53l30_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+	struct cs53l30_private *priv = snd_soc_component_get_drvdata(dai->component);
 	u8 aspcfg = 0, aspctl1 = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -626,7 +626,7 @@ static int cs53l30_pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+	struct cs53l30_private *priv = snd_soc_component_get_drvdata(dai->component);
 	int srate = params_rate(params);
 	int mclk_coeff;
 
@@ -650,11 +650,11 @@ static int cs53l30_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int cs53l30_set_bias_level(struct snd_soc_codec *codec,
+static int cs53l30_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct cs53l30_private *priv = snd_soc_component_get_drvdata(component);
 	unsigned int reg;
 	int i, inter_max_check, ret;
 
@@ -670,7 +670,7 @@ static int cs53l30_set_bias_level(struct snd_soc_codec *codec,
 		if (dapm->bias_level == SND_SOC_BIAS_OFF) {
 			ret = clk_prepare_enable(priv->mclk);
 			if (ret) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"failed to enable MCLK: %d\n", ret);
 				return ret;
 			}
@@ -736,7 +736,7 @@ static int cs53l30_set_bias_level(struct snd_soc_codec *codec,
 
 static int cs53l30_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
-	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+	struct cs53l30_private *priv = snd_soc_component_get_drvdata(dai->component);
 	u8 val = tristate ? CS53L30_ASP_3ST : 0;
 
 	return regmap_update_bits(priv->regmap, CS53L30_ASP_CTL1,
@@ -770,7 +770,7 @@ static int cs53l30_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				    unsigned int tx_mask, unsigned int rx_mask,
 				    int slots, int slot_width)
 {
-	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+	struct cs53l30_private *priv = snd_soc_component_get_drvdata(dai->component);
 	unsigned int loc[CS53L30_TDM_SLOT_MAX] = {48, 48, 48, 48};
 	unsigned int slot_next, slot_step;
 	u64 tx_enable = 0;
@@ -840,7 +840,7 @@ static int cs53l30_set_dai_tdm_slot(struct snd_soc_dai *dai,
 
 static int cs53l30_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
-	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+	struct cs53l30_private *priv = snd_soc_component_get_drvdata(dai->component);
 
 	gpiod_set_value_cansleep(priv->mute_gpio, mute);
 
@@ -876,10 +876,10 @@ static struct snd_soc_dai_driver cs53l30_dai = {
 	.symmetric_rates = 1,
 };
 
-static int cs53l30_codec_probe(struct snd_soc_codec *codec)
+static int cs53l30_component_probe(struct snd_soc_component *component)
 {
-	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct cs53l30_private *priv = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	if (priv->use_sdout2)
 		snd_soc_dapm_add_routes(dapm, cs53l30_dapm_routes_sdout2,
@@ -891,19 +891,18 @@ static int cs53l30_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static const struct snd_soc_codec_driver cs53l30_driver = {
-	.probe = cs53l30_codec_probe,
-	.set_bias_level = cs53l30_set_bias_level,
-	.idle_bias_off = true,
-
-	.component_driver = {
-		.controls		= cs53l30_snd_controls,
-		.num_controls		= ARRAY_SIZE(cs53l30_snd_controls),
-		.dapm_widgets		= cs53l30_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(cs53l30_dapm_widgets),
-		.dapm_routes		= cs53l30_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(cs53l30_dapm_routes),
-	},
+static const struct snd_soc_component_driver cs53l30_driver = {
+	.probe			= cs53l30_component_probe,
+	.set_bias_level		= cs53l30_set_bias_level,
+	.controls		= cs53l30_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs53l30_snd_controls),
+	.dapm_widgets		= cs53l30_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs53l30_dapm_widgets),
+	.dapm_routes		= cs53l30_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(cs53l30_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static struct regmap_config cs53l30_regmap = {
@@ -1033,9 +1032,9 @@ static int cs53l30_i2c_probe(struct i2c_client *client,
 
 	dev_info(dev, "Cirrus Logic CS53L30, Revision: %02X\n", reg & 0xFF);
 
-	ret = snd_soc_register_codec(dev, &cs53l30_driver, &cs53l30_dai, 1);
+	ret = devm_snd_soc_register_component(dev, &cs53l30_driver, &cs53l30_dai, 1);
 	if (ret) {
-		dev_err(dev, "failed to register codec: %d\n", ret);
+		dev_err(dev, "failed to register component: %d\n", ret);
 		goto error;
 	}
 
@@ -1051,8 +1050,6 @@ static int cs53l30_i2c_remove(struct i2c_client *client)
 {
 	struct cs53l30_private *cs53l30 = i2c_get_clientdata(client);
 
-	snd_soc_unregister_codec(&client->dev);
-
 	/* Hold down reset */
 	gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
 
-- 
2.16.1
