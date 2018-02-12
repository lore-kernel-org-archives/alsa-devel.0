From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mc13783: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:37:10 +0000
Message-ID: <E1elDM6-0003yB-S8@debutante>
References: <87y3khuvra.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CF7E2675F1
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:37:13 +0100 (CET)
In-Reply-To: <87y3khuvra.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: mc13783: replace codec to component

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

>From 78c97ec04b108d3fff70526e6bdb5bc2ebebe4bd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:37:36 +0000
Subject: [PATCH] ASoC: mc13783: replace codec to component

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
 sound/soc/codecs/mc13783.c | 68 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index be7a45f05bbf..7b0d2610cd27 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -107,13 +107,13 @@ static int mc13783_pcm_hw_params_dac(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int rate = params_rate(params);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mc13783_rates); i++) {
 		if (rate == mc13783_rates[i]) {
-			snd_soc_update_bits(codec, MC13783_AUDIO_DAC,
+			snd_soc_component_update_bits(component, MC13783_AUDIO_DAC,
 					0xf << 17, i << 17);
 			return 0;
 		}
@@ -126,7 +126,7 @@ static int mc13783_pcm_hw_params_codec(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int rate = params_rate(params);
 	unsigned int val;
 
@@ -141,7 +141,7 @@ static int mc13783_pcm_hw_params_codec(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, MC13783_AUDIO_CODEC, AUDIO_CODEC_CDCFS8K16K,
+	snd_soc_component_update_bits(component, MC13783_AUDIO_CODEC, AUDIO_CODEC_CDCFS8K16K,
 			val);
 
 	return 0;
@@ -160,7 +160,7 @@ static int mc13783_pcm_hw_params_sync(struct snd_pcm_substream *substream,
 static int mc13783_set_fmt(struct snd_soc_dai *dai, unsigned int fmt,
 			unsigned int reg)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int val = 0;
 	unsigned int mask = AUDIO_CFS(3) | AUDIO_BCL_INV | AUDIO_CFS_INV |
 				AUDIO_CSM | AUDIO_C_CLK_EN | AUDIO_C_RESET;
@@ -208,7 +208,7 @@ static int mc13783_set_fmt(struct snd_soc_dai *dai, unsigned int fmt,
 
 	val |= AUDIO_C_RESET;
 
-	snd_soc_update_bits(codec, reg, mask, val);
+	snd_soc_component_update_bits(component, reg, mask, val);
 
 	return 0;
 }
@@ -255,7 +255,7 @@ static int mc13783_set_sysclk(struct snd_soc_dai *dai,
 				  int clk_id, unsigned int freq, int dir,
 				  unsigned int reg)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	int clk;
 	unsigned int val = 0;
 	unsigned int mask = AUDIO_CLK(0x7) | AUDIO_CLK_SEL;
@@ -275,7 +275,7 @@ static int mc13783_set_sysclk(struct snd_soc_dai *dai,
 
 	val |= AUDIO_CLK(clk);
 
-	snd_soc_update_bits(codec, reg, mask, val);
+	snd_soc_component_update_bits(component, reg, mask, val);
 
 	return 0;
 }
@@ -308,7 +308,7 @@ static int mc13783_set_tdm_slot_dac(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots,
 	int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int val = 0;
 	unsigned int mask = SSI_NETWORK_DAC_SLOT_MASK |
 				SSI_NETWORK_DAC_RXSLOT_MASK;
@@ -344,7 +344,7 @@ static int mc13783_set_tdm_slot_dac(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, MC13783_SSI_NETWORK, mask, val);
+	snd_soc_component_update_bits(component, MC13783_SSI_NETWORK, mask, val);
 
 	return 0;
 }
@@ -353,7 +353,7 @@ static int mc13783_set_tdm_slot_codec(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots,
 	int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int val = 0;
 	unsigned int mask = 0x3f;
 
@@ -366,7 +366,7 @@ static int mc13783_set_tdm_slot_codec(struct snd_soc_dai *dai,
 	val |= (0x00 << 2);	/* primary timeslot RX/TX(?) is 0 */
 	val |= (0x01 << 4);	/* secondary timeslot TX is 1 */
 
-	snd_soc_update_bits(codec, MC13783_SSI_NETWORK, mask, val);
+	snd_soc_component_update_bits(component, MC13783_SSI_NETWORK, mask, val);
 
 	return 0;
 }
@@ -606,12 +606,12 @@ static struct snd_kcontrol_new mc13783_control_list[] = {
 	SOC_SINGLE("MC2 Capture Bias Switch", MC13783_AUDIO_TX, 1, 1, 0),
 };
 
-static int mc13783_probe(struct snd_soc_codec *codec)
+static int mc13783_probe(struct snd_soc_component *component)
 {
-	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct mc13783_priv *priv = snd_soc_component_get_drvdata(component);
 
-	snd_soc_codec_init_regmap(codec,
-				  dev_get_regmap(codec->dev->parent, NULL));
+	snd_soc_component_init_regmap(component,
+				  dev_get_regmap(component->dev->parent, NULL));
 
 	/* these are the reset values */
 	mc13xxx_reg_write(priv->mc13xxx, MC13783_AUDIO_RX0, 0x25893);
@@ -638,14 +638,12 @@ static int mc13783_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int mc13783_remove(struct snd_soc_codec *codec)
+static void mc13783_remove(struct snd_soc_component *component)
 {
-	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct mc13783_priv *priv = snd_soc_component_get_drvdata(component);
 
 	/* Make sure VAUDIOON is off */
 	mc13xxx_reg_rmw(priv->mc13xxx, MC13783_AUDIO_RX0, 0x3, 0);
-
-	return 0;
 }
 
 #define MC13783_RATES_RECORD (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000)
@@ -731,17 +729,19 @@ static struct snd_soc_dai_driver mc13783_dai_sync[] = {
 	}
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
-	.probe		= mc13783_probe,
-	.remove		= mc13783_remove,
-	.component_driver = {
-		.controls		= mc13783_control_list,
-		.num_controls		= ARRAY_SIZE(mc13783_control_list),
-		.dapm_widgets		= mc13783_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(mc13783_dapm_widgets),
-		.dapm_routes		= mc13783_routes,
-		.num_dapm_routes	= ARRAY_SIZE(mc13783_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_mc13783 = {
+	.probe			= mc13783_probe,
+	.remove			= mc13783_remove,
+	.controls		= mc13783_control_list,
+	.num_controls		= ARRAY_SIZE(mc13783_control_list),
+	.dapm_widgets		= mc13783_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(mc13783_dapm_widgets),
+	.dapm_routes		= mc13783_routes,
+	.num_dapm_routes	= ARRAY_SIZE(mc13783_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int __init mc13783_codec_probe(struct platform_device *pdev)
@@ -782,10 +782,10 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 	priv->mc13xxx = dev_get_drvdata(pdev->dev.parent);
 
 	if (priv->adc_ssi_port == priv->dac_ssi_port)
-		ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_mc13783,
+		ret = devm_snd_soc_register_component(&pdev->dev, &soc_component_dev_mc13783,
 			mc13783_dai_sync, ARRAY_SIZE(mc13783_dai_sync));
 	else
-		ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_mc13783,
+		ret = devm_snd_soc_register_component(&pdev->dev, &soc_component_dev_mc13783,
 			mc13783_dai_async, ARRAY_SIZE(mc13783_dai_async));
 
 	return ret;
@@ -793,8 +793,6 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 
 static int mc13783_codec_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_codec(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.16.1
