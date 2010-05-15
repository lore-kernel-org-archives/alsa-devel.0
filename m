From: apatard@mandriva.com
Subject: [patch 4/6] cs42l51: add asoc driver
Date: Sat, 15 May 2010 17:30:02 +0200
Message-ID: <20100515153130.666637769@mandriva.com>
References: <20100515152958.899927802@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id 13733243A4
	for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 17:31:16 +0200 (CEST)
Content-Disposition: inline; filename=cs42l51_support.patch
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
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch is adding a ASoC driver for the cs42l51 from Cirrus Logic.
Master mode and spi mode are not supported.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Index: sound-2.6/sound/soc/codecs/cs42l51.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/codecs/cs42l51.c	2010-05-15 17:26:39.598586210 +0200
@@ -0,0 +1,756 @@
+/*
+ * cs42l51.c
+ *
+ * ASoC Driver for Cirrus Logic CS42L51 codecs
+ *
+ * Copyright (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ * Based on cs4270.c - Copyright (c) Freescale Semiconductor
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * For now:
+ *  - Only I2C is support. Not SPI
+ *  - master mode *NOT* supported
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
+#include <sound/pcm.h>
+#include <linux/i2c.h>
+
+#include "cs42l51.h"
+
+enum master_slave_mode {
+	MODE_SLAVE,
+	MODE_SLAVE_AUTO,
+	MODE_MASTER,
+};
+
+struct cs42l51_private {
+	unsigned int mclk;
+	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
+	enum master_slave_mode func;
+	struct snd_soc_codec codec;
+	u8 reg_cache[CS42L51_NUMREGS];
+};
+
+static struct snd_soc_codec *cs42l51_codec;
+
+#define CS42L51_FORMATS ( \
+		SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE  | \
+		SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S18_3BE | \
+		SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE | \
+		SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE)
+
+static int cs42l51_fill_cache(struct snd_soc_codec *codec)
+{
+	u8 *cache = codec->reg_cache + 1;
+	struct i2c_client *i2c_client = codec->control_data;
+	s32 length;
+
+	length = i2c_smbus_read_i2c_block_data(i2c_client,
+			CS42L51_FIRSTREG | 0x80, CS42L51_NUMREGS, cache);
+	if (length != CS42L51_NUMREGS) {
+		dev_err(&i2c_client->dev,
+				"I2C read failure, addr=0x%x (ret=%d vs %d)\n",
+				i2c_client->addr, length, CS42L51_NUMREGS);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
+	const struct i2c_device_id *id)
+{
+	struct snd_soc_codec *codec;
+	struct cs42l51_private *cs42l51;
+	int ret = 0;
+	int reg;
+
+	if (cs42l51_codec)
+		return -EBUSY;
+
+	/* Verify that we have a CS42L51 */
+	ret = i2c_smbus_read_byte_data(i2c_client, CHIP_REV_ID);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "failed to read I2C\n");
+		goto error;
+	}
+
+	if ((ret != MK_CHIP_REV(CHIP_ID, CHIP_REV_A)) &&
+		(ret != MK_CHIP_REV(CHIP_ID, CHIP_REV_B))) {
+		dev_err(&i2c_client->dev, "Invalid chip id\n");
+		ret = -ENODEV;
+		goto error;
+	}
+
+	dev_info(&i2c_client->dev, "found device cs42l51 rev %d\n",
+				ret & 7);
+
+	cs42l51 = kzalloc(sizeof(struct cs42l51_private), GFP_KERNEL);
+	if (!cs42l51) {
+		dev_err(&i2c_client->dev, "could not allocate codec\n");
+		return -ENOMEM;
+	}
+	codec = &cs42l51->codec;
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->dev = &i2c_client->dev;
+	codec->name = "CS42L51";
+	codec->owner = THIS_MODULE;
+	codec->dai = &cs42l51_dai;
+	codec->num_dai = 1;
+	snd_soc_codec_set_drvdata(codec, cs42l51);
+
+	codec->control_data = i2c_client;
+	codec->reg_cache = cs42l51->reg_cache;
+	codec->reg_cache_size = CS42L51_NUMREGS;
+	i2c_set_clientdata(i2c_client, codec);
+
+	ret = cs42l51_fill_cache(codec);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "failed to fill register cache\n");
+		goto error_alloc;
+	}
+
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "Failed to set cache I/O: %d\n", ret);
+		goto error_alloc;
+	}
+
+	/*
+	 * DAC configuration
+	 * - Use signal processor
+	 * - auto mute
+	 * - vol changes immediate
+	 * - no de-emphasize
+	 */
+	reg = DAC_CTL_DATA_SEL(1) | DAC_CTL_AMUTE | DAC_CTL_DACSZ(0);
+	ret = snd_soc_write(codec, DAC_CTL, reg);
+	if (ret < 0)
+		goto error_alloc;
+
+	/* route microphone */
+	ret = snd_soc_write(codec, ADC_INPUT, 0xF0);
+	if (ret < 0)
+		goto error_alloc;
+
+	cs42l51_dai.dev = codec->dev;
+	cs42l51_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto error_alloc;
+	}
+
+	ret = snd_soc_register_dai(&cs42l51_dai);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "failed to register DAIe\n");
+		goto error_reg;
+	}
+
+	return 0;
+
+error_reg:
+	snd_soc_unregister_codec(codec);
+error_alloc:
+	kfree(cs42l51);
+error:
+	return ret;
+}
+
+static int cs42l51_i2c_remove(struct i2c_client *client)
+{
+	struct cs42l51_private *cs42l51 = i2c_get_clientdata(client);
+	snd_soc_unregister_dai(&cs42l51_dai);
+	snd_soc_unregister_codec(cs42l51_codec);
+	cs42l51_codec = NULL;
+	kfree(cs42l51);
+	return 0;
+}
+
+
+static const struct i2c_device_id cs42l51_id[] = {
+	{"cs42l51", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs42l51_id);
+
+static struct i2c_driver cs42l51_i2c_driver = {
+	.driver = {
+		.name = "CS42L51 I2C",
+		.owner = THIS_MODULE,
+	},
+	.id_table = cs42l51_id,
+	.probe = cs42l51_i2c_probe,
+	.remove = cs42l51_i2c_remove,
+};
+
+static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned long value = snd_soc_read(codec, PCM_MIXER)&3;
+
+	switch (value) {
+	default:
+	case 0:
+		ucontrol->value.integer.value[0] = 0;
+		break;
+	/* same value : (L+R)/2 and (R+L)/2 */
+	case 1:
+	case 2:
+		ucontrol->value.integer.value[0] = 1;
+		break;
+	case 3:
+		ucontrol->value.integer.value[0] = 2;
+		break;
+	}
+
+	return 0;
+}
+
+#define CHAN_MIX_NORMAL	0x00
+#define CHAN_MIX_BOTH	0x55
+#define CHAN_MIX_SWAP	0xFF
+
+static int cs42l51_set_chan_mix(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned char val;
+
+	switch (ucontrol->value.integer.value[0]) {
+	default:
+	case 0:
+		val = CHAN_MIX_NORMAL;
+		break;
+	case 1:
+		val = CHAN_MIX_BOTH;
+		break;
+	case 2:
+		val = CHAN_MIX_SWAP;
+		break;
+	}
+
+	snd_soc_write(codec, PCM_MIXER, val);
+
+	return 1;
+}
+
+static const DECLARE_TLV_DB_SCALE(adc_pcm_tlv, -5150, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tone_tlv, -1050, 150, 0);
+/* This is a lie. after -102 db, it stays at -102 */
+/* maybe a range would be better */
+static const DECLARE_TLV_DB_SCALE(aout_tlv, -11550, 50, 0);
+
+static const char *mic_boost[] = { "+16dB", "+32dB"};
+static const char *chan_mix[] = {
+	"L R",
+	"L+R",
+	"R L",
+};
+
+static const struct soc_enum cs42l51_chan_mix =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(chan_mix), chan_mix);
+static const struct soc_enum cs42l51_mic_boost =
+	SOC_ENUM_DOUBLE(MIC_CTL, 0, 1, 2, mic_boost);
+
+static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
+	SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
+			PCMA_VOL, PCMB_VOL, 7, 0xffffff99, 0x18, adc_pcm_tlv),
+	SOC_DOUBLE_R("PCM Playback Switch", PCMA_VOL, PCMB_VOL, 7, 1, 1),
+	SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
+			AOUTA_VOL, AOUTB_VOL, 8, 0xffffff19, 0x18, aout_tlv),
+	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
+			ADCA_VOL, ADCB_VOL, 7, 0xffffff99, 0x18, adc_pcm_tlv),
+	SOC_DOUBLE_R("ADC Mixer Switch", ADCA_VOL, ADCB_VOL, 7, 1, 1),
+	SOC_SINGLE("Playback Deemphasis Switch", DAC_CTL, 3, 1, 0),
+	SOC_SINGLE("Auto-Mute Switch", DAC_CTL, 2, 1, 0),
+	SOC_SINGLE("Soft Ramp Switch", DAC_CTL, 1, 1, 0),
+	SOC_SINGLE("Zero Cross Switch", DAC_CTL, 0, 0, 0),
+	SOC_ENUM("Mic Boost", cs42l51_mic_boost),
+	SOC_SINGLE_TLV("Bass Volume", TONE_CTL, 0, 0xf, 1, tone_tlv),
+	SOC_SINGLE_TLV("Treble Volume", TONE_CTL, 4, 0xf, 1, tone_tlv),
+	SOC_ENUM_EXT("PCM channel mixer",
+			cs42l51_chan_mix,
+			cs42l51_get_chan_mix, cs42l51_set_chan_mix),
+};
+
+/*
+ * to power down, one must:
+ * 1.) Enable the PDN bit
+ * 2.) enable power-down for the select channels
+ * 3.) disable the PDN bit.
+ */
+static int cs42l51_pdn_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	unsigned long value;
+
+	value = snd_soc_read(w->codec, POWER_CTL1);
+	value &= ~POWER_CTL1_PDN;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMD:
+		value |= POWER_CTL1_PDN;
+		break;
+	default:
+	case SND_SOC_DAPM_POST_PMD:
+		break;
+	}
+	snd_soc_write(w->codec, POWER_CTL1, value);
+
+	return 0;
+}
+
+static const char *cs42l51_dac_names[] = {"PCM->DAC",
+	"PCM->SPE->DAC", "ADC->DAC"};
+static const struct soc_enum cs42l51_dac_mux_enum =
+	SOC_ENUM_SINGLE(DAC_CTL, 6, 3, cs42l51_dac_names);
+static const struct snd_kcontrol_new cs42l51_dac_mux_controls =
+	SOC_DAPM_ENUM("Route", cs42l51_dac_mux_enum);
+
+static const char *cs42l51_adcl_names[] = {"AIN1 Left", "AIN2 Left",
+	"MIC Left", "MIC+preamp Left"};
+static const struct soc_enum cs42l51_adcl_mux_enum =
+	SOC_ENUM_SINGLE(ADC_INPUT, 4, 4, cs42l51_adcl_names);
+static const struct snd_kcontrol_new cs42l51_adcl_mux_controls =
+	SOC_DAPM_ENUM("Route", cs42l51_adcl_mux_enum);
+
+static const char *cs42l51_adcr_names[] = {"AIN1 Right", "AIN2 Right",
+	"MIC Right", "MIC+preamp Right"};
+static const struct soc_enum cs42l51_adcr_mux_enum =
+	SOC_ENUM_SINGLE(ADC_INPUT, 6, 4, cs42l51_adcr_names);
+static const struct snd_kcontrol_new cs42l51_adcr_mux_controls =
+	SOC_DAPM_ENUM("Route", cs42l51_adcr_mux_enum);
+
+#define DAPM_EVENT_PRE_POST_PMD	(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)
+
+static const struct snd_soc_dapm_widget cs42l51_dapm_widgets[] = {
+	SND_SOC_DAPM_MICBIAS("Mic Bias", MIC_POWER_CTL, 1, 1),
+	SND_SOC_DAPM_PGA_E("Left PGA", POWER_CTL1, 3, 1, NULL, 0,
+		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
+	SND_SOC_DAPM_PGA_E("Right PGA", POWER_CTL1, 4, 1, NULL, 0,
+		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
+	SND_SOC_DAPM_ADC_E("Left ADC", "Left HiFi Capture",
+		POWER_CTL1, 1, 1,
+		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
+	SND_SOC_DAPM_ADC_E("Right ADC", "Right HiFi Capture",
+		POWER_CTL1, 2, 1,
+		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
+	SND_SOC_DAPM_DAC_E("Left DAC", "Left HiFi Playback",
+		POWER_CTL1, 5, 1,
+		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
+	SND_SOC_DAPM_DAC_E("Right DAC", "Right HiFi Playback",
+		POWER_CTL1, 6, 1,
+		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
+
+	/* analog/mic */
+	SND_SOC_DAPM_INPUT("AIN1L"),
+	SND_SOC_DAPM_INPUT("AIN1R"),
+	SND_SOC_DAPM_INPUT("AIN2L"),
+	SND_SOC_DAPM_INPUT("AIN2R"),
+	SND_SOC_DAPM_INPUT("MICL"),
+	SND_SOC_DAPM_INPUT("MICR"),
+
+	SND_SOC_DAPM_MIXER("Mic Preamp Left", MIC_POWER_CTL, 2, 1, NULL, 0),
+	SND_SOC_DAPM_MIXER("Mic Preamp Right", MIC_POWER_CTL, 3, 1, NULL, 0),
+
+	/* HP */
+	SND_SOC_DAPM_OUTPUT("HPL"),
+	SND_SOC_DAPM_OUTPUT("HPR"),
+
+	/* mux */
+	SND_SOC_DAPM_MUX("DAC Mux", SND_SOC_NOPM, 0, 0,
+		&cs42l51_dac_mux_controls),
+	SND_SOC_DAPM_MUX("PGA-ADC Mux Left", SND_SOC_NOPM, 0, 0,
+		&cs42l51_adcl_mux_controls),
+	SND_SOC_DAPM_MUX("PGA-ADC Mux Right", SND_SOC_NOPM, 0, 0,
+		&cs42l51_adcr_mux_controls),
+};
+
+static const struct snd_soc_dapm_route cs42l51_routes[] = {
+	{"HPL", NULL, "Left DAC"},
+	{"HPR", NULL, "Right DAC"},
+
+	{"Left ADC", NULL, "Left PGA"},
+	{"Right ADC", NULL, "Right PGA"},
+
+	{"Mic Preamp Left",  NULL,  "MICL"},
+	{"Mic Preamp Right", NULL,  "MICR"},
+
+	{"PGA-ADC Mux Left",  "AIN1 Left",        "AIN1L" },
+	{"PGA-ADC Mux Left",  "AIN2 Left",        "AIN2L" },
+	{"PGA-ADC Mux Left",  "MIC Left",         "MICL"  },
+	{"PGA-ADC Mux Left",  "MIC+preamp Left",  "Mic Preamp Left" },
+	{"PGA-ADC Mux Right", "AIN1 Right",       "AIN1R" },
+	{"PGA-ADC Mux Right", "AIN2 Right",       "AIN2R" },
+	{"PGA-ADC Mux Right", "MIC Right",        "MICR" },
+	{"PGA-ADC Mux Right", "MIC+preamp Right", "Mic Preamp Right" },
+
+	{"Left PGA", NULL, "PGA-ADC Mux Left"},
+	{"Right PGA", NULL, "PGA-ADC Mux Right"},
+};
+
+static int cs42l51_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		cs42l51->audio_mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		printk(KERN_ERR "cs42l51: invalid DAI format\n");
+		ret = -EINVAL;
+	}
+
+	switch (SND_SOC_DAIFMT_MASTER_MASK) {
+	default:
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cs42l51->func = MODE_SLAVE_AUTO;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		cs42l51->func = MODE_MASTER;
+		break;
+	}
+
+	return ret;
+}
+
+struct cs42l51_ratios {
+	unsigned int ratio;
+	unsigned char speed_mode;
+	unsigned char mclk;
+};
+
+static struct cs42l51_ratios slave_ratios[] = {
+	{  512, QSM_MODE, 0 }, {  768, QSM_MODE, 0 }, { 1024, QSM_MODE, 0 },
+	{ 1536, QSM_MODE, 0 }, { 2048, QSM_MODE, 0 }, { 3072, QSM_MODE, 0 },
+	{  256, HSM_MODE, 0 }, {  384, HSM_MODE, 0 }, {  512, HSM_MODE, 0 },
+	{  768, HSM_MODE, 0 }, { 1024, HSM_MODE, 0 }, { 1536, HSM_MODE, 0 },
+	{  128, SSM_MODE, 0 }, {  192, SSM_MODE, 0 }, {  256, SSM_MODE, 0 },
+	{  384, SSM_MODE, 0 }, {  512, SSM_MODE, 0 }, {  768, SSM_MODE, 0 },
+	{  128, DSM_MODE, 0 }, {  192, DSM_MODE, 0 }, {  256, DSM_MODE, 0 },
+	{  384, DSM_MODE, 0 },
+};
+
+static struct cs42l51_ratios slave_auto_ratios[] = {
+	{ 1024, QSM_MODE, 0 }, { 1536, QSM_MODE, 0 }, { 2048, QSM_MODE, 1 },
+	{ 3072, QSM_MODE, 1 },
+	{  512, HSM_MODE, 0 }, {  768, HSM_MODE, 0 }, { 1024, HSM_MODE, 1 },
+	{ 1536, HSM_MODE, 1 },
+	{  256, SSM_MODE, 0 }, {  384, SSM_MODE, 0 }, {  512, SSM_MODE, 1 },
+	{  768, SSM_MODE, 1 },
+	{  128, DSM_MODE, 0 }, {  192, DSM_MODE, 0 }, {  256, DSM_MODE, 1 },
+	{  384, DSM_MODE, 1 },
+};
+
+static int cs42l51_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l51_ratios *ratios = NULL;
+	int nr_ratios = 0;
+	unsigned int rates = 0;
+	unsigned int rate_min = -1;
+	unsigned int rate_max = 0;
+	int i;
+
+	cs42l51->mclk = freq;
+
+	switch (cs42l51->func) {
+	case MODE_MASTER:
+		return -EINVAL;
+	case MODE_SLAVE:
+		ratios = slave_ratios;
+		nr_ratios = ARRAY_SIZE(slave_ratios);
+		break;
+	case MODE_SLAVE_AUTO:
+		ratios = slave_auto_ratios;
+		nr_ratios = ARRAY_SIZE(slave_auto_ratios);
+		break;
+	}
+
+	for (i = 0; i < nr_ratios; i++) {
+		unsigned int rate = freq / ratios[i].ratio;
+		rates |= snd_pcm_rate_to_rate_bit(rate);
+		if (rate < rate_min)
+			rate_min = rate;
+		if (rate > rate_max)
+			rate_max = rate;
+	}
+	rates &= ~SNDRV_PCM_RATE_KNOT;
+
+	if (!rates) {
+		printk(KERN_ERR "cs42l51: could not find a valid sample rate\n");
+		return -EINVAL;
+	}
+
+	codec_dai->playback.rates = rates;
+	codec_dai->playback.rate_min = rate_min;
+	codec_dai->playback.rate_max = rate_max;
+
+	codec_dai->capture.rates = rates;
+	codec_dai->capture.rate_min = rate_min;
+	codec_dai->capture.rate_max = rate_max;
+
+	return 0;
+}
+
+static int cs42l51_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+	unsigned int i;
+	unsigned int rate;
+	unsigned int ratio;
+	struct cs42l51_ratios *ratios = NULL;
+	int nr_ratios = 0;
+	int intf_ctl, power_ctl;
+
+	switch (cs42l51->func) {
+	case MODE_MASTER:
+		return -EINVAL;
+	case MODE_SLAVE:
+		ratios = slave_ratios;
+		nr_ratios = ARRAY_SIZE(slave_ratios);
+		break;
+	case MODE_SLAVE_AUTO:
+		ratios = slave_auto_ratios;
+		nr_ratios = ARRAY_SIZE(slave_auto_ratios);
+		break;
+	}
+
+	/* Figure out which MCLK/LRCK ratio to use */
+	rate = params_rate(params);     /* Sampling rate, in Hz */
+	ratio = cs42l51->mclk / rate;    /* MCLK/LRCK ratio */
+	for (i = 0; i < nr_ratios; i++) {
+		if (ratios[i].ratio == ratio)
+			break;
+	}
+
+	if (i == nr_ratios) {
+		/* We did not find a matching ratio */
+		printk(KERN_ERR "cs42l51: could not find matching ratio\n");
+		return -EINVAL;
+	}
+
+	intf_ctl = snd_soc_read(codec, INTF_CTL);
+	power_ctl = snd_soc_read(codec, MIC_POWER_CTL);
+
+	intf_ctl &= ~(INTF_CTL_MASTER|INTF_CTL_ADC_I2S|INTF_CTL_DAC_FORMAT(7));
+	power_ctl &= ~(MIC_POWER_CTL_SPEED(3)|MIC_POWER_CTL_MCLK_DIV2);
+
+	switch (cs42l51->func) {
+	case MODE_MASTER:
+		intf_ctl |= INTF_CTL_MASTER;
+		power_ctl |= MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
+		break;
+	case MODE_SLAVE:
+		power_ctl |= MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
+		break;
+	case MODE_SLAVE_AUTO:
+		power_ctl |= MIC_POWER_CTL_AUTO;
+		break;
+	}
+
+	switch (cs42l51->audio_mode) {
+	case SND_SOC_DAIFMT_I2S:
+		intf_ctl |= INTF_CTL_ADC_I2S | INTF_CTL_DAC_FORMAT(DAC_DIF_I2S);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		intf_ctl |= INTF_CTL_DAC_FORMAT(DAC_DIF_LJ24);
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (params_format(params)) {
+		case SNDRV_PCM_FORMAT_S16_LE:
+		case SNDRV_PCM_FORMAT_S16_BE:
+			intf_ctl |= INTF_CTL_DAC_FORMAT(DAC_DIF_RJ16);
+			break;
+		case SNDRV_PCM_FORMAT_S18_3LE:
+		case SNDRV_PCM_FORMAT_S18_3BE:
+			intf_ctl |= INTF_CTL_DAC_FORMAT(DAC_DIF_RJ18);
+			break;
+		case SNDRV_PCM_FORMAT_S20_3LE:
+		case SNDRV_PCM_FORMAT_S20_3BE:
+			intf_ctl |= INTF_CTL_DAC_FORMAT(DAC_DIF_RJ20);
+			break;
+		case SNDRV_PCM_FORMAT_S24_LE:
+		case SNDRV_PCM_FORMAT_S24_BE:
+			intf_ctl |= INTF_CTL_DAC_FORMAT(DAC_DIF_RJ24);
+			break;
+		default:
+			printk(KERN_ERR "cs42l51: unknown format\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		printk(KERN_ERR "cs42l51: unknown format\n");
+		return -EINVAL;
+	}
+
+	if (ratios[i].mclk)
+		power_ctl |= MIC_POWER_CTL_MCLK_DIV2;
+
+	ret = snd_soc_write(codec, INTF_CTL, intf_ctl);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_write(codec, MIC_POWER_CTL, power_ctl);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cs42l51_dai_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int reg;
+	int mask = DAC_OUT_CTL_DACA_MUTE | DAC_OUT_CTL_DACB_MUTE;
+
+	reg = snd_soc_read(codec, DAC_OUT_CTL);
+
+	if (mute)
+		reg |= mask;
+	else
+		reg &= ~mask;
+
+	return snd_soc_write(codec, DAC_OUT_CTL, reg);
+}
+
+static struct snd_soc_dai_ops cs42l51_dai_ops = {
+	.hw_params      = cs42l51_hw_params,
+	.set_sysclk     = cs42l51_set_dai_sysclk,
+	.set_fmt        = cs42l51_set_dai_fmt,
+	.digital_mute   = cs42l51_dai_mute,
+};
+
+struct snd_soc_dai cs42l51_dai = {
+	.name = "CS42L51 HiFi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = CS42L51_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = CS42L51_FORMATS,
+	},
+	.ops = &cs42l51_dai_ops,
+};
+EXPORT_SYMBOL_GPL(cs42l51_dai);
+
+
+static int cs42l51_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	if (!cs42l51_codec) {
+		dev_err(&pdev->dev, "CS42L51 codec not yet registered\n");
+		return -EINVAL;
+	}
+
+	dev_info(&pdev->dev, "CS42L51 ALSA SoC Codec\n");
+
+	socdev->card->codec = cs42l51_codec;
+	codec = socdev->card->codec;
+
+	/* Register PCMs */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to create PCMs\n");
+		return ret;
+	}
+
+	snd_soc_add_controls(codec, cs42l51_snd_controls,
+		ARRAY_SIZE(cs42l51_snd_controls));
+	snd_soc_dapm_new_controls(codec, cs42l51_dapm_widgets,
+		ARRAY_SIZE(cs42l51_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, cs42l51_routes,
+		ARRAY_SIZE(cs42l51_routes));
+
+	return 0;
+}
+
+
+static int cs42l51_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_device_cs42l51 = {
+	.probe =	cs42l51_probe,
+	.remove =	cs42l51_remove
+};
+EXPORT_SYMBOL_GPL(soc_codec_device_cs42l51);
+
+static int __init cs42l51_init(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&cs42l51_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "can't add i2c driver\n");
+		return ret;
+	}
+	return 0;
+}
+module_init(cs42l51_init);
+
+static void __exit cs42l51_exit(void)
+{
+	i2c_del_driver(&cs42l51_i2c_driver);
+}
+module_exit(cs42l51_exit);
+
+MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
+MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
+MODULE_LICENSE("GPL");
+
Index: sound-2.6/sound/soc/codecs/cs42l51.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/codecs/cs42l51.h	2010-05-15 17:13:44.342087567 +0200
@@ -0,0 +1,168 @@
+/*
+ * cs42l51.h
+ *
+ * ASoC Driver for Cirrus Logic CS42L51 codecs
+ *
+ * Copyright (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef _CS42L51_H
+#define CS42L51_H
+
+#define CHIP_ID			0x1B
+#define CHIP_REV_A		0x00
+#define CHIP_REV_B		0x01
+
+#define CHIP_REV_ID		0x01
+#define MK_CHIP_REV(a, b)	((a)<<3|(b))
+
+#define POWER_CTL1		0x02
+#define POWER_CTL1_PDN_DACB	(1<<6)
+#define POWER_CTL1_PDN_DACA	(1<<5)
+#define POWER_CTL1_PDN_PGAB	(1<<4)
+#define POWER_CTL1_PDN_PGAA	(1<<3)
+#define POWER_CTL1_PDN_ADCB	(1<<2)
+#define POWER_CTL1_PDN_ADCA	(1<<1)
+#define POWER_CTL1_PDN		(1<<0)
+
+#define MIC_POWER_CTL		0x03
+#define MIC_POWER_CTL_AUTO	(1<<7)
+#define MIC_POWER_CTL_SPEED(x)	(((x)&3)<<5)
+#define QSM_MODE		3
+#define HSM_MODE		2
+#define	SSM_MODE		1
+#define DSM_MODE		0
+#define MIC_POWER_CTL_3ST_SP	(1<<4)
+#define MIC_POWER_CTL_PDN_MICB	(1<<3)
+#define MIC_POWER_CTL_PDN_MICA	(1<<2)
+#define MIC_POWER_CTL_PDN_BIAS	(1<<1)
+#define MIC_POWER_CTL_MCLK_DIV2	(1<<0)
+
+#define INTF_CTL		0x04
+#define INTF_CTL_LOOPBACK	(1<<7)
+#define INTF_CTL_MASTER		(1<<6)
+#define INTF_CTL_DAC_FORMAT(x)	(((x)&7)<<3)
+#define DAC_DIF_LJ24		0x00
+#define DAC_DIF_I2S		0x01
+#define DAC_DIF_RJ24		0x02
+#define DAC_DIF_RJ20		0x03
+#define DAC_DIF_RJ18		0x04
+#define DAC_DIF_RJ16		0x05
+#define INTF_CTL_ADC_I2S	(1<<2)
+#define INTF_CTL_DIGMIX		(1<<1)
+#define INTF_CTL_MICMIX		(1<<0)
+
+#define MIC_CTL			0x05
+#define MIC_CTL_ADC_SNGVOL	(1<<7)
+#define MIC_CTL_ADCD_DBOOST	(1<<6)
+#define MIC_CTL_ADCA_DBOOST	(1<<5)
+#define MIC_CTL_MICBIAS_SEL	(1<<4)
+#define MIC_CTL_MICBIAS_LVL(x)	(((x)&3)<<2)
+#define MIC_CTL_MICB_BOOST	(1<<1)
+#define MIC_CTL_MICA_BOOST	(1<<0)
+
+#define ADC_CTL			0x06
+#define ADC_CTL_ADCB_HPFEN	(1<<7)
+#define ADC_CTL_ADCB_HPFRZ	(1<<6)
+#define ADC_CTL_ADCA_HPFEN	(1<<5)
+#define ADC_CTL_ADCA_HPFRZ	(1<<4)
+#define ADC_CTL_SOFTB		(1<<3)
+#define ADC_CTL_ZCROSSB		(1<<2)
+#define ADC_CTL_SOFTA		(1<<1)
+#define ADC_CTL_ZCROSSA		(1<<0)
+
+#define ADC_INPUT		0x07
+#define ADC_INPUT_AINB_MUX(x)	(((x)&3)<<6)
+#define ADC_INPUT_AINA_MUX(x)	(((x)&3)<<4)
+#define ADC_INPUT_INV_ADCB	(1<<3)
+#define ADC_INPUT_INV_ADCA	(1<<2)
+#define ADC_INPUT_ADCB_MUTE	(1<<1)
+#define ADC_INPUT_ADCA_MUTE	(1<<0)
+
+#define DAC_OUT_CTL		0x08
+#define DAC_OUT_CTL_HP_GAIN(x)	(((x)&7)<<5)
+#define DAC_OUT_CTL_DAC_SNGVOL	(1<<4)
+#define DAC_OUT_CTL_INV_PCMB	(1<<3)
+#define DAC_OUT_CTL_INV_PCMA	(1<<2)
+#define DAC_OUT_CTL_DACB_MUTE	(1<<1)
+#define DAC_OUT_CTL_DACA_MUTE	(1<<0)
+
+#define DAC_CTL			0x09
+#define DAC_CTL_DATA_SEL(x)	(((x)&3)<<6)
+#define DAC_CTL_FREEZE		(1<<5)
+#define DAC_CTL_DEEMPH		(1<<3)
+#define DAC_CTL_AMUTE		(1<<2)
+#define DAC_CTL_DACSZ(x)	(((x)&3)<<0)
+
+#define ALC_PGA_CTL		0x0A
+#define ALC_PGB_CTL		0x0B
+#define ALC_PGX_ALCX_SRDIS	(1<<7)
+#define ALC_PGX_ALCX_ZCDIS	(1<<6)
+#define ALC_PGX_PGX_VOL(x)	(((x)&0x1f)<<0)
+
+#define ADCA_ATT		0x0C
+#define ADCB_ATT		0x0D
+
+#define ADCA_VOL		0x0E
+#define ADCB_VOL		0x0F
+#define PCMA_VOL		0x10
+#define PCMB_VOL		0x11
+#define MIX_MUTE_ADCMIX		(1<<7)
+#define MIX_VOLUME(x)		(((x)&0x7f)<<0)
+
+#define CS42L51_BEEP_FREQ	0x12
+#define CS42L51_BEEP_VOL	0x13
+#define CS42L51_BEEP_CONF	0x14
+
+#define TONE_CTL		0x15
+#define TONE_CTL_TREB(x)	(((x)&0xf)<<4)
+#define TONE_CTL_BASS(x)	(((x)&0xf)<<0)
+
+#define AOUTA_VOL		0x16
+#define AOUTB_VOL		0x17
+#define PCM_MIXER		0x18
+#define LIMIT_THRES_DIS		0x19
+#define LIMIT_REL		0x1A
+#define LIMIT_ATT		0x1B
+#define ALC_EN			0x1C
+#define ALC_REL			0x1D
+#define ALC_THRES		0x1E
+#define NOISE_CONF		0x1F
+
+#define STATUS			0x20
+#define STATUS_SP_CLKERR	(1<<6)
+#define STATUS_SPEA_OVFL	(1<<5)
+#define STATUS_SPEB_OVFL	(1<<4)
+#define STATUS_PCMA_OVFL	(1<<3)
+#define STATUS_PCMB_OVFL	(1<<2)
+#define STATUS_ADCA_OVFL	(1<<1)
+#define STATUS_ADCB_OVFL	(1<<0)
+
+#define CHARGE_FREQ		0x21
+
+#define CS42L51_FIRSTREG	0x01
+/*
+ * Hack: with register 0x21, it makes 33 registers. Looks like someone in the
+ * i2c layer doesn't like i2c smbus block read of 33 regs. Workaround by using
+ * 32 regs
+ */
+#define CS42L51_LASTREG		0x20
+#define CS42L51_NUMREGS		(CS42L51_LASTREG - CS42L51_FIRSTREG + 1)
+
+struct cs42l51_setup_data {
+	int i2c_bus;
+	unsigned short i2c_address;
+};
+
+extern struct snd_soc_dai cs42l51_dai;
+extern struct snd_soc_codec_device soc_codec_device_cs42l51;
+#endif
Index: sound-2.6/sound/soc/codecs/Kconfig
===================================================================
--- sound-2.6.orig/sound/soc/codecs/Kconfig	2010-05-15 17:10:21.222086550 +0200
+++ sound-2.6/sound/soc/codecs/Kconfig	2010-05-15 17:13:44.362087086 +0200
@@ -22,6 +22,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
 	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
+	select SND_SOC_CS42L51 if I2C
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_DA7210 if I2C
@@ -120,6 +121,9 @@ config SND_SOC_AK4671
 config SND_SOC_CQ0093VC
 	tristate
 
+config SND_SOC_CS42L51
+	tristate
+
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
Index: sound-2.6/sound/soc/codecs/Makefile
===================================================================
--- sound-2.6.orig/sound/soc/codecs/Makefile	2010-05-15 17:10:21.246086628 +0200
+++ sound-2.6/sound/soc/codecs/Makefile	2010-05-15 17:13:44.366086568 +0200
@@ -9,6 +9,7 @@ snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
 snd-soc-cq93vc-objs := cq93vc.o
+snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-da7210-objs := da7210.o
@@ -74,6 +75,7 @@ obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-
 obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
+obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
