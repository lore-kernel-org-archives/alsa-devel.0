From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: alc5632: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:37:33 +0000
Message-ID: <E1elDMT-00044D-98@debutante>
References: <87bmhdwaij.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 32F35267537
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:37:35 +0100 (CET)
In-Reply-To: <87bmhdwaij.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: alc5632: replace codec to component

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

>From c778b7715f66c97f6b41077c72a16ad3553817ff Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:33:31 +0000
Subject: [PATCH] ASoC: alc5632: replace codec to component

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
 sound/soc/codecs/alc5632.c | 138 ++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 72 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index adb80d8719bd..08034a6d4c5a 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -116,20 +116,20 @@ static inline int alc5632_reset(struct regmap *map)
 static int amp_mixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	/* to power-on/off class-d amp generators/speaker */
 	/* need to write to 'index-46h' register :        */
 	/* so write index num (here 0x46) to reg 0x6a     */
 	/* and then 0xffff/0 to reg 0x6c                  */
-	snd_soc_write(codec, ALC5632_HID_CTRL_INDEX, 0x46);
+	snd_soc_component_write(component, ALC5632_HID_CTRL_INDEX, 0x46);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_write(codec, ALC5632_HID_CTRL_DATA, 0xFFFF);
+		snd_soc_component_write(component, ALC5632_HID_CTRL_DATA, 0xFFFF);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_write(codec, ALC5632_HID_CTRL_DATA, 0);
+		snd_soc_component_write(component, ALC5632_HID_CTRL_DATA, 0);
 		break;
 	}
 
@@ -681,7 +681,7 @@ static int alc5632_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		int source, unsigned int freq_in, unsigned int freq_out)
 {
 	int i;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	int gbl_clk = 0, pll_div = 0;
 	u16 reg;
 
@@ -689,15 +689,15 @@ static int alc5632_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		return -EINVAL;
 
 	/* Disable PLL power */
-	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD2,
+	snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD2,
 				ALC5632_PWR_ADD2_PLL1,
 				0);
-	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD2,
+	snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD2,
 				ALC5632_PWR_ADD2_PLL2,
 				0);
 
 	/* pll is not used in slave mode */
-	reg = snd_soc_read(codec, ALC5632_DAI_CONTROL);
+	reg = snd_soc_component_read32(component, ALC5632_DAI_CONTROL);
 	if (reg & ALC5632_DAI_SDP_SLAVE_MODE)
 		return 0;
 
@@ -745,19 +745,19 @@ static int alc5632_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		return -EINVAL;
 
 	/* choose MCLK/BCLK/VBCLK */
-	snd_soc_write(codec, ALC5632_GPCR2, gbl_clk);
+	snd_soc_component_write(component, ALC5632_GPCR2, gbl_clk);
 	/* choose PLL1 clock rate */
-	snd_soc_write(codec, ALC5632_PLL1_CTRL, pll_div);
+	snd_soc_component_write(component, ALC5632_PLL1_CTRL, pll_div);
 	/* enable PLL1 */
-	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD2,
+	snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD2,
 				ALC5632_PWR_ADD2_PLL1,
 				ALC5632_PWR_ADD2_PLL1);
 	/* enable PLL2 */
-	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD2,
+	snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD2,
 				ALC5632_PWR_ADD2_PLL2,
 				ALC5632_PWR_ADD2_PLL2);
 	/* use PLL1 as main SYSCLK */
-	snd_soc_update_bits(codec, ALC5632_GPCR1,
+	snd_soc_component_update_bits(component, ALC5632_GPCR1,
 			ALC5632_GPCR1_CLK_SYS_SRC_SEL_PLL1,
 			ALC5632_GPCR1_CLK_SYS_SRC_SEL_PLL1);
 
@@ -775,9 +775,9 @@ static const struct _coeff_div coeff_div[] = {
 	{512*1, 0x3075},
 };
 
-static int get_coeff(struct snd_soc_codec *codec, int rate)
+static int get_coeff(struct snd_soc_component *component, int rate)
 {
-	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
+	struct alc5632_priv *alc5632 = snd_soc_component_get_drvdata(component);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(coeff_div); i++) {
@@ -793,8 +793,8 @@ static int get_coeff(struct snd_soc_codec *codec, int rate)
 static int alc5632_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct alc5632_priv *alc5632 = snd_soc_component_get_drvdata(component);
 
 	switch (freq) {
 	case  4096000:
@@ -815,7 +815,7 @@ static int alc5632_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int alc5632_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 iface = 0;
 
 	/* set master/slave audio interface */
@@ -864,17 +864,17 @@ static int alc5632_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	return snd_soc_write(codec, ALC5632_DAI_CONTROL, iface);
+	return snd_soc_component_write(component, ALC5632_DAI_CONTROL, iface);
 }
 
 static int alc5632_pcm_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	int coeff, rate;
 	u16 iface;
 
-	iface = snd_soc_read(codec, ALC5632_DAI_CONTROL);
+	iface = snd_soc_component_read32(component, ALC5632_DAI_CONTROL);
 	iface &= ~ALC5632_DAI_I2S_DL_MASK;
 
 	/* bit size */
@@ -893,29 +893,29 @@ static int alc5632_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set iface & srate */
-	snd_soc_write(codec, ALC5632_DAI_CONTROL, iface);
+	snd_soc_component_write(component, ALC5632_DAI_CONTROL, iface);
 	rate = params_rate(params);
-	coeff = get_coeff(codec, rate);
+	coeff = get_coeff(component, rate);
 	if (coeff < 0)
 		return -EINVAL;
 
 	coeff = coeff_div[coeff].regvalue;
-	snd_soc_write(codec, ALC5632_DAC_CLK_CTRL1, coeff);
+	snd_soc_component_write(component, ALC5632_DAC_CLK_CTRL1, coeff);
 
 	return 0;
 }
 
 static int alc5632_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u16 hp_mute = ALC5632_MISC_HP_DEPOP_MUTE_L
 						|ALC5632_MISC_HP_DEPOP_MUTE_R;
-	u16 mute_reg = snd_soc_read(codec, ALC5632_MISC_CTRL) & ~hp_mute;
+	u16 mute_reg = snd_soc_component_read32(component, ALC5632_MISC_CTRL) & ~hp_mute;
 
 	if (mute)
 		mute_reg |= hp_mute;
 
-	return snd_soc_write(codec, ALC5632_MISC_CTRL, mute_reg);
+	return snd_soc_component_write(component, ALC5632_MISC_CTRL, mute_reg);
 }
 
 #define ALC5632_ADD2_POWER_EN (ALC5632_PWR_ADD2_VREF)
@@ -929,73 +929,73 @@ static int alc5632_mute(struct snd_soc_dai *dai, int mute)
 		| ALC5632_PWR_ADD1_HP_OUT_ENH_AMP \
 		| ALC5632_PWR_ADD1_MAIN_BIAS)
 
-static void enable_power_depop(struct snd_soc_codec *codec)
+static void enable_power_depop(struct snd_soc_component *component)
 {
-	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD1,
+	snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD1,
 				ALC5632_PWR_ADD1_SOFTGEN_EN,
 				ALC5632_PWR_ADD1_SOFTGEN_EN);
 
-	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD3,
+	snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD3,
 				ALC5632_ADD3_POWER_EN,
 				ALC5632_ADD3_POWER_EN);
 
-	snd_soc_update_bits(codec, ALC5632_MISC_CTRL,
+	snd_soc_component_update_bits(component, ALC5632_MISC_CTRL,
 				ALC5632_MISC_HP_DEPOP_MODE2_EN,
 				ALC5632_MISC_HP_DEPOP_MODE2_EN);
 
 	/* "normal" mode: 0 @ 26 */
 	/* set all PR0-7 mixers to 0 */
-	snd_soc_update_bits(codec, ALC5632_PWR_DOWN_CTRL_STATUS,
+	snd_soc_component_update_bits(component, ALC5632_PWR_DOWN_CTRL_STATUS,
 				ALC5632_PWR_DOWN_CTRL_STATUS_MASK,
 				0);
 
 	msleep(500);
 
-	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD2,
+	snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD2,
 				ALC5632_ADD2_POWER_EN,
 				ALC5632_ADD2_POWER_EN);
 
-	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD1,
+	snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD1,
 				ALC5632_ADD1_POWER_EN,
 				ALC5632_ADD1_POWER_EN);
 
 	/* disable HP Depop2 */
-	snd_soc_update_bits(codec, ALC5632_MISC_CTRL,
+	snd_soc_component_update_bits(component, ALC5632_MISC_CTRL,
 				ALC5632_MISC_HP_DEPOP_MODE2_EN,
 				0);
 
 }
 
-static int alc5632_set_bias_level(struct snd_soc_codec *codec,
+static int alc5632_set_bias_level(struct snd_soc_component *component,
 				      enum snd_soc_bias_level level)
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		enable_power_depop(codec);
+		enable_power_depop(component);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* everything off except vref/vmid, */
-		snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD1,
+		snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD1,
 				ALC5632_PWR_MANAG_ADD1_MASK,
 				ALC5632_PWR_ADD1_MAIN_BIAS);
-		snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD2,
+		snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD2,
 				ALC5632_PWR_MANAG_ADD2_MASK,
 				ALC5632_PWR_ADD2_VREF);
 		/* "normal" mode: 0 @ 26 */
-		snd_soc_update_bits(codec, ALC5632_PWR_DOWN_CTRL_STATUS,
+		snd_soc_component_update_bits(component, ALC5632_PWR_DOWN_CTRL_STATUS,
 				ALC5632_PWR_DOWN_CTRL_STATUS_MASK,
 				0xffff ^ (ALC5632_PWR_VREF_PR3
 				| ALC5632_PWR_VREF_PR2));
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* everything off, dac mute, inactive */
-		snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD2,
+		snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD2,
 				ALC5632_PWR_MANAG_ADD2_MASK, 0);
-		snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD3,
+		snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD3,
 				ALC5632_PWR_MANAG_ADD3_MASK, 0);
-		snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD1,
+		snd_soc_component_update_bits(component, ALC5632_PWR_MANAG_ADD1,
 				ALC5632_PWR_MANAG_ADD1_MASK, 0);
 		break;
 	}
@@ -1038,9 +1038,9 @@ static struct snd_soc_dai_driver alc5632_dai = {
 };
 
 #ifdef CONFIG_PM
-static int alc5632_resume(struct snd_soc_codec *codec)
+static int alc5632_resume(struct snd_soc_component *component)
 {
-	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
+	struct alc5632_priv *alc5632 = snd_soc_component_get_drvdata(component);
 
 	regcache_sync(alc5632->regmap);
 
@@ -1050,13 +1050,13 @@ static int alc5632_resume(struct snd_soc_codec *codec)
 #define	alc5632_resume	NULL
 #endif
 
-static int alc5632_probe(struct snd_soc_codec *codec)
+static int alc5632_probe(struct snd_soc_component *component)
 {
-	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
+	struct alc5632_priv *alc5632 = snd_soc_component_get_drvdata(component);
 
 	switch (alc5632->id) {
 	case 0x5c:
-		snd_soc_add_codec_controls(codec, alc5632_vol_snd_controls,
+		snd_soc_add_component_controls(component, alc5632_vol_snd_controls,
 			ARRAY_SIZE(alc5632_vol_snd_controls));
 		break;
 	default:
@@ -1066,20 +1066,21 @@ static int alc5632_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_device_alc5632 = {
-	.probe = alc5632_probe,
-	.resume = alc5632_resume,
-	.set_bias_level = alc5632_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= alc5632_snd_controls,
-		.num_controls		= ARRAY_SIZE(alc5632_snd_controls),
-		.dapm_widgets		= alc5632_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(alc5632_dapm_widgets),
-		.dapm_routes		= alc5632_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(alc5632_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_device_alc5632 = {
+	.probe			= alc5632_probe,
+	.resume			= alc5632_resume,
+	.set_bias_level		= alc5632_set_bias_level,
+	.controls		= alc5632_snd_controls,
+	.num_controls		= ARRAY_SIZE(alc5632_snd_controls),
+	.dapm_widgets		= alc5632_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(alc5632_dapm_widgets),
+	.dapm_routes		= alc5632_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(alc5632_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config alc5632_regmap = {
@@ -1151,23 +1152,17 @@ static int alc5632_i2c_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	ret = snd_soc_register_codec(&client->dev,
-		&soc_codec_device_alc5632, &alc5632_dai, 1);
+	ret = devm_snd_soc_register_component(&client->dev,
+		&soc_component_device_alc5632, &alc5632_dai, 1);
 
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed to register codec: %d\n", ret);
+		dev_err(&client->dev, "Failed to register component: %d\n", ret);
 		return ret;
 	}
 
 	return ret;
 }
 
-static int alc5632_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id alc5632_i2c_table[] = {
 	{"alc5632", 0x5c},
 	{}
@@ -1187,7 +1182,6 @@ static struct i2c_driver alc5632_i2c_driver = {
 		.of_match_table = of_match_ptr(alc5632_of_match),
 	},
 	.probe = alc5632_i2c_probe,
-	.remove =  alc5632_i2c_remove,
 	.id_table = alc5632_i2c_table,
 };
 
-- 
2.16.1
