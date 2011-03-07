From: Christian Glindkamp <christian.glindkamp@taskit.de>
Subject: [PATCH] ASoC: Add MAX9850 codec driver
Date: Mon,  7 Mar 2011 13:45:13 +0100
Message-ID: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 03B041038FF
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:50:06 +0100 (CET)
Received: from gieselher.localdomain (gieselher.localdomain [10.1.100.24])
	by localhost.localdomain (Postfix) with ESMTP id 362CBA941A
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:46:37 +0100 (CET)
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

This patch adds ASoC support for the MAX9850 codec with headphone
amplifier.

Supported features:
- Playback
- 16, 20 and 24 bit audio
- 8k - 48k sample rates
- DAPM

Only 16 bit audio was tested while the codec was connected to an
AT91SAM9G20 SSC in master mode.

Signed-off-by: Christian Glindkamp <christian.glindkamp@taskit.de>
---

I've all ready sent this patch some time ago, but it hung in the moderation
queue. This is a slightly modified version. Unfortunately I do not have the
hardware anymore to test suggested changes that alter function.

 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/max9850.c |  358 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max9850.h |   41 +++++
 4 files changed, 405 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/max9850.c
 create mode 100644 sound/soc/codecs/max9850.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e239345..51e9844 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -31,6 +31,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA7210 if I2C
 	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
 	select SND_SOC_MAX98088 if I2C
+	select SND_SOC_MAX9850 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_PCM3008
 	select SND_SOC_SN95031 if INTEL_SCU_IPC
@@ -179,6 +180,9 @@ config SND_SOC_DMIC
 config SND_SOC_MAX98088
        tristate
 
+config SND_SOC_MAX9850
+	tristate
+
 config SND_SOC_PCM3008
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index ae10507..f2efd1c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -18,6 +18,7 @@ snd-soc-da7210-objs := da7210.o
 snd-soc-dmic-objs := dmic.o
 snd-soc-l3-objs := l3.o
 snd-soc-max98088-objs := max98088.o
+snd-soc-max9850-objs := max9850.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-alc5623-objs := alc5623.o
 snd-soc-sn95031-objs := sn95031.o
@@ -102,6 +103,7 @@ obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
+obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif.o
diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
new file mode 100644
index 0000000..a8c1f95
--- /dev/null
+++ b/sound/soc/codecs/max9850.c
@@ -0,0 +1,358 @@
+/*
+ * max9850.c  --  codec driver for max9850
+ *
+ * Copyright (C) 2011 taskit GmbH
+ *
+ * Author: Christian Glindkamp <christian.glindkamp@taskit.de>
+ *
+ * Initial development of this code was funded by
+ * MICRONIC Computer Systeme GmbH, http://www.mcsberlin.de/
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "max9850.h"
+
+struct max9850_priv {
+	unsigned int sysclk;
+};
+
+/* max9850 register cache */
+static const u8 max9850_reg[MAX9850_CACHEREGNUM] = {
+	0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/* these registers are not used at the moment but provided for the sake of
+ * completeness */
+static int max9850_volatile_register(unsigned int reg)
+{
+	switch (reg) {
+	case MAX9850_STATUSA:
+	case MAX9850_STATUSB:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static const unsigned int max9850_tlv[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0x18, 0x1f, TLV_DB_SCALE_ITEM(-7450, 400, 0),
+	0x20, 0x33, TLV_DB_SCALE_ITEM(-4150, 200, 0),
+	0x34, 0x37, TLV_DB_SCALE_ITEM(-150, 100, 0),
+	0x38, 0x3f, TLV_DB_SCALE_ITEM(250, 50, 0),
+};
+
+static const struct snd_kcontrol_new max9850_controls[] = {
+SOC_SINGLE_TLV("Headphone Volume", MAX9850_VOLUME, 0, 0x3f, 1, max9850_tlv),
+SOC_SINGLE("Headphone Switch", MAX9850_VOLUME, 7, 1, 1),
+SOC_SINGLE("Mono", MAX9850_GENERAL_PURPOSE, 2, 1, 0),
+};
+
+static const struct snd_kcontrol_new max9850_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line In Switch", MAX9850_ENABLE, 1, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget max9850_dapm_widgets[] = {
+SND_SOC_DAPM_DAC("DAC", "HiFi Playback", MAX9850_ENABLE, 0, 0),
+SND_SOC_DAPM_SUPPLY("MCLK", MAX9850_ENABLE, 6, 0, NULL, 0),
+SND_SOC_DAPM_OUTPUT("OUTL"),
+SND_SOC_DAPM_OUTPUT("OUTR"),
+SND_SOC_DAPM_OUTPUT("HPL"),
+SND_SOC_DAPM_OUTPUT("HPR"),
+SND_SOC_DAPM_INPUT("INL"),
+SND_SOC_DAPM_INPUT("INR"),
+SND_SOC_DAPM_PGA("Headphone Output", MAX9850_ENABLE, 3, 0, NULL, 0),
+SND_SOC_DAPM_MIXER("Line Input", SND_SOC_NOPM, 0, 0, NULL, 0),
+SND_SOC_DAPM_MIXER_NAMED_CTL("Output Mixer", MAX9850_ENABLE, 2, 0,
+		&max9850_mixer_controls[0],
+		ARRAY_SIZE(max9850_mixer_controls)),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	/* output mixer */
+	{"Output Mixer", NULL, "DAC"},
+	{"Output Mixer", "Line In Switch", "Line Input"},
+
+	/* outputs */
+	{"Headphone Output", NULL, "Output Mixer"},
+	{"HPL", NULL, "Headphone Output"},
+	{"HPR", NULL, "Headphone Output"},
+	{"OUTL", NULL, "Output Mixer"},
+	{"OUTR", NULL, "Output Mixer"},
+
+	/* inputs */
+	{"Line Input", NULL, "INL"},
+	{"Line Input", NULL, "INR"},
+
+	/* supplies */
+	{"DAC", NULL, "MCLK"},
+};
+
+static int max9850_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max9850_priv *max9850 = snd_soc_codec_get_drvdata(codec);
+	u64 lrclk_div;
+	u8 sf, da;
+
+	/* lrclk_div = 2^22 * rate / iclk with iclk = mclk / sf */
+	sf = (snd_soc_read(codec, MAX9850_CLOCK) >> 2) + 1;
+	lrclk_div = (1 << 22);
+	lrclk_div *= params_rate(params);
+	lrclk_div *= sf;
+	do_div(lrclk_div, max9850->sysclk);
+
+	snd_soc_write(codec, MAX9850_LRCLK_MSB, (lrclk_div >> 8) & 0x7f);
+	snd_soc_write(codec, MAX9850_LRCLK_LSB, lrclk_div & 0xff);
+
+	da = snd_soc_read(codec, MAX9850_DIGITAL_AUDIO);
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		da |= 0x2;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		da |= 0x3;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_write(codec, MAX9850_DIGITAL_AUDIO, da);
+
+	return 0;
+}
+
+static int max9850_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct max9850_priv *max9850 = snd_soc_codec_get_drvdata(codec);
+
+	/* calculate mclk -> iclk divider */
+	if (freq <= 13000000)
+		snd_soc_write(codec, MAX9850_CLOCK, 0x0);
+	else if (freq <= 26000000)
+		snd_soc_write(codec, MAX9850_CLOCK, 0x4);
+	else if (freq <= 40000000)
+		snd_soc_write(codec, MAX9850_CLOCK, 0x8);
+	else
+		return -EINVAL;
+
+	max9850->sysclk = freq;
+	return 0;
+}
+
+static int max9850_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u8 da = 0;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		da |= MAX9850_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		da |= MAX9850_DLY;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		da |= MAX9850_RTJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		da |= MAX9850_BCINV | MAX9850_INV;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		da |= MAX9850_BCINV;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		da |= MAX9850_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set da */
+	snd_soc_write(codec, MAX9850_DIGITAL_AUDIO, da);
+
+	return 0;
+}
+
+static int max9850_set_bias_level(struct snd_soc_codec *codec,
+				  enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		snd_soc_update_bits(codec, MAX9850_ENABLE, MAX9850_SHDN,
+				MAX9850_SHDN);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		snd_soc_update_bits(codec, MAX9850_ENABLE, MAX9850_SHDN, 0);
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+	codec->dapm.bias_level = level;
+	return 0;
+}
+
+#define MAX9850_RATES SNDRV_PCM_RATE_8000_48000
+
+#define MAX9850_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+	SNDRV_PCM_FMTBIT_S24_LE)
+
+static struct snd_soc_dai_ops max9850_dai_ops = {
+	.hw_params	= max9850_hw_params,
+	.set_sysclk	= max9850_set_dai_sysclk,
+	.set_fmt	= max9850_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver max9850_dai = {
+	.name = "max9850-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = MAX9850_RATES,
+		.formats = MAX9850_FORMATS
+	},
+	.ops = &max9850_dai_ops,
+};
+
+static int max9850_probe(struct snd_soc_codec *codec)
+{
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret;
+
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	/* enable zero-detect */
+	snd_soc_update_bits(codec, MAX9850_GENERAL_PURPOSE, 1, 1);
+	/* enable charge pump, disable everything else */
+	snd_soc_write(codec, MAX9850_ENABLE, 0x30);
+	/* enable slew-rate control */
+	snd_soc_update_bits(codec, MAX9850_VOLUME, 0x40, 0x40);
+	/* set slew-rate 125ms */
+	snd_soc_update_bits(codec, MAX9850_CHARGE_PUMP, 0xff, 0xc0);
+
+	snd_soc_dapm_new_controls(dapm, max9850_dapm_widgets,
+				  ARRAY_SIZE(max9850_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
+
+	snd_soc_add_controls(codec, max9850_controls,
+			ARRAY_SIZE(max9850_controls));
+
+	return 0;
+}
+static int max9850_remove(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_max9850 = {
+	.probe =	max9850_probe,
+	.remove =	max9850_remove,
+	.set_bias_level = max9850_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(max9850_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = max9850_reg,
+	.volatile_register = max9850_volatile_register,
+};
+
+static int __devinit max9850_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	struct max9850_priv *max9850;
+	int ret;
+
+	max9850 = kzalloc(sizeof(struct max9850_priv), GFP_KERNEL);
+	if (max9850 == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, max9850);
+
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_max9850, &max9850_dai, 1);
+	if (ret < 0)
+		kfree(max9850);
+	return ret;
+}
+
+static __devexit int max9850_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const struct i2c_device_id max9850_i2c_id[] = {
+	{ "max9850", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max9850_i2c_id);
+
+static struct i2c_driver max9850_i2c_driver = {
+	.driver = {
+		.name = "max9850-codec",
+		.owner = THIS_MODULE,
+	},
+	.probe = max9850_i2c_probe,
+	.remove = __devexit_p(max9850_i2c_remove),
+	.id_table = max9850_i2c_id,
+};
+
+static int __init max9850_init(void)
+{
+	return i2c_add_driver(&max9850_i2c_driver);
+}
+module_init(max9850_init);
+
+static void __exit max9850_exit(void)
+{
+	i2c_del_driver(&max9850_i2c_driver);
+}
+module_exit(max9850_exit);
+
+MODULE_AUTHOR("Christian Glindkamp <christian.glindkamp@taskit.de>");
+MODULE_DESCRIPTION("ASoC MAX9850 codec driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/max9850.h b/sound/soc/codecs/max9850.h
new file mode 100644
index 0000000..5268575
--- /dev/null
+++ b/sound/soc/codecs/max9850.h
@@ -0,0 +1,41 @@
+/*
+ * max9850.h  --  codec driver for max9850
+ *
+ * Copyright (C) 2011 taskit GmbH
+ * Author: Christian Glindkamp <christian.glindkamp@taskit.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef _MAX9850_H
+#define _MAX9850_H
+
+#define MAX9850_STATUSA			0x00
+#define MAX9850_STATUSB			0x01
+#define MAX9850_VOLUME			0x02
+#define MAX9850_GENERAL_PURPOSE		0x03
+#define MAX9850_INTERRUPT		0x04
+#define MAX9850_ENABLE			0x05
+#define MAX9850_CLOCK			0x06
+#define MAX9850_CHARGE_PUMP		0x07
+#define MAX9850_LRCLK_MSB		0x08
+#define MAX9850_LRCLK_LSB		0x09
+#define MAX9850_DIGITAL_AUDIO		0x0a
+
+#define MAX9850_CACHEREGNUM 11
+
+/* MAX9850_ENABLE */
+#define MAX9850_SHDN			(1<<7)
+
+/* MAX9850_DIGITAL_AUDIO */
+#define MAX9850_MASTER			(1<<7)
+#define MAX9850_INV			(1<<6)
+#define MAX9850_BCINV			(1<<5)
+#define MAX9850_DLY			(1<<3)
+#define MAX9850_RTJ			(1<<2)
+
+#endif
-- 
1.7.2.3
