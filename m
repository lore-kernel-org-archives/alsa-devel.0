From: apatard@mandriva.com
Subject: [patch 4/6] cs42l51: add asoc driver
Date: Tue, 11 May 2010 18:23:46 +0200
Message-ID: <20100511162602.226980713@mandriva.com>
References: <20100511162342.640158675@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id 7ABB0248ED
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 18:26:01 +0200 (CEST)
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
Cc: Arnaud Patard <apatard@mandriva.com>, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, nico@fluxnic.net, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

This patch is adding a ASoC driver for the cs42l51 from Cirrus Logic.
Master mode and spi mode are not supported.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---
 sound/soc/codecs/Kconfig   |    4 	4 +	0 -	0 !
 sound/soc/codecs/Makefile  |    2 	2 +	0 -	0 !
 sound/soc/codecs/cs42l51.c |  682 	682 +	0 -	0 !
 sound/soc/codecs/cs42l51.h |  167 	167 +	0 -	0 !
 4 files changed, 855 insertions(+)

Index: linux-2.6.33/sound/soc/codecs/cs42l51.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.33/sound/soc/codecs/cs42l51.c	2010-05-11 18:03:07.717711495 +0200
@@ -0,0 +1,682 @@
+/*
+ * cs42l51.c
+ *
+ * ASoC Driver for Cirrus Logic CS42L51 codecs
+ *
+ * Copyright (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ * Based on cs4270.c - Copyright (c) Timur Tabi <timur@freescale.com>
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
+#include <sound/tlv.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
+#include <sound/pcm.h>
+#include <linux/i2c.h>
+
+#include "cs42l51.h"
+
+enum funct_mode {
+	MODE_SLAVE,
+	MODE_SLAVE_AUTO,
+	MODE_MASTER,
+};
+
+struct cs42l51_private {
+	unsigned int mclk;
+	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
+	enum funct_mode func;		/* See funct_mode */
+	struct snd_soc_codec codec;
+	u16 reg_cache[CS42L51_NUMREGS];
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
+	u8 *cache = codec->reg_cache;
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
+static unsigned int cs42l51_read_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u8 *cache = codec->reg_cache;
+
+	if ((reg < CS42L51_FIRSTREG) || (reg > CS42L51_LASTREG))
+		return -EIO;
+
+	return cache[reg - CS42L51_FIRSTREG];
+}
+
+static int cs42l51_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int value)
+{
+	u8 *cache = codec->reg_cache;
+	struct i2c_client *client = codec->control_data;
+
+	if ((reg < CS42L51_FIRSTREG) || (reg > CS42L51_LASTREG))
+		return -EIO;
+
+	/* Only perform an I2C operation if the new value is different */
+	if (cache[reg - CS42L51_FIRSTREG] != value) {
+		if (i2c_smbus_write_byte_data(client, reg, value)) {
+			dev_err(&client->dev, "I2C write failed\n");
+			return -EIO;
+		}
+		cache[reg - CS42L51_FIRSTREG] = value;
+	}
+
+	return 0;
+}
+
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
+	if (ret != MK_CHIP_REV(CHIP_ID, CHIP_REV)) {
+		dev_err(&i2c_client->dev, "Invalid chip id\n");
+		ret = -ENODEV;
+		goto error;
+	}
+
+	dev_info(&i2c_client->dev, "found device at I2C address %X\n",
+				i2c_client->addr);
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
+	codec->private_data = cs42l51;
+
+	codec->control_data = i2c_client;
+	codec->read = cs42l51_read_reg_cache;
+	codec->write = cs42l51_i2c_write;
+	codec->reg_cache = cs42l51->reg_cache;
+	codec->reg_cache_size = CS42L51_NUMREGS;
+
+	ret = cs42l51_fill_cache(codec);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "failed to fill register cache\n");
+		goto error;
+	}
+
+	i2c_set_clientdata(i2c_client, codec);
+
+	/*
+	 * DAC configuration (right place to do that ?)
+	 * - Use signal processor
+	 * - auto mute
+	 * - vol changes immediate
+	 * - no de-emphasize
+	 */
+	reg = DAC_CTL_DATA_SEL(1) | DAC_CTL_AMUTE | DAC_CTL_DACSZ(0);
+	ret = cs42l51_i2c_write(codec, DAC_CTL, reg);
+	if (ret < 0)
+		goto error;
+
+	/* Unmute PCM-A & PCM-B and set default vol to */
+	ret = cs42l51_i2c_write(codec, PCMA_VOL, 0x60);
+	if (ret < 0)
+		goto error;
+
+	ret = cs42l51_i2c_write(codec, PCMB_VOL, 0x60);
+	if (ret < 0)
+		goto error;
+
+	/* default for AOUTx */
+	ret = cs42l51_i2c_write(codec, AOUTA_VOL, 0x05);
+	if (ret < 0)
+		goto error;
+
+	ret = cs42l51_i2c_write(codec, AOUTB_VOL, 0x05);
+	if (ret < 0)
+		goto error;
+
+	/* route microphone */
+	ret = cs42l51_i2c_write(codec, ADC_INPUT, 0xF0);
+	if (ret < 0)
+		goto error;
+
+	cs42l51_dai.dev = codec->dev;
+	cs42l51_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto error;
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
+error:
+	return ret;
+}
+
+static int cs42l51_i2c_remove(struct i2c_client *client)
+{
+	struct cs42l51_private *cs42l51 = i2c_get_clientdata(client);
+	snd_soc_unregister_dai(&cs42l51_dai);
+	snd_soc_unregister_codec(&cs42l51->codec);
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
+
+static const char *chan_mix[] = {
+	"L R",
+	"L+R",
+	"R L",
+};
+
+static const struct soc_enum cs42l51_mix[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(chan_mix), chan_mix),
+	SOC_ENUM_DOUBLE(MIC_CTL, 0, 1, 2, mic_boost),
+};
+
+static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
+	SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
+			PCMA_VOL, PCMB_VOL, 7, 0xffffff99, 0x18, adc_pcm_tlv),
+	SOC_DOUBLE_R("PCM Playback Switch", PCMA_VOL, PCMB_VOL, 7, 1, 1),
+	SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
+			AOUTA_VOL, AOUTB_VOL, 8, 0xffffff19, 0x18, aout_tlv),
+	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
+			ADCA_VOL, ADCB_VOL, 7, 0xffffff99, 0x18, adc_pcm_tlv),
+	SOC_DOUBLE_R("ADC Mixer Switch", PCMA_VOL, PCMB_VOL, 7, 1, 1),
+	SOC_SINGLE("Playback Deemphasis", DAC_CTL, 3, 1, 0),
+	SOC_SINGLE("Auto-Mute Switch", DAC_CTL, 2, 1, 0),
+	SOC_SINGLE("Soft Ramp Switch", DAC_CTL, 1, 1, 0),
+	SOC_SINGLE("Zero Cross Switch", DAC_CTL, 0, 0, 0),
+	SOC_SINGLE("Mic Bias", MIC_POWER_CTL, 1, 1, 1),
+	SOC_DOUBLE("Mic Powerdown", MIC_POWER_CTL, 2, 3, 1, 0),
+	SOC_ENUM("Mic Boost", cs42l51_mix[1]),
+	SOC_SINGLE_TLV("Bass Volume", TONE_CTL, 0, 0xf, 1, tone_tlv),
+	SOC_SINGLE_TLV("Treble Volume", TONE_CTL, 4, 0xf, 1, tone_tlv),
+	SOC_ENUM_EXT("PCM channel mixer",
+			cs42l51_mix[0],
+			cs42l51_get_chan_mix, cs42l51_set_chan_mix),
+};
+
+static int cs42l51_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs42l51_private *cs42l51 = codec->private_data;
+	int ret = 0;
+
+	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		cs42l51->audio_mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		printk(KERN_ERR "cs4270: invalid DAI format\n");
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
+/* Fill me */
+static struct cs42l51_ratios master_ratios[] = { {},
+};
+
+static int cs42l51_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs42l51_private *cs42l51 = codec->private_data;
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
+		ratios = master_ratios;
+		nr_ratios = ARRAY_SIZE(master_ratios);
+		break;
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
+	struct cs42l51_private *cs42l51 = codec->private_data;
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
+		ratios = master_ratios;
+		nr_ratios = ARRAY_SIZE(master_ratios);
+		break;
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
+static struct snd_soc_dai_ops cs42l51_dai_ops = {
+	.hw_params      = cs42l51_hw_params,
+	.set_sysclk     = cs42l51_set_dai_sysclk,
+	.set_fmt        = cs42l51_set_dai_fmt,
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
+	int i;
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
+	for (i = 0; i < ARRAY_SIZE(cs42l51_snd_controls); i++) {
+		ret = snd_ctl_add(codec->card,
+				snd_soc_cnew(&cs42l51_snd_controls[i],
+				codec, NULL));
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to add controls\n");
+			snd_soc_free_pcms(socdev);
+			return ret;
+		}
+	}
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
Index: linux-2.6.33/sound/soc/codecs/cs42l51.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.33/sound/soc/codecs/cs42l51.h	2010-05-11 17:59:30.745650160 +0200
@@ -0,0 +1,167 @@
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
+#define CHIP_REV		0x01
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
+#define BEEP_FREQ		0x12
+#define BEEP_VOL		0x13
+#define BEEP_CONF		0x14
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
Index: linux-2.6.33/sound/soc/codecs/Kconfig
===================================================================
--- linux-2.6.33.orig/sound/soc/codecs/Kconfig	2010-05-11 17:38:48.729650013 +0200
+++ linux-2.6.33/sound/soc/codecs/Kconfig	2010-05-11 17:59:30.745650160 +0200
@@ -21,6 +21,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
+	select SND_SOC_CS42L51 if I2C
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_DA7210 if I2C
@@ -114,6 +115,9 @@ config SND_SOC_AK4642
 config SND_SOC_AK4671
 	tristate
 
+config SND_SOC_CS42L51
+	tristate
+
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
Index: linux-2.6.33/sound/soc/codecs/Makefile
===================================================================
--- linux-2.6.33.orig/sound/soc/codecs/Makefile	2010-05-11 17:38:48.753650032 +0200
+++ linux-2.6.33/sound/soc/codecs/Makefile	2010-05-11 17:59:30.745650160 +0200
@@ -8,6 +8,7 @@ snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
+snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-da7210-objs := da7210.o
@@ -70,6 +71,7 @@ obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
+obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
