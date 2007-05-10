From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH1/5] ASoC S3C24xx machine drivers - s3c2443-AC97
Date: Thu, 10 May 2007 14:00:13 +0100
Message-ID: <1178802013.10518.69.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Bm2/dZWDk9vROCKw6s1V"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id D1B502438C
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:00:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--=-Bm2/dZWDk9vROCKw6s1V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry for the lateness in the current merge window of this patch
series.  

From: Graeme Gregory <gg@opensource.wolfsonmicro.com>

This patch adds AC97 support to the Samsung S3C2443 CPU. 

Signed-off-by: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

--=-Bm2/dZWDk9vROCKw6s1V
Content-Disposition: attachment; filename=s3c2443-ac97.patch
Content-Type: text/x-patch; name=s3c2443-ac97.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/s3c24xx/s3c2443-ac97.c	Wed May 09 13:54:02 2007 +0100
@@ -0,0 +1,405 @@
+/*
+ * s3c2443-ac97.c  --  ALSA Soc Audio Layer
+ *
+ * (c) 2007 Wolfson Microelectronics PLC.
+ * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  Copyright (C) 2005, Sean Choi <sh428.choi@samsung.com>
+ *  All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  Revision history
+ *	21st Mar 2007   Initial Version
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/arch/regs-ac97.h>
+#include <asm/arch/regs-gpio.h>
+#include <asm/arch/regs-clock.h>
+#include <asm/arch/audio.h>
+#include <asm/dma.h>
+#include <asm/arch/dma.h>
+
+#include "s3c24xx-pcm.h"
+#include "s3c24xx-ac97.h"
+
+struct s3c24xx_ac97_info {
+	void __iomem	*regs;
+	struct clk	*ac97_clk;
+};
+static struct s3c24xx_ac97_info s3c24xx_ac97;
+
+static struct completion ac97_completion;
+static u32 codec_ready;
+static DECLARE_MUTEX(ac97_mutex);
+
+static unsigned short s3c2443_ac97_read(struct snd_ac97 *ac97,
+	unsigned short reg)
+{
+	u32 ac_glbctrl;
+	u32 ac_codec_cmd;
+	u32 stat, addr, data;
+
+	down(&ac97_mutex);
+
+	/* Initialise the completion used in ISR */
+	init_completion(&ac97_completion);
+
+	codec_ready = S3C_AC97_GLBSTAT_CODECREADY;
+	ac_codec_cmd = readl(s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
+	ac_codec_cmd = S3C_AC97_CODEC_CMD_READ | AC_CMD_ADDR(reg);
+	writel(ac_codec_cmd, s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
+
+	udelay(50);
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+
+	wait_for_completion(&ac97_completion);
+
+	stat = readl(s3c24xx_ac97.regs + S3C_AC97_STAT);
+	addr = (stat >> 16) & 0x7f;
+	data = (stat & 0xffff);
+
+	if (addr != reg)
+		printk(KERN_ERR "s3c24xx-ac97: req addr = %02x, rep addr = %02x\n", reg, addr);
+
+	up(&ac97_mutex);
+
+	return (unsigned short)data;
+}
+
+static void s3c2443_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+	unsigned short val)
+{
+	u32 ac_glbctrl;
+	u32 ac_codec_cmd;
+
+	down(&ac97_mutex);
+
+	init_completion(&ac97_completion);
+
+	codec_ready = S3C_AC97_GLBSTAT_CODECREADY;
+	ac_codec_cmd = readl(s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
+	ac_codec_cmd = AC_CMD_ADDR(reg) | AC_CMD_DATA(val);
+	writel(ac_codec_cmd, s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
+
+	udelay(50);
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+
+	wait_for_completion(&ac97_completion);
+
+	ac_codec_cmd = readl(s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
+	ac_codec_cmd |= S3C_AC97_CODEC_CMD_READ;
+	writel(ac_codec_cmd, s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
+
+	up(&ac97_mutex);
+
+}
+
+static void s3c2443_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	u32 ac_glbctrl;
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl = S3C_AC97_GLBCTRL_WARMRESET;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+
+	ac_glbctrl = 0;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+}
+
+static void s3c2443_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+	u32 ac_glbctrl;
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl = S3C_AC97_GLBCTRL_COLDRESET;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+
+	ac_glbctrl = 0;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl = S3C_AC97_GLBCTRL_ACLINKON;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+
+	ac_glbctrl |= S3C_AC97_GLBCTRL_TRANSFERDATAENABLE;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+
+	ac_glbctrl |= S3C_AC97_GLBCTRL_PCMOUTTM_DMA |
+		S3C_AC97_GLBCTRL_PCMINTM_DMA | S3C_AC97_GLBCTRL_MICINTM_DMA;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+}
+
+static irqreturn_t s3c2443_ac97_irq(int irq, void *dev_id)
+{
+	int status;
+	u32 ac_glbctrl;
+
+	status = readl(s3c24xx_ac97.regs + S3C_AC97_GLBSTAT) & codec_ready;
+
+	if (status) {
+	    ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	    ac_glbctrl &= ~S3C_AC97_GLBCTRL_CODECREADYIE;
+	    writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+		complete(&ac97_completion);
+	}
+	return IRQ_HANDLED;
+}
+
+struct snd_ac97_bus_ops soc_ac97_ops = {
+	.read	= s3c2443_ac97_read,
+	.write	= s3c2443_ac97_write,
+	.warm_reset	= s3c2443_ac97_warm_reset,
+	.reset	= s3c2443_ac97_cold_reset,
+};
+
+static struct s3c2410_dma_client s3c2443_dma_client_out = {
+	.name = "AC97 PCM Stereo out"
+};
+
+static struct s3c2410_dma_client s3c2443_dma_client_in = {
+	.name = "AC97 PCM Stereo in"
+};
+
+static struct s3c2410_dma_client s3c2443_dma_client_micin = {
+	.name = "AC97 Mic Mono in"
+};
+
+static struct s3c24xx_pcm_dma_params s3c2443_ac97_pcm_stereo_out = {
+	.client		= &s3c2443_dma_client_out,
+	.channel	= DMACH_PCM_OUT,
+	.dma_addr	= S3C2440_PA_AC97 + S3C_AC97_PCM_DATA,
+	.dma_size	= 4,
+};
+
+static struct s3c24xx_pcm_dma_params s3c2443_ac97_pcm_stereo_in = {
+	.client		= &s3c2443_dma_client_in,
+	.channel	= DMACH_PCM_IN,
+	.dma_addr	= S3C2440_PA_AC97 + S3C_AC97_PCM_DATA,
+	.dma_size	= 4,
+};
+
+static struct s3c24xx_pcm_dma_params s3c2443_ac97_mic_mono_in = {
+	.client		= &s3c2443_dma_client_micin,
+	.channel	= DMACH_MIC_IN,
+	.dma_addr	= S3C2440_PA_AC97 + S3C_AC97_MIC_DATA,
+	.dma_size	= 4,
+};
+
+static int s3c2443_ac97_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 ac_glbctrl;
+
+	s3c24xx_ac97.regs = ioremap(S3C2440_PA_AC97, 0x100);
+	if (s3c24xx_ac97.regs == NULL)
+		return -ENXIO;
+
+	s3c24xx_ac97.ac97_clk = clk_get(&pdev->dev, "ac97");
+	if (s3c24xx_ac97.ac97_clk == NULL) {
+		printk(KERN_ERR "s3c2443-ac97 failed to get ac97_clock\n");
+		iounmap(s3c24xx_ac97.regs);
+		return -ENODEV;
+	}
+	clk_enable(s3c24xx_ac97.ac97_clk);
+
+	s3c2410_gpio_cfgpin(S3C2410_GPE0, S3C2443_GPE0_AC_nRESET);
+	s3c2410_gpio_cfgpin(S3C2410_GPE1, S3C2443_GPE1_AC_SYNC);
+	s3c2410_gpio_cfgpin(S3C2410_GPE2, S3C2443_GPE2_AC_BITCLK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE3, S3C2443_GPE3_AC_SDI);
+	s3c2410_gpio_cfgpin(S3C2410_GPE4, S3C2443_GPE4_AC_SDO);
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl = S3C_AC97_GLBCTRL_COLDRESET;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+
+	ac_glbctrl = 0;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl = S3C_AC97_GLBCTRL_ACLINKON;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	udelay(1000);
+
+	ac_glbctrl |= S3C_AC97_GLBCTRL_TRANSFERDATAENABLE;
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+
+	ret = request_irq(IRQ_S3C2443_AC97, s3c2443_ac97_irq,
+		IRQF_DISABLED, "AC97", NULL);
+	if (ret < 0) {
+		printk(KERN_ERR "s3c24xx-ac97: interrupt request failed.\n");
+		clk_disable(s3c24xx_ac97.ac97_clk);
+		clk_put(s3c24xx_ac97.ac97_clk);
+		iounmap(s3c24xx_ac97.regs);
+	}
+	return ret;
+}
+
+static void s3c2443_ac97_remove(struct platform_device *pdev)
+{
+	free_irq(IRQ_S3C2443_AC97, NULL);
+	clk_disable(s3c24xx_ac97.ac97_clk);
+	clk_put(s3c24xx_ac97.ac97_clk);
+	iounmap(s3c24xx_ac97.regs);
+}
+
+static int s3c2443_ac97_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		cpu_dai->dma_data = &s3c2443_ac97_pcm_stereo_out;
+	else
+		cpu_dai->dma_data = &s3c2443_ac97_pcm_stereo_in;
+
+	return 0;
+}
+
+static int s3c2443_ac97_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	u32 ac_glbctrl;
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	switch(cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			ac_glbctrl |= S3C_AC97_GLBCTRL_PCMINTM_DMA;
+		else
+			ac_glbctrl |= S3C_AC97_GLBCTRL_PCMOUTTM_DMA;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMINTM_MASK;
+		else
+			ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMOUTTM_MASK;
+		break;
+	}
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+
+	return 0;
+}
+
+static int s3c2443_ac97_hw_mic_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return -ENODEV;
+	else
+		cpu_dai->dma_data = &s3c2443_ac97_mic_mono_in;
+
+	return 0;
+}
+
+static int s3c2443_ac97_mic_trigger(struct snd_pcm_substream *substream,
+	int cmd)
+{
+	u32 ac_glbctrl;
+
+	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+	switch(cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ac_glbctrl |= S3C_AC97_GLBCTRL_PCMINTM_DMA;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMINTM_MASK;
+	}
+	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
+
+	return 0;
+}
+
+#define s3c2443_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
+struct snd_soc_cpu_dai s3c2443_ac97_dai[] = {
+{
+	.name = "s3c2443-ac97",
+	.id = 0,
+	.type = SND_SOC_DAI_AC97,
+	.probe = s3c2443_ac97_probe,
+	.remove = s3c2443_ac97_remove,
+	.playback = {
+		.stream_name = "AC97 Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = s3c2443_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.stream_name = "AC97 Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = s3c2443_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.ops = {
+		.hw_params = s3c2443_ac97_hw_params,
+		.trigger = s3c2443_ac97_trigger},
+},
+{
+	.name = "pxa2xx-ac97-mic",
+	.id = 1,
+	.type = SND_SOC_DAI_AC97,
+	.capture = {
+		.stream_name = "AC97 Mic Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = s3c2443_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.ops = {
+		.hw_params = s3c2443_ac97_hw_mic_params,
+		.trigger = s3c2443_ac97_mic_trigger,},
+},
+};
+
+EXPORT_SYMBOL_GPL(s3c2443_ac97_dai);
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+MODULE_AUTHOR("Graeme Gregory");
+MODULE_DESCRIPTION("AC97 driver for the Samsung s3c2443 chip");
+MODULE_LICENSE("GPL");
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/s3c24xx/s3c24xx-ac97.h	Tue May 08 10:16:09 2007 +0100
@@ -0,0 +1,25 @@
+/*
+ * s3c24xx-ac97.c  --  ALSA Soc Audio Layer
+ *
+ * (c) 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Revision history
+ *    10th Nov 2006   Initial version.
+ */
+
+#ifndef S3C24XXAC97_H_
+#define S3C24XXAC97_H_
+
+#define AC_CMD_ADDR(x) (x << 16)
+#define AC_CMD_DATA(x) (x & 0xffff)
+
+extern struct snd_soc_cpu_dai s3c2443_ac97_dai[];
+
+#endif /*S3C24XXAC97_H_*/

--=-Bm2/dZWDk9vROCKw6s1V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-Bm2/dZWDk9vROCKw6s1V--
