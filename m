From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es7134: add support for the es7154" to
	the asoc tree
Date: Tue, 03 Jul 2018 16:33:59 +0100
Message-ID: <E1faNJX-0003fk-FU@debutante>
References: <20180703150600.17697-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F0C2B26771C
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:34:01 +0200 (CEST)
In-Reply-To: <20180703150600.17697-4-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es7134: add support for the es7154

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

>From 563c263248ff37dcd743549a0c0932fe2bf83980 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 3 Jul 2018 17:06:00 +0200
Subject: [PATCH] ASoC: es7134: add support for the es7154

Add support for the es7154 which is basically an es7134 with an
embedded power amplifier and lower maximum sample rate

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es7134.c | 60 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 80f2936cefed..6d7bca7b78ca 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -33,6 +33,7 @@ struct es7134_clock_mode {
 };
 
 struct es7134_chip {
+	struct snd_soc_dai_driver *dai_drv;
 	const struct es7134_clock_mode *modes;
 	unsigned int mode_num;
 	const struct snd_soc_dapm_widget *extra_widgets;
@@ -196,6 +197,7 @@ static const struct snd_soc_dapm_route es7134_extra_routes[] = {
 };
 
 static const struct es7134_chip es7134_chip = {
+	.dai_drv = &es7134_dai,
 	.modes = es7134_modes,
 	.mode_num = ARRAY_SIZE(es7134_modes),
 	.extra_routes = es7134_extra_routes,
@@ -227,6 +229,61 @@ static const struct snd_soc_component_driver es7134_component_driver = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static struct snd_soc_dai_driver es7154_dai = {
+	.name = "es7154-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = (SNDRV_PCM_RATE_8000_48000 |
+			  SNDRV_PCM_RATE_88200      |
+			  SNDRV_PCM_RATE_96000),
+		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
+			    SNDRV_PCM_FMTBIT_S18_3LE |
+			    SNDRV_PCM_FMTBIT_S20_3LE |
+			    SNDRV_PCM_FMTBIT_S24_3LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &es7134_dai_ops,
+};
+
+static const struct es7134_clock_mode es7154_modes[] = {
+	{
+		/* Single speed mode */
+		.rate_min = 8000,
+		.rate_max = 50000,
+		.mclk_fs = (unsigned int[]) { 32, 64, 128, 192, 256,
+					      384, 512, 768, 1024 },
+		.mclk_fs_num = 9,
+	}, {
+		/* Double speed mode */
+		.rate_min = 84000,
+		.rate_max = 100000,
+		.mclk_fs = (unsigned int[]) { 128, 192, 256, 384, 512,
+					      768, 1024},
+		.mclk_fs_num = 7,
+	}
+};
+
+/* Es7154 has a separate supply for digital I/O  */
+static const struct snd_soc_dapm_widget es7154_extra_widgets[] = {
+	SND_SOC_DAPM_REGULATOR_SUPPLY("PVDD", 0, 0),
+};
+
+static const struct snd_soc_dapm_route es7154_extra_routes[] = {
+	{ "Playback", NULL, "PVDD", }
+};
+
+static const struct es7134_chip es7154_chip = {
+	.dai_drv = &es7154_dai,
+	.modes = es7154_modes,
+	.mode_num = ARRAY_SIZE(es7154_modes),
+	.extra_routes = es7154_extra_routes,
+	.extra_route_num = ARRAY_SIZE(es7154_extra_routes),
+	.extra_widgets = es7154_extra_widgets,
+	.extra_widget_num = ARRAY_SIZE(es7154_extra_widgets),
+};
+
 static int es7134_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -245,13 +302,14 @@ static int es7134_probe(struct platform_device *pdev)
 
 	return devm_snd_soc_register_component(&pdev->dev,
 				      &es7134_component_driver,
-				      &es7134_dai, 1);
+				      priv->chip->dai_drv, 1);
 }
 
 #ifdef CONFIG_OF
 static const struct of_device_id es7134_ids[] = {
 	{ .compatible = "everest,es7134", .data = &es7134_chip },
 	{ .compatible = "everest,es7144", .data = &es7134_chip },
+	{ .compatible = "everest,es7154", .data = &es7154_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, es7134_ids);
-- 
2.18.0.rc2
