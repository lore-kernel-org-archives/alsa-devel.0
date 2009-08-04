From: javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH 3/3] ASoC: add machine driver for
	i.mx27_visstrim_m10 board
Date: Tue, 4 Aug 2009 17:18:02 +0200
Message-ID: <eedb5540908040818j3ba586ceq124016bb7eb9d7b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 910612440D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 17:18:02 +0200 (CEST)
Received: by mail-ew0-f223.google.com with SMTP id 23so563551ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 04 Aug 2009 08:18:02 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This adds support for i.mx27_visstrim_sm10 board machine driver which
uses an i.mx27 processor plus a wm8974 codec.

It has been tested on a visstrim_sm10 board.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/imx/Kconfig          |    8 +
 sound/soc/imx/Makefile         |    4 +
 sound/soc/imx/mx27vis_wm8974.c |  317 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 329 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 886dadd..2c6f568 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -9,5 +9,13 @@ config SND_MX1_MX2_SOC
 config SND_MXC_SOC_SSI
 	tristate

+config SND_SOC_MX27VIS_WM8974
+	tristate "SoC Audio support for MX27 - WM8974 Visstrim_sm10 board"
+	depends on SND_MX1_MX2_SOC && MACH_MX27 && MACH_IMX27_VISSTRIM_M10
+	select SND_MXC_SOC_SSI
+	select SND_SOC_WM8974
+	help
+	  Say Y if you want to add support for SoC audio on Visstrim SM10
+	  board with WM8974.


diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index 6552cb2..c2ffd2c 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -4,3 +4,7 @@ snd-soc-mxc-ssi-objs := mxc-ssi.o

 obj-$(CONFIG_SND_MX1_MX2_SOC) += snd-soc-mx1_mx2.o
 obj-$(CONFIG_SND_MXC_SOC_SSI) += snd-soc-mxc-ssi.o
+
+# i.MX Machine Support
+snd-soc-mx27vis-wm8974-objs := mx27vis_wm8974.o
+obj-$(CONFIG_SND_SOC_MX27VIS_WM8974) += snd-soc-mx27vis-wm8974.o
diff --git a/sound/soc/imx/mx27vis_wm8974.c b/sound/soc/imx/mx27vis_wm8974.c
new file mode 100644
index 0000000..e4dcb53
--- /dev/null
+++ b/sound/soc/imx/mx27vis_wm8974.c
@@ -0,0 +1,317 @@
+/*
+ * mx27vis_wm8974.c  --  SoC audio for mx27vis
+ *
+ * Copyright 2009 Vista Silicon S.L.
+ * Author: Javier Martin
+ *         javier.martin@vista-silicon.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+
+#include "../codecs/wm8974.h"
+#include "mx1_mx2-pcm.h"
+#include "mxc-ssi.h"
+#include <mach/gpio.h>
+#include <mach/iomux.h>
+
+#define IGNORED_ARG 0
+
+
+static struct snd_soc_card mx27vis;
+
+/**
+  * This function connects SSI1 (HPCR1) as slave to
+  * SSI1 external signals (PPCR1)
+  * As slave, HPCR1 must set TFSDIR and TCLKDIR as inputs from
+  * port 4
+  */
+void audmux_connect_1_4(void)
+{
+	pr_debug("AUDMUX: normal operation mode\n");
+	/* Reset HPCR1 and PPCR1 */
+
+	DAM_HPCR1 = 0x00000000;
+	DAM_PPCR1 = 0x00000000;
+
+	/* set to synchronous */
+	DAM_HPCR1 |= AUDMUX_HPCR_SYN;
+	DAM_PPCR1 |= AUDMUX_PPCR_SYN;
+
+
+	/* set Rx sources 1 <--> 4 */
+	DAM_HPCR1 |= AUDMUX_HPCR_RXDSEL(3); /* port 4 */
+	DAM_PPCR1 |= AUDMUX_PPCR_RXDSEL(0); /* port 1 */
+
+	/* set Tx frame and Clock direction and source  4 --> 1 output */
+	DAM_HPCR1 |= AUDMUX_HPCR_TFSDIR | AUDMUX_HPCR_TCLKDIR;
+	DAM_HPCR1 |= AUDMUX_HPCR_TFCSEL(3); /* TxDS and TxCclk from port 4 */
+
+	return;
+}
+
+static int mx27vis_hifi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int pll_out = 0, bclk = 0, fmt = 0, mclk = 0;
+	int ret = 0;
+
+	/*
+	 * The WM8974 is better at generating accurate audio clocks than the
+	 * MX27 SSI controller, so we will use it as master when we can.
+	 */
+	switch (params_rate(params)) {
+	case 8000:
+		fmt = SND_SOC_DAIFMT_CBM_CFM;
+		mclk = WM8974_MCLKDIV_12;
+		pll_out = 24576000;
+		break;
+	case 16000:
+		fmt = SND_SOC_DAIFMT_CBM_CFM;
+		pll_out = 12288000;
+		break;
+	case 48000:
+		fmt = SND_SOC_DAIFMT_CBM_CFM;
+		bclk = WM8974_BCLKDIV_4;
+		pll_out = 12288000;
+		break;
+	case 96000:
+		fmt = SND_SOC_DAIFMT_CBM_CFM;
+		bclk = WM8974_BCLKDIV_2;
+		pll_out = 12288000;
+		break;
+	case 11025:
+		fmt = SND_SOC_DAIFMT_CBM_CFM;
+		bclk = WM8974_BCLKDIV_16;
+		pll_out = 11289600;
+		break;
+	case 22050:
+		fmt = SND_SOC_DAIFMT_CBM_CFM;
+		bclk = WM8974_BCLKDIV_8;
+		pll_out = 11289600;
+		break;
+	case 44100:
+		fmt = SND_SOC_DAIFMT_CBM_CFM;
+		bclk = WM8974_BCLKDIV_4;
+		mclk = WM8974_MCLKDIV_2;
+		pll_out = 11289600;
+		break;
+	case 88200:
+		fmt = SND_SOC_DAIFMT_CBM_CFM;
+		bclk = WM8974_BCLKDIV_2;
+		pll_out = 11289600;
+		break;
+	}
+
+	/* set codec DAI configuration */
+	ret = codec_dai->ops->set_fmt(codec_dai,
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+		SND_SOC_DAIFMT_SYNC | fmt);
+	if (ret < 0) {
+		printk(KERN_ERR "Error from codec DAI configuration\n");
+		return ret;
+	}
+
+	/* set cpu DAI configuration */
+	ret = cpu_dai->ops->set_fmt(cpu_dai,
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_SYNC | fmt);
+	if (ret < 0) {
+		printk(KERN_ERR "Error from cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Put DC field of STCCR to 1 (not zero) */
+	ret = cpu_dai->ops->set_tdm_slot(cpu_dai, 0, 2);
+
+	/* set the SSI system clock as input */
+	ret = cpu_dai->ops->set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "Error when setting system SSI clk\n");
+		return ret;
+	}
+
+	/* set codec BCLK division for sample rate */
+	ret = codec_dai->ops->set_clkdiv(codec_dai, WM8974_BCLKDIV, bclk);
+	if (ret < 0) {
+		printk(KERN_ERR "Error when setting BCLK division\n");
+		return ret;
+	}
+
+
+	/* codec PLL input is 25 MHz */
+	ret = codec_dai->ops->set_pll(codec_dai, IGNORED_ARG,
+					25000000, pll_out);
+	if (ret < 0) {
+		printk(KERN_ERR "Error when setting PLL input\n");
+		return ret;
+	}
+
+	/*set codec MCLK division for sample rate */
+	ret = codec_dai->ops->set_clkdiv(codec_dai, WM8974_MCLKDIV, mclk);
+	if (ret < 0) {
+		printk(KERN_ERR "Error when setting MCLK division\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mx27vis_hifi_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	/* disable the PLL */
+	return codec_dai->ops->set_pll(codec_dai, IGNORED_ARG, 0, 0);
+}
+
+/*
+ * mx27vis WM8974 HiFi DAI opserations.
+ */
+static struct snd_soc_ops mx27vis_hifi_ops = {
+	.hw_params = mx27vis_hifi_hw_params,
+	.hw_free = mx27vis_hifi_hw_free,
+};
+
+
+static int mx27vis_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	return 0;
+}
+
+static int mx27vis_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int mx27vis_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+
+	ret = get_ssi_clk(0, &pdev->dev);
+
+	if (ret < 0) {
+		printk(KERN_ERR "%s: cant get ssi clock\n", __func__);
+		return ret;
+	}
+
+
+	return 0;
+}
+
+static int mx27vis_remove(struct platform_device *pdev)
+{
+	put_ssi_clk(0);
+	return 0;
+}
+
+static struct snd_soc_dai_link mx27vis_dai[] = {
+{ /* Hifi Playback*/
+	.name = "WM8974",
+	.stream_name = "WM8974 HiFi",
+	.cpu_dai = &imx_ssi_pcm_dai[0],
+	.codec_dai = &wm8974_dai,
+	.ops = &mx27vis_hifi_ops,
+},
+};
+
+static struct snd_soc_card mx27vis = {
+	.name = "mx27vis",
+	.platform = &mx1_mx2_soc_platform,
+	.probe = mx27vis_probe,
+	.remove = mx27vis_remove,
+	.suspend_pre = mx27vis_suspend,
+	.resume_post = mx27vis_resume,
+	.dai_link = mx27vis_dai,
+	.num_links = ARRAY_SIZE(mx27vis_dai),
+};
+
+static struct snd_soc_device mx27vis_snd_devdata = {
+	.card = &mx27vis,
+	.codec_dev = &soc_codec_dev_wm8974,
+};
+
+static struct platform_device *mx27vis_snd_device;
+
+/* Temporal definition of board specific behaviour */
+void gpio_ssi_active(int ssi_num)
+{
+	int ret = 0;
+
+	unsigned int ssi1_pins[] = {
+		PC20_PF_SSI1_FS,
+		PC21_PF_SSI1_RXD,
+		PC22_PF_SSI1_TXD,
+		PC23_PF_SSI1_CLK,
+	};
+	unsigned int ssi2_pins[] = {
+		PC24_PF_SSI2_FS,
+		PC25_PF_SSI2_RXD,
+		PC26_PF_SSI2_TXD,
+		PC27_PF_SSI2_CLK,
+	};
+	if (ssi_num == 0)
+		ret = mxc_gpio_setup_multiple_pins(ssi1_pins,
+				ARRAY_SIZE(ssi1_pins), "USB OTG");
+	else
+		ret = mxc_gpio_setup_multiple_pins(ssi2_pins,
+				ARRAY_SIZE(ssi2_pins), "USB OTG");
+	if (ret)
+		printk(KERN_ERR "Error requesting ssi %x pins\n", ssi_num);
+}
+
+
+static int __init mx27vis_init(void)
+{
+	int ret;
+
+	mx27vis_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!mx27vis_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(mx27vis_snd_device, &mx27vis_snd_devdata);
+	mx27vis_snd_devdata.dev = &mx27vis_snd_device->dev;
+	ret = platform_device_add(mx27vis_snd_device);
+
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		platform_device_put(mx27vis_snd_device);
+	}
+
+	/* WM8974 uses SSI1 (HPCR1) via AUDMUX port 4 for audio (PPCR1) */
+	gpio_ssi_active(0);
+	audmux_connect_1_4();
+
+	return ret;
+}
+
+static void __exit mx27vis_exit(void)
+{
+	/* We should call some "ssi_gpio_inactive()" properly */
+}
+
+module_init(mx27vis_init);
+module_exit(mx27vis_exit);
+
+
+MODULE_AUTHOR("Javier Martin, javier.martin@vista-silicon.com");
+MODULE_DESCRIPTION("ALSA SoC WM8974 mx27vis");
+MODULE_LICENSE("GPL");
---

-- 
Javier Martin
Vista Silicon S.L.
Universidad de Cantabria
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
