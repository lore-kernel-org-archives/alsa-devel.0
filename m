From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/6] ASoC: meson: axg-toddr: add g12a support
Date: Thu,  4 Apr 2019 13:17:30 +0200
Message-ID: <20190404111733.28705-4-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Maxime Jourdan <mjourdan@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Since the g12a SoC fifo can set the fifo initial start address, we must
make sure to actually reset the write pointer to this address when
starting a capture.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
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
