From: miguel.aguilar@ridgerun.com
Subject: [PATCH 2/4] ASoC: DaVinci: Voice Codec Interface
Date: Tue, 22 Sep 2009 13:29:20 -0600
Message-ID: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CA78103892
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 21:29:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
Cc: santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

1) Adds an interface needed by the voice codec CQ0093.
2) Add an option to select internal or external codec in the DM365.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 sound/soc/davinci/Kconfig        |   26 +++-
 sound/soc/davinci/Makefile       |    2 +
 sound/soc/davinci/davinci-vcif.c |  363 ++++++++++++++++++++++++++++++++++++++
 sound/soc/davinci/davinci-vcif.h |   63 +++++++
 4 files changed, 452 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/davinci/davinci-vcif.c
 create mode 100644 sound/soc/davinci/davinci-vcif.h

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 047ee39..051a10e 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -9,18 +9,40 @@ config SND_DAVINCI_SOC
 config SND_DAVINCI_SOC_I2S
 	tristate
 
+config SND_DAVINCI_SOC_VCIF
+	tristate
+
 config SND_DAVINCI_SOC_MCASP
 	tristate
 
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
-	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM  || MACH_DAVINCI_DM365_EVM
+	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM || MACH_DAVINCI_DM365_EVM
 	select SND_DAVINCI_SOC_I2S
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on TI
-	  DaVinci DM6446 or DM355 EVM platforms.
+	  DaVinci DM6446, DM355 or DM365 EVM platforms.
+
+choice
+	prompt "DM365 codec select"
+	depends on SND_DAVINCI_SOC_EVM
+	depends on MACH_DAVINCI_DM365_EVM
+	default SND_DM365_EXTERNAL_CODEC
+
+config SND_DM365_INTERNAL_CODEC
+	bool "CQ93VC"
+	select SND_DAVINCI_SOC_VCIF
+	select SND_SOC_CQ0093VC
+	help
+	  Say Y if you want to add support for SoC On-chip voice codec
+
+config SND_DM365_EXTERNAL_CODEC
+	bool "AIC3101"
+	help
+	  Say Y if you want to add support for AIC3101 audio codec
+endchoice
 
 config  SND_DM6467_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6467 EVM"
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index a6939d7..a93679d 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -2,10 +2,12 @@
 snd-soc-davinci-objs := davinci-pcm.o
 snd-soc-davinci-i2s-objs := davinci-i2s.o
 snd-soc-davinci-mcasp-objs:= davinci-mcasp.o
+snd-soc-davinci-vcif-objs:= davinci-vcif.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC) += snd-soc-davinci.o
 obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
 obj-$(CONFIG_SND_DAVINCI_SOC_MCASP) += snd-soc-davinci-mcasp.o
+obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 
 # DAVINCI Machine Support
 snd-soc-evm-objs := davinci-evm.o
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
new file mode 100644
index 0000000..83191f1
--- /dev/null
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -0,0 +1,363 @@
+/*
+ * ALSA SoC Voice Codec Interface for TI DAVINCI processor
+ *
+ * Copyright (C) 2009 Texas Instruments.
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * Initial code: Hui Geng
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "davinci-pcm.h"
+#include "davinci-i2s.h"
+#include "davinci-vcif.h"
+
+#define MOD_REG_BIT(val, mask, set) do { \
+	if (set) { \
+		val |= mask; \
+	} else { \
+		val &= ~mask; \
+	} \
+} while (0)
+
+static struct davinci_pcm_dma_params davinci_vcif_pcm_out = {
+	.name = "VCIF PCM Stereo out",
+};
+
+static struct davinci_pcm_dma_params davinci_vcif_pcm_in = {
+	.name = "VCIF PCM Stereo in",
+};
+
+struct davinci_vcif_dev {
+	void __iomem			*base;
+	resource_size_t			pbase;
+	size_t				base_size;
+	int				mode;
+	u32				pcr;
+	struct clk			*clk;
+	struct davinci_pcm_dma_params	*dma_params[2];
+};
+
+static inline void davinci_vcif_write_reg(struct davinci_vcif_dev *dev,
+					   int reg, u32 val)
+{
+	__raw_writel(val, dev->base + reg);
+}
+
+static inline u32 davinci_vcif_read_reg(struct davinci_vcif_dev *dev, int reg)
+{
+	return __raw_readl(dev->base + reg);
+}
+
+static void davinci_vcif_start(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_vcif_dev *dev = rtd->dai->cpu_dai->private_data;
+	u32 w;
+
+	/* Start the sample generator and enable transmitter/receiver */
+	w = davinci_vcif_read_reg(dev, DAVINCI_VCIF_CTRL_REG);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RSTDAC, 1);
+	else
+		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RSTADC, 1);
+
+	davinci_vcif_write_reg(dev, DAVINCI_VCIF_CTRL_REG, w);
+}
+
+static void davinci_vcif_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_vcif_dev *dev = rtd->dai->cpu_dai->private_data;
+	u32 w;
+
+	/* Reset transmitter/receiver and sample rate/frame sync generators */
+	w = davinci_vcif_read_reg(dev, DAVINCI_VCIF_CTRL_REG);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RSTDAC, 0);
+	else
+		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RSTADC, 0);
+
+	davinci_vcif_write_reg(dev, DAVINCI_VCIF_CTRL_REG, w);
+}
+
+static int davinci_vcif_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *cpu_dai)
+{
+	struct davinci_vcif_dev *dev = cpu_dai->private_data;
+
+	cpu_dai->dma_data = dev->dma_params[substream->stream];
+	return 0;
+}
+
+static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct davinci_pcm_dma_params *dma_params = dai->dma_data;
+	struct davinci_vcif_dev *dev = dai->private_data;
+	u32 w;
+
+	/* Restart the codec before setup */
+	davinci_vcif_stop(substream);
+	davinci_vcif_start(substream);
+
+	/* General line settings */
+	davinci_vcif_write_reg(dev,
+			DAVINCI_VCIF_CTRL_REG, DAVINCI_VCIF_CTRL_MASK);
+
+	davinci_vcif_write_reg(dev,
+			DAVINCI_VCIF_INTCLR_REG, DAVINCI_VCIF_INT_MASK);
+
+	davinci_vcif_write_reg(dev,
+			DAVINCI_VCIF_INTEN_REG, DAVINCI_VCIF_INT_MASK);
+
+	w = davinci_vcif_read_reg(dev, DAVINCI_VCIF_CTRL_REG);
+
+	/* Determine xfer data type */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U8:
+		dma_params->data_type = 0;
+
+		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RD_BITS_8 |
+					DAVINCI_VCIF_CTRL_RD_UNSIGNED |
+					DAVINCI_VCIF_CTRL_WD_BITS_8 |
+					DAVINCI_VCIF_CTRL_WD_UNSIGNED, 1);
+		break;
+	case SNDRV_PCM_FORMAT_S8:
+		dma_params->data_type = 1;
+
+		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RD_BITS_8 |
+					DAVINCI_VCIF_CTRL_WD_BITS_8, 1);
+
+		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RD_UNSIGNED |
+					DAVINCI_VCIF_CTRL_WD_UNSIGNED, 0);
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dma_params->data_type = 2;
+
+		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RD_BITS_8 |
+					DAVINCI_VCIF_CTRL_RD_UNSIGNED |
+					DAVINCI_VCIF_CTRL_WD_BITS_8 |
+					DAVINCI_VCIF_CTRL_WD_UNSIGNED, 0);
+		break;
+	default:
+		printk(KERN_WARNING "davinci-vcif: unsupported PCM format");
+		return -EINVAL;
+	}
+
+	dma_params->acnt  = dma_params->data_type;
+
+	davinci_vcif_write_reg(dev, DAVINCI_VCIF_CTRL_REG, w);
+
+	return 0;
+}
+
+static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		davinci_vcif_start(substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		davinci_vcif_stop(substream);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+#define DAVINCI_VCIF_RATES	SNDRV_PCM_RATE_8000_48000
+
+static struct snd_soc_dai_ops davinci_vcif_dai_ops = {
+	.startup 	= davinci_vcif_startup,
+	.trigger	= davinci_vcif_trigger,
+	.hw_params	= davinci_vcif_hw_params,
+};
+
+struct snd_soc_dai davinci_vcif_dai = {
+	.name = "davinci-vcif",
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = DAVINCI_VCIF_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = DAVINCI_VCIF_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.ops = &davinci_vcif_dai_ops,
+
+};
+EXPORT_SYMBOL_GPL(davinci_vcif_dai);
+
+static int davinci_vcif_probe(struct platform_device *pdev)
+{
+	struct davinci_vcif_dev *dev;
+	struct resource *res, *mem;
+	int ret;
+
+	dev = kzalloc(sizeof(struct davinci_vcif_dev), GFP_KERNEL);
+	if (!dev) {
+		dev_dbg(&pdev->dev, "could not allocate memory for private data\n");
+		return -ENOMEM;
+	}
+
+	dev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk)) {
+		dev_dbg(&pdev->dev, "%s: could not get the clock for voice codec\n",
+			pdev->name);
+		ret = -ENODEV;
+		goto fail1;
+	}
+	clk_enable(dev->clk);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no mem resource\n");
+		ret = -ENODEV;
+		goto fail2;
+	}
+
+	dev->pbase = res->start;
+	dev->base_size = resource_size(res);
+
+	mem = request_mem_region(dev->pbase, dev->base_size, pdev->name);
+	if (!mem) {
+		dev_err(&pdev->dev, "VCIF region already claimed\n");
+		ret = -EBUSY;
+		goto fail2;
+	}
+
+	dev->base = ioremap(dev->pbase, dev->base_size);
+	if (!dev->base) {
+		dev_err(&pdev->dev,"%s: can't ioremap mem resource.\n", pdev->name);
+		ret = -ENOMEM;
+		goto fail3;
+	}
+
+	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK] = &davinci_vcif_pcm_out;
+	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->dma_addr =
+	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_VCIF_WFIFO_REG);
+
+	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE] = &davinci_vcif_pcm_in;
+	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->dma_addr =
+	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_VCIF_RFIFO_REG);
+
+	/* first TX, then RX */
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "%s: no DMA resource\n", pdev->name);
+		ret = -ENXIO;
+		goto fail4;
+	}
+	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->channel = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "%s: no DMA resource\n", pdev->name);
+		ret = -ENXIO;
+		goto fail4;
+	}
+	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->channel = res->start;
+
+	davinci_vcif_dai.private_data = dev;
+	ret = snd_soc_register_dai(&davinci_vcif_dai);
+	if (ret != 0)
+		goto fail4;
+
+	return 0;
+
+fail4:
+	iounmap(dev->base);
+fail3:
+	release_mem_region(dev->pbase, dev->base_size);
+fail2:
+	clk_disable(dev->clk);
+	clk_put(dev->clk);
+	dev->clk = NULL;
+fail1:
+	kfree(dev);
+
+	return ret;
+}
+
+static int davinci_vcif_remove(struct platform_device *pdev)
+{
+	struct davinci_vcif_dev *dev = davinci_vcif_dai.private_data;
+
+	iounmap(dev->base);
+	release_mem_region(dev->pbase, dev->base_size);
+
+	clk_disable(dev->clk);
+	clk_put(dev->clk);
+	dev->clk = NULL;
+
+	kfree(dev);
+
+	snd_soc_unregister_dai(&davinci_vcif_dai);
+
+	return 0;
+}
+
+static struct platform_driver davinci_vcif_driver = {
+	.probe		= davinci_vcif_probe,
+	.remove		= davinci_vcif_remove,
+	.driver		= {
+		.name	= "voice_codec",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init davinci_vcif_init(void)
+{
+	return platform_driver_probe(&davinci_vcif_driver, davinci_vcif_probe);
+}
+module_init(davinci_vcif_init);
+
+static void __exit davinci_vcif_exit(void)
+{
+	platform_driver_unregister(&davinci_vcif_driver);
+}
+module_exit(davinci_vcif_exit);
+
+MODULE_AUTHOR("Miguel Aguilar");
+MODULE_DESCRIPTION("Texas Instruments DaVinci ASoC Voice Codec Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/davinci/davinci-vcif.h b/sound/soc/davinci/davinci-vcif.h
new file mode 100644
index 0000000..30e441d
--- /dev/null
+++ b/sound/soc/davinci/davinci-vcif.h
@@ -0,0 +1,63 @@
+/*
+ * ALSA SoC Voice Codec Interface for TI DAVINCI processor
+ *
+ * Copyright (C) 2009 Texas Instruments.
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * Initial code: Hui Geng
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _DAVINCI_VCIF_H
+#define _DAVINCI_VCIF_H
+
+#define DAVINCI_VCIF_PID_REG		0x00
+#define DAVINCI_VCIF_CTRL_REG		0x04
+#define DAVINCI_VCIF_INTEN_REG		0x08
+#define DAVINCI_VCIF_INTSTATUS_REG	0x0c
+#define DAVINCI_VCIF_INTCLR_REG		0x10
+#define DAVINCI_VCIF_EMUL_CTRL_REG	0x14
+#define DAVINCI_VCIF_RFIFO_REG		0x20
+#define DAVINCI_VCIF_WFIFO_REG		0x24
+#define DAVINCI_VCIF_FIFOSTAT_REG	0x28
+#define DAVINCI_VCIF_TST_CTRL_REG	0x2C
+
+#define DAVINCI_VCIF_CTRL_MASK		0x5500
+#define DAVINCI_VCIF_CTRL_RSTADC	(1 << 0)
+#define DAVINCI_VCIF_CTRL_RSTDAC	(1 << 1)
+#define DAVINCI_VCIF_CTRL_RD_BITS_8	(1 << 4)
+#define DAVINCI_VCIF_CTRL_RD_UNSIGNED	(1 << 5)
+#define DAVINCI_VCIF_CTRL_WD_BITS_8	(1 << 6)
+#define DAVINCI_VCIF_CTRL_WD_UNSIGNED	(1 << 7)
+#define DAVINCI_VCIF_CTRL_RFIFOEN	(1 << 8)
+#define DAVINCI_VCIF_CTRL_RFIFOCL	(1 << 9)
+#define DAVINCI_VCIF_CTRL_RFIFOMD_WORD_1	(1 << 10)
+#define DAVINCI_VCIF_CTRL_WFIFOEN	(1 << 12)
+#define DAVINCI_VCIF_CTRL_WFIFOCL	(1 << 13)
+#define DAVINCI_VCIF_CTRL_WFIFOMD_WORD_1	(1 << 14)
+
+#define DAVINCI_VCIF_INT_MASK		0x3F
+#define DAVINCI_VCIF_INT_RDRDY_MASK	(1 << 0)
+#define DAVINCI_VCIF_INT_RERROVF_MASK	(1 << 1)
+#define DAVINCI_VCIF_INT_RERRUDR_MASK	(1 << 2)
+#define DAVINCI_VCIF_INT_WDREQ_MASK	(1 << 3)
+#define DAVINCI_VCIF_INT_WERROVF_MASK	(1 << 4)
+#define DAVINCI_VCIF_INT_WERRUDR_MASK	(1 << 5)
+
+extern struct snd_soc_dai davinci_vcif_dai;
+
+#endif
-- 
1.6.0.4
