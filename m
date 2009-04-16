From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH v2 4/6] ARM: DaVinci: ASoC: Add dummy codec
	support
Date: Thu, 16 Apr 2009 18:44:54 -0400
Message-ID: <1239921894-26973-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 6436A103920
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:32:57 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3GBWp7I026616
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 06:32:56 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Steve Chen <schen@mvista.com>, "Naresh.Medisetty" <naresh@ti.com>, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

From: Naresh.Medisetty <naresh@ti.com>

McASP on DM646x can operate in DIT (S/PDIF) where no codec is needed.
This patch provides stub codec that can be used in these configurations.
On DM646x EVM the McASP1 is connected to the S/PDIF out.

Signed-off-by: Steve Chen <schen@mvista.com>
Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies against ALSA mainline - that's the topic/asoc
branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

 sound/soc/codecs/Kconfig             |    3 +
 sound/soc/codecs/Makefile            |    2 +
 sound/soc/codecs/spdif_transciever.c |   69 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/spdif_transciever.h |   17 ++++++++
 sound/soc/davinci/Kconfig            |    1 +
 5 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/spdif_transciever.c
 create mode 100644 sound/soc/codecs/spdif_transciever.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 121d63f..154c64c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -22,6 +22,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC3X if I2C
+	select SND_SOC_SPDIF
 	select SND_SOC_TWL4030 if TWL4030_CORE
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
@@ -93,6 +94,8 @@ config SND_SOC_SSM2602
 
 config SND_SOC_TLV320AIC23
 	tristate
+config SND_SOC_SPDIF
+        tristate
 
 config SND_SOC_TLV320AIC26
 	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d8e15a4..10d5729 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -10,6 +10,7 @@ snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
+snd-soc-spdif-objs := spdif_transciever.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
@@ -43,6 +44,7 @@ obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
+obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
new file mode 100644
index 0000000..45f56ae
--- /dev/null
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -0,0 +1,69 @@
+/*
+ * ALSA SoC DaVinci DIT driver
+ *
+ *  TI DaVinci audio controller can operate in DIT (SPDI/F) where
+ *  no codec is needed.  This file provides stub codec that can be used
+ *  in these configurations.
+ *
+ * Author:      Steve Chen,  <schen@mvista.com>
+ * Copyright:   (C) 2009 MontaVista Software, Inc., <source@mvista.com>
+ * Copyright:   (C) 2009  Texas Instruments, India
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+
+#define STUB_RATES	SNDRV_PCM_RATE_8000_96000
+#define STUB_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
+
+
+struct snd_soc_dai dit_stub_dai = {
+	.name = "DIT",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 384,
+		.rates = STUB_RATES,
+		.formats = STUB_FORMATS,
+	},
+};
+
+static int davinci_dit_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&dit_stub_dai);
+}
+
+static int davinci_dit_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&dit_stub_dai);
+	return 0;
+}
+
+static struct platform_driver davinci_dit_driver = {
+	.probe		= davinci_dit_probe,
+	.remove		= davinci_dit_remove,
+	.driver		= {
+		.name	= "davinci-dit",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init dit_modinit(void)
+{
+	return platform_driver_register(&davinci_dit_driver);
+}
+
+static void __exit dit_exit(void)
+{
+	platform_driver_unregister(&davinci_dit_driver);
+}
+
+module_init(dit_modinit);
+module_exit(dit_exit);
+
diff --git a/sound/soc/codecs/spdif_transciever.h b/sound/soc/codecs/spdif_transciever.h
new file mode 100644
index 0000000..296f2eb
--- /dev/null
+++ b/sound/soc/codecs/spdif_transciever.h
@@ -0,0 +1,17 @@
+/*
+ * ALSA SoC DIT/DIR driver header
+ *
+ * Author:      Steve Chen,  <schen@mvista.com>
+ * Copyright:   (C) 2008 MontaVista Software, Inc., <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef CODEC_STUBS_H
+#define CODEC_STUBS_H
+
+extern struct snd_soc_dai dit_stub_dai;
+
+#endif /* CODEC_STUBS_H */
diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 0ae84d4..03631a7 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -26,6 +26,7 @@ config  SND_DM6467_SOC_EVM
         depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM6467_EVM
         select SND_DAVINCI_SOC_I2S_MCASP
         select SND_SOC_TLV320AIC3X
+        select SND_SOC_SPDIF
         help
           Say Y if you want to add support for SoC audio on TI
           DaVinci DM6467 EVM platform.
-- 
1.5.6
