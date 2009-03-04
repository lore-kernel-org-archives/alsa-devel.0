From: Ben Dooks <ben-alsa@fluff.org>
Subject: [patch 5/9] S3C: Split s3c2412-i2s.c into core and SoC
	specific parts
Date: Wed, 04 Mar 2009 00:49:30 +0000
Message-ID: <20090304005138.875883650@fluff.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F4F024407
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:54:00 +0100 (CET)
Content-Disposition: inline; filename=audio/split-s3c2412-iis.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Ben Dooks <ben@simtec.co.uk>

The S3C2412 I2S (IIS) interface is replicated on further Samsung SoC
parts in a broadly compatible way, so split the common code out into
a core called s3c-i2s-v2.[ch] so that the newer SoCs such as the
S3C6410 can make use of it.

As such, all the original s3c2412 functions are currently being left
with their original names, and will be renamed later in the series.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

Index: linux.git/sound/soc/s3c24xx/s3c-i2s-v2.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/s3c-i2s-v2.c	2009-02-28 20:58:09.000000000 +0000
@@ -0,0 +1,645 @@
+/* sound/soc/s3c24xx/s3c-i2c-v2.c
+ *
+ * ALSA Soc Audio Layer - I2S core for newer Samsung SoCs.
+ *
+ * Copyright (c) 2006 Wolfson Microelectronics PLC.
+ *	Graeme Gregory graeme.gregory@wolfsonmicro.com
+ *	linux@wolfsonmicro.com
+ *
+ * Copyright (c) 2008, 2007, 2004-2005 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <plat/regs-s3c2412-iis.h>
+
+#include <plat/audio.h>
+#include <mach/dma.h>
+
+#include "s3c-i2s-v2.h"
+
+#define S3C2412_I2S_DEBUG_CON 0
+#define S3C2412_I2S_DEBUG 0
+
+#if S3C2412_I2S_DEBUG
+#define DBG(x...) printk(KERN_INFO x)
+#else
+#define DBG(x...) do { } while (0)
+#endif
+
+static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
+{
+	return cpu_dai->private_data;
+}
+
+#define bit_set(v, b) (((v) & (b)) ? 1 : 0)
+
+#if S3C2412_I2S_DEBUG_CON
+static void dbg_showcon(const char *fn, u32 con)
+{
+	printk(KERN_DEBUG "%s: LRI=%d, TXFEMPT=%d, RXFEMPT=%d, TXFFULL=%d, RXFFULL=%d\n", fn,
+	       bit_set(con, S3C2412_IISCON_LRINDEX),
+	       bit_set(con, S3C2412_IISCON_TXFIFO_EMPTY),
+	       bit_set(con, S3C2412_IISCON_RXFIFO_EMPTY),
+	       bit_set(con, S3C2412_IISCON_TXFIFO_FULL),
+	       bit_set(con, S3C2412_IISCON_RXFIFO_FULL));
+
+	printk(KERN_DEBUG "%s: PAUSE: TXDMA=%d, RXDMA=%d, TXCH=%d, RXCH=%d\n",
+	       fn,
+	       bit_set(con, S3C2412_IISCON_TXDMA_PAUSE),
+	       bit_set(con, S3C2412_IISCON_RXDMA_PAUSE),
+	       bit_set(con, S3C2412_IISCON_TXCH_PAUSE),
+	       bit_set(con, S3C2412_IISCON_RXCH_PAUSE));
+	printk(KERN_DEBUG "%s: ACTIVE: TXDMA=%d, RXDMA=%d, IIS=%d\n", fn,
+	       bit_set(con, S3C2412_IISCON_TXDMA_ACTIVE),
+	       bit_set(con, S3C2412_IISCON_RXDMA_ACTIVE),
+	       bit_set(con, S3C2412_IISCON_IIS_ACTIVE));
+}
+#else
+static inline void dbg_showcon(const char *fn, u32 con)
+{
+}
+#endif
+
+
+/* Turn on or off the transmission path. */
+void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
+{
+	void __iomem *regs = i2s->regs;
+	u32 fic, con, mod;
+
+	DBG("%s(%d)\n", __func__, on);
+
+	fic = readl(regs + S3C2412_IISFIC);
+	con = readl(regs + S3C2412_IISCON);
+	mod = readl(regs + S3C2412_IISMOD);
+
+	DBG("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
+
+	if (on) {
+		con |= S3C2412_IISCON_TXDMA_ACTIVE | S3C2412_IISCON_IIS_ACTIVE;
+		con &= ~S3C2412_IISCON_TXDMA_PAUSE;
+		con &= ~S3C2412_IISCON_TXCH_PAUSE;
+
+		switch (mod & S3C2412_IISMOD_MODE_MASK) {
+		case S3C2412_IISMOD_MODE_TXONLY:
+		case S3C2412_IISMOD_MODE_TXRX:
+			/* do nothing, we are in the right mode */
+			break;
+
+		case S3C2412_IISMOD_MODE_RXONLY:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			mod |= S3C2412_IISMOD_MODE_TXRX;
+			break;
+
+		default:
+			dev_err(i2s->dev, "TXEN: Invalid MODE in IISMOD\n");
+		}
+
+		writel(con, regs + S3C2412_IISCON);
+		writel(mod, regs + S3C2412_IISMOD);
+	} else {
+		/* Note, we do not have any indication that the FIFO problems
+		 * tha the S3C2410/2440 had apply here, so we should be able
+		 * to disable the DMA and TX without resetting the FIFOS.
+		 */
+
+		con |=  S3C2412_IISCON_TXDMA_PAUSE;
+		con |=  S3C2412_IISCON_TXCH_PAUSE;
+		con &= ~S3C2412_IISCON_TXDMA_ACTIVE;
+
+		switch (mod & S3C2412_IISMOD_MODE_MASK) {
+		case S3C2412_IISMOD_MODE_TXRX:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			mod |= S3C2412_IISMOD_MODE_RXONLY;
+			break;
+
+		case S3C2412_IISMOD_MODE_TXONLY:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			con &= ~S3C2412_IISCON_IIS_ACTIVE;
+			break;
+
+		default:
+			dev_err(i2s->dev, "TXDIS: Invalid MODE in IISMOD\n");
+		}
+
+		writel(mod, regs + S3C2412_IISMOD);
+		writel(con, regs + S3C2412_IISCON);
+	}
+
+	fic = readl(regs + S3C2412_IISFIC);
+	dbg_showcon(__func__, con);
+	DBG("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
+}
+EXPORT_SYMBOL_GPL(s3c2412_snd_txctrl);
+
+void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
+{
+	void __iomem *regs = i2s->regs;
+	u32 fic, con, mod;
+
+	DBG("%s(%d)\n", __func__, on);
+
+	fic = readl(regs + S3C2412_IISFIC);
+	con = readl(regs + S3C2412_IISCON);
+	mod = readl(regs + S3C2412_IISMOD);
+
+	DBG("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
+
+	if (on) {
+		con |= S3C2412_IISCON_RXDMA_ACTIVE | S3C2412_IISCON_IIS_ACTIVE;
+		con &= ~S3C2412_IISCON_RXDMA_PAUSE;
+		con &= ~S3C2412_IISCON_RXCH_PAUSE;
+
+		switch (mod & S3C2412_IISMOD_MODE_MASK) {
+		case S3C2412_IISMOD_MODE_TXRX:
+		case S3C2412_IISMOD_MODE_RXONLY:
+			/* do nothing, we are in the right mode */
+			break;
+
+		case S3C2412_IISMOD_MODE_TXONLY:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			mod |= S3C2412_IISMOD_MODE_TXRX;
+			break;
+
+		default:
+			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
+		}
+
+		writel(mod, regs + S3C2412_IISMOD);
+		writel(con, regs + S3C2412_IISCON);
+	} else {
+		/* See txctrl notes on FIFOs. */
+
+		con &= ~S3C2412_IISCON_RXDMA_ACTIVE;
+		con |=  S3C2412_IISCON_RXDMA_PAUSE;
+		con |=  S3C2412_IISCON_RXCH_PAUSE;
+
+		switch (mod & S3C2412_IISMOD_MODE_MASK) {
+		case S3C2412_IISMOD_MODE_RXONLY:
+			con &= ~S3C2412_IISCON_IIS_ACTIVE;
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			break;
+
+		case S3C2412_IISMOD_MODE_TXRX:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			mod |= S3C2412_IISMOD_MODE_TXONLY;
+			break;
+
+		default:
+			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
+		}
+
+		writel(con, regs + S3C2412_IISCON);
+		writel(mod, regs + S3C2412_IISMOD);
+	}
+
+	fic = readl(regs + S3C2412_IISFIC);
+	DBG("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
+}
+EXPORT_SYMBOL_GPL(s3c2412_snd_rxctrl);
+
+/*
+ * Wait for the LR signal to allow synchronisation to the L/R clock
+ * from the codec. May only be needed for slave mode.
+ */
+static int s3c2412_snd_lrsync(struct s3c_i2sv2_info *i2s)
+{
+	u32 iiscon;
+	unsigned long timeout = jiffies + msecs_to_jiffies(5);
+
+	DBG("Entered %s\n", __func__);
+
+	while (1) {
+		iiscon = readl(i2s->regs + S3C2412_IISCON);
+		if (iiscon & S3C2412_IISCON_LRINDEX)
+			break;
+
+		if (timeout < jiffies) {
+			printk(KERN_ERR "%s: timeout\n", __func__);
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Set S3C2412 I2S DAI format
+ */
+static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+			       unsigned int fmt)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 iismod;
+
+	DBG("Entered %s\n", __func__);
+
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	DBG("hw_params r: IISMOD: %x \n", iismod);
+
+#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
+#define IISMOD_MASTER_MASK S3C2412_IISMOD_MASTER_MASK
+#define IISMOD_SLAVE S3C2412_IISMOD_SLAVE
+#define IISMOD_MASTER S3C2412_IISMOD_MASTER_INTERNAL
+#endif
+
+#if defined(CONFIG_PLAT_S3C64XX)
+/* From Rev1.1 datasheet, we have two master and two slave modes:
+ * IMS[11:10]:
+ *	00 = master mode, fed from PCLK
+ *	01 = master mode, fed from CLKAUDIO
+ *	10 = slave mode, using PCLK
+ *	11 = slave mode, using I2SCLK
+ */
+#define IISMOD_MASTER_MASK (1 << 11)
+#define IISMOD_SLAVE (1 << 11)
+#define IISMOD_MASTER (0x0)
+#endif
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		i2s->master = 0;
+		iismod &= ~IISMOD_MASTER_MASK;
+		iismod |= IISMOD_SLAVE;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s->master = 1;
+		iismod &= ~IISMOD_MASTER_MASK;
+		iismod |= IISMOD_MASTER;
+		break;
+	default:
+		DBG("unknwon master/slave format\n");
+		return -EINVAL;
+	}
+
+	iismod &= ~S3C2412_IISMOD_SDF_MASK;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		iismod |= S3C2412_IISMOD_SDF_MSB;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iismod |= S3C2412_IISMOD_SDF_LSB;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		iismod |= S3C2412_IISMOD_SDF_IIS;
+		break;
+	default:
+		DBG("Unknown data format\n");
+		return -EINVAL;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	DBG("hw_params w: IISMOD: %x \n", iismod);
+	return 0;
+}
+
+static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *socdai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_link *dai = rtd->dai;
+	struct s3c_i2sv2_info *i2s = to_info(dai->cpu_dai);
+	u32 iismod;
+
+	DBG("Entered %s\n", __func__);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dai->cpu_dai->dma_data = i2s->dma_playback;
+	else
+		dai->cpu_dai->dma_data = i2s->dma_capture;
+
+	/* Working copies of register */
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	DBG("%s: r: IISMOD: %x\n", __func__, iismod);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		iismod |= S3C2412_IISMOD_8BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		iismod &= ~S3C2412_IISMOD_8BIT;
+		break;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	DBG("%s: w: IISMOD: %x\n", __func__, iismod);
+	return 0;
+}
+
+static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c_i2sv2_info *i2s = to_info(rtd->dai->cpu_dai);
+	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
+	unsigned long irqs;
+	int ret = 0;
+
+	DBG("Entered %s\n", __func__);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* On start, ensure that the FIFOs are cleared and reset. */
+
+		writel(capture ? S3C2412_IISFIC_RXFLUSH : S3C2412_IISFIC_TXFLUSH,
+		       i2s->regs + S3C2412_IISFIC);
+
+		/* clear again, just in case */
+		writel(0x0, i2s->regs + S3C2412_IISFIC);
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (!i2s->master) {
+			ret = s3c2412_snd_lrsync(i2s);
+			if (ret)
+				goto exit_err;
+		}
+
+		local_irq_save(irqs);
+
+		if (capture)
+			s3c2412_snd_rxctrl(i2s, 1);
+		else
+			s3c2412_snd_txctrl(i2s, 1);
+
+		local_irq_restore(irqs);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		local_irq_save(irqs);
+
+		if (capture)
+			s3c2412_snd_rxctrl(i2s, 0);
+		else
+			s3c2412_snd_txctrl(i2s, 0);
+
+		local_irq_restore(irqs);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+exit_err:
+	return ret;
+}
+
+/*
+ * Set S3C2412 Clock dividers
+ */
+static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
+				  int div_id, int div)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 reg;
+
+	DBG("%s(%p, %d, %d)\n", __func__, cpu_dai, div_id, div);
+
+	switch (div_id) {
+	case S3C_I2SV2_DIV_BCLK:
+		reg = readl(i2s->regs + S3C2412_IISMOD);
+		reg &= ~S3C2412_IISMOD_BCLK_MASK;
+		writel(reg | div, i2s->regs + S3C2412_IISMOD);
+
+		DBG("%s: MOD=%08x\n", __func__, readl(i2s->regs + S3C2412_IISMOD));
+		break;
+
+	case S3C_I2SV2_DIV_RCLK:
+		if (div > 3) {
+			/* convert value to bit field */
+
+			switch (div) {
+			case 256:
+				div = S3C2412_IISMOD_RCLK_256FS;
+				break;
+
+			case 384:
+				div = S3C2412_IISMOD_RCLK_384FS;
+				break;
+
+			case 512:
+				div = S3C2412_IISMOD_RCLK_512FS;
+				break;
+
+			case 768:
+				div = S3C2412_IISMOD_RCLK_768FS;
+				break;
+
+			default:
+				return -EINVAL;
+			}
+		}
+
+		reg = readl(i2s->regs + S3C2412_IISMOD);
+		reg &= ~S3C2412_IISMOD_RCLK_MASK;
+		writel(reg | div, i2s->regs + S3C2412_IISMOD);
+		DBG("%s: MOD=%08x\n", __func__, readl(i2s->regs + S3C2412_IISMOD));
+		break;
+
+	case S3C_I2SV2_DIV_PRESCALER:
+		if (div >= 0) {
+			writel((div << 8) | S3C2412_IISPSR_PSREN,
+			       i2s->regs + S3C2412_IISPSR);
+		} else {
+			writel(0x0, i2s->regs + S3C2412_IISPSR);
+		}
+		DBG("%s: PSR=%08x\n", __func__, readl(i2s->regs + S3C2412_IISPSR));
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* default table of all avaialable root fs divisors */
+static unsigned int iis_fs_tab[] = { 256, 512, 384, 768 };
+
+int s3c2412_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
+			  unsigned int *fstab,
+			  unsigned int rate, struct clk *clk)
+{
+	unsigned long clkrate = clk_get_rate(clk);
+	unsigned int div;
+	unsigned int fsclk;
+	unsigned int actual;
+	unsigned int fs;
+	unsigned int fsdiv;
+	signed int deviation = 0;
+	unsigned int best_fs = 0;
+	unsigned int best_div = 0;
+	unsigned int best_rate = 0;
+	unsigned int best_deviation = INT_MAX;
+
+	if (fstab == NULL)
+		fstab = iis_fs_tab;
+
+	for (fs = 0; fs < ARRAY_SIZE(iis_fs_tab); fs++) {
+		fsdiv = iis_fs_tab[fs];
+
+		fsclk = clkrate / fsdiv;
+		div = fsclk / rate;
+
+		if ((fsclk % rate) > (rate / 2))
+			div++;
+
+		if (div <= 1)
+			continue;
+
+		actual = clkrate / (fsdiv * div);
+		deviation = actual - rate;
+
+		printk(KERN_DEBUG "%dfs: div %d => result %d, deviation %d\n",
+		       fsdiv, div, actual, deviation);
+
+		deviation = abs(deviation);
+
+		if (deviation < best_deviation) {
+			best_fs = fsdiv;
+			best_div = div;
+			best_rate = actual;
+			best_deviation = deviation;
+		}
+
+		if (deviation == 0)
+			break;
+	}
+
+	printk(KERN_DEBUG "best: fs=%d, div=%d, rate=%d\n",
+	       best_fs, best_div, best_rate);
+
+	info->fs_div = best_fs;
+	info->clk_div = best_div;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s3c2412_iis_calc_rate);
+
+int s3c_i2sv2_probe(struct platform_device *pdev,
+		    struct snd_soc_dai *dai,
+		    struct s3c_i2sv2_info *i2s,
+		    unsigned long base)
+{
+	struct device *dev = &pdev->dev;
+
+	i2s->dev = dev;
+
+	/* record our i2s structure for later use in the callbacks */
+	dai->private_data = i2s;
+
+	i2s->regs = ioremap(base, 0x100);
+	if (i2s->regs == NULL) {
+		dev_err(dev, "cannot ioremap registers\n");
+		return -ENXIO;
+	}
+
+	i2s->iis_pclk = clk_get(dev, "iis");
+	if (i2s->iis_pclk == NULL) {
+		DBG("failed to get iis_clock\n");
+		iounmap(i2s->regs);
+		return -ENOENT;
+	}
+
+	clk_enable(i2s->iis_pclk);
+
+	s3c2412_snd_txctrl(i2s, 0);
+	s3c2412_snd_rxctrl(i2s, 0);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(s3c_i2sv2_probe);
+
+#ifdef CONFIG_PM
+static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(dai);
+	u32 iismod;
+
+	if (dai->active) {
+		i2s->suspend_iismod = readl(i2s->regs + S3C2412_IISMOD);
+		i2s->suspend_iiscon = readl(i2s->regs + S3C2412_IISCON);
+		i2s->suspend_iispsr = readl(i2s->regs + S3C2412_IISPSR);
+
+		/* some basic suspend checks */
+
+		iismod = readl(i2s->regs + S3C2412_IISMOD);
+
+		if (iismod & S3C2412_IISCON_RXDMA_ACTIVE)
+			pr_warning("%s: RXDMA active?\n", __func__);
+
+		if (iismod & S3C2412_IISCON_TXDMA_ACTIVE)
+			pr_warning("%s: TXDMA active?\n", __func__);
+
+		if (iismod & S3C2412_IISCON_IIS_ACTIVE)
+			pr_warning("%s: IIS active\n", __func__);
+	}
+
+	return 0;
+}
+
+static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(dai);
+
+	pr_info("dai_active %d, IISMOD %08x, IISCON %08x\n",
+		dai->active, i2s->suspend_iismod, i2s->suspend_iiscon);
+
+	if (dai->active) {
+		writel(i2s->suspend_iiscon, i2s->regs + S3C2412_IISCON);
+		writel(i2s->suspend_iismod, i2s->regs + S3C2412_IISMOD);
+		writel(i2s->suspend_iispsr, i2s->regs + S3C2412_IISPSR);
+
+		writel(S3C2412_IISFIC_RXFLUSH | S3C2412_IISFIC_TXFLUSH,
+		       i2s->regs + S3C2412_IISFIC);
+
+		ndelay(250);
+		writel(0x0, i2s->regs + S3C2412_IISFIC);
+	}
+
+	return 0;
+}
+#else
+#define s3c2412_i2s_suspend NULL
+#define s3c2412_i2s_resume  NULL
+#endif
+
+int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
+{
+	dai->ops.trigger = s3c2412_i2s_trigger;
+	dai->ops.hw_params = s3c2412_i2s_hw_params;
+	dai->ops.set_fmt = s3c2412_i2s_set_fmt;
+	dai->ops.set_clkdiv = s3c2412_i2s_set_clkdiv;
+
+	dai->suspend = s3c2412_i2s_suspend;
+	dai->resume = s3c2412_i2s_resume;
+
+	return snd_soc_register_dai(dai);
+}
+
+EXPORT_SYMBOL_GPL(s3c_i2sv2_register_dai);
Index: linux.git/sound/soc/s3c24xx/s3c-i2s-v2.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/s3c-i2s-v2.h	2009-02-28 20:41:45.000000000 +0000
@@ -0,0 +1,90 @@
+/* sound/soc/s3c24xx/s3c-i2s-v2.h
+ *
+ * ALSA Soc Audio Layer - S3C_I2SV2 I2S driver
+ *
+ * Copyright (c) 2007 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+*/
+
+/* This code is the core support for the I2S block found in a number of
+ * Samsung SoC devices which is unofficially named I2S-V2. Currently the
+ * S3C2412 and the S3C64XX series use this block to provide 1 or 2 I2S
+ * channels via configurable GPIO.
+ */
+
+#ifndef __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H
+#define __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H __FILE__
+
+#define S3C_I2SV2_DIV_BCLK	(1)
+#define S3C_I2SV2_DIV_RCLK	(2)
+#define S3C_I2SV2_DIV_PRESCALER	(3)
+
+/**
+ * struct s3c_i2sv2_info - S3C I2S-V2 information
+ * @dev: The parent device passed to use from the probe.
+ * @regs: The pointer to the device registe block.
+ * @master: True if the I2S core is the I2S bit clock master.
+ * @dma_playback: DMA information for playback channel.
+ * @dma_capture: DMA information for capture channel.
+ * @suspend_iismod: PM save for the IISMOD register.
+ * @suspend_iiscon: PM save for the IISCON register.
+ * @suspend_iispsr: PM save for the IISPSR register.
+ *
+ * This is the private codec state for the hardware associated with an
+ * I2S channel such as the register mappings and clock sources.
+ */
+struct s3c_i2sv2_info {
+	struct device	*dev;
+	void __iomem	*regs;
+
+	struct clk	*iis_pclk;
+	struct clk	*iis_cclk;
+	struct clk	*iis_clk;
+
+	unsigned char	 master;
+
+	struct s3c24xx_pcm_dma_params	*dma_playback;
+	struct s3c24xx_pcm_dma_params	*dma_capture;
+
+	u32		 suspend_iismod;
+	u32		 suspend_iiscon;
+	u32		 suspend_iispsr;
+};
+
+struct s3c_i2sv2_rate_calc {
+	unsigned int	clk_div;	/* for prescaler */
+	unsigned int	fs_div;		/* for root frame clock */
+};
+
+extern int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
+				   unsigned int *fstab,
+				   unsigned int rate, struct clk *clk);
+
+/**
+ * s3c_i2sv2_probe - probe for i2s device helper
+ * @pdev: The platform device supplied to the original probe.
+ * @dai: The ASoC DAI structure supplied to the original probe.
+ * @i2s: Our local i2s structure to fill in.
+ * @base: The base address for the registers.
+ */
+extern int s3c_i2sv2_probe(struct platform_device *pdev,
+			   struct snd_soc_dai *dai,
+			   struct s3c_i2sv2_info *i2s,
+			   unsigned long base);
+
+/**
+ * s3c_i2sv2_register_dai - register dai with soc core
+ * @dai: The snd_soc_dai structure to register
+ *
+ * Fill in any missing fields and then register the given dai with the
+ * soc core.
+ */
+extern int s3c_i2sv2_register_dai(struct snd_soc_dai *dai);
+
+#endif /* __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H */
Index: linux.git/sound/soc/s3c24xx/s3c2412-i2s.c
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/s3c2412-i2s.c	2009-02-28 20:41:44.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/s3c2412-i2s.c	2009-02-28 20:41:45.000000000 +0000
@@ -33,7 +33,7 @@
 
 #include <plat/regs-s3c2412-iis.h>
 
-#include <mach/regs-gpio.h>
+#include <plat/regs-gpio.h>
 #include <plat/audio.h>
 #include <mach/dma.h>
 
@@ -41,7 +41,6 @@
 #include "s3c2412-i2s.h"
 
 #define S3C2412_I2S_DEBUG 0
-#define S3C2412_I2S_DEBUG_CON 0
 
 #if S3C2412_I2S_DEBUG
 #define DBG(x...) printk(KERN_INFO x)
@@ -71,431 +70,7 @@ static struct s3c24xx_pcm_dma_params s3c
 	.dma_size	= 4,
 };
 
-struct s3c2412_i2s_info {
-	struct device	*dev;
-	void __iomem	*regs;
-	struct clk	*iis_clk;
-	struct clk	*iis_pclk;
-	struct clk	*iis_cclk;
-
-	u32		 suspend_iismod;
-	u32		 suspend_iiscon;
-	u32		 suspend_iispsr;
-};
-
-static struct s3c2412_i2s_info s3c2412_i2s;
-
-#define bit_set(v, b) (((v) & (b)) ? 1 : 0)
-
-#if S3C2412_I2S_DEBUG_CON
-static void dbg_showcon(const char *fn, u32 con)
-{
-	printk(KERN_DEBUG "%s: LRI=%d, TXFEMPT=%d, RXFEMPT=%d, TXFFULL=%d, RXFFULL=%d\n", fn,
-	       bit_set(con, S3C2412_IISCON_LRINDEX),
-	       bit_set(con, S3C2412_IISCON_TXFIFO_EMPTY),
-	       bit_set(con, S3C2412_IISCON_RXFIFO_EMPTY),
-	       bit_set(con, S3C2412_IISCON_TXFIFO_FULL),
-	       bit_set(con, S3C2412_IISCON_RXFIFO_FULL));
-
-	printk(KERN_DEBUG "%s: PAUSE: TXDMA=%d, RXDMA=%d, TXCH=%d, RXCH=%d\n",
-	       fn,
-	       bit_set(con, S3C2412_IISCON_TXDMA_PAUSE),
-	       bit_set(con, S3C2412_IISCON_RXDMA_PAUSE),
-	       bit_set(con, S3C2412_IISCON_TXCH_PAUSE),
-	       bit_set(con, S3C2412_IISCON_RXCH_PAUSE));
-	printk(KERN_DEBUG "%s: ACTIVE: TXDMA=%d, RXDMA=%d, IIS=%d\n", fn,
-	       bit_set(con, S3C2412_IISCON_TXDMA_ACTIVE),
-	       bit_set(con, S3C2412_IISCON_RXDMA_ACTIVE),
-	       bit_set(con, S3C2412_IISCON_IIS_ACTIVE));
-}
-#else
-static inline void dbg_showcon(const char *fn, u32 con)
-{
-}
-#endif
-
-/* Turn on or off the transmission path. */
-static void s3c2412_snd_txctrl(int on)
-{
-	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
-	void __iomem *regs = i2s->regs;
-	u32 fic, con, mod;
-
-	DBG("%s(%d)\n", __func__, on);
-
-	fic = readl(regs + S3C2412_IISFIC);
-	con = readl(regs + S3C2412_IISCON);
-	mod = readl(regs + S3C2412_IISMOD);
-
-	DBG("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
-
-	if (on) {
-		con |= S3C2412_IISCON_TXDMA_ACTIVE | S3C2412_IISCON_IIS_ACTIVE;
-		con &= ~S3C2412_IISCON_TXDMA_PAUSE;
-		con &= ~S3C2412_IISCON_TXCH_PAUSE;
-
-		switch (mod & S3C2412_IISMOD_MODE_MASK) {
-		case S3C2412_IISMOD_MODE_TXONLY:
-		case S3C2412_IISMOD_MODE_TXRX:
-			/* do nothing, we are in the right mode */
-			break;
-
-		case S3C2412_IISMOD_MODE_RXONLY:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			mod |= S3C2412_IISMOD_MODE_TXRX;
-			break;
-
-		default:
-			dev_err(i2s->dev, "TXEN: Invalid MODE in IISMOD\n");
-		}
-
-		writel(con, regs + S3C2412_IISCON);
-		writel(mod, regs + S3C2412_IISMOD);
-	} else {
-		/* Note, we do not have any indication that the FIFO problems
-		 * tha the S3C2410/2440 had apply here, so we should be able
-		 * to disable the DMA and TX without resetting the FIFOS.
-		 */
-
-		con |=  S3C2412_IISCON_TXDMA_PAUSE;
-		con |=  S3C2412_IISCON_TXCH_PAUSE;
-		con &= ~S3C2412_IISCON_TXDMA_ACTIVE;
-
-		switch (mod & S3C2412_IISMOD_MODE_MASK) {
-		case S3C2412_IISMOD_MODE_TXRX:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			mod |= S3C2412_IISMOD_MODE_RXONLY;
-			break;
-
-		case S3C2412_IISMOD_MODE_TXONLY:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			con &= ~S3C2412_IISCON_IIS_ACTIVE;
-			break;
-
-		default:
-			dev_err(i2s->dev, "TXDIS: Invalid MODE in IISMOD\n");
-		}
-
-		writel(mod, regs + S3C2412_IISMOD);
-		writel(con, regs + S3C2412_IISCON);
-	}
-
-	fic = readl(regs + S3C2412_IISFIC);
-	dbg_showcon(__func__, con);
-	DBG("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
-}
-
-static void s3c2412_snd_rxctrl(int on)
-{
-	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
-	void __iomem *regs = i2s->regs;
-	u32 fic, con, mod;
-
-	DBG("%s(%d)\n", __func__, on);
-
-	fic = readl(regs + S3C2412_IISFIC);
-	con = readl(regs + S3C2412_IISCON);
-	mod = readl(regs + S3C2412_IISMOD);
-
-	DBG("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
-
-	if (on) {
-		con |= S3C2412_IISCON_RXDMA_ACTIVE | S3C2412_IISCON_IIS_ACTIVE;
-		con &= ~S3C2412_IISCON_RXDMA_PAUSE;
-		con &= ~S3C2412_IISCON_RXCH_PAUSE;
-
-		switch (mod & S3C2412_IISMOD_MODE_MASK) {
-		case S3C2412_IISMOD_MODE_TXRX:
-		case S3C2412_IISMOD_MODE_RXONLY:
-			/* do nothing, we are in the right mode */
-			break;
-
-		case S3C2412_IISMOD_MODE_TXONLY:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			mod |= S3C2412_IISMOD_MODE_TXRX;
-			break;
-
-		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
-		}
-
-		writel(mod, regs + S3C2412_IISMOD);
-		writel(con, regs + S3C2412_IISCON);
-	} else {
-		/* See txctrl notes on FIFOs. */
-
-		con &= ~S3C2412_IISCON_RXDMA_ACTIVE;
-		con |=  S3C2412_IISCON_RXDMA_PAUSE;
-		con |=  S3C2412_IISCON_RXCH_PAUSE;
-
-		switch (mod & S3C2412_IISMOD_MODE_MASK) {
-		case S3C2412_IISMOD_MODE_RXONLY:
-			con &= ~S3C2412_IISCON_IIS_ACTIVE;
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			break;
-
-		case S3C2412_IISMOD_MODE_TXRX:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			mod |= S3C2412_IISMOD_MODE_TXONLY;
-			break;
-
-		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE in IISMOD\n");
-		}
-
-		writel(con, regs + S3C2412_IISCON);
-		writel(mod, regs + S3C2412_IISMOD);
-	}
-
-	fic = readl(regs + S3C2412_IISFIC);
-	DBG("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
-}
-
-
-/*
- * Wait for the LR signal to allow synchronisation to the L/R clock
- * from the codec. May only be needed for slave mode.
- */
-static int s3c2412_snd_lrsync(void)
-{
-	u32 iiscon;
-	unsigned long timeout = jiffies + msecs_to_jiffies(5);
-
-	DBG("Entered %s\n", __func__);
-
-	while (1) {
-		iiscon = readl(s3c2412_i2s.regs + S3C2412_IISCON);
-		if (iiscon & S3C2412_IISCON_LRINDEX)
-			break;
-
-		if (timeout < jiffies) {
-			printk(KERN_ERR "%s: timeout\n", __func__);
-			return -ETIMEDOUT;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Check whether CPU is the master or slave
- */
-static inline int s3c2412_snd_is_clkmaster(void)
-{
-	u32 iismod = readl(s3c2412_i2s.regs + S3C2412_IISMOD);
-
-	DBG("Entered %s\n", __func__);
-
-	iismod &= S3C2412_IISMOD_MASTER_MASK;
-	return !(iismod == S3C2412_IISMOD_SLAVE);
-}
-
-/*
- * Set S3C2412 I2S DAI format
- */
-static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
-			       unsigned int fmt)
-{
-	u32 iismod;
-
-
-	DBG("Entered %s\n", __func__);
-
-	iismod = readl(s3c2412_i2s.regs + S3C2412_IISMOD);
-	DBG("hw_params r: IISMOD: %x \n", iismod);
-
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
-		iismod &= ~S3C2412_IISMOD_MASTER_MASK;
-		iismod |= S3C2412_IISMOD_SLAVE;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
-		iismod &= ~S3C2412_IISMOD_MASTER_MASK;
-		iismod |= S3C2412_IISMOD_MASTER_INTERNAL;
-		break;
-	default:
-		DBG("unknwon master/slave format\n");
-		return -EINVAL;
-	}
-
-	iismod &= ~S3C2412_IISMOD_SDF_MASK;
-
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_RIGHT_J:
-		iismod |= S3C2412_IISMOD_SDF_MSB;
-		break;
-	case SND_SOC_DAIFMT_LEFT_J:
-		iismod |= S3C2412_IISMOD_SDF_LSB;
-		break;
-	case SND_SOC_DAIFMT_I2S:
-		iismod |= S3C2412_IISMOD_SDF_IIS;
-		break;
-	default:
-		DBG("Unknown data format\n");
-		return -EINVAL;
-	}
-
-	writel(iismod, s3c2412_i2s.regs + S3C2412_IISMOD);
-	DBG("hw_params w: IISMOD: %x \n", iismod);
-	return 0;
-}
-
-static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	u32 iismod;
-
-	DBG("Entered %s\n", __func__);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		rtd->dai->cpu_dai->dma_data = &s3c2412_i2s_pcm_stereo_out;
-	else
-		rtd->dai->cpu_dai->dma_data = &s3c2412_i2s_pcm_stereo_in;
-
-	/* Working copies of register */
-	iismod = readl(s3c2412_i2s.regs + S3C2412_IISMOD);
-	DBG("%s: r: IISMOD: %x\n", __func__, iismod);
-
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		iismod |= S3C2412_IISMOD_8BIT;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		iismod &= ~S3C2412_IISMOD_8BIT;
-		break;
-	}
-
-	writel(iismod, s3c2412_i2s.regs + S3C2412_IISMOD);
-	DBG("%s: w: IISMOD: %x\n", __func__, iismod);
-	return 0;
-}
-
-static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
-			       struct snd_soc_dai *dai)
-{
-	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
-	unsigned long irqs;
-	int ret = 0;
-
-	DBG("Entered %s\n", __func__);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		/* On start, ensure that the FIFOs are cleared and reset. */
-
-		writel(capture ? S3C2412_IISFIC_RXFLUSH : S3C2412_IISFIC_TXFLUSH,
-		       s3c2412_i2s.regs + S3C2412_IISFIC);
-
-		/* clear again, just in case */
-		writel(0x0, s3c2412_i2s.regs + S3C2412_IISFIC);
-
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!s3c2412_snd_is_clkmaster()) {
-			ret = s3c2412_snd_lrsync();
-			if (ret)
-				goto exit_err;
-		}
-
-		local_irq_save(irqs);
-
-		if (capture)
-			s3c2412_snd_rxctrl(1);
-		else
-			s3c2412_snd_txctrl(1);
-
-		local_irq_restore(irqs);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		local_irq_save(irqs);
-
-		if (capture)
-			s3c2412_snd_rxctrl(0);
-		else
-			s3c2412_snd_txctrl(0);
-
-		local_irq_restore(irqs);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-exit_err:
-	return ret;
-}
-
-/* default table of all avaialable root fs divisors */
-static unsigned int s3c2412_iis_fs[] = { 256, 512, 384, 768, 0 };
-
-int s3c2412_iis_calc_rate(struct s3c2412_rate_calc *info,
-			  unsigned int *fstab,
-			  unsigned int rate, struct clk *clk)
-{
-	unsigned long clkrate = clk_get_rate(clk);
-	unsigned int div;
-	unsigned int fsclk;
-	unsigned int actual;
-	unsigned int fs;
-	unsigned int fsdiv;
-	signed int deviation = 0;
-	unsigned int best_fs = 0;
-	unsigned int best_div = 0;
-	unsigned int best_rate = 0;
-	unsigned int best_deviation = INT_MAX;
-
-
-	if (fstab == NULL)
-		fstab = s3c2412_iis_fs;
-
-	for (fs = 0;; fs++) {
-		fsdiv = s3c2412_iis_fs[fs];
-
-		if (fsdiv == 0)
-			break;
-
-		fsclk = clkrate / fsdiv;
-		div = fsclk / rate;
-
-		if ((fsclk % rate) > (rate / 2))
-			div++;
-
-		if (div <= 1)
-			continue;
-
-		actual = clkrate / (fsdiv * div);
-		deviation = actual - rate;
-
-		printk(KERN_DEBUG "%dfs: div %d => result %d, deviation %d\n",
-		       fsdiv, div, actual, deviation);
-
-		deviation = abs(deviation);
-
-		if (deviation < best_deviation) {
-			best_fs = fsdiv;
-			best_div = div;
-			best_rate = actual;
-			best_deviation = deviation;
-		}
-
-		if (deviation == 0)
-			break;
-	}
-
-	printk(KERN_DEBUG "best: fs=%d, div=%d, rate=%d\n",
-	       best_fs, best_div, best_rate);
-
-	info->fs_div = best_fs;
-	info->clk_div = best_div;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(s3c2412_iis_calc_rate);
+static struct s3c_i2sv2_info s3c2412_i2s;
 
 /*
  * Set S3C2412 Clock source
@@ -510,10 +85,12 @@ static int s3c2412_i2s_set_sysclk(struct
 
 	switch (clk_id) {
 	case S3C2412_CLKSRC_PCLK:
+		s3c2412_i2s.master = 1;
 		iismod &= ~S3C2412_IISMOD_MASTER_MASK;
 		iismod |= S3C2412_IISMOD_MASTER_INTERNAL;
 		break;
 	case S3C2412_CLKSRC_I2SCLK:
+		s3c2412_i2s.master = 0;
 		iismod &= ~S3C2412_IISMOD_MASTER_MASK;
 		iismod |= S3C2412_IISMOD_MASTER_EXTERNAL;
 		break;
@@ -525,74 +102,6 @@ static int s3c2412_i2s_set_sysclk(struct
 	return 0;
 }
 
-/*
- * Set S3C2412 Clock dividers
- */
-static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
-				  int div_id, int div)
-{
-	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
-	u32 reg;
-
-	DBG("%s(%p, %d, %d)\n", __func__, cpu_dai, div_id, div);
-
-	switch (div_id) {
-	case S3C2412_DIV_BCLK:
-		reg = readl(i2s->regs + S3C2412_IISMOD);
-		reg &= ~S3C2412_IISMOD_BCLK_MASK;
-		writel(reg | div, i2s->regs + S3C2412_IISMOD);
-
-		DBG("%s: MOD=%08x\n", __func__, readl(i2s->regs + S3C2412_IISMOD));
-		break;
-
-	case S3C2412_DIV_RCLK:
-		if (div > 3) {
-			/* convert value to bit field */
-
-			switch (div) {
-			case 256:
-				div = S3C2412_IISMOD_RCLK_256FS;
-				break;
-
-			case 384:
-				div = S3C2412_IISMOD_RCLK_384FS;
-				break;
-
-			case 512:
-				div = S3C2412_IISMOD_RCLK_512FS;
-				break;
-
-			case 768:
-				div = S3C2412_IISMOD_RCLK_768FS;
-				break;
-
-			default:
-				return -EINVAL;
-			}
-		}
-
-		reg = readl(s3c2412_i2s.regs + S3C2412_IISMOD);
-		reg &= ~S3C2412_IISMOD_RCLK_MASK;
-		writel(reg | div, i2s->regs + S3C2412_IISMOD);
-		DBG("%s: MOD=%08x\n", __func__, readl(i2s->regs + S3C2412_IISMOD));
-		break;
-
-	case S3C2412_DIV_PRESCALER:
-		if (div >= 0) {
-			writel((div << 8) | S3C2412_IISPSR_PSREN,
-			       i2s->regs + S3C2412_IISPSR);
-		} else {
-			writel(0x0, i2s->regs + S3C2412_IISPSR);
-		}
-		DBG("%s: PSR=%08x\n", __func__, readl(i2s->regs + S3C2412_IISPSR));
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
 
 struct clk *s3c2412_get_iisclk(void)
 {
@@ -604,20 +113,16 @@ EXPORT_SYMBOL_GPL(s3c2412_get_iisclk);
 static int s3c2412_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
 {
+	int ret;
+
 	DBG("Entered %s\n", __func__);
 
-	s3c2412_i2s.dev = &pdev->dev;
+	ret = s3c_i2sv2_probe(pdev, dai, &s3c2412_i2s, S3C2410_PA_IIS);
+	if (ret)
+		return ret;
 
-	s3c2412_i2s.regs = ioremap(S3C2410_PA_IIS, 0x100);
-	if (s3c2412_i2s.regs == NULL)
-		return -ENXIO;
-
-	s3c2412_i2s.iis_pclk = clk_get(&pdev->dev, "iis");
-	if (s3c2412_i2s.iis_pclk == NULL) {
-		DBG("failed to get iis_clock\n");
-		iounmap(s3c2412_i2s.regs);
-		return -ENODEV;
-	}
+	s3c2412_i2s.dma_capture = &s3c2412_i2s_pcm_stereo_in;
+	s3c2412_i2s.dma_playback = &s3c2412_i2s_pcm_stereo_out;
 
 	s3c2412_i2s.iis_cclk = clk_get(&pdev->dev, "i2sclk");
 	if (s3c2412_i2s.iis_cclk == NULL) {
@@ -626,12 +131,12 @@ static int s3c2412_i2s_probe(struct plat
 		return -ENODEV;
 	}
 
-	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
+	/* Set MPLL as the source for IIS CLK */
 
-	clk_enable(s3c2412_i2s.iis_pclk);
+	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
 	clk_enable(s3c2412_i2s.iis_cclk);
 
-	s3c2412_i2s.iis_clk = s3c2412_i2s.iis_pclk;
+	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
 
 	/* Configure the I2S pins in correct mode */
 	s3c2410_gpio_cfgpin(S3C2410_GPE0, S3C2410_GPE0_I2SLRCK);
@@ -640,78 +145,18 @@ static int s3c2412_i2s_probe(struct plat
 	s3c2410_gpio_cfgpin(S3C2410_GPE3, S3C2410_GPE3_I2SSDI);
 	s3c2410_gpio_cfgpin(S3C2410_GPE4, S3C2410_GPE4_I2SSDO);
 
-	s3c2412_snd_txctrl(0);
-	s3c2412_snd_rxctrl(0);
-
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
-{
-	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
-	u32 iismod;
-
-	if (dai->active) {
-		i2s->suspend_iismod = readl(i2s->regs + S3C2412_IISMOD);
-		i2s->suspend_iiscon = readl(i2s->regs + S3C2412_IISCON);
-		i2s->suspend_iispsr = readl(i2s->regs + S3C2412_IISPSR);
-
-		/* some basic suspend checks */
-
-		iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-		if (iismod & S3C2412_IISCON_RXDMA_ACTIVE)
-			pr_warning("%s: RXDMA active?\n", __func__);
-
-		if (iismod & S3C2412_IISCON_TXDMA_ACTIVE)
-			pr_warning("%s: TXDMA active?\n", __func__);
-
-		if (iismod & S3C2412_IISCON_IIS_ACTIVE)
-			pr_warning("%s: IIS active\n", __func__);
-	}
-
-	return 0;
-}
-
-static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
-{
-	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
-
-	pr_info("dai_active %d, IISMOD %08x, IISCON %08x\n",
-		dai->active, i2s->suspend_iismod, i2s->suspend_iiscon);
-
-	if (dai->active) {
-		writel(i2s->suspend_iiscon, i2s->regs + S3C2412_IISCON);
-		writel(i2s->suspend_iismod, i2s->regs + S3C2412_IISMOD);
-		writel(i2s->suspend_iispsr, i2s->regs + S3C2412_IISPSR);
-
-		writel(S3C2412_IISFIC_RXFLUSH | S3C2412_IISFIC_TXFLUSH,
-		       i2s->regs + S3C2412_IISFIC);
-
-		ndelay(250);
-		writel(0x0, i2s->regs + S3C2412_IISFIC);
-
-	}
-
-	return 0;
-}
-#else
-#define s3c2412_i2s_suspend NULL
-#define s3c2412_i2s_resume  NULL
-#endif /* CONFIG_PM */
-
 #define S3C2412_I2S_RATES \
 	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
 	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 struct snd_soc_dai s3c2412_i2s_dai = {
-	.name	= "s3c2412-i2s",
-	.id	= 0,
-	.probe	= s3c2412_i2s_probe,
-	.suspend = s3c2412_i2s_suspend,
-	.resume = s3c2412_i2s_resume,
+	.name		= "s3c2412-i2s",
+	.id		= 0,
+	.probe		= s3c2412_i2s_probe,
 	.playback = {
 		.channels_min	= 2,
 		.channels_max	= 2,
@@ -725,10 +170,6 @@ struct snd_soc_dai s3c2412_i2s_dai = {
 		.formats	= SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.ops = {
-		.trigger	= s3c2412_i2s_trigger,
-		.hw_params	= s3c2412_i2s_hw_params,
-		.set_fmt	= s3c2412_i2s_set_fmt,
-		.set_clkdiv	= s3c2412_i2s_set_clkdiv,
 		.set_sysclk	= s3c2412_i2s_set_sysclk,
 	},
 };
@@ -736,7 +177,7 @@ EXPORT_SYMBOL_GPL(s3c2412_i2s_dai);
 
 static int __init s3c2412_i2s_init(void)
 {
-	return snd_soc_register_dai(&s3c2412_i2s_dai);
+	return  s3c_i2sv2_register_dai(&s3c2412_i2s_dai);
 }
 module_init(s3c2412_i2s_init);
 
@@ -746,7 +187,6 @@ static void __exit s3c2412_i2s_exit(void
 }
 module_exit(s3c2412_i2s_exit);
 
-
 /* Module information */
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("S3C2412 I2S SoC Interface");
Index: linux.git/sound/soc/s3c24xx/jive_wm8750.c
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/jive_wm8750.c	2009-02-28 20:41:43.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/jive_wm8750.c	2009-02-28 20:41:45.000000000 +0000
@@ -65,7 +65,7 @@ static int jive_hw_params(struct snd_pcm
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct s3c2412_rate_calc div;
+	struct s3c_i2sv2_rate_calc div;
 	unsigned int clk = 0;
 	int ret = 0;
 
@@ -83,8 +83,8 @@ static int jive_hw_params(struct snd_pcm
 		break;
 	}
 
-	s3c2412_iis_calc_rate(&div, NULL, params_rate(params),
-			      s3c2412_get_iisclk());
+	s3c_i2sv2_calc_rate(&div, NULL, params_rate(params),
+			    s3c2412_get_iisclk());
 
 	/* set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
Index: linux.git/sound/soc/s3c24xx/s3c2412-i2s.h
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/s3c2412-i2s.h	2009-02-23 10:41:21.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/s3c2412-i2s.h	2009-02-28 20:41:45.000000000 +0000
@@ -15,9 +15,11 @@
 #ifndef __SND_SOC_S3C24XX_S3C2412_I2S_H
 #define __SND_SOC_S3C24XX_S3C2412_I2S_H __FILE__
 
-#define S3C2412_DIV_BCLK	(1)
-#define S3C2412_DIV_RCLK	(2)
-#define S3C2412_DIV_PRESCALER	(3)
+#include "s3c-i2s-v2.h"
+
+#define S3C2412_DIV_BCLK	S3C_I2SV2_DIV_BCLK
+#define S3C2412_DIV_RCLK	S3C_I2SV2_DIV_RCLK
+#define S3C2412_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
 
 #define S3C2412_CLKSRC_PCLK	(0)
 #define S3C2412_CLKSRC_I2SCLK	(1)
@@ -26,13 +28,4 @@ extern struct clk *s3c2412_get_iisclk(vo
 
 extern struct snd_soc_dai s3c2412_i2s_dai;
 
-struct s3c2412_rate_calc {
-	unsigned int	clk_div;	/* for prescaler */
-	unsigned int	fs_div;		/* for root frame clock */
-};
-
-extern int s3c2412_iis_calc_rate(struct s3c2412_rate_calc *info,
-				 unsigned int *fstab,
-				 unsigned int rate, struct clk *clk);
-
 #endif /* __SND_SOC_S3C24XX_S3C2412_I2S_H */
Index: linux.git/sound/soc/s3c24xx/Kconfig
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/Kconfig	2009-02-28 20:41:43.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/Kconfig	2009-02-28 20:57:34.000000000 +0000
@@ -9,8 +9,12 @@ config SND_S3C24XX_SOC
 config SND_S3C24XX_SOC_I2S
 	tristate
 
+config SND_S3C_I2SV2_SOC
+	tristate
+
 config SND_S3C2412_SOC_I2S
 	tristate
+	select SND_S3C_I2SV2_SOC
 
 config SND_S3C2443_SOC_AC97
 	tristate
Index: linux.git/sound/soc/s3c24xx/Makefile
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/Makefile	2009-02-28 20:41:43.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/Makefile	2009-02-28 20:57:34.000000000 +0000
@@ -3,11 +3,13 @@ snd-soc-s3c24xx-objs := s3c24xx-pcm.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
 snd-soc-s3c2443-ac97-objs := s3c2443-ac97.o
+snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
 obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
 obj-$(CONFIG_SND_S3C2443_SOC_AC97) += snd-soc-s3c2443-ac97.o
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
+obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
 
 # S3C24XX Machine Support
 snd-soc-jive-wm8750-objs := jive_wm8750.o

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
