From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-toddr: add g12a support" to the asoc tree
Date: Fri,  5 Apr 2019 09:43:15 +0700 (+07)
Message-ID: <20190405024315.7F18E441D3C@finisterre.ee.mobilebroadband>
References: <20190404111733.28705-4-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404111733.28705-4-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Maxime Jourdan <mjourdan@baylibre.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: axg-toddr: add g12a support

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

>From a3c23a8ad4dc07100d916d75ca30c982288b868d Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:17:30 +0200
Subject: [PATCH] ASoC: meson: axg-toddr: add g12a support

Since the g12a SoC fifo can set the fifo initial start address, we must
make sure to actually reset the write pointer to this address when
starting a capture.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-toddr.c | 53 +++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 0e9ca3882ae5..4f63e434fad4 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -24,6 +24,7 @@
 #define CTRL0_TODDR_MSB_POS(x)		((x) << 8)
 #define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
 #define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
+#define CTRL1_TODDR_FORCE_FINISH	BIT(25)
 
 #define TODDR_MSB_POS	31
 
@@ -33,6 +34,22 @@ static int axg_toddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	return axg_fifo_pcm_new(rtd, SNDRV_PCM_STREAM_CAPTURE);
 }
 
+static int g12a_toddr_dai_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+
+	/* Reset the write pointer to the FIFO_INIT_ADDR */
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, 0);
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, CTRL1_TODDR_FORCE_FINISH);
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, 0);
+
+	return 0;
+}
+
 static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -172,10 +189,46 @@ static const struct axg_fifo_match_data axg_toddr_match_data = {
 	.dai_drv	= &axg_toddr_dai_drv
 };
 
+static const struct snd_soc_dai_ops g12a_toddr_ops = {
+	.prepare	= g12a_toddr_dai_prepare,
+	.hw_params	= axg_toddr_dai_hw_params,
+	.startup	= axg_toddr_dai_startup,
+	.shutdown	= axg_toddr_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver g12a_toddr_dai_drv = {
+	.name = "TODDR",
+	.capture = {
+		.stream_name	= "Capture",
+		.channels_min	= 1,
+		.channels_max	= AXG_FIFO_CH_MAX,
+		.rates		= AXG_FIFO_RATES,
+		.formats	= AXG_FIFO_FORMATS,
+	},
+	.ops		= &g12a_toddr_ops,
+	.pcm_new	= axg_toddr_pcm_new,
+};
+
+static const struct snd_soc_component_driver g12a_toddr_component_drv = {
+	.dapm_widgets		= axg_toddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_toddr_dapm_widgets),
+	.dapm_routes		= axg_toddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_toddr_dapm_routes),
+	.ops			= &g12a_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data g12a_toddr_match_data = {
+	.component_drv	= &g12a_toddr_component_drv,
+	.dai_drv	= &g12a_toddr_dai_drv
+};
+
 static const struct of_device_id axg_toddr_of_match[] = {
 	{
 		.compatible = "amlogic,axg-toddr",
 		.data = &axg_toddr_match_data,
+	}, {
+		.compatible = "amlogic,g12a-toddr",
+		.data = &g12a_toddr_match_data,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_toddr_of_match);
-- 
2.20.1
