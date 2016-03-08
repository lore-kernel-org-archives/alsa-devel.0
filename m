From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v4] ASoC: imx-wm8958: add imx-wm8958 machine
	driver
Date: Tue, 8 Mar 2016 14:27:56 +0800
Message-ID: <4db703a76e01f1c9ad3eda78758f3e121098e515.1457417904.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 by alsa0.perex.cz (Postfix) with ESMTP id BF73C261298
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 07:24:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

This is an initial imx-wm8958 device-tree-only machine driver.
The sound card driver support three dai link, HIFI, VOICE and BT.
We can configure the cpu dai from device tree, if present it
will create corresponding sound card subdevice. So at least
one cpu dai phandle should be set from device tree.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
v3->v4: remove the dummy cpu dai, support set cpu dai1/2/3 from device tree.
	When cpu-dai1/2/3 present it will create croresponding sound card
	subdevice. At least one cpu dai should be configured.

 .../devicetree/bindings/sound/imx-audio-wm8958.txt |  56 ++++
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 sound/soc/fsl/Kconfig                              |  14 +
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/imx-wm8958.c                         | 327 +++++++++++++++++++++
 5 files changed, 400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
 create mode 100644 sound/soc/fsl/imx-wm8958.c

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt b/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
new file mode 100644
index 0000000..c013287
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
@@ -0,0 +1,56 @@
+Freescale i.MX audio complex with WM8958 codec
+
+Required properties:
+
+  - compatible		   : "fsl,imx-audio-wm8958"
+
+  - model		   : The user-visible name of this sound complex
+
+  - audio-codec            : The phandle of the WM8958 audio codec
+
+  - audio-routing	   : A list of the connections between audio components.
+			     Each entry is a pair of strings, the first being
+			     the connection's sink, the second being the
+			     connection's source. Valid names could be power
+			     supplies, WM8958 pins, and the jacks on the board:
+
+			     Power supplies:
+			      * MICBIAS1
+			      * MICBIAS2
+
+			     Board connectors:
+			      * Headphone Jack
+			      * Ext Spk
+
+Optional properties:
+
+ - cpu-dai1		   : The phandle of CPU DAI1 controller. At least one
+			     cpu dai is required.
+
+ - cpu-dai2                : The phandle of CPU DAI2 controller. At least one
+			     cpu dai is required.
+
+ - cpu-dai3                : The phandle of CPU DAI3 controller. At least one
+			     cpu dai is required.
+
+ - fsl,cpu-dai1-master   : If present, cpu dai1 works as master, and will
+			   provide bit clock and frame clock. Otherwise,
+			   cpu dai1 works as slave.
+
+Example:
+
+sound {
+		compatible = "fsl,imx6ul-evk-wm8958",
+			   "fsl,imx-audio-wm8958";
+		model = "wm8958-audio";
+		cpu-dai1 = <&sai1>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"Headphone Jack", "HPOUT1L",
+			"Headphone Jack", "HPOUT1R",
+			"Ext Spk", "SPKOUTLP",
+			"Ext Spk", "SPKOUTLN",
+			"Ext Spk", "SPKOUTRP",
+			"Ext Spk", "SPKOUTRN",
+			"IN1LN", "MICBIAS2";
+};
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 978c5de..7ac5856 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -251,6 +251,7 @@ CONFIG_SND_SOC_FSL_ASRC=y
 CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
+CONFIG_SND_SOC_IMX_WM8958=y
 CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 35aabf9..f6e5d96 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -229,6 +229,20 @@ config SND_SOC_EUKREA_TLV320
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
 
+config SND_SOC_IMX_WM8958
+	tristate "SoC Audio support for i.MX boards with wm8958"
+	depends on OF && I2C
+	select MFD_WM8994
+	select SND_SOC_WM8994
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_FSL_SAI
+	select SND_SOC_FSL_UTILS
+	select SND_KCTL_JACK
+	help
+	 SoC Audio support for i.MX boards with WM8958
+	 Say Y if you want to add support for SoC audio on an i.MX board with
+	 a wm8958 codec.
+
 config SND_SOC_IMX_WM8962
 	tristate "SoC Audio support for i.MX boards with wm8962"
 	depends on OF && I2C && INPUT
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index d28dc25..2a781c0 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -54,6 +54,7 @@ snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-es8328-objs := imx-es8328.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
+snd-soc-imx-wm8958-objs := imx-wm8958.o
 snd-soc-imx-wm8962-objs := imx-wm8962.o
 snd-soc-imx-spdif-objs := imx-spdif.o
 snd-soc-imx-mc13783-objs := imx-mc13783.o
@@ -64,6 +65,7 @@ obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_ES8328) += snd-soc-imx-es8328.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
+obj-$(CONFIG_SND_SOC_IMX_WM8958) += snd-soc-imx-wm8958.o
 obj-$(CONFIG_SND_SOC_IMX_WM8962) += snd-soc-imx-wm8962.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) += snd-soc-imx-spdif.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
diff --git a/sound/soc/fsl/imx-wm8958.c b/sound/soc/fsl/imx-wm8958.c
new file mode 100644
index 0000000..0e8a9b2
--- /dev/null
+++ b/sound/soc/fsl/imx-wm8958.c
@@ -0,0 +1,327 @@
+/*
+ * Copyright (C) 2015-2016 Freescale Semiconductor, Inc.
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
+#include <linux/of_platform.h>
+#include <linux/i2c.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/clk.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <sound/control.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dapm.h>
+#include <linux/mfd/wm8994/registers.h>
+#include "../fsl/fsl_sai.h"
+#include "../codecs/wm8994.h"
+
+#define DAI_NAME_SIZE	32
+
+#define DAI_LINK_NUM (3)
+#define HIFI_DAI (0)
+#define VOICE_DAI (1)
+#define BT_DAI (2)
+
+#define WM8958_MCLK_MAX (2)
+
+#define WM8994_FLL(id) (id == HIFI_DAI ? WM8994_FLL1 : WM8994_FLL2)
+#define WM8994_SYSCLK_FLL(id) (id == HIFI_DAI ? WM8994_SYSCLK_FLL1 : WM8994_SYSCLK_FLL2)
+#define WM8994_FLL_SRC_MCLK(id) (id == HIFI_DAI ? WM8994_FLL_SRC_MCLK1 : WM8994_FLL_SRC_MCLK2)
+
+struct imx_wm8958_data {
+	struct snd_soc_dai_link dai_link[DAI_LINK_NUM];
+	int num_links;
+	struct snd_soc_card card;
+	struct clk *mclk[WM8958_MCLK_MAX];
+	u32 mclk_freq[WM8958_MCLK_MAX];
+	bool is_cpu_dai1_master;
+	bool is_stream_in_use[DAI_LINK_NUM][2];
+};
+
+static const struct snd_soc_dapm_widget imx_wm8958_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static int imx_wm8958_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_card *card = rtd->card;
+	struct device *dev = card->dev;
+	struct imx_wm8958_data *data = snd_soc_card_get_drvdata(card);
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	bool hifi_dai_sysclk_dir = SND_SOC_CLOCK_OUT;
+	u32 mclk_id, id = codec_dai->id - 1;
+	u32 pll_out;
+	int ret;
+
+	data->is_stream_in_use[id][tx] = true;
+
+	if (data->mclk_freq[id])
+		mclk_id = WM8994_FLL_SRC_MCLK(id);
+	else if (id == HIFI_DAI)
+		mclk_id = WM8994_FLL_SRC_MCLK2;
+	else
+		mclk_id = WM8994_FLL_SRC_MCLK1;
+
+	if (id == HIFI_DAI) {
+		if (data->is_cpu_dai1_master)
+			hifi_dai_sysclk_dir = SND_SOC_CLOCK_IN;
+
+		ret = snd_soc_dai_set_sysclk(cpu_dai,
+				0, 0, !hifi_dai_sysclk_dir);
+
+		if (ret) {
+			dev_err(dev, "failed to set cpu sysclk: %d\n", ret);
+			return ret;
+		}
+
+		if (data->is_cpu_dai1_master) {
+			ret = snd_soc_dai_set_sysclk(codec_dai, mclk_id,
+						data->mclk_freq[mclk_id - 1],
+						hifi_dai_sysclk_dir);
+			if (ret) {
+				dev_err(dev,
+					"failed to set codec sysclk: %d\n",
+					ret);
+				return ret;
+			}
+
+			return 0;
+		}
+	}
+
+	if (params_width(params) == 24)
+		pll_out = params_rate(params) * 384;
+	else
+		pll_out = params_rate(params) * 256;
+
+	ret = snd_soc_dai_set_pll(codec_dai,
+				  WM8994_FLL(id),
+				  mclk_id,
+				  data->mclk_freq[mclk_id - 1],
+				  pll_out);
+	if (ret) {
+		dev_err(dev, "failed to set codec pll: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai,
+				     WM8994_SYSCLK_FLL(id),
+				     pll_out,
+				     SND_SOC_CLOCK_OUT);
+	if (ret) {
+		dev_err(dev, "failed to set codec sysclk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_wm8958_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_card *card = rtd->card;
+	struct imx_wm8958_data *data = snd_soc_card_get_drvdata(card);
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	int id = codec_dai->id - 1;
+
+	data->is_stream_in_use[id][tx] = false;
+
+	if (id == HIFI_DAI && data->is_cpu_dai1_master)
+		return 0;
+
+	if (!data->is_stream_in_use[id][!tx]) {
+		/*
+		 * We should connect AIFxCLK source to FLL after enable FLL,
+		 * and disconnect AIF1CLK source to FLL before disable FLL,
+		 * otherwise FLL worked abnormal.
+		 */
+		snd_soc_dai_set_sysclk(codec_dai, WM8994_FLL_SRC_MCLK(id),
+				data->mclk_freq[id], SND_SOC_CLOCK_OUT);
+
+		/* Disable FLL1 after all stream finished. */
+		snd_soc_dai_set_pll(codec_dai, WM8994_FLL(id), 0, 0, 0);
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops imx_hifi_ops = {
+	.hw_params = imx_wm8958_hw_params,
+	.hw_free   = imx_wm8958_hw_free,
+};
+
+static struct snd_soc_ops imx_voice_ops = {
+	.hw_params = imx_wm8958_hw_params,
+	.hw_free   = imx_wm8958_hw_free,
+};
+
+static struct snd_soc_dai_link imx_wm8958_dai_link[] = {
+	[HIFI_DAI] =	{
+			.name = "HiFi",
+			.stream_name = "HiFi",
+			.codec_name = "wm8994-codec",
+			.codec_dai_name = "wm8994-aif1",
+			.ops = &imx_hifi_ops,
+			.dai_fmt = SND_SOC_DAIFMT_I2S |
+				   SND_SOC_DAIFMT_NB_NF,
+	},
+	[VOICE_DAI] =   {
+			.name = "Voice",
+			.stream_name = "Voice",
+			.codec_name = "wm8994-codec",
+			.codec_dai_name = "wm8994-aif2",
+			.ops = &imx_voice_ops,
+			.dai_fmt = SND_SOC_DAIFMT_I2S |
+				   SND_SOC_DAIFMT_NB_NF |
+				   SND_SOC_DAIFMT_CBM_CFM,
+	},
+	[BT_DAI] =	{
+			.name = "Bluetooth",
+			.stream_name = "Bluetooth",
+			.codec_name = "wm8994-codec",
+			.codec_dai_name = "wm8994-aif3",
+	},
+};
+
+static int imx_wm8958_probe(struct platform_device *pdev)
+{
+	struct device_node *cpu_np[DAI_LINK_NUM], *codec_np;
+	struct device_node *np = pdev->dev.of_node;
+	struct platform_device *cpu_pdev[DAI_LINK_NUM];
+	struct i2c_client *codec_dev;
+	struct imx_wm8958_data *data;
+	char tmp[8];
+	int ret, i;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	for (i = 0; i < DAI_LINK_NUM; i++) {
+		sprintf(tmp, "cpu-dai%d", i + 1);
+		cpu_np[i] = of_parse_phandle(np, tmp, 0);
+		if (cpu_np[i]) {
+			cpu_pdev[i] = of_find_device_by_node(cpu_np[i]);
+			if (!cpu_pdev[i]) {
+				dev_err(&pdev->dev,
+					"failed to get cpu dai%d platform device\n", i);
+				ret = -EINVAL;
+				goto fail;
+			}
+
+			data->dai_link[data->num_links] = imx_wm8958_dai_link[i];
+			data->dai_link[data->num_links].cpu_dai_name = dev_name(&cpu_pdev[i]->dev);
+			data->dai_link[data->num_links++].platform_of_node = cpu_np[i];
+		}
+	}
+
+	if (!data->num_links) {
+		dev_err(&pdev->dev, "cpu dai phandle missing or invalid\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	codec_np = of_parse_phandle(np, "audio-codec", 0);
+	if (!codec_np) {
+		dev_err(&pdev->dev, "phandle missing or invalid\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	codec_dev = of_find_i2c_device_by_node(codec_np);
+	if (!codec_dev || !codec_dev->dev.driver) {
+		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	/* Hifi dai link support codec master and slave mode */
+	if (of_property_read_bool(pdev->dev.of_node, "fsl,cpu-dai1-master")) {
+		data->is_cpu_dai1_master = true;
+		data->dai_link[HIFI_DAI].dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+	} else {
+		data->is_cpu_dai1_master = false;
+		data->dai_link[HIFI_DAI].dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+	}
+
+	for (i = 0; i < WM8958_MCLK_MAX; i++) {
+		sprintf(tmp, "MCLK%d", i + 1);
+		data->mclk[i] = devm_clk_get(&codec_dev->dev, tmp);
+		if (!IS_ERR(data->mclk[i]))
+			data->mclk_freq[i] = clk_get_rate(data->mclk[i]);
+	}
+
+	if (!data->mclk_freq[0] && !data->mclk_freq[1]) {
+		dev_err(&pdev->dev, "failed to get mclk clock\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	data->card.dev = &pdev->dev;
+	ret = snd_soc_of_parse_card_name(&data->card, "model");
+	if (ret)
+		goto fail;
+
+	data->card.num_links = data->num_links;
+	data->card.dai_link = data->dai_link;
+	data->card.dapm_widgets = imx_wm8958_dapm_widgets;
+	data->card.num_dapm_widgets = ARRAY_SIZE(imx_wm8958_dapm_widgets);
+	data->card.owner = THIS_MODULE;
+
+	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
+	if (ret)
+		goto fail;
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
+fail:
+	of_node_put(cpu_np[HIFI_DAI]);
+	of_node_put(cpu_np[VOICE_DAI]);
+	of_node_put(cpu_np[BT_DAI]);
+	of_node_put(codec_np);
+
+	return ret;
+}
+
+static const struct of_device_id imx_wm8958_dt_ids[] = {
+	{ .compatible = "fsl,imx-audio-wm8958", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_wm8958_dt_ids);
+
+static struct platform_driver imx_wm8958_driver = {
+	.driver = {
+		.name = "imx-wm8958",
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = imx_wm8958_dt_ids,
+	},
+	.probe = imx_wm8958_probe,
+};
+module_platform_driver(imx_wm8958_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Freescale i.MX WM8958 ASoC machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx-wm8958");
-- 
1.9.1
