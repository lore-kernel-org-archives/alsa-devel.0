From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:51 +0000
Message-ID: <E1elDNj-0004N1-Dp@debutante>
References: <87a7wxxpj8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E1E7267AEB
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:53 +0100 (CET)
In-Reply-To: <87a7wxxpj8.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: sun4i: replace codec to component

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

>From 77f4be16e6bf781e05a5ea95b98259c93ccf1fa2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:23:46 +0000
Subject: [PATCH] ASoC: sun4i: replace codec to component

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
 sound/soc/sunxi/sun4i-codec.c | 71 ++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 886281673972..9a3cb7704810 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -792,15 +792,17 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Mic1", NULL, "VMIC" },
 };
 
-static const struct snd_soc_codec_driver sun4i_codec_codec = {
-	.component_driver = {
-		.controls		= sun4i_codec_controls,
-		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
-		.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
-		.dapm_routes		= sun4i_codec_codec_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
-	},
+static const struct snd_soc_component_driver sun4i_codec_codec = {
+	.controls		= sun4i_codec_controls,
+	.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
+	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+	.dapm_routes		= sun4i_codec_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 /*** sun6i Codec ***/
@@ -1098,15 +1100,17 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "Right ADC Mixer" },
 };
 
-static const struct snd_soc_codec_driver sun6i_codec_codec = {
-	.component_driver = {
-		.controls		= sun6i_codec_codec_widgets,
-		.num_controls		= ARRAY_SIZE(sun6i_codec_codec_widgets),
-		.dapm_widgets		= sun6i_codec_codec_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(sun6i_codec_codec_dapm_widgets),
-		.dapm_routes		= sun6i_codec_codec_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(sun6i_codec_codec_dapm_routes),
-	},
+static const struct snd_soc_component_driver sun6i_codec_codec = {
+	.controls		= sun6i_codec_codec_widgets,
+	.num_controls		= ARRAY_SIZE(sun6i_codec_codec_widgets),
+	.dapm_widgets		= sun6i_codec_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun6i_codec_codec_dapm_widgets),
+	.dapm_routes		= sun6i_codec_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sun6i_codec_codec_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 /* sun8i A23 codec */
@@ -1126,13 +1130,15 @@ static const struct snd_soc_dapm_widget sun8i_a23_codec_codec_widgets[] = {
 
 };
 
-static const struct snd_soc_codec_driver sun8i_a23_codec_codec = {
-	.component_driver = {
-		.controls		= sun8i_a23_codec_codec_controls,
-		.num_controls		= ARRAY_SIZE(sun8i_a23_codec_codec_controls),
-		.dapm_widgets		= sun8i_a23_codec_codec_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(sun8i_a23_codec_codec_widgets),
-	},
+static const struct snd_soc_component_driver sun8i_a23_codec_codec = {
+	.controls		= sun8i_a23_codec_codec_controls,
+	.num_controls		= ARRAY_SIZE(sun8i_a23_codec_codec_controls),
+	.dapm_widgets		= sun8i_a23_codec_codec_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun8i_a23_codec_codec_widgets),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct snd_soc_component_driver sun4i_codec_component = {
@@ -1450,7 +1456,7 @@ static const struct regmap_config sun8i_v3s_codec_regmap_config = {
 
 struct sun4i_codec_quirks {
 	const struct regmap_config *regmap_config;
-	const struct snd_soc_codec_driver *codec;
+	const struct snd_soc_component_driver *codec;
 	struct snd_soc_card * (*create_card)(struct device *dev);
 	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
 	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
@@ -1657,7 +1663,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	scodec->capture_dma_data.maxburst = 8;
 	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
-	ret = snd_soc_register_codec(&pdev->dev, quirks->codec,
+	ret = devm_snd_soc_register_component(&pdev->dev, quirks->codec,
 				     &sun4i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our codec\n");
@@ -1669,20 +1675,20 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 					      &dummy_cpu_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our DAI\n");
-		goto err_unregister_codec;
+		goto err_assert_reset;
 	}
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register against DMAEngine\n");
-		goto err_unregister_codec;
+		goto err_assert_reset;
 	}
 
 	card = quirks->create_card(&pdev->dev);
 	if (IS_ERR(card)) {
 		ret = PTR_ERR(card);
 		dev_err(&pdev->dev, "Failed to create our card\n");
-		goto err_unregister_codec;
+		goto err_assert_reset;
 	}
 
 	snd_soc_card_set_drvdata(card, scodec);
@@ -1690,13 +1696,11 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our card\n");
-		goto err_unregister_codec;
+		goto err_assert_reset;
 	}
 
 	return 0;
 
-err_unregister_codec:
-	snd_soc_unregister_codec(&pdev->dev);
 err_assert_reset:
 	if (scodec->rst)
 		reset_control_assert(scodec->rst);
@@ -1711,7 +1715,6 @@ static int sun4i_codec_remove(struct platform_device *pdev)
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(card);
 
 	snd_soc_unregister_card(card);
-	snd_soc_unregister_codec(&pdev->dev);
 	if (scodec->rst)
 		reset_control_assert(scodec->rst);
 	clk_disable_unprepare(scodec->clk_apb);
-- 
2.16.1
