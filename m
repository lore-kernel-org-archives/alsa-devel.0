From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] Add Phytec i.MX sound support for AC97
Date: Tue, 9 Feb 2010 11:14:28 +0100
Message-ID: <20100209101428.GG17643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D06E42452B
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 11:14:31 +0100 (CET)
Content-Disposition: inline
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Marc et all,

The following patch adds support for Phytec i.MX boards in AC97
mode. With this patch only some board glue code is missing to
enable sound for the first i.MX boards. I'll push the board code
through my i.MX tree. Please consider including this patch for -next.

Sascha


>From 264b0916b712d6cbbcbd2f7b208b1c84b40a3f54 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 25 Nov 2009 16:18:28 +0100
Subject: [PATCH 1/6] ASoC: add phycore-ac97 sound support

This patch adds sound support for Phytec PhyCORE / PhyCARD
modules in AC97 mode.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Kconfig        |   11 +++++-
 sound/soc/imx/Makefile       |    2 +
 sound/soc/imx/phycore-ac97.c |   90 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/imx/phycore-ac97.c

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 5f006f0..e687d53 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,6 +1,6 @@
 config SND_IMX_SOC
 	tristate "SoC Audio for Freecale i.MX CPUs"
-	depends on ARCH_MXC && BROKEN
+	depends on ARCH_MXC
 	select SND_PCM
 	select FIQ
 	select SND_SOC_AC97_BUS
@@ -11,3 +11,12 @@ config SND_IMX_SOC
 config SND_MXC_SOC_SSI
 	tristate
 
+config SND_SOC_PHYCORE_AC97
+	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
+	depends on MACH_PCM043 || MACH_PCA100
+	select SND_IMX_SOC
+	select SND_SOC_WM9712
+	help
+	  Say Y if you want to add support for SoC audio on Phytec phyCORE
+	  and phyCARD boards in AC97 mode
+
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index d05cc95..9f8bb92 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -8,3 +8,5 @@ endif
 obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
 
 # i.MX Machine Support
+snd-soc-phycore-ac97-objs := phycore-ac97.o
+obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
new file mode 100644
index 0000000..a8307d5
--- /dev/null
+++ b/sound/soc/imx/phycore-ac97.c
@@ -0,0 +1,90 @@
+/*
+ * phycore-ac97.c  --  SoC audio for imx_phycore in AC97 mode
+ *
+ * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
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
+#include <asm/mach-types.h>
+
+#include "../codecs/wm9712.h"
+#include "imx-ssi.h"
+
+static struct snd_soc_card imx_phycore;
+
+static struct snd_soc_ops imx_phycore_hifi_ops = {
+};
+
+static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
+	{
+		.name		= "HiFi",
+		.stream_name	= "HiFi",
+		.codec_dai	= &wm9712_dai[WM9712_DAI_AC97_HIFI],
+		.ops		= &imx_phycore_hifi_ops,
+	},
+};
+
+static struct snd_soc_card imx_phycore = {
+	.name		= "PhyCORE-audio",
+	.platform	= &imx_soc_platform,
+	.dai_link	= imx_phycore_dai_ac97,
+	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
+};
+
+static struct snd_soc_device imx_phycore_snd_devdata = {
+	.card		= &imx_phycore,
+	.codec_dev	= &soc_codec_dev_wm9712,
+};
+
+static struct platform_device *imx_phycore_snd_device;
+
+static int __init imx_phycore_init(void)
+{
+	int ret;
+
+	if (!machine_is_pcm043() && !machine_is_pca100())
+		/* return happy. We might run on a totally different machine */
+		return 0;
+
+	imx_phycore_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!imx_phycore_snd_device)
+		return -ENOMEM;
+
+	imx_phycore_dai_ac97[0].cpu_dai = &imx_ssi_pcm_dai[0];
+
+	platform_set_drvdata(imx_phycore_snd_device, &imx_phycore_snd_devdata);
+	imx_phycore_snd_devdata.dev = &imx_phycore_snd_device->dev;
+	ret = platform_device_add(imx_phycore_snd_device);
+
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		platform_device_put(imx_phycore_snd_device);
+	}
+
+	return ret;
+}
+
+static void __exit imx_phycore_exit(void)
+{
+	platform_device_unregister(imx_phycore_snd_device);
+}
+
+late_initcall(imx_phycore_init);
+module_exit(imx_phycore_exit);
+
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("PhyCORE ALSA SoC driver");
+MODULE_LICENSE("GPL");
-- 
1.6.6

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
