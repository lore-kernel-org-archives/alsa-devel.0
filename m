From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v11 3/3] ASoC: fsl: add imx-es8328 machine driver
Date: Thu, 24 Jul 2014 10:15:40 +0800
Message-ID: <1406168140-15961-4-git-send-email-xobs@kosagi.com>
References: <1406168140-15961-1-git-send-email-xobs@kosagi.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406168140-15961-1-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This adds an initial machine driver for the ES8328 audio codec on Freescale
boards.  The driver supports headphones and an audio regulator for an onboard
speaker amp.

Signed-off-by: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/sound/imx-audio-es8328.txt |  60 ++++++
 sound/soc/fsl/Kconfig                              |  14 ++
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/imx-es8328.c                         | 232 +++++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
 create mode 100644 sound/soc/fsl/imx-es8328.c

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt b/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
new file mode 100644
index 0000000..07b68ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
@@ -0,0 +1,60 @@
+Freescale i.MX audio complex with ES8328 codec
+
+Required properties:
+- compatible       : "fsl,imx-audio-es8328"
+- model            : The user-visible name of this sound complex
+- ssi-controller   : The phandle of the i.MX SSI controller
+- jack-gpio        : Optional GPIO for headphone jack
+- audio-amp-supply : Power regulator for speaker amps
+- audio-codec      : The phandle of the ES8328 audio codec
+- audio-routing    : A list of the connections between audio components.
+                     Each entry is a pair of strings, the first being the
+		     connection's sink, the second being the connection's
+		     source. Valid names could be power supplies, ES8328
+		     pins, and the jacks on the board:
+
+			Power supplies:
+			   * audio-amp
+
+			ES8328 pins:
+			   * LOUT1
+			   * LOUT2
+			   * ROUT1
+			   * ROUT2
+			   * LINPUT1
+			   * LINPUT2
+			   * RINPUT1
+			   * RINPUT2
+			   * Mic PGA
+
+			Board connectors:
+			   * Headphone
+			   * Speaker
+			   * Mic Jack
+- mux-int-port     : The internal port of the i.MX audio muxer (AUDMUX)
+- mux-ext-port     : The external port of the i.MX audio muxer (AUDMIX)
+
+Note: The AUDMUX port numbering should start at 1, which is consistent with
+hardware manual.
+
+Example:
+
+sound {
+	compatible = "fsl,imx-audio-es8328";
+	model = "imx-audio-es8328";
+	ssi-controller = <&ssi1>;
+	audio-codec = <&codec>;
+	jack-gpio = <&gpio5 15 0>;
+	audio-amp-supply = <&reg_audio_amp>;
+	audio-routing =
+		"Speaker", "LOUT2",
+		"Speaker", "ROUT2",
+		"Speaker", "audio-amp",
+		"Headphone", "ROUT1",
+		"Headphone", "LOUT1",
+		"LINPUT1", "Mic Jack",
+		"RINPUT1", "Mic Jack",
+		"Mic Jack", "Mic Bias";
+	mux-int-port = <1>;
+	mux-ext-port = <3>;
+};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3793362..c0ace69 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -229,6 +229,20 @@ config SND_SOC_IMX_WM8962
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a wm8962 codec.
 
+config SND_SOC_IMX_ES8328
+	tristate "SoC Audio support for i.MX boards with the ES8328 codec"
+	depends on OF && (I2C || SPI)
+	select SND_SOC_ES8328_I2C if I2C
+	select SND_SOC_ES8328_SPI if SPI_MASTER
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_FSL_SSI
+	select SND_SOC_FSL_UTILS
+	select SND_SOC_IMX_PCM_FIQ
+	help
+	  Say Y if you want to add support for the ES8328 audio codec connected
+	  via SSI/I2S over either SPI or I2C.
+
 config SND_SOC_IMX_SGTL5000
 	tristate "SoC Audio support for i.MX boards with sgtl5000"
 	depends on OF && I2C
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index db254e3..e561766 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -48,6 +48,7 @@ snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
 snd-soc-phycore-ac97-objs := phycore-ac97.o
 snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
+snd-soc-imx-es8328-objs := imx-es8328.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
 snd-soc-imx-wm8962-objs := imx-wm8962.o
 snd-soc-imx-spdif-objs := imx-spdif.o
@@ -57,6 +58,7 @@ obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
+obj-$(CONFIG_SND_SOC_IMX_ES8328) += snd-soc-imx-es8328.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
 obj-$(CONFIG_SND_SOC_IMX_WM8962) += snd-soc-imx-wm8962.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) += snd-soc-imx-spdif.o
diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
new file mode 100644
index 0000000..653e66d
--- /dev/null
+++ b/sound/soc/fsl/imx-es8328.c
@@ -0,0 +1,232 @@
+/*
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
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/i2c.h>
+#include <linux/of_gpio.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+
+#include "imx-audmux.h"
+
+#define DAI_NAME_SIZE	32
+#define MUX_PORT_MAX	7
+
+struct imx_es8328_data {
+	struct device *dev;
+	struct snd_soc_dai_link dai;
+	struct snd_soc_card card;
+	char codec_dai_name[DAI_NAME_SIZE];
+	char platform_name[DAI_NAME_SIZE];
+	int jack_gpio;
+};
+
+static struct snd_soc_jack_gpio headset_jack_gpios[] = {
+	{
+		.gpio = -1,
+		.name = "headset-gpio",
+		.report = SND_JACK_HEADSET,
+		.invert = 0,
+		.debounce_time = 200,
+	},
+};
+
+static struct snd_soc_jack headset_jack;
+
+static int imx_es8328_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct imx_es8328_data *data = container_of(rtd->card,
+					struct imx_es8328_data, card);
+	int ret = 0;
+
+	/* Headphone jack detection */
+	if (gpio_is_valid(data->jack_gpio)) {
+		ret = snd_soc_jack_new(rtd->codec, "Headphone",
+				       SND_JACK_HEADPHONE | SND_JACK_BTN_0,
+				       &headset_jack);
+		if (ret)
+			return ret;
+
+		headset_jack_gpios[0].gpio = data->jack_gpio;
+		ret = snd_soc_jack_add_gpios(&headset_jack,
+					     ARRAY_SIZE(headset_jack_gpios),
+					     headset_jack_gpios);
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget imx_es8328_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("audio-amp", 1, 0),
+};
+
+static int imx_es8328_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ssi_np, *codec_np;
+	struct platform_device *ssi_pdev;
+	struct imx_es8328_data *data;
+	u32 int_port, ext_port;
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	ret = of_property_read_u32(np, "mux-int-port", &int_port);
+	if (ret) {
+		dev_err(dev, "mux-int-port missing or invalid\n");
+		goto fail;
+	}
+	if (int_port > MUX_PORT_MAX || int_port == 0) {
+		dev_err(dev, "mux-int-port: hardware only has %d mux ports\n",
+			MUX_PORT_MAX);
+		goto fail;
+	}
+
+	ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
+	if (ret) {
+		dev_err(dev, "mux-ext-port missing or invalid\n");
+		goto fail;
+	}
+	if (ext_port > MUX_PORT_MAX || ext_port == 0) {
+		dev_err(dev, "mux-ext-port: hardware only has %d mux ports\n",
+			MUX_PORT_MAX);
+		goto fail;
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
+		dev_err(dev, "audmux internal port setup failed\n");
+		return ret;
+	}
+	ret = imx_audmux_v2_configure_port(ext_port,
+			IMX_AUDMUX_V2_PTCR_SYN,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
+	if (ret) {
+		dev_err(dev, "audmux external port setup failed\n");
+		return ret;
+	}
+
+	ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
+	codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
+	if (!ssi_np || !codec_np) {
+		dev_err(dev, "phandle missing or invalid\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	ssi_pdev = of_find_device_by_node(ssi_np);
+	if (!ssi_pdev) {
+		dev_err(dev, "failed to find SSI platform device\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	data->dev = dev;
+
+	data->jack_gpio = of_get_named_gpio(pdev->dev.of_node, "jack-gpio", 0);
+
+	data->dai.name = "hifi";
+	data->dai.stream_name = "hifi";
+	data->dai.codec_dai_name = "es8328-hifi-analog";
+	data->dai.codec_of_node = codec_np;
+	data->dai.cpu_of_node = ssi_np;
+	data->dai.platform_of_node = ssi_np;
+	data->dai.init = &imx_es8328_dai_init;
+	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			    SND_SOC_DAIFMT_CBM_CFM;
+
+	data->card.dev = dev;
+	data->card.dapm_widgets = imx_es8328_dapm_widgets;
+	data->card.num_dapm_widgets = ARRAY_SIZE(imx_es8328_dapm_widgets);
+	ret = snd_soc_of_parse_card_name(&data->card, "model");
+	if (ret) {
+		dev_err(dev, "Unable to parse card name\n");
+		goto fail;
+	}
+	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
+	if (ret) {
+		dev_err(dev, "Unable to parse routing: %d\n", ret);
+		goto fail;
+	}
+	data->card.num_links = 1;
+	data->card.owner = THIS_MODULE;
+	data->card.dai_link = &data->dai;
+
+	ret = snd_soc_register_card(&data->card);
+	if (ret) {
+		dev_err(dev, "Unable to register: %d\n", ret);
+		goto fail;
+	}
+
+	platform_set_drvdata(pdev, data);
+fail:
+	of_node_put(ssi_np);
+	of_node_put(codec_np);
+
+	return ret;
+}
+
+static int imx_es8328_remove(struct platform_device *pdev)
+{
+	struct imx_es8328_data *data = platform_get_drvdata(pdev);
+
+	snd_soc_jack_free_gpios(&headset_jack, ARRAY_SIZE(headset_jack_gpios),
+				headset_jack_gpios);
+
+	snd_soc_unregister_card(&data->card);
+
+	return 0;
+}
+
+static const struct of_device_id imx_es8328_dt_ids[] = {
+	{ .compatible = "fsl,imx-audio-es8328", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_es8328_dt_ids);
+
+static struct platform_driver imx_es8328_driver = {
+	.driver = {
+		.name = "imx-es8328",
+		.of_match_table = imx_es8328_dt_ids,
+	},
+	.probe = imx_es8328_probe,
+	.remove = imx_es8328_remove,
+};
+module_platform_driver(imx_es8328_driver);
+
+MODULE_AUTHOR("Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("Kosagi i.MX6 ES8328 ASoC machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx-audio-es8328");
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
