From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 03/14] ASoC: qcom: move ipq806x specific bits out of lpass driver.
Date: Thu, 30 Apr 2015 18:16:53 +0100
Message-ID: <1430414213-10997-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch tries to make the lpass driver more generic by moving the
ipq806x specific bits out of the cpu and platform driver, also allows the
SOC specific drivers to add the correct register offsets.

This patch also renames the register definition header file into more
generic header file.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig               |   9 +-
 sound/soc/qcom/Makefile              |   2 +
 sound/soc/qcom/lpass-cpu.c           | 157 ++++++++++++++++----------------
 sound/soc/qcom/lpass-ipq806x.c       |  82 +++++++++++++++++
 sound/soc/qcom/lpass-lpaif-ipq806x.h | 172 -----------------------------------
 sound/soc/qcom/lpass-lpaif-reg.h     | 167 ++++++++++++++++++++++++++++++++++
 sound/soc/qcom/lpass-platform.c      |  49 ++++++----
 sound/soc/qcom/lpass.h               |  28 ++++++
 8 files changed, 391 insertions(+), 275 deletions(-)
 create mode 100644 sound/soc/qcom/lpass-ipq806x.c
 delete mode 100644 sound/soc/qcom/lpass-lpaif-ipq806x.h
 create mode 100644 sound/soc/qcom/lpass-lpaif-reg.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 5f58e4f..ba87e9b 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -14,11 +14,16 @@ config SND_SOC_LPASS_PLATFORM
 	depends on SND_SOC_QCOM
 	select REGMAP_MMIO
 
+config SND_SOC_LPASS_IPQ806X
+	tristate
+	depends on SND_SOC_QCOM
+	select SND_SOC_LPASS_CPU
+	select SND_SOC_LPASS_PLATFORM
+
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
 	depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
-	select SND_SOC_LPASS_CPU
-	select SND_SOC_LPASS_PLATFORM
+	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help
           Say Y or M if you want add support for SoC audio on the
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index c5ce96c..f8aab91 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -1,9 +1,11 @@
 # Platform
 snd-soc-lpass-cpu-objs := lpass-cpu.o
 snd-soc-lpass-platform-objs := lpass-platform.o
+snd-soc-lpass-ipq806x-objs := lpass-ipq806x.o
 
 obj-$(CONFIG_SND_SOC_LPASS_CPU) += snd-soc-lpass-cpu.o
 obj-$(CONFIG_SND_SOC_LPASS_PLATFORM) += snd-soc-lpass-platform.o
+obj-$(CONFIG_SND_SOC_LPASS_IPQ806X) += snd-soc-lpass-ipq806x.o
 
 # Machine
 snd-soc-storm-objs := storm.o
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 4084295..74b2245 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -17,14 +17,14 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
-
-#include "lpass-lpaif-ipq806x.h"
+#include "lpass-lpaif-reg.h"
 #include "lpass.h"
 
 static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
@@ -138,7 +138,9 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_I2SCTL_REG(LPAIF_I2S_PORT_MI2S), regval);
+			   LPAIF_I2SCTL_REG(drvdata->variant,
+			   LPAIF_I2S_PORT_MI2S),
+			   regval);
 	if (ret) {
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 				__func__, ret);
@@ -162,7 +164,8 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
 	int ret;
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_I2SCTL_REG(LPAIF_I2S_PORT_MI2S), 0);
+			   LPAIF_I2SCTL_REG(drvdata->variant,
+			   LPAIF_I2S_PORT_MI2S), 0);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 				__func__, ret);
@@ -177,7 +180,7 @@ static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
 	int ret;
 
 	ret = regmap_update_bits(drvdata->lpaif_map,
-			LPAIF_I2SCTL_REG(LPAIF_I2S_PORT_MI2S),
+			LPAIF_I2SCTL_REG(drvdata->variant, LPAIF_I2S_PORT_MI2S),
 			LPAIF_I2SCTL_SPKEN_MASK, LPAIF_I2SCTL_SPKEN_ENABLE);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
@@ -197,7 +200,8 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_I2SCTL_REG(LPAIF_I2S_PORT_MI2S),
+				LPAIF_I2SCTL_REG(drvdata->variant,
+				LPAIF_I2S_PORT_MI2S),
 				LPAIF_I2SCTL_SPKEN_MASK,
 				LPAIF_I2SCTL_SPKEN_ENABLE);
 		if (ret)
@@ -208,7 +212,8 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_I2SCTL_REG(LPAIF_I2S_PORT_MI2S),
+				LPAIF_I2SCTL_REG(drvdata->variant,
+				LPAIF_I2S_PORT_MI2S),
 				LPAIF_I2SCTL_SPKEN_MASK,
 				LPAIF_I2SCTL_SPKEN_DISABLE);
 		if (ret)
@@ -220,7 +225,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_dai_ops lpass_cpu_dai_ops = {
+struct snd_soc_dai_ops lpass_cpu_dai_ops = {
 	.set_sysclk	= lpass_cpu_daiops_set_sysclk,
 	.startup	= lpass_cpu_daiops_startup,
 	.shutdown	= lpass_cpu_daiops_shutdown,
@@ -229,41 +234,24 @@ static struct snd_soc_dai_ops lpass_cpu_dai_ops = {
 	.prepare	= lpass_cpu_daiops_prepare,
 	.trigger	= lpass_cpu_daiops_trigger,
 };
+EXPORT_SYMBOL_GPL(lpass_cpu_dai_ops);
 
-static int lpass_cpu_dai_probe(struct snd_soc_dai *dai)
+int lpass_cpu_dai_probe(struct snd_soc_dai *dai)
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
 	/* ensure audio hardware is disabled */
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_I2SCTL_REG(LPAIF_I2S_PORT_MI2S), 0);
+			   LPAIF_I2SCTL_REG(drvdata->variant,
+			   LPAIF_I2S_PORT_MI2S), 0);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 				__func__, ret);
 
 	return ret;
 }
-
-static struct snd_soc_dai_driver lpass_cpu_dai_driver = {
-	.playback = {
-		.stream_name	= "lpass-cpu-playback",
-		.formats	= SNDRV_PCM_FMTBIT_S16 |
-					SNDRV_PCM_FMTBIT_S24 |
-					SNDRV_PCM_FMTBIT_S32,
-		.rates		= SNDRV_PCM_RATE_8000 |
-					SNDRV_PCM_RATE_16000 |
-					SNDRV_PCM_RATE_32000 |
-					SNDRV_PCM_RATE_48000 |
-					SNDRV_PCM_RATE_96000,
-		.rate_min	= 8000,
-		.rate_max	= 96000,
-		.channels_min	= 1,
-		.channels_max	= 8,
-	},
-	.probe	= &lpass_cpu_dai_probe,
-	.ops    = &lpass_cpu_dai_ops,
-};
+EXPORT_SYMBOL_GPL(lpass_cpu_dai_probe);
 
 static const struct snd_soc_component_driver lpass_cpu_comp_driver = {
 	.name = "lpass-cpu",
@@ -271,27 +259,29 @@ static const struct snd_soc_component_driver lpass_cpu_comp_driver = {
 
 static bool lpass_cpu_regmap_writeable(struct device *dev, unsigned int reg)
 {
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
 	int i;
 
-	for (i = 0; i < LPAIF_I2S_PORT_NUM; ++i)
-		if (reg == LPAIF_I2SCTL_REG(i))
+	for (i = 0; i < v->i2s_ports; ++i)
+		if (reg == LPAIF_I2SCTL_REG(v, i))
 			return true;
 
-	for (i = 0; i < LPAIF_IRQ_PORT_NUM; ++i) {
-		if (reg == LPAIF_IRQEN_REG(i))
+	for (i = 0; i < v->irq_ports; ++i) {
+		if (reg == LPAIF_IRQEN_REG(v, i))
 			return true;
-		if (reg == LPAIF_IRQCLEAR_REG(i))
+		if (reg == LPAIF_IRQCLEAR_REG(v, i))
 			return true;
 	}
 
-	for (i = 0; i < LPAIF_RDMA_CHAN_NUM; ++i) {
-		if (reg == LPAIF_RDMACTL_REG(i))
+	for (i = 0; i < v->rdma_channels; ++i) {
+		if (reg == LPAIF_RDMACTL_REG(v, i))
 			return true;
-		if (reg == LPAIF_RDMABASE_REG(i))
+		if (reg == LPAIF_RDMABASE_REG(v, i))
 			return true;
-		if (reg == LPAIF_RDMABUFF_REG(i))
+		if (reg == LPAIF_RDMABUFF_REG(v, i))
 			return true;
-		if (reg == LPAIF_RDMAPER_REG(i))
+		if (reg == LPAIF_RDMAPER_REG(v, i))
 			return true;
 	}
 
@@ -300,29 +290,31 @@ static bool lpass_cpu_regmap_writeable(struct device *dev, unsigned int reg)
 
 static bool lpass_cpu_regmap_readable(struct device *dev, unsigned int reg)
 {
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
 	int i;
 
-	for (i = 0; i < LPAIF_I2S_PORT_NUM; ++i)
-		if (reg == LPAIF_I2SCTL_REG(i))
+	for (i = 0; i < v->i2s_ports; ++i)
+		if (reg == LPAIF_I2SCTL_REG(v, i))
 			return true;
 
-	for (i = 0; i < LPAIF_IRQ_PORT_NUM; ++i) {
-		if (reg == LPAIF_IRQEN_REG(i))
+	for (i = 0; i < v->irq_ports; ++i) {
+		if (reg == LPAIF_IRQEN_REG(v, i))
 			return true;
-		if (reg == LPAIF_IRQSTAT_REG(i))
+		if (reg == LPAIF_IRQSTAT_REG(v, i))
 			return true;
 	}
 
-	for (i = 0; i < LPAIF_RDMA_CHAN_NUM; ++i) {
-		if (reg == LPAIF_RDMACTL_REG(i))
+	for (i = 0; i < v->rdma_channels; ++i) {
+		if (reg == LPAIF_RDMACTL_REG(v, i))
 			return true;
-		if (reg == LPAIF_RDMABASE_REG(i))
+		if (reg == LPAIF_RDMABASE_REG(v, i))
 			return true;
-		if (reg == LPAIF_RDMABUFF_REG(i))
+		if (reg == LPAIF_RDMABUFF_REG(v, i))
 			return true;
-		if (reg == LPAIF_RDMACURR_REG(i))
+		if (reg == LPAIF_RDMACURR_REG(v, i))
 			return true;
-		if (reg == LPAIF_RDMAPER_REG(i))
+		if (reg == LPAIF_RDMAPER_REG(v, i))
 			return true;
 	}
 
@@ -331,35 +323,39 @@ static bool lpass_cpu_regmap_readable(struct device *dev, unsigned int reg)
 
 static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
 {
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
 	int i;
 
-	for (i = 0; i < LPAIF_IRQ_PORT_NUM; ++i)
-		if (reg == LPAIF_IRQSTAT_REG(i))
+	for (i = 0; i < v->irq_ports; ++i)
+		if (reg == LPAIF_IRQSTAT_REG(v, i))
 			return true;
 
-	for (i = 0; i < LPAIF_RDMA_CHAN_NUM; ++i)
-		if (reg == LPAIF_RDMACURR_REG(i))
+	for (i = 0; i < v->rdma_channels; ++i)
+		if (reg == LPAIF_RDMACURR_REG(v, i))
 			return true;
 
 	return false;
 }
 
-static const struct regmap_config lpass_cpu_regmap_config = {
+static struct regmap_config lpass_cpu_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = LPAIF_RDMAPER_REG(LPAIF_RDMA_CHAN_MAX),
 	.writeable_reg = lpass_cpu_regmap_writeable,
 	.readable_reg = lpass_cpu_regmap_readable,
 	.volatile_reg = lpass_cpu_regmap_volatile,
 	.cache_type = REGCACHE_FLAT,
 };
 
-static int lpass_cpu_platform_probe(struct platform_device *pdev)
+int lpass_cpu_platform_probe(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata;
 	struct device_node *dsp_of_node;
 	struct resource *res;
+	struct lpass_variant *variant;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
 	int ret;
 
 	dsp_of_node = of_parse_phandle(pdev->dev.of_node, "qcom,adsp", 0);
@@ -375,6 +371,13 @@ static int lpass_cpu_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, drvdata);
 
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!match || !match->data)
+		return -EINVAL;
+
+	drvdata->variant = (struct lpass_variant *)match->data;
+	variant = drvdata->variant;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
 
 	drvdata->lpaif = devm_ioremap_resource(&pdev->dev, res);
@@ -385,6 +388,9 @@ static int lpass_cpu_platform_probe(struct platform_device *pdev)
 		return PTR_ERR((void const __force *)drvdata->lpaif);
 	}
 
+	lpass_cpu_regmap_config.max_register = LPAIF_RDMAPER_REG(variant,
+						variant->rdma_channels);
+
 	drvdata->lpaif_map = devm_regmap_init_mmio(&pdev->dev, drvdata->lpaif,
 			&lpass_cpu_regmap_config);
 	if (IS_ERR(drvdata->lpaif_map)) {
@@ -393,6 +399,9 @@ static int lpass_cpu_platform_probe(struct platform_device *pdev)
 		return PTR_ERR(drvdata->lpaif_map);
 	}
 
+	if (variant->init)
+		variant->init(pdev);
+
 	drvdata->mi2s_osr_clk = devm_clk_get(&pdev->dev, "mi2s-osr-clk");
 	if (IS_ERR(drvdata->mi2s_osr_clk)) {
 		dev_err(&pdev->dev, "%s() error getting mi2s-osr-clk: %ld\n",
@@ -431,7 +440,9 @@ static int lpass_cpu_platform_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-			&lpass_cpu_comp_driver, &lpass_cpu_dai_driver, 1);
+					      &lpass_cpu_comp_driver,
+					      variant->dai_driver,
+					      variant->num_dai);
 	if (ret) {
 		dev_err(&pdev->dev, "%s() error registering cpu driver: %d\n",
 				__func__, ret);
@@ -451,33 +462,17 @@ err_clk:
 	clk_disable_unprepare(drvdata->ahbix_clk);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(lpass_cpu_platform_probe);
 
-static int lpass_cpu_platform_remove(struct platform_device *pdev)
+int lpass_cpu_platform_remove(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
 
+	if (drvdata->variant->exit)
+		drvdata->variant->exit(pdev);
+
 	clk_disable_unprepare(drvdata->ahbix_clk);
 
 	return 0;
 }
-
-#ifdef CONFIG_OF
-static const struct of_device_id lpass_cpu_device_id[] = {
-	{ .compatible = "qcom,lpass-cpu" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, lpass_cpu_device_id);
-#endif
-
-static struct platform_driver lpass_cpu_platform_driver = {
-	.driver	= {
-		.name		= "lpass-cpu",
-		.of_match_table	= of_match_ptr(lpass_cpu_device_id),
-	},
-	.probe	= lpass_cpu_platform_probe,
-	.remove	= lpass_cpu_platform_remove,
-};
-module_platform_driver(lpass_cpu_platform_driver);
-
-MODULE_DESCRIPTION("QTi LPASS CPU Driver");
-MODULE_LICENSE("GPL v2");
+EXPORT_SYMBOL_GPL(lpass_cpu_platform_remove);
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
new file mode 100644
index 0000000..8e9a427
--- /dev/null
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (c) 2010-2011,2013-2015 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * lpass-ipq806x.c -- ALSA SoC CPU DAI driver for QTi LPASS
+ * Splited out the IPQ8064 soc specific from lpass-cpu.c
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "lpass-lpaif-reg.h"
+#include "lpass.h"
+
+static struct snd_soc_dai_driver lpass_cpu_dai_driver = {
+	.playback = {
+		.stream_name	= "lpass-cpu-playback",
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
+	.probe	= &lpass_cpu_dai_probe,
+	.ops    = &lpass_cpu_dai_ops,
+};
+
+struct lpass_variant ipq806x_data = {
+	.i2sctrl_reg_base	= 0x0010,
+	.i2sctrl_reg_stride	= 0x04,
+	.i2s_ports		= 5,
+	.irq_reg_base		= 0x3000,
+	.irq_reg_stride		= 0x1000,
+	.irq_ports		= 3,
+	.rdma_reg_base		= 0x6000,
+	.rdma_reg_stride	= 0x1000,
+	.rdma_channels		= 4,
+	.dai_driver		= &lpass_cpu_dai_driver,
+	.num_dai		= 1,
+};
+
+static const struct of_device_id ipq806x_lpass_cpu_device_id[] = {
+	{ .compatible = "qcom,lpass-cpu", .data = &ipq806x_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ipq806x_lpass_cpu_device_id);
+
+static struct platform_driver lpass_cpu_platform_driver = {
+	.driver	= {
+		.name		= "lpass-cpu",
+		.of_match_table	= of_match_ptr(ipq806x_lpass_cpu_device_id),
+	},
+	.probe	= lpass_cpu_platform_probe,
+	.remove	= lpass_cpu_platform_remove,
+};
+module_platform_driver(lpass_cpu_platform_driver);
+
+MODULE_DESCRIPTION("QTi LPASS CPU Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/lpass-lpaif-ipq806x.h b/sound/soc/qcom/lpass-lpaif-ipq806x.h
deleted file mode 100644
index dc423b8..0000000
--- a/sound/soc/qcom/lpass-lpaif-ipq806x.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * Copyright (c) 2010-2011,2013-2015 The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * lpass-lpaif-ipq806x.h -- Definitions for the QTi LPAIF in the ipq806x LPASS
- */
-
-#ifndef __LPASS_LPAIF_H__
-#define __LPASS_LPAIF_H__
-
-#define LPAIF_BANK_OFFSET		0x1000
-
-/* LPAIF I2S */
-
-#define LPAIF_I2SCTL_REG_BASE		0x0010
-#define LPAIF_I2SCTL_REG_STRIDE		0x4
-#define LPAIF_I2SCTL_REG_ADDR(addr, port) \
-	(LPAIF_I2SCTL_REG_BASE + (addr) + (LPAIF_I2SCTL_REG_STRIDE * (port)))
-
-enum lpaif_i2s_ports {
-	LPAIF_I2S_PORT_MIN		= 0,
-
-	LPAIF_I2S_PORT_CODEC_SPK	= 0,
-	LPAIF_I2S_PORT_CODEC_MIC	= 1,
-	LPAIF_I2S_PORT_SEC_SPK		= 2,
-	LPAIF_I2S_PORT_SEC_MIC		= 3,
-	LPAIF_I2S_PORT_MI2S		= 4,
-
-	LPAIF_I2S_PORT_MAX		= 4,
-	LPAIF_I2S_PORT_NUM		= 5,
-};
-
-#define LPAIF_I2SCTL_REG(port)		LPAIF_I2SCTL_REG_ADDR(0x0, (port))
-
-#define LPAIF_I2SCTL_LOOPBACK_MASK	0x8000
-#define LPAIF_I2SCTL_LOOPBACK_SHIFT	15
-#define LPAIF_I2SCTL_LOOPBACK_DISABLE	(0 << LPAIF_I2SCTL_LOOPBACK_SHIFT)
-#define LPAIF_I2SCTL_LOOPBACK_ENABLE	(1 << LPAIF_I2SCTL_LOOPBACK_SHIFT)
-
-#define LPAIF_I2SCTL_SPKEN_MASK		0x4000
-#define LPAIF_I2SCTL_SPKEN_SHIFT	14
-#define LPAIF_I2SCTL_SPKEN_DISABLE	(0 << LPAIF_I2SCTL_SPKEN_SHIFT)
-#define LPAIF_I2SCTL_SPKEN_ENABLE	(1 << LPAIF_I2SCTL_SPKEN_SHIFT)
-
-#define LPAIF_I2SCTL_SPKMODE_MASK	0x3C00
-#define LPAIF_I2SCTL_SPKMODE_SHIFT	10
-#define LPAIF_I2SCTL_SPKMODE_NONE	(0 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-#define LPAIF_I2SCTL_SPKMODE_SD0	(1 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-#define LPAIF_I2SCTL_SPKMODE_SD1	(2 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-#define LPAIF_I2SCTL_SPKMODE_SD2	(3 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-#define LPAIF_I2SCTL_SPKMODE_SD3	(4 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-#define LPAIF_I2SCTL_SPKMODE_QUAD01	(5 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-#define LPAIF_I2SCTL_SPKMODE_QUAD23	(6 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-#define LPAIF_I2SCTL_SPKMODE_6CH	(7 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-#define LPAIF_I2SCTL_SPKMODE_8CH	(8 << LPAIF_I2SCTL_SPKMODE_SHIFT)
-
-#define LPAIF_I2SCTL_SPKMONO_MASK	0x0200
-#define LPAIF_I2SCTL_SPKMONO_SHIFT	9
-#define LPAIF_I2SCTL_SPKMONO_STEREO	(0 << LPAIF_I2SCTL_SPKMONO_SHIFT)
-#define LPAIF_I2SCTL_SPKMONO_MONO	(1 << LPAIF_I2SCTL_SPKMONO_SHIFT)
-
-#define LPAIF_I2SCTL_WSSRC_MASK		0x0004
-#define LPAIF_I2SCTL_WSSRC_SHIFT	2
-#define LPAIF_I2SCTL_WSSRC_INTERNAL	(0 << LPAIF_I2SCTL_WSSRC_SHIFT)
-#define LPAIF_I2SCTL_WSSRC_EXTERNAL	(1 << LPAIF_I2SCTL_WSSRC_SHIFT)
-
-#define LPAIF_I2SCTL_BITWIDTH_MASK	0x0003
-#define LPAIF_I2SCTL_BITWIDTH_SHIFT	0
-#define LPAIF_I2SCTL_BITWIDTH_16	(0 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
-#define LPAIF_I2SCTL_BITWIDTH_24	(1 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
-#define LPAIF_I2SCTL_BITWIDTH_32	(2 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
-
-/* LPAIF IRQ */
-
-#define LPAIF_IRQ_REG_BASE		0x3000
-#define LPAIF_IRQ_REG_STRIDE		0x1000
-#define LPAIF_IRQ_REG_ADDR(addr, port) \
-	(LPAIF_IRQ_REG_BASE + (addr) + (LPAIF_IRQ_REG_STRIDE * (port)))
-
-enum lpaif_irq_ports {
-	LPAIF_IRQ_PORT_MIN		= 0,
-
-	LPAIF_IRQ_PORT_HOST		= 0,
-	LPAIF_IRQ_PORT_ADSP		= 1,
-
-	LPAIF_IRQ_PORT_MAX		= 2,
-	LPAIF_IRQ_PORT_NUM		= 3,
-};
-
-#define LPAIF_IRQEN_REG(port)		LPAIF_IRQ_REG_ADDR(0x0, (port))
-#define LPAIF_IRQSTAT_REG(port)		LPAIF_IRQ_REG_ADDR(0x4, (port))
-#define LPAIF_IRQCLEAR_REG(port)	LPAIF_IRQ_REG_ADDR(0xC, (port))
-
-#define LPAIF_IRQ_BITSTRIDE		3
-#define LPAIF_IRQ_PER(chan)		(1 << (LPAIF_IRQ_BITSTRIDE * (chan)))
-#define LPAIF_IRQ_XRUN(chan)		(2 << (LPAIF_IRQ_BITSTRIDE * (chan)))
-#define LPAIF_IRQ_ERR(chan)		(4 << (LPAIF_IRQ_BITSTRIDE * (chan)))
-#define LPAIF_IRQ_ALL(chan)		(7 << (LPAIF_IRQ_BITSTRIDE * (chan)))
-
-/* LPAIF DMA */
-
-#define LPAIF_RDMA_REG_BASE		0x6000
-#define LPAIF_RDMA_REG_STRIDE		0x1000
-#define LPAIF_RDMA_REG_ADDR(addr, chan) \
-	(LPAIF_RDMA_REG_BASE + (addr) + (LPAIF_RDMA_REG_STRIDE * (chan)))
-
-enum lpaif_dma_channels {
-	LPAIF_RDMA_CHAN_MIN		= 0,
-
-	LPAIF_RDMA_CHAN_MI2S		= 0,
-	LPAIF_RDMA_CHAN_PCM0		= 1,
-	LPAIF_RDMA_CHAN_PCM1		= 2,
-
-	LPAIF_RDMA_CHAN_MAX		= 4,
-	LPAIF_RDMA_CHAN_NUM		= 5,
-};
-
-#define LPAIF_RDMACTL_REG(chan)		LPAIF_RDMA_REG_ADDR(0x00, (chan))
-#define LPAIF_RDMABASE_REG(chan)	LPAIF_RDMA_REG_ADDR(0x04, (chan))
-#define	LPAIF_RDMABUFF_REG(chan)	LPAIF_RDMA_REG_ADDR(0x08, (chan))
-#define LPAIF_RDMACURR_REG(chan)	LPAIF_RDMA_REG_ADDR(0x0C, (chan))
-#define	LPAIF_RDMAPER_REG(chan)		LPAIF_RDMA_REG_ADDR(0x10, (chan))
-
-#define LPAIF_RDMACTL_BURSTEN_MASK	0x800
-#define LPAIF_RDMACTL_BURSTEN_SHIFT	11
-#define LPAIF_RDMACTL_BURSTEN_SINGLE	(0 << LPAIF_RDMACTL_BURSTEN_SHIFT)
-#define LPAIF_RDMACTL_BURSTEN_INCR4	(1 << LPAIF_RDMACTL_BURSTEN_SHIFT)
-
-#define LPAIF_RDMACTL_WPSCNT_MASK	0x700
-#define LPAIF_RDMACTL_WPSCNT_SHIFT	8
-#define LPAIF_RDMACTL_WPSCNT_ONE	(0 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_TWO	(1 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_THREE	(2 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_FOUR	(3 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_SIX	(5 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_EIGHT	(7 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-
-#define LPAIF_RDMACTL_AUDINTF_MASK	0x0F0
-#define LPAIF_RDMACTL_AUDINTF_SHIFT	4
-#define LPAIF_RDMACTL_AUDINTF_NONE	(0 << LPAIF_RDMACTL_AUDINTF_SHIFT)
-#define LPAIF_RDMACTL_AUDINTF_CODEC	(1 << LPAIF_RDMACTL_AUDINTF_SHIFT)
-#define LPAIF_RDMACTL_AUDINTF_PCM	(2 << LPAIF_RDMACTL_AUDINTF_SHIFT)
-#define LPAIF_RDMACTL_AUDINTF_SEC_I2S	(3 << LPAIF_RDMACTL_AUDINTF_SHIFT)
-#define LPAIF_RDMACTL_AUDINTF_MI2S	(4 << LPAIF_RDMACTL_AUDINTF_SHIFT)
-#define LPAIF_RDMACTL_AUDINTF_HDMI	(5 << LPAIF_RDMACTL_AUDINTF_SHIFT)
-#define LPAIF_RDMACTL_AUDINTF_SEC_PCM	(7 << LPAIF_RDMACTL_AUDINTF_SHIFT)
-
-#define LPAIF_RDMACTL_FIFOWM_MASK	0x00E
-#define LPAIF_RDMACTL_FIFOWM_SHIFT	1
-#define LPAIF_RDMACTL_FIFOWM_1		(0 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_2		(1 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_3		(2 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_4		(3 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_5		(4 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_6		(5 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_7		(6 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_8		(7 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-
-#define LPAIF_RDMACTL_ENABLE_MASK	0x1
-#define LPAIF_RDMACTL_ENABLE_SHIFT	0
-#define LPAIF_RDMACTL_ENABLE_OFF	(0 << LPAIF_RDMACTL_ENABLE_SHIFT)
-#define LPAIF_RDMACTL_ENABLE_ON		(1 << LPAIF_RDMACTL_ENABLE_SHIFT)
-
-#endif /* __LPASS_LPAIF_H__ */
diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
new file mode 100644
index 0000000..5541b14
--- /dev/null
+++ b/sound/soc/qcom/lpass-lpaif-reg.h
@@ -0,0 +1,167 @@
+/*
+ * Copyright (c) 2010-2011,2013-2015 The Linux Foundation. All rights reserved.
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
+#ifndef __LPASS_LPAIF_REG_H__
+#define __LPASS_LPAIF_REG_H__
+
+
+/* LPAIF I2S */
+
+#define LPAIF_I2SCTL_REG_ADDR(v, addr, port) \
+	(v->i2sctrl_reg_base + (addr) + v->i2sctrl_reg_stride * (port))
+
+enum lpaif_i2s_ports {
+	LPAIF_I2S_PORT_MIN		= 0,
+
+	LPAIF_I2S_PORT_CODEC_SPK	= 0,
+	LPAIF_I2S_PORT_CODEC_MIC	= 1,
+	LPAIF_I2S_PORT_SEC_SPK		= 2,
+	LPAIF_I2S_PORT_SEC_MIC		= 3,
+	LPAIF_I2S_PORT_MI2S		= 4,
+
+	LPAIF_I2S_PORT_MAX		= 4,
+	LPAIF_I2S_PORT_NUM		= 5,
+};
+
+
+#define LPAIF_I2SCTL_REG(v, port)	LPAIF_I2SCTL_REG_ADDR(v, 0x0, (port))
+#define LPAIF_I2SCTL_LOOPBACK_MASK	0x8000
+#define LPAIF_I2SCTL_LOOPBACK_SHIFT	15
+#define LPAIF_I2SCTL_LOOPBACK_DISABLE	(0 << LPAIF_I2SCTL_LOOPBACK_SHIFT)
+#define LPAIF_I2SCTL_LOOPBACK_ENABLE	(1 << LPAIF_I2SCTL_LOOPBACK_SHIFT)
+
+#define LPAIF_I2SCTL_SPKEN_MASK		0x4000
+#define LPAIF_I2SCTL_SPKEN_SHIFT	14
+#define LPAIF_I2SCTL_SPKEN_DISABLE	(0 << LPAIF_I2SCTL_SPKEN_SHIFT)
+#define LPAIF_I2SCTL_SPKEN_ENABLE	(1 << LPAIF_I2SCTL_SPKEN_SHIFT)
+
+#define LPAIF_I2SCTL_SPKMODE_MASK	0x3C00
+#define LPAIF_I2SCTL_SPKMODE_SHIFT	10
+#define LPAIF_I2SCTL_SPKMODE_NONE	(0 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_SD0	(1 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_SD1	(2 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_SD2	(3 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_SD3	(4 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_QUAD01	(5 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_QUAD23	(6 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_6CH	(7 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+#define LPAIF_I2SCTL_SPKMODE_8CH	(8 << LPAIF_I2SCTL_SPKMODE_SHIFT)
+
+#define LPAIF_I2SCTL_SPKMONO_MASK	0x0200
+#define LPAIF_I2SCTL_SPKMONO_SHIFT	9
+#define LPAIF_I2SCTL_SPKMONO_STEREO	(0 << LPAIF_I2SCTL_SPKMONO_SHIFT)
+#define LPAIF_I2SCTL_SPKMONO_MONO	(1 << LPAIF_I2SCTL_SPKMONO_SHIFT)
+
+#define LPAIF_I2SCTL_WSSRC_MASK		0x0004
+#define LPAIF_I2SCTL_WSSRC_SHIFT	2
+#define LPAIF_I2SCTL_WSSRC_INTERNAL	(0 << LPAIF_I2SCTL_WSSRC_SHIFT)
+#define LPAIF_I2SCTL_WSSRC_EXTERNAL	(1 << LPAIF_I2SCTL_WSSRC_SHIFT)
+
+#define LPAIF_I2SCTL_BITWIDTH_MASK	0x0003
+#define LPAIF_I2SCTL_BITWIDTH_SHIFT	0
+#define LPAIF_I2SCTL_BITWIDTH_16	(0 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
+#define LPAIF_I2SCTL_BITWIDTH_24	(1 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
+#define LPAIF_I2SCTL_BITWIDTH_32	(2 << LPAIF_I2SCTL_BITWIDTH_SHIFT)
+
+/* LPAIF IRQ */
+#define LPAIF_IRQ_REG_ADDR(v, addr, port) \
+	(v->irq_reg_base + (addr) + v->irq_reg_stride * (port))
+
+enum lpaif_irq_ports {
+	LPAIF_IRQ_PORT_MIN		= 0,
+
+	LPAIF_IRQ_PORT_HOST		= 0,
+	LPAIF_IRQ_PORT_ADSP		= 1,
+
+	LPAIF_IRQ_PORT_MAX		= 2,
+	LPAIF_IRQ_PORT_NUM		= 3,
+};
+
+#define LPAIF_IRQEN_REG(v, port)	LPAIF_IRQ_REG_ADDR(v, 0x0, (port))
+#define LPAIF_IRQSTAT_REG(v, port)	LPAIF_IRQ_REG_ADDR(v, 0x4, (port))
+#define LPAIF_IRQCLEAR_REG(v, port)	LPAIF_IRQ_REG_ADDR(v, 0xC, (port))
+
+#define LPAIF_IRQ_BITSTRIDE		3
+
+#define LPAIF_IRQ_PER(chan)		(1 << (LPAIF_IRQ_BITSTRIDE * (chan)))
+#define LPAIF_IRQ_XRUN(chan)		(2 << (LPAIF_IRQ_BITSTRIDE * (chan)))
+#define LPAIF_IRQ_ERR(chan)		(4 << (LPAIF_IRQ_BITSTRIDE * (chan)))
+
+#define LPAIF_IRQ_ALL(chan)		(7 << (LPAIF_IRQ_BITSTRIDE * (chan)))
+
+/* LPAIF DMA */
+
+#define LPAIF_RDMA_REG_ADDR(v, addr, chan) \
+	(v->rdma_reg_base + (addr) + v->rdma_reg_stride * (chan))
+
+enum lpaif_dma_channels {
+	LPAIF_RDMA_CHAN_MIN		= 0,
+
+	LPAIF_RDMA_CHAN_MI2S		= 0,
+	LPAIF_RDMA_CHAN_PCM0		= 1,
+	LPAIF_RDMA_CHAN_PCM1		= 2,
+
+	LPAIF_RDMA_CHAN_MAX		= 4,
+	LPAIF_RDMA_CHAN_NUM		= 5,
+};
+
+#define LPAIF_RDMACTL_AUDINTF(id)	(id << LPAIF_RDMACTL_AUDINTF_SHIFT)
+
+#define LPAIF_RDMACTL_REG(v, chan)	LPAIF_RDMA_REG_ADDR(v, 0x00, (chan))
+#define LPAIF_RDMABASE_REG(v, chan)	LPAIF_RDMA_REG_ADDR(v, 0x04, (chan))
+#define	LPAIF_RDMABUFF_REG(v, chan)	LPAIF_RDMA_REG_ADDR(v, 0x08, (chan))
+#define LPAIF_RDMACURR_REG(v, chan)	LPAIF_RDMA_REG_ADDR(v, 0x0C, (chan))
+#define	LPAIF_RDMAPER_REG(v, chan)	LPAIF_RDMA_REG_ADDR(v, 0x10, (chan))
+#define	LPAIF_RDMAPERCNT_REG(v, chan)	LPAIF_RDMA_REG_ADDR(v, 0x14, (chan))
+
+#define LPAIF_RDMACTL_BURSTEN_MASK	0x800
+#define LPAIF_RDMACTL_BURSTEN_SHIFT	11
+#define LPAIF_RDMACTL_BURSTEN_SINGLE	(0 << LPAIF_RDMACTL_BURSTEN_SHIFT)
+#define LPAIF_RDMACTL_BURSTEN_INCR4	(1 << LPAIF_RDMACTL_BURSTEN_SHIFT)
+
+#define LPAIF_RDMACTL_WPSCNT_MASK	0x700
+#define LPAIF_RDMACTL_WPSCNT_SHIFT	8
+#define LPAIF_RDMACTL_WPSCNT_ONE	(0 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_TWO	(1 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_THREE	(2 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_FOUR	(3 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_SIX	(5 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+#define LPAIF_RDMACTL_WPSCNT_EIGHT	(7 << LPAIF_RDMACTL_WPSCNT_SHIFT)
+
+#define LPAIF_RDMACTL_AUDINTF_MASK	0x0F0
+#define LPAIF_RDMACTL_AUDINTF_SHIFT	4
+#define LPAIF_RDMACTL_AUDINTF_NONE	(0 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_CODEC	(1 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_PCM	(2 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_SEC_I2S	(3 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_MI2S	(4 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_HDMI	(5 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+#define LPAIF_RDMACTL_AUDINTF_SEC_PCM	(7 << LPAIF_RDMACTL_AUDINTF_SHIFT)
+
+#define LPAIF_RDMACTL_FIFOWM_MASK	0x00E
+#define LPAIF_RDMACTL_FIFOWM_SHIFT	1
+#define LPAIF_RDMACTL_FIFOWM_1		(0 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_2		(1 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_3		(2 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_4		(3 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_5		(4 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_6		(5 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_7		(6 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+#define LPAIF_RDMACTL_FIFOWM_8		(7 << LPAIF_RDMACTL_FIFOWM_SHIFT)
+
+#define LPAIF_RDMACTL_ENABLE_MASK	0x1
+#define LPAIF_RDMACTL_ENABLE_SHIFT	0
+#define LPAIF_RDMACTL_ENABLE_OFF	(0 << LPAIF_RDMACTL_ENABLE_SHIFT)
+#define LPAIF_RDMACTL_ENABLE_ON		(1 << LPAIF_RDMACTL_ENABLE_SHIFT)
+
+#endif /* __LPASS_LPAIF_REG_H__ */
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index ffc0928..a38e7ec 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -21,7 +21,7 @@
 #include <sound/pcm_params.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
-#include "lpass-lpaif-ipq806x.h"
+#include "lpass-lpaif-reg.h"
 #include "lpass.h"
 
 #define LPASS_PLATFORM_BUFFER_SIZE	(16 * 1024)
@@ -80,6 +80,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
 	snd_pcm_format_t format = params_format(params);
 	unsigned int channels = params_channels(params);
 	unsigned int regval;
@@ -150,7 +151,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(LPAIF_RDMA_CHAN_MI2S), regval);
+			LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S), regval);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -165,10 +166,11 @@ static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
 	int ret;
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(LPAIF_RDMA_CHAN_MI2S), 0);
+			LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S), 0);
 	if (ret)
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -182,10 +184,11 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
 	int ret;
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMABASE_REG(LPAIF_RDMA_CHAN_MI2S),
+			LPAIF_RDMABASE_REG(v, LPAIF_RDMA_CHAN_MI2S),
 			runtime->dma_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmabase reg: %d\n",
@@ -194,7 +197,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMABUFF_REG(LPAIF_RDMA_CHAN_MI2S),
+			LPAIF_RDMABUFF_REG(v, LPAIF_RDMA_CHAN_MI2S),
 			(snd_pcm_lib_buffer_bytes(substream) >> 2) - 1);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmabuff reg: %d\n",
@@ -203,7 +206,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMAPER_REG(LPAIF_RDMA_CHAN_MI2S),
+			LPAIF_RDMAPER_REG(v, LPAIF_RDMA_CHAN_MI2S),
 			(snd_pcm_lib_period_bytes(substream) >> 2) - 1);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmaper reg: %d\n",
@@ -212,7 +215,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_update_bits(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(LPAIF_RDMA_CHAN_MI2S),
+			LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S),
 			LPAIF_RDMACTL_ENABLE_MASK, LPAIF_RDMACTL_ENABLE_ON);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
@@ -229,6 +232,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
 	int ret;
 
 	switch (cmd) {
@@ -237,7 +241,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		/* clear status before enabling interrupts */
 		ret = regmap_write(drvdata->lpaif_map,
-				LPAIF_IRQCLEAR_REG(LPAIF_IRQ_PORT_HOST),
+				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S));
 		if (ret) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
@@ -246,7 +250,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		}
 
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_IRQEN_REG(LPAIF_IRQ_PORT_HOST),
+				LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S),
 				LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S));
 		if (ret) {
@@ -256,7 +260,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		}
 
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_RDMACTL_REG(LPAIF_RDMA_CHAN_MI2S),
+				LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S),
 				LPAIF_RDMACTL_ENABLE_MASK,
 				LPAIF_RDMACTL_ENABLE_ON);
 		if (ret) {
@@ -269,7 +273,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_RDMACTL_REG(LPAIF_RDMA_CHAN_MI2S),
+				LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S),
 				LPAIF_RDMACTL_ENABLE_MASK,
 				LPAIF_RDMACTL_ENABLE_OFF);
 		if (ret) {
@@ -279,7 +283,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		}
 
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_IRQEN_REG(LPAIF_IRQ_PORT_HOST),
+				LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S), 0);
 		if (ret) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqen reg: %d\n",
@@ -298,11 +302,13 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 			snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
 	unsigned int base_addr, curr_addr;
 	int ret;
 
 	ret = regmap_read(drvdata->lpaif_map,
-			LPAIF_RDMABASE_REG(LPAIF_RDMA_CHAN_MI2S), &base_addr);
+			 LPAIF_RDMABASE_REG(v, LPAIF_RDMA_CHAN_MI2S),
+			 &base_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error reading from rdmabase reg: %d\n",
 				__func__, ret);
@@ -310,7 +316,8 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	}
 
 	ret = regmap_read(drvdata->lpaif_map,
-			LPAIF_RDMACURR_REG(LPAIF_RDMA_CHAN_MI2S), &curr_addr);
+			 LPAIF_RDMACURR_REG(v, LPAIF_RDMA_CHAN_MI2S),
+			 &curr_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error reading from rdmacurr reg: %d\n",
 				__func__, ret);
@@ -347,12 +354,13 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
 	unsigned int interrupts;
 	irqreturn_t ret = IRQ_NONE;
 	int rv;
 
 	rv = regmap_read(drvdata->lpaif_map,
-			LPAIF_IRQSTAT_REG(LPAIF_IRQ_PORT_HOST), &interrupts);
+			LPAIF_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &interrupts);
 	if (rv) {
 		dev_err(soc_runtime->dev, "%s() error reading from irqstat reg: %d\n",
 				__func__, rv);
@@ -362,7 +370,7 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 
 	if (interrupts & LPAIF_IRQ_PER(LPAIF_RDMA_CHAN_MI2S)) {
 		rv = regmap_write(drvdata->lpaif_map,
-				LPAIF_IRQCLEAR_REG(LPAIF_IRQ_PORT_HOST),
+				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_PER(LPAIF_RDMA_CHAN_MI2S));
 		if (rv) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
@@ -375,7 +383,7 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 
 	if (interrupts & LPAIF_IRQ_XRUN(LPAIF_RDMA_CHAN_MI2S)) {
 		rv = regmap_write(drvdata->lpaif_map,
-				LPAIF_IRQCLEAR_REG(LPAIF_IRQ_PORT_HOST),
+				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_XRUN(LPAIF_RDMA_CHAN_MI2S));
 		if (rv) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
@@ -389,7 +397,7 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 
 	if (interrupts & LPAIF_IRQ_ERR(LPAIF_RDMA_CHAN_MI2S)) {
 		rv = regmap_write(drvdata->lpaif_map,
-				LPAIF_IRQCLEAR_REG(LPAIF_IRQ_PORT_HOST),
+				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_ERR(LPAIF_RDMA_CHAN_MI2S));
 		if (rv) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
@@ -444,6 +452,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 		pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
 	int ret;
 
 	soc_runtime->dev->coherent_dma_mask = DMA_BIT_MASK(32);
@@ -464,14 +473,14 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 
 	/* ensure audio hardware is disabled */
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_IRQEN_REG(LPAIF_IRQ_PORT_HOST), 0);
+			LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to irqen reg: %d\n",
 				__func__, ret);
 		return ret;
 	}
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(LPAIF_RDMA_CHAN_MI2S), 0);
+			LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S), 0);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 5c99b3d..5bd2a90 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -43,9 +43,37 @@ struct lpass_data {
 
 	/* interrupts from the low-power audio interface (LPAIF) */
 	int lpaif_irq;
+
+	/* SOC specific variations in the LPASS IP integration */
+	struct lpass_variant *variant;
+};
+
+/* Vairant data per each SOC */
+struct lpass_variant {
+	u32	i2sctrl_reg_base;
+	u32	i2sctrl_reg_stride;
+	u32	i2s_ports;
+	u32	irq_reg_base;
+	u32	irq_reg_stride;
+	u32	irq_ports;
+	u32	rdma_reg_base;
+	u32	rdma_reg_stride;
+	u32	rdma_channels;
+
+	/* SOC specific intialization like clocks */
+	int (*init)(struct platform_device *pdev);
+	int (*exit)(struct platform_device *pdev);
+
+	/* SOC specific dais */
+	struct snd_soc_dai_driver *dai_driver;
+	int num_dai;
 };
 
 /* register the platform driver from the CPU DAI driver */
 int asoc_qcom_lpass_platform_register(struct platform_device *);
+int lpass_cpu_platform_remove(struct platform_device *pdev);
+int lpass_cpu_platform_probe(struct platform_device *pdev);
+int lpass_cpu_dai_probe(struct snd_soc_dai *dai);
+extern struct snd_soc_dai_ops lpass_cpu_dai_ops;
 
 #endif /* __LPASS_H__ */
-- 
1.9.1
