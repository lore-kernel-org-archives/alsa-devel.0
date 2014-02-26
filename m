From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] ASoC: Add driver for CLPS711X DAI interface
Date: Wed, 26 Feb 2014 20:05:41 +0400
Message-ID: <1393430741-16272-2-git-send-email-shc_work@mail.ru>
References: <1393430741-16272-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp25.mail.ru (smtp25.mail.ru [94.100.176.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 525B42657AC
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 17:05:50 +0100 (CET)
In-Reply-To: <1393430741-16272-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org

This patch adds a driver for the DAI interface found on Cirrus Logic
CLPS711X family CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/cirrus/Kconfig        |   8 +
 sound/soc/cirrus/Makefile       |   5 +
 sound/soc/cirrus/clps711x-dai.c | 522 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/cirrus/clps711x-dai.h |  61 +++++
 sound/soc/cirrus/clps711x-fiq.S |  56 +++++
 5 files changed, 652 insertions(+)
 create mode 100644 sound/soc/cirrus/clps711x-dai.c
 create mode 100644 sound/soc/cirrus/clps711x-dai.h
 create mode 100644 sound/soc/cirrus/clps711x-fiq.S

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index c872dac..bbd25cd 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -1,3 +1,11 @@
+config SND_CLPS711X_SOC
+	tristate "SoC Audio support for the Cirrus Logic CLPS711X CPUs"
+	depends on ARCH_CLPS711X || (ARM && COMPILE_TEST)
+	select FIQ
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the CLPS711X DAI interface.
+
 config SND_EP93XX_SOC
 	tristate "SoC Audio support for the Cirrus Logic EP93xx series"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/sound/soc/cirrus/Makefile b/sound/soc/cirrus/Makefile
index 5514146..f5d72fc 100644
--- a/sound/soc/cirrus/Makefile
+++ b/sound/soc/cirrus/Makefile
@@ -1,3 +1,8 @@
+# CLPS711X Platform Support
+snd-soc-clps711x-objs				:= clps711x-dai.o clps711x-fiq.o
+
+obj-$(CONFIG_SND_CLPS711X_SOC)			+= snd-soc-clps711x.o
+
 # EP93xx Platform Support
 snd-soc-ep93xx-objs				:= ep93xx-pcm.o
 snd-soc-ep93xx-i2s-objs	 			:= ep93xx-i2s.o
diff --git a/sound/soc/cirrus/clps711x-dai.c b/sound/soc/cirrus/clps711x-dai.c
new file mode 100644
index 0000000..1910903
--- /dev/null
+++ b/sound/soc/cirrus/clps711x-dai.c
@@ -0,0 +1,522 @@
+/*
+ *  Currus Logic CLPS711X DAI driver
+ *
+ *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/clps711x.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/fiq.h>
+
+#include "clps711x-dai.h"
+
+#define CLPS711X_FMTS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE)
+#define CLPS711X_RATES	(SNDRV_PCM_RATE_8000_48000)
+
+struct clps711x_dai {
+	u32				head;
+	u32				last_ptr;
+
+	struct hrtimer			hrt;
+	unsigned long			reload;
+
+	struct clk			*pll_clk;
+	unsigned long			pll_hz;
+	unsigned long			ext_hz;
+	int				div2;
+
+	void __iomem			*base;
+	int				irq;
+	struct regmap			*syscon;
+
+	struct pt_regs			regs;
+	struct fiq_handler		fiq;
+	atomic_t			running;
+
+	struct snd_pcm_substream	*substream;
+};
+
+static int clps711x_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_LEFT_J)
+		return -EINVAL;
+
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
+		return -EINVAL;
+
+	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int clps711x_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+				   unsigned int freq, int dir)
+{
+	struct clps711x_dai *s = dev_get_drvdata(dai->dev);
+
+	s->ext_hz = freq;
+
+	return 0;
+}
+
+static int clps711x_dai_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
+{
+	struct clps711x_dai *s = dev_get_drvdata(dai->dev);
+
+	s->div2 = div;
+
+	return 0;
+}
+
+static int clps711x_dai_update_best_err(unsigned int clk, unsigned int div,
+					unsigned int rate, int *besterr)
+{
+	int err = abs(DIV_ROUND_CLOSEST(clk, div) - rate);
+
+	if ((*besterr < 0) || (*besterr > err)) {
+		*besterr = err;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int clps711x_dai_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct clps711x_dai *s = dev_get_drvdata(dai->dev);
+	int i, besterr = -1;
+	u32 dai64 = 0;
+
+	if ((params_rate(params) < 8000) || (params_rate(params) > 48000))
+		return -EINVAL;
+
+	if (!s->pll_hz && !s->ext_hz)
+		return -EINVAL;
+
+	/* Find best settings for desired samplerate */
+	for (i = 0x01; (i < 0x80) && besterr && s->pll_hz; i++)
+		if (!clps711x_dai_update_best_err(s->pll_hz, 128 * i,
+						  params_rate(params),
+						  &besterr))
+			dai64 = DAI64FS_AUDIV(i);
+	for (i = 0x01; (i < 0x80) && besterr && s->ext_hz; i++)
+		if (!clps711x_dai_update_best_err(s->ext_hz, 128 * i,
+						  params_rate(params),
+						  &besterr))
+			dai64 = DAI64FS_AUDIV(i) | DAI64FS_AUDIOCLKSRC;
+
+	regmap_update_bits(s->syscon, SYSCON_OFFSET, SYSCON3_128FS,
+			   s->div2 ? SYSCON3_128FS : 0);
+
+	dai64 |= DAI64FS_AUDIOCLKEN | DAI64FS_MCLK256EN;
+	dai64 |= s->div2 ? 0 : DAI64FS_I2SF64;
+	writel(dai64, s->base + DAI64FS);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops clps711x_dai_ops = {
+	.hw_params	= clps711x_dai_hw_params,
+	.set_fmt	= clps711x_dai_set_fmt,
+	.set_clkdiv	= clps711x_dai_set_clkdiv,
+	.set_sysclk	= clps711x_dai_set_sysclk,
+};
+
+static int clps711x_dai_probe(struct snd_soc_dai *dai)
+{
+	struct clps711x_dai *s = dev_get_drvdata(dai->dev);
+
+	snd_soc_dai_set_drvdata(dai, s);
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver clps711x_dai_driver = {
+	.ops	= &clps711x_dai_ops,
+	.probe	= clps711x_dai_probe,
+	.playback = {
+		.stream_name	= "Playback",
+		.formats	= CLPS711X_FMTS,
+		.rates		= CLPS711X_RATES,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+};
+
+static const struct snd_soc_component_driver clps711x_i2s_component = {
+	.name = "clps711x-i2s",
+};
+
+static int clps711x_pcm_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
+	int ret;
+
+	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	if (ret < 0)
+		return ret;
+
+	dai->substream = substream;
+	dai->reload = (1000000000 / params_rate(params)) *
+		    params_period_size(params) / 2;
+
+	local_fiq_disable();
+	get_fiq_regs(&dai->regs);
+	dai->regs.ARM_r8 = (u32)substream->runtime->dma_area;
+	set_fiq_regs(&dai->regs);
+	local_fiq_enable();
+
+	return 0;
+}
+
+static int clps711x_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		atomic_set(&dai->running, 1);
+		hrtimer_start(&dai->hrt, ns_to_ktime(dai->reload),
+			      HRTIMER_MODE_REL);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		atomic_set(&dai->running, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t clps711x_pcm_ptr(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
+
+	return bytes_to_frames(substream->runtime, dai->last_ptr);
+}
+
+static int clps711x_pcm_copy(struct snd_pcm_substream *substream, int channel,
+			     snd_pcm_uframes_t pos, void __user *buf,
+			     snd_pcm_uframes_t count)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
+	int sz = frames_to_bytes(substream->runtime, count);
+
+	if (copy_from_user(substream->runtime->dma_area + dai->head, buf, sz))
+		return -EFAULT;
+
+	local_fiq_disable();
+	dai->head += sz;
+	dai->head %= CLPS711X_SNDBUF_SIZE;
+	local_fiq_enable();
+
+	return 0;
+}
+
+static int clps711x_pcm_silence(struct snd_pcm_substream *substream,
+				int channel, snd_pcm_uframes_t pos,
+				snd_pcm_uframes_t count)
+{
+	return 0;
+}
+
+static enum hrtimer_restart clps711x_pcm_timer(struct hrtimer *hrt)
+{
+	struct clps711x_dai *dai = container_of(hrt, struct clps711x_dai, hrt);
+	u32 delta;
+
+	if (!atomic_read(&dai->running)) {
+		dai->head = 0;
+		dai->last_ptr = 0;
+
+		local_fiq_disable();
+		get_fiq_regs(&dai->regs);
+		dai->regs.ARM_r10 = 0;
+		set_fiq_regs(&dai->regs);
+		local_fiq_enable();
+
+		return HRTIMER_NORESTART;
+	}
+
+	get_fiq_regs(&dai->regs);
+
+	delta = CLPS711X_SNDBUF_SIZE + dai->regs.ARM_r10 - dai->last_ptr;
+	delta %= CLPS711X_SNDBUF_SIZE;
+	if ((delta >= dai->substream->runtime->period_size) ||
+	    (dai->regs.ARM_r10 == dai->head)) {
+		dai->last_ptr = dai->regs.ARM_r10;
+		snd_pcm_period_elapsed(dai->substream);
+	}
+
+	hrtimer_forward_now(hrt, ns_to_ktime(dai->reload));
+
+	return HRTIMER_RESTART;
+}
+
+static const struct snd_pcm_hardware clps711x_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.formats		= CLPS711X_FMTS,
+	.buffer_bytes_max	= CLPS711X_SNDBUF_SIZE,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= CLPS711X_SNDBUF_SIZE / 8,
+	.periods_min		= 4,
+	.periods_max		= CLPS711X_SNDBUF_SIZE / 64 - 1,
+};
+
+static int clps711x_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
+	int ret;
+
+	atomic_set(&dai->running, 0);
+	hrtimer_init(&dai->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dai->hrt.function = clps711x_pcm_timer;
+
+	dai->head = 0;
+	dai->last_ptr = 0;
+
+	get_fiq_regs(&dai->regs);
+	dai->regs.ARM_r9 = (u32)&dai->head;
+	dai->regs.ARM_r10 = 0;
+	dai->regs.ARM_fp = (u32)dai->base;
+	set_fiq_regs(&dai->regs);
+
+	enable_irq(dai->irq);
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_set_runtime_hwparams(substream, &clps711x_pcm_hardware);
+}
+
+static int clps711x_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
+
+	disable_irq(dai->irq);
+	hrtimer_cancel(&dai->hrt);
+
+	return 0;
+}
+
+static const struct snd_pcm_ops clps711x_pcm_ops = {
+	.open		= clps711x_pcm_open,
+	.close		= clps711x_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= clps711x_pcm_hw_params,
+	.hw_free	= snd_pcm_lib_free_pages,
+	.trigger	= clps711x_pcm_trigger,
+	.pointer	= clps711x_pcm_ptr,
+	.copy		= clps711x_pcm_copy,
+	.silence	= clps711x_pcm_silence,
+};
+
+#if defined(CONFIG_SND_CLPS711X_SOC_MODULE)
+irqreturn_t no_action(int irq, void *dev_id)
+{
+	return IRQ_NONE;
+}
+#endif
+
+static int clps711x_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
+	int ret;
+
+	/* Request FIQ */
+	dai->fiq.name = dev_name(rtd->platform->dev);
+	ret = claim_fiq(&dai->fiq);
+	if (ret)
+		return ret;
+
+	/* Request FIQ interrupt */
+	ret = devm_request_irq(rtd->platform->dev, dai->irq, no_action, 0,
+			       dev_name(rtd->platform->dev), NULL);
+	if (ret)
+		return ret;
+
+	/* Install FIQ handler */
+	set_fiq_handler(&daifiq_start, &daifiq_end - &daifiq_start);
+
+	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+		SNDRV_DMA_TYPE_CONTINUOUS, snd_dma_continuous_data(GFP_KERNEL),
+		CLPS711X_SNDBUF_SIZE, CLPS711X_SNDBUF_SIZE);
+}
+
+static void clps711x_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
+	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
+
+	/* Manually free IRQ */
+	devm_free_irq(rtd->platform->dev, dai->irq, NULL);
+
+	release_fiq(&dai->fiq);
+
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static struct snd_soc_platform_driver clps711x_soc_platform_drv = {
+	.ops		= &clps711x_pcm_ops,
+	.pcm_new	= clps711x_pcm_new,
+	.pcm_free	= clps711x_pcm_free,
+};
+
+static int clps711x_enable_fifo(void __iomem *base, u32 channel)
+{
+	unsigned long timeout;
+
+	writel(DAIDR2_FIFOEN | channel, base + DAIDR2);
+	timeout = jiffies + msecs_to_jiffies(5);
+	while (!(readl(base + DAISR) & DAISR_FIFO)) {
+		if (time_is_before_jiffies(timeout))
+			return -ETIMEDOUT;
+		usleep_range(100, 1000);
+	}
+
+	return 0;
+}
+
+static int clps711x_dai_platform_probe(struct platform_device *pdev)
+{
+	unsigned int dai64 = DAI64FS_AUDIOCLKEN | DAI64FS_MCLK256EN;
+	struct device *dev = &pdev->dev;
+	struct clps711x_dai *dai;
+	struct resource *res;
+	int ret;
+
+	/* Check for proper buffer size */
+	BUG_ON(!is_power_of_2(CLPS711X_SNDBUF_SIZE));
+
+	dai = devm_kzalloc(dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	dai->irq = platform_get_irq(pdev, 0);
+	if (dai->irq < 0)
+		return dai->irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dai->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dai->base))
+		return PTR_ERR(dai->base);
+
+	dai->syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
+	if (IS_ERR(dai->syscon))
+		return PTR_ERR(dai->syscon);
+
+	dai->pll_clk = devm_clk_get(dev, "pll");
+	if (IS_ERR(dai->pll_clk))
+		return PTR_ERR(dai->pll_clk);
+
+	dai->pll_hz = clk_get_rate(dai->pll_clk) / 2;
+	if (!dai->pll_hz) {
+		dai64 |= DAI64FS_AUDIOCLKSRC;
+		dev_notice(dev, "Work with external MCLK only\n");
+	}
+
+	platform_set_drvdata(pdev, dai);
+
+	ret = devm_snd_soc_register_component(dev, &clps711x_i2s_component,
+					      &clps711x_dai_driver, 1);
+	if (ret)
+		return ret;
+
+	/* Enable DAI interface */
+	regmap_update_bits(dai->syscon, SYSCON_OFFSET,
+			   SYSCON3_DAISEL | SYSCON3_128FS,
+			   SYSCON3_DAISEL | SYSCON3_128FS);
+
+	/* Clear interrupt flags */
+	writel(~0, dai->base + DAISR);
+
+	/* Enable DAI */
+	writel(DAIR_RESERVED | DAIR_DAIEN | DAIR_ECS | DAIR_LCTM | DAIR_RCTM,
+	       dai->base + DAIR);
+
+	/* Set initial value to DAI register */
+	writel(dai64 | DAI64FS_AUDIV(10), dai->base + DAI64FS);
+
+	/* Enable FIFOs */
+	ret = clps711x_enable_fifo(dai->base, DAIDR2_FIFOLEFT);
+	if (ret)
+		goto out_err;
+	ret = clps711x_enable_fifo(dai->base, DAIDR2_FIFORIGHT);
+	if (ret)
+		goto out_err;
+
+	ret = snd_soc_register_platform(dev, &clps711x_soc_platform_drv);
+
+out_err:
+	if (ret)
+		writel(DAIR_RESERVED, dai->base + DAIR);
+
+	return ret;
+}
+
+static int clps711x_dai_platform_remove(struct platform_device *pdev)
+{
+	struct clps711x_dai *dai = platform_get_drvdata(pdev);
+
+	/* Disable DAI */
+	writel(DAIR_RESERVED, dai->base + DAIR);
+
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id clps711x_dai_dt_ids[] = {
+	{ .compatible = "cirrus,clps711x-dai", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clps711x_dai_dt_ids);
+
+static struct platform_driver clps711x_dai_platform_driver = {
+	.driver	= {
+		.name		= "clps711x-dai",
+		.owner		= THIS_MODULE,
+		.of_match_table	= clps711x_dai_dt_ids,
+	},
+	.probe	= clps711x_dai_platform_probe,
+	.remove	= clps711x_dai_platform_remove,
+};
+module_platform_driver(clps711x_dai_platform_driver);
+
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("CLPS711X DAI driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/cirrus/clps711x-dai.h b/sound/soc/cirrus/clps711x-dai.h
new file mode 100644
index 0000000..c79d26a
--- /dev/null
+++ b/sound/soc/cirrus/clps711x-dai.h
@@ -0,0 +1,61 @@
+/*
+ *  Currus Logic CLPS711X DAI definitions
+ *
+ *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __CLPS711X_DAI_H
+#define __CLPS711X_DAI_H
+
+#include <linux/sizes.h>
+
+#define CLPS711X_SNDBUF_SIZE	SZ_128K
+
+#define DAIR			(0x0000)
+# define DAIR_RESERVED		(0x0404)
+# define DAIR_DAIEN		(1 << 16)
+# define DAIR_ECS		(1 << 17)
+# define DAIR_LCTM		(1 << 19)
+# define DAIR_LCRM		(1 << 20)
+# define DAIR_RCTM		(1 << 21)
+# define DAIR_RCRM		(1 << 22)
+# define DAIR_LBM		(1 << 23)
+#define DAIDR0			(0x0040)
+#define DAIDR1			(0x0080)
+#define DAIDR2			(0x00c0)
+# define DAIDR2_FIFOEN		(1 << 15)
+# define DAIDR2_FIFOLEFT	(0x0d << 16)
+# define DAIDR2_FIFORIGHT	(0x11 << 16)
+#define DAISR			(0x0100)
+# define DAISR_RCTS		(1 << 0)
+# define DAISR_RCRS		(1 << 1)
+# define DAISR_LCTS		(1 << 2)
+# define DAISR_LCRS		(1 << 3)
+# define DAISR_RCTU		(1 << 4)
+# define DAISR_RCRO		(1 << 5)
+# define DAISR_LCTU		(1 << 6)
+# define DAISR_LCRO		(1 << 7)
+# define DAISR_RCNF		(1 << 8)
+# define DAISR_RCNE		(1 << 9)
+# define DAISR_LCNF		(1 << 10)
+# define DAISR_LCNE		(1 << 11)
+# define DAISR_FIFO		(1 << 12)
+#define DAI64FS			(0x0600)
+# define DAI64FS_I2SF64		(1 << 0)
+# define DAI64FS_AUDIOCLKEN	(1 << 1)
+# define DAI64FS_AUDIOCLKSRC	(1 << 2)
+# define DAI64FS_MCLK256EN	(1 << 3)
+# define DAI64FS_LOOPBACK	(1 << 5)
+# define DAI64FS_AUDIV_MASK	(0x7f00)
+# define DAI64FS_AUDIV(x)	(((x) << 8) & DAI64FS_AUDIV_MASK)
+
+#ifndef __ASSEMBLY__
+extern unsigned char daifiq_start, daifiq_end;
+#endif
+
+#endif
diff --git a/sound/soc/cirrus/clps711x-fiq.S b/sound/soc/cirrus/clps711x-fiq.S
new file mode 100644
index 0000000..aa2dfb9
--- /dev/null
+++ b/sound/soc/cirrus/clps711x-fiq.S
@@ -0,0 +1,56 @@
+/*
+ *  Currus Logic CLPS711X DAI FIQ Handler
+ *
+ *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <asm/assembler.h>
+#include <linux/linkage.h>
+
+#include "clps711x-dai.h"
+
+	.text
+	.arm
+
+	.global daifiq_end
+
+ENTRY(daifiq_start)
+	@ r8  - Buffer address
+	@ r9  - Head Pointer
+	@ r10 - Tail Pointer
+	@ r11 - Registers base virtual address
+	# r12 - Temp
+
+daifiq_loop:
+	ldr	r12, [r9]			@ Get Head
+	subs	r12, r12, r10			@ Compare Head & Tail
+	beq	daifiq_play			@ Send zeroes if Head = Tail
+
+	ldr	r12, [r8, r10]			@ Get buffer value
+	add	r10, r10, #4			@ Increment pointer
+	bic	r10, r10, #CLPS711X_SNDBUF_SIZE	@ Mask with buffer size
+
+daifiq_play:
+	@ Put data to FIFOs
+	strh	r12, [r11, #DAIDR1]		@ Left channel
+	mov	r12, r12, lsr #16
+	strh	r12, [r11, #DAIDR0]		@ Right channel
+
+	@ Check DAI Flags (FIFOs not full)
+	ldr	r12, [r11, #DAISR]
+	and	r12, r12, #DAISR_RCNF | DAISR_LCNF
+	cmp	r12, #DAISR_RCNF | DAISR_LCNF
+	beq	daifiq_loop
+
+	@ Clear DAI Interrupt Flags
+	mvn	r12, #0
+	str	r12, [r11, #DAISR]
+
+	@ Return from FIQ
+	subs	pc, lr, #4
+daifiq_end:
-- 
1.8.3.2
