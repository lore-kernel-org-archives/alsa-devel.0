From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sta529: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:02 +0000
Message-ID: <E1elDMw-0004Bq-7k@debutante>
References: <87o9ldwanx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 681CC267900
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:04 +0100 (CET)
In-Reply-To: <87o9ldwanx.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: sta529: replace codec to component

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

>From 895577874dc8340fbc7dca7402870d3f18d92109 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:30:16 +0000
Subject: [PATCH] ASoC: sta529: replace codec to component

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
 sound/soc/codecs/sta529.c | 69 +++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 660734359bf3..2881a0f7bb39 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -151,28 +151,28 @@ static const struct snd_kcontrol_new sta529_snd_controls[] = {
 	SOC_ENUM("PWM Select", pwm_src),
 };
 
-static int sta529_set_bias_level(struct snd_soc_codec *codec, enum
+static int sta529_set_bias_level(struct snd_soc_component *component, enum
 		snd_soc_bias_level level)
 {
-	struct sta529 *sta529 = snd_soc_codec_get_drvdata(codec);
+	struct sta529 *sta529 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
-		snd_soc_update_bits(codec, STA529_FFXCFG0, POWER_CNTLMSAK,
+		snd_soc_component_update_bits(component, STA529_FFXCFG0, POWER_CNTLMSAK,
 				POWER_UP);
-		snd_soc_update_bits(codec, STA529_MISC,	FFX_CLK_MSK,
+		snd_soc_component_update_bits(component, STA529_MISC,	FFX_CLK_MSK,
 				FFX_CLK_ENB);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
 			regcache_sync(sta529->regmap);
-		snd_soc_update_bits(codec, STA529_FFXCFG0,
+		snd_soc_component_update_bits(component, STA529_FFXCFG0,
 					POWER_CNTLMSAK, POWER_STDBY);
 		/* Making FFX output to zero */
-		snd_soc_update_bits(codec, STA529_FFXCFG0, FFX_MASK,
+		snd_soc_component_update_bits(component, STA529_FFXCFG0, FFX_MASK,
 				FFX_OFF);
-		snd_soc_update_bits(codec, STA529_MISC, FFX_CLK_MSK,
+		snd_soc_component_update_bits(component, STA529_MISC, FFX_CLK_MSK,
 				FFX_CLK_DIS);
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -187,7 +187,7 @@ static int sta529_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	int pdata, play_freq_val, record_freq_val;
 	int bclk_to_fs_ratio;
 
@@ -205,7 +205,7 @@ static int sta529_hw_params(struct snd_pcm_substream *substream,
 		bclk_to_fs_ratio = 2;
 		break;
 	default:
-		dev_err(codec->dev, "Unsupported format\n");
+		dev_err(component->dev, "Unsupported format\n");
 		return -EINVAL;
 	}
 
@@ -228,23 +228,23 @@ static int sta529_hw_params(struct snd_pcm_substream *substream,
 		record_freq_val = 0;
 		break;
 	default:
-		dev_err(codec->dev, "Unsupported rate\n");
+		dev_err(component->dev, "Unsupported rate\n");
 		return -EINVAL;
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		snd_soc_update_bits(codec, STA529_S2PCFG1, PDATA_LEN_MSK,
+		snd_soc_component_update_bits(component, STA529_S2PCFG1, PDATA_LEN_MSK,
 				pdata << 6);
-		snd_soc_update_bits(codec, STA529_S2PCFG1, BCLK_TO_FS_MSK,
+		snd_soc_component_update_bits(component, STA529_S2PCFG1, BCLK_TO_FS_MSK,
 				bclk_to_fs_ratio << 4);
-		snd_soc_update_bits(codec, STA529_MISC, PLAY_FREQ_RANGE_MSK,
+		snd_soc_component_update_bits(component, STA529_MISC, PLAY_FREQ_RANGE_MSK,
 				play_freq_val << 4);
 	} else {
-		snd_soc_update_bits(codec, STA529_P2SCFG1, PDATA_LEN_MSK,
+		snd_soc_component_update_bits(component, STA529_P2SCFG1, PDATA_LEN_MSK,
 				pdata << 6);
-		snd_soc_update_bits(codec, STA529_P2SCFG1, BCLK_TO_FS_MSK,
+		snd_soc_component_update_bits(component, STA529_P2SCFG1, BCLK_TO_FS_MSK,
 				bclk_to_fs_ratio << 4);
-		snd_soc_update_bits(codec, STA529_MISC, CAP_FREQ_RANGE_MSK,
+		snd_soc_component_update_bits(component, STA529_MISC, CAP_FREQ_RANGE_MSK,
 				record_freq_val << 2);
 	}
 
@@ -258,14 +258,14 @@ static int sta529_mute(struct snd_soc_dai *dai, int mute)
 	if (mute)
 		val |= CODEC_MUTE_VAL;
 
-	snd_soc_update_bits(dai->codec, STA529_FFXCFG0, AUDIO_MUTE_MSK, val);
+	snd_soc_component_update_bits(dai->component, STA529_FFXCFG0, AUDIO_MUTE_MSK, val);
 
 	return 0;
 }
 
 static int sta529_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u8 mode = 0;
 
 	/* interface format */
@@ -283,7 +283,7 @@ static int sta529_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, STA529_S2PCFG0, DATA_FORMAT_MSK, mode);
+	snd_soc_component_update_bits(component, STA529_S2PCFG0, DATA_FORMAT_MSK, mode);
 
 	return 0;
 }
@@ -313,14 +313,15 @@ static struct snd_soc_dai_driver sta529_dai = {
 	.ops	= &sta529_dai_ops,
 };
 
-static const struct snd_soc_codec_driver sta529_codec_driver = {
-	.set_bias_level = sta529_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= sta529_snd_controls,
-		.num_controls		= ARRAY_SIZE(sta529_snd_controls),
-	},
+static const struct snd_soc_component_driver sta529_component_driver = {
+	.set_bias_level		= sta529_set_bias_level,
+	.controls		= sta529_snd_controls,
+	.num_controls		= ARRAY_SIZE(sta529_snd_controls),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config sta529_regmap = {
@@ -354,21 +355,14 @@ static int sta529_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, sta529);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&sta529_codec_driver, &sta529_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&sta529_component_driver, &sta529_dai, 1);
 	if (ret != 0)
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
 
 	return ret;
 }
 
-static int sta529_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id sta529_i2c_id[] = {
 	{ "sta529", 0 },
 	{ }
@@ -387,7 +381,6 @@ static struct i2c_driver sta529_i2c_driver = {
 		.of_match_table = sta529_of_match,
 	},
 	.probe		= sta529_i2c_probe,
-	.remove		= sta529_i2c_remove,
 	.id_table	= sta529_i2c_id,
 };
 
-- 
2.16.1
