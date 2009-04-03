From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 4/5] ARM: DaVinci: ASoC: Add dummy codec support
Date: Thu,  2 Apr 2009 21:50:07 -0400
Message-ID: <1238723407-27479-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 23C04103877
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 16:37:34 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n32EbT9n030981
	for <alsa-devel@alsa-project.org>; Thu, 2 Apr 2009 09:37:34 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

McASP on DM646x can operate in DIT (S/PDIF) where no codec is needed.
This patch provides stub codec that can be used in these configurations.
On DM646x EVM the McASP1 is connected to the S/PDIF out.

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies against ALSA mainline - that's the topic/asoc
branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

 sound/soc/codecs/Kconfig               |    3 +
 sound/soc/codecs/Makefile              |    2 +
 sound/soc/codecs/davinci_codec_stubs.c |   83 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/davinci_codec_stubs.h |   23 +++++++++
 4 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/davinci_codec_stubs.c
 create mode 100644 sound/soc/codecs/davinci_codec_stubs.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b6c7f7a..59e50d0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -22,6 +22,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC3X if I2C
+	select SND_SOC_CODEC_STUBS
 	select SND_SOC_TWL4030 if TWL4030_CORE
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
@@ -91,6 +92,8 @@ config SND_SOC_SSM2602
 
 config SND_SOC_TLV320AIC23
 	tristate
+config SND_SOC_CODEC_STUBS
+        tristate
 
 config SND_SOC_TLV320AIC26
 	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 030d245..70c26a5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -10,6 +10,7 @@ snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
+snd-soc-davinci_stubs-objs := davinci_codec_stubs.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
@@ -41,6 +42,7 @@ obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
+obj-$(CONFIG_SND_SOC_CODEC_STUBS)	+= snd-soc-davinci_stubs.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
diff --git a/sound/soc/codecs/davinci_codec_stubs.c b/sound/soc/codecs/davinci_codec_stubs.c
new file mode 100644
index 0000000..63d56ad
--- /dev/null
+++ b/sound/soc/codecs/davinci_codec_stubs.c
@@ -0,0 +1,83 @@
+/*
+ * ALSA SoC DaVinci DIT/DIR driver
+ *
+ *  TI DaVinci audio controller can operate in DIT/DIR (SPDI/F) where
+ *  no codec is needed.  This file provides stub codec that can be used
+ *  in these configurations.
+ *
+ * Author:      Steve Chen,  <schen@mvista.com>
+ * Copyright:   (C) 2008 MontaVista Software, Inc., <source@mvista.com>
+ * Copyright:   (C) 2008  Texas Instruments, India
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
+struct snd_soc_dai dit_stub_dai[] = {
+	{
+		.name = "DIT",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 384,
+			.rates = STUB_RATES,
+			.formats = STUB_FORMATS,
+		},
+	}
+};
+
+struct snd_soc_dai dir_stub_dai[] = {
+	{
+		.name = "DIR",
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 384,
+			.rates = STUB_RATES,
+			.formats = STUB_FORMATS,
+		},
+	}
+};
+
+static int davinci_dit_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(dit_stub_dai);
+}
+
+static int davici_dit_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(dit_stub_dai);
+	return 0;
+}
+
+static struct platform_driver davinci_dit_driver = {
+	.probe		= davinci_dit_probe,
+	.remove		= davici_dit_remove,
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
diff --git a/sound/soc/codecs/davinci_codec_stubs.h b/sound/soc/codecs/davinci_codec_stubs.h
new file mode 100644
index 0000000..693797b
--- /dev/null
+++ b/sound/soc/codecs/davinci_codec_stubs.h
@@ -0,0 +1,23 @@
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
+#ifdef CONFIG_SND_SOC_CODEC_STUBS
+extern struct snd_soc_dai dit_stub_dai[];
+extern struct snd_soc_dai dir_stub_dai[];
+#else
+#define dit_stub_dai	NULL
+#define dir_stub_dai	NULL
+#endif
+
+#endif /* CODEC_STUBS_H */
-- 
1.5.6
