From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:39:19 +0000
Message-ID: <E1elDOB-0004UW-Nc@debutante>
References: <87mv0xxpq3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 258AB267B2C
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:22 +0100 (CET)
In-Reply-To: <87mv0xxpq3.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: pcm3168a: replace codec to component

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

>From 29751c1cdf3098380b44c52d2027dd3ba1baadf0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:19:39 +0000
Subject: [PATCH] ASoC: pcm3168a: replace codec to component

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
 sound/soc/codecs/pcm3168a.c | 51 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index b9d1207ccef2..3356c91f55b0 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -287,8 +287,8 @@ static int pcm3168a_reset(struct pcm3168a_priv *pcm3168a)
 
 static int pcm3168a_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
 
 	regmap_write(pcm3168a->regmap, PCM3168A_DAC_MUTE, mute ? 0xff : 0);
 
@@ -298,7 +298,7 @@ static int pcm3168a_digital_mute(struct snd_soc_dai *dai, int mute)
 static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 				  int clk_id, unsigned int freq, int dir)
 {
-	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(dai->codec);
+	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(dai->component);
 	int ret;
 
 	if (freq > PCM1368A_MAX_SYSCLK)
@@ -316,8 +316,8 @@ static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 static int pcm3168a_set_dai_fmt(struct snd_soc_dai *dai,
 			       unsigned int format, bool dac)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
 	u32 fmt, reg, mask, shift;
 	bool master_mode;
 
@@ -338,7 +338,7 @@ static int pcm3168a_set_dai_fmt(struct snd_soc_dai *dai,
 		fmt = PCM3168A_FMT_DSP_B;
 		break;
 	default:
-		dev_err(codec->dev, "unsupported dai format\n");
+		dev_err(component->dev, "unsupported dai format\n");
 		return -EINVAL;
 	}
 
@@ -350,7 +350,7 @@ static int pcm3168a_set_dai_fmt(struct snd_soc_dai *dai,
 		master_mode = true;
 		break;
 	default:
-		dev_err(codec->dev, "unsupported master/slave mode\n");
+		dev_err(component->dev, "unsupported master/slave mode\n");
 		return -EINVAL;
 	}
 
@@ -396,8 +396,8 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
 	bool tx, master_mode;
 	u32 val, mask, shift, reg;
 	unsigned int rate, fmt, ratio, max_ratio;
@@ -430,7 +430,7 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (i == max_ratio) {
-		dev_err(codec->dev, "unsupported sysclk ratio\n");
+		dev_err(component->dev, "unsupported sysclk ratio\n");
 		return -EINVAL;
 	}
 
@@ -438,21 +438,21 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	switch (min_frame_size) {
 	case 32:
 		if (master_mode || (fmt != PCM3168A_FMT_RIGHT_J)) {
-			dev_err(codec->dev, "32-bit frames are supported only for slave mode using right justified\n");
+			dev_err(component->dev, "32-bit frames are supported only for slave mode using right justified\n");
 			return -EINVAL;
 		}
 		fmt = PCM3168A_FMT_RIGHT_J_16;
 		break;
 	case 48:
 		if (master_mode || (fmt & PCM3168A_FMT_DSP_MASK)) {
-			dev_err(codec->dev, "48-bit frames not supported in master mode, or slave mode using DSP\n");
+			dev_err(component->dev, "48-bit frames not supported in master mode, or slave mode using DSP\n");
 			return -EINVAL;
 		}
 		break;
 	case 64:
 		break;
 	default:
-		dev_err(codec->dev, "unsupported frame size: %d\n", min_frame_size);
+		dev_err(component->dev, "unsupported frame size: %d\n", min_frame_size);
 		return -EINVAL;
 	}
 
@@ -595,16 +595,16 @@ const struct regmap_config pcm3168a_regmap = {
 };
 EXPORT_SYMBOL_GPL(pcm3168a_regmap);
 
-static const struct snd_soc_codec_driver pcm3168a_driver = {
-	.idle_bias_off = true,
-	.component_driver = {
-		.controls		= pcm3168a_snd_controls,
-		.num_controls		= ARRAY_SIZE(pcm3168a_snd_controls),
-		.dapm_widgets		= pcm3168a_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(pcm3168a_dapm_widgets),
-		.dapm_routes		= pcm3168a_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(pcm3168a_dapm_routes)
-	},
+static const struct snd_soc_component_driver pcm3168a_driver = {
+	.controls		= pcm3168a_snd_controls,
+	.num_controls		= ARRAY_SIZE(pcm3168a_snd_controls),
+	.dapm_widgets		= pcm3168a_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm3168a_dapm_widgets),
+	.dapm_routes		= pcm3168a_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm3168a_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 int pcm3168a_probe(struct device *dev, struct regmap *regmap)
@@ -669,10 +669,10 @@ int pcm3168a_probe(struct device *dev, struct regmap *regmap)
 	pm_runtime_enable(dev);
 	pm_runtime_idle(dev);
 
-	ret = snd_soc_register_codec(dev, &pcm3168a_driver, pcm3168a_dais,
+	ret = devm_snd_soc_register_component(dev, &pcm3168a_driver, pcm3168a_dais,
 			ARRAY_SIZE(pcm3168a_dais));
 	if (ret) {
-		dev_err(dev, "failed to register codec: %d\n", ret);
+		dev_err(dev, "failed to register component: %d\n", ret);
 		goto err_regulator;
 	}
 
@@ -692,7 +692,6 @@ void pcm3168a_remove(struct device *dev)
 {
 	struct pcm3168a_priv *pcm3168a = dev_get_drvdata(dev);
 
-	snd_soc_unregister_codec(dev);
 	pm_runtime_disable(dev);
 	regulator_bulk_disable(ARRAY_SIZE(pcm3168a->supplies),
 				pcm3168a->supplies);
-- 
2.16.1
