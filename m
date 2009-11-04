From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH] ASoC ADS117x ADC driver
Date: Wed, 04 Nov 2009 17:49:22 +0000
Message-ID: <1257356962.2887.488.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C966243EB
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 18:49:26 +0100 (CET)
Received: by ewy21 with SMTP id 21so12559687ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2009 09:49:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <gg@slimlogic.co.uk>

This patch adds support for the TI ADS117x family of multichannel ADCs
and was sponsored by Shotspotter Inc.

Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/Kconfig   |    5 ++
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/ads117x.c |  129 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ads117x.h |   13 +++++
 4 files changed, 149 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/ads117x.c
 create mode 100644 sound/soc/codecs/ads117x.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b54dfd0..9763062 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -15,6 +15,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD1836 if SPI_MASTER
 	select SND_SOC_AD1938 if SPI_MASTER
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
+	select SND_SOC_ADS117X
 	select SND_SOC_AD73311 if I2C
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
@@ -97,6 +98,9 @@ config SND_SOC_AD1980
 
 config SND_SOC_AD73311
 	tristate
+	
+config SND_SOC_ADS117X
+	tristate
 
 config SND_SOC_AK4104
 	tristate
@@ -261,3 +265,4 @@ config SND_SOC_WM9713
 # Amp
 config SND_SOC_MAX9877
 	tristate
+
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 15350ec..ad12458 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -5,6 +5,7 @@ snd-soc-ad1939-objs := ad1939.o
 snd-soc-ad1980-objs := ad1980.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-ad73311-objs := ad73311.o
+snd-soc-ads117x-objs := ads117x.o
 snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4642-objs := ak4642.o
@@ -67,6 +68,7 @@ obj-$(CONFIG_SND_SOC_AD1938)	+= snd-soc-ad1938.o
 obj-$(CONFIG_SND_SOC_AD1939)	+= snd-soc-ad1939.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
+obj-$(CONFIG_SND_SOC_ADS117X)	+= snd-soc-ads117x.o
 obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_CS4251X)	+= snd-soc-cs4251x.o
diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
new file mode 100644
index 0000000..72be32c
--- /dev/null
+++ b/sound/soc/codecs/ads117x.c
@@ -0,0 +1,129 @@
+/*
+ * ads117x.c  --  Driver for ads1174/8 ADC chips
+ *
+ * Copyright 2009 ShotSpotter Inc.
+ * Author: Graeme Gregory <gg@slimlogic.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "ads117x.h"
+
+#define ADS117X_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 )
+
+#define ADS117X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
+
+struct snd_soc_dai ads117x_dai = {
+/* ADC */
+	.name = "ADS117X ADC",
+	.id = 1,
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 32,
+		.rates = ADS117X_RATES,
+		.formats = ADS117X_FORMATS,},
+};
+EXPORT_SYMBOL_GPL(ads117x_dai);
+
+/*
+ * initialise the ads117x driver
+ */
+static int ads117x_init(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int ret = 0;
+
+	codec->name = "ADS117X";
+	codec->owner = THIS_MODULE;
+	codec->dai = &ads117x_dai;
+	codec->num_dai = 1;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "ads117x: failed to create pcms\n");
+		return ret;
+	}
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "ads117x: failed to register card\n");
+		goto card_err;
+	}
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	return ret;
+}
+
+static int ads117x_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret;
+
+	pr_info("ads117x ADC\n");
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
+	socdev->card->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	ret = ads117x_init(socdev);
+	if (ret != 0)
+		kfree(codec);
+
+	return ret;
+}
+
+static int ads117x_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	snd_soc_free_pcms(socdev);
+	kfree(codec);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_ads117x = {
+	.probe =	ads117x_probe,
+	.remove =	ads117x_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_ads117x);
+
+static int __init ads117x_modinit(void)
+{
+	return snd_soc_register_dai(&ads117x_dai);
+}
+module_init(ads117x_modinit);
+
+static void __exit ads117x_exit(void)
+{
+	snd_soc_unregister_dai(&ads117x_dai);
+}
+module_exit(ads117x_exit);
+
+MODULE_DESCRIPTION("ASoC ads117x driver");
+MODULE_AUTHOR("Graeme Gregory");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ads117x.h b/sound/soc/codecs/ads117x.h
new file mode 100644
index 0000000..dbcf50e
--- /dev/null
+++ b/sound/soc/codecs/ads117x.h
@@ -0,0 +1,13 @@
+/*
+ * ads117x.h  --  Driver for ads1174/8 ADC chips
+ *
+ * Copyright 2009 ShotSpotter Inc.
+ * Author: Graeme Gregory <gg@slimlogic.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+extern struct snd_soc_dai ads117x_dai;
+extern struct snd_soc_codec_device soc_codec_dev_ads117x;
-- 
1.6.3.3
