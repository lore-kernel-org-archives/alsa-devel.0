From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 2/2] ASoC: fsl: add imx-ssm2603 machine driver
Date: Wed, 29 Jan 2014 17:47:27 +0100
Message-ID: <1391014047-22816-2-git-send-email-p.zabel@pengutronix.de>
References: <1391014047-22816-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4D83C2652F5
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 17:47:33 +0100 (CET)
In-Reply-To: <1391014047-22816-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, kernel@pengutronix.de, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

This adds support for i.MX boards with Analog Devices SSM2603 codecs
connected via I2S with separate Tx and Rx clocks.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 sound/soc/fsl/Kconfig       |  12 +++
 sound/soc/fsl/Makefile      |   2 +
 sound/soc/fsl/imx-ssm2603.c | 239 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 sound/soc/fsl/imx-ssm2603.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index b7ab71f..8a4ff4e 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -212,4 +212,16 @@ config SND_SOC_IMX_MC13783
 	select SND_SOC_MC13783
 	select SND_SOC_IMX_PCM_DMA
 
+config SND_SOC_IMX_SSM2603
+	tristate "SoC Audio support for i.MX boards with ssm2603"
+	depends on OF && I2C
+	select SND_SOC_SSM2602
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_FSL_SSI
+	select SND_SOC_FSL_UTILS
+	help
+	  Say Y if you want to add support for SoC audio on an i.MX board with
+	  a ssm2603 codec.
+
 endif # SND_IMX_SOC
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 8db705b..e3b0faf 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -44,6 +44,7 @@ snd-soc-phycore-ac97-objs := phycore-ac97.o
 snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
+snd-soc-imx-ssm2603-objs := imx-ssm2603.o
 snd-soc-imx-wm8962-objs := imx-wm8962.o
 snd-soc-imx-spdif-objs := imx-spdif.o
 snd-soc-imx-mc13783-objs := imx-mc13783.o
@@ -53,6 +54,7 @@ obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
+obj-$(CONFIG_SND_SOC_IMX_SSM2603) += snd-soc-imx-ssm2603.o
 obj-$(CONFIG_SND_SOC_IMX_WM8962) += snd-soc-imx-wm8962.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) += snd-soc-imx-spdif.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
diff --git a/sound/soc/fsl/imx-ssm2603.c b/sound/soc/fsl/imx-ssm2603.c
new file mode 100644
index 0000000..da9c465
--- /dev/null
+++ b/sound/soc/fsl/imx-ssm2603.c
@@ -0,0 +1,239 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
+ * Copyright 2013 Philipp Zabel, Pengutronix
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/clk.h>
+#include <sound/soc.h>
+
+#include "../codecs/ssm2602.h"
+#include "imx-audmux.h"
+
+#define DAI_NAME_SIZE	32
+
+struct imx_ssm2603_data {
+	struct snd_soc_dai_link dai;
+	struct snd_soc_card card;
+	struct clk *codec_clk;
+	unsigned int clk_frequency;
+	struct gpio_desc *speaker_en_gpio;
+};
+
+static int imx_ssm2603_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct imx_ssm2603_data *data = container_of(rtd->card,
+					struct imx_ssm2603_data, card);
+	struct device *dev = rtd->card->dev;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(rtd->codec_dai, SSM2602_SYSCLK,
+				     data->clk_frequency, SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(dev, "could not set codec driver clock params\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_ssm2603_speaker_power(struct snd_soc_dapm_widget *w,
+				     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct imx_ssm2603_data *data = snd_soc_card_get_drvdata(card);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpiod_set_value(data->speaker_en_gpio, 1);
+	else
+		gpiod_set_value(data->speaker_en_gpio, 0);
+
+	return 0;
+}
+
+
+static const struct snd_soc_dapm_widget imx_ssm2603_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Line Out Jack", NULL),
+	SND_SOC_DAPM_SPK("Int Spk", imx_ssm2603_speaker_power),
+};
+
+static int imx_ssm2603_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ssi_np, *codec_np;
+	struct platform_device *ssi_pdev;
+	struct i2c_client *codec_dev;
+	struct imx_ssm2603_data *data;
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
+			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_RFSEL(ext_port | IMX_AUDMUX_RXFS) |
+			IMX_AUDMUX_V2_PTCR_RCSEL(ext_port | IMX_AUDMUX_RXCLK) |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_RFSDIR |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_RCLKDIR,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
+	if (ret) {
+		dev_err(&pdev->dev, "audmux internal port setup failed\n");
+		return ret;
+	}
+	ret = imx_audmux_v2_configure_port(ext_port, 0,
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
+		ret = -EPROBE_DEFER;
+		goto fail;
+	}
+	codec_dev = of_find_i2c_device_by_node(codec_np);
+	if (!codec_dev) {
+		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		return -EPROBE_DEFER;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
+	if (IS_ERR(data->codec_clk))
+		goto fail;
+
+	data->clk_frequency = clk_get_rate(data->codec_clk);
+
+	data->dai.name = "HiFi";
+	data->dai.stream_name = "HiFi";
+	data->dai.codec_dai_name = "ssm2602-hifi";
+	data->dai.codec_of_node = codec_np;
+	data->dai.cpu_of_node = ssi_np;
+	data->dai.platform_of_node = ssi_np;
+	data->dai.init = &imx_ssm2603_dai_init;
+	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			    SND_SOC_DAIFMT_CBM_CFM;
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
+	data->card.dapm_widgets = imx_ssm2603_dapm_widgets;
+	data->card.num_dapm_widgets = ARRAY_SIZE(imx_ssm2603_dapm_widgets);
+
+	data->speaker_en_gpio = devm_gpiod_get(&pdev->dev, "fsl,spkr-en");
+	if (IS_ERR(data->speaker_en_gpio)) {
+		dev_err(&pdev->dev, "Failed to get fsl,spkr-en-gpios!\n");
+	} else {
+		gpiod_direction_output(data->speaker_en_gpio, 0);
+		/* FIXME */
+		gpiod_set_value(data->speaker_en_gpio, 0);
+	}
+
+	ret = snd_soc_register_card(&data->card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		goto fail;
+	}
+
+	platform_set_drvdata(pdev, data);
+	snd_soc_card_set_drvdata(&data->card, data);
+	of_node_put(ssi_np);
+	of_node_put(codec_np);
+
+	return 0;
+
+fail:
+	if (ssi_np)
+		of_node_put(ssi_np);
+	if (codec_np)
+		of_node_put(codec_np);
+
+	return ret;
+}
+
+static int imx_ssm2603_remove(struct platform_device *pdev)
+{
+	struct imx_ssm2603_data *data = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(&data->card);
+
+	return 0;
+}
+
+static const struct of_device_id imx_ssm2603_dt_ids[] = {
+	{ .compatible = "fsl,imx-audio-ssm2603", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, imx_ssm2603_dt_ids);
+
+static struct platform_driver imx_ssm2603_driver = {
+	.driver = {
+		.name = "imx-ssm2603",
+		.owner = THIS_MODULE,
+		.of_match_table = imx_ssm2603_dt_ids,
+	},
+	.probe = imx_ssm2603_probe,
+	.remove = imx_ssm2603_remove,
+};
+module_platform_driver(imx_ssm2603_driver);
+
+MODULE_AUTHOR("Philipp Zabel <p.zabel@pengutronix.de>");
+MODULE_DESCRIPTION("Freescale i.MX ssm2603 ASoC machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx-ssm2603");
-- 
1.8.5.3
