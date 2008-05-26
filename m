From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] Add EM-X270 ASoC driver
Date: Mon, 26 May 2008 12:59:16 +0300
Message-ID: <483A89F4.5040006@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout10.netvision.net.il (mxout10.netvision.net.il
	[194.90.6.38]) by alsa0.perex.cz (Postfix) with ESMTP id AA566248BE
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 11:59:15 +0200 (CEST)
Received: from mail.linux-boards.com ([62.90.235.247])
	by mxout10.netvision.net.il
	(Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
	with ESMTP id <0K1G006QEZVX0WB0@mxout10.netvision.net.il> for
	alsa-devel@alsa-project.org; Mon, 26 May 2008 13:02:21 +0300 (IDT)
Received: from [10.1.1.95] (mike-pc.compulab.local [10.1.1.95])
	by mail.linux-boards.com (8.12.5/8.12.8) with ESMTP id
	m4Q9wVGT002577	for
	<alsa-devel@alsa-project.org>; Mon, 26 May 2008 12:58:31 +0300
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

This patch adds ASoC support for EM-X270 machine.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 sound/soc/pxa/Kconfig   |    9 ++++
 sound/soc/pxa/Makefile  |    3 +-
 sound/soc/pxa/em-x270.c |  102 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/pxa/em-x270.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 484f883..e31ab49 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -62,3 +62,12 @@ config SND_PXA2XX_SOC_E800
 	help
 	  Say Y if you want to add support for SoC audio on the
 	  Toshiba e800 PDA
+
+config SND_PXA2XX_SOC_EM_X270
+	tristate "SoC Audio support for CompuLab EM-x270"
+	depends on SND_PXA2XX_SOC && MACH_EM_X270
+	select SND_PXA2XX_SOC_AC97
+	select SND_SOC_WM9712
+	help
+	  Say Y if you want to add support for SoC audio on
+	  CompuLab EM-x270.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 04e5646..5bc8edf 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -13,10 +13,11 @@ snd-soc-poodle-objs := poodle.o
 snd-soc-tosa-objs := tosa.o
 snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
+snd-soc-em-x270-objs := em-x270.o

 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
 obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
 obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
-
+obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
new file mode 100644
index 0000000..02dcac3
--- /dev/null
+++ b/sound/soc/pxa/em-x270.c
@@ -0,0 +1,102 @@
+/*
+ * em-x270.c  --  SoC audio for EM-X270
+ *
+ * Copyright 2007 CompuLab, Ltd.
+ *
+ * Author: Mike Rapoport <mike@compulab.co.il>
+ *
+ * Copied from tosa.c:
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * Authors: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *          Richard Purdie <richard@openedhand.com>
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
+static struct snd_soc_dai_link em_x270_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+		.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
+	},
+	{
+		.name = "AC97 Aux",
+		.stream_name = "AC97 Aux",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+		.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
+	},
+};
+
+static struct snd_soc_machine em_x270 = {
+	.name = "EM-X270",
+	.dai_link = em_x270_dai,
+	.num_links = ARRAY_SIZE(em_x270_dai),
+};
+
+static struct snd_soc_device em_x270_snd_devdata = {
+	.machine = &em_x270,
+	.platform = &pxa2xx_soc_platform,
+	.codec_dev = &soc_codec_dev_wm9712,
+};
+
+static struct platform_device *em_x270_snd_device;
+
+static int __init em_x270_init(void)
+{
+	int ret;
+
+	if (!machine_is_em_x270())
+		return -ENODEV;
+
+	em_x270_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!em_x270_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(em_x270_snd_device, &em_x270_snd_devdata);
+	em_x270_snd_devdata.dev = &em_x270_snd_device->dev;
+	ret = platform_device_add(em_x270_snd_device);
+
+	if (ret)
+		platform_device_put(em_x270_snd_device);
+
+	return ret;
+}
+
+static void __exit em_x270_exit(void)
+{
+	platform_device_unregister(em_x270_snd_device);
+}
+
+module_init(em_x270_init);
+module_exit(em_x270_exit);
+
+/* Module information */
+MODULE_AUTHOR("Mike Rapoport");
+MODULE_DESCRIPTION("ALSA SoC EM-X270");
+MODULE_LICENSE("GPL");
-- 
1.5.3.7
