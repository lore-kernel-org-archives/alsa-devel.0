From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: Add support for the Analog Devices
	AXI-SPDIF driver
Date: Thu, 28 Nov 2013 20:02:52 +0100
Message-ID: <1385665372-29477-4-git-send-email-lars@metafoo.de>
References: <1385665372-29477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-045.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id D22D526549C
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 20:02:21 +0100 (CET)
In-Reply-To: <1385665372-29477-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds a ASoC driver for the AXI-SPDIF core. The core implements a
simple SPDIF transmitter and is used on some Analog Devices' reference designs
for various FPGA platforms. For now the driver only support the PL330 as the the
DMA controller.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Has a compile time dependency on topic/dma
---
 sound/soc/adi/Kconfig     |   8 ++
 sound/soc/adi/Makefile    |   2 +
 sound/soc/adi/axi-spdif.c | 272 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 sound/soc/adi/axi-spdif.c

diff --git a/sound/soc/adi/Kconfig b/sound/soc/adi/Kconfig
index 14bb385..82438de 100644
--- a/sound/soc/adi/Kconfig
+++ b/sound/soc/adi/Kconfig
@@ -11,3 +11,11 @@ config SND_SOC_ADI_AXI_I2S
 	select REGMAP_MMIO
 	help
 	  ASoC driver for the Analog Devices AXI-I2S softcore peripheral.
+
+config SND_SOC_ADI_AXI_SPDIF
+	tristate "AXI-SPDIF support"
+	depends on SND_SOC_ADI
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select REGMAP_MMIO
+	help
+	  ASoC driver for the Analog Devices AXI-SPDIF softcore peripheral.
diff --git a/sound/soc/adi/Makefile b/sound/soc/adi/Makefile
index d32c21a..64456c1 100644
--- a/sound/soc/adi/Makefile
+++ b/sound/soc/adi/Makefile
@@ -1,3 +1,5 @@
 snd-soc-adi-axi-i2s-objs := axi-i2s.o
+snd-soc-adi-axi-spdif-objs := axi-spdif.o
 
 obj-$(CONFIG_SND_SOC_ADI_AXI_I2S) += snd-soc-adi-axi-i2s.o
+obj-$(CONFIG_SND_SOC_ADI_AXI_SPDIF) += snd-soc-adi-axi-spdif.o
diff --git a/sound/soc/adi/axi-spdif.c b/sound/soc/adi/axi-spdif.c
new file mode 100644
index 0000000..806fc8f
--- /dev/null
+++ b/sound/soc/adi/axi-spdif.c
@@ -0,0 +1,272 @@
+/*
+ * Copyright (C) 2012-2013, Analog Devices Inc.
+ * Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/dmaengine_pcm.h>
+
+#define AXI_SPDIF_REG_CTRL	0x0
+#define AXI_SPDIF_REG_STAT	0x4
+#define AXI_SPDIF_REG_TX_FIFO	0xc
+
+#define AXI_SPDIF_CTRL_TXDATA BIT(1)
+#define AXI_SPDIF_CTRL_TXEN BIT(0)
+#define AXI_SPDIF_CTRL_CLKDIV_OFFSET 8
+#define AXI_SPDIF_CTRL_CLKDIV_MASK (0xff << 8)
+
+#define AXI_SPDIF_FREQ_44100	(0x0 << 6)
+#define AXI_SPDIF_FREQ_48000	(0x1 << 6)
+#define AXI_SPDIF_FREQ_32000	(0x2 << 6)
+#define AXI_SPDIF_FREQ_NA	(0x3 << 6)
+
+struct axi_spdif {
+	struct regmap *regmap;
+	struct clk *clk;
+	struct clk *clk_ref;
+
+	struct snd_dmaengine_dai_dma_data dma_data;
+
+	struct snd_ratnum ratnum;
+	struct snd_pcm_hw_constraint_ratnums rate_constraints;
+};
+
+static int axi_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
+	struct snd_soc_dai *dai)
+{
+	struct axi_spdif *spdif = snd_soc_dai_get_drvdata(dai);
+	unsigned int val;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		val = AXI_SPDIF_CTRL_TXDATA;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(spdif->regmap, AXI_SPDIF_REG_CTRL,
+		AXI_SPDIF_CTRL_TXDATA, val);
+
+	return 0;
+}
+
+static int axi_spdif_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct axi_spdif *spdif = snd_soc_dai_get_drvdata(dai);
+	unsigned int rate = params_rate(params);
+	unsigned int clkdiv, stat;
+
+	switch (params_rate(params)) {
+	case 32000:
+		stat = AXI_SPDIF_FREQ_32000;
+		break;
+	case 44100:
+		stat = AXI_SPDIF_FREQ_44100;
+		break;
+	case 48000:
+		stat = AXI_SPDIF_FREQ_48000;
+		break;
+	default:
+		stat = AXI_SPDIF_FREQ_NA;
+		break;
+	}
+
+	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(spdif->clk_ref),
+			rate * 64 * 2) - 1;
+	clkdiv <<= AXI_SPDIF_CTRL_CLKDIV_OFFSET;
+
+	regmap_write(spdif->regmap, AXI_SPDIF_REG_STAT, stat);
+	regmap_update_bits(spdif->regmap, AXI_SPDIF_REG_CTRL,
+		AXI_SPDIF_CTRL_CLKDIV_MASK, clkdiv);
+
+	return 0;
+}
+
+static int axi_spdif_dai_probe(struct snd_soc_dai *dai)
+{
+	struct axi_spdif *spdif = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &spdif->dma_data, NULL);
+
+	return 0;
+}
+
+static int axi_spdif_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct axi_spdif *spdif = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = snd_pcm_hw_constraint_ratnums(substream->runtime, 0,
+			   SNDRV_PCM_HW_PARAM_RATE,
+			   &spdif->rate_constraints);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(spdif->clk_ref);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(spdif->regmap, AXI_SPDIF_REG_CTRL,
+		AXI_SPDIF_CTRL_TXEN, AXI_SPDIF_CTRL_TXEN);
+
+	return 0;
+}
+
+static void axi_spdif_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct axi_spdif *spdif = snd_soc_dai_get_drvdata(dai);
+
+	regmap_update_bits(spdif->regmap, AXI_SPDIF_REG_CTRL,
+		AXI_SPDIF_CTRL_TXEN, 0);
+
+	clk_disable_unprepare(spdif->clk_ref);
+}
+
+static const struct snd_soc_dai_ops axi_spdif_dai_ops = {
+	.startup = axi_spdif_startup,
+	.shutdown = axi_spdif_shutdown,
+	.trigger = axi_spdif_trigger,
+	.hw_params = axi_spdif_hw_params,
+};
+
+static struct snd_soc_dai_driver axi_spdif_dai = {
+	.probe = axi_spdif_dai_probe,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &axi_spdif_dai_ops,
+};
+
+static const struct snd_soc_component_driver axi_spdif_component = {
+	.name		= "axi-spdif",
+};
+
+static const struct regmap_config axi_spdif_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = AXI_SPDIF_REG_STAT,
+};
+
+static int axi_spdif_probe(struct platform_device *pdev)
+{
+	struct axi_spdif *spdif;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+
+	spdif = devm_kzalloc(&pdev->dev, sizeof(*spdif), GFP_KERNEL);
+	if (!spdif)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, spdif);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!base)
+		return -EBUSY;
+
+	spdif->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					    &axi_spdif_regmap_config);
+	if (IS_ERR(spdif->regmap))
+		return PTR_ERR(spdif->regmap);
+
+	spdif->clk = devm_clk_get(&pdev->dev, "axi");
+	if (IS_ERR(spdif->clk))
+		return PTR_ERR(spdif->clk);
+
+	spdif->clk_ref = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(spdif->clk_ref))
+		return PTR_ERR(spdif->clk_ref);
+
+	ret = clk_prepare_enable(spdif->clk);
+	if (ret)
+		return ret;
+
+	spdif->dma_data.addr = res->start + AXI_SPDIF_REG_TX_FIFO;
+	spdif->dma_data.addr_width = 4;
+	spdif->dma_data.maxburst = 1;
+
+	spdif->ratnum.num = clk_get_rate(spdif->clk_ref) / 128;
+	spdif->ratnum.den_step = 1;
+	spdif->ratnum.den_min = 1;
+	spdif->ratnum.den_max = 64;
+
+	spdif->rate_constraints.rats = &spdif->ratnum;
+	spdif->rate_constraints.nrats = 1;
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &axi_spdif_component,
+					 &axi_spdif_dai, 1);
+	if (ret)
+		goto err_clk_disable;
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
+			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
+	if (ret)
+		goto err_clk_disable;
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(spdif->clk);
+	return ret;
+}
+
+static int axi_spdif_dev_remove(struct platform_device *pdev)
+{
+	struct axi_spdif *spdif = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(spdif->clk);
+
+	return 0;
+}
+
+static const struct of_device_id axi_spdif_of_match[] = {
+	{ .compatible = "adi,axi-spdif-tx-1.00.a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, axi_spdif_of_match);
+
+static struct platform_driver axi_spdif_driver = {
+	.driver = {
+		.name = "axi-spdif",
+		.owner = THIS_MODULE,
+		.of_match_table = axi_spdif_of_match,
+	},
+	.probe = axi_spdif_probe,
+	.remove = axi_spdif_dev_remove,
+};
+module_platform_driver(axi_spdif_driver);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("AXI SPDIF driver");
+MODULE_LICENSE("GPL");
-- 
1.8.0
