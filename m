From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 17/17] Preliminary ac97 drivers for Toshiba
	e800 PDAs
Date: Thu, 10 Jan 2008 13:17:15 +0000
Message-ID: <1199971035-13553-17-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-16-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C71724592
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:20 +0100 (CET)
In-Reply-To: <1199971035-13553-16-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Ian Molton <spyro@f2s.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Molton <spyro@f2s.com>

Currently only the AUX channel is used (touchscreen)

Signed-off-by: Ian Molton <spyro@f2s.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/Kconfig       |    9 ++++
 sound/soc/pxa/Makefile      |    2 +
 sound/soc/pxa/e800_wm9712.c |   90 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/e800_wm9712.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index a83e229..484f883 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -53,3 +53,12 @@ config SND_PXA2XX_SOC_TOSA
 	help
 	  Say Y if you want to add support for SoC audio on Sharp
 	  Zaurus SL-C6000x models (Tosa).
+
+config SND_PXA2XX_SOC_E800
+	tristate "SoC AC97 Audio support for e800"
+	depends on SND_PXA2XX_SOC && MACH_E800
+	select SND_SOC_WM9712
+	select SND_PXA2XX_SOC_AC97
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  Toshiba e800 PDA
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 78e0d6b..04e5646 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -11,10 +11,12 @@ obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
 snd-soc-corgi-objs := corgi.o
 snd-soc-poodle-objs := poodle.o
 snd-soc-tosa-objs := tosa.o
+snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
 obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
+obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
 
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
new file mode 100644
index 0000000..1e25722
--- /dev/null
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -0,0 +1,90 @@
+/*
+ * e800-wm9712.c  --  SoC audio for e800
+ *
+ * Based on tosa.c
+ *
+ * Copyright 2007 (c) Ian Molton <spyro@f2s.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation; version 2 ONLY.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/audio.h>
+
+#include "../codecs/wm9712.h"
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
+
+static struct snd_soc_machine e800;
+
+static struct snd_soc_dai_link e800_dai[] = {
+{
+	.name = "AC97 Aux",
+	.stream_name = "AC97 Aux",
+	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
+},
+};
+
+static struct snd_soc_machine e800 = {
+	.name = "Toshiba e800",
+	.dai_link = e800_dai,
+	.num_links = ARRAY_SIZE(e800_dai),
+};
+
+static struct snd_soc_device e800_snd_devdata = {
+	.machine = &e800,
+	.platform = &pxa2xx_soc_platform,
+	.codec_dev = &soc_codec_dev_wm9712,
+};
+
+static struct platform_device *e800_snd_device;
+
+static int __init e800_init(void)
+{
+	int ret;
+
+	if (!machine_is_e800())
+		return -ENODEV;
+
+	e800_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!e800_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(e800_snd_device, &e800_snd_devdata);
+	e800_snd_devdata.dev = &e800_snd_device->dev;
+	ret = platform_device_add(e800_snd_device);
+
+	if (ret)
+		platform_device_put(e800_snd_device);
+
+	return ret;
+}
+
+static void __exit e800_exit(void)
+{
+	platform_device_unregister(e800_snd_device);
+}
+
+module_init(e800_init);
+module_exit(e800_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
+MODULE_DESCRIPTION("ALSA SoC driver for e800");
+MODULE_LICENSE("GPL");
-- 
1.5.3.8
