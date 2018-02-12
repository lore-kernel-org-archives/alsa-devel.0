From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun8i: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:48 +0000
Message-ID: <E1elDNg-0004MD-9x@debutante>
References: <878tchxpic.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FAC226792F
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:50 +0100 (CET)
In-Reply-To: <878tchxpic.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: sun8i: replace codec to component

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

>From 7ec9b872f975a7ab7a466fdb63da9509bc2c9085 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:24:17 +0000
Subject: [PATCH] ASoC: sun8i: replace codec to component

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
 sound/soc/sunxi/sun8i-codec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 7a15df924316..fb37dd927e33 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -184,7 +184,7 @@ static int sun8i_codec_get_hw_rate(struct snd_pcm_hw_params *params)
 
 static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct sun8i_codec *scodec = snd_soc_codec_get_drvdata(dai->codec);
+	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(dai->component);
 	u32 value;
 
 	/* clock masters */
@@ -304,7 +304,7 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct sun8i_codec *scodec = snd_soc_codec_get_drvdata(dai->codec);
+	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(dai->component);
 	int sample_rate;
 	u8 bclk_div;
 
@@ -500,13 +500,15 @@ static struct snd_soc_dai_driver sun8i_codec_dai = {
 	.ops = &sun8i_codec_dai_ops,
 };
 
-static const struct snd_soc_codec_driver sun8i_soc_codec = {
-	.component_driver = {
-		.dapm_widgets		= sun8i_codec_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(sun8i_codec_dapm_widgets),
-		.dapm_routes		= sun8i_codec_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(sun8i_codec_dapm_routes),
-	},
+static const struct snd_soc_component_driver sun8i_soc_component = {
+	.dapm_widgets		= sun8i_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun8i_codec_dapm_widgets),
+	.dapm_routes		= sun8i_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sun8i_codec_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config sun8i_codec_regmap_config = {
@@ -566,7 +568,7 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = snd_soc_register_codec(&pdev->dev, &sun8i_soc_codec,
+	ret = devm_snd_soc_register_component(&pdev->dev, &sun8i_soc_component,
 				     &sun8i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register codec\n");
@@ -594,7 +596,6 @@ static int sun8i_codec_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun8i_codec_runtime_suspend(&pdev->dev);
 
-	snd_soc_unregister_codec(&pdev->dev);
 	clk_disable_unprepare(scodec->clk_module);
 	clk_disable_unprepare(scodec->clk_bus);
 
-- 
2.16.1
