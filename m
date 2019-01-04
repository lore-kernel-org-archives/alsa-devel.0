From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4341: Add driver for CS4341 DAC" to
	the asoc tree
Date: Fri,  4 Jan 2019 17:10:10 +0000 (GMT)
Message-ID: <20190104171010.43E1B11270A3@debutante.sirena.org.uk>
References: <20181220073612.11961-1-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AC85C267D70
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:10:16 +0100 (CET)
In-Reply-To: <20181220073612.11961-1-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4341: Add driver for CS4341 DAC

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0f68c396f6048cf87c662aab1ef9c9aa237153a8 Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work@mail.ru>
Date: Thu, 20 Dec 2018 10:36:12 +0300
Subject: [PATCH] ASoC: cs4341: Add driver for CS4341 DAC

This patch adds Cirrus Logic CS4341.
This is a very simple, playback only, stereo DAC.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |   7 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/cs4341.c | 346 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 355 insertions(+)
 create mode 100644 sound/soc/codecs/cs4341.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 62bdb7e333b8..3f742753abd1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -65,6 +65,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS4271_SPI if SPI_MASTER
 	select SND_SOC_CS42XX8_I2C if I2C
 	select SND_SOC_CS43130 if I2C
+	select SND_SOC_CS4341 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_CS4349 if I2C
 	select SND_SOC_CS47L24 if MFD_CS47L24
 	select SND_SOC_CS53L30 if I2C
@@ -542,6 +543,12 @@ config SND_SOC_CS43130
         tristate "Cirrus Logic CS43130 CODEC"
         depends on I2C
 
+config SND_SOC_CS4341
+	tristate "Cirrus Logic CS4341 CODEC"
+	depends on I2C || SPI_MASTER
+	select REGMAP_I2C if I2C
+	select REGMAP_SPI if SPI_MASTER
+
 # Cirrus Logic CS4349 HiFi DAC
 config SND_SOC_CS4349
 	tristate "Cirrus Logic CS4349 CODEC"
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 66f55d185620..fbe36e6177b0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -60,6 +60,7 @@ snd-soc-cs4271-spi-objs := cs4271-spi.o
 snd-soc-cs42xx8-objs := cs42xx8.o
 snd-soc-cs42xx8-i2c-objs := cs42xx8-i2c.o
 snd-soc-cs43130-objs := cs43130.o
+snd-soc-cs4341-objs := cs4341.o
 snd-soc-cs4349-objs := cs4349.o
 snd-soc-cs47l24-objs := cs47l24.o
 snd-soc-cs53l30-objs := cs53l30.o
@@ -326,6 +327,7 @@ obj-$(CONFIG_SND_SOC_CS4271_SPI)	+= snd-soc-cs4271-spi.o
 obj-$(CONFIG_SND_SOC_CS42XX8)	+= snd-soc-cs42xx8.o
 obj-$(CONFIG_SND_SOC_CS42XX8_I2C) += snd-soc-cs42xx8-i2c.o
 obj-$(CONFIG_SND_SOC_CS43130)   += snd-soc-cs43130.o
+obj-$(CONFIG_SND_SOC_CS4341)	+= snd-soc-cs4341.o
 obj-$(CONFIG_SND_SOC_CS4349)	+= snd-soc-cs4349.o
 obj-$(CONFIG_SND_SOC_CS47L24)	+= snd-soc-cs47l24.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
diff --git a/sound/soc/codecs/cs4341.c b/sound/soc/codecs/cs4341.c
new file mode 100644
index 000000000000..d2e616a89fd4
--- /dev/null
+++ b/sound/soc/codecs/cs4341.c
@@ -0,0 +1,346 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Cirrus Logic CS4341A ALSA SoC Codec Driver
+ *  Author: Alexander Shiyan <shc_work@mail.ru>
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define CS4341_REG_MODE1	0x00
+#define CS4341_REG_MODE2	0x01
+#define CS4341_REG_MIX		0x02
+#define CS4341_REG_VOLA		0x03
+#define CS4341_REG_VOLB		0x04
+
+#define CS4341_MODE2_DIF	(7 << 4)
+#define CS4341_MODE2_DIF_I2S_24	(0 << 4)
+#define CS4341_MODE2_DIF_I2S_16	(1 << 4)
+#define CS4341_MODE2_DIF_LJ_24	(2 << 4)
+#define CS4341_MODE2_DIF_RJ_24	(3 << 4)
+#define CS4341_MODE2_DIF_RJ_16	(5 << 4)
+#define CS4341_VOLX_MUTE	(1 << 7)
+
+struct cs4341_priv {
+	unsigned int		fmt;
+	struct regmap		*regmap;
+	struct regmap_config	regcfg;
+};
+
+static const struct reg_default cs4341_reg_defaults[] = {
+	{ CS4341_REG_MODE1,	0x00 },
+	{ CS4341_REG_MODE2,	0x82 },
+	{ CS4341_REG_MIX,	0x49 },
+	{ CS4341_REG_VOLA,	0x80 },
+	{ CS4341_REG_VOLB,	0x80 },
+};
+
+static int cs4341_set_fmt(struct snd_soc_dai *dai, unsigned int format)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs4341_priv *cs4341 = snd_soc_component_get_drvdata(component);
+
+	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (format & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		cs4341->fmt = format & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cs4341_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs4341_priv *cs4341 = snd_soc_component_get_drvdata(component);
+	unsigned int mode = 0;
+	int b24 = 0;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S24_LE:
+		b24 = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	default:
+		dev_err(component->dev, "Unsupported PCM format 0x%08x.\n",
+			params_format(params));
+		return -EINVAL;
+	}
+
+	switch (cs4341->fmt) {
+	case SND_SOC_DAIFMT_I2S:
+		mode = b24 ? CS4341_MODE2_DIF_I2S_24 : CS4341_MODE2_DIF_I2S_16;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		mode = CS4341_MODE2_DIF_LJ_24;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		mode = b24 ? CS4341_MODE2_DIF_RJ_24 : CS4341_MODE2_DIF_RJ_16;
+		break;
+	default:
+		dev_err(component->dev, "Unsupported DAI format 0x%08x.\n",
+			cs4341->fmt);
+		return -EINVAL;
+	}
+
+	return snd_soc_component_update_bits(component, CS4341_REG_MODE2,
+					     CS4341_MODE2_DIF, mode);
+}
+
+static int cs4341_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_component *component = dai->component;
+	int ret;
+
+	ret = snd_soc_component_update_bits(component, CS4341_REG_VOLA,
+					    CS4341_VOLX_MUTE,
+					    mute ? CS4341_VOLX_MUTE : 0);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_component_update_bits(component, CS4341_REG_VOLB,
+					     CS4341_VOLX_MUTE,
+					     mute ? CS4341_VOLX_MUTE : 0);
+}
+
+static DECLARE_TLV_DB_SCALE(out_tlv, -9000, 100, 0);
+
+static const char * const deemph[] = {
+	"None", "44.1k", "48k", "32k",
+};
+
+static const struct soc_enum deemph_enum =
+	SOC_ENUM_SINGLE(CS4341_REG_MODE2, 2, 4, deemph);
+
+static const char * const srzc[] = {
+	"Immediate", "Zero Cross", "Soft Ramp", "SR on ZC",
+};
+
+static const struct soc_enum srzc_enum =
+	SOC_ENUM_SINGLE(CS4341_REG_MIX, 5, 4, srzc);
+
+
+static const struct snd_soc_dapm_widget cs4341_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("HiFi DAC", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("OutA"),
+	SND_SOC_DAPM_OUTPUT("OutB"),
+};
+
+static const struct snd_soc_dapm_route cs4341_routes[] = {
+	{ "OutA", NULL, "HiFi DAC" },
+	{ "OutB", NULL, "HiFi DAC" },
+	{ "DAC Playback", NULL, "OutA" },
+	{ "DAC Playback", NULL, "OutB" },
+};
+
+static const struct snd_kcontrol_new cs4341_controls[] = {
+	SOC_DOUBLE_R_TLV("Master Playback Volume",
+			 CS4341_REG_VOLA, CS4341_REG_VOLB, 0, 90, 1, out_tlv),
+	SOC_ENUM("De-Emphasis Control", deemph_enum),
+	SOC_ENUM("Soft Ramp Zero Cross Control", srzc_enum),
+	SOC_SINGLE("Auto-Mute Switch", CS4341_REG_MODE2, 7, 1, 0),
+	SOC_SINGLE("Popguard Transient Switch", CS4341_REG_MODE2, 1, 1, 0),
+};
+
+static const struct snd_soc_dai_ops cs4341_dai_ops = {
+	.set_fmt	= cs4341_set_fmt,
+	.hw_params	= cs4341_hw_params,
+	.digital_mute	= cs4341_digital_mute,
+};
+
+static struct snd_soc_dai_driver cs4341_dai = {
+	.name			= "cs4341a-hifi",
+	.playback		= {
+		.stream_name	= "DAC Playback",
+		.channels_min	= 1,
+		.channels_max	= 2,
+		.rates		= SNDRV_PCM_RATE_8000_96000,
+		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
+				  SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops			= &cs4341_dai_ops,
+	.symmetric_rates	= 1,
+};
+
+static const struct snd_soc_component_driver soc_component_cs4341 = {
+	.controls		= cs4341_controls,
+	.num_controls		= ARRAY_SIZE(cs4341_controls),
+	.dapm_widgets		= cs4341_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs4341_dapm_widgets),
+	.dapm_routes		= cs4341_routes,
+	.num_dapm_routes	= ARRAY_SIZE(cs4341_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+static const struct of_device_id __maybe_unused cs4341_dt_ids[] = {
+	{ .compatible = "cirrus,cs4341a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs4341_dt_ids);
+
+static int cs4341_probe(struct device *dev)
+{
+	struct cs4341_priv *cs4341 = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs4341_reg_defaults); i++)
+		regmap_write(cs4341->regmap, cs4341_reg_defaults[i].reg,
+			     cs4341_reg_defaults[i].def);
+
+	return devm_snd_soc_register_component(dev, &soc_component_cs4341,
+					       &cs4341_dai, 1);
+}
+
+#if defined(CONFIG_I2C)
+static int cs4341_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct cs4341_priv *cs4341;
+
+	cs4341 = devm_kzalloc(&i2c->dev, sizeof(*cs4341), GFP_KERNEL);
+	if (!cs4341)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, cs4341);
+
+	cs4341->regcfg.reg_bits		= 8;
+	cs4341->regcfg.val_bits		= 8;
+	cs4341->regcfg.max_register	= CS4341_REG_VOLB;
+	cs4341->regcfg.cache_type	= REGCACHE_FLAT;
+	cs4341->regcfg.reg_defaults	= cs4341_reg_defaults;
+	cs4341->regcfg.num_reg_defaults	= ARRAY_SIZE(cs4341_reg_defaults);
+	cs4341->regmap = devm_regmap_init_i2c(i2c, &cs4341->regcfg);
+	if (IS_ERR(cs4341->regmap))
+		return PTR_ERR(cs4341->regmap);
+
+	return cs4341_probe(&i2c->dev);
+}
+
+static const struct i2c_device_id cs4341_i2c_id[] = {
+	{ "cs4341", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cs4341_i2c_id);
+
+static struct i2c_driver cs4341_i2c_driver = {
+	.driver = {
+		.name = "cs4341-i2c",
+		.of_match_table = of_match_ptr(cs4341_dt_ids),
+	},
+	.probe = cs4341_i2c_probe,
+	.id_table = cs4341_i2c_id,
+};
+#endif
+
+#if defined(CONFIG_SPI_MASTER)
+static bool cs4341_reg_readable(struct device *dev, unsigned int reg)
+{
+	return false;
+}
+
+static int cs4341_spi_probe(struct spi_device *spi)
+{
+	struct cs4341_priv *cs4341;
+	int ret;
+
+	cs4341 = devm_kzalloc(&spi->dev, sizeof(*cs4341), GFP_KERNEL);
+	if (!cs4341)
+		return -ENOMEM;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz = 6000000;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
+
+	spi_set_drvdata(spi, cs4341);
+
+	cs4341->regcfg.reg_bits		= 16;
+	cs4341->regcfg.val_bits		= 8;
+	cs4341->regcfg.write_flag_mask	= 0x20;
+	cs4341->regcfg.max_register	= CS4341_REG_VOLB;
+	cs4341->regcfg.cache_type	= REGCACHE_FLAT;
+	cs4341->regcfg.readable_reg	= cs4341_reg_readable;
+	cs4341->regcfg.reg_defaults	= cs4341_reg_defaults;
+	cs4341->regcfg.num_reg_defaults	= ARRAY_SIZE(cs4341_reg_defaults);
+	cs4341->regmap = devm_regmap_init_spi(spi, &cs4341->regcfg);
+	if (IS_ERR(cs4341->regmap))
+		return PTR_ERR(cs4341->regmap);
+
+	return cs4341_probe(&spi->dev);
+}
+
+static struct spi_driver cs4341_spi_driver = {
+	.driver = {
+		.name = "cs4341-spi",
+		.of_match_table = of_match_ptr(cs4341_dt_ids),
+	},
+	.probe = cs4341_spi_probe,
+};
+#endif
+
+static int __init cs4341_init(void)
+{
+	int ret = 0;
+
+#if defined(CONFIG_I2C)
+	ret = i2c_add_driver(&cs4341_i2c_driver);
+	if (ret)
+		return ret;
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&cs4341_spi_driver);
+#endif
+
+	return ret;
+}
+module_init(cs4341_init);
+
+static void __exit cs4341_exit(void)
+{
+#if defined(CONFIG_I2C)
+	i2c_del_driver(&cs4341_i2c_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&cs4341_spi_driver);
+#endif
+}
+module_exit(cs4341_exit);
+
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("Cirrus Logic CS4341 ALSA SoC Codec Driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1
