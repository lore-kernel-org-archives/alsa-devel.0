From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hisilicon: Add hi6210 i2s audio driver"
	to the asoc tree
Date: Mon, 10 Apr 2017 19:42:42 +0100
Message-ID: <E1cxeGw-0003ou-PJ@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4F66266BA4
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 20:42:52 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Green <andy.green@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hisilicon: Add hi6210 i2s audio driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0bf750f4cbe1406d8819cbec2a3ff6beeb824617 Mon Sep 17 00:00:00 2001
From: Andy Green <andy.green@linaro.org>
Date: Fri, 31 Mar 2017 15:06:00 -0700
Subject: [PATCH] ASoC: hisilicon: Add hi6210 i2s audio driver

Add driver for hi6210 i2s controller found on hi6220 boards.

Signed-off-by: Andy Green <andy.green@linaro.org>
[jstultz: Forward ported to mainline, fairly major rework
 based on suggestions from Mark Brown]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig                |   1 +
 sound/soc/Makefile               |   1 +
 sound/soc/hisilicon/Kconfig      |   5 +
 sound/soc/hisilicon/Makefile     |   1 +
 sound/soc/hisilicon/hi6210-i2s.c | 628 +++++++++++++++++++++++++++++++++++++++
 sound/soc/hisilicon/hi6210-i2s.h | 276 +++++++++++++++++
 6 files changed, 912 insertions(+)
 create mode 100644 sound/soc/hisilicon/Kconfig
 create mode 100644 sound/soc/hisilicon/Makefile
 create mode 100644 sound/soc/hisilicon/hi6210-i2s.c
 create mode 100644 sound/soc/hisilicon/hi6210-i2s.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 182d92efc7c8..9df9658b552b 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -47,6 +47,7 @@ source "sound/soc/cirrus/Kconfig"
 source "sound/soc/davinci/Kconfig"
 source "sound/soc/dwc/Kconfig"
 source "sound/soc/fsl/Kconfig"
+source "sound/soc/hisilicon/Kconfig"
 source "sound/soc/jz4740/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 9a30f21d16ee..2f6aabb8b4c3 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SND_SOC)	+= cirrus/
 obj-$(CONFIG_SND_SOC)	+= davinci/
 obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= fsl/
+obj-$(CONFIG_SND_SOC)	+= hisilicon/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
 obj-$(CONFIG_SND_SOC)	+= img/
 obj-$(CONFIG_SND_SOC)	+= intel/
diff --git a/sound/soc/hisilicon/Kconfig b/sound/soc/hisilicon/Kconfig
new file mode 100644
index 000000000000..4356d5a1d338
--- /dev/null
+++ b/sound/soc/hisilicon/Kconfig
@@ -0,0 +1,5 @@
+config SND_I2S_HI6210_I2S
+	tristate "Hisilicon I2S controller"
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Hisilicon I2S
diff --git a/sound/soc/hisilicon/Makefile b/sound/soc/hisilicon/Makefile
new file mode 100644
index 000000000000..e8095e2af91a
--- /dev/null
+++ b/sound/soc/hisilicon/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SND_I2S_HI6210_I2S) += hi6210-i2s.o
diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
new file mode 100644
index 000000000000..45691b70060c
--- /dev/null
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -0,0 +1,628 @@
+/*
+ * linux/sound/soc/m8m/hi6210_i2s.c - I2S IP driver
+ *
+ * Copyright (C) 2015 Linaro, Ltd
+ * Author: Andy Green <andy.green@linaro.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This driver only deals with S2 interface (BT)
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <linux/interrupt.h>
+#include <linux/reset.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/reset-controller.h>
+#include <linux/clk.h>
+
+#include "hi6210-i2s.h"
+
+struct hi6210_i2s {
+	struct device *dev;
+	struct reset_control *rc;
+	struct clk *clk[8];
+	int clocks;
+	struct snd_soc_dai_driver dai;
+	void __iomem *base;
+	struct regmap *sysctrl;
+	phys_addr_t base_phys;
+	struct snd_dmaengine_dai_dma_data dma_data[2];
+	int clk_rate;
+	spinlock_t lock;
+	int rate;
+	int format;
+	u8 bits;
+	u8 channels;
+	u8 id;
+	u8 channel_length;
+	u8 use;
+	u32 master:1;
+	u32 status:1;
+};
+
+#define SC_PERIPH_CLKEN1	0x210
+#define SC_PERIPH_CLKDIS1	0x214
+
+#define SC_PERIPH_CLKEN3	0x230
+#define SC_PERIPH_CLKDIS3	0x234
+
+#define SC_PERIPH_CLKEN12	0x270
+#define SC_PERIPH_CLKDIS12	0x274
+
+#define SC_PERIPH_RSTEN1	0x310
+#define SC_PERIPH_RSTDIS1	0x314
+#define SC_PERIPH_RSTSTAT1	0x318
+
+#define SC_PERIPH_RSTEN2	0x320
+#define SC_PERIPH_RSTDIS2	0x324
+#define SC_PERIPH_RSTSTAT2	0x328
+
+#define SOC_PMCTRL_BBPPLLALIAS	0x48
+
+enum {
+	CLK_DACODEC,
+	CLK_I2S_BASE,
+};
+
+static inline void hi6210_write_reg(struct hi6210_i2s *i2s, int reg, u32 val)
+{
+	writel(val, i2s->base + reg);
+}
+
+static inline u32 hi6210_read_reg(struct hi6210_i2s *i2s, int reg)
+{
+	return readl(i2s->base + reg);
+}
+
+int hi6210_i2s_startup(struct snd_pcm_substream *substream,
+		     struct snd_soc_dai *cpu_dai)
+{
+	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
+	int ret, n;
+	u32 val;
+
+	/* deassert reset on ABB */
+	regmap_read(i2s->sysctrl, SC_PERIPH_RSTSTAT2, &val);
+	if (val & BIT(4))
+		regmap_write(i2s->sysctrl, SC_PERIPH_RSTDIS2, BIT(4));
+
+	for (n = 0; n < i2s->clocks; n++) {
+		ret = clk_prepare_enable(i2s->clk[n]);
+		if (ret) {
+			while (n--)
+				clk_disable_unprepare(i2s->clk[n]);
+			return ret;
+		}
+	}
+
+	ret = clk_set_rate(i2s->clk[CLK_I2S_BASE], 49152000);
+	if (ret) {
+		dev_err(i2s->dev, "%s: setting 49.152MHz base rate failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* enable clock before frequency division */
+	regmap_write(i2s->sysctrl, SC_PERIPH_CLKEN12, BIT(9));
+
+	/* enable codec working clock / == "codec bus clock" */
+	regmap_write(i2s->sysctrl, SC_PERIPH_CLKEN1, BIT(5));
+
+	/* deassert reset on codec / interface clock / working clock */
+	regmap_write(i2s->sysctrl, SC_PERIPH_RSTEN1, BIT(5));
+	regmap_write(i2s->sysctrl, SC_PERIPH_RSTDIS1, BIT(5));
+
+	/* not interested in i2s irqs */
+	val = hi6210_read_reg(i2s, HII2S_CODEC_IRQ_MASK);
+	val |= 0x3f;
+	hi6210_write_reg(i2s, HII2S_CODEC_IRQ_MASK, val);
+
+
+	/* reset the stereo downlink fifo */
+	val = hi6210_read_reg(i2s, HII2S_APB_AFIFO_CFG_1);
+	val |= (BIT(5) | BIT(4));
+	hi6210_write_reg(i2s, HII2S_APB_AFIFO_CFG_1, val);
+
+	val = hi6210_read_reg(i2s, HII2S_APB_AFIFO_CFG_1);
+	val &= ~(BIT(5) | BIT(4));
+	hi6210_write_reg(i2s, HII2S_APB_AFIFO_CFG_1, val);
+
+
+	val = hi6210_read_reg(i2s, HII2S_SW_RST_N);
+	val &= ~(HII2S_SW_RST_N__ST_DL_WORDLEN_MASK <<
+			HII2S_SW_RST_N__ST_DL_WORDLEN_SHIFT);
+	val |= (HII2S_BITS_16 << HII2S_SW_RST_N__ST_DL_WORDLEN_SHIFT);
+	hi6210_write_reg(i2s, HII2S_SW_RST_N, val);
+
+	val = hi6210_read_reg(i2s, HII2S_MISC_CFG);
+	/* mux 11/12 = APB not i2s */
+	val &= ~HII2S_MISC_CFG__ST_DL_TEST_SEL;
+	/* BT R ch  0 = mixer op of DACR ch */
+	val &= ~HII2S_MISC_CFG__S2_DOUT_RIGHT_SEL;
+	val &= ~HII2S_MISC_CFG__S2_DOUT_TEST_SEL;
+
+	val |= HII2S_MISC_CFG__S2_DOUT_RIGHT_SEL;
+	/* BT L ch = 1 = mux 7 = "mixer output of DACL */
+	val |= HII2S_MISC_CFG__S2_DOUT_TEST_SEL;
+	hi6210_write_reg(i2s, HII2S_MISC_CFG, val);
+
+	val = hi6210_read_reg(i2s, HII2S_SW_RST_N);
+	val |= HII2S_SW_RST_N__SW_RST_N;
+	hi6210_write_reg(i2s, HII2S_SW_RST_N, val);
+
+	return 0;
+}
+void hi6210_i2s_shutdown(struct snd_pcm_substream *substream,
+		       struct snd_soc_dai *cpu_dai)
+{
+	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
+	int n;
+
+	for (n = 0; n < i2s->clocks; n++)
+		clk_disable_unprepare(i2s->clk[n]);
+
+	regmap_write(i2s->sysctrl, SC_PERIPH_RSTEN1, BIT(5));
+}
+
+static void hi6210_i2s_txctrl(struct snd_soc_dai *cpu_dai, int on)
+{
+	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
+	u32 val;
+
+	spin_lock(&i2s->lock);
+	if (on) {
+		/* enable S2 TX */
+		val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+		val |= HII2S_I2S_CFG__S2_IF_TX_EN;
+		hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+	} else {
+		/* disable S2 TX */
+		val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+		val &= ~HII2S_I2S_CFG__S2_IF_TX_EN;
+		hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+	}
+	spin_unlock(&i2s->lock);
+}
+
+static void hi6210_i2s_rxctrl(struct snd_soc_dai *cpu_dai, int on)
+{
+	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
+	u32 val;
+
+	spin_lock(&i2s->lock);
+	if (on) {
+		val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+		val |= HII2S_I2S_CFG__S2_IF_RX_EN;
+		hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+	} else {
+		val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+		val &= ~HII2S_I2S_CFG__S2_IF_RX_EN;
+		hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+	}
+	spin_unlock(&i2s->lock);
+}
+
+static int hi6210_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
+
+	/*
+	 * We don't actually set the hardware until the hw_params
+	 * call, but we need to validate the user input here.
+	 */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	i2s->format = fmt;
+	i2s->master = (i2s->format & SND_SOC_DAIFMT_MASTER_MASK) ==
+		      SND_SOC_DAIFMT_CBS_CFS;
+
+	return 0;
+}
+
+static int hi6210_i2s_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *cpu_dai)
+{
+	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
+	u32 bits = 0, rate = 0, signed_data = 0, fmt = 0;
+	u32 val;
+	struct snd_dmaengine_dai_dma_data *dma_data;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U16_LE:
+		signed_data = HII2S_I2S_CFG__S2_CODEC_DATA_FORMAT;
+		/* fallthru */
+	case SNDRV_PCM_FORMAT_S16_LE:
+		bits = HII2S_BITS_16;
+		break;
+	case SNDRV_PCM_FORMAT_U24_LE:
+		signed_data = HII2S_I2S_CFG__S2_CODEC_DATA_FORMAT;
+		/* fallthru */
+	case SNDRV_PCM_FORMAT_S24_LE:
+		bits = HII2S_BITS_24;
+		break;
+	default:
+		dev_err(cpu_dai->dev, "Bad format\n");
+		return -EINVAL;
+	}
+
+
+	switch (params_rate(params)) {
+	case 8000:
+		rate = HII2S_FS_RATE_8KHZ;
+		break;
+	case 16000:
+		rate = HII2S_FS_RATE_16KHZ;
+		break;
+	case 32000:
+		rate = HII2S_FS_RATE_32KHZ;
+		break;
+	case 48000:
+		rate = HII2S_FS_RATE_48KHZ;
+		break;
+	case 96000:
+		rate = HII2S_FS_RATE_96KHZ;
+		break;
+	case 192000:
+		rate = HII2S_FS_RATE_192KHZ;
+		break;
+	default:
+		dev_err(cpu_dai->dev, "Bad rate: %d\n", params_rate(params));
+		return -EINVAL;
+	}
+
+	if (!(params_channels(params))) {
+		dev_err(cpu_dai->dev, "Bad channels\n");
+		return -EINVAL;
+	}
+
+	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
+
+	switch (bits) {
+	case HII2S_BITS_24:
+		i2s->bits = 32;
+		dma_data->addr_width = 3;
+		break;
+	default:
+		i2s->bits = 16;
+		dma_data->addr_width = 2;
+	}
+	i2s->rate = params_rate(params);
+	i2s->channels = params_channels(params);
+	i2s->channel_length = i2s->channels * i2s->bits;
+
+	val = hi6210_read_reg(i2s, HII2S_ST_DL_FIFO_TH_CFG);
+	val &= ~((HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AEMPTY_MASK <<
+			HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AEMPTY_SHIFT) |
+		(HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AFULL_MASK <<
+			HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AFULL_SHIFT) |
+		(HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AEMPTY_MASK <<
+			HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AEMPTY_SHIFT) |
+		(HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AFULL_MASK <<
+			HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AFULL_SHIFT));
+	val |= ((16 << HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AEMPTY_SHIFT) |
+		(30 << HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AFULL_SHIFT) |
+		(16 << HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AEMPTY_SHIFT) |
+		(30 << HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AFULL_SHIFT));
+	hi6210_write_reg(i2s, HII2S_ST_DL_FIFO_TH_CFG, val);
+
+
+	val = hi6210_read_reg(i2s, HII2S_IF_CLK_EN_CFG);
+	val |= (BIT(19) | BIT(18) | BIT(17) |
+		HII2S_IF_CLK_EN_CFG__S2_IF_CLK_EN |
+		HII2S_IF_CLK_EN_CFG__S2_OL_MIXER_EN |
+		HII2S_IF_CLK_EN_CFG__S2_OL_SRC_EN |
+		HII2S_IF_CLK_EN_CFG__ST_DL_R_EN |
+		HII2S_IF_CLK_EN_CFG__ST_DL_L_EN);
+	hi6210_write_reg(i2s, HII2S_IF_CLK_EN_CFG, val);
+
+
+	val = hi6210_read_reg(i2s, HII2S_DIG_FILTER_CLK_EN_CFG);
+	val &= ~(HII2S_DIG_FILTER_CLK_EN_CFG__DACR_SDM_EN |
+		 HII2S_DIG_FILTER_CLK_EN_CFG__DACR_HBF2I_EN |
+		 HII2S_DIG_FILTER_CLK_EN_CFG__DACR_AGC_EN |
+		 HII2S_DIG_FILTER_CLK_EN_CFG__DACL_SDM_EN |
+		 HII2S_DIG_FILTER_CLK_EN_CFG__DACL_HBF2I_EN |
+		 HII2S_DIG_FILTER_CLK_EN_CFG__DACL_AGC_EN);
+	val |= (HII2S_DIG_FILTER_CLK_EN_CFG__DACR_MIXER_EN |
+		HII2S_DIG_FILTER_CLK_EN_CFG__DACL_MIXER_EN);
+	hi6210_write_reg(i2s, HII2S_DIG_FILTER_CLK_EN_CFG, val);
+
+
+	val = hi6210_read_reg(i2s, HII2S_DIG_FILTER_MODULE_CFG);
+	val &= ~(HII2S_DIG_FILTER_MODULE_CFG__DACR_MIXER_IN2_MUTE |
+		 HII2S_DIG_FILTER_MODULE_CFG__DACL_MIXER_IN2_MUTE);
+	hi6210_write_reg(i2s, HII2S_DIG_FILTER_MODULE_CFG, val);
+
+	val = hi6210_read_reg(i2s, HII2S_MUX_TOP_MODULE_CFG);
+	val &= ~(HII2S_MUX_TOP_MODULE_CFG__S2_OL_MIXER_IN1_MUTE |
+		 HII2S_MUX_TOP_MODULE_CFG__S2_OL_MIXER_IN2_MUTE |
+		 HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_MIXER_IN1_MUTE |
+		 HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_MIXER_IN2_MUTE);
+	hi6210_write_reg(i2s, HII2S_MUX_TOP_MODULE_CFG, val);
+
+
+	switch (i2s->format & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		i2s->master = false;
+		val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+		val |= HII2S_I2S_CFG__S2_MST_SLV;
+		hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s->master = true;
+		val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+		val &= ~HII2S_I2S_CFG__S2_MST_SLV;
+		hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+		break;
+	default:
+		WARN_ONCE(1, "Invalid i2s->fmt MASTER_MASK. This shouldn't happen\n");
+	}
+
+	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		fmt = HII2S_FORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		fmt = HII2S_FORMAT_LEFT_JUST;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		fmt = HII2S_FORMAT_RIGHT_JUST;
+		break;
+	default:
+		WARN_ONCE(1, "Invalid i2s->fmt FORMAT_MASK. This shouldn't happen\n");
+	}
+
+	val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+	val &= ~(HII2S_I2S_CFG__S2_FUNC_MODE_MASK <<
+			HII2S_I2S_CFG__S2_FUNC_MODE_SHIFT);
+	val |= fmt << HII2S_I2S_CFG__S2_FUNC_MODE_SHIFT;
+	hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+
+
+	val = hi6210_read_reg(i2s, HII2S_CLK_SEL);
+	val &= ~(HII2S_CLK_SEL__I2S_BT_FM_SEL | /* BT gets the I2S */
+			HII2S_CLK_SEL__EXT_12_288MHZ_SEL);
+	hi6210_write_reg(i2s, HII2S_CLK_SEL, val);
+
+	dma_data->maxburst = 2;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data->addr = i2s->base_phys + HII2S_ST_DL_CHANNEL;
+	else
+		dma_data->addr = i2s->base_phys + HII2S_STEREO_UPLINK_CHANNEL;
+
+	switch (i2s->channels) {
+	case 1:
+		val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+		val |= HII2S_I2S_CFG__S2_FRAME_MODE;
+		hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+		break;
+	default:
+		val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+		val &= ~HII2S_I2S_CFG__S2_FRAME_MODE;
+		hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+	}
+
+	/* clear loopback, set signed type and word length */
+	val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
+	val &= ~HII2S_I2S_CFG__S2_CODEC_DATA_FORMAT;
+	val &= ~(HII2S_I2S_CFG__S2_CODEC_IO_WORDLENGTH_MASK <<
+			HII2S_I2S_CFG__S2_CODEC_IO_WORDLENGTH_SHIFT);
+	val &= ~(HII2S_I2S_CFG__S2_DIRECT_LOOP_MASK <<
+			HII2S_I2S_CFG__S2_DIRECT_LOOP_SHIFT);
+	val |= signed_data;
+	val |= (bits << HII2S_I2S_CFG__S2_CODEC_IO_WORDLENGTH_SHIFT);
+	hi6210_write_reg(i2s, HII2S_I2S_CFG, val);
+
+
+	if (!i2s->master)
+		return 0;
+
+	/* set DAC and related units to correct rate */
+	val = hi6210_read_reg(i2s, HII2S_FS_CFG);
+	val &= ~(HII2S_FS_CFG__FS_S2_MASK << HII2S_FS_CFG__FS_S2_SHIFT);
+	val &= ~(HII2S_FS_CFG__FS_DACLR_MASK << HII2S_FS_CFG__FS_DACLR_SHIFT);
+	val &= ~(HII2S_FS_CFG__FS_ST_DL_R_MASK <<
+					HII2S_FS_CFG__FS_ST_DL_R_SHIFT);
+	val &= ~(HII2S_FS_CFG__FS_ST_DL_L_MASK <<
+					HII2S_FS_CFG__FS_ST_DL_L_SHIFT);
+	val |= (rate << HII2S_FS_CFG__FS_S2_SHIFT);
+	val |= (rate << HII2S_FS_CFG__FS_DACLR_SHIFT);
+	val |= (rate << HII2S_FS_CFG__FS_ST_DL_R_SHIFT);
+	val |= (rate << HII2S_FS_CFG__FS_ST_DL_L_SHIFT);
+	hi6210_write_reg(i2s, HII2S_FS_CFG, val);
+
+	return 0;
+}
+
+static int hi6210_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			  struct snd_soc_dai *cpu_dai)
+{
+	pr_debug("%s\n", __func__);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			hi6210_i2s_rxctrl(cpu_dai, 1);
+		else
+			hi6210_i2s_txctrl(cpu_dai, 1);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			hi6210_i2s_rxctrl(cpu_dai, 0);
+		else
+			hi6210_i2s_txctrl(cpu_dai, 0);
+		break;
+	default:
+		dev_err(cpu_dai->dev, "uknown cmd\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int hi6210_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct hi6210_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai,
+				  &i2s->dma_data[SNDRV_PCM_STREAM_PLAYBACK],
+				  &i2s->dma_data[SNDRV_PCM_STREAM_CAPTURE]);
+
+	return 0;
+}
+
+
+static struct snd_soc_dai_ops hi6210_i2s_dai_ops = {
+	.trigger	= hi6210_i2s_trigger,
+	.hw_params	= hi6210_i2s_hw_params,
+	.set_fmt	= hi6210_i2s_set_fmt,
+	.startup	= hi6210_i2s_startup,
+	.shutdown	= hi6210_i2s_shutdown,
+};
+
+struct snd_soc_dai_driver hi6210_i2s_dai_init = {
+	.probe		= hi6210_i2s_dai_probe,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_U16_LE,
+		.rates = SNDRV_PCM_RATE_48000,
+	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_U16_LE,
+		.rates = SNDRV_PCM_RATE_48000,
+	},
+	.ops = &hi6210_i2s_dai_ops,
+};
+
+static const struct snd_soc_component_driver hi6210_i2s_i2s_comp = {
+	.name = "hi6210_i2s-i2s",
+};
+
+static int hi6210_i2s_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct hi6210_i2s *i2s;
+	struct resource *res;
+	int ret;
+
+	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
+	if (!i2s)
+		return -ENOMEM;
+
+	i2s->dev = dev;
+	spin_lock_init(&i2s->lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	i2s->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(i2s->base))
+		return PTR_ERR(i2s->base);
+
+	i2s->base_phys = (phys_addr_t)res->start;
+	i2s->dai = hi6210_i2s_dai_init;
+
+	dev_set_drvdata(&pdev->dev, i2s);
+
+	i2s->sysctrl = syscon_regmap_lookup_by_phandle(node,
+						"hisilicon,sysctrl-syscon");
+	if (IS_ERR(i2s->sysctrl))
+		return PTR_ERR(i2s->sysctrl);
+
+	i2s->clk[CLK_DACODEC] = devm_clk_get(&pdev->dev, "dacodec");
+	if (IS_ERR_OR_NULL(i2s->clk[CLK_DACODEC]))
+		return PTR_ERR(i2s->clk[CLK_DACODEC]);
+	i2s->clocks++;
+
+	i2s->clk[CLK_I2S_BASE] = devm_clk_get(&pdev->dev, "i2s-base");
+	if (IS_ERR_OR_NULL(i2s->clk[CLK_I2S_BASE]))
+		return PTR_ERR(i2s->clk[CLK_I2S_BASE]);
+	i2s->clocks++;
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_register_component(&pdev->dev, &hi6210_i2s_i2s_comp,
+					 &i2s->dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register dai\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hi6210_i2s_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_component(&pdev->dev);
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id hi6210_i2s_dt_ids[] = {
+	{ .compatible = "hisilicon,hi6210-i2s" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, hi6210_i2s_dt_ids);
+
+static struct platform_driver hi6210_i2s_driver = {
+	.probe = hi6210_i2s_probe,
+	.remove = hi6210_i2s_remove,
+	.driver = {
+		.name = "hi6210_i2s",
+		.of_match_table = hi6210_i2s_dt_ids,
+	},
+};
+
+module_platform_driver(hi6210_i2s_driver);
+
+MODULE_DESCRIPTION("Hisilicon HI6210 I2S driver");
+MODULE_AUTHOR("Andy Green <andy.green@linaro.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/hisilicon/hi6210-i2s.h b/sound/soc/hisilicon/hi6210-i2s.h
new file mode 100644
index 000000000000..85cecc4939a0
--- /dev/null
+++ b/sound/soc/hisilicon/hi6210-i2s.h
@@ -0,0 +1,276 @@
+/*
+ * linux/sound/soc/hisilicon/hi6210-i2s.h
+ *
+ * Copyright (C) 2015 Linaro, Ltd
+ * Author: Andy Green <andy.green@linaro.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Note at least on 6220, S2 == BT, S1 == Digital FM Radio IF
+ */
+
+#ifndef _HI6210_I2S_H
+#define _HI6210_I2S_H
+
+#define HII2S_SW_RST_N				0
+
+#define HII2S_SW_RST_N__STEREO_UPLINK_WORDLEN_SHIFT			28
+#define HII2S_SW_RST_N__STEREO_UPLINK_WORDLEN_MASK			3
+#define HII2S_SW_RST_N__THIRDMD_UPLINK_WORDLEN_SHIFT			26
+#define HII2S_SW_RST_N__THIRDMD_UPLINK_WORDLEN_MASK			3
+#define HII2S_SW_RST_N__VOICE_UPLINK_WORDLEN_SHIFT			24
+#define HII2S_SW_RST_N__VOICE_UPLINK_WORDLEN_MASK			3
+#define HII2S_SW_RST_N__ST_DL_WORDLEN_SHIFT				20
+#define HII2S_SW_RST_N__ST_DL_WORDLEN_MASK				3
+#define HII2S_SW_RST_N__THIRDMD_DLINK_WORDLEN_SHIFT			18
+#define HII2S_SW_RST_N__THIRDMD_DLINK_WORDLEN_MASK			3
+#define HII2S_SW_RST_N__VOICE_DLINK_WORDLEN_SHIFT			16
+#define HII2S_SW_RST_N__VOICE_DLINK_WORDLEN_MASK			3
+
+#define HII2S_SW_RST_N__SW_RST_N					BIT(0)
+
+enum hi6210_bits {
+	HII2S_BITS_16,
+	HII2S_BITS_18,
+	HII2S_BITS_20,
+	HII2S_BITS_24,
+};
+
+
+#define HII2S_IF_CLK_EN_CFG			4
+
+#define HII2S_IF_CLK_EN_CFG__THIRDMD_UPLINK_EN				BIT(25)
+#define HII2S_IF_CLK_EN_CFG__THIRDMD_DLINK_EN				BIT(24)
+#define HII2S_IF_CLK_EN_CFG__S3_IF_CLK_EN				BIT(20)
+#define HII2S_IF_CLK_EN_CFG__S2_IF_CLK_EN				BIT(16)
+#define HII2S_IF_CLK_EN_CFG__S2_OL_MIXER_EN				BIT(15)
+#define HII2S_IF_CLK_EN_CFG__S2_OL_SRC_EN				BIT(14)
+#define HII2S_IF_CLK_EN_CFG__S2_IR_PGA_EN				BIT(13)
+#define HII2S_IF_CLK_EN_CFG__S2_IL_PGA_EN				BIT(12)
+#define HII2S_IF_CLK_EN_CFG__S1_IR_PGA_EN				BIT(10)
+#define HII2S_IF_CLK_EN_CFG__S1_IL_PGA_EN				BIT(9)
+#define HII2S_IF_CLK_EN_CFG__S1_IF_CLK_EN				BIT(8)
+#define HII2S_IF_CLK_EN_CFG__VOICE_DLINK_SRC_EN				BIT(7)
+#define HII2S_IF_CLK_EN_CFG__VOICE_DLINK_EN				BIT(6)
+#define HII2S_IF_CLK_EN_CFG__ST_DL_R_EN					BIT(5)
+#define HII2S_IF_CLK_EN_CFG__ST_DL_L_EN					BIT(4)
+#define HII2S_IF_CLK_EN_CFG__VOICE_UPLINK_R_EN				BIT(3)
+#define HII2S_IF_CLK_EN_CFG__VOICE_UPLINK_L_EN				BIT(2)
+#define HII2S_IF_CLK_EN_CFG__STEREO_UPLINK_R_EN				BIT(1)
+#define HII2S_IF_CLK_EN_CFG__STEREO_UPLINK_L_EN				BIT(0)
+
+#define HII2S_DIG_FILTER_CLK_EN_CFG		8
+#define HII2S_DIG_FILTER_CLK_EN_CFG__DACR_SDM_EN			BIT(30)
+#define HII2S_DIG_FILTER_CLK_EN_CFG__DACR_HBF2I_EN			BIT(28)
+#define HII2S_DIG_FILTER_CLK_EN_CFG__DACR_MIXER_EN			BIT(25)
+#define HII2S_DIG_FILTER_CLK_EN_CFG__DACR_AGC_EN			BIT(24)
+#define HII2S_DIG_FILTER_CLK_EN_CFG__DACL_SDM_EN			BIT(22)
+#define HII2S_DIG_FILTER_CLK_EN_CFG__DACL_HBF2I_EN			BIT(20)
+#define HII2S_DIG_FILTER_CLK_EN_CFG__DACL_MIXER_EN			BIT(17)
+#define HII2S_DIG_FILTER_CLK_EN_CFG__DACL_AGC_EN			BIT(16)
+
+#define HII2S_FS_CFG				0xc
+
+#define HII2S_FS_CFG__FS_S2_SHIFT					28
+#define HII2S_FS_CFG__FS_S2_MASK					7
+#define HII2S_FS_CFG__FS_S1_SHIFT					24
+#define HII2S_FS_CFG__FS_S1_MASK					7
+#define HII2S_FS_CFG__FS_ADCLR_SHIFT					20
+#define HII2S_FS_CFG__FS_ADCLR_MASK					7
+#define HII2S_FS_CFG__FS_DACLR_SHIFT					16
+#define HII2S_FS_CFG__FS_DACLR_MASK					7
+#define HII2S_FS_CFG__FS_ST_DL_R_SHIFT					8
+#define HII2S_FS_CFG__FS_ST_DL_R_MASK					7
+#define HII2S_FS_CFG__FS_ST_DL_L_SHIFT					4
+#define HII2S_FS_CFG__FS_ST_DL_L_MASK					7
+#define HII2S_FS_CFG__FS_VOICE_DLINK_SHIFT				0
+#define HII2S_FS_CFG__FS_VOICE_DLINK_MASK				7
+
+enum hi6210_i2s_rates {
+	HII2S_FS_RATE_8KHZ = 0,
+	HII2S_FS_RATE_16KHZ = 1,
+	HII2S_FS_RATE_32KHZ = 2,
+	HII2S_FS_RATE_48KHZ = 4,
+	HII2S_FS_RATE_96KHZ = 5,
+	HII2S_FS_RATE_192KHZ = 6,
+};
+
+#define HII2S_I2S_CFG				0x10
+
+#define HII2S_I2S_CFG__S2_IF_TX_EN					BIT(31)
+#define HII2S_I2S_CFG__S2_IF_RX_EN					BIT(30)
+#define HII2S_I2S_CFG__S2_FRAME_MODE					BIT(29)
+#define HII2S_I2S_CFG__S2_MST_SLV					BIT(28)
+#define HII2S_I2S_CFG__S2_LRCK_MODE					BIT(27)
+#define HII2S_I2S_CFG__S2_CHNNL_MODE					BIT(26)
+#define HII2S_I2S_CFG__S2_CODEC_IO_WORDLENGTH_SHIFT			24
+#define HII2S_I2S_CFG__S2_CODEC_IO_WORDLENGTH_MASK			3
+#define HII2S_I2S_CFG__S2_DIRECT_LOOP_SHIFT				22
+#define HII2S_I2S_CFG__S2_DIRECT_LOOP_MASK				3
+#define HII2S_I2S_CFG__S2_TX_CLK_SEL					BIT(21)
+#define HII2S_I2S_CFG__S2_RX_CLK_SEL					BIT(20)
+#define HII2S_I2S_CFG__S2_CODEC_DATA_FORMAT				BIT(19)
+#define HII2S_I2S_CFG__S2_FUNC_MODE_SHIFT				16
+#define HII2S_I2S_CFG__S2_FUNC_MODE_MASK				7
+#define HII2S_I2S_CFG__S1_IF_TX_EN					BIT(15)
+#define HII2S_I2S_CFG__S1_IF_RX_EN					BIT(14)
+#define HII2S_I2S_CFG__S1_FRAME_MODE					BIT(13)
+#define HII2S_I2S_CFG__S1_MST_SLV					BIT(12)
+#define HII2S_I2S_CFG__S1_LRCK_MODE					BIT(11)
+#define HII2S_I2S_CFG__S1_CHNNL_MODE					BIT(10)
+#define HII2S_I2S_CFG__S1_CODEC_IO_WORDLENGTH_SHIFT			8
+#define HII2S_I2S_CFG__S1_CODEC_IO_WORDLENGTH_MASK			3
+#define HII2S_I2S_CFG__S1_DIRECT_LOOP_SHIFT				6
+#define HII2S_I2S_CFG__S1_DIRECT_LOOP_MASK				3
+#define HII2S_I2S_CFG__S1_TX_CLK_SEL					BIT(5)
+#define HII2S_I2S_CFG__S1_RX_CLK_SEL					BIT(4)
+#define HII2S_I2S_CFG__S1_CODEC_DATA_FORMAT				BIT(3)
+#define HII2S_I2S_CFG__S1_FUNC_MODE_SHIFT				0
+#define HII2S_I2S_CFG__S1_FUNC_MODE_MASK				7
+
+enum hi6210_i2s_formats {
+	HII2S_FORMAT_I2S,
+	HII2S_FORMAT_PCM_STD,
+	HII2S_FORMAT_PCM_USER,
+	HII2S_FORMAT_LEFT_JUST,
+	HII2S_FORMAT_RIGHT_JUST,
+};
+
+#define HII2S_DIG_FILTER_MODULE_CFG		0x14
+
+#define HII2S_DIG_FILTER_MODULE_CFG__DACR_MIXER_GAIN_SHIFT		28
+#define HII2S_DIG_FILTER_MODULE_CFG__DACR_MIXER_GAIN_MASK		3
+#define HII2S_DIG_FILTER_MODULE_CFG__DACR_MIXER_IN4_MUTE		BIT(27)
+#define HII2S_DIG_FILTER_MODULE_CFG__DACR_MIXER_IN3_MUTE		BIT(26)
+#define HII2S_DIG_FILTER_MODULE_CFG__DACR_MIXER_IN2_MUTE		BIT(25)
+#define HII2S_DIG_FILTER_MODULE_CFG__DACR_MIXER_IN1_MUTE		BIT(24)
+#define HII2S_DIG_FILTER_MODULE_CFG__DACL_MIXER_GAIN_SHIFT		20
+#define HII2S_DIG_FILTER_MODULE_CFG__DACL_MIXER_GAIN_MASK		3
+#define HII2S_DIG_FILTER_MODULE_CFG__DACL_MIXER_IN4_MUTE		BIT(19)
+#define HII2S_DIG_FILTER_MODULE_CFG__DACL_MIXER_IN3_MUTE		BIT(18)
+#define HII2S_DIG_FILTER_MODULE_CFG__DACL_MIXER_IN2_MUTE		BIT(17)
+#define HII2S_DIG_FILTER_MODULE_CFG__DACL_MIXER_IN1_MUTE		BIT(16)
+#define HII2S_DIG_FILTER_MODULE_CFG__SW_DACR_SDM_DITHER			BIT(9)
+#define HII2S_DIG_FILTER_MODULE_CFG__SW_DACL_SDM_DITHER			BIT(8)
+#define HII2S_DIG_FILTER_MODULE_CFG__LM_CODEC_DAC2ADC_SHIFT		4
+#define HII2S_DIG_FILTER_MODULE_CFG__LM_CODEC_DAC2ADC_MASK		7
+#define HII2S_DIG_FILTER_MODULE_CFG__RM_CODEC_DAC2ADC_SHIFT		0
+#define HII2S_DIG_FILTER_MODULE_CFG__RM_CODEC_DAC2ADC_MASK		7
+
+enum hi6210_gains {
+	HII2S_GAIN_100PC,
+	HII2S_GAIN_50PC,
+	HII2S_GAIN_25PC,
+};
+
+#define HII2S_MUX_TOP_MODULE_CFG		0x18
+
+#define HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_MIXER_GAIN_SHIFT		14
+#define HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_MIXER_GAIN_MASK		3
+#define HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_MIXER_IN2_MUTE		BIT(13)
+#define HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_MIXER_IN1_MUTE		BIT(12)
+#define HII2S_MUX_TOP_MODULE_CFG__S2_OL_MIXER_GAIN_SHIFT		10
+#define HII2S_MUX_TOP_MODULE_CFG__S2_OL_MIXER_GAIN_MASK			3
+#define HII2S_MUX_TOP_MODULE_CFG__S2_OL_MIXER_IN2_MUTE			BIT(9)
+#define HII2S_MUX_TOP_MODULE_CFG__S2_OL_MIXER_IN1_MUTE			BIT(8)
+#define HII2S_MUX_TOP_MODULE_CFG__S2_OL_SRC_RDY				BIT(6)
+#define HII2S_MUX_TOP_MODULE_CFG__S2_OL_SRC_MODE_SHIFT			4
+#define HII2S_MUX_TOP_MODULE_CFG__S2_OL_SRC_MODE_MASK			3
+#define HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_SRC_RDY			BIT(3)
+#define HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_SRC_MODE_SHIFT		0
+#define HII2S_MUX_TOP_MODULE_CFG__VOICE_DLINK_SRC_MODE_MASK		7
+
+enum hi6210_s2_src_mode {
+	HII2S_S2_SRC_MODE_3,
+	HII2S_S2_SRC_MODE_12,
+	HII2S_S2_SRC_MODE_6,
+	HII2S_S2_SRC_MODE_2,
+};
+
+enum hi6210_voice_dlink_src_mode {
+	HII2S_VOICE_DL_SRC_MODE_12 = 1,
+	HII2S_VOICE_DL_SRC_MODE_6,
+	HII2S_VOICE_DL_SRC_MODE_2,
+	HII2S_VOICE_DL_SRC_MODE_3,
+};
+
+#define HII2S_ADC_PGA_CFG			0x1c
+#define HII2S_S1_INPUT_PGA_CFG			0x20
+#define HII2S_S2_INPUT_PGA_CFG			0x24
+#define HII2S_ST_DL_PGA_CFG			0x28
+#define HII2S_VOICE_SIDETONE_DLINK_PGA_CFG	0x2c
+#define HII2S_APB_AFIFO_CFG_1			0x30
+#define HII2S_APB_AFIFO_CFG_2			0x34
+#define HII2S_ST_DL_FIFO_TH_CFG			0x38
+
+#define HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AEMPTY_SHIFT			24
+#define HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AEMPTY_MASK			0x1f
+#define HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AFULL_SHIFT			16
+#define HII2S_ST_DL_FIFO_TH_CFG__ST_DL_R_AFULL_MASK			0x1f
+#define HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AEMPTY_SHIFT			8
+#define HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AEMPTY_MASK			0x1f
+#define HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AFULL_SHIFT			0
+#define HII2S_ST_DL_FIFO_TH_CFG__ST_DL_L_AFULL_MASK			0x1f
+
+#define HII2S_STEREO_UPLINK_FIFO_TH_CFG		0x3c
+#define HII2S_VOICE_UPLINK_FIFO_TH_CFG		0x40
+#define HII2S_CODEC_IRQ_MASK			0x44
+#define HII2S_CODEC_IRQ				0x48
+#define HII2S_DACL_AGC_CFG_1			0x4c
+#define HII2S_DACL_AGC_CFG_2			0x50
+#define HII2S_DACR_AGC_CFG_1			0x54
+#define HII2S_DACR_AGC_CFG_2			0x58
+#define HII2S_DMIC_SIF_CFG			0x5c
+#define HII2S_MISC_CFG				0x60
+
+#define HII2S_MISC_CFG__THIRDMD_DLINK_TEST_SEL				BIT(17)
+#define HII2S_MISC_CFG__THIRDMD_DLINK_DIN_SEL				BIT(16)
+#define HII2S_MISC_CFG__S3_DOUT_RIGHT_SEL				BIT(14)
+#define HII2S_MISC_CFG__S3_DOUT_LEFT_SEL				BIT(13)
+#define HII2S_MISC_CFG__S3_DIN_TEST_SEL					BIT(12)
+#define HII2S_MISC_CFG__VOICE_DLINK_SRC_UP_DOUT_VLD_SEL			BIT(8)
+#define HII2S_MISC_CFG__VOICE_DLINK_TEST_SEL				BIT(7)
+#define HII2S_MISC_CFG__VOICE_DLINK_DIN_SEL				BIT(6)
+#define HII2S_MISC_CFG__ST_DL_TEST_SEL					BIT(4)
+#define HII2S_MISC_CFG__S2_DOUT_RIGHT_SEL				BIT(3)
+#define HII2S_MISC_CFG__S2_DOUT_TEST_SEL				BIT(2)
+#define HII2S_MISC_CFG__S1_DOUT_TEST_SEL				BIT(1)
+#define HII2S_MISC_CFG__S2_DOUT_LEFT_SEL				BIT(0)
+
+#define HII2S_S2_SRC_CFG			0x64
+#define HII2S_MEM_CFG				0x68
+#define HII2S_THIRDMD_PCM_PGA_CFG		0x6c
+#define HII2S_THIRD_MODEM_FIFO_TH		0x70
+#define HII2S_S3_ANTI_FREQ_JITTER_TX_INC_CNT	0x74
+#define HII2S_S3_ANTI_FREQ_JITTER_TX_DEC_CNT	0x78
+#define HII2S_S3_ANTI_FREQ_JITTER_RX_INC_CNT	0x7c
+#define HII2S_S3_ANTI_FREQ_JITTER_RX_DEC_CNT	0x80
+#define HII2S_ANTI_FREQ_JITTER_EN		0x84
+#define HII2S_CLK_SEL				0x88
+
+/* 0 = BT owns the i2s */
+#define HII2S_CLK_SEL__I2S_BT_FM_SEL					BIT(0)
+/* 0 = internal source, 1 = ext */
+#define HII2S_CLK_SEL__EXT_12_288MHZ_SEL				BIT(1)
+
+
+#define HII2S_THIRDMD_DLINK_CHANNEL		0xe8
+#define HII2S_THIRDMD_ULINK_CHANNEL		0xec
+#define HII2S_VOICE_DLINK_CHANNEL		0xf0
+
+/* shovel data in here for playback */
+#define HII2S_ST_DL_CHANNEL			0xf4
+#define HII2S_STEREO_UPLINK_CHANNEL		0xf8
+#define HII2S_VOICE_UPLINK_CHANNEL		0xfc
+
+#endif/* _HI6210_I2S_H */
-- 
2.11.0
