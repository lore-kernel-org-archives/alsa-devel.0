From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cpcap: replace codec to component" to
	the asoc tree
Date: Wed, 28 Mar 2018 03:20:29 +0100 (BST)
Message-ID: <20180328022029.3D19144007A@finisterre.ee.mobilebroadband>
References: <87y3id3r8i.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F8B626721A
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 04:20:33 +0200 (CEST)
In-Reply-To: <87y3id3r8i.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cpcap: replace codec to component

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

>From b305d8c21cf9c009ce4995084cb44151c7306fc9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Mar 2018 01:51:02 +0000
Subject: [PATCH] ASoC: cpcap: replace codec to component

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
 sound/soc/codecs/cpcap.c | 152 +++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 79 deletions(-)

diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
index aedb267d4581..d7f05b384f1f 100644
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -243,7 +243,7 @@ enum cpcap_dai {
 };
 
 struct cpcap_audio {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct regmap *regmap;
 
 	u16 vendor;
@@ -256,8 +256,8 @@ struct cpcap_audio {
 static int cpcap_st_workaround(struct snd_soc_dapm_widget *w,
 			       struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	int err = 0;
 
 	/* Only CPCAP from ST requires workaround */
@@ -357,8 +357,8 @@ static SOC_ENUM_SINGLE_DECL(cpcap_emu_r_mux_enum, 0, 8, cpcap_out_mux_texts);
 static int cpcap_output_mux_get_enum(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int shift = e->shift_l;
 	int reg_voice, reg_hifi, reg_ext, status;
@@ -400,8 +400,8 @@ static int cpcap_output_mux_get_enum(struct snd_kcontrol *kcontrol,
 static int cpcap_output_mux_put_enum(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
@@ -445,8 +445,8 @@ static int cpcap_output_mux_put_enum(struct snd_kcontrol *kcontrol,
 static int cpcap_input_right_mux_get_enum(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	int regval, mask;
 	int err;
 
@@ -484,8 +484,8 @@ static int cpcap_input_right_mux_get_enum(struct snd_kcontrol *kcontrol,
 static int cpcap_input_right_mux_put_enum(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
@@ -529,8 +529,8 @@ static int cpcap_input_right_mux_put_enum(struct snd_kcontrol *kcontrol,
 static int cpcap_input_left_mux_get_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	int regval, mask;
 	int err;
 
@@ -560,8 +560,8 @@ static int cpcap_input_left_mux_get_enum(struct snd_kcontrol *kcontrol,
 static int cpcap_input_left_mux_put_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
@@ -969,13 +969,13 @@ static int cpcap_set_sysclk(struct cpcap_audio *cpcap, enum cpcap_dai dai,
 		clkidshift = CPCAP_BIT_CLK_IN_SEL;
 		break;
 	default:
-		dev_err(cpcap->codec->dev, "invalid DAI: %d", dai);
+		dev_err(cpcap->component->dev, "invalid DAI: %d", dai);
 		return -EINVAL;
 	}
 
 	/* setup clk id */
 	if (clk_id < 0 || clk_id > 1) {
-		dev_err(cpcap->codec->dev, "invalid clk id %d", clk_id);
+		dev_err(cpcap->component->dev, "invalid clk id %d", clk_id);
 		return -EINVAL;
 	}
 	err = regmap_update_bits(cpcap->regmap, clkidreg, BIT(clkidshift),
@@ -1015,7 +1015,7 @@ static int cpcap_set_sysclk(struct cpcap_audio *cpcap, enum cpcap_dai dai,
 		clkfreqval = 0x06 << clkfreqshift;
 		break;
 	default:
-		dev_err(cpcap->codec->dev, "unsupported freq %u", freq);
+		dev_err(cpcap->component->dev, "unsupported freq %u", freq);
 		return -EINVAL;
 	}
 
@@ -1035,7 +1035,7 @@ static int cpcap_set_sysclk(struct cpcap_audio *cpcap, enum cpcap_dai dai,
 static int cpcap_set_samprate(struct cpcap_audio *cpcap, enum cpcap_dai dai,
 			      int samplerate)
 {
-	struct snd_soc_codec *codec = cpcap->codec;
+	struct snd_soc_component *component = cpcap->component;
 	u16 sampreg, sampmask, sampshift, sampval, sampreset;
 	int err, sampreadval;
 
@@ -1053,7 +1053,7 @@ static int cpcap_set_samprate(struct cpcap_audio *cpcap, enum cpcap_dai dai,
 			    BIT(CPCAP_BIT_CDC_CLOCK_TREE_RESET);
 		break;
 	default:
-		dev_err(codec->dev, "invalid DAI: %d", dai);
+		dev_err(component->dev, "invalid DAI: %d", dai);
 		return -EINVAL;
 	}
 
@@ -1087,7 +1087,7 @@ static int cpcap_set_samprate(struct cpcap_audio *cpcap, enum cpcap_dai dai,
 		sampval = 0x0 << sampshift;
 		break;
 	default:
-		dev_err(codec->dev, "unsupported samplerate %d", samplerate);
+		dev_err(component->dev, "unsupported samplerate %d", samplerate);
 		return -EINVAL;
 	}
 	err = regmap_update_bits(cpcap->regmap, sampreg,
@@ -1103,7 +1103,7 @@ static int cpcap_set_samprate(struct cpcap_audio *cpcap, enum cpcap_dai dai,
 		return err;
 
 	if (sampreadval & sampreset) {
-		dev_err(codec->dev, "reset self-clear failed: %04x",
+		dev_err(component->dev, "reset self-clear failed: %04x",
 			sampreadval);
 		return -EIO;
 	}
@@ -1115,20 +1115,20 @@ static int cpcap_hifi_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	int rate = params_rate(params);
 
-	dev_dbg(codec->dev, "HiFi setup HW params: rate=%d", rate);
+	dev_dbg(component->dev, "HiFi setup HW params: rate=%d", rate);
 	return cpcap_set_samprate(cpcap, CPCAP_DAI_HIFI, rate);
 }
 
 static int cpcap_hifi_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
 				     unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
-	struct device *dev = codec->dev;
+	struct snd_soc_component *component = codec_dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
 
 	dev_dbg(dev, "HiFi setup sysclk: clk_id=%u, freq=%u", clk_id, freq);
 	return cpcap_set_sysclk(cpcap, CPCAP_DAI_HIFI, clk_id, freq);
@@ -1137,9 +1137,9 @@ static int cpcap_hifi_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
 static int cpcap_hifi_set_dai_fmt(struct snd_soc_dai *codec_dai,
 				  unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
-	struct device *dev = codec->dev;
+	struct snd_soc_component *component = codec_dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
 	static const u16 reg = CPCAP_REG_SDACDI;
 	static const u16 mask =
 		BIT(CPCAP_BIT_SMB_ST_DAC) |
@@ -1218,8 +1218,8 @@ static int cpcap_hifi_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 static int cpcap_hifi_set_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	static const u16 reg = CPCAP_REG_RXSDOA;
 	static const u16 mask = BIT(CPCAP_BIT_ST_DAC_SW);
 	u16 val;
@@ -1229,7 +1229,7 @@ static int cpcap_hifi_set_mute(struct snd_soc_dai *dai, int mute)
 	else
 		val = BIT(CPCAP_BIT_ST_DAC_SW);
 
-	dev_dbg(codec->dev, "HiFi mute: %d", mute);
+	dev_dbg(component->dev, "HiFi mute: %d", mute);
 	return regmap_update_bits(cpcap->regmap, reg, mask, val);
 }
 
@@ -1244,9 +1244,9 @@ static int cpcap_voice_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct device *dev = codec->dev;
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct device *dev = component->dev;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	static const u16 reg_cdi = CPCAP_REG_CDI;
 	int rate = params_rate(params);
 	int channels = params_channels(params);
@@ -1283,10 +1283,10 @@ static int cpcap_voice_hw_params(struct snd_pcm_substream *substream,
 static int cpcap_voice_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
 				      unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(codec->dev, "Voice setup sysclk: clk_id=%u, freq=%u",
+	dev_dbg(component->dev, "Voice setup sysclk: clk_id=%u, freq=%u",
 		clk_id, freq);
 	return cpcap_set_sysclk(cpcap, CPCAP_DAI_VOICE, clk_id, freq);
 }
@@ -1294,8 +1294,8 @@ static int cpcap_voice_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
 static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 				   unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	static const u16 mask = BIT(CPCAP_BIT_SMB_CDC) |
 				BIT(CPCAP_BIT_CLK_INV) |
 				BIT(CPCAP_BIT_FS_INV) |
@@ -1304,7 +1304,7 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	u16 val = 0x0000;
 	int err;
 
-	dev_dbg(codec->dev, "Voice setup dai format (%08x)", fmt);
+	dev_dbg(component->dev, "Voice setup dai format (%08x)", fmt);
 
 	/*
 	 * "Voice Playback" and "Voice Capture" should always be
@@ -1316,7 +1316,7 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		val &= ~BIT(CPCAP_BIT_SMB_CDC);
 		break;
 	default:
-		dev_err(codec->dev, "Voice dai fmt failed: CPCAP should be the master");
+		dev_err(component->dev, "Voice dai fmt failed: CPCAP should be the master");
 		val &= ~BIT(CPCAP_BIT_SMB_CDC);
 		break;
 	}
@@ -1339,7 +1339,7 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		val &= ~BIT(CPCAP_BIT_FS_INV);
 		break;
 	default:
-		dev_err(codec->dev, "Voice dai fmt failed: unsupported clock invert mode");
+		dev_err(component->dev, "Voice dai fmt failed: unsupported clock invert mode");
 		break;
 	}
 
@@ -1361,7 +1361,7 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	}
 
-	dev_dbg(codec->dev, "Voice dai format: val=%04x", val);
+	dev_dbg(component->dev, "Voice dai format: val=%04x", val);
 	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI, mask, val);
 	if (err)
 		return err;
@@ -1372,8 +1372,8 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 static int cpcap_voice_set_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	static const u16 reg = CPCAP_REG_RXCOA;
 	static const u16 mask = BIT(CPCAP_BIT_CDC_SW);
 	u16 val;
@@ -1383,7 +1383,7 @@ static int cpcap_voice_set_mute(struct snd_soc_dai *dai, int mute)
 	else
 		val = BIT(CPCAP_BIT_CDC_SW);
 
-	dev_dbg(codec->dev, "Voice mute: %d", mute);
+	dev_dbg(component->dev, "Voice mute: %d", mute);
 	return regmap_update_bits(cpcap->regmap, reg, mask, val);
 };
 
@@ -1460,13 +1460,13 @@ static int cpcap_dai_mux(struct cpcap_audio *cpcap, bool swap_dai_configuration)
 	return 0;
 }
 
-static int cpcap_audio_reset(struct snd_soc_codec *codec,
+static int cpcap_audio_reset(struct snd_soc_component *component,
 			     bool swap_dai_configuration)
 {
-	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
 	int i, err = 0;
 
-	dev_dbg(codec->dev, "init audio codec");
+	dev_dbg(component->dev, "init audio codec");
 
 	for (i = 0; i < ARRAY_SIZE(cpcap_default_regs); i++) {
 		err = regmap_update_bits(cpcap->regmap,
@@ -1500,40 +1500,41 @@ static int cpcap_audio_reset(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int cpcap_soc_probe(struct snd_soc_codec *codec)
+static int cpcap_soc_probe(struct snd_soc_component *component)
 {
 	struct cpcap_audio *cpcap;
 	int err;
 
-	cpcap = devm_kzalloc(codec->dev, sizeof(*cpcap), GFP_KERNEL);
+	cpcap = devm_kzalloc(component->dev, sizeof(*cpcap), GFP_KERNEL);
 	if (!cpcap)
 		return -ENOMEM;
-	snd_soc_codec_set_drvdata(codec, cpcap);
-	cpcap->codec = codec;
+	snd_soc_component_set_drvdata(component, cpcap);
+	cpcap->component = component;
 
-	cpcap->regmap = dev_get_regmap(codec->dev->parent, NULL);
+	cpcap->regmap = dev_get_regmap(component->dev->parent, NULL);
 	if (!cpcap->regmap)
 		return -ENODEV;
-	snd_soc_codec_init_regmap(codec, cpcap->regmap);
+	snd_soc_component_init_regmap(component, cpcap->regmap);
 
-	err = cpcap_get_vendor(codec->dev, cpcap->regmap, &cpcap->vendor);
+	err = cpcap_get_vendor(component->dev, cpcap->regmap, &cpcap->vendor);
 	if (err)
 		return err;
 
-	return cpcap_audio_reset(codec, false);
+	return cpcap_audio_reset(component, false);
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_cpcap = {
-	.probe = cpcap_soc_probe,
-
-	.component_driver = {
-		.controls		= cpcap_snd_controls,
-		.num_controls		= ARRAY_SIZE(cpcap_snd_controls),
-		.dapm_widgets		= cpcap_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(cpcap_dapm_widgets),
-		.dapm_routes		= intercon,
-		.num_dapm_routes	= ARRAY_SIZE(intercon),
-	},
+static struct snd_soc_component_driver soc_codec_dev_cpcap = {
+	.probe			= cpcap_soc_probe,
+	.controls		= cpcap_snd_controls,
+	.num_controls		= ARRAY_SIZE(cpcap_snd_controls),
+	.dapm_widgets		= cpcap_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cpcap_dapm_widgets),
+	.dapm_routes		= intercon,
+	.num_dapm_routes	= ARRAY_SIZE(intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int cpcap_codec_probe(struct platform_device *pdev)
@@ -1543,19 +1544,12 @@ static int cpcap_codec_probe(struct platform_device *pdev)
 
 	pdev->dev.of_node = codec_node;
 
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_cpcap,
+	return devm_snd_soc_register_component(&pdev->dev, &soc_codec_dev_cpcap,
 				      cpcap_dai, ARRAY_SIZE(cpcap_dai));
 }
 
-static int cpcap_codec_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
 static struct platform_driver cpcap_codec_driver = {
 	.probe		= cpcap_codec_probe,
-	.remove		= cpcap_codec_remove,
 	.driver		= {
 		.name	= "cpcap-codec",
 	},
-- 
2.16.2
