From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: add codec driver for TI TAS5086
Date: Fri,  8 Mar 2013 12:07:13 +0100
Message-ID: <1362740833-15704-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A3598261700
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 12:07:13 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds a driver for TI's TA5086 6-channel PWM processor.

This chip has a very unusual register layout, specifically because the
registers are of unequal size, and multi-byte registers require bulk
writes to take effect. Regmap does not support these kind of mappings.

Currently, the driver does not touch any of the registers >= 0x20, so
it doesn't matter, because the register map is mapped to an 8-bit array.
In case more features will be added in the future that require access
to higher registers, the entire regmap H/W I/O routines have to be
open-coded.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/sound/ti,tas5086.txt       |  32 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas5086.c                         | 587 +++++++++++++++++++++
 4 files changed, 625 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas5086.txt
 create mode 100644 sound/soc/codecs/tas5086.c

diff --git a/Documentation/devicetree/bindings/sound/ti,tas5086.txt b/Documentation/devicetree/bindings/sound/ti,tas5086.txt
new file mode 100644
index 0000000..8ea4f5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas5086.txt
@@ -0,0 +1,32 @@
+Texas Instruments TAS5086 6-channel PWM Processor
+
+Required properties:
+
+ - compatible:		Should contain "ti,tas5086".
+ - reg:			The i2c address. Should contain <0x1b>.
+
+Optional properties:
+
+ - reset-gpio: 		A GPIO spec to define which pin is connected to the
+			chip's !RESET pin. If specified, the driver will
+			assert a hardware reset at probe time.
+
+ - ti,charge-period:	This property should contain the time in microseconds
+			that closely matches the external single-ended
+			split-capacitor charge period. The hardware chip
+			waits for this period of time before starting the
+			PWM signals. This helps reduce pops and clicks.
+
+			When not specified, the hardware default of 1300ms
+			is retained.
+
+Examples:
+
+	i2c_bus {
+		tas5086@1b {
+			compatible = "ti,tas5086";
+			reg = <0x1b>;
+			reset-gpio = <&gpio 23 0>;
+			ti,charge-period = <156000>;
+		};
+	};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 45b7256..86b3524 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -63,6 +63,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_STA32X if I2C
 	select SND_SOC_STA529 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
+	select SND_SOC_TAS5086 if I2C
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC32X4 if I2C
@@ -320,6 +321,9 @@ config SND_SOC_STA529
 config SND_SOC_STAC9766
 	tristate
 
+config SND_SOC_TAS5086
+	tristate
+
 config SND_SOC_TLV320AIC23
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6a3b3c3..8077bc2 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -55,6 +55,7 @@ snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-sta32x-objs := sta32x.o
 snd-soc-sta529-objs := sta529.o
 snd-soc-stac9766-objs := stac9766.o
+snd-soc-tas5086-objs := tas5086.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
@@ -177,6 +178,7 @@ obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_STA32X)   += snd-soc-sta32x.o
 obj-$(CONFIG_SND_SOC_STA529)   += snd-soc-sta529.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
+obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
new file mode 100644
index 0000000..cd3c267
--- /dev/null
+++ b/sound/soc/codecs/tas5086.c
@@ -0,0 +1,587 @@
+/*
+ * TAS5086 ASoC codec driver
+ *
+ * Copyright (c) 2013 Daniel Mack <zonque@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * TODO:
+ *  - implement DAPM and input muxing
+ *  - implement modulation limit
+ *  - implement non-default PWM start
+ *
+ * Note that this chip has a very unusual register layout, specifically
+ * because the registers are of unequal size, and multi-byte registers
+ * require bulk writes to take effect. Regmap does not support that kind
+ * of devices.
+ *
+ * Currently, the driver does not touch any of the registers >= 0x20, so
+ * it doesn't matter because the entire map can be accessed as 8-bit
+ * array. In case more features will be added in the future
+ * that require access to higher registers, the entire regmap H/W I/O
+ * routines have to be open-coded.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define TAS5086_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE  |		\
+			     SNDRV_PCM_FMTBIT_S20_3LE |		\
+			     SNDRV_PCM_FMTBIT_S24_3LE)
+
+#define TAS5086_PCM_RATES   (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100  | \
+			     SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200  | \
+			     SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 | \
+			     SNDRV_PCM_RATE_192000)
+
+/*
+ * TAS5086 registers
+ */
+#define TAS5086_CLOCK_CONTROL		0x00	/* Clock control register  */
+#define TAS5086_CLOCK_RATE(val)		(val << 5)
+#define TAS5086_CLOCK_RATE_MASK		(0x7 << 5)
+#define TAS5086_CLOCK_RATIO(val)	(val << 2)
+#define TAS5086_CLOCK_RATIO_MASK	(0x7 << 2)
+#define TAS5086_CLOCK_SCLK_RATIO_48	(1 << 1)
+#define TAS5086_CLOCK_VALID		(1 << 0)
+
+#define TAS5086_DEV_ID			0x01	/* Device ID register */
+#define TAS5086_ERROR_STATUS		0x02	/* Error status register */
+#define TAS5086_SYS_CONTROL_1		0x03	/* System control register 1 */
+#define TAS5086_SERIAL_DATA_IF		0x04	/* Serial data interface register  */
+#define TAS5086_SYS_CONTROL_2		0x05	/* System control register 2 */
+#define TAS5086_SOFT_MUTE		0x06	/* Soft mute register */
+#define TAS5086_MASTER_VOL		0x07	/* Master volume  */
+#define TAS5086_CHANNEL_VOL(X)		(0x08 + (X))	/* Channel 1-6 volume */
+#define TAS5086_VOLUME_CONTROL		0x09	/* Volume control register */
+#define TAS5086_MOD_LIMIT		0x10	/* Modulation limit register */
+#define TAS5086_PWM_START		0x18	/* PWM start register */
+#define TAS5086_SURROUND		0x19	/* Surround register */
+#define TAS5086_SPLIT_CAP_CHARGE	0x1a	/* Split cap charge period register */
+#define TAS5086_OSC_TRIM		0x1b	/* Oscillator trim register */
+#define TAS5086_BKNDERR 		0x1c
+
+#define TAS5086_DEEMPH_MASK		0x03
+
+/*
+ * Default TAS5086 power-up configuration
+ */
+static const struct reg_default tas5086_reg_defaults[] = {
+	{ 0x00,	0x6c },
+	{ 0x01,	0x03 },
+	{ 0x02,	0x00 },
+	{ 0x03,	0xa0 },
+	{ 0x04,	0x05 },
+	{ 0x05,	0x60 },
+	{ 0x06,	0x00 },
+	{ 0x07,	0xff },
+	{ 0x08,	0x30 },
+	{ 0x09,	0x30 },
+	{ 0x0a,	0x30 },
+	{ 0x0b,	0x30 },
+	{ 0x0c,	0x30 },
+	{ 0x0d,	0x30 },
+	{ 0x0e,	0xb1 },
+	{ 0x0f,	0x00 },
+	{ 0x10,	0x02 },
+	{ 0x11,	0x00 },
+	{ 0x12,	0x00 },
+	{ 0x13,	0x00 },
+	{ 0x14,	0x00 },
+	{ 0x15,	0x00 },
+	{ 0x16,	0x00 },
+	{ 0x17,	0x00 },
+	{ 0x18,	0x3f },
+	{ 0x19,	0x00 },
+	{ 0x1a,	0x18 },
+	{ 0x1b,	0x82 },
+	{ 0x1c,	0x05 },
+};
+
+static bool tas5086_accessible_reg(struct device *dev, unsigned int reg)
+{
+	return !((reg == 0x0f) || (reg >= 0x11 && reg <= 0x17));
+}
+
+static bool tas5086_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == TAS5086_DEV_ID ||
+	       reg == TAS5086_ERROR_STATUS;
+}
+
+static bool tas5086_writeable_reg(struct device *dev, unsigned int reg)
+{
+	return tas5086_accessible_reg(dev, reg) && (reg != TAS5086_DEV_ID);
+}
+
+struct tas5086_private {
+	struct regmap	*regmap;
+	unsigned int	mclk, sclk;
+	unsigned int	format;
+	bool		deemph;
+	/* Current sample rate for de-emphasis control */
+	int		rate;
+	/* GPIO driving Reset pin, if any */
+	int		gpio_nreset;
+};
+
+static int tas5086_deemph[] = { 0, 32000, 44100, 48000 };
+
+static int tas5086_set_deemph(struct snd_soc_codec *codec)
+{
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	int i, val = 0;
+
+	if (priv->deemph)
+		for (i = 0; i < ARRAY_SIZE(tas5086_deemph); i++)
+			if (tas5086_deemph[i] == priv->rate)
+				val = i;
+
+	return regmap_update_bits(priv->regmap, TAS5086_SYS_CONTROL_1,
+				  TAS5086_DEEMPH_MASK, val);
+}
+
+static int tas5086_get_deemph(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = priv->deemph;
+
+	return 0;
+}
+
+static int tas5086_put_deemph(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->deemph = ucontrol->value.enumerated.item[0];
+
+	return tas5086_set_deemph(codec);
+}
+
+
+static int tas5086_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	switch (clk_id) {
+	case 0:		/* MCLK */
+		priv->mclk = freq;
+		break;
+	case 1:		/* SCLK */
+		priv->sclk = freq;
+		break;
+	}
+
+	return 0;
+}
+
+static int tas5086_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			       unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	/* The TAS5086 can only be slave to all clocks */
+	if ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
+		dev_err(codec->dev, "Invalid clocking mode\n");
+		return -EINVAL;
+	}
+
+	/* we need to refer to the data format from hw_params() */
+	priv->format = format;
+
+	return 0;
+}
+
+static const int tas5086_sample_rates[] = {
+	32000, 38000, 44100, 48000, 88200, 96000, 176400, 192000
+};
+
+static const int tas5086_ratios[] = {
+	64, 128, 192, 256, 384, 512
+};
+
+static int index_in_array(const int *array, int len, int needle)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (array[i] == needle)
+			return i;
+
+	return -ENOENT;
+}
+
+static int tas5086_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
+	int ret;
+
+	priv->rate = params_rate(params);
+
+	/* Look up the sample rate and refer to the offset in the list */
+	val = index_in_array(tas5086_sample_rates,
+			     ARRAY_SIZE(tas5086_sample_rates), priv->rate);
+
+	if (val < 0) {
+		dev_err(codec->dev, "Invalid sample rate\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(priv->regmap, TAS5086_CLOCK_CONTROL,
+				 TAS5086_CLOCK_RATE_MASK,
+				 TAS5086_CLOCK_RATE(val));
+	if (ret < 0)
+		return ret;
+
+	/* MCLK / Fs ratio */
+	val = index_in_array(tas5086_ratios, ARRAY_SIZE(tas5086_ratios),
+			     priv->mclk / priv->rate);
+	if (val < 0) {
+		dev_err(codec->dev, "Inavlid MCLK / Fs ratio\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(priv->regmap, TAS5086_CLOCK_CONTROL,
+				 TAS5086_CLOCK_RATIO_MASK,
+				 TAS5086_CLOCK_RATIO(val));
+	if (ret < 0)
+		return ret;
+
+
+	ret = regmap_update_bits(priv->regmap, TAS5086_CLOCK_CONTROL,
+				 TAS5086_CLOCK_SCLK_RATIO_48,
+				 (priv->sclk == 48 * priv->rate) ? 
+					TAS5086_CLOCK_SCLK_RATIO_48 : 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The chip has a very unituitive register mapping and muxes information
+	 * about data format and sample depth into the same register, but not on
+	 * a logical bit-boundary. Hence, we have to refer to the format passed
+	 * in the set_dai_fmt() callback and set up everything from here.
+	 *
+	 * First, determine the 'base' value, using the format ...
+	 */
+	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		val = 0x00;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		val = 0x03;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		val = 0x06;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	/* ... then add the offset for the sample bit depth. */
+	switch (params_format(params)) {
+        case SNDRV_PCM_FORMAT_S16_LE:
+		val += 0;
+                break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		val += 1;
+		break;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		val += 2;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid bit width\n");
+		return -EINVAL;
+	};
+
+	ret = regmap_write(priv->regmap, TAS5086_SERIAL_DATA_IF, val);
+	if (ret < 0)
+		return ret;
+
+	/* clock is considered valid now */
+	ret = regmap_update_bits(priv->regmap, TAS5086_CLOCK_CONTROL,
+				 TAS5086_CLOCK_VALID, TAS5086_CLOCK_VALID);
+	if (ret < 0)
+		return ret;
+
+	return tas5086_set_deemph(codec);
+}
+
+static int tas5086_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	return regmap_write(priv->regmap, TAS5086_SOFT_MUTE,
+			    mute ? 0x3f : 0x00);
+}
+
+/* TAS5086 controls */
+static const DECLARE_TLV_DB_SCALE(tas5086_dac_tlv, -10350, 50, 1);
+
+static const struct snd_kcontrol_new tas5086_controls[] = {
+	SOC_SINGLE_TLV("Master Playback Volume", TAS5086_MASTER_VOL,
+		       0, 0xff, 1, tas5086_dac_tlv),
+	SOC_DOUBLE_R_TLV("Channel 1/2 Playback Volume",
+			 TAS5086_CHANNEL_VOL(0), TAS5086_CHANNEL_VOL(1),
+			 0, 0xff, 1, tas5086_dac_tlv),
+	SOC_DOUBLE_R_TLV("Channel 3/4 Playback Volume",
+			 TAS5086_CHANNEL_VOL(2), TAS5086_CHANNEL_VOL(3),
+			 0, 0xff, 1, tas5086_dac_tlv),
+	SOC_DOUBLE_R_TLV("Channel 5/6 Playback Volume",
+			 TAS5086_CHANNEL_VOL(4), TAS5086_CHANNEL_VOL(5),
+			 0, 0xff, 1, tas5086_dac_tlv),
+	SOC_SINGLE_BOOL_EXT("De-emphasis Switch", 0,
+			    tas5086_get_deemph, tas5086_put_deemph),
+};
+
+static const struct snd_soc_dai_ops tas5086_dai_ops = {
+	.hw_params	= tas5086_hw_params,
+	.set_sysclk	= tas5086_set_dai_sysclk,
+	.set_fmt	= tas5086_set_dai_fmt,
+	.digital_mute	= tas5086_digital_mute,
+};
+
+static struct snd_soc_dai_driver tas5086_dai = {
+	.name = "tas5086-hifi",
+	.playback = {
+		.stream_name	= "Playback",
+		.channels_min	= 2,
+		.channels_max	= 6,
+		.rates		= TAS5086_PCM_RATES,
+		.formats	= TAS5086_PCM_FORMATS,
+	},
+	.ops = &tas5086_dai_ops,
+};
+
+#ifdef CONFIG_PM
+static int tas5086_soc_suspend(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static int tas5086_soc_resume(struct snd_soc_codec *codec)
+{
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	/* Restore codec state */
+	return regcache_sync(priv->regmap);
+}
+#else
+#define tas5086_soc_suspend	NULL
+#define tas5086_soc_resume	NULL
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_OF
+static const struct of_device_id tas5086_dt_ids[] = {
+	{ .compatible = "ti,tas5086", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tas5086_dt_ids);
+#endif
+
+/* charge period values in microseconds */
+static const int tas5086_charge_period[] = {
+	  13000,  16900,   23400,   31200,   41600,   54600,   72800,   96200,
+	 130000, 156000,  234000,  312000,  416000,  546000,  728000,  962000,
+	1300000, 169000, 2340000, 3120000, 4160000, 5460000, 7280000, 9620000,
+};
+
+static int tas5086_probe(struct snd_soc_codec *codec)
+{
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	int charge_period = 1300000; /* hardware default is 1300 ms */
+	int gpio_nreset = -EINVAL;
+	int i, ret;
+
+	if (of_match_device(of_match_ptr(tas5086_dt_ids), codec->dev)) {
+		struct device_node *of_node = codec->dev->of_node;
+
+		gpio_nreset = of_get_named_gpio(of_node, "reset-gpio", 0);
+		of_property_read_u32(of_node, "ti,charge-period", &charge_period);
+	}
+
+	if (gpio_nreset >= 0)
+		if (devm_gpio_request(codec->dev, gpio_nreset, "TAS5086 Reset"))
+			gpio_nreset = -EINVAL;
+	if (gpio_nreset >= 0) {
+		/* Reset codec - minimum assertion time is 400ns */
+		gpio_direction_output(gpio_nreset, 0);
+		udelay(1);
+		gpio_set_value(gpio_nreset, 1);
+
+		/* Codec needs ~15ms to wake up */
+		msleep(15);
+	}
+msleep(300);
+	priv->gpio_nreset = gpio_nreset;
+
+	/* The TAS5086 always returns 0x03 in its TAS5086_DEV_ID register */
+	ret = regmap_read(priv->regmap, TAS5086_DEV_ID, &i);
+	if (ret < 0)
+		return ret;
+
+	if (i != 0x3) {
+		dev_err(codec->dev,
+			"Failed to identify TAS5086 codec (got %02x)\n", i);
+		return -ENODEV;
+	}
+
+	/* lookup and set split-capacitor charge period */
+	if (charge_period == 0) {
+		regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE, 0);
+	} else {
+		i = index_in_array(tas5086_charge_period,
+				   ARRAY_SIZE(tas5086_charge_period),
+				   charge_period);
+		if (i >= 0)
+			regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE,
+				     i + 0x08);
+		else
+			dev_warn(codec->dev,
+				 "Invalid split-cap charge period of %d ns.\n",
+				 charge_period);
+	}
+
+	/* enable factory trim */
+	ret = regmap_write(priv->regmap, TAS5086_OSC_TRIM, 0x00);
+	if (ret < 0)
+		return ret;
+
+	/* start all channels */
+	ret = regmap_write(priv->regmap, TAS5086_SYS_CONTROL_2, 0x20);
+	if (ret < 0)
+		return ret;
+
+	/* set master volume to 0 dB */
+	ret = regmap_write(priv->regmap, TAS5086_MASTER_VOL, 0x30);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int tas5086_remove(struct snd_soc_codec *codec)
+{
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	if (gpio_is_valid(priv->gpio_nreset))
+		/* Set codec to the reset state */
+		gpio_set_value(priv->gpio_nreset, 0);
+
+	return 0;
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_tas5086 = {
+	.probe			= tas5086_probe,
+	.remove			= tas5086_remove,
+	.suspend		= tas5086_soc_suspend,
+	.resume			= tas5086_soc_resume,
+	.controls		= tas5086_controls,
+	.num_controls		= ARRAY_SIZE(tas5086_controls),
+};
+
+static const struct i2c_device_id tas5086_i2c_id[] = {
+	{ "tas5086", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tas5086_i2c_id);
+
+static const struct regmap_config tas5086_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= ARRAY_SIZE(tas5086_reg_defaults),
+	.reg_defaults		= tas5086_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(tas5086_reg_defaults),
+	.cache_type		= REGCACHE_RBTREE,
+	.volatile_reg		= tas5086_volatile_reg,
+	.writeable_reg		= tas5086_writeable_reg,
+	.readable_reg		= tas5086_accessible_reg,
+};
+
+static int tas5086_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct tas5086_private *priv;
+	int ret;
+
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = devm_regmap_init_i2c(i2c, &tas5086_regmap);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		dev_err(&i2c->dev, "Failed to create regmap: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(i2c, priv);
+
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tas5086,
+		&tas5086_dai, 1);
+}
+
+static int tas5086_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+	return 0;
+}
+
+static struct i2c_driver tas5086_i2c_driver = {
+	.driver = {
+		.name	= "tas5086",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(tas5086_dt_ids),
+	},
+	.id_table	= tas5086_i2c_id,
+	.probe		= tas5086_i2c_probe,
+	.remove		= tas5086_i2c_remove,
+};
+
+static int __init tas5086_modinit(void)
+{
+	return i2c_add_driver(&tas5086_i2c_driver);
+}
+module_init(tas5086_modinit);
+
+static void __exit tas5086_modexit(void)
+{
+	i2c_del_driver(&tas5086_i2c_driver);
+}
+module_exit(tas5086_modexit);
+
+MODULE_AUTHOR("Daniel Mack <zonque@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments TAS5086 ALSA SoC Codec Driver");
+MODULE_LICENSE("GPL");
-- 
1.8.1.4
