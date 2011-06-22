From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: ASoC: add WM8782 ADC Codec Driver
Date: Wed, 22 Jun 2011 14:59:25 +0200
Message-ID: <1308747565-4506-2-git-send-email-zonque@gmail.com>
References: <20110622125456.GA21802@opensource.wolfsonmicro.com>
	<1308747565-4506-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B6C81039F8
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 14:59:37 +0200 (CEST)
In-Reply-To: <1308747565-4506-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Johannes Stezenbach <js@sig21.net>

Signed-off-by: Johannes Stezenbach <js@sig21.net>
[zonque@gmail.com: transform to new ASoC structure]
Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/Kconfig  |    4 ++
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/wm8782.c |   80 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wm8782.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index dd075f2..64bc0d2 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -72,6 +72,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8753 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8770 if SPI_MASTER
 	select SND_SOC_WM8776 if SND_SOC_I2C_AND_SPI
+	select SND_SOC_WM8782
 	select SND_SOC_WM8804 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8900 if I2C
 	select SND_SOC_WM8903 if I2C
@@ -303,6 +304,9 @@ config SND_SOC_WM8770
 config SND_SOC_WM8776
 	tristate
 
+config SND_SOC_WM8782
+	tristate
+
 config SND_SOC_WM8804
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2ad1310..0ef7cd1 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -56,6 +56,7 @@ snd-soc-wm8750-objs := wm8750.o
 snd-soc-wm8753-objs := wm8753.o
 snd-soc-wm8770-objs := wm8770.o
 snd-soc-wm8776-objs := wm8776.o
+snd-soc-wm8782-objs := wm8782.o
 snd-soc-wm8804-objs := wm8804.o
 snd-soc-wm8900-objs := wm8900.o
 snd-soc-wm8903-objs := wm8903.o
@@ -149,6 +150,7 @@ obj-$(CONFIG_SND_SOC_WM8750)	+= snd-soc-wm8750.o
 obj-$(CONFIG_SND_SOC_WM8753)	+= snd-soc-wm8753.o
 obj-$(CONFIG_SND_SOC_WM8770)	+= snd-soc-wm8770.o
 obj-$(CONFIG_SND_SOC_WM8776)	+= snd-soc-wm8776.o
+obj-$(CONFIG_SND_SOC_WM8782)	+= snd-soc-wm8782.o
 obj-$(CONFIG_SND_SOC_WM8804)	+= snd-soc-wm8804.o
 obj-$(CONFIG_SND_SOC_WM8900)	+= snd-soc-wm8900.o
 obj-$(CONFIG_SND_SOC_WM8903)	+= snd-soc-wm8903.o
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
new file mode 100644
index 0000000..a2a09f8
--- /dev/null
+++ b/sound/soc/codecs/wm8782.c
@@ -0,0 +1,80 @@
+/*
+ * sound/soc/codecs/wm8782.c
+ * simple, strap-pin configured 24bit 2ch ADC
+ *
+ * Copyright: 2011 Raumfeld GmbH
+ * Author: Johannes Stezenbach <js@sig21.net>
+ *
+ * based on ad73311.c
+ * Copyright:	Analog Device Inc.
+ * Author:	Cliff Cai <cliff.cai@analog.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+static struct snd_soc_dai_driver wm8782_dai = {
+	.name = "wm8782",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		/* For configurations with FSAMPEN=0 */
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S20_3LE |
+			   SNDRV_PCM_FMTBIT_S24_LE,
+	},
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_wm8782;
+
+static __devinit int wm8782_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_wm8782, &wm8782_dai, 1);
+}
+
+static int __devexit wm8782_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver wm8782_codec_driver = {
+	.driver = {
+		.name = "wm8782",
+		.owner = THIS_MODULE,
+	},
+	.probe = wm8782_probe,
+	.remove = wm8782_remove,
+};
+
+static int __init wm8782_init(void)
+{
+	return platform_driver_register(&wm8782_codec_driver);
+}
+module_init(wm8782_init);
+
+static void __exit wm8782_exit(void)
+{
+	platform_driver_unregister(&wm8782_codec_driver);
+}
+module_exit(wm8782_exit);
+
+MODULE_DESCRIPTION("ASoC WM8782 driver");
+MODULE_AUTHOR("Johannes Stezenbach <js@sig21.net>");
+MODULE_LICENSE("GPL");
-- 
1.7.5.4
