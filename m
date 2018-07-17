From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 04/15] ASoC: meson: add axg toddr driver
Date: Tue, 17 Jul 2018 17:36:28 +0200
Message-ID: <20180717153643.8806-5-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add the capture memory interface of Amlogic's axg SoCs.
TDM, SPDIF or PDM input devices place audio samples inside this FIFO.
The FIFO content is then pushed to DDR

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig     |   7 ++
 sound/soc/meson/Makefile    |   2 +
 sound/soc/meson/axg-toddr.c | 199 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 sound/soc/meson/axg-toddr.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index cdd78f62e8d7..3916060edcae 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -12,4 +12,11 @@ config SND_MESON_AXG_FRDDR
 	  Select Y or M to add support for the frontend playback interfaces
 	  embedded in the Amlogic AXG SoC family
 
+config SND_MESON_AXG_TODDR
+	tristate "Amlogic AXG Capture FIFO support"
+	select SND_MESON_AXG_FIFO
+	help
+	  Select Y or M to add support for the frontend capture interfaces
+	  embedded in the Amlogic AXG SoC family
+
 endmenu
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index 9c5d7d4a8e33..12edf2db2a24 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -2,6 +2,8 @@
 
 snd-soc-meson-axg-fifo-objs := axg-fifo.o
 snd-soc-meson-axg-frddr-objs := axg-frddr.o
+snd-soc-meson-axg-toddr-objs := axg-toddr.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
 obj-$(CONFIG_SND_MESON_AXG_FRDDR) += snd-soc-meson-axg-frddr.o
+obj-$(CONFIG_SND_MESON_AXG_TODDR) += snd-soc-meson-axg-toddr.o
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
new file mode 100644
index 000000000000..c2c9bb312586
--- /dev/null
+++ b/sound/soc/meson/axg-toddr.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+/* This driver implements the frontend capture DAI of AXG based SoCs */
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "axg-fifo.h"
+
+#define CTRL0_TODDR_SEL_RESAMPLE	BIT(30)
+#define CTRL0_TODDR_EXT_SIGNED		BIT(29)
+#define CTRL0_TODDR_PP_MODE		BIT(28)
+#define CTRL0_TODDR_TYPE_MASK		GENMASK(15, 13)
+#define CTRL0_TODDR_TYPE(x)		((x) << 13)
+#define CTRL0_TODDR_MSB_POS_MASK	GENMASK(12, 8)
+#define CTRL0_TODDR_MSB_POS(x)		((x) << 8)
+#define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
+#define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
+
+static int axg_toddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_soc_dai *dai)
+{
+	return axg_fifo_pcm_new(rtd, SNDRV_PCM_STREAM_CAPTURE);
+}
+
+static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+	unsigned int type, width, msb = 31;
+
+	/*
+	 * NOTE:
+	 * Almost all backend will place the MSB at bit 31, except SPDIF Input
+	 * which will put it at index 28. When adding support for the SPDIF
+	 * Input, we'll need to find which type of backend we are connected to.
+	 */
+
+	switch (params_physical_width(params)) {
+	case 8:
+		type = 0; /* 8 samples of 8 bits */
+		break;
+	case 16:
+		type = 2; /* 4 samples of 16 bits - right justified */
+		break;
+	case 32:
+		type = 4; /* 2 samples of 32 bits - right justified */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	width = params_width(params);
+
+	regmap_update_bits(fifo->map, FIFO_CTRL0,
+			   CTRL0_TODDR_TYPE_MASK |
+			   CTRL0_TODDR_MSB_POS_MASK |
+			   CTRL0_TODDR_LSB_POS_MASK,
+			   CTRL0_TODDR_TYPE(type) |
+			   CTRL0_TODDR_MSB_POS(msb) |
+			   CTRL0_TODDR_LSB_POS(msb - (width - 1)));
+
+	return 0;
+}
+
+static int axg_toddr_dai_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+	unsigned int fifo_threshold;
+	int ret;
+
+	/* Enable pclk to access registers and clock the fifo ip */
+	ret = clk_prepare_enable(fifo->pclk);
+	if (ret)
+		return ret;
+
+	/* Select orginal data - resampling not supported ATM */
+	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_TODDR_SEL_RESAMPLE, 0);
+
+	/* Only signed format are supported ATM */
+	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_TODDR_EXT_SIGNED,
+			   CTRL0_TODDR_EXT_SIGNED);
+
+	/* Apply single buffer mode to the interface */
+	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_TODDR_PP_MODE, 0);
+
+	/* TODDR does not have a configurable fifo depth */
+	fifo_threshold = AXG_FIFO_MIN_CNT - 1;
+	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_THRESHOLD_MASK,
+			   CTRL1_THRESHOLD(fifo_threshold));
+
+	return 0;
+}
+
+static void axg_toddr_dai_shutdown(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable_unprepare(fifo->pclk);
+}
+
+static const struct snd_soc_dai_ops axg_toddr_ops = {
+	.hw_params	= axg_toddr_dai_hw_params,
+	.startup	= axg_toddr_dai_startup,
+	.shutdown	= axg_toddr_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver axg_toddr_dai_drv = {
+	.name = "TODDR",
+	.capture = {
+		.stream_name	= "Capture",
+		.channels_min	= 1,
+		.channels_max	= AXG_FIFO_CH_MAX,
+		.rates		= AXG_FIFO_RATES,
+		.formats	= AXG_FIFO_FORMATS,
+	},
+	.ops		= &axg_toddr_ops,
+	.pcm_new	= axg_toddr_pcm_new,
+};
+
+static const char * const axg_toddr_sel_texts[] = {
+	"IN 0", "IN 1", "IN 2", "IN 3", "IN 4", "IN 6"
+};
+
+static const unsigned int axg_toddr_sel_values[] = {
+	0, 1, 2, 3, 4, 6
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(axg_toddr_sel_enum, FIFO_CTRL0,
+				  CTRL0_SEL_SHIFT, CTRL0_SEL_MASK,
+				  axg_toddr_sel_texts, axg_toddr_sel_values);
+
+static const struct snd_kcontrol_new axg_toddr_in_mux =
+	SOC_DAPM_ENUM("Input Source", axg_toddr_sel_enum);
+
+static const struct snd_soc_dapm_widget axg_toddr_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("SRC SEL", SND_SOC_NOPM, 0, 0, &axg_toddr_in_mux),
+	SND_SOC_DAPM_AIF_IN("IN 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 6", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route axg_toddr_dapm_routes[] = {
+	{ "Capture", NULL, "SRC SEL" },
+	{ "SRC SEL", "IN 0", "IN 0" },
+	{ "SRC SEL", "IN 1", "IN 1" },
+	{ "SRC SEL", "IN 2", "IN 2" },
+	{ "SRC SEL", "IN 3", "IN 3" },
+	{ "SRC SEL", "IN 4", "IN 4" },
+	{ "SRC SEL", "IN 6", "IN 6" },
+};
+
+static const struct snd_soc_component_driver axg_toddr_component_drv = {
+	.dapm_widgets		= axg_toddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_toddr_dapm_widgets),
+	.dapm_routes		= axg_toddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_toddr_dapm_routes),
+	.ops			= &axg_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data axg_toddr_match_data = {
+	.component_drv	= &axg_toddr_component_drv,
+	.dai_drv	= &axg_toddr_dai_drv
+};
+
+static const struct of_device_id axg_toddr_of_match[] = {
+	{
+		.compatible = "amlogic,axg-toddr",
+		.data = &axg_toddr_match_data,
+	}, {}
+};
+MODULE_DEVICE_TABLE(of, axg_toddr_of_match);
+
+static struct platform_driver axg_toddr_pdrv = {
+	.probe = axg_fifo_probe,
+	.driver = {
+		.name = "axg-toddr",
+		.of_match_table = axg_toddr_of_match,
+	},
+};
+module_platform_driver(axg_toddr_pdrv);
+
+MODULE_DESCRIPTION("Amlogic AXG capture fifo driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.4
