From: "Felipe F. Tonello" <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH] ASoC: fsl: add imx-cs427x machine driver
Date: Mon, 25 Jan 2016 17:53:23 +0000
Message-ID: <1453744403-12268-1-git-send-email-eu@felipetonello.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is the initial imx-cs427x device-tree-only machine driver working with
fsl_ssi driver. More features can be added on top of it later.

Signed-off-by: Felipe F. Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
---
 .../devicetree/bindings/sound/imx-audio-cs427x.txt |  47 +++++
 sound/soc/fsl/Kconfig                              |  12 ++
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/imx-cs427x.c                         | 218 +++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
 create mode 100644 sound/soc/fsl/imx-cs427x.c

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
new file mode 100644
index 000000000000..295f60b19418
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
@@ -0,0 +1,47 @@
+Freescale i.MX audio complex with CS4271 or CS4272 codec
+
+Required properties:
+
+  - compatible		: "fsl,imx-audio-cs427x"
+
+  - model		: The user-visible name of this sound complex
+
+  - ssi-controller	: The phandle of the i.MX SSI controller
+
+  - audio-codec	: The phandle of the CS4271 audio codec
+
+  - audio-routing	: A list of the connections between audio components.
+			  Each entry is a pair of strings, the first being the
+			  connection's sink, the second being the connection's
+			  source. Valid names could be power supplies, CS427x
+			  pins, and the jacks on the board:
+
+			  Board connectors:
+			   * Mic Jack
+			   * Headphone Jack
+
+  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
+
+  - mux-ext-port	: The external port of the i.MX audio muxer
+
+Note: The AUDMUX port numbering should start at 1, which is consistent with
+hardware manual.
+
+Example:
+
+sound {
+	compatible = "fsl,imx6-rex-cs427x",
+		"fsl,imx-audio-cs427x";
+	model = "audio-cs427x";
+	ssi-controller = <&ssi1>;
+	audio-codec = <&cs4271>;
+	audio-routing =
+		"Mic Jack", "AINA",
+		"Mic Jack", "AINB",
+		"Headphone Jack", "AOUTA+",
+		"Headphone Jack", "AOUTA-",
+		"Headphone Jack", "AOUTB+",
+		"Headphone Jack", "AOUTB-";
+	mux-int-port = <1>;
+	mux-ext-port = <3>;
+};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 14dfdee05fd5..8696b5c42dd8 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -263,6 +263,18 @@ config SND_SOC_IMX_SGTL5000
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a sgtl5000 codec.
 
+config SND_SOC_IMX_CS427x
+	tristate "SoC Audio support for i.MX boards with cs4271 or cs4272"
+	depends on OF && (I2C || SPI)
+	select SND_SOC_CS4271_I2C if I2C
+	select SND_SOC_CS4271_SPI if SPI_MASTER
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_FSL_SSI
+	help
+	  Say Y if you want to add support for SoC audio on an i.MX board with
+	  a CS4271 or CS4272 codec over either SPI or I2C.
+
 config SND_SOC_IMX_SPDIF
 	tristate "SoC Audio support for i.MX boards with S/PDIF"
 	select SND_SOC_IMX_PCM_DMA
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index d28dc25c9375..334d183e3a17 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -54,6 +54,7 @@ snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-es8328-objs := imx-es8328.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
+snd-soc-imx-cs427x-objs := imx-cs427x.o
 snd-soc-imx-wm8962-objs := imx-wm8962.o
 snd-soc-imx-spdif-objs := imx-spdif.o
 snd-soc-imx-mc13783-objs := imx-mc13783.o
@@ -64,6 +65,7 @@ obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_ES8328) += snd-soc-imx-es8328.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
+obj-$(CONFIG_SND_SOC_IMX_CS427x) += snd-soc-imx-cs427x.o
 obj-$(CONFIG_SND_SOC_IMX_WM8962) += snd-soc-imx-wm8962.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) += snd-soc-imx-spdif.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
diff --git a/sound/soc/fsl/imx-cs427x.c b/sound/soc/fsl/imx-cs427x.c
new file mode 100644
index 000000000000..45c56013822b
--- /dev/null
+++ b/sound/soc/fsl/imx-cs427x.c
@@ -0,0 +1,218 @@
+/*
+ * Copyright 2015 ROLI Ltd.
+ * Author: Felipe F. Tonello <felipe.tonello-sJD5iFO22Lw@public.gmane.org>
+ *
+ * Based on imx-sgtl5000.c
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/i2c.h>
+#include <linux/clk.h>
+#include <sound/soc.h>
+
+#include "imx-audmux.h"
+
+#define CS427x_SYSCLK_MCLK 0
+
+struct imx_cs427x_data {
+	struct snd_soc_dai_link dai;
+	struct snd_soc_card card;
+	struct clk *codec_clk;
+	unsigned int clk_frequency;
+};
+
+static int imx_cs427x_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct imx_cs427x_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct device *dev = rtd->card->dev;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(rtd->codec_dai, CS427x_SYSCLK_MCLK,
+			data->clk_frequency, SND_SOC_CLOCK_IN);
+	if (ret)
+		dev_err(dev, "failed to set sysclk\n");
+
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget imx_cs427x_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+};
+
+static int imx_cs427x_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ssi_np, *codec_np;
+	struct platform_device *ssi_pdev;
+	struct i2c_client *codec_dev;
+	struct imx_cs427x_data *data = NULL;
+	int int_port, ext_port;
+	int ret;
+
+	ret = of_property_read_u32(np, "mux-int-port", &int_port);
+	if (ret) {
+		dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
+		return ret;
+	}
+	ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
+	if (ret) {
+		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
+		return ret;
+	}
+
+	/*
+	 * The port numbering in the hardware manual starts at 1, while
+	 * the audmux API expects it starts at 0.
+	 */
+	int_port--;
+	ext_port--;
+	ret = imx_audmux_v2_configure_port(int_port,
+			IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
+	if (ret) {
+		dev_err(&pdev->dev, "audmux internal port setup failed\n");
+		return ret;
+	}
+	ret = imx_audmux_v2_configure_port(ext_port,
+			IMX_AUDMUX_V2_PTCR_SYN,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
+	if (ret) {
+		dev_err(&pdev->dev, "audmux external port setup failed\n");
+		return ret;
+	}
+
+	ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
+	codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
+	if (!ssi_np || !codec_np) {
+		dev_err(&pdev->dev, "phandle missing or invalid\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	ssi_pdev = of_find_device_by_node(ssi_np);
+	if (!ssi_pdev) {
+		dev_err(&pdev->dev, "failed to find SSI platform device\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+	codec_dev = of_find_i2c_device_by_node(codec_np);
+	if (!codec_dev) {
+		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	data->codec_clk = clk_get(&codec_dev->dev, NULL);
+	if (IS_ERR(data->codec_clk)) {
+		ret = PTR_ERR(data->codec_clk);
+		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
+		goto fail;
+	}
+
+	data->clk_frequency = clk_get_rate(data->codec_clk);
+	ret = clk_prepare_enable(data->codec_clk);
+	if (ret) {
+		dev_err(&codec_dev->dev, "failed to enable codec clk: %d\n", ret);
+		goto fail;
+	}
+
+	data->dai.name = "HiFi";
+	data->dai.stream_name = "HiFi";
+	data->dai.codec_dai_name = "cs4271-hifi";
+	data->dai.codec_of_node = codec_np;
+	data->dai.cpu_of_node = ssi_np;
+	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
+	data->dai.platform_of_node = ssi_np;
+	data->dai.init = &imx_cs427x_dai_init;
+	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM;
+
+	data->card.dev = &pdev->dev;
+	ret = snd_soc_of_parse_card_name(&data->card, "model");
+	if (ret)
+		goto fail;
+	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
+	if (ret)
+		goto fail;
+	data->card.num_links = 1;
+	data->card.owner = THIS_MODULE;
+	data->card.dai_link = &data->dai;
+	data->card.dapm_widgets = imx_cs427x_dapm_widgets;
+	data->card.num_dapm_widgets = ARRAY_SIZE(imx_cs427x_dapm_widgets);
+
+	platform_set_drvdata(pdev, &data->card);
+	snd_soc_card_set_drvdata(&data->card, data);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		goto fail;
+	}
+
+	of_node_put(ssi_np);
+	of_node_put(codec_np);
+
+	return 0;
+
+fail:
+	if (data && !IS_ERR(data->codec_clk))
+		clk_put(data->codec_clk);
+	of_node_put(ssi_np);
+	of_node_put(codec_np);
+
+	return ret;
+}
+
+static int imx_cs427x_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct imx_cs427x_data *data = snd_soc_card_get_drvdata(card);
+
+	clk_put(data->codec_clk);
+
+	return 0;
+}
+
+static const struct of_device_id imx_cs427x_dt_ids[] = {
+	{ .compatible = "fsl,imx-audio-cs427x", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_cs427x_dt_ids);
+
+static struct platform_driver imx_cs427x_driver = {
+	.driver = {
+		.name = "imx-cs427x",
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = imx_cs427x_dt_ids,
+	},
+	.probe = imx_cs427x_probe,
+	.remove = imx_cs427x_remove,
+};
+module_platform_driver(imx_cs427x_driver);
+
+MODULE_AUTHOR("Felipe F. Tonello <felipe.tonello-sJD5iFO22Lw@public.gmane.org>");
+MODULE_DESCRIPTION("Freescale i.MX CS427x ASoC machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx-cs427x");
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
