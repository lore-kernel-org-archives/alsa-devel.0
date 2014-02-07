From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] sound: soc: fsl: Add support for Novena onboard audio
Date: Fri,  7 Feb 2014 13:05:16 +0800
Message-ID: <1391749517-11787-3-git-send-email-xobs@kosagi.com>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391749517-11787-1-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Novena uses an ES8328 audio codec connected via I2S.
---
 sound/soc/fsl/Kconfig      |  13 ++
 sound/soc/fsl/Makefile     |   2 +
 sound/soc/fsl/imx-novena.c | 344 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 sound/soc/fsl/imx-novena.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 07f8f14..88e7fbf 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -163,6 +163,19 @@ config SND_SOC_PHYCORE_AC97
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
 
+config SND_SOC_IMX_NOVENA
+	tristate "SoC Audio support for i.MX6-based Novena boards"
+	depends on OF && I2C
+	select SND_SOC_ES8328
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_FSL_SSI
+	select SND_SOC_FSL_UTILS
+	select SND_SOC_IMX_PCM_FIQ
+	help
+	  Say Y if you want to add support for SoC audio on an i.MX board with
+	  an audio codec connected via SSI/I2S.
+
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
 	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index b12ad4b..fc89017 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -47,6 +47,7 @@ snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
 snd-soc-phycore-ac97-objs := phycore-ac97.o
 snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
+snd-soc-imx-novena-objs := imx-novena.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
 snd-soc-imx-wm8962-objs := imx-wm8962.o
 snd-soc-imx-spdif-objs := imx-spdif.o
@@ -56,6 +57,7 @@ obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
+obj-$(CONFIG_SND_SOC_IMX_NOVENA) += snd-soc-imx-novena.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
 obj-$(CONFIG_SND_SOC_IMX_WM8962) += snd-soc-imx-wm8962.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) += snd-soc-imx-spdif.o
diff --git a/sound/soc/fsl/imx-novena.c b/sound/soc/fsl/imx-novena.c
new file mode 100644
index 0000000..6e06de9
--- /dev/null
+++ b/sound/soc/fsl/imx-novena.c
@@ -0,0 +1,344 @@
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
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/i2c.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/clk-provider.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+
+#include "imx-audmux.h"
+
+#define DAI_NAME_SIZE	32
+#define IMX6Q_SYSCLK 0x00
+
+struct imx_novena_data {
+	struct device *dev;
+	struct snd_soc_dai_link dai;
+	struct snd_soc_card card;
+	char codec_dai_name[DAI_NAME_SIZE];
+	char platform_name[DAI_NAME_SIZE];
+	struct clk *codec_clk;
+	struct clk *codec_clk_src;
+	struct clk *codec_clk_sel;
+	struct clk *codec_clk_post_div;
+	struct clk *system_cko;
+	unsigned int clk_freq_src;
+	unsigned int clk_frequency;
+	int power_gpio;
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
+static int imx_novena_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct imx_novena_data *data = container_of(rtd->card,
+					struct imx_novena_data, card);
+	struct device *dev = rtd->card->dev;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(rtd->codec_dai, IMX6Q_SYSCLK,
+				     data->clk_frequency, SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(dev, "could not set codec driver clock params to %d\n",
+			data->clk_frequency);
+		return ret;
+	}
+
+	/* Headphone jack detection */
+	if (gpio_is_valid(data->jack_gpio)) {
+		ret = snd_soc_jack_new(rtd->codec, "Headset",
+				       SND_JACK_HEADSET | SND_JACK_BTN_0,
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
+static const struct snd_soc_dapm_widget imx_novena_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static int imx_set_frequency(struct imx_novena_data *data, int freq) {
+	int ret;
+
+	ret = clk_set_parent(data->system_cko, data->codec_clk);
+	if (ret) {
+		dev_err(data->dev, "unable to set clk output");
+		return ret;
+	}
+
+	ret = clk_set_parent(data->codec_clk_sel, data->codec_clk_post_div);
+	if (ret) {
+		dev_err(data->dev, "unable to set clk parent");
+		return ret;
+	}
+
+	data->clk_freq_src = clk_round_rate(data->codec_clk_src, freq*32);
+	data->clk_frequency = clk_round_rate(data->codec_clk, freq);
+	dev_dbg(data->dev, "clock source frequency: %d\n", data->clk_freq_src);
+	dev_dbg(data->dev, "clock frequency: %d\n", data->clk_frequency);
+
+	ret = clk_set_rate(data->codec_clk_src, data->clk_freq_src);
+	if (ret) {
+		dev_err(data->dev, "unable to set source clock rate\n");
+		return ret;
+	}
+
+	ret = clk_set_rate(data->codec_clk, data->clk_frequency);
+	if (ret) {
+		dev_err(data->dev, "unable to set codec clock rate\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(data->codec_clk);
+	if (ret) {
+		dev_err(data->dev, "unable to prepare codec clk\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(data->codec_clk_src);
+	if (ret) {
+		dev_err(data->dev, "unable to prepare codec clk source\n");
+		return ret;
+	}
+	return ret;
+}
+
+static int imx_novena_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ssi_np, *codec_np;
+	struct platform_device *ssi_pdev;
+	struct i2c_client *codec_dev;
+	struct imx_novena_data *data;
+	int int_port, ext_port;
+	int ret;
+	struct device *dev = &pdev->dev;
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
+	data->dev = dev;
+
+	data->jack_gpio = of_get_named_gpio(pdev->dev.of_node,
+				"jack-gpio", 0);
+
+	data->power_gpio = of_get_named_gpio(pdev->dev.of_node,
+				"power-gpio", 0);
+	if (gpio_is_valid(data->power_gpio))
+		devm_gpio_request_one(&pdev->dev, data->power_gpio,
+				    GPIOF_OUT_INIT_HIGH,
+				    "audio codec power switch");
+
+	/* Setup clocks */
+	data->codec_clk = devm_clk_get(dev, "cko1");
+	if (IS_ERR(data->codec_clk)) {
+		dev_err(dev,
+			"codec clock missing or invalid\n");
+		goto fail;
+	}
+
+	data->codec_clk_sel = devm_clk_get(dev, "cko1_sel");
+	if (IS_ERR(data->codec_clk_sel)) {
+		dev_err(dev,
+			"codec clock select missing or invalid\n");
+		goto fail;
+	}
+
+	data->codec_clk_src = devm_clk_get(dev, "pll4_audio");
+	if (IS_ERR(data->codec_clk_src)) {
+		dev_err(dev,
+			"codec clock source missing or invalid\n");
+		goto fail;
+	}
+
+	data->codec_clk_post_div = devm_clk_get(dev, "pll4_post_div");
+	if (IS_ERR(data->codec_clk_post_div)) {
+		dev_err(dev,
+			"codec clock post-div missing or invalid\n");
+		goto fail;
+	}
+
+	data->system_cko = devm_clk_get(dev, "cko_sel");
+	if (IS_ERR(data->system_cko)) {
+		dev_err(dev,
+			"system clock missing or invalid\n");
+		goto fail;
+	}
+
+	ret = imx_set_frequency(data, 22579200);
+	if (ret)
+		goto fail;
+
+
+	data->dai.name = "hifi";
+	data->dai.stream_name = "hifi";
+	data->dai.codec_dai_name = "es8328-hifi-analog";
+	data->dai.codec_of_node = codec_np;
+	data->dai.cpu_of_node = ssi_np;
+	data->dai.platform_of_node = ssi_np;
+	data->dai.init = &imx_novena_dai_init;
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
+	data->card.dapm_widgets = imx_novena_dapm_widgets;
+	data->card.num_dapm_widgets = ARRAY_SIZE(imx_novena_dapm_widgets);
+
+	ret = snd_soc_register_card(&data->card);
+	if (ret)
+		goto fail;
+
+	platform_set_drvdata(pdev, data);
+fail:
+	if (ssi_np)
+		of_node_put(ssi_np);
+	if (codec_np)
+		of_node_put(codec_np);
+
+	return ret;
+}
+
+static int imx_novena_remove(struct platform_device *pdev)
+{
+	struct imx_novena_data *data = platform_get_drvdata(pdev);
+
+	snd_soc_jack_free_gpios(&headset_jack, ARRAY_SIZE(headset_jack_gpios),
+				headset_jack_gpios);
+
+	if (data->codec_clk)
+		clk_disable_unprepare(data->codec_clk);
+
+	if (data->codec_clk_src)
+		clk_disable_unprepare(data->codec_clk_src);
+
+	snd_soc_unregister_card(&data->card);
+
+	return 0;
+}
+
+static const struct of_device_id imx_novena_dt_ids[] = {
+	{ .compatible = "kosagi,imx-audio-novena", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_novena_dt_ids);
+
+static struct platform_driver imx_novena_driver = {
+	.driver = {
+		.name = "imx-novena",
+		.owner = THIS_MODULE,
+		.of_match_table = imx_novena_dt_ids,
+	},
+	.probe = imx_novena_probe,
+	.remove = imx_novena_remove,
+};
+module_platform_driver(imx_novena_driver);
+
+MODULE_AUTHOR("Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
+MODULE_DESCRIPTION("Kosagi i.MX6 Novena ASoC machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx-audio-novena");
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
