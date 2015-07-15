From: timothyc.howe@gmail.com
Subject: [PATCH v3] ASoC: cs4349: Add support for Cirrus Logic
	CS4349
Date: Wed, 15 Jul 2015 11:31:49 -0500
Message-ID: <55a68b00.4e946b0a.7bbc.ffff9616@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
 [209.85.213.181])
 by alsa0.perex.cz (Postfix) with ESMTP id F21EE265D42
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 18:32:06 +0200 (CEST)
Received: by igvi1 with SMTP id i1so81254369igv.1
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 09:32:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: brian.austin@cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

From: Tim Howe <tim.howe@cirrus.com>

Signed-off-by: Tim Howe <tim.howe@cirrus.com>
---
 Documentation/devicetree/bindings/sound/cs4349.txt |  19 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/cs4349.c                          | 401 +++++++++++++++++++++
 sound/soc/codecs/cs4349.h                          | 146 ++++++++
 5 files changed, 574 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4349.txt
 create mode 100644 sound/soc/codecs/cs4349.c
 create mode 100644 sound/soc/codecs/cs4349.h

diff --git a/Documentation/devicetree/bindings/sound/cs4349.txt b/Documentation/devicetree/bindings/sound/cs4349.txt
new file mode 100644
index 0000000..54c117b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs4349.txt
@@ -0,0 +1,19 @@
+CS4349 audio CODEC
+
+Required properties:
+
+  - compatible : "cirrus,cs4349"
+
+  - reg : the I2C address of the device for I2C
+
+Optional properties:
+
+  - reset-gpios : a GPIO spec for the reset pin.
+
+Example:
+
+codec: cs4349@48 {
+        compatible = "cirrus,cs4349";
+        reg = <0x48>;
+        reset-gpios = <&gpio 54 0>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7223c7f..4a78606 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -54,6 +54,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS4271_I2C if I2C
 	select SND_SOC_CS4271_SPI if SPI_MASTER
 	select SND_SOC_CS42XX8_I2C if I2C
+	select SND_SOC_CS4349 if I2C
 	select SND_SOC_CX20442 if TTY
 	select SND_SOC_DA7210 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_DA7213 if I2C
@@ -413,6 +414,11 @@ config SND_SOC_CS42XX8_I2C
 	select SND_SOC_CS42XX8
 	select REGMAP_I2C
 
+# Cirrus Logic CS4349 HiFi DAC
+config SND_SOC_CS4349
+	tristate "Cirrus Logic CS4349 CODEC"
+	depends on I2C
+
 config SND_SOC_CX20442
 	tristate
 	depends on TTY
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9f7136c..36a9f37 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -46,6 +46,7 @@ snd-soc-cs4271-i2c-objs := cs4271-i2c.o
 snd-soc-cs4271-spi-objs := cs4271-spi.o
 snd-soc-cs42xx8-objs := cs42xx8.o
 snd-soc-cs42xx8-i2c-objs := cs42xx8-i2c.o
+snd-soc-cs4349-objs := cs4349.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-da7210-objs := da7210.o
 snd-soc-da7213-objs := da7213.o
@@ -237,6 +238,7 @@ obj-$(CONFIG_SND_SOC_CS4271_I2C)	+= snd-soc-cs4271-i2c.o
 obj-$(CONFIG_SND_SOC_CS4271_SPI)	+= snd-soc-cs4271-spi.o
 obj-$(CONFIG_SND_SOC_CS42XX8)	+= snd-soc-cs42xx8.o
 obj-$(CONFIG_SND_SOC_CS42XX8_I2C) += snd-soc-cs42xx8-i2c.o
+obj-$(CONFIG_SND_SOC_CS4349)	+= snd-soc-cs4349.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
 obj-$(CONFIG_SND_SOC_DA7213)	+= snd-soc-da7213.o
diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
new file mode 100644
index 0000000..fb8d1e1
--- /dev/null
+++ b/sound/soc/codecs/cs4349.c
@@ -0,0 +1,401 @@
+/*
+ * cs4349.c  --  CS4349 ALSA Soc Audio driver
+ *
+ * Copyright 2015 Cirrus Logic, Inc.
+ *
+ * Authors: Tim Howe <Tim.Howe@cirrus.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include "cs4349.h"
+
+
+static const struct reg_default cs4349_reg_defaults[] = {
+	{ 2, 0x00 },	/* r02	- Mode Control */
+	{ 3, 0x09 },	/* r03	- Volume, Mixing and Inversion Control */
+	{ 4, 0x81 },	/* r04	- Mute Control */
+	{ 5, 0x00 },	/* r05	- Channel A Volume Control */
+	{ 6, 0x00 },	/* r06	- Channel B Volume Control */
+	{ 7, 0xB1 },	/* r07	- Ramp and Filter Control */
+	{ 8, 0x1C },	/* r08	- Misc. Control */
+};
+
+/* Private data for the CS4349 */
+struct  cs4349_private {
+	struct regmap			*regmap;
+	struct cs4349_platform_data	pdata;
+	struct gpio_desc		*reset_gpio;
+	unsigned int			mode;
+	int				rate;
+};
+
+static bool cs4349_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS4349_CHIPID:
+	case CS4349_MODE:
+	case CS4349_VMI:
+	case CS4349_MUTE:
+	case CS4349_VOLA:
+	case CS4349_VOLB:
+	case CS4349_RMPFLT:
+	case CS4349_MISC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int cs4349_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs4349_private *cs4349 = snd_soc_codec_get_drvdata(codec);
+	unsigned int fmt;
+
+	fmt = format & SND_SOC_DAIFMT_FORMAT_MASK;
+
+	switch (fmt) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		cs4349->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cs4349_pcm_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct cs4349_private *cs4349 = snd_soc_codec_get_drvdata(codec);
+	int mode, fmt, ret;
+
+	mode = snd_soc_read(codec, CS4349_MODE);
+	cs4349->rate = params_rate(params);
+
+	switch (cs4349->mode) {
+	case SND_SOC_DAIFMT_I2S:
+		mode |= MODE_FORMAT(DIF_I2S);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		mode |= MODE_FORMAT(DIF_LEFT_JST);
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (params_width(params)) {
+		case 16:
+			fmt = DIF_RGHT_JST16;
+			break;
+		case 24:
+			fmt = DIF_RGHT_JST24;
+			break;
+		default:
+			return -EINVAL;
+		}
+		mode |= MODE_FORMAT(fmt);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_write(codec, CS4349_MODE, mode);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cs4349_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int reg;
+
+	reg = 0;
+	if (mute)
+		reg = MUTE_AB_MASK;
+
+	return snd_soc_update_bits(codec, CS4349_MUTE, MUTE_AB_MASK, reg);
+}
+
+static DECLARE_TLV_DB_SCALE(dig_tlv, -12750, 50, 0);
+
+static const char * const chan_mix_texts[] = {
+	"Mute", "MuteA", "MuteA SwapB", "MuteA MonoB", "SwapA MuteB",
+	"BothR", "Swap", "SwapA MonoB", "MuteB", "Normal", "BothL",
+	"MonoB", "MonoA MuteB", "MonoA", "MonoA SwapB", "Mono",
+	/*Normal == Channel A = Left, Channel B = Right*/
+};
+
+static const char * const fm_texts[] = {
+	"Auto", "Single", "Double", "Quad",
+};
+
+static const char * const deemph_texts[] = {
+	"None", "44.1k", "48k", "32k",
+};
+
+static const char * const softr_zeroc_texts[] = {
+	"Immediate", "Zero Cross", "Soft Ramp", "SR on ZC",
+};
+
+static int deemph_values[] = {
+	0, 4, 8, 12,
+};
+
+static int softr_zeroc_values[] = {
+	0, 64, 128, 192,
+};
+
+static const struct soc_enum chan_mix_enum =
+	SOC_ENUM_SINGLE(CS4349_VMI, 0,
+			ARRAY_SIZE(chan_mix_texts),
+			chan_mix_texts);
+
+static const struct soc_enum fm_mode_enum =
+	SOC_ENUM_SINGLE(CS4349_MODE, 0,
+			ARRAY_SIZE(fm_texts),
+			fm_texts);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(deemph_enum, CS4349_MODE, 0, DEM_MASK,
+				deemph_texts, deemph_values);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(softr_zeroc_enum, CS4349_RMPFLT, 0,
+				SR_ZC_MASK, softr_zeroc_texts,
+				softr_zeroc_values);
+
+static const struct snd_kcontrol_new cs4349_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Master Playback Volume",
+			 CS4349_VOLA, CS4349_VOLB, 0, 0xFF, 1, dig_tlv),
+	SOC_ENUM("Functional Mode", fm_mode_enum),
+	SOC_ENUM("De-Emphasis Control", deemph_enum),
+	SOC_ENUM("Soft Ramp Zero Cross Control", softr_zeroc_enum),
+	SOC_ENUM("Channel Mixer", chan_mix_enum),
+	SOC_SINGLE("VolA = VolB Switch", CS4349_VMI, 7, 1, 0),
+	SOC_SINGLE("InvertA Switch", CS4349_VMI, 6, 1, 0),
+	SOC_SINGLE("InvertB Switch", CS4349_VMI, 5, 1, 0),
+	SOC_SINGLE("Auto-Mute Switch", CS4349_MUTE, 7, 1, 0),
+	SOC_SINGLE("MUTEC A = B Switch", CS4349_MUTE, 5, 1, 0),
+	SOC_SINGLE("Soft Ramp Up Switch", CS4349_RMPFLT, 5, 1, 0),
+	SOC_SINGLE("Soft Ramp Down Switch", CS4349_RMPFLT, 4, 1, 0),
+	SOC_SINGLE("Slow Roll Off Filter Switch", CS4349_RMPFLT, 2, 1, 0),
+	SOC_SINGLE("Freeze Switch", CS4349_MISC, 5, 1, 0),
+	SOC_SINGLE("Popguard Switch", CS4349_MISC, 4, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget cs4349_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("HiFi DAC", NULL, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_OUTPUT("OutputA"),
+	SND_SOC_DAPM_OUTPUT("OutputB"),
+};
+
+static const struct snd_soc_dapm_route cs4349_routes[] = {
+	{"DAC Playback", NULL, "OutputA"},
+	{"DAC Playback", NULL, "OutputB"},
+
+	{"OutputA", NULL, "HiFi DAC"},
+	{"OutputB", NULL, "HiFi DAC"},
+};
+
+#define CS4349_PCM_FORMATS (SNDRV_PCM_FMTBIT_S8  | \
+			SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE  | \
+			SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S18_3BE | \
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE | \
+			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE | \
+			SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE)
+
+#define CS4349_PCM_RATES SNDRV_PCM_RATE_8000_192000
+
+static const struct snd_soc_dai_ops cs4349_dai_ops = {
+	.hw_params	= cs4349_pcm_hw_params,
+	.set_fmt	= cs4349_set_dai_fmt,
+	.digital_mute	= cs4349_digital_mute,
+};
+
+static struct snd_soc_dai_driver cs4349_dai = {
+	.name = "cs4349_hifi",
+	.playback = {
+		.stream_name	= "DAC Playback",
+		.channels_min	= 1,
+		.channels_max	= 2,
+		.rates		= CS4349_PCM_RATES,
+		.formats	= CS4349_PCM_FORMATS,
+	},
+	.ops = &cs4349_dai_ops,
+	.symmetric_rates = 1,
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_cs4349 = {
+	.controls		= cs4349_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs4349_snd_controls),
+
+	.dapm_widgets		= cs4349_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs4349_dapm_widgets),
+	.dapm_routes		= cs4349_routes,
+	.num_dapm_routes	= ARRAY_SIZE(cs4349_routes),
+};
+
+static struct regmap_config cs4349_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+
+	.max_register		= CS4349_NUMREGS,
+	.reg_defaults		= cs4349_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(cs4349_reg_defaults),
+	.readable_reg		= cs4349_readable_register,
+	.cache_type		= REGCACHE_RBTREE,
+};
+
+static int cs4349_i2c_probe(struct i2c_client *client,
+				      const struct i2c_device_id *id)
+{
+	struct cs4349_private *cs4349;
+	struct cs4349_platform_data *pdata = dev_get_platdata(&client->dev);
+	int ret = 0;
+
+	cs4349 = devm_kzalloc(&client->dev, sizeof(*cs4349), GFP_KERNEL);
+	if (!cs4349)
+		return -ENOMEM;
+
+	cs4349->regmap = devm_regmap_init_i2c(client, &cs4349_regmap);
+	if (IS_ERR(cs4349->regmap)) {
+		ret = PTR_ERR(cs4349->regmap);
+		dev_err(&client->dev, "regmap_init() failed: %d\n", ret);
+		return ret;
+	}
+
+	if (pdata)
+		cs4349->pdata = *pdata;
+
+	/* Reset the Device */
+	cs4349->reset_gpio = devm_gpiod_get_optional(&client->dev,
+		"reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs4349->reset_gpio))
+		return PTR_ERR(cs4349->reset_gpio);
+
+	if (cs4349->reset_gpio)
+		gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
+
+	i2c_set_clientdata(client, cs4349);
+
+	return snd_soc_register_codec(&client->dev, &soc_codec_dev_cs4349,
+		&cs4349_dai, 1);
+}
+
+static int cs4349_i2c_remove(struct i2c_client *client)
+{
+	struct cs4349_private *cs4349 = i2c_get_clientdata(client);
+
+	snd_soc_unregister_codec(&client->dev);
+
+	/* Hold down reset */
+	if (cs4349->reset_gpio)
+		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cs4349_runtime_suspend(struct device *dev)
+{
+	struct cs4349_private *cs4349 = dev_get_drvdata(dev);
+	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
+	int ret;
+
+	ret = snd_soc_update_bits(rtd->codec, CS4349_MISC, PWR_DWN, 1);
+	if (ret < 0)
+		return ret;
+
+	regcache_sync(cs4349->regmap);
+	regcache_cache_only(cs4349->regmap, true);
+
+	/* Hold down reset */
+	if (cs4349->reset_gpio)
+		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
+
+	return 0;
+}
+
+static int cs4349_runtime_resume(struct device *dev)
+{
+	struct cs4349_private *cs4349 = dev_get_drvdata(dev);
+	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
+	int ret;
+
+	ret = snd_soc_update_bits(rtd->codec, CS4349_MISC, PWR_DWN, 0);
+	if (ret < 0)
+		return ret;
+
+	if (cs4349->reset_gpio)
+		gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
+
+	regcache_cache_only(cs4349->regmap, false);
+	regcache_sync(cs4349->regmap);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops cs4349_runtime_pm = {
+	SET_RUNTIME_PM_OPS(cs4349_runtime_suspend, cs4349_runtime_resume,
+			   NULL)
+};
+
+static const struct of_device_id cs4349_of_match[] = {
+	{ .compatible = "cirrus,cs4349", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, cs4349_of_match);
+
+static const struct i2c_device_id cs4349_i2c_id[] = {
+	{"cs4349", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, cs4349_i2c_id);
+
+static struct i2c_driver cs4349_i2c_driver = {
+	.driver = {
+		.name		= "cs4349",
+		.owner		= THIS_MODULE,
+		.of_match_table	= cs4349_of_match,
+	},
+	.id_table	= cs4349_i2c_id,
+	.probe		= cs4349_i2c_probe,
+	.remove		= cs4349_i2c_remove,
+};
+
+module_i2c_driver(cs4349_i2c_driver);
+
+MODULE_AUTHOR("Tim Howe <tim.howe@cirrus.com>");
+MODULE_DESCRIPTION("Cirrus Logic CS4349 ALSA SoC Codec Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs4349.h b/sound/soc/codecs/cs4349.h
new file mode 100644
index 0000000..3884a89
--- /dev/null
+++ b/sound/soc/codecs/cs4349.h
@@ -0,0 +1,146 @@
+/*
+ * ALSA SoC CS4349 codec driver
+ *
+ * Copyright 2015 Cirrus Logic, Inc.
+ *
+ * Author: Tim Howe <Tim.Howe@cirrus.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#ifndef __CS4349_H__
+#define __CS4349_H__
+
+struct cs4349_platform_data {
+
+	/* GPIO for Reset */
+	unsigned int gpio_nreset;
+
+};
+
+/* CS4349 registers addresses */
+#define CS4349_CHIPID		0x01	/* Device and Rev ID, Read Only */
+#define CS4349_MODE		0x02	/* Mode Control */
+#define CS4349_VMI		0x03	/* Volume, Mixing, Inversion Control */
+#define CS4349_MUTE		0x04	/* Mute Control */
+#define CS4349_VOLA		0x05	/* DAC Channel A Volume Control */
+#define CS4349_VOLB		0x06	/* DAC Channel B Volume Control */
+#define CS4349_RMPFLT		0x07	/* Ramp and Filter Control */
+#define CS4349_MISC		0x08	/* Power Down,Freeze Control,Pop Stop*/
+
+#define CS4349_FIRSTREG		0x01
+#define CS4349_LASTREG		0x08
+#define CS4349_NUMREGS		(CS4349_LASTREG - CS4349_FIRSTREG + 1)
+#define CS4349_I2C_INCR		0x80
+
+
+/* Device and Revision ID */
+#define CS4349_REVA		0xF0	/* Rev A */
+#define CS4349_REVB		0xF1	/* Rev B */
+#define CS4349_REVC2		0xFF	/* Rev C2 */
+
+
+/* PDN_DONE Poll Maximum
+ * If soft ramp is set it will take much longer to power down
+ * the system.
+ */
+#define PDN_POLL_MAX		900
+
+
+/* Bitfield Definitions */
+
+/* CS4349_MODE */
+/* (Digital Interface Format, De-Emphasis Control, Functional Mode */
+#define DIF2			(1 << 6)
+#define DIF1			(1 << 5)
+#define DIF0			(1 << 4)
+#define DEM1			(1 << 3)
+#define DEM0			(1 << 2)
+#define FM1			(1 << 1)
+#define DIF_LEFT_JST		0x00
+#define DIF_I2S			0x01
+#define DIF_RGHT_JST16		0x02
+#define DIF_RGHT_JST24		0x03
+#define DIF_TDM0		0x04
+#define DIF_TDM1		0x05
+#define DIF_TDM2		0x06
+#define DIF_TDM3		0x07
+#define DIF_MASK		0x70
+#define MODE_FORMAT(x)		(((x)&7)<<4)
+#define DEM_MASK		0x0C
+#define NO_DEM			0x00
+#define DEM_441			0x04
+#define DEM_48K			0x08
+#define DEM_32K			0x0C
+#define FM_AUTO			0x00
+#define FM_SNGL			0x01
+#define FM_DBL			0x02
+#define FM_QUAD			0x03
+#define FM_SNGL_MIN		30000
+#define FM_SNGL_MAX		54000
+#define FM_DBL_MAX		108000
+#define FM_QUAD_MAX		216000
+#define FM_MASK			0x03
+
+/* CS4349_VMI (VMI = Volume, Mixing and Inversion Controls) */
+#define VOLBISA			(1 << 7)
+#define VOLAISB			(1 << 7)
+/* INVERT_A only available for Left Jstfd, Right Jstfd16 and Right Jstfd24 */
+#define INVERT_A		(1 << 6)
+/* INVERT_B only available for Left Jstfd, Right Jstfd16 and Right Jstfd24 */
+#define INVERT_B		(1 << 5)
+#define ATAPI3			(1 << 3)
+#define ATAPI2			(1 << 2)
+#define ATAPI1			(1 << 1)
+#define ATAPI0			(1 << 0)
+#define MUTEAB			0x00
+#define MUTEA_RIGHTB		0x01
+#define MUTEA_LEFTB		0x02
+#define MUTEA_SUMLRDIV2B	0x03
+#define RIGHTA_MUTEB		0x04
+#define RIGHTA_RIGHTB		0x05
+#define RIGHTA_LEFTB		0x06
+#define RIGHTA_SUMLRDIV2B	0x07
+#define LEFTA_MUTEB		0x08
+#define LEFTA_RIGHTB		0x09	/* Default */
+#define LEFTA_LEFTB		0x0A
+#define LEFTA_SUMLRDIV2B	0x0B
+#define SUMLRDIV2A_MUTEB	0x0C
+#define SUMLRDIV2A_RIGHTB	0x0D
+#define SUMLRDIV2A_LEFTB	0x0E
+#define SUMLRDIV2_AB		0x0F
+#define CHMIX_MASK		0x0F
+
+/* CS4349_MUTE */
+#define AUTOMUTE		(1 << 7)
+#define MUTEC_AB		(1 << 5)
+#define MUTE_A			(1 << 4)
+#define MUTE_B			(1 << 3)
+#define MUTE_AB_MASK		0x18
+
+/* CS4349_RMPFLT (Ramp and Filter Control) */
+#define SCZ1			(1 << 7)
+#define SCZ0			(1 << 6)
+#define RMP_UP			(1 << 5)
+#define RMP_DN			(1 << 4)
+#define FILT_SEL		(1 << 2)
+#define IMMDT_CHNG		0x31
+#define ZEROCRSS		0x71
+#define SOFT_RMP		0xB1
+#define SFTRMP_ZEROCRSS		0xF1
+#define SR_ZC_MASK		0xC0
+
+/* CS4349_MISC */
+#define PWR_DWN			(1 << 7)
+#define FREEZE			(1 << 5)
+#define POPG_EN			(1 << 4)
+
+#endif	/* __CS4349_H__ */
-- 
2.4.5
