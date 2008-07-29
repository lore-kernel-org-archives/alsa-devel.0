From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/14] ASoC: AD1980 audio codec driver
Date: Tue, 29 Jul 2008 11:42:34 +0100
Message-ID: <1217328155-30158-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-12-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F6AE103892
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:41 +0200 (CEST)
In-Reply-To: <1217328155-30158-12-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

[Mechanical updates from code review applied -- broonie]

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    3 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/ad1980.c |  309 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad1980.h |   23 ++++
 4 files changed, 337 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/ad1980.c
 create mode 100644 sound/soc/codecs/ad1980.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e09fa5..7ab74cd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2,6 +2,9 @@ config SND_SOC_AC97_CODEC
 	tristate
 	select SND_AC97_CODEC
 
+config SND_SOC_AD1980
+	tristate
+
 config SND_SOC_AK4535
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index dc0357e..409e4dd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,4 +1,5 @@
 snd-soc-ac97-objs := ac97.o
+snd-soc-ad1980-objs := ad1980.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wm8510-objs := wm8510.o
@@ -13,6 +14,7 @@ snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
+obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WM8510)	+= snd-soc-wm8510.o
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
new file mode 100644
index 0000000..bfbab3d
--- /dev/null
+++ b/sound/soc/codecs/ad1980.c
@@ -0,0 +1,309 @@
+/*
+ * ad1980.c  --  ALSA Soc AD1980 codec support
+ *
+ * Copyright:	Analog Device Inc.
+ * Author:	Roy Huang <roy.huang@analog.com>
+ * 		Cliff Cai <cliff.cai@analog.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "ad1980.h"
+
+static unsigned int ac97_read(struct snd_soc_codec *codec,
+	unsigned int reg);
+static int ac97_write(struct snd_soc_codec *codec,
+	unsigned int reg, unsigned int val);
+
+/*
+ * AD1980 register cache
+ */
+static const u16 ad1980_reg[] = {
+	0x0090, 0x8000, 0x8000, 0x8000, /* 0 - 6  */
+	0x0000, 0x0000, 0x8008, 0x8008, /* 8 - e  */
+	0x8808, 0x8808, 0x0000, 0x8808, /* 10 - 16 */
+	0x8808, 0x0000, 0x8000, 0x0000, /* 18 - 1e */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 20 - 26 */
+	0x03c7, 0x0000, 0xbb80, 0xbb80, /* 28 - 2e */
+	0xbb80, 0xbb80, 0x0000, 0x8080, /* 30 - 36 */
+	0x8080, 0x2000, 0x0000, 0x0000, /* 38 - 3e */
+	0x0000, 0x0000, 0x0000, 0x0000, /* reserved */
+	0x0000, 0x0000, 0x0000, 0x0000, /* reserved */
+	0x0000, 0x0000, 0x0000, 0x0000, /* reserved */
+	0x0000, 0x0000, 0x0000, 0x0000, /* reserved */
+	0x8080, 0x0000, 0x0000, 0x0000, /* 60 - 66 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* reserved */
+	0x0000, 0x0000, 0x1001, 0x0000, /* 70 - 76 */
+	0x0000, 0x0000, 0x4144, 0x5370  /* 78 - 7e */
+};
+
+static const char *ad1980_rec_sel[] = {"Mic", "CD", "NC", "AUX", "Line",
+		"Stereo Mix", "Mono Mix", "Phone"};
+
+static const struct soc_enum ad1980_cap_src =
+	SOC_ENUM_DOUBLE(AC97_REC_SEL, 8, 0, 7, ad1980_rec_sel);
+
+static const struct snd_kcontrol_new ad1980_snd_ac97_controls[] = {
+SOC_DOUBLE("Master Playback Volume", AC97_MASTER, 8, 0, 31, 1),
+SOC_SINGLE("Master Playback Switch", AC97_MASTER, 15, 1, 1),
+
+SOC_DOUBLE("Headphone Playback Volume", AC97_HEADPHONE, 8, 0, 31, 1),
+SOC_SINGLE("Headphone Playback Switch", AC97_HEADPHONE, 15, 1, 1),
+
+SOC_DOUBLE("PCM Playback Volume", AC97_PCM, 8, 0, 31, 1),
+SOC_SINGLE("PCM Playback Switch", AC97_PCM, 15, 1, 1),
+
+SOC_DOUBLE("PCM Capture Volume", AC97_REC_GAIN, 8, 0, 31, 0),
+SOC_SINGLE("PCM Capture Switch", AC97_REC_GAIN, 15, 1, 1),
+
+SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
+SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
+
+SOC_SINGLE("Phone Capture Volume", AC97_PHONE, 0, 31, 1),
+SOC_SINGLE("Phone Capture Switch", AC97_PHONE, 15, 1, 1),
+
+SOC_SINGLE("Mic Volume", AC97_MIC, 0, 31, 1),
+SOC_SINGLE("Mic Switch", AC97_MIC, 15, 1, 1),
+
+SOC_SINGLE("Stereo Mic Switch", AC97_AD_MISC, 6, 1, 0),
+SOC_DOUBLE("Line HP Swap Switch", AC97_AD_MISC, 10, 5, 1, 0),
+
+SOC_DOUBLE("Surround Playback Volume", AC97_SURROUND_MASTER, 8, 0, 31, 1),
+SOC_DOUBLE("Surround Playback Switch", AC97_SURROUND_MASTER, 15, 7, 1, 1),
+
+SOC_ENUM("Capture Source", ad1980_cap_src),
+
+SOC_SINGLE("Mic Boost Switch", AC97_MIC, 6, 1, 0),
+};
+
+/* add non dapm controls */
+static int ad1980_add_controls(struct snd_soc_codec *codec)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(ad1980_snd_ac97_controls); i++) {
+		err = snd_ctl_add(codec->card, snd_soc_cnew(
+				&ad1980_snd_ac97_controls[i], codec, NULL));
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static unsigned int ac97_read(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+
+	switch (reg) {
+	case AC97_RESET:
+	case AC97_INT_PAGING:
+	case AC97_POWERDOWN:
+	case AC97_EXTENDED_STATUS:
+	case AC97_VENDOR_ID1:
+	case AC97_VENDOR_ID2:
+		return soc_ac97_ops.read(codec->ac97, reg);
+	default:
+		reg = reg >> 1;
+
+		if (reg >= (ARRAY_SIZE(ad1980_reg)))
+			return -EINVAL;
+
+		return cache[reg];
+	}
+}
+
+static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int val)
+{
+	u16 *cache = codec->reg_cache;
+
+	soc_ac97_ops.write(codec->ac97, reg, val);
+	reg = reg >> 1;
+	if (reg < (ARRAY_SIZE(ad1980_reg)))
+		cache[reg] = val;
+
+	return 0;
+}
+
+struct snd_soc_codec_dai ad1980_dai = {
+	.name = "AC97",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+};
+EXPORT_SYMBOL_GPL(ad1980_dai);
+
+static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
+{
+	u16 retry_cnt = 0;
+
+retry:
+	if (try_warm && soc_ac97_ops.warm_reset) {
+		soc_ac97_ops.warm_reset(codec->ac97);
+		if (ac97_read(codec, AC97_RESET) == 0x0090)
+			return 1;
+	}
+
+	soc_ac97_ops.reset(codec->ac97);
+	/* Set bit 16slot in register 74h, then every slot will has only 16
+	 * bits. This command is sent out in 20bit mode, in which case the
+	 * first nibble of data is eaten by the addr. (Tag is always 16 bit)*/
+	ac97_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
+
+	if (ac97_read(codec, AC97_RESET)  != 0x0090)
+		goto err;
+	return 0;
+
+err:
+	while (retry_cnt++ < 10)
+		goto retry;
+
+	printk(KERN_ERR "AD1980 AC97 reset failed\n");
+	return -EIO;
+}
+
+static int ad1980_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+	u16 vendor_id2;
+
+	printk(KERN_INFO "AD1980 SoC Audio Codec\n");
+
+	socdev->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (socdev->codec == NULL)
+		return -ENOMEM;
+	codec = socdev->codec;
+	mutex_init(&codec->mutex);
+
+	codec->reg_cache =
+		kzalloc(sizeof(u16) * ARRAY_SIZE(ad1980_reg), GFP_KERNEL);
+	if (codec->reg_cache == NULL) {
+		ret = -ENOMEM;
+		goto cache_err;
+	}
+	memcpy(codec->reg_cache, ad1980_reg, sizeof(u16) * \
+			ARRAY_SIZE(ad1980_reg));
+	codec->reg_cache_size = sizeof(u16) * ARRAY_SIZE(ad1980_reg);
+	codec->reg_cache_step = 2;
+	codec->name = "AD1980";
+	codec->owner = THIS_MODULE;
+	codec->dai = &ad1980_dai;
+	codec->num_dai = 1;
+	codec->write = ac97_write;
+	codec->read = ac97_read;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	if (ret < 0) {
+		printk(KERN_ERR "ad1980: failed to register AC97 codec\n");
+		goto codec_err;
+	}
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0)
+		goto pcm_err;
+
+
+	ret = ad1980_reset(codec, 0);
+	if (ret < 0) {
+		printk(KERN_ERR "AC97 link error\n");
+		goto reset_err;
+	}
+
+	/* Read out vendor ID to make sure it is ad1980 */
+	if (ac97_read(codec, AC97_VENDOR_ID1) != 0x4144)
+		goto reset_err;
+
+	vendor_id2 = ac97_read(codec, AC97_VENDOR_ID2);
+
+	if (vendor_id2 != 0x5370) {
+		if (vendor_id2 != 0x5374)
+			goto reset_err;
+		else
+			printk(KERN_WARNING "ad1980: "
+				"Found AD1981 - only 2/2 IN/OUT Channels "
+				"supported\n");
+	}
+
+	ac97_write(codec, AC97_MASTER, 0x0000); /* unmute line out volume */
+	ac97_write(codec, AC97_PCM, 0x0000);	/* unmute PCM out volume */
+	ac97_write(codec, AC97_REC_GAIN, 0x0000);/* unmute record volume */
+
+	ad1980_add_controls(codec);
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "ad1980: failed to register card\n");
+		goto reset_err;
+	}
+
+	return 0;
+
+reset_err:
+	snd_soc_free_pcms(socdev);
+
+pcm_err:
+	snd_soc_free_ac97_codec(codec);
+
+codec_err:
+	kfree(codec->reg_cache);
+
+cache_err:
+	kfree(socdev->codec);
+	socdev->codec = NULL;
+	return ret;
+}
+
+static int ad1980_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	if (codec == NULL)
+		return 0;
+
+	snd_soc_dapm_free(socdev);
+	snd_soc_free_pcms(socdev);
+	snd_soc_free_ac97_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_ad1980 = {
+	.probe = 	ad1980_soc_probe,
+	.remove = 	ad1980_soc_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_ad1980);
+
+MODULE_DESCRIPTION("ASoC ad1980 driver");
+MODULE_AUTHOR("Roy Huang, Cliff Cai");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad1980.h b/sound/soc/codecs/ad1980.h
new file mode 100644
index 0000000..5d4710d
--- /dev/null
+++ b/sound/soc/codecs/ad1980.h
@@ -0,0 +1,23 @@
+/*
+ * ad1980.h  --  ad1980 Soc Audio driver
+ */
+
+#ifndef _AD1980_H
+#define _AD1980_H
+/* Bit definition of Power-Down Control/Status Register */
+#define ADC		0x0001
+#define DAC		0x0002
+#define ANL		0x0004
+#define REF		0x0008
+#define PR0		0x0100
+#define PR1		0x0200
+#define PR2		0x0400
+#define PR3		0x0800
+#define PR4		0x1000
+#define PR5		0x2000
+#define PR6		0x4000
+
+extern struct snd_soc_codec_dai ad1980_dai;
+extern struct snd_soc_codec_device soc_codec_dev_ad1980;
+
+#endif
-- 
1.5.6.3
