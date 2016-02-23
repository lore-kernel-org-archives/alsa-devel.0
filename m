From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/4 RESEND] ASoC: dwc: Add I2S HDMI audio support using custom platform driver
Date: Tue, 23 Feb 2016 13:51:13 +0000
Message-ID: <7d969db0323c266be5ea981fd4bd0b5742387456.1456234503.git.joabreu@synopsys.com>
References: <cover.1456234503.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1456234503.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1456234503.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1456234503.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

HDMI audio support was added to the AXS board using an
I2S cpu driver and a custom platform driver.

The platform driver supports two channels @ 16 bits with
rates 32k, 44.1k and 48k. ALSA Simple audio card is used to
glue the cpu, platform and codec driver (adv7511).

Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 arch/arc/boot/dts/axs10x_mb.dtsi |  20 ++-
 sound/soc/dwc/Kconfig            |   1 +
 sound/soc/dwc/Makefile           |   4 +-
 sound/soc/dwc/designware_i2s.c   | 139 +++++++++++++++++++--
 sound/soc/dwc/designware_pcm.c   | 264 +++++++++++++++++++++++++++++++++++++++
 sound/soc/dwc/designware_pcm.h   |  21 ++++
 6 files changed, 430 insertions(+), 19 deletions(-)
 create mode 100644 sound/soc/dwc/designware_pcm.c
 create mode 100644 sound/soc/dwc/designware_pcm.h

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index e00e5bb..c137376 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -130,12 +130,23 @@
 			interrupts = <14>;
 		};
 
-		i2c@0x1e000 {
-			compatible = "snps,designware-i2c";
+		i2s: i2s@0x1e000 {
+			compatible = "snps,designware-i2s";
 			reg = <0x1e000 0x100>;
-			clock-frequency = <400000>;
-			clocks = <&i2cclk>;
 			interrupts = <15>;
+			#sound-dai-cells = <0>;
+		};
+
+		sound {
+			compatible = "simple-audio-card";
+			simple-audio-card,name = "AXS10X HDMI Audio";
+			simple-audio-card,format = "i2s";
+			simple-audio-card,cpu {
+				sound-dai = <&i2s>;
+			};
+			simple-audio-card,codec {
+				sound-dai = <&adv7511>;
+			};
 		};
 
 		i2c@0x1f000 {
@@ -155,6 +166,7 @@
 				adi,input-colorspace = "rgb";
 				adi,input-clock = "1x";
 				adi,clock-delay = <0x03>;
+				#sound-dai-cells = <0>;
 
 				ports {
 					#address-cells = <1>;
diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index d50e085..bc3fae7 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -2,6 +2,7 @@ config SND_DESIGNWARE_I2S
 	tristate "Synopsys I2S Device Driver"
 	depends on CLKDEV_LOOKUP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select SND_SIMPLE_CARD
 	help
 	 Say Y or M if you want to add support for I2S driver for
 	 Synopsys desigwnware I2S device. The device supports upto
diff --git a/sound/soc/dwc/Makefile b/sound/soc/dwc/Makefile
index 319371f..4d8f869 100644
--- a/sound/soc/dwc/Makefile
+++ b/sound/soc/dwc/Makefile
@@ -1,3 +1,3 @@
 # SYNOPSYS Platform Support
-obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_i2s.o
-
+obj-$(CONFIG_SND_DESIGNWARE_I2S) += dwc_i2s.o
+dwc_i2s-y := designware_i2s.o designware_pcm.o
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index bff258d..db9aced 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -25,6 +25,8 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
+#include "designware_pcm.h"
+
 /* common register for all channel */
 #define IER		0x000
 #define IRER		0x004
@@ -84,6 +86,11 @@
 #define MAX_CHANNEL_NUM		8
 #define MIN_CHANNEL_NUM		2
 
+/* PLL registers addresses */
+#define PLL_IDIV_ADDR	0xE00100A0
+#define PLL_FBDIV_ADDR 	0xE00100A4
+#define PLL_ODIV_ADDR	0xE00100A8
+
 union dw_i2s_snd_dma_data {
 	struct i2s_dma_data pd;
 	struct snd_dmaengine_dai_dma_data dt;
@@ -100,12 +107,32 @@ struct dw_i2s_dev {
 	struct device *dev;
 	u32 ccr;
 	u32 xfer_resolution;
+	u32 xfer_bytes;
+	u32 fifo_th;
 
 	/* data related to DMA transfers b/w i2s and DMAC */
 	union dw_i2s_snd_dma_data play_dma_data;
 	union dw_i2s_snd_dma_data capture_dma_data;
 	struct i2s_clk_config_data config;
 	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
+	int (*pcm_get)(u32 *lsample, u32 *rsample, int bytes, int buf_size);
+};
+
+struct dw_i2s_pll {
+	unsigned int rate;
+	unsigned int data_width;
+	unsigned int idiv;
+	unsigned int fbdiv;
+	unsigned int odiv;
+};
+
+static const struct dw_i2s_pll dw_i2s_pll_cfg[] = {
+	{ 32000, 16, 0x104, 0x451, 0x10E38 },	/* 32 kHz */
+	{ 32000, 32, 0x82, 0x451, 0x10E38 },
+	{ 44100, 16, 0x104, 0x596, 0x10D35},	/* 44.1 kHz */
+	{ 44100, 32, 0x82, 0x596, 0x10D35 },
+	{ 48000, 16, 0x208, 0xA28, 0x10B2C },	/* 48 kHz */
+	{ 48000, 32, 0x104, 0xA28, 0x10B2C },
 };
 
 static inline void i2s_write_reg(void __iomem *io_base, int reg, u32 val)
@@ -144,20 +171,72 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
 	}
 }
 
+static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
+{
+	struct dw_i2s_dev *dev = dev_id;
+	u32 isr[4], sleft[dev->fifo_th], sright[dev->fifo_th];
+	int i, j;
+
+	for (i = 0; i < 4; i++)
+		isr[i] = i2s_read_reg(dev->i2s_base, ISR(i));
+
+	for (i = 0; i < 4; i++) {
+		/* Copy only to first two channels.
+		   TODO: Remaining channels */
+		if ((isr[i] & 0x10) && (i == 0) && (dev->pcm_get)) {
+			/* TXFE - TX FIFO is empty */
+			dev->pcm_get(sleft, sright, dev->xfer_bytes,
+					dev->fifo_th);
+
+			for (j = 0; j < dev->fifo_th; j++) {
+				i2s_write_reg(dev->i2s_base, LRBR_LTHR(i),
+						sleft[j]);
+				i2s_write_reg(dev->i2s_base, RRBR_RTHR(i),
+						sright[j]);
+			}
+		}
+	}
+
+	i2s_clear_irqs(dev, SNDRV_PCM_STREAM_PLAYBACK);
+	i2s_clear_irqs(dev, SNDRV_PCM_STREAM_CAPTURE);
+
+	return IRQ_HANDLED;
+}
+
+static int i2s_pll_cfg(struct i2s_clk_config_data *config)
+{
+	u32 rate = config->sample_rate;
+	u32 data_width = config->data_width;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dw_i2s_pll_cfg); i++) {
+		if ((dw_i2s_pll_cfg[i].rate == rate) &&
+				(dw_i2s_pll_cfg[i].data_width == data_width)) {
+			writel(dw_i2s_pll_cfg[i].idiv, (void *)PLL_IDIV_ADDR);
+			writel(dw_i2s_pll_cfg[i].fbdiv, (void *)PLL_FBDIV_ADDR);
+			writel(dw_i2s_pll_cfg[i].odiv, (void *)PLL_ODIV_ADDR);
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
 static void i2s_start(struct dw_i2s_dev *dev,
 		      struct snd_pcm_substream *substream)
 {
+	struct i2s_clk_config_data *config = &dev->config;
 	u32 i, irq;
 	i2s_write_reg(dev->i2s_base, IER, 1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < (config->chan_nr / 2); i++) {
 			irq = i2s_read_reg(dev->i2s_base, IMR(i));
 			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x30);
 		}
 		i2s_write_reg(dev->i2s_base, ITER, 1);
 	} else {
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < (config->chan_nr / 2); i++) {
 			irq = i2s_read_reg(dev->i2s_base, IMR(i));
 			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x03);
 		}
@@ -231,14 +310,16 @@ static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
 				      dev->xfer_resolution);
-			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
+			i2s_write_reg(dev->i2s_base, TFCR(ch_reg),
+				      dev->fifo_th - 1);
 			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
 			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
 			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
 		} else {
 			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
 				      dev->xfer_resolution);
-			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
+			i2s_write_reg(dev->i2s_base, RFCR(ch_reg),
+				      dev->fifo_th - 1);
 			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
 			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
 			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
@@ -259,22 +340,25 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 		config->data_width = 16;
 		dev->ccr = 0x00;
 		dev->xfer_resolution = 0x02;
+		dev->xfer_bytes = 0x02;
 		break;
 
 	case SNDRV_PCM_FORMAT_S24_LE:
 		config->data_width = 24;
 		dev->ccr = 0x08;
 		dev->xfer_resolution = 0x04;
+		dev->xfer_bytes = 0x03;
 		break;
 
 	case SNDRV_PCM_FORMAT_S32_LE:
 		config->data_width = 32;
 		dev->ccr = 0x10;
 		dev->xfer_resolution = 0x05;
+		dev->xfer_bytes = 0x04;
 		break;
 
 	default:
-		dev_err(dev->dev, "designware-i2s: unsuppted PCM fmt");
+		dev_err(dev->dev, "designware-i2s: unsupported PCM fmt");
 		return -EINVAL;
 	}
 
@@ -611,6 +695,7 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 		dev->capture_dma_data.dt.maxburst = 16;
 	}
 
+	dev->fifo_th = fifo_depth / 2;
 	return 0;
 
 }
@@ -620,7 +705,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
 	struct dw_i2s_dev *dev;
 	struct resource *res;
-	int ret;
+	int ret, irq_number;
 	struct snd_soc_dai_driver *dw_i2s_dai;
 	const char *clk_id;
 
@@ -643,6 +728,19 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->i2s_base))
 		return PTR_ERR(dev->i2s_base);
 
+	irq_number = platform_get_irq(pdev, 0);
+	if (irq_number <= 0) {
+		dev_err(&pdev->dev, "get irq fail\n");
+		return -EINVAL;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq_number, i2s_irq_handler,
+			IRQF_SHARED, "dw_i2s_irq_handler", dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "request irq fail\n");
+		return ret;
+	}
+
 	dev->dev = &pdev->dev;
 
 	dev->i2s_reg_comp1 = I2S_COMP_PARAM_1;
@@ -671,14 +769,22 @@ static int dw_i2s_probe(struct platform_device *pdev)
 				return -ENODEV;
 			}
 		}
-		dev->clk = devm_clk_get(&pdev->dev, clk_id);
 
-		if (IS_ERR(dev->clk))
-			return PTR_ERR(dev->clk);
+		if (dev->i2s_clk_cfg ||
+				of_get_property(pdev->dev.of_node, "clocks", NULL)) {
+			dev->clk = devm_clk_get(&pdev->dev, clk_id);
+
+			if (IS_ERR(dev->clk))
+				return PTR_ERR(dev->clk);
 
-		ret = clk_prepare_enable(dev->clk);
-		if (ret < 0)
-			return ret;
+			ret = clk_prepare_enable(dev->clk);
+			if (ret < 0)
+				return ret;
+		} else {
+			/* Use internal PLL config */
+			dev->i2s_clk_cfg = i2s_pll_cfg;
+			dev->clk = NULL;
+		}
 	}
 
 	dev_set_drvdata(&pdev->dev, dev);
@@ -690,7 +796,14 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (!pdata) {
-		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+		if (of_get_property(pdev->dev.of_node, "dmas", NULL)) {
+			/* Using DMA */
+			ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+		} else {
+			ret = dw_pcm_platform_register(pdev);
+			dev->pcm_get = dw_pcm_platform_get;
+		}
+
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Could not register PCM: %d\n", ret);
diff --git a/sound/soc/dwc/designware_pcm.c b/sound/soc/dwc/designware_pcm.c
new file mode 100644
index 0000000..e1928b8
--- /dev/null
+++ b/sound/soc/dwc/designware_pcm.c
@@ -0,0 +1,264 @@
+/*
+ * ALSA Platform Synopsys Audio Layer
+ *
+ * sound/soc/dwc/designware_pcm.c
+ *
+ * Copyright (C) 2016 Synopsys
+ * Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Tiago Duarte
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+struct dw_pcm_binfo {
+	struct snd_pcm_substream *stream;
+	spinlock_t lock;
+	unsigned char *dma_base;
+	unsigned char *dma_pointer;
+	unsigned int period_size_frames;
+	unsigned int size;
+	snd_pcm_uframes_t period_pointer;
+	unsigned int total_periods;
+	unsigned int current_period;
+};
+
+static const struct snd_pcm_hardware dw_pcm_playback_hw = {
+	.info       = SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.rates      = SNDRV_PCM_RATE_32000 |
+			SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000,
+	.rate_min   = 32000,
+	.rate_max   = 48000,
+	.formats    = SNDRV_PCM_FMTBIT_S16_LE,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 1152000,
+	.period_bytes_min = 64000,
+	.period_bytes_max = 576000,
+	.periods_min      = 8,
+	.periods_max      = 18,
+};
+
+static struct dw_pcm_binfo *dw_pcm_bi;
+
+static int dw_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_pcm_binfo *bi;
+
+	snd_soc_set_runtime_hwparams(substream, &dw_pcm_playback_hw);
+	snd_pcm_hw_constraint_integer(rt, SNDRV_PCM_HW_PARAM_PERIODS);
+
+	bi = kzalloc(sizeof(*bi), GFP_KERNEL);
+	if (!bi)
+		return -ENOMEM;
+
+	dw_pcm_bi = bi;
+	spin_lock_init(&bi->lock);
+
+	rt->hw.rate_min = 32000;
+	rt->hw.rate_max = 48000;
+
+	spin_lock(&bi->lock);
+	bi->stream = substream;
+	rt->private_data = bi;
+	spin_unlock(&bi->lock);
+
+	return 0;
+}
+
+static int dw_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_pcm_binfo *bi = rt->private_data;
+
+	kfree(bi);
+	dw_pcm_bi = NULL;
+	return 0;
+}
+
+static int dw_pcm_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_pcm_binfo *bi = rt->private_data;
+	int ret;
+
+	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+			params_buffer_bytes(hw_params));
+	if (ret < 0)
+		return ret;
+
+	memset(rt->dma_area, 0, params_buffer_bytes(hw_params));
+
+	spin_lock(&bi->lock);
+	bi->dma_base = rt->dma_area;
+	bi->dma_pointer = bi->dma_base;
+	spin_unlock(&bi->lock);
+
+	return 0;
+}
+
+static int dw_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	int ret;
+
+	ret = snd_pcm_lib_free_vmalloc_buffer(substream);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int dw_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_pcm_binfo *bi = rt->private_data;
+	u32 buffer_size_frames = 0;
+
+	spin_lock(&bi->lock);
+	bi->period_size_frames = bytes_to_frames(rt,
+			snd_pcm_lib_period_bytes(substream));
+	bi->size = snd_pcm_lib_buffer_bytes(substream);
+	buffer_size_frames = bytes_to_frames(rt, bi->size);
+	bi->total_periods = buffer_size_frames / bi->period_size_frames;
+	bi->current_period = 1;
+	spin_unlock(&bi->lock);
+
+	if ((buffer_size_frames % bi->period_size_frames) != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dw_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t dw_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_pcm_binfo *bi = rt->private_data;
+
+	return bi->period_pointer;
+}
+
+static struct snd_pcm_ops dw_pcm_capture_ops = {
+	.open      = dw_pcm_open,
+	.close     = dw_pcm_close,
+	.ioctl     = snd_pcm_lib_ioctl,
+	.hw_params = dw_pcm_hw_params,
+	.hw_free   = dw_pcm_hw_free,
+	.prepare   = dw_pcm_prepare,
+	.trigger   = dw_pcm_trigger,
+	.pointer   = dw_pcm_pointer,
+	.page      = snd_pcm_lib_get_vmalloc_page,
+	.mmap      = snd_pcm_lib_mmap_vmalloc,
+};
+
+static int dw_pcm_new(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_pcm *pcm = runtime->pcm;
+	int ret;
+
+	ret =  snd_pcm_lib_preallocate_pages_for_all(pcm,
+			SNDRV_DMA_TYPE_DEV,
+			snd_dma_continuous_data(GFP_KERNEL),
+			dw_pcm_playback_hw.buffer_bytes_max,
+			dw_pcm_playback_hw.buffer_bytes_max);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void dw_pcm_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static struct snd_soc_platform_driver dw_pcm_soc_platform = {
+	.pcm_new  = dw_pcm_new,
+	.pcm_free = dw_pcm_free,
+	.ops = &dw_pcm_capture_ops,
+};
+
+int dw_pcm_platform_get(u32 *lsample, u32 *rsample, int bytes, int buf_size)
+{
+	struct snd_pcm_runtime *rt = NULL;
+	struct dw_pcm_binfo *bi = dw_pcm_bi;
+	int i;
+
+	if (!bi)
+		return -1;
+
+	rt = bi->stream->runtime;
+
+	spin_lock(&bi->lock);
+	for (i = 0; i < buf_size; i++) {
+		memcpy(&lsample[i], bi->dma_pointer, bytes);
+		memset(bi->dma_pointer, 0, bytes);
+		bi->dma_pointer += bytes;
+
+		memcpy(&rsample[i], bi->dma_pointer, bytes);
+		memset(bi->dma_pointer, 0, bytes);
+		bi->dma_pointer += bytes;
+	}
+	bi->period_pointer += bytes_to_frames(rt, bytes * 2 * buf_size);
+
+	if (bi->period_pointer >=
+			(bi->period_size_frames * bi->current_period)) {
+		bi->current_period++;
+		if (bi->current_period > bi->total_periods) {
+			bi->dma_pointer = bi->dma_base;
+			bi->period_pointer = 0;
+			bi->current_period = 1;
+		}
+
+		spin_unlock(&bi->lock);
+		snd_pcm_period_elapsed(bi->stream);
+		spin_lock(&bi->lock);
+	}
+
+	spin_unlock(&bi->lock);
+	return 0;
+}
+
+int dw_pcm_platform_register(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, &dw_pcm_soc_platform);
+}
+
+int dw_pcm_platform_unregister(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+MODULE_AUTHOR("Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Tiago Duarte");
+MODULE_DESCRIPTION("Synopsys PCM module");
+MODULE_LICENSE("GPL");
\ No newline at end of file
diff --git a/sound/soc/dwc/designware_pcm.h b/sound/soc/dwc/designware_pcm.h
new file mode 100644
index 0000000..20bf65b
--- /dev/null
+++ b/sound/soc/dwc/designware_pcm.h
@@ -0,0 +1,21 @@
+/*
+ * ALSA Platform Synopsys Audio Layer
+ *
+ * sound/soc/dwc/designware_pcm.h
+ *
+ * Copyright (C) 2016 Synopsys
+ * Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Tiago Duarte
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __DW_PCM_H
+#define __DW_PCM_H
+
+int dw_pcm_platform_get(u32 *lsample, u32 *rsample, int bytes, int buf_size);
+int dw_pcm_platform_register(struct platform_device *pdev);
+int dw_pcm_platform_unregister(struct platform_device *pdev);
+
+#endif /* __DW_PCM_H */
\ No newline at end of file
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
