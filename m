From: Neil Jones <neiljay@gmail.com>
Subject: [PATCH] sound/soc/codecs: Add support for the wm8727
	DAC.
Date: Mon, 2 Nov 2009 11:54:15 +0000
Message-ID: <91f916b90911020354s7f22d0a8pba2ac82525663d8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f224.google.com (mail-ew0-f224.google.com
	[209.85.219.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A38D10383B
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 12:54:16 +0100 (CET)
Received: by ewy24 with SMTP id 24so4430711ewy.46
	for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2009 03:54:16 -0800 (PST)
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

Add support for the Wolfson Micro wm8727 DAC, this is a simple
non-configurable DAC.

Signed-off-by: Neil Jones <neil.jones@imgtec.com>
---
 sound/soc/codecs/Kconfig  |    6 ++-
 sound/soc/codecs/Makefile |    5 +-
 sound/soc/codecs/wm8727.c |  120
+++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8727.h |   21 ++++++++
 4 files changed, 149 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/wm8727.c
 create mode 100644 sound/soc/codecs/wm8727.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0edca93..816cc86 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -36,6 +36,7 @@ config SND_SOC_ALL_CODECS
     select SND_SOC_WM8510 if SND_SOC_I2C_AND_SPI
     select SND_SOC_WM8523 if I2C
     select SND_SOC_WM8580 if I2C
+    select SND_SOC_WM8727
     select SND_SOC_WM8728 if SND_SOC_I2C_AND_SPI
     select SND_SOC_WM8731 if SND_SOC_I2C_AND_SPI
     select SND_SOC_WM8750 if SND_SOC_I2C_AND_SPI
@@ -160,6 +161,9 @@ config SND_SOC_WM8523
 config SND_SOC_WM8580
     tristate

+config SND_SOC_WM8727
+    tristate
+
 config SND_SOC_WM8728
     tristate

@@ -217,6 +221,6 @@ config SND_SOC_WM9712
 config SND_SOC_WM9713
     tristate

-# Amp
 config SND_SOC_MAX9877
     tristate
+
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index fb4af28..fa536a9 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -24,6 +24,7 @@ snd-soc-wm8400-objs := wm8400.o
 snd-soc-wm8510-objs := wm8510.o
 snd-soc-wm8523-objs := wm8523.o
 snd-soc-wm8580-objs := wm8580.o
+snd-soc-wm8727-objs := wm8727.o
 snd-soc-wm8728-objs := wm8728.o
 snd-soc-wm8731-objs := wm8731.o
 snd-soc-wm8750-objs := wm8750.o
@@ -44,7 +45,6 @@ snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
-
 # Amp
 snd-soc-max9877-objs := max9877.o

@@ -74,6 +74,7 @@ obj-$(CONFIG_SND_SOC_WM8400)    += snd-soc-wm8400.o
 obj-$(CONFIG_SND_SOC_WM8510)    += snd-soc-wm8510.o
 obj-$(CONFIG_SND_SOC_WM8523)    += snd-soc-wm8523.o
 obj-$(CONFIG_SND_SOC_WM8580)    += snd-soc-wm8580.o
+obj-$(CONFIG_SND_SOC_WM8727)    += snd-soc-wm8727.o
 obj-$(CONFIG_SND_SOC_WM8728)    += snd-soc-wm8728.o
 obj-$(CONFIG_SND_SOC_WM8731)    += snd-soc-wm8731.o
 obj-$(CONFIG_SND_SOC_WM8750)    += snd-soc-wm8750.o
@@ -94,6 +95,6 @@ obj-$(CONFIG_SND_SOC_WM9705)    += snd-soc-wm9705.o
 obj-$(CONFIG_SND_SOC_WM9712)    += snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)    += snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)    += snd-soc-wm-hubs.o
-
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)    += snd-soc-max9877.o
+
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
new file mode 100644
index 0000000..83aa5fa
--- /dev/null
+++ b/sound/soc/codecs/wm8727.c
@@ -0,0 +1,120 @@
+/*
+ * wm8727.c
+ *
+ *  Created on: 15-Oct-2009
+ *      Author: neil.jones@imgtec.com
+ *
+ * Copyright (C) 2009 Imagination Technologies Ltd.
+ *
+ *  This program is free software; you can redistribute  it and/or modify
it
+ *  under  the terms of  the GNU General  Public License as published by
the
+ *  Free Software Foundation;  either version 2 of the  License, or (at
your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "wm8727.h"
+/*
+ * Note this is a simple chip with no configuration interface, sample rate
is
+ * determined automatically by examining the Master clock and Bit clock
ratios
+ */
+#define WM8727_RATES  (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+            SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |\
+            SNDRV_PCM_RATE_192000)
+
+
+struct snd_soc_dai wm8727_dai = {
+    .name = "WM8727",
+    .playback = {
+        .stream_name = "Playback",
+        .channels_min = 2,
+        .channels_max = 2,
+        .rates = WM8727_RATES,
+        .formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+        },
+};
+EXPORT_SYMBOL_GPL(wm8727_dai);
+
+static int wm8727_soc_probe(struct platform_device *pdev)
+{
+    struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+    struct snd_soc_codec *codec;
+    int ret = 0;
+
+    codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+    if (codec == NULL)
+        return -ENOMEM;
+    mutex_init(&codec->mutex);
+    codec->name = "WM8727";
+    codec->owner = THIS_MODULE;
+    codec->dai = &wm8727_dai;
+    codec->num_dai = 1;
+    socdev->card->codec = codec;
+    INIT_LIST_HEAD(&codec->dapm_widgets);
+    INIT_LIST_HEAD(&codec->dapm_paths);
+
+    /* register pcms */
+    ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+    if (ret < 0) {
+        printk(KERN_ERR "wm8727: failed to create pcms\n");
+        goto pcm_err;
+    }
+    /* register card */
+    ret = snd_soc_init_card(socdev);
+    if (ret < 0) {
+        printk(KERN_ERR "wm8727: failed to register card\n");
+        goto register_err;
+    }
+
+    return ret;
+
+register_err:
+    snd_soc_free_pcms(socdev);
+pcm_err:
+    kfree(socdev->card->codec);
+    socdev->card->codec = NULL;
+    return ret;
+}
+
+static int wm8727_soc_remove(struct platform_device *pdev)
+{
+    struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+    struct snd_soc_codec *codec = socdev->card->codec;
+
+    if (codec == NULL)
+        return 0;
+    snd_soc_free_pcms(socdev);
+    kfree(codec);
+    return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8727 = {
+    .probe =     wm8727_soc_probe,
+    .remove =     wm8727_soc_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8727);
+
+static int __init wm8727_init(void)
+{
+    return snd_soc_register_dai(&wm8727_dai);
+}
+module_init(wm8727_init);
+
+static void __exit wm8727_exit(void)
+{
+    snd_soc_unregister_dai(&wm8727_dai);
+}
+module_exit(wm8727_exit);
+
+MODULE_DESCRIPTION("ASoC wm8727 driver");
+MODULE_AUTHOR("Neil Jones");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8727.h b/sound/soc/codecs/wm8727.h
new file mode 100644
index 0000000..ee19aa7
--- /dev/null
+++ b/sound/soc/codecs/wm8727.h
@@ -0,0 +1,21 @@
+/*
+ * wm8727.h
+ *
+ *  Created on: 15-Oct-2009
+ *      Author: neil.jones@imgtec.com
+ *
+ * Copyright (C) 2009 Imagination Technologies Ltd.
+ *
+ *  This program is free software; you can redistribute  it and/or modify
it
+ *  under  the terms of  the GNU General  Public License as published by
the
+ *  Free Software Foundation;  either version 2 of the  License, or (at
your
+ *  option) any later version.
+ */
+
+#ifndef WM8727_H_
+#define WM8727_H_
+
+extern struct snd_soc_dai wm8727_dai;
+extern struct snd_soc_codec_device soc_codec_dev_wm8727;
+
+#endif /* WM8727_H_ */
-- 
1.5.5.2
