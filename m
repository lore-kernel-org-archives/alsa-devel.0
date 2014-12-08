From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch v2 05/11] ASoC: ipq806x: Add LPASS CPU DAI driver
Date: Mon,  8 Dec 2014 14:01:07 -0800
Message-ID: <1418076073-12623-6-git-send-email-kwestfie@codeaurora.org>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add the CPU DAI driver for the QCOM LPASS SOC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu-mi2s.c | 374 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/lpass-cpu-mi2s.h |  48 ++++++
 2 files changed, 422 insertions(+)
 create mode 100644 sound/soc/qcom/lpass-cpu-mi2s.c
 create mode 100644 sound/soc/qcom/lpass-cpu-mi2s.h

diff --git a/sound/soc/qcom/lpass-cpu-mi2s.c b/sound/soc/qcom/lpass-cpu-mi2s.c
new file mode 100644
index 0000000000000000000000000000000000000000..b506064b4e7c3807170e1bff1daaef016221e5f4
--- /dev/null
+++ b/sound/soc/qcom/lpass-cpu-mi2s.c
@@ -0,0 +1,374 @@
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
+#include "lpass-lpaif.h"
+#include "lpass-cpu-mi2s.h"
+
+#define DRV_NAME			"lpass-cpu-mi2s"
+
+#define LPASS_OSR_TO_BIT_DIVIDER	4
+
+static void lpass_lpaif_mi2s_playback(struct lpass_cpu_mi2s_data *pdata,
+		int enable)
+{
+	u32 cfg;
+
+	cfg = readl(pdata->base + LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S));
+
+	if (enable)
+		cfg |= LPAIF_MI2SCTL_SPKEN;
+	else
+		cfg &= ~LPAIF_MI2SCTL_SPKEN;
+
+	cfg &= ~LPAIF_MI2SCTL_WS;
+
+	writel(cfg, pdata->base + LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S));
+}
+
+static int lpass_lpaif_mi2s_bitwidth(struct lpass_cpu_mi2s_data *pdata,
+		u32 bitwidth)
+{
+	u32 cfg;
+
+	cfg = readl(pdata->base + LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S));
+
+	cfg &= ~LPAIF_MI2SCTL_BITRATE_MASK;
+
+	switch (bitwidth) {
+	case SNDRV_PCM_FORMAT_S16:
+		cfg |= LPAIF_MI2SCTL_BITRATE_16;
+		break;
+	case SNDRV_PCM_FORMAT_S24:
+		cfg |= LPAIF_MI2SCTL_BITRATE_24;
+		break;
+	case SNDRV_PCM_FORMAT_S32:
+		cfg |= LPAIF_MI2SCTL_BITRATE_32;
+		break;
+	default:
+		pr_err("%s: invalid bitwidth given: %u\n", __func__, bitwidth);
+		return -EINVAL;
+	}
+
+	writel(cfg, pdata->base + LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S));
+
+	return 0;
+}
+
+static int lpass_lpaif_mi2s_channels(struct lpass_cpu_mi2s_data *pdata,
+		u32 channels, u32 bitwidth)
+{
+	u32 cfg;
+
+	cfg = readl(pdata->base + LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S));
+
+	cfg &= ~LPAIF_MI2SCTL_SPKMODE_MASK;
+	cfg &= ~LPAIF_MI2SCTL_SPKMONO_MASK;
+
+	switch (channels) {
+	case 1:
+		cfg |= LPAIF_MI2SCTL_SPKMODE_SD0;
+		cfg |= LPAIF_MI2SCTL_SPKMONO_MONO;
+		break;
+	case 2:
+		cfg |= LPAIF_MI2SCTL_SPKMODE_SD0;
+		cfg |= LPAIF_MI2SCTL_SPKMONO_STEREO;
+		break;
+	case 4:
+		cfg |= LPAIF_MI2SCTL_SPKMODE_QUAD01;
+		cfg |= LPAIF_MI2SCTL_SPKMONO_STEREO;
+		break;
+	case 6:
+		cfg |= LPAIF_MI2SCTL_SPKMODE_6CH;
+		cfg |= LPAIF_MI2SCTL_SPKMONO_STEREO;
+		break;
+	case 8:
+		cfg |= LPAIF_MI2SCTL_SPKMODE_8CH;
+		cfg |= LPAIF_MI2SCTL_SPKMONO_STEREO;
+		break;
+	default:
+		pr_err("%s: invalid channels given: %u\n", __func__, channels);
+		return -EINVAL;
+	}
+
+	writel(cfg, pdata->base + LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S));
+
+	return 0;
+}
+
+
+static int lpass_cpu_mi2s_daiops_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	u32 ret;
+	u32 bit_act;
+	u32 bitwidth = params_format(params);
+	u32 channels = params_channels(params);
+	u32 rate = params_rate(params);
+	struct lpass_cpu_mi2s_data *prtd = snd_soc_dai_get_drvdata(dai);
+
+	bit_act = snd_pcm_format_width(bitwidth);
+	if (bit_act < 0) {
+		dev_err(dai->dev, "%s: Invalid bit width given\n", __func__);
+		return bit_act;
+	}
+
+	ret = lpass_lpaif_mi2s_channels(prtd, channels, bit_act);
+	if (ret) {
+		dev_err(dai->dev, "%s: Channel setting unsuccessful\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	ret = lpass_lpaif_mi2s_bitwidth(prtd, bitwidth);
+	if (ret) {
+		dev_err(dai->dev, "%s: Could not set bit width in HW\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	ret = clk_set_rate(prtd->mi2s_osr_clk,
+		(rate * bit_act * channels * LPASS_OSR_TO_BIT_DIVIDER));
+	if (ret) {
+		dev_err(dai->dev, "%s: error in setting mi2s osr clk: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(prtd->mi2s_osr_clk);
+	if (ret) {
+		dev_err(dai->dev, "%s: error in enabling mi2s osr clk: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	ret = clk_set_rate(prtd->mi2s_bit_clk, rate * bit_act * channels);
+	if (ret) {
+		dev_err(dai->dev, "%s: error in setting mi2s bit clk: %d\n",
+				__func__, ret);
+		goto err;
+	}
+
+	ret = clk_prepare_enable(prtd->mi2s_bit_clk);
+	if (ret) {
+		dev_err(dai->dev, "%s: error in enabling mi2s bit clk: %d\n",
+				__func__, ret);
+		goto err;
+	}
+
+	prtd->mi2s_clocks_enabled = 1;
+
+	return 0;
+
+err:
+	clk_disable_unprepare(prtd->mi2s_osr_clk);
+
+	return ret;
+}
+
+static int lpass_cpu_mi2s_daiops_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct lpass_cpu_mi2s_data *prtd = snd_soc_dai_get_drvdata(dai);
+
+	if (prtd->mi2s_clocks_enabled) {
+		clk_disable_unprepare(prtd->mi2s_osr_clk);
+		clk_disable_unprepare(prtd->mi2s_bit_clk);
+	}
+	prtd->mi2s_clocks_enabled = 0;
+
+	return 0;
+}
+
+static int lpass_cpu_mi2s_daiops_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct lpass_cpu_mi2s_data *prtd = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		lpass_lpaif_mi2s_playback(prtd, 1);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		lpass_lpaif_mi2s_playback(prtd, 0);
+		break;
+	default:
+		dev_err(dai->dev, "%s: Invalid trigger command given\n",
+				__func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+static struct snd_soc_dai_ops lpass_cpu_mi2s_ops = {
+	.hw_params	= lpass_cpu_mi2s_daiops_hw_params,
+	.hw_free	= lpass_cpu_mi2s_daiops_hw_free,
+	.trigger	= lpass_cpu_mi2s_daiops_trigger,
+};
+
+static int lpass_cpu_mi2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct lpass_cpu_mi2s_data *prtd = snd_soc_dai_get_drvdata(dai);
+
+	prtd->mi2s_osr_clk = devm_clk_get(dai->dev, "mi2s_osr_clk");
+	if (IS_ERR(prtd->mi2s_osr_clk)) {
+		dev_err(dai->dev, "%s: Error in getting mi2s_osr_clk\n",
+				__func__);
+		return PTR_ERR(prtd->mi2s_osr_clk);
+	}
+
+	prtd->mi2s_bit_clk = devm_clk_get(dai->dev, "mi2s_bit_clk");
+	if (IS_ERR(prtd->mi2s_bit_clk)) {
+		dev_err(dai->dev, "%s: Error in getting mi2s_bit_clk\n",
+				__func__);
+		return PTR_ERR(prtd->mi2s_bit_clk);
+	}
+
+	prtd->mi2s_clocks_enabled = 0;
+
+	/* disable MI2S port */
+	lpass_lpaif_mi2s_playback(prtd, 0);
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver lpass_cpu_mi2s_dai_driver = {
+	.name = "lpass-cpu-mi2s-dai",
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
+	.ops    = &lpass_cpu_mi2s_ops,
+};
+
+static const struct snd_soc_component_driver lpass_cpu_mi2s_comp_driver = {
+	.name = DRV_NAME,
+};
+
+static int lpass_cpu_mi2s_platform_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *lpass_res;
+	struct lpass_cpu_mi2s_data *prtd;
+
+	prtd = devm_kzalloc(&pdev->dev, sizeof(struct lpass_cpu_mi2s_data),
+			GFP_KERNEL);
+	if (!prtd)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, prtd);
+
+	prtd->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix_clk");
+	if (IS_ERR(prtd->ahbix_clk)) {
+		dev_err(&pdev->dev, "%s: Error in getting ahbix_clk\n",
+				__func__);
+		return PTR_ERR(prtd->ahbix_clk);
+	}
+
+	clk_set_rate(prtd->ahbix_clk, 131072);
+	ret = clk_prepare_enable(prtd->ahbix_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Error in enabling ahbix_clk\n",
+				__func__);
+		return ret;
+	}
+
+	lpass_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"lpass-lpaif-mem");
+	if (!lpass_res) {
+		dev_err(&pdev->dev, "%s: error getting resource\n", __func__);
+		ret = -ENODEV;
+		goto err_clk;
+	}
+
+	prtd->base = devm_ioremap_resource(&pdev->dev, lpass_res);
+	if (IS_ERR(prtd->base)) {
+		dev_err(&pdev->dev, "%s: error remapping resource\n",
+				__func__);
+		ret = PTR_ERR(prtd->base);
+		goto err_clk;
+	}
+
+	prtd->irqnum = platform_get_irq_byname(pdev, "lpass-lpaif-irq");
+	if (prtd->irqnum < 0) {
+		dev_err(&pdev->dev, "%s: failed get irq res\n", __func__);
+		return -ENODEV;
+	}
+
+	prtd->irq_acquired = 0;
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
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(prtd->ahbix_clk);
+	return ret;
+}
+
+static int lpass_cpu_mi2s_platform_remove(struct platform_device *pdev)
+{
+	struct lpass_cpu_mi2s_data *prtd = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(prtd->ahbix_clk);
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
diff --git a/sound/soc/qcom/lpass-cpu-mi2s.h b/sound/soc/qcom/lpass-cpu-mi2s.h
new file mode 100644
index 0000000000000000000000000000000000000000..4227a3661d2a90214e3e8bd43d21d3d3345da531
--- /dev/null
+++ b/sound/soc/qcom/lpass-cpu-mi2s.h
@@ -0,0 +1,48 @@
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
+#ifndef _LPASS_CPU_MI2S_H
+#define _LPASS_CPU_MI2S_H
+
+enum pinctrl_pin_state {
+	STATE_DISABLED = 0,
+	STATE_ENABLED = 1
+};
+static const char *const pin_states[] = {"Disabled", "Enabled"};
+
+struct mi2s_pinctrl_info {
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *disabled;
+	struct pinctrl_state *enabled;
+	enum pinctrl_pin_state curr_state;
+};
+
+/*
+ * Device data for the multi-channel I2S port in the low-power audio
+ * interface (LPAIF) within the low-power audio subsystem (LPASS).
+ * Both the CPU DAI driver and platform driver will access this.
+ */
+struct lpass_cpu_mi2s_data {
+	void __iomem *base;
+	struct clk *ahbix_clk;
+	struct clk *mi2s_bit_clk;
+	struct clk *mi2s_osr_clk;
+	int mi2s_clocks_enabled;
+	struct mi2s_pinctrl_info mi2s_pinfo;
+	int irqnum;
+	int irq_acquired;
+	uint8_t prepare_start;
+	uint32_t period_index;
+};
+
+#endif /* _LPASS_CPU_MI2S_H */
-- 
1.8.2.1
