From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add max98371 codec driver" to the asoc
	tree
Date: Thu, 28 Apr 2016 18:47:35 +0100
Message-ID: <E1avq2J-00024N-A1@debutante>
References: <1461796745-31281-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B85F226518B
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 19:47:44 +0200 (CEST)
In-Reply-To: <1461796745-31281-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add max98371 codec driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ca2cd6bc6663314ba7fbf66ba7b14e099671420e Mon Sep 17 00:00:00 2001
From: anish kumar <yesanishhere@gmail.com>
Date: Wed, 27 Apr 2016 15:39:05 -0700
Subject: [PATCH] ASoC: Add max98371 codec driver

Signed-off-by: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/max98371.txt         |  17 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   1 +
 sound/soc/codecs/max98371.c                        | 442 +++++++++++++++++++++
 sound/soc/codecs/max98371.h                        |  67 ++++
 5 files changed, 531 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98371.txt
 create mode 100644 sound/soc/codecs/max98371.c
 create mode 100644 sound/soc/codecs/max98371.h

diff --git a/Documentation/devicetree/bindings/sound/max98371.txt b/Documentation/devicetree/bindings/sound/max98371.txt
new file mode 100644
index 000000000000..6c285235e64b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98371.txt
@@ -0,0 +1,17 @@
+max98371 codec
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "maxim,max98371"
+- reg : The chip select number on the I2C bus
+
+Example:
+
+&i2c {
+	max98371: max98371@0x31 {
+		compatible = "maxim,max98371";
+		reg = <0x31>;
+	};
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 649e92a252ae..d764f1329042 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -79,6 +79,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98090 if I2C
 	select SND_SOC_MAX98095 if I2C
 	select SND_SOC_MAX98357A if GPIOLIB
+	select SND_SOC_MAX98371 if I2C
 	select SND_SOC_MAX9867 if I2C
 	select SND_SOC_MAX98925 if I2C
 	select SND_SOC_MAX98926 if I2C
@@ -522,6 +523,9 @@ config SND_SOC_MAX98095
 config SND_SOC_MAX98357A
        tristate
 
+config SND_SOC_MAX98371
+       tristate
+
 config SND_SOC_MAX9867
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 185a712a7fe7..92ef8719c311 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -74,6 +74,7 @@ snd-soc-max98088-objs := max98088.o
 snd-soc-max98090-objs := max98090.o
 snd-soc-max98095-objs := max98095.o
 snd-soc-max98357a-objs := max98357a.o
+snd-soc-max98371-objs := max98371.o
 snd-soc-max9867-objs := max9867.o
 snd-soc-max98925-objs := max98925.o
 snd-soc-max98926-objs := max98926.o
diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
new file mode 100644
index 000000000000..21fae0932137
--- /dev/null
+++ b/sound/soc/codecs/max98371.c
@@ -0,0 +1,442 @@
+/*
+ * max98371.c -- ALSA SoC Stereo MAX98371 driver
+ *
+ * Copyright 2015-16 Maxim Integrated Products
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include "max98371.h"
+
+static const char *const monomix_text[] = {
+	"Left", "Right", "LeftRightDiv2",
+};
+
+static const char *const hpf_cutoff_txt[] = {
+	"Disable", "DC Block", "50Hz",
+	"100Hz", "200Hz", "400Hz", "800Hz",
+};
+
+static SOC_ENUM_SINGLE_DECL(max98371_monomix, MAX98371_MONOMIX_CFG, 0,
+		monomix_text);
+
+static SOC_ENUM_SINGLE_DECL(max98371_hpf_cutoff, MAX98371_HPF, 0,
+		hpf_cutoff_txt);
+
+static const DECLARE_TLV_DB_RANGE(max98371_dht_min_gain,
+	0, 1, TLV_DB_SCALE_ITEM(537, 66, 0),
+	2, 3, TLV_DB_SCALE_ITEM(677, 82, 0),
+	4, 5, TLV_DB_SCALE_ITEM(852, 104, 0),
+	6, 7, TLV_DB_SCALE_ITEM(1072, 131, 0),
+	8, 9, TLV_DB_SCALE_ITEM(1350, 165, 0),
+	10, 11, TLV_DB_SCALE_ITEM(1699, 101, 0),
+);
+
+static const DECLARE_TLV_DB_RANGE(max98371_dht_max_gain,
+	0, 1, TLV_DB_SCALE_ITEM(537, 66, 0),
+	2, 3, TLV_DB_SCALE_ITEM(677, 82, 0),
+	4, 5, TLV_DB_SCALE_ITEM(852, 104, 0),
+	6, 7, TLV_DB_SCALE_ITEM(1072, 131, 0),
+	8, 9, TLV_DB_SCALE_ITEM(1350, 165, 0),
+	10, 11, TLV_DB_SCALE_ITEM(1699, 208, 0),
+);
+
+static const DECLARE_TLV_DB_RANGE(max98371_dht_rot_gain,
+	0, 1, TLV_DB_SCALE_ITEM(-50, -50, 0),
+	2, 6, TLV_DB_SCALE_ITEM(-100, -100, 0),
+	7, 8, TLV_DB_SCALE_ITEM(-800, -200, 0),
+	9, 11, TLV_DB_SCALE_ITEM(-1200, -300, 0),
+	12, 13, TLV_DB_SCALE_ITEM(-2000, -200, 0),
+	14, 15, TLV_DB_SCALE_ITEM(-2500, -500, 0),
+);
+
+static const struct reg_default max98371_reg[] = {
+	{ 0x01, 0x00 },
+	{ 0x02, 0x00 },
+	{ 0x03, 0x00 },
+	{ 0x04, 0x00 },
+	{ 0x05, 0x00 },
+	{ 0x06, 0x00 },
+	{ 0x07, 0x00 },
+	{ 0x08, 0x00 },
+	{ 0x09, 0x00 },
+	{ 0x0A, 0x00 },
+	{ 0x10, 0x06 },
+	{ 0x11, 0x08 },
+	{ 0x14, 0x80 },
+	{ 0x15, 0x00 },
+	{ 0x16, 0x00 },
+	{ 0x18, 0x00 },
+	{ 0x19, 0x00 },
+	{ 0x1C, 0x00 },
+	{ 0x1D, 0x00 },
+	{ 0x1E, 0x00 },
+	{ 0x1F, 0x00 },
+	{ 0x20, 0x00 },
+	{ 0x21, 0x00 },
+	{ 0x22, 0x00 },
+	{ 0x23, 0x00 },
+	{ 0x24, 0x00 },
+	{ 0x25, 0x00 },
+	{ 0x26, 0x00 },
+	{ 0x27, 0x00 },
+	{ 0x28, 0x00 },
+	{ 0x29, 0x00 },
+	{ 0x2A, 0x00 },
+	{ 0x2B, 0x00 },
+	{ 0x2C, 0x00 },
+	{ 0x2D, 0x00 },
+	{ 0x2E, 0x0B },
+	{ 0x31, 0x00 },
+	{ 0x32, 0x18 },
+	{ 0x33, 0x00 },
+	{ 0x34, 0x00 },
+	{ 0x36, 0x00 },
+	{ 0x37, 0x00 },
+	{ 0x38, 0x00 },
+	{ 0x39, 0x00 },
+	{ 0x3A, 0x00 },
+	{ 0x3B, 0x00 },
+	{ 0x3B, 0x00 },
+	{ 0x3C, 0x00 },
+	{ 0x3D, 0x00 },
+	{ 0x3E, 0x00 },
+	{ 0x3F, 0x00 },
+	{ 0x40, 0x00 },
+	{ 0x41, 0x00 },
+	{ 0x42, 0x00 },
+	{ 0x43, 0x00 },
+	{ 0x4A, 0x00 },
+	{ 0x4B, 0x00 },
+	{ 0x4C, 0x00 },
+	{ 0x4D, 0x00 },
+	{ 0x4E, 0x00 },
+	{ 0x50, 0x00 },
+	{ 0x51, 0x00 },
+	{ 0x55, 0x00 },
+	{ 0x58, 0x00 },
+	{ 0x59, 0x00 },
+	{ 0x5C, 0x00 },
+	{ 0xFF, 0x43 },
+};
+
+static bool max98371_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98371_IRQ_CLEAR1:
+	case MAX98371_IRQ_CLEAR2:
+	case MAX98371_IRQ_CLEAR3:
+	case MAX98371_VERSION:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool max98371_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98371_SOFT_RESET:
+		return false;
+	default:
+		return true;
+	}
+};
+
+static const DECLARE_TLV_DB_RANGE(max98371_gain_tlv,
+	0, 7, TLV_DB_SCALE_ITEM(0, 50, 0),
+	8, 10, TLV_DB_SCALE_ITEM(400, 100, 0)
+);
+
+static const DECLARE_TLV_DB_RANGE(max98371_noload_gain_tlv,
+	0, 11, TLV_DB_SCALE_ITEM(950, 100, 0),
+);
+
+static const DECLARE_TLV_DB_SCALE(digital_tlv, -6300, 50, 1);
+
+static const struct snd_kcontrol_new max98371_snd_controls[] = {
+	SOC_SINGLE_TLV("Speaker Volume", MAX98371_GAIN,
+			MAX98371_GAIN_SHIFT, (1<<MAX98371_GAIN_WIDTH)-1, 0,
+			max98371_gain_tlv),
+	SOC_SINGLE_TLV("Digital Volume", MAX98371_DIGITAL_GAIN, 0,
+			(1<<MAX98371_DIGITAL_GAIN_WIDTH)-1, 1, digital_tlv),
+	SOC_SINGLE_TLV("Speaker DHT Max Volume", MAX98371_GAIN,
+			0, (1<<MAX98371_DHT_MAX_WIDTH)-1, 0,
+			max98371_dht_max_gain),
+	SOC_SINGLE_TLV("Speaker DHT Min Volume", MAX98371_DHT_GAIN,
+			0, (1<<MAX98371_DHT_GAIN_WIDTH)-1, 0,
+			max98371_dht_min_gain),
+	SOC_SINGLE_TLV("Speaker DHT Rotation Volume", MAX98371_DHT_GAIN,
+			0, (1<<MAX98371_DHT_ROT_WIDTH)-1, 0,
+			max98371_dht_rot_gain),
+	SOC_SINGLE("DHT Attack Step", MAX98371_DHT, MAX98371_DHT_STEP, 3, 0),
+	SOC_SINGLE("DHT Attack Rate", MAX98371_DHT, 0, 7, 0),
+	SOC_ENUM("Monomix Select", max98371_monomix),
+	SOC_ENUM("HPF Cutoff", max98371_hpf_cutoff),
+};
+
+static int max98371_dai_set_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct max98371_priv *max98371 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		dev_err(codec->dev, "DAI clock mode unsupported");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		val |= 0;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		val |= MAX98371_DAI_RIGHT;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		val |= MAX98371_DAI_LEFT;
+		break;
+	default:
+		dev_err(codec->dev, "DAI wrong mode unsupported");
+		return -EINVAL;
+	}
+	regmap_update_bits(max98371->regmap, MAX98371_FMT,
+			MAX98371_FMT_MODE_MASK, val);
+	return 0;
+}
+
+static int max98371_dai_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max98371_priv *max98371 = snd_soc_codec_get_drvdata(codec);
+	int blr_clk_ratio, ch_size, channels = params_channels(params);
+	int rate = params_rate(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		regmap_update_bits(max98371->regmap, MAX98371_FMT,
+				MAX98371_FMT_MASK, MAX98371_DAI_CHANSZ_16);
+		ch_size = 8;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		regmap_update_bits(max98371->regmap, MAX98371_FMT,
+				MAX98371_FMT_MASK, MAX98371_DAI_CHANSZ_16);
+		ch_size = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		regmap_update_bits(max98371->regmap, MAX98371_FMT,
+				MAX98371_FMT_MASK, MAX98371_DAI_CHANSZ_32);
+		ch_size = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		regmap_update_bits(max98371->regmap, MAX98371_FMT,
+				MAX98371_FMT_MASK, MAX98371_DAI_CHANSZ_32);
+		ch_size = 32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* BCLK/LRCLK ratio calculation */
+	blr_clk_ratio = channels * ch_size;
+	switch (blr_clk_ratio) {
+	case 32:
+		regmap_update_bits(max98371->regmap,
+			MAX98371_DAI_CLK,
+			MAX98371_DAI_BSEL_MASK, MAX98371_DAI_BSEL_32);
+		break;
+	case 48:
+		regmap_update_bits(max98371->regmap,
+			MAX98371_DAI_CLK,
+			MAX98371_DAI_BSEL_MASK, MAX98371_DAI_BSEL_48);
+		break;
+	case 64:
+		regmap_update_bits(max98371->regmap,
+			MAX98371_DAI_CLK,
+			MAX98371_DAI_BSEL_MASK, MAX98371_DAI_BSEL_64);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (rate) {
+	case 32000:
+		regmap_update_bits(max98371->regmap,
+			MAX98371_SPK_SR,
+			MAX98371_SPK_SR_MASK, MAX98371_SPK_SR_32);
+		break;
+	case 44100:
+		regmap_update_bits(max98371->regmap,
+			MAX98371_SPK_SR,
+			MAX98371_SPK_SR_MASK, MAX98371_SPK_SR_44);
+		break;
+	case 48000:
+		regmap_update_bits(max98371->regmap,
+			MAX98371_SPK_SR,
+			MAX98371_SPK_SR_MASK, MAX98371_SPK_SR_48);
+		break;
+	case 88200:
+		regmap_update_bits(max98371->regmap,
+			MAX98371_SPK_SR,
+			MAX98371_SPK_SR_MASK, MAX98371_SPK_SR_88);
+		break;
+	case 96000:
+		regmap_update_bits(max98371->regmap,
+			MAX98371_SPK_SR,
+			MAX98371_SPK_SR_MASK, MAX98371_SPK_SR_96);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* enabling both the RX channels*/
+	regmap_update_bits(max98371->regmap, MAX98371_MONOMIX_SRC,
+			MAX98371_MONOMIX_SRC_MASK, MONOMIX_RX_0_1);
+	regmap_update_bits(max98371->regmap, MAX98371_DAI_CHANNEL,
+			MAX98371_CHANNEL_MASK, MAX98371_CHANNEL_MASK);
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget max98371_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", NULL, MAX98371_SPK_ENABLE, 0, 0),
+	SND_SOC_DAPM_SUPPLY("Global Enable", MAX98371_GLOBAL_ENABLE,
+		0, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("SPK_OUT"),
+};
+
+static const struct snd_soc_dapm_route max98371_audio_map[] = {
+	{"DAC", NULL, "HiFi Playback"},
+	{"SPK_OUT", NULL, "DAC"},
+	{"SPK_OUT", NULL, "Global Enable"},
+};
+
+#define MAX98371_RATES SNDRV_PCM_RATE_8000_48000
+#define MAX98371_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE | \
+		SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE)
+
+static const struct snd_soc_dai_ops max98371_dai_ops = {
+	.set_fmt = max98371_dai_set_fmt,
+	.hw_params = max98371_dai_hw_params,
+};
+
+static struct snd_soc_dai_driver max98371_dai[] = {
+	{
+		.name = "max98371-aif1",
+		.playback = {
+			.stream_name = "HiFi Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = MAX98371_FORMATS,
+		},
+		.ops = &max98371_dai_ops,
+	}
+};
+
+static const struct snd_soc_codec_driver max98371_codec = {
+	.controls = max98371_snd_controls,
+	.num_controls = ARRAY_SIZE(max98371_snd_controls),
+	.dapm_routes = max98371_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(max98371_audio_map),
+	.dapm_widgets = max98371_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max98371_dapm_widgets),
+};
+
+static const struct regmap_config max98371_regmap = {
+	.reg_bits         = 8,
+	.val_bits         = 8,
+	.max_register     = MAX98371_VERSION,
+	.reg_defaults     = max98371_reg,
+	.num_reg_defaults = ARRAY_SIZE(max98371_reg),
+	.volatile_reg     = max98371_volatile_register,
+	.readable_reg     = max98371_readable_register,
+	.cache_type       = REGCACHE_RBTREE,
+};
+
+static int max98371_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	struct max98371_priv *max98371;
+	int ret, reg;
+
+	max98371 = devm_kzalloc(&i2c->dev,
+			sizeof(*max98371), GFP_KERNEL);
+	if (!max98371)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, max98371);
+	max98371->regmap = devm_regmap_init_i2c(i2c, &max98371_regmap);
+	if (IS_ERR(max98371->regmap)) {
+		ret = PTR_ERR(max98371->regmap);
+		dev_err(&i2c->dev,
+				"Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(max98371->regmap, MAX98371_VERSION, &reg);
+	if (ret < 0) {
+		dev_info(&i2c->dev, "device error %d\n", ret);
+		return ret;
+	}
+	dev_info(&i2c->dev, "device version %x\n", reg);
+
+	ret = snd_soc_register_codec(&i2c->dev, &max98371_codec,
+			max98371_dai, ARRAY_SIZE(max98371_dai));
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int max98371_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id max98371_i2c_id[] = {
+	{ "max98371", 0 },
+};
+
+MODULE_DEVICE_TABLE(i2c, max98371_i2c_id);
+
+static const struct of_device_id max98371_of_match[] = {
+	{ .compatible = "maxim,max98371", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max98371_of_match);
+
+static struct i2c_driver max98371_i2c_driver = {
+	.driver = {
+		.name = "max98371",
+		.owner = THIS_MODULE,
+		.pm = NULL,
+		.of_match_table = of_match_ptr(max98371_of_match),
+	},
+	.probe  = max98371_i2c_probe,
+	.remove = max98371_i2c_remove,
+	.id_table = max98371_i2c_id,
+};
+
+module_i2c_driver(max98371_i2c_driver);
+
+MODULE_AUTHOR("anish kumar <yesanishhere@gmail.com>");
+MODULE_DESCRIPTION("ALSA SoC MAX98371 driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/max98371.h b/sound/soc/codecs/max98371.h
new file mode 100644
index 000000000000..9f6330964d98
--- /dev/null
+++ b/sound/soc/codecs/max98371.h
@@ -0,0 +1,67 @@
+/*
+ * max98371.h -- MAX98371 ALSA SoC Audio driver
+ *
+ * Copyright 2011-2012 Maxim Integrated Products
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _MAX98371_H
+#define _MAX98371_H
+
+#define MAX98371_IRQ_CLEAR1			0x01
+#define MAX98371_IRQ_CLEAR2			0x02
+#define MAX98371_IRQ_CLEAR3			0x03
+#define MAX98371_DAI_CLK			0x10
+#define MAX98371_DAI_BSEL_MASK			0xF
+#define MAX98371_DAI_BSEL_32			2
+#define MAX98371_DAI_BSEL_48			3
+#define MAX98371_DAI_BSEL_64			4
+#define MAX98371_SPK_SR				0x11
+#define MAX98371_SPK_SR_MASK			0xF
+#define MAX98371_SPK_SR_32			6
+#define MAX98371_SPK_SR_44			7
+#define MAX98371_SPK_SR_48			8
+#define MAX98371_SPK_SR_88			10
+#define MAX98371_SPK_SR_96			11
+#define MAX98371_DAI_CHANNEL			0x15
+#define MAX98371_CHANNEL_MASK			0x3
+#define MAX98371_MONOMIX_SRC			0x18
+#define MAX98371_MONOMIX_CFG			0x19
+#define MAX98371_HPF				0x1C
+#define MAX98371_MONOMIX_SRC_MASK		0xFF
+#define MONOMIX_RX_0_1				((0x1)<<(4))
+#define M98371_DAI_CHANNEL_I2S			0x3
+#define MAX98371_DIGITAL_GAIN			0x2D
+#define MAX98371_DIGITAL_GAIN_WIDTH		0x7
+#define MAX98371_GAIN				0x2E
+#define MAX98371_GAIN_SHIFT			0x4
+#define MAX98371_GAIN_WIDTH			0x4
+#define MAX98371_DHT_MAX_WIDTH			4
+#define MAX98371_FMT				0x14
+#define MAX98371_CHANSZ_WIDTH			6
+#define MAX98371_FMT_MASK		        ((0x3)<<(MAX98371_CHANSZ_WIDTH))
+#define MAX98371_FMT_MODE_MASK		        ((0x7)<<(3))
+#define MAX98371_DAI_LEFT		        ((0x1)<<(3))
+#define MAX98371_DAI_RIGHT		        ((0x2)<<(3))
+#define MAX98371_DAI_CHANSZ_16                  ((1)<<(MAX98371_CHANSZ_WIDTH))
+#define MAX98371_DAI_CHANSZ_24                  ((2)<<(MAX98371_CHANSZ_WIDTH))
+#define MAX98371_DAI_CHANSZ_32                  ((3)<<(MAX98371_CHANSZ_WIDTH))
+#define MAX98371_DHT  0x32
+#define MAX98371_DHT_STEP			0x3
+#define MAX98371_DHT_GAIN			0x31
+#define MAX98371_DHT_GAIN_WIDTH			0x4
+#define MAX98371_DHT_ROT_WIDTH			0x4
+#define MAX98371_SPK_ENABLE			0x4A
+#define MAX98371_GLOBAL_ENABLE			0x50
+#define MAX98371_SOFT_RESET			0x51
+#define MAX98371_VERSION			0xFF
+
+
+struct max98371_priv {
+	struct regmap *regmap;
+	struct snd_soc_codec *codec;
+};
+#endif
-- 
2.8.0.rc3
