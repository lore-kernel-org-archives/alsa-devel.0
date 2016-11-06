From: Aurelien Chanot <chanot.a@gmail.com>
Subject: [PATCH] ASoC: tas642x: Add initial support for TAS642x
	amplifiers.
Date: Sat,  5 Nov 2016 17:21:51 -0700
Message-ID: <20161106002151.16968-1-chanot.a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Aurelien Chanot <chanot.a@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for Texas Intrument Amplifier TAS642X.

Signed-off-by: Aurelien Chanot <chanot.a@gmail.com>
---
 .../devicetree/bindings/sound/tas642x.txt          |  27 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas642x.c                         | 374 +++++++++++++++++++++
 sound/soc/codecs/tas642x.h                         |  32 ++
 5 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas642x.txt
 create mode 100644 sound/soc/codecs/tas642x.c
 create mode 100644 sound/soc/codecs/tas642x.h

diff --git a/Documentation/devicetree/bindings/sound/tas642x.txt b/Documentation/devicetree/bindings/sound/tas642x.txt
new file mode 100644
index 0000000..57abe6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas642x.txt
@@ -0,0 +1,27 @@
+Texas Instruments TAS642X Audio amplifier
+
+The TAS642X serial control bus communicates through the I2C protocol only. The
+serial bus is also used for periodic codec fault checking/reporting during
+audio playback. For more product information please see the links below:
+
+http://www.ti.com/product/TAS6424-Q1
+
+
+Required properties:
+
+- compatible: "ti,tas6424"
+- reg: I2C slave address
+
+Optional properties:
+
+- chan-swap : swap channels 1-2 with 3-4
+- chan-sel: uses channels 1 to 4 (0) or 5 to 8(1) from the TDM input.
+
+Example:
+
+tas6424: tas6424@64 {
+	status = "okay";
+	compatible = "ti,tas6424";
+	reg = <0x6c>;
+	chan-sel = <1>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c67667b..dce371e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -135,6 +135,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TAS5086 if I2C
 	select SND_SOC_TAS571X if I2C
 	select SND_SOC_TAS5720 if I2C
+	select SND_SOC_TAS642X if I2C
 	select SND_SOC_TFA9879 if I2C
 	select SND_SOC_TLV320AIC23_I2C if I2C
 	select SND_SOC_TLV320AIC23_SPI if SPI_MASTER
@@ -812,6 +813,10 @@ config SND_SOC_TAS5720
 	  Enable support for Texas Instruments TAS5720L/M high-efficiency mono
 	  Class-D audio power amplifiers.
 
+config SND_SOC_TAS642X
+	tristate "Texas Instruments TAS6424 speaker amplifier"
+	depends on I2C
+
 config SND_SOC_TFA9879
 	tristate "NXP Semiconductors TFA9879 amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 958cd49..3f49516 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -142,6 +142,7 @@ snd-soc-sti-sas-objs := sti-sas.o
 snd-soc-tas5086-objs := tas5086.o
 snd-soc-tas571x-objs := tas571x.o
 snd-soc-tas5720-objs := tas5720.o
+snd-soc-tas642x-objs := tas642x.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic23-i2c-objs := tlv320aic23-i2c.o
@@ -363,6 +364,7 @@ obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
+obj-$(CONFIG_SND_SOC_TAS642X)	+= snd-soc-tas642x.o
 obj-$(CONFIG_SND_SOC_TFA9879)	+= snd-soc-tfa9879.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23_I2C)	+= snd-soc-tlv320aic23-i2c.o
diff --git a/sound/soc/codecs/tas642x.c b/sound/soc/codecs/tas642x.c
new file mode 100644
index 0000000..16f2c94
--- /dev/null
+++ b/sound/soc/codecs/tas642x.c
@@ -0,0 +1,374 @@
+/*
+ * TAS642x amplifier audio driver
+ *
+ * Copyright (C) 2016 Witekio
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/stddef.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "tas642x.h"
+
+struct tas642x_chip {
+	struct snd_soc_codec_driver     codec_driver;
+	const struct regmap_config      *regmap_config;
+	int                             channel_number;
+};
+
+struct tas642x_private {
+	struct device                   *dev;
+	const struct tas642x_chip       *chip;
+	struct regmap                   *regmap;
+	struct clk                      *mclk;
+	unsigned int                    format;
+	unsigned int                    chan_sel; /* 0=1-4; 1=5-8 */
+	unsigned int                    chan_swap; /* 0=No; 1=Yes */
+};
+
+static int tas642x_reg_write(void *context, unsigned int reg,
+			     unsigned int value)
+{
+	struct i2c_client *client = context;
+	unsigned int size;
+	uint8_t buf[3];
+	int ret;
+
+	size = 2;
+	buf[0] = reg;
+	buf[1] = value;
+
+	ret = i2c_master_send(client, buf, size);
+	if (ret == size)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int tas642x_reg_read(void *context, unsigned int reg,
+			    unsigned int *value)
+{
+	struct i2c_client *client = context;
+	uint8_t send_buf, recv_buf[4];
+	struct i2c_msg msgs[2];
+	unsigned int size;
+	unsigned int i;
+	int ret;
+
+	size = 1;
+	send_buf = reg;
+
+	msgs[0].addr = client->addr;
+	msgs[0].len = sizeof(send_buf);
+	msgs[0].buf = &send_buf;
+	msgs[0].flags = 0;
+
+	msgs[1].addr = client->addr;
+	msgs[1].len = size;
+	msgs[1].buf = recv_buf;
+	msgs[1].flags = I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+	else if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	*value = 0;
+
+	for (i = 0; i < size; i++) {
+		*value <<= 8;
+		*value |= recv_buf[i];
+	}
+
+	return 0;
+}
+
+static int tas6424_set_dai_fmt(struct snd_soc_dai *dai, unsigned int format)
+{
+	struct tas642x_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+
+	/* set master/slave audio interface. Only support slave */
+	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		pr_err("Only support Slave mode!\n");
+		return -EINVAL;
+	}
+
+	priv->format = format;
+
+	return 0;
+}
+
+static int tas6424_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct tas642x_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+	u32 val;
+
+	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		val = 0x00;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		val = 0x04;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		val = 0x05;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		val = 0x06;
+		break;
+	default:
+		pr_info("Invalid format (0x%x)!!\n",
+				priv->format & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	if (params_width(params) < 24)
+		val += 0x10;
+
+	if (priv->chan_sel)
+		val += 0x20;
+
+	if (priv->chan_swap > 0)
+		val += 0x08;
+
+	val = regmap_update_bits(priv->regmap, TAS642X_SAP_CTRL,
+				  TAS642X_SAP_FMT_MSK |
+				  TAS642X_SAP_CH_SWP_MSK |
+				  TAS642X_SAP_TDM_SIZ_MSK |
+				  TAS642X_SAP_TDM_SEL_MSK,
+				  val);
+	pr_info("%s: regmap return 0x%x\n", __func__, val);
+	return val;
+}
+
+static const struct snd_soc_dai_ops tas6424_dai_ops = {
+	.set_fmt	= tas6424_set_dai_fmt,
+	.hw_params	= tas6424_hw_params,
+};
+
+static const struct reg_default tas642x_reg_defaults[] = {
+	{ TAS642X_MODE_CTRL, 0x00 },
+	{ TAS642X_MISC_CTRL1, 0x32 },
+	{ TAS642X_MISC_CTRL2, 0x62 },
+	{ TAS642X_SAP_CTRL, 0x04 },
+	{ TAS642X_CH_STATE, 0xAA },
+	{ TAS642X_CH1_VOL, 0xCF },
+	{ TAS642X_CH2_VOL, 0xCF },
+	{ TAS642X_CH3_VOL, 0xCF },
+	{ TAS642X_CH4_VOL, 0xCF },
+};
+
+
+static const struct regmap_config tas642x_regmap_config = {
+	.reg_bits				= 8,
+	.val_bits				= 8,
+	.max_register			= 0xff,
+	.reg_read				= tas642x_reg_read,
+	.reg_write				= tas642x_reg_write,
+	.reg_defaults			= tas642x_reg_defaults,
+	.num_reg_defaults		= ARRAY_SIZE(tas642x_reg_defaults),
+	.cache_type				= REGCACHE_RBTREE,
+};
+
+static const DECLARE_TLV_DB_SCALE(tas642x_volume_tlv, -10350, 50, 1);
+
+static const struct snd_kcontrol_new tas6424_controls[] = {
+	SOC_SINGLE("Spk 1 Playback Switch", TAS642X_CH_STATE, 7, 1, 1),
+	SOC_SINGLE_TLV("Spk 1 Playback Volume",
+			 TAS642X_CH1_VOL,
+			 0, 0xff, 0, tas642x_volume_tlv),
+	SOC_SINGLE("Spk 2 Playback Switch", TAS642X_CH_STATE, 5, 1, 1),
+	SOC_SINGLE_TLV("Spk 2 Playback Volume",
+			 TAS642X_CH2_VOL,
+			 0, 0xff, 0, tas642x_volume_tlv),
+	SOC_SINGLE("Spk 3 Playback Switch", TAS642X_CH_STATE, 3, 1, 1),
+	SOC_SINGLE_TLV("Spk 3 Playback Volume",
+			 TAS642X_CH3_VOL,
+			 0, 0xff, 0, tas642x_volume_tlv),
+	SOC_SINGLE("Spk 4 Playback Switch", TAS642X_CH_STATE, 1, 1, 1),
+	SOC_SINGLE_TLV("Spk 4 Playback Volume",
+			 TAS642X_CH4_VOL,
+			 0, 0xff, 0, tas642x_volume_tlv),
+};
+
+static const struct snd_soc_dapm_route tas642x_1_dapm_routes[] = {
+	{ "Speaker 1",  NULL, "Playback" },
+	{ "Speaker 2",  NULL, "Playback" },
+	{ "Speaker 3",  NULL, "Playback" },
+	{ "Speaker 4",  NULL, "Playback" },
+	{ "OUT_1", NULL, "Speaker 1" },
+	{ "OUT_2", NULL, "Speaker 2" },
+	{ "OUT_3", NULL, "Speaker 3" },
+	{ "OUT_4", NULL, "Speaker 4" },
+};
+
+
+static const struct snd_soc_dapm_widget tas6424_1_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("Speaker 1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("Speaker 2", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("Speaker 3", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("Speaker 4", NULL, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_OUTPUT("OUT_1"),
+	SND_SOC_DAPM_OUTPUT("OUT_2"),
+	SND_SOC_DAPM_OUTPUT("OUT_3"),
+	SND_SOC_DAPM_OUTPUT("OUT_4"),
+};
+
+
+static int tas642x_codec_probe(struct snd_soc_codec *codec)
+{
+	pr_info("TAS642X: i2c codec Probe\n");
+	/* Set All channels to mute */
+	snd_soc_write(codec, TAS642X_CH_STATE, 0xAA);
+	return 0;
+}
+
+static const struct tas642x_chip tas6424_chip = {
+	.codec_driver = {
+		.probe = tas642x_codec_probe,
+		.component_driver = {
+			.controls          = tas6424_controls,
+			.num_controls      = ARRAY_SIZE(tas6424_controls),
+			.dapm_widgets      = tas6424_1_dapm_widgets,
+			.num_dapm_widgets  = ARRAY_SIZE(tas6424_1_dapm_widgets),
+			.dapm_routes       = tas642x_1_dapm_routes,
+			.num_dapm_routes   = ARRAY_SIZE(tas642x_1_dapm_routes),
+		},
+	},
+	.regmap_config			= &tas642x_regmap_config,
+	.channel_number			= 4,
+};
+
+static struct snd_soc_dai_driver tas642x_dai = {
+	.name = "tas642x-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 4,
+		.channels_max = 4,
+		.rates = SNDRV_PCM_RATE_44100 |
+			   SNDRV_PCM_RATE_48000 |
+			   SNDRV_PCM_RATE_96000,
+		.formats = SNDRV_PCM_FMTBIT_S24_LE |
+			   SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &tas6424_dai_ops,
+};
+
+static const struct of_device_id tas642x_of_match[];
+
+#if defined(CONFIG_OF)
+static void tas642x_pdata_from_of(struct tas642x_private *priv)
+{
+	struct device_node *np = priv->dev->of_node;
+
+	priv->chan_swap = of_property_read_bool(np, "chan-swap");
+	priv->chan_sel = of_property_read_bool(np, "chan-sel");
+}
+#else /* CONFIG_OF */
+static void tas642x_pdata_from_of(struct tas642x_private *priv)
+{
+}
+#endif /* CONFIG_OF */
+
+void tas642x_device_init(struct tas642x_private *priv)
+{
+	dev_set_drvdata(priv->dev, priv);
+
+	if (priv->dev->of_node)
+		tas642x_pdata_from_of(priv);
+}
+
+static int tas642x_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct tas642x_private *priv;
+	struct device *dev = &client->dev;
+	const struct of_device_id *of_id;
+
+	dev_info(dev, "i2c Probe\n");
+
+	priv = (struct tas642x_private *)devm_kzalloc(dev,
+			sizeof(struct tas642x_private),
+			GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	of_id = of_match_device(tas642x_of_match, dev);
+	if (!of_id) {
+		dev_err(dev, "Unknown device type\n");
+		return -EINVAL;
+	}
+	priv->chip = of_id->data;
+	priv->dev = dev;
+	i2c_set_clientdata(client, priv);
+	priv->regmap = devm_regmap_init_i2c(client, priv->chip->regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+
+	tas642x_device_init(priv);
+
+	dev_info(dev, "i2c Probe Ends!\n");
+	return snd_soc_register_codec(&client->dev, &tas6424_chip.codec_driver,
+				      &tas642x_dai, 1);
+}
+
+static int tas642x_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct of_device_id tas642x_of_match[] = {
+	{ .compatible = "ti,tas6424", .data = &tas6424_chip, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tas642x_of_match);
+
+static const struct i2c_device_id tas642x_i2c_id[] = {
+	{ "tas6424", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tas642x_i2c_id);
+
+static struct i2c_driver tas642x_i2c_driver = {
+	.driver = {
+		.name = "tas642x",
+		.of_match_table = of_match_ptr(tas642x_of_match),
+	},
+	.probe = tas642x_i2c_probe,
+	.remove = tas642x_i2c_remove,
+	.id_table = tas642x_i2c_id,
+};
+module_i2c_driver(tas642x_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC tas642x driver");
+MODULE_AUTHOR("Aurelien Chanot <chanot.a@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tas642x.h b/sound/soc/codecs/tas642x.h
new file mode 100644
index 0000000..e0dec07
--- /dev/null
+++ b/sound/soc/codecs/tas642x.h
@@ -0,0 +1,32 @@
+/*
+ * TAS642X amplifier audio driver
+ *
+ * Copyright (C) 2016 Witekio
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _TAS642X_H
+#define _TAS642X_H
+
+/* device registers */
+#define TAS642X_MODE_CTRL   0x00
+#define TAS642X_MISC_CTRL1  0x01
+#define TAS642X_MISC_CTRL2  0x02
+
+#define TAS642X_SAP_CTRL    0x03
+#   define TAS642X_SAP_SAMP_MSK     0xC0
+#   define TAS642X_SAP_TDM_SEL_MSK  0x20
+#   define TAS642X_SAP_TDM_SIZ_MSK  0x10
+#   define TAS642X_SAP_CH_SWP_MSK   0x08
+#   define TAS642X_SAP_FMT_MSK      0x07
+#define TAS642X_CH_STATE    0x04
+#define TAS642X_CH1_VOL     0x05
+#define TAS642X_CH2_VOL     0x06
+#define TAS642X_CH3_VOL     0x07
+#define TAS642X_CH4_VOL     0x08
+
+#endif /* _TAS642X_H */
-- 
2.9.3
