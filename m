From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH v3 4/6] ARM: DaVinci: ASoC: Add dummy codec
	support
Date: Thu, 28 May 2009 05:10:50 -0400
Message-ID: <1243501850-28531-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C2381038ED
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 11:47:25 +0200 (CEST)
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
Cc: Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Steve Chen <schen@mvista.com>, Naresh Medisetty <naresh@ti.com>, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

McASP on DM646x can operate in DIT (S/PDIF) where no codec is needed.
This patch provides stub codec that can be used in these configurations.
On DM646x EVM the McASP1 is connected to the S/PDIF out.

Signed-off-by: Steve Chen <schen@mvista.com>
Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
Signed-off-by: Naresh Medisetty <naresh@ti.com>
Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
This patch applies against ALSA mainline - that's the topic/asoc
branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

 sound/soc/codecs/Kconfig             |    4 ++
 sound/soc/codecs/Makefile            |    2 +
 sound/soc/codecs/spdif_transciever.c |   69 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/spdif_transciever.h |   17 ++++++++
 4 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/spdif_transciever.c
 create mode 100644 sound/soc/codecs/spdif_transciever.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cb07d9b..bbc97fd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -18,6 +18,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_PCM3008
+	select SND_SOC_SPDIF
 	select SND_SOC_SSM2602 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TLV320AIC23 if I2C
@@ -91,6 +92,9 @@ config SND_SOC_L3
 config SND_SOC_PCM3008
        tristate
 
+config SND_SOC_SPDIF
+	tristate
+
 config SND_SOC_SSM2602
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 46c007c..8b75305 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -6,6 +6,7 @@ snd-soc-ak4535-objs := ak4535.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-l3-objs := l3.o
 snd-soc-pcm3008-objs := pcm3008.o
+snd-soc-spdif-objs := spdif_transciever.o
 snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-stac9766-objs := stac9766.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
@@ -42,6 +43,7 @@ obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
+obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
new file mode 100644
index 0000000..118e976
--- /dev/null
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -0,0 +1,69 @@
+/*
+ * ALSA SoC SPDIF DIT driver
+ *
+ *  This driver is used by controllers which can operate in DIT (SPDI/F) where
+ *  no codec is needed.  This file provides stub codec that can be used
+ *  in these configurations. TI DaVinci Audio controller uses this driver.
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
+	.name		= "DIT",
+	.playback 	= {
+		.stream_name	= "Playback",
+		.channels_min	= 1,
+		.channels_max	= 384,
+		.rates		= STUB_RATES,
+		.formats	= STUB_FORMATS,
+	},
+};
+
+static int spdif_dit_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&dit_stub_dai);
+}
+
+static int spdif_dit_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&dit_stub_dai);
+	return 0;
+}
+
+static struct platform_driver spdif_dit_driver = {
+	.probe		= spdif_dit_probe,
+	.remove		= spdif_dit_remove,
+	.driver		= {
+		.name	= "spdif-dit",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init dit_modinit(void)
+{
+	return platform_driver_register(&spdif_dit_driver);
+}
+
+static void __exit dit_exit(void)
+{
+	platform_driver_unregister(&spdif_dit_driver);
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
-- 
1.5.6
