From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/4] ASoC: dwc: Add I2S HDMI audio support using custom platform driver
Date: Mon, 28 Mar 2016 10:41:51 +0100
Message-ID: <7aaad0b57652fc724be7b447790c194645321173.1458839710.git.joabreu@synopsys.com>
References: <cover.1458839710.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1458839710.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1458839710.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1458839710.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, lgirdwoord-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, mjonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

HDMI audio support was added to the AXS board using an
I2S cpu driver and a custom platform driver.

The platform driver supports two channels @ 16 bits with
rates 32k, 44.1k and 48k. ALSA Simple audio card is used to
glue the cpu, platform and codec driver (adv7511).

Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 arch/arc/boot/dts/axs10x_mb.dtsi |  20 +-
 sound/soc/dwc/Kconfig            |   1 +
 sound/soc/dwc/designware_i2s.c   | 384 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 388 insertions(+), 17 deletions(-)

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
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index bff258d..b343c9f 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -84,11 +84,37 @@
 #define MAX_CHANNEL_NUM		8
 #define MIN_CHANNEL_NUM		2
 
+/* FPGA Version Info */
+#define FPGA_VER_INFO	0xE0011230
+#define FPGA_VER_27M	0x000FBED9
+
+/* PLL registers addresses */
+#define PLL_IDIV_ADDR	0xE00100A0
+#define PLL_FBDIV_ADDR	0xE00100A4
+#define PLL_ODIV0_ADDR	0xE00100A8
+#define PLL_ODIV1_ADDR	0xE00100AC
+
+/* PCM definitions */
+#define BUFFER_BYTES_MAX	384000
+#define PERIOD_BYTES_MIN	2048
+#define PERIODS_MIN		8
+
 union dw_i2s_snd_dma_data {
 	struct i2s_dma_data pd;
 	struct snd_dmaengine_dai_dma_data dt;
 };
 
+struct dw_pcm_binfo {
+	struct snd_pcm_substream *stream;
+	unsigned char *dma_base;
+	unsigned char *dma_pointer;
+	unsigned int period_size_frames;
+	unsigned int size;
+	snd_pcm_uframes_t period_pointer;
+	unsigned int total_periods;
+	unsigned int current_period;
+};
+
 struct dw_i2s_dev {
 	void __iomem *i2s_base;
 	struct clk *clk;
@@ -100,14 +126,103 @@ struct dw_i2s_dev {
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
+	struct dw_pcm_binfo binfo;
+};
+
+struct dw_i2s_pll {
+	unsigned int rate;
+	unsigned int data_width;
+	unsigned int idiv;
+	unsigned int fbdiv;
+	unsigned int odiv0;
+	unsigned int odiv1;
+};
+
+static const struct dw_i2s_pll dw_i2s_pll_cfg_27m[] = {
+	/* 27Mhz */
+	{ 32000, 16, 0x104, 0x451, 0x10E38, 0x2000 },
+	{ 44100, 16, 0x104, 0x596, 0x10D35, 0x2000 },
+	{ 48000, 16, 0x208, 0xA28, 0x10B2C, 0x2000 },
+	{ 0, 0, 0, 0, 0, 0 },
 };
 
+static const struct dw_i2s_pll dw_i2s_pll_cfg_28m[] = {
+	/* 28.224Mhz */
+	{ 32000, 16, 0x82, 0x105, 0x107DF, 0x2000 },
+	{ 44100, 16, 0x28A, 0x1, 0x10001, 0x2000 },
+	{ 48000, 16, 0xA28, 0x187, 0x10042, 0x2000 },
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static const struct snd_pcm_hardware dw_pcm_hw = {
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
+	.buffer_bytes_max = BUFFER_BYTES_MAX,
+	.period_bytes_min = PERIOD_BYTES_MIN,
+	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
+	.periods_min      = PERIODS_MIN,
+	.periods_max      = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
+};
+
+static int dw_pcm_transfer(u32 *lsample, u32 *rsample, int bytes, int buf_size,
+		struct dw_pcm_binfo *bi)
+{
+	struct snd_pcm_runtime *rt = NULL;
+	int i;
+
+	if (!bi)
+		return -EINVAL;
+
+	rt = bi->stream->runtime;
+
+	for (i = 0; i < buf_size; i++) {
+		if (bi->stream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			memcpy(&lsample[i], bi->dma_pointer, bytes);
+			bi->dma_pointer += bytes;
+			memcpy(&rsample[i], bi->dma_pointer, bytes);
+			bi->dma_pointer += bytes;
+		} else {
+			memcpy(bi->dma_pointer, &lsample[i], bytes);
+			bi->dma_pointer += bytes;
+			memcpy(bi->dma_pointer, &rsample[i], bytes);
+			bi->dma_pointer += bytes;
+		}
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
+		snd_pcm_period_elapsed(bi->stream);
+	}
+
+	return 0;
+}
+
 static inline void i2s_write_reg(void __iomem *io_base, int reg, u32 val)
 {
 	writel(val, io_base + reg);
@@ -144,20 +259,93 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
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
+		/* Copy only to/from first two channels.
+		   TODO: Remaining channels */
+		if ((isr[i] & 0x10) && (i == 0) && (dev->binfo.stream->stream ==
+					SNDRV_PCM_STREAM_PLAYBACK)) {
+			/* TXFE - TX FIFO is empty */
+			dw_pcm_transfer(sleft, sright, dev->xfer_bytes,
+					dev->fifo_th, &dev->binfo);
+
+			for (j = 0; j < dev->fifo_th; j++) {
+				i2s_write_reg(dev->i2s_base, LRBR_LTHR(i),
+						sleft[j]);
+				i2s_write_reg(dev->i2s_base, RRBR_RTHR(i),
+						sright[j]);
+			}
+		} else if ((isr[i] & 0x1) && (i == 0) &&
+					(dev->binfo.stream->stream ==
+					SNDRV_PCM_STREAM_CAPTURE)) {
+			/* RSFE - RX FIFO is full */
+			for (j = 0; j < dev->fifo_th; j++) {
+				sleft[j] = i2s_read_reg(dev->i2s_base,
+						LRBR_LTHR(i));
+				sright[j] = i2s_read_reg(dev->i2s_base,
+						RRBR_RTHR(i));
+			}
+
+			dw_pcm_transfer(sleft, sright, dev->xfer_bytes,
+					dev->fifo_th, &dev->binfo);
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
+	const struct dw_i2s_pll *pll_cfg;
+	u32 rate = config->sample_rate;
+	u32 data_width = config->data_width;
+	int i;
+
+	if (readl((void *)FPGA_VER_INFO) <= FPGA_VER_27M)
+		pll_cfg = dw_i2s_pll_cfg_27m;
+	else
+		pll_cfg = dw_i2s_pll_cfg_28m;
+
+	for (i = 0; pll_cfg[i].rate != 0; i++) {
+		if ((pll_cfg[i].rate == rate) &&
+				(pll_cfg[i].data_width == data_width)) {
+			writel(pll_cfg[i].idiv, (void *)PLL_IDIV_ADDR);
+			writel(pll_cfg[i].fbdiv, (void *)PLL_FBDIV_ADDR);
+			writel(pll_cfg[i].odiv0, (void *)PLL_ODIV0_ADDR);
+			writel(pll_cfg[i].odiv1, (void *)PLL_ODIV1_ADDR);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
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
@@ -195,6 +383,139 @@ static void i2s_stop(struct dw_i2s_dev *dev,
 	}
 }
 
+static int dw_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	snd_soc_set_runtime_hwparams(substream, &dw_pcm_hw);
+	snd_pcm_hw_constraint_integer(rt, SNDRV_PCM_HW_PARAM_PERIODS);
+
+	rt->hw.rate_min = 32000;
+	rt->hw.rate_max = 48000;
+
+	dev->binfo.stream = substream;
+	rt->private_data = &dev->binfo;
+	return 0;
+}
+
+static int dw_pcm_close(struct snd_pcm_substream *substream)
+{
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
+	bi->dma_base = rt->dma_area;
+	bi->dma_pointer = bi->dma_base;
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
+	bi->period_size_frames = bytes_to_frames(rt,
+			snd_pcm_lib_period_bytes(substream));
+	bi->size = snd_pcm_lib_buffer_bytes(substream);
+	buffer_size_frames = bytes_to_frames(rt, bi->size);
+	bi->total_periods = buffer_size_frames / bi->period_size_frames;
+	bi->current_period = 1;
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
+static struct snd_pcm_ops dw_pcm_ops = {
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
+			dw_pcm_hw.buffer_bytes_max,
+			dw_pcm_hw.buffer_bytes_max);
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
+	.ops = &dw_pcm_ops,
+};
+
 static int dw_i2s_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai)
 {
@@ -231,14 +552,16 @@ static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
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
@@ -259,22 +582,25 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
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
 
@@ -316,6 +642,7 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 			}
 		}
 	}
+
 	return 0;
 }
 
@@ -498,6 +825,7 @@ static int dw_configure_dai(struct dw_i2s_dev *dev,
 	 */
 	u32 comp1 = i2s_read_reg(dev->i2s_base, dev->i2s_reg_comp1);
 	u32 comp2 = i2s_read_reg(dev->i2s_base, dev->i2s_reg_comp2);
+	u32 fifo_depth = 1 << (1 + COMP1_FIFO_DEPTH_GLOBAL(comp1));
 	u32 idx;
 
 	if (dev->capability & DWC_I2S_RECORD &&
@@ -536,6 +864,7 @@ static int dw_configure_dai(struct dw_i2s_dev *dev,
 		dev->capability |= DW_I2S_SLAVE;
 	}
 
+	dev->fifo_th = fifo_depth / 2;
 	return 0;
 }
 
@@ -620,7 +949,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
 	struct dw_i2s_dev *dev;
 	struct resource *res;
-	int ret;
+	int ret, irq_number;
 	struct snd_soc_dai_driver *dw_i2s_dai;
 	const char *clk_id;
 
@@ -643,6 +972,19 @@ static int dw_i2s_probe(struct platform_device *pdev)
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
@@ -671,14 +1013,22 @@ static int dw_i2s_probe(struct platform_device *pdev)
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
@@ -690,7 +1040,14 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (!pdata) {
-		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+		if (of_get_property(pdev->dev.of_node, "dmas", NULL)) {
+			/* Using DMA */
+			ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+		} else {
+			ret = snd_soc_register_platform(&pdev->dev,
+					&dw_pcm_soc_platform);
+		}
+
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Could not register PCM: %d\n", ret);
@@ -714,6 +1071,7 @@ static int dw_i2s_remove(struct platform_device *pdev)
 		clk_disable_unprepare(dev->clk);
 
 	pm_runtime_disable(&pdev->dev);
+	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
 }
 
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
