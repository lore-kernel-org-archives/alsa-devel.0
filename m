From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 06/10] ASoC: ipq806x: Add LPASS CPU DAI driver
Date: Wed, 24 Dec 2014 08:42:06 -0800
Message-ID: <1419439330-2303-7-git-send-email-kwestfie@codeaurora.org>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add the CPU DAI driver for the QCOM LPASS SOC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu-mi2s.c | 378 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 378 insertions(+)
 create mode 100644 sound/soc/qcom/lpass-cpu-mi2s.c

diff --git a/sound/soc/qcom/lpass-cpu-mi2s.c b/sound/soc/qcom/lpass-cpu-mi2s.c
new file mode 100644
index 0000000000000000000000000000000000000000..dc1bd53a78c3d6c097909dd240b6580efae19577
--- /dev/null
+++ b/sound/soc/qcom/lpass-cpu-mi2s.c
@@ -0,0 +1,378 @@
+/*
+ * Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include "lpass-lpaif-reg.h"
+#include "lpass-mi2s.h"
+
+#define DRV_NAME			"lpass-cpu-mi2s"
+
+#define LPASS_OSR_TO_BIT_DIVIDER	4
+
+static inline int lpass_lpaif_mi2s_config(struct snd_soc_dai *dai,
+		unsigned int channels, unsigned int bitwidth)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	u32 mi2s_control_offset = LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S);
+	u32 value;
+
+	value = 0;
+
+	value &= ~LPAIF_MI2SCTL_WS;
+
+	switch (bitwidth) {
+	case 16:
+		value |= LPAIF_MI2SCTL_BITWIDTH_16;
+		break;
+	case 24:
+		value |= LPAIF_MI2SCTL_BITWIDTH_24;
+		break;
+	case 32:
+		value |= LPAIF_MI2SCTL_BITWIDTH_32;
+		break;
+	default:
+		dev_err(dai->dev, "%s: invalid bitwidth given: %u\n", __func__,
+				bitwidth);
+		return -EINVAL;
+	}
+
+	switch (channels) {
+	case 1:
+		value |= LPAIF_MI2SCTL_SPKMODE_SD0;
+		value |= LPAIF_MI2SCTL_SPKMONO_MONO;
+		break;
+	case 2:
+		value |= LPAIF_MI2SCTL_SPKMODE_SD0;
+		value |= LPAIF_MI2SCTL_SPKMONO_STEREO;
+		break;
+	case 4:
+		value |= LPAIF_MI2SCTL_SPKMODE_QUAD01;
+		value |= LPAIF_MI2SCTL_SPKMONO_STEREO;
+		break;
+	case 6:
+		value |= LPAIF_MI2SCTL_SPKMODE_6CH;
+		value |= LPAIF_MI2SCTL_SPKMONO_STEREO;
+		break;
+	case 8:
+		value |= LPAIF_MI2SCTL_SPKMODE_8CH;
+		value |= LPAIF_MI2SCTL_SPKMONO_STEREO;
+		break;
+	default:
+		dev_err(dai->dev, "%s: invalid channels given: %u\n", __func__,
+				channels);
+		return -EINVAL;
+	}
+
+	writel(value, drvdata->base + mi2s_control_offset);
+
+	return 0;
+}
+
+static inline void lpass_lpaif_mi2s_playback_start(struct snd_soc_dai *dai)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	u32 mi2s_control_offset = LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S);
+	u32 value;
+
+	value = readl(drvdata->base + mi2s_control_offset);
+	value |= LPAIF_MI2SCTL_SPKEN;
+	writel(value, drvdata->base + mi2s_control_offset);
+}
+
+static inline void lpass_lpaif_mi2s_playback_stop(struct snd_soc_dai *dai)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	u32 mi2s_control_offset = LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S);
+	u32 value;
+
+	value = readl(drvdata->base + mi2s_control_offset);
+	value &= ~LPAIF_MI2SCTL_SPKEN;
+	writel(value, drvdata->base + mi2s_control_offset);
+}
+
+static inline void lpass_lpaif_mi2s_playback_stop_clear(struct snd_soc_dai *dai)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	u32 mi2s_control_offset = LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S);
+
+	writel(0, drvdata->base + mi2s_control_offset);
+}
+
+static int lpass_cpu_mi2s_daiops_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = clk_prepare_enable(drvdata->mi2s_osr_clk);
+	if (ret) {
+		dev_err(dai->dev, "%s: error in enabling mi2s osr clk: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(drvdata->mi2s_bit_clk);
+	if (ret) {
+		dev_err(dai->dev, "%s: error in enabling mi2s bit clk: %d\n",
+				__func__, ret);
+		clk_disable_unprepare(drvdata->mi2s_osr_clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void lpass_cpu_mi2s_daiops_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable_unprepare(drvdata->mi2s_bit_clk);
+	clk_disable_unprepare(drvdata->mi2s_osr_clk);
+}
+
+static int lpass_cpu_mi2s_daiops_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	snd_pcm_format_t format = params_format(params);
+	unsigned int channels = params_channels(params);
+	unsigned int rate = params_rate(params);
+	int bitwidth;
+	int ret;
+
+	bitwidth = snd_pcm_format_width(format);
+	if (bitwidth < 0) {
+		dev_err(dai->dev, "%s: Invalid bit width given\n", __func__);
+		return bitwidth;
+	}
+
+	ret = lpass_lpaif_mi2s_config(dai, channels, bitwidth);
+	if (ret) {
+		dev_err(dai->dev, "%s: Channel setting unsuccessful\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	ret = clk_set_rate(drvdata->mi2s_osr_clk,
+		(rate * bitwidth * channels * LPASS_OSR_TO_BIT_DIVIDER));
+	if (ret) {
+		dev_err(dai->dev, "%s: error in setting mi2s osr clk: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	ret = clk_set_rate(drvdata->mi2s_bit_clk, rate * bitwidth * channels);
+	if (ret) {
+		dev_err(dai->dev, "%s: error in setting mi2s bit clk: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lpass_cpu_mi2s_daiops_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	lpass_lpaif_mi2s_playback_stop_clear(dai);
+
+	return 0;
+}
+
+static int lpass_cpu_mi2s_daiops_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	lpass_lpaif_mi2s_playback_start(dai);
+
+	return 0;
+}
+
+static int lpass_cpu_mi2s_daiops_set_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = clk_set_rate(drvdata->mi2s_osr_clk, freq);
+	if (ret) {
+		dev_err(dai->dev, "%s: error in setting mi2s osr clk: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops lpass_cpu_mi2s_dai_ops = {
+	.startup	= lpass_cpu_mi2s_daiops_startup,
+	.shutdown	= lpass_cpu_mi2s_daiops_shutdown,
+	.hw_params	= lpass_cpu_mi2s_daiops_hw_params,
+	.hw_free	= lpass_cpu_mi2s_daiops_hw_free,
+	.prepare	= lpass_cpu_mi2s_daiops_prepare,
+	.set_sysclk	= lpass_cpu_mi2s_daiops_set_sysclk,
+};
+
+static int lpass_cpu_mi2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
+
+	drvdata->mi2s_osr_clk = devm_clk_get(dai->dev, "mi2s_osr_clk");
+	if (IS_ERR(drvdata->mi2s_osr_clk)) {
+		dev_err(dai->dev, "%s: Error in getting mi2s_osr_clk\n",
+				__func__);
+		return PTR_ERR(drvdata->mi2s_osr_clk);
+	}
+
+	drvdata->mi2s_bit_clk = devm_clk_get(dai->dev, "mi2s_bit_clk");
+	if (IS_ERR(drvdata->mi2s_bit_clk)) {
+		dev_err(dai->dev, "%s: Error in getting mi2s_bit_clk\n",
+				__func__);
+		return PTR_ERR(drvdata->mi2s_bit_clk);
+	}
+
+	/* ensure MI2S port is disabled */
+	lpass_lpaif_mi2s_playback_stop_clear(dai);
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver lpass_cpu_mi2s_dai_driver = {
+	.playback = {
+		.stream_name	= "lpass-cpu-mi2s-playback",
+		.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24 |
+					SNDRV_PCM_FMTBIT_S32,
+		.rates		= SNDRV_PCM_RATE_8000 |
+					SNDRV_PCM_RATE_16000 |
+					SNDRV_PCM_RATE_32000 |
+					SNDRV_PCM_RATE_48000 |
+					SNDRV_PCM_RATE_96000,
+		.rate_min	= 8000,
+		.rate_max	= 96000,
+		.channels_min	= 1,
+		.channels_max	= 8,
+	},
+	.probe	= &lpass_cpu_mi2s_dai_probe,
+	.ops    = &lpass_cpu_mi2s_dai_ops,
+};
+
+static const struct snd_soc_component_driver lpass_cpu_mi2s_comp_driver = {
+	.name = DRV_NAME,
+};
+
+static int lpass_cpu_mi2s_platform_probe(struct platform_device *pdev)
+{
+	struct device_node *of_node = pdev->dev.of_node;
+	struct lpass_mi2s_data *drvdata;
+	struct resource *lpass_res;
+	u32 freq;
+	int ret;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct lpass_mi2s_data),
+			GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, drvdata);
+
+	lpass_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"lpass-lpaif-mem");
+	if (!lpass_res) {
+		dev_err(&pdev->dev, "%s: error getting resource\n", __func__);
+		return -ENODEV;
+	}
+
+	drvdata->base = devm_ioremap_resource(&pdev->dev, lpass_res);
+	if (IS_ERR(drvdata->base)) {
+		dev_err(&pdev->dev, "%s: error remapping resource\n",
+				__func__);
+		return PTR_ERR(drvdata->base);
+	}
+
+	drvdata->irqnum = platform_get_irq_byname(pdev, "lpass-lpaif-irq");
+	if (drvdata->irqnum < 0) {
+		dev_err(&pdev->dev, "%s: failed get irq res\n", __func__);
+		return -ENODEV;
+	}
+
+	drvdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix_clk");
+	if (IS_ERR(drvdata->ahbix_clk)) {
+		dev_err(&pdev->dev, "%s: Error getting ahbix_clk\n", __func__);
+		return PTR_ERR(drvdata->ahbix_clk);
+	}
+
+	if (of_property_read_bool(of_node, "ahbix-frequency"))
+		of_property_read_u32(of_node, "ahbix-frequency", &freq);
+	clk_set_rate(drvdata->ahbix_clk, freq);
+
+	ret = clk_prepare_enable(drvdata->ahbix_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Error enabling ahbix_clk\n", __func__);
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+			&lpass_cpu_mi2s_comp_driver,
+			&lpass_cpu_mi2s_dai_driver, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: error registering soc dai\n",
+				__func__);
+		goto err_clk;
+	}
+
+	ret = lpass_pcm_mi2s_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: error registering pcm device\n",
+				__func__);
+		goto err_clk;
+	}
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(drvdata->ahbix_clk);
+	return ret;
+}
+
+static int lpass_cpu_mi2s_platform_remove(struct platform_device *pdev)
+{
+	struct lpass_mi2s_data *drvdata = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(drvdata->ahbix_clk);
+
+	return 0;
+}
+
+static const struct of_device_id lpass_cpu_mi2s_dt_match[] = {
+	{.compatible = "qcom,lpass-cpu-mi2s"},
+	{}
+};
+
+static struct platform_driver lpass_cpu_mi2s_platform_driver = {
+	.driver	= {
+		.name	= DRV_NAME,
+		.of_match_table = lpass_cpu_mi2s_dt_match,
+	},
+	.probe	= lpass_cpu_mi2s_platform_probe,
+	.remove	= lpass_cpu_mi2s_platform_remove,
+};
+module_platform_driver(lpass_cpu_mi2s_platform_driver);
+
+MODULE_DESCRIPTION("QCOM LPASS MI2S CPU DRIVER");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, lpass_cpu_mi2s_dt_match);
-- 
1.8.2.1
