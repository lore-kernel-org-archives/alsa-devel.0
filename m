From: Ivan Kuten <ivan.kuten@promwad.com>
Subject: PATCH: ln2440sbc ac97 support
Date: Fri, 26 Oct 2007 10:54:08 -0100
Message-ID: <20071026105408.4a4fa63b@IvanK.DOMAIN>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from secure.poehali.org (42.242.232.72.static.reverse.ltdomains.com
	[72.232.242.42]) by alsa0.perex.cz (Postfix) with ESMTP id 926ED244FF
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 11:55:41 +0200 (CEST)
Received: from localhost ([127.0.0.1]:59808 helo=IvanK.DOMAIN)
	by secure.poehali.org with smtp (Exim 4.63)
	(envelope-from <ivan.kuten@promwad.com>) id 1IlLui-0002LA-D7
	for alsa-devel@alsa-project.org; Fri, 26 Oct 2007 12:55:36 +0300
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
List-Id: alsa-devel@alsa-project.org

Hello, 

This patch adds ac97 support for ln2440sbc board from LittleChips.
This board is based on s3c2440 SoC + AC97 Realtek ALC650 codec. 
Existing s3c2443 implementation is slightly modified because s3c2440 and s3c2443
have different AC97 interrupts.

Regards,
Ivan

Signed-off-by: Ivan Kuten <ivan.kuten@promwad.com>

diff -urN linux-2.6.23/sound/soc/s3c24xx/Kconfig linux-2.6.23-2440/sound/soc/s3c24xx/Kconfig
--- linux-2.6.23/sound/soc/s3c24xx/Kconfig	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.23-2440/sound/soc/s3c24xx/Kconfig	2007-10-28 01:18:23.000000000 +0200
@@ -34,4 +34,12 @@
 	  Say Y if you want to add support for SoC audio on smdk2443
 	  with the WM9710.
 
+config SND_S3C24XX_SOC_LN2440SBC_ALC650
+	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
+	depends on SND_S3C24XX_SOC
+	select SND_S3C2443_SOC_AC97
+	select SND_SOC_AC97_CODEC
+	help
+	  Say Y if you want to add support for SoC audio on ln2440sbc
+	  with the ALC650.
 
diff -urN linux-2.6.23/sound/soc/s3c24xx/Makefile linux-2.6.23-2440/sound/soc/s3c24xx/Makefile
--- linux-2.6.23/sound/soc/s3c24xx/Makefile	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.23-2440/sound/soc/s3c24xx/Makefile	2007-10-25 01:28:18.000000000 +0200
@@ -10,6 +10,8 @@
 # S3C24XX Machine Support
 snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
 snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
+snd-soc-ln2440sbc-alc650-objs := ln2440sbc_alc650.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
+obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
diff -urN linux-2.6.23/sound/soc/s3c24xx/ln2440sbc_alc650.c linux-2.6.23-2440/sound/soc/s3c24xx/ln2440sbc_alc650.c
--- linux-2.6.23/sound/soc/s3c24xx/ln2440sbc_alc650.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.23-2440/sound/soc/s3c24xx/ln2440sbc_alc650.c	2007-10-28 00:27:41.000000000 +0200
@@ -0,0 +1,86 @@
+/*
+ * SoC audio for ln2440sbc
+ * 
+ * Copyright 2007 KonekTel, a.s.
+ * Author: Ivan Kuten
+ *         ivan.kuten@promwad.com
+ * 
+ * Heavily based on smdk2443_wm9710.c
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "../codecs/ac97.h"
+#include "s3c24xx-pcm.h"
+#include "s3c24xx-ac97.h"
+
+static struct snd_soc_machine ln2440sbc;
+
+static struct snd_soc_dai_link ln2440sbc_dai[] = {
+{
+	.name = "AC97",
+	.stream_name = "AC97 HiFi",
+	.cpu_dai = &s3c2443_ac97_dai[0],
+	.codec_dai = &ac97_dai,
+},
+};
+
+static struct snd_soc_machine ln2440sbc = {
+	.name = "LN2440SBC",
+	.dai_link = ln2440sbc_dai,
+	.num_links = ARRAY_SIZE(ln2440sbc_dai),
+};
+
+static struct snd_soc_device ln2440sbc_snd_ac97_devdata = {
+	.machine = &ln2440sbc,
+	.platform = &s3c24xx_soc_platform,
+	.codec_dev = &soc_codec_dev_ac97,
+};
+
+static struct platform_device *ln2440sbc_snd_ac97_device;
+
+static int __init ln2440sbc_init(void)
+{
+	int ret;
+
+	ln2440sbc_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!ln2440sbc_snd_ac97_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(ln2440sbc_snd_ac97_device,
+				&ln2440sbc_snd_ac97_devdata);
+	ln2440sbc_snd_ac97_devdata.dev = &ln2440sbc_snd_ac97_device->dev;
+	ret = platform_device_add(ln2440sbc_snd_ac97_device);
+
+	if (ret)
+		platform_device_put(ln2440sbc_snd_ac97_device);
+
+	return ret;
+}
+
+static void __exit ln2440sbc_exit(void)
+{
+	platform_device_unregister(ln2440sbc_snd_ac97_device);
+}
+
+module_init(ln2440sbc_init);
+module_exit(ln2440sbc_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ivan Kuten");
+MODULE_DESCRIPTION("ALSA SoC ALC650 LN2440SBC");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.23/sound/soc/s3c24xx/s3c2443-ac97.c linux-2.6.23-2440/sound/soc/s3c24xx/s3c2443-ac97.c
--- linux-2.6.23/sound/soc/s3c24xx/s3c2443-ac97.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.23-2440/sound/soc/s3c24xx/s3c2443-ac97.c	2007-10-28 00:55:57.000000000 +0200
@@ -32,7 +32,7 @@
 
 #include <asm/hardware.h>
 #include <asm/io.h>
-#include <asm/arch/regs-ac97.h>
+#include <asm/plat-s3c/regs-ac97.h>
 #include <asm/arch/regs-gpio.h>
 #include <asm/arch/regs-clock.h>
 #include <asm/arch/audio.h>
@@ -253,7 +253,7 @@
 	ac_glbctrl |= S3C_AC97_GLBCTRL_TRANSFERDATAENABLE;
 	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
 
-	ret = request_irq(IRQ_S3C2443_AC97, s3c2443_ac97_irq,
+	ret = request_irq(IRQ_S3C244x_AC97, s3c2443_ac97_irq,
 		IRQF_DISABLED, "AC97", NULL);
 	if (ret < 0) {
 		printk(KERN_ERR "s3c24xx-ac97: interrupt request failed.\n");
@@ -266,7 +266,7 @@
 
 static void s3c2443_ac97_remove(struct platform_device *pdev)
 {
-	free_irq(IRQ_S3C2443_AC97, NULL);
+	free_irq(IRQ_S3C244x_AC97, NULL);
 	clk_disable(s3c24xx_ac97.ac97_clk);
 	clk_put(s3c24xx_ac97.ac97_clk);
 	iounmap(s3c24xx_ac97.regs);
diff -urN linux-2.6.23/sound/soc/s3c24xx/s3c24xx-ac97.h linux-2.6.23-2440/sound/soc/s3c24xx/s3c24xx-ac97.h
--- linux-2.6.23/sound/soc/s3c24xx/s3c24xx-ac97.h	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.23-2440/sound/soc/s3c24xx/s3c24xx-ac97.h	2007-10-28 00:32:04.000000000 +0200
@@ -20,6 +20,12 @@
 #define AC_CMD_ADDR(x) (x << 16)
 #define AC_CMD_DATA(x) (x & 0xffff)
 
+#ifdef CONFIG_CPU_S3C2440
+#define IRQ_S3C244x_AC97 IRQ_S3C2440_AC97 
+#else
+#define IRQ_S3C244x_AC97 IRQ_S3C2443_AC97 
+#endif
+
 extern struct snd_soc_cpu_dai s3c2443_ac97_dai[];
 
 #endif /*S3C24XXAC97_H_*/
