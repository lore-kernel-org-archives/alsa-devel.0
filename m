From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas6424: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:33:14 +0000
Message-ID: <E1elDII-0003Zq-Vz@debutante>
References: <871si9uv9t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CF8A26754A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:33:17 +0100 (CET)
In-Reply-To: <871si9uv9t.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: tas6424: replace codec to component

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

>From fbf3c936d8cfa7d754e5f782e26dd9caa4cba191 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:48:04 +0000
Subject: [PATCH] ASoC: tas6424: replace codec to component

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
 sound/soc/codecs/tas6424.c | 99 ++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 51 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 49b87f6e85bf..4f3a16c520a2 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -66,10 +66,10 @@ static const struct snd_kcontrol_new tas6424_snd_controls[] = {
 static int tas6424_dac_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct tas6424_data *tas6424 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(codec->dev, "%s() event=0x%0x\n", __func__, event);
+	dev_dbg(component->dev, "%s() event=0x%0x\n", __func__, event);
 
 	if (event & SND_SOC_DAPM_POST_PMU) {
 		/* Observe codec shutdown-to-active time */
@@ -105,12 +105,12 @@ static int tas6424_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int rate = params_rate(params);
 	unsigned int width = params_width(params);
 	u8 sap_ctrl = 0;
 
-	dev_dbg(codec->dev, "%s() rate=%u width=%u\n", __func__, rate, width);
+	dev_dbg(component->dev, "%s() rate=%u width=%u\n", __func__, rate, width);
 
 	switch (rate) {
 	case 44100:
@@ -123,7 +123,7 @@ static int tas6424_hw_params(struct snd_pcm_substream *substream,
 		sap_ctrl |= TAS6424_SAP_RATE_96000;
 		break;
 	default:
-		dev_err(codec->dev, "unsupported sample rate: %u\n", rate);
+		dev_err(component->dev, "unsupported sample rate: %u\n", rate);
 		return -EINVAL;
 	}
 
@@ -134,11 +134,11 @@ static int tas6424_hw_params(struct snd_pcm_substream *substream,
 	case 24:
 		break;
 	default:
-		dev_err(codec->dev, "unsupported sample width: %u\n", width);
+		dev_err(component->dev, "unsupported sample width: %u\n", width);
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, TAS6424_SAP_CTRL,
+	snd_soc_component_update_bits(component, TAS6424_SAP_CTRL,
 			    TAS6424_SAP_RATE_MASK |
 			    TAS6424_SAP_TDM_SLOT_SZ_16,
 			    sap_ctrl);
@@ -148,17 +148,17 @@ static int tas6424_hw_params(struct snd_pcm_substream *substream,
 
 static int tas6424_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u8 serial_format = 0;
 
-	dev_dbg(codec->dev, "%s() fmt=0x%0x\n", __func__, fmt);
+	dev_dbg(component->dev, "%s() fmt=0x%0x\n", __func__, fmt);
 
 	/* clock masters */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
 	default:
-		dev_err(codec->dev, "Invalid DAI master/slave interface\n");
+		dev_err(component->dev, "Invalid DAI master/slave interface\n");
 		return -EINVAL;
 	}
 
@@ -167,7 +167,7 @@ static int tas6424_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	default:
-		dev_err(codec->dev, "Invalid DAI clock signal polarity\n");
+		dev_err(component->dev, "Invalid DAI clock signal polarity\n");
 		return -EINVAL;
 	}
 
@@ -191,11 +191,11 @@ static int tas6424_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		serial_format |= TAS6424_SAP_LEFTJ;
 		break;
 	default:
-		dev_err(codec->dev, "Invalid DAI interface format\n");
+		dev_err(component->dev, "Invalid DAI interface format\n");
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, TAS6424_SAP_CTRL,
+	snd_soc_component_update_bits(component, TAS6424_SAP_CTRL,
 			    TAS6424_SAP_FMT_MASK, serial_format);
 
 	return 0;
@@ -205,11 +205,11 @@ static int tas6424_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				    unsigned int tx_mask, unsigned int rx_mask,
 				    int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int first_slot, last_slot;
 	bool sap_tdm_slot_last;
 
-	dev_dbg(codec->dev, "%s() tx_mask=%d rx_mask=%d\n", __func__,
+	dev_dbg(component->dev, "%s() tx_mask=%d rx_mask=%d\n", __func__,
 		tx_mask, rx_mask);
 
 	if (!tx_mask || !rx_mask)
@@ -224,7 +224,7 @@ static int tas6424_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	last_slot = __fls(rx_mask);
 
 	if (last_slot - first_slot != 4) {
-		dev_err(codec->dev, "tdm mask must cover 4 contiguous slots\n");
+		dev_err(component->dev, "tdm mask must cover 4 contiguous slots\n");
 		return -EINVAL;
 	}
 
@@ -236,11 +236,11 @@ static int tas6424_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		sap_tdm_slot_last = true;
 		break;
 	default:
-		dev_err(codec->dev, "tdm mask must start at slot 0 or 4\n");
+		dev_err(component->dev, "tdm mask must start at slot 0 or 4\n");
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, TAS6424_SAP_CTRL, TAS6424_SAP_TDM_SLOT_LAST,
+	snd_soc_component_update_bits(component, TAS6424_SAP_CTRL, TAS6424_SAP_TDM_SLOT_LAST,
 			    sap_tdm_slot_last ? TAS6424_SAP_TDM_SLOT_LAST : 0);
 
 	return 0;
@@ -248,27 +248,27 @@ static int tas6424_set_dai_tdm_slot(struct snd_soc_dai *dai,
 
 static int tas6424_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int val;
 
-	dev_dbg(codec->dev, "%s() mute=%d\n", __func__, mute);
+	dev_dbg(component->dev, "%s() mute=%d\n", __func__, mute);
 
 	if (mute)
 		val = TAS6424_ALL_STATE_MUTE;
 	else
 		val = TAS6424_ALL_STATE_PLAY;
 
-	snd_soc_write(codec, TAS6424_CH_STATE_CTRL, val);
+	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, val);
 
 	return 0;
 }
 
-static int tas6424_power_off(struct snd_soc_codec *codec)
+static int tas6424_power_off(struct snd_soc_component *component)
 {
-	struct tas6424_data *tas6424 = snd_soc_codec_get_drvdata(codec);
+	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	snd_soc_write(codec, TAS6424_CH_STATE_CTRL, TAS6424_ALL_STATE_HIZ);
+	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, TAS6424_ALL_STATE_HIZ);
 
 	regcache_cache_only(tas6424->regmap, true);
 	regcache_mark_dirty(tas6424->regmap);
@@ -276,22 +276,22 @@ static int tas6424_power_off(struct snd_soc_codec *codec)
 	ret = regulator_bulk_disable(ARRAY_SIZE(tas6424->supplies),
 				     tas6424->supplies);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to disable supplies: %d\n", ret);
+		dev_err(component->dev, "failed to disable supplies: %d\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
-static int tas6424_power_on(struct snd_soc_codec *codec)
+static int tas6424_power_on(struct snd_soc_component *component)
 {
-	struct tas6424_data *tas6424 = snd_soc_codec_get_drvdata(codec);
+	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(tas6424->supplies),
 				    tas6424->supplies);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to enable supplies: %d\n", ret);
+		dev_err(component->dev, "failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
@@ -299,11 +299,11 @@ static int tas6424_power_on(struct snd_soc_codec *codec)
 
 	ret = regcache_sync(tas6424->regmap);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to sync regcache: %d\n", ret);
+		dev_err(component->dev, "failed to sync regcache: %d\n", ret);
 		return ret;
 	}
 
-	snd_soc_write(codec, TAS6424_CH_STATE_CTRL, TAS6424_ALL_STATE_MUTE);
+	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, TAS6424_ALL_STATE_MUTE);
 
 	/* any time we come out of HIZ, the output channels automatically run DC
 	 * load diagnostics, wait here until this completes
@@ -313,39 +313,38 @@ static int tas6424_power_on(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int tas6424_set_bias_level(struct snd_soc_codec *codec,
+static int tas6424_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
-	dev_dbg(codec->dev, "%s() level=%d\n", __func__, level);
+	dev_dbg(component->dev, "%s() level=%d\n", __func__, level);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
-			tas6424_power_on(codec);
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
+			tas6424_power_on(component);
 		break;
 	case SND_SOC_BIAS_OFF:
-		tas6424_power_off(codec);
+		tas6424_power_off(component);
 		break;
 	}
 
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_tas6424 = {
-	.set_bias_level = tas6424_set_bias_level,
-	.idle_bias_off = true,
-
-	.component_driver = {
-		.controls = tas6424_snd_controls,
-		.num_controls = ARRAY_SIZE(tas6424_snd_controls),
-		.dapm_widgets = tas6424_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(tas6424_dapm_widgets),
-		.dapm_routes = tas6424_audio_map,
-		.num_dapm_routes = ARRAY_SIZE(tas6424_audio_map),
-	},
+static struct snd_soc_component_driver soc_codec_dev_tas6424 = {
+	.set_bias_level		= tas6424_set_bias_level,
+	.controls		= tas6424_snd_controls,
+	.num_controls		= ARRAY_SIZE(tas6424_snd_controls),
+	.dapm_widgets		= tas6424_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tas6424_dapm_widgets),
+	.dapm_routes		= tas6424_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(tas6424_audio_map),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static struct snd_soc_dai_ops tas6424_speaker_dai_ops = {
@@ -654,7 +653,7 @@ static int tas6424_i2c_probe(struct i2c_client *client,
 
 	INIT_DELAYED_WORK(&tas6424->fault_check_work, tas6424_fault_check_work);
 
-	ret = snd_soc_register_codec(dev, &soc_codec_dev_tas6424,
+	ret = devm_snd_soc_register_component(dev, &soc_codec_dev_tas6424,
 				     tas6424_dai, ARRAY_SIZE(tas6424_dai));
 	if (ret < 0) {
 		dev_err(dev, "unable to register codec: %d\n", ret);
@@ -670,8 +669,6 @@ static int tas6424_i2c_remove(struct i2c_client *client)
 	struct tas6424_data *tas6424 = dev_get_drvdata(dev);
 	int ret;
 
-	snd_soc_unregister_codec(dev);
-
 	cancel_delayed_work_sync(&tas6424->fault_check_work);
 
 	ret = regulator_bulk_disable(ARRAY_SIZE(tas6424->supplies),
-- 
2.16.1
