From: <bardliao@realtek.com>
Subject: [PATCH V2] ASoC: add RT286 CODEC driver
Date: Wed, 4 Dec 2013 21:41:28 +0800
Message-ID: <1386164488-32227-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A1BCC265383
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 14:41:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch adds the ALC286 codec driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>

---

This is the initial codec driver of ALC286.
I tested Headset recording and Speaker playback.
I tested with snd_soc_register_codec because my kernel doesn't support devm_snd_soc_register_codec yet.

---
 include/sound/rt286.h     |   19 +
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/rt286.c  | 1367 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt286.h  |   89 +++
 5 files changed, 1481 insertions(+)
 create mode 100644 include/sound/rt286.h
 create mode 100644 sound/soc/codecs/rt286.c
 create mode 100644 sound/soc/codecs/rt286.h

diff --git a/include/sound/rt286.h b/include/sound/rt286.h
new file mode 100644
index 0000000..6c0c1c9
--- /dev/null
+++ b/include/sound/rt286.h
@@ -0,0 +1,19 @@
+/*
+ * linux/sound/rt286.h -- Platform data for RT286
+ *
+ * Copyright 2013 Realtek Microelectronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_RT286_H
+#define __LINUX_SND_RT286_H
+
+struct rt286_platform_data {
+	bool cbj_en; /*combo jack enable*/
+	bool irq_en; /*IRQ enable*/
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 983d087a..755a39d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -61,6 +61,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM3008
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_RT5640 if I2C
+	select SND_SOC_RT286 if I2C
 	select SND_SOC_SGTL5000 if I2C
 	select SND_SOC_SI476X if MFD_SI476X_CORE
 	select SND_SOC_SN95031 if INTEL_SCU_IPC
@@ -319,6 +320,9 @@ config SND_SOC_RT5631
 config SND_SOC_RT5640
 	tristate
 
+config SND_SOC_RT286
+	tristate
+
 #Freescale sgtl5000 codec
 config SND_SOC_SGTL5000
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bc12676..b31615c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -48,6 +48,7 @@ snd-soc-pcm1792a-codec-objs := pcm1792a.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-rt5640-objs := rt5640.o
+snd-soc-rt286-objs := rt286.o
 snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
 snd-soc-alc5632-objs := alc5632.o
@@ -181,6 +182,7 @@ obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
+obj-$(CONFIG_SND_SOC_RT286)	+= snd-soc-rt286.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
 obj-$(CONFIG_SND_SOC_SI476X)	+= snd-soc-si476x.o
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
new file mode 100644
index 0000000..e7aef0d
--- /dev/null
+++ b/sound/soc/codecs/rt286.c
@@ -0,0 +1,1367 @@
+/*
+ * rt286.c  --  RT286 ALSA SoC audio codec driver
+ *
+ * Copyright 2013 Realtek Semiconductor Corp.
+ * Author: Bard Liao <bardliao@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/acpi.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <sound/rt286.h>
+
+#include "../../pci/hda/hda_codec.h"
+#include "rt286.h"
+
+struct rt286_priv {
+	struct regmap *regmap;
+	struct rt286_platform_data pdata;
+	int sys_clk;
+};
+
+static unsigned int rt286_reg_cache[TOTAL_NODE_ID + 1] = {
+	[NODE_ID_DAC_OUT1] = 0x7f7f,
+	[NODE_ID_DAC_OUT2] = 0x7f7f,
+	[NODE_ID_SPDIF] = 0x0000,
+	[NODE_ID_ADC_IN1] = 0x4343,
+	[NODE_ID_ADC_IN2] = 0x4343,
+	[NODE_ID_MIC1] = 0x0000,
+	[NODE_ID_MIXER_IN] = 0x000b,
+	[NODE_ID_MIXER_OUT1] = 0x0002,
+	[NODE_ID_MIXER_OUT2] = 0x0000,
+	[NODE_ID_SPK_OUT] = 0x0000,
+	[NODE_ID_HP_OUT] = 0x0000,
+	[NODE_ID_MIXER_IN1] = 0x0000,
+	[NODE_ID_MIXER_IN2] = 0x0000,
+};
+
+static int rt286_hw_read(void *context, unsigned int reg, unsigned int *value)
+{
+	struct i2c_client *client = context;
+	struct i2c_msg xfer[2];
+	int ret;
+	unsigned int buf = 0x0;
+
+	if (reg <= 0xff) { /*read cache*/
+		*value = rt286_reg_cache[reg];
+		return 0;
+	}
+	reg = cpu_to_be32(reg);
+	/* Write register */
+	xfer[0].addr = client->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 4;
+	xfer[0].buf = (u8 *)&reg;
+
+	/* Read data */
+	xfer[1].addr = client->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = 4;
+	xfer[1].buf = (u8 *)&buf;
+
+	ret = i2c_transfer(client->adapter, xfer, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+
+	*value = be32_to_cpu(buf);
+
+	return 0;
+}
+
+static int rt286_hw_write(void *context, unsigned int reg, unsigned int value)
+{
+	struct i2c_client *client = context;
+	u8 data[4];
+	int ret;
+
+	if (reg <= 0xff) { /*write cache*/
+		rt286_reg_cache[reg] = value;
+		return 0;
+	}
+	data[0] = (reg >> 24) & 0xff;
+	data[1] = (reg >> 16) & 0xff;
+	data[2] = (reg >> 8) & 0xff;
+	data[3] = reg & 0xff;
+
+	ret = i2c_master_send(client, data, 4);
+	if (ret == 4)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static unsigned int rt286_read(struct snd_soc_codec *codec,
+					   unsigned int vid,
+					   unsigned int nid,
+					   unsigned int data)
+{
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+	unsigned int verb;
+	unsigned int buf = 0x0;
+
+	verb = (nid << 20) | (vid << 8) | data;
+
+	regmap_read(rt286->regmap, verb, &buf);
+	return buf;
+}
+
+static int rt286_write(struct snd_soc_codec *codec,
+				unsigned int vid,
+				unsigned int nid,
+				unsigned int value)
+{
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg;
+
+	reg = (nid << 20) | (vid << 8) | value;
+
+	return regmap_write(rt286->regmap, reg, 0);
+}
+
+static int rt286_update_bits(struct snd_soc_codec *codec, unsigned int vid,
+				unsigned int nid, unsigned int data,
+				unsigned int mask, unsigned int value)
+{
+	unsigned int old, new;
+	int change, ret;
+
+	old = rt286_read(codec, vid | 0x800, nid, data);
+	new = (old & ~mask) | (value & mask);
+	change = old != new;
+
+	if (change) {
+		ret = rt286_write(codec, vid, nid, new);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to write private reg: %d\n", ret);
+			goto err;
+		}
+	}
+	return change;
+
+err:
+	return ret;
+}
+
+static int rt286_index_write(struct snd_soc_codec *codec,
+	unsigned int wid, unsigned int index, unsigned int data)
+{
+	int ret;
+
+	ret = rt286_write(codec, AC_VERB_SET_COEF_INDEX,
+			wid, index);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set private addr: %d\n", ret);
+		goto err;
+	}
+	ret = rt286_write(codec, AC_VERB_SET_PROC_COEF,
+			wid, data);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set private value: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	return ret;
+}
+
+static unsigned int rt286_index_read(struct snd_soc_codec *codec,
+	unsigned int wid, unsigned int index)
+{
+	int ret;
+
+	ret = rt286_write(codec, AC_VERB_SET_COEF_INDEX,
+			wid, index);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set private addr: %d\n", ret);
+		return ret;
+	}
+	return rt286_read(codec, AC_VERB_GET_PROC_COEF,
+				wid, index);
+}
+
+static int rt286_index_update_bits(struct snd_soc_codec *codec,
+	unsigned int wid, unsigned int index,
+	unsigned int mask, unsigned int data)
+{
+	unsigned int old, new;
+	int change, ret;
+
+	old =  rt286_index_read(codec, wid, index);
+	new = (old & ~mask) | (data & mask);
+	change = old != new;
+
+	if (change) {
+		ret = rt286_index_write(codec, wid, index, new);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to write private reg: %d\n", ret);
+			goto err;
+		}
+	}
+	return change;
+
+err:
+	return ret;
+}
+
+static int rt286_support_power_controls[] = {
+	NODE_ID_DAC_OUT1,
+	NODE_ID_DAC_OUT2,
+	NODE_ID_ADC_IN1,
+	NODE_ID_ADC_IN2,
+	NODE_ID_MIC1,
+	NODE_ID_DMIC1,
+	NODE_ID_DMIC2,
+	NODE_ID_SPK_OUT,
+	NODE_ID_HP_OUT,
+};
+#define RT286_POWER_REG_LEN ARRAY_SIZE(rt286_support_power_controls)
+
+static const struct reg_default rt286_reg[] = {
+	{ NODE_ID_DAC_OUT1, 0x7f7f },
+	{ NODE_ID_DAC_OUT2, 0x7f7f },
+	{ NODE_ID_SPDIF, 0x0000 },
+	{ NODE_ID_ADC_IN1, 0x4343 },
+	{ NODE_ID_ADC_IN2, 0x4343 },
+	{ NODE_ID_MIC1, 0x0000 },
+	{ NODE_ID_MIXER_IN, 0x000b },
+	{ NODE_ID_MIXER_OUT1, 0x0002 },
+	{ NODE_ID_MIXER_OUT2, 0x0000 },
+	{ NODE_ID_SPK_OUT, 0x0000 },
+	{ NODE_ID_HP_OUT, 0x0000 },
+	{ NODE_ID_MIXER_IN1, 0x0005 },
+	{ NODE_ID_MIXER_IN2, 0x0005 },
+};
+
+static bool rt286_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NODE_ID_DAC_OUT1:
+	case NODE_ID_DAC_OUT2:
+	case NODE_ID_ADC_IN1:
+	case NODE_ID_ADC_IN2:
+	case NODE_ID_MIC1:
+	case NODE_ID_SPDIF:
+	case NODE_ID_MIXER_IN:
+	case NODE_ID_MIXER_OUT1:
+	case NODE_ID_MIXER_OUT2:
+	case NODE_ID_DMIC1:
+	case NODE_ID_DMIC2:
+	case NODE_ID_SPK_OUT:
+	case NODE_ID_HP_OUT:
+	case NODE_ID_MIXER_IN1:
+	case NODE_ID_MIXER_IN2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+int rt286_jack_detect(struct snd_soc_codec *codec, bool *hp, bool *mic)
+{
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
+	int i;
+
+	*hp  = false;
+	*mic = false;
+
+	if (rt286->pdata.cbj_en) {
+		*hp = rt286_read(codec, AC_VERB_GET_PIN_SENSE,
+					NODE_ID_HP_OUT, 0);
+		if (*hp) {
+			/* power on HV,VERF */
+			rt286_index_update_bits(codec,
+				NODE_ID_VENDOR_REGISTERS, 0x03, 0x1001, 0x0);
+			/* power LDO1 */
+			rt286_index_update_bits(codec,
+				NODE_ID_VENDOR_REGISTERS, 0x08, 0x4, 0x4);
+			rt286_write(codec, AC_VERB_SET_PIN_WIDGET_CONTROL,
+						NODE_ID_MIC1, 0x24);
+			rt286_write(codec, AC_VERB_SET_COEF_INDEX,
+						0x20, 0x50);
+			val = rt286_read(codec, AC_VERB_GET_PROC_COEF,
+						0x20, 0x50);
+
+			msleep(200);
+			i = 40;
+			while (((val & 0x0800) == 0) && (i > 0)) {
+				rt286_write(codec, AC_VERB_SET_COEF_INDEX,
+							0x20, 0x50);
+				val = rt286_read(codec,
+					AC_VERB_GET_PROC_COEF, 0x20, 0x50);
+				i--;
+				msleep(20);
+			}
+
+			if (0x0400 == (val & 0x0700)) {
+				*mic = false;
+
+				rt286_write(codec,
+					AC_VERB_SET_PIN_WIDGET_CONTROL,
+					NODE_ID_MIC1, 0x20);
+				/* power off HV,VERF */
+				rt286_index_update_bits(codec,
+					NODE_ID_VENDOR_REGISTERS,
+					0x03, 0x1001, 0x1001);
+				rt286_index_update_bits(codec,
+					NODE_ID_VENDOR_REGISTERS,
+					0x04, 0xC000, 0x0000);
+				rt286_index_update_bits(codec,
+					NODE_ID_VENDOR_REGISTERS,
+					0x4f, 0x0030, 0x0000);
+				rt286_index_update_bits(codec,
+					NODE_ID_VENDOR_REGISTERS,
+					0x02, 0xc000, 0x0000);
+			} else if ((0x0200 == (val & 0x0700)) ||
+				(0x0100 == (val & 0x0700))) {
+				*mic = true;
+			} else {
+				*mic = false;
+			}
+
+			rt286_index_update_bits(codec,
+						NODE_ID_VENDOR_REGISTERS,
+						0x20, 0x0060, 0x0000);
+		} else {
+			rt286_index_update_bits(codec,
+						NODE_ID_VENDOR_REGISTERS,
+						0x20, 0x0060, 0x0020);
+			rt286_index_update_bits(codec,
+						NODE_ID_VENDOR_REGISTERS,
+						0x04, 0xC000, 0x8000);
+			rt286_index_update_bits(codec,
+						NODE_ID_VENDOR_REGISTERS,
+						0x4f, 0x0030, 0x0020);
+			rt286_index_update_bits(codec,
+						NODE_ID_VENDOR_REGISTERS,
+						0x02, 0xc000, 0x8000);
+
+			*mic = false;
+		}
+	} else {
+		*hp = rt286_read(codec, AC_VERB_GET_PIN_SENSE,
+					NODE_ID_HP_OUT, 0);
+		*mic = rt286_read(codec, AC_VERB_GET_PIN_SENSE,
+					NODE_ID_MIC1, 0);
+	}
+
+
+	/* Clear IRQ */
+	rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+				0x33, 0x1, 0x1);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt286_jack_detect);
+
+static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -6350, 50, 0);
+static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
+
+static int rt286_vol_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int io = 0x8000;
+
+	if (NODE_ID_ADC_IN1 == mc->reg)
+		io = 0;
+	ucontrol->value.integer.value[0] =
+	rt286_read(codec, AC_VERB_GET_AMP_GAIN_MUTE,
+		mc->reg, 0x2000 | io) & 0x7f;
+	ucontrol->value.integer.value[1] =
+	rt286_read(codec, AC_VERB_GET_AMP_GAIN_MUTE,
+		mc->reg, io) & 0x7f;
+
+	return 0;
+}
+
+static int rt286_vol_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int vall, valr, io;
+
+	if (NODE_ID_ADC_IN1 == mc->reg)
+		io = 0x4000;
+	else
+		io = 0x8000;
+	vall = ucontrol->value.integer.value[0];
+	valr = ucontrol->value.integer.value[1];
+	if (vall == valr) {
+		vall = vall | 0x3000 | io;
+		rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE, mc->reg, vall);
+	} else {
+		vall = vall | 0x2000 | io;
+		rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE, mc->reg, vall);
+		valr = valr | 0x1000 | io;
+		rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE, mc->reg, valr);
+	}
+
+	return 0;
+}
+
+static int rt286_mic_gain_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] =
+		rt286_read(codec, AC_VERB_GET_AMP_GAIN_MUTE,
+			mc->reg, 0x0) & 0x3;
+
+	return 0;
+}
+
+static int rt286_mic_gain_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int val;
+
+	val = ucontrol->value.integer.value[0];
+	val = val | 0x7000;
+	rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE, mc->reg, val);
+
+	return 0;
+}
+
+static int rt286_playback_switch_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+
+
+	ucontrol->value.integer.value[0] =
+		!(rt286_read(codec, AC_VERB_GET_AMP_GAIN_MUTE,
+			mc->reg, 0xa000) & 0x80);
+	ucontrol->value.integer.value[1] =
+		!(rt286_read(codec, AC_VERB_GET_AMP_GAIN_MUTE,
+			mc->reg, 0x8000) & 0x80);
+
+	return 0;
+}
+
+static int rt286_playback_switch_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int vall, valr, val = 0;
+
+	vall = (!ucontrol->value.integer.value[0] << 7);
+	valr = (!ucontrol->value.integer.value[1] << 7);
+	if (vall)
+		val |= 0x8000;
+	if (valr)
+		val |= 0x0080;
+
+	if (vall == valr) {
+		vall = vall | 0xb000;
+		rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE, mc->reg, vall);
+	} else {
+		vall = vall | 0xa000;
+		rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE, mc->reg, vall);
+		valr = valr | 0x9000;
+		rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE, mc->reg, valr);
+	}
+	snd_soc_update_bits(codec, mc->reg, 0x8080, val);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new rt286_snd_controls[] = {
+	SOC_DOUBLE_EXT_TLV("DAC0 Playback Volume", NODE_ID_DAC_OUT1,
+			   8, 0, 0x7f, 0,
+			   rt286_vol_get, rt286_vol_put,
+			   out_vol_tlv),
+	SOC_DOUBLE_EXT_TLV("ADC0 Capture Volume", NODE_ID_ADC_IN1,
+			   8, 0, 0x7f, 0,
+			   rt286_vol_get, rt286_vol_put,
+			   out_vol_tlv),
+	SOC_SINGLE_EXT_TLV("AMIC Volume", NODE_ID_MIC1, 0, 0x3, 0,
+			   rt286_mic_gain_get, rt286_mic_gain_put,
+			   mic_vol_tlv),
+	SOC_DOUBLE_EXT("Headphone Playback Switch", NODE_ID_HP_OUT,
+			   15, 8, 1, 1, rt286_playback_switch_get,
+			   rt286_playback_switch_put),
+	SOC_DOUBLE_EXT("Speaker Playback Switch", NODE_ID_SPK_OUT,
+			   15, 8, 1, 1, rt286_playback_switch_get,
+			   rt286_playback_switch_put),
+};
+
+static void hw_configure(struct snd_soc_codec *codec)
+{
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	rt286_write(codec, AC_VERB_SET_POWER_STATE,
+		NODE_ID_AUDIO_FUNCTION_GROUP, AC_PWRST_D3);
+	for (i = 0; i < RT286_POWER_REG_LEN; i++) {
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			rt286_support_power_controls[i], AC_PWRST_D3);
+	}
+
+	if (rt286->pdata.irq_en)
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x33, 0x0002, 0x0002);
+
+	if (!rt286->pdata.cbj_en) {
+		rt286_index_write(codec,
+				NODE_ID_VENDOR_REGISTERS, 0x50, 0x0000);
+		rt286_index_write(codec,
+				NODE_ID_VENDOR_REGISTERS, 0x19, 0x0816);
+		rt286_index_write(codec,
+				NODE_ID_VENDOR_REGISTERS, 0x20, 0x0000);
+	}
+
+	mdelay(10);
+
+	/* Set configuration default  */
+	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
+		NODE_ID_MIC1, 0x00);
+	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
+		NODE_ID_DMIC1, 0x00);
+	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
+		NODE_ID_DMIC2, 0x00);
+
+	mdelay(10);
+
+	if (rt286->pdata.cbj_en)
+		rt286_index_write(codec,
+				NODE_ID_VENDOR_REGISTERS, 0x4f, 0x5029);
+	else
+		rt286_index_write(codec,
+				NODE_ID_VENDOR_REGISTERS, 0x4f, 0xb029);
+
+	/*Power down LDO2*/
+	rt286_index_update_bits(codec,
+		NODE_ID_VENDOR_REGISTERS, 0x08, 0x0008, 0x0000);
+}
+
+/* Digital Mixer */
+static const struct snd_kcontrol_new rt286_front_mix[] = {
+	SOC_DAPM_SINGLE("DAC Switch", NODE_ID_MIXER_OUT1,
+			RT286_M_FRONT_DAC_SFT, 1, 1),
+	SOC_DAPM_SINGLE("RECMIX Switch", NODE_ID_MIXER_OUT1,
+			RT286_M_FRONT_REC_SFT, 1, 1),
+};
+
+/* Analog Input Mixer */
+static const struct snd_kcontrol_new rt286_rec_mix[] = {
+	SOC_DAPM_SINGLE("Beep Switch", NODE_ID_MIXER_IN,
+			RT286_M_REC_BEEP_SFT, 1, 1),
+	SOC_DAPM_SINGLE("Line1 Switch", NODE_ID_MIXER_IN,
+			RT286_M_REC_LINE1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("Mic1 Switch", NODE_ID_MIXER_IN,
+			RT286_M_REC_MIC1_SFT, 1, 1),
+	SOC_DAPM_SINGLE("I2S Switch", NODE_ID_MIXER_IN,
+			RT286_M_REC_I2S_SFT, 1, 1),
+};
+
+/* ADC0 source */
+static const char * const rt286_adc_src[] = {
+	"Mic", "Dmic"
+};
+
+static int rt286_adc_values[] = {
+	0, 5,
+};
+
+static const SOC_VALUE_ENUM_SINGLE_DECL(
+	rt286_adc0_enum, NODE_ID_MIXER_IN1, RT286_ADC_SEL_SFT,
+	RT286_ADC_SEL_MASK, rt286_adc_src, rt286_adc_values);
+
+static const struct snd_kcontrol_new rt286_adc0_mux =
+	SOC_DAPM_VALUE_ENUM("ADC 0 source", rt286_adc0_enum);
+
+static const SOC_VALUE_ENUM_SINGLE_DECL(
+	rt286_adc1_enum, NODE_ID_MIXER_IN2, RT286_ADC_SEL_SFT,
+	RT286_ADC_SEL_MASK, rt286_adc_src, rt286_adc_values);
+
+static const struct snd_kcontrol_new rt286_adc1_mux =
+	SOC_DAPM_VALUE_ENUM("ADC 1 source", rt286_adc1_enum);
+
+/* HP-OUT source */
+static const char * const rt286_hpo_src[] = {
+	"Front", "Surround"
+};
+
+static const SOC_ENUM_SINGLE_DECL(rt286_hpo_enum, NODE_ID_HP_OUT,
+				  RT286_HP_SEL_SFT, rt286_hpo_src);
+
+static const struct snd_kcontrol_new rt286_hpo_mux =
+SOC_DAPM_ENUM("HPO source", rt286_hpo_enum);
+
+/* SPK-OUT source */
+static const char * const rt286_spo_src[] = {
+	"Front", "Surround"
+};
+
+static const SOC_ENUM_SINGLE_DECL(rt286_spo_enum, NODE_ID_SPK_OUT,
+				  RT286_SPK_SEL_SFT, rt286_spo_src);
+
+static const struct snd_kcontrol_new rt286_spo_mux =
+SOC_DAPM_ENUM("SPO source", rt286_spo_enum);
+
+/* SPDIF source */
+static const char * const rt286_spdif_src[] = {
+	"PCM-IN 0", "PCM-IN 1", "SP-OUT", "PP"
+};
+
+static const SOC_ENUM_SINGLE_DECL(rt286_spdif_enum, NODE_ID_SPDIF,
+				  RT286_SPDIF_SEL_SFT, rt286_spdif_src);
+
+static const struct snd_kcontrol_new rt286_spdif_mux =
+SOC_DAPM_ENUM("SPDIF source", rt286_spdif_enum);
+
+
+static int rt286_spk_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			NODE_ID_SPK_OUT, AC_PWRST_D0);
+		rt286_write(codec, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			NODE_ID_SPK_OUT, 0x40);
+		rt286_write(codec, AC_VERB_SET_EAPD_BTLENABLE,
+			NODE_ID_SPK_OUT, 0x0002);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		rt286_write(codec, AC_VERB_SET_EAPD_BTLENABLE,
+			NODE_ID_SPK_OUT, 0x0000);
+		rt286_write(codec, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			NODE_ID_SPK_OUT, 0x00);
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			NODE_ID_SPK_OUT, AC_PWRST_D3);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt286_hp_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	unsigned int val;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		val = snd_soc_read(codec, NODE_ID_HP_OUT) & 0x8080;
+		switch (val) {
+		case 0x0:
+			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
+				NODE_ID_HP_OUT, 0xb000);
+			break;
+		case 0x8000:
+			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
+				NODE_ID_HP_OUT, 0x9000);
+			break;
+		case 0x0080:
+			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
+				NODE_ID_HP_OUT, 0xa000);
+			break;
+		}
+		if (val != 0x8080)
+			mdelay(100);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
+			NODE_ID_HP_OUT, 0xb080);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt286_set_power_event(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			w->reg, AC_PWRST_D0);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			w->reg, AC_PWRST_D3);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt286_set_dmic1_event(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		rt286_write(codec, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			NODE_ID_DMIC1, 0x20);
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			NODE_ID_DMIC1, AC_PWRST_D0);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			NODE_ID_DMIC1, AC_PWRST_D3);
+		rt286_write(codec, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			NODE_ID_DMIC1, 0x0);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt286_hp_pow_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			NODE_ID_HP_OUT, AC_PWRST_D0);
+		rt286_write(codec, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			NODE_ID_HP_OUT, 0x40);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		rt286_write(codec, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			NODE_ID_HP_OUT, 0x00);
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			NODE_ID_HP_OUT, AC_PWRST_D3);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt286_adc_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+	struct soc_enum *e;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (rt286->pdata.cbj_en) {
+			rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+						0x04, 0xC000, 0x8000);
+			rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+						0x4f, 0x0030, 0x0020);
+			rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+						0x02, 0xc000, 0x8000);
+		}
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+					0x0f, 0x0020, 0x0000);
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			w->reg, AC_PWRST_D0);
+		rt286_update_bits(codec, AC_VERB_SET_AMP_GAIN_MUTE,
+			w->reg, 0, 0x7080, 0x7000);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		rt286_update_bits(codec, AC_VERB_SET_AMP_GAIN_MUTE,
+			w->reg, 0, 0x7080, 0x7080);
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			w->reg, AC_PWRST_D3);
+		break;
+	case SND_SOC_DAPM_POST_REG:
+		e = (struct soc_enum *)kcontrol->private_value;
+		rt286_write(codec, AC_VERB_SET_CONNECT_SEL, e->reg,
+			snd_soc_read(codec, e->reg) & RT286_ADC_SEL_MASK);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt286_out_mux_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_REG:
+		rt286_write(codec, AC_VERB_SET_CONNECT_SEL,
+			e->reg, snd_soc_read(codec, e->reg) & 0x1);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget rt286_dapm_widgets[] = {
+	/* Input Lines */
+	SND_SOC_DAPM_INPUT("DMIC1 Pin"),
+	SND_SOC_DAPM_INPUT("DMIC2 Pin"),
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("LINE1"),
+	SND_SOC_DAPM_INPUT("Beep"),
+
+	/* DMIC */
+	SND_SOC_DAPM_PGA_E("DMIC1", NODE_ID_DMIC1, 15, 0,
+		NULL, 0, rt286_set_dmic1_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_E("DMIC2", NODE_ID_DMIC2, 15, 0,
+		NULL, 0, rt286_set_power_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_SUPPLY("DMIC Receiver", SND_SOC_NOPM,
+		0, 0, NULL, 0),
+
+	/* REC Mixer */
+	SND_SOC_DAPM_MIXER("RECMIX", SND_SOC_NOPM, 0, 0,
+		rt286_rec_mix, ARRAY_SIZE(rt286_rec_mix)),
+
+	/* ADCs */
+	SND_SOC_DAPM_ADC("ADC 0", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC 1", NULL, SND_SOC_NOPM, 0, 0),
+
+	/* ADC Mux */
+	SND_SOC_DAPM_MUX_E("ADC 0 Mux", NODE_ID_ADC_IN1, 15, 0,
+		&rt286_adc0_mux, rt286_adc_event, SND_SOC_DAPM_PRE_PMD |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_MUX_E("ADC 1 Mux", NODE_ID_ADC_IN2, 15, 0,
+		&rt286_adc1_mux, rt286_adc_event, SND_SOC_DAPM_PRE_PMD |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_REG),
+
+
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF2RX", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF2TX", "AIF2 Capture", 0, SND_SOC_NOPM, 0, 0),
+
+
+	/* Output Side */
+
+	/* DACs */
+	SND_SOC_DAPM_DAC_E("DAC 0", NULL, NODE_ID_DAC_OUT1,
+			   15, 0, rt286_set_power_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC_E("DAC 1", NULL, NODE_ID_DAC_OUT2,
+			   15, 0, rt286_set_power_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
+	/* Output Mux */
+	SND_SOC_DAPM_MUX_E("SPK Mux", SND_SOC_NOPM, 0, 0,
+			 &rt286_spo_mux,
+			 rt286_out_mux_event,
+			 SND_SOC_DAPM_POST_REG),
+
+	SND_SOC_DAPM_MUX_E("HPO Mux", SND_SOC_NOPM, 0, 0,
+			 &rt286_hpo_mux,
+			 rt286_out_mux_event,
+			 SND_SOC_DAPM_POST_REG),
+
+	SND_SOC_DAPM_SUPPLY("HP Power", SND_SOC_NOPM,
+		0, 0, rt286_hp_pow_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+
+	SND_SOC_DAPM_MUX("SPDIF Mux", SND_SOC_NOPM, 0, 0,
+			 &rt286_spdif_mux),
+
+	/* Output Mixer */
+	SND_SOC_DAPM_MIXER("Front", SND_SOC_NOPM, 0, 0,
+			   rt286_front_mix, ARRAY_SIZE(rt286_front_mix)),
+	SND_SOC_DAPM_PGA("Surround", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Output Pga */
+	SND_SOC_DAPM_PGA_E("SPO", SND_SOC_NOPM, 0, 0,
+		NULL, 0, rt286_spk_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_E("HPO", SND_SOC_NOPM, 0, 0,
+		NULL, 0, rt286_hp_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+
+	/* Output Lines */
+	SND_SOC_DAPM_OUTPUT("SPOL"),
+	SND_SOC_DAPM_OUTPUT("SPOR"),
+	SND_SOC_DAPM_OUTPUT("HPO Pin"),
+	SND_SOC_DAPM_OUTPUT("SPDIF"),
+};
+
+static const struct snd_soc_dapm_route rt286_dapm_routes[] = {
+	{"DMIC1", NULL, "DMIC1 Pin"},
+	{"DMIC2", NULL, "DMIC2 Pin"},
+	{"DMIC1", NULL, "DMIC Receiver"},
+	{"DMIC2", NULL, "DMIC Receiver"},
+
+	{"RECMIX", "Beep Switch", "Beep"},
+	{"RECMIX", "Line1 Switch", "LINE1"},
+	{"RECMIX", "Mic1 Switch", "MIC1"},
+
+	{"ADC 0 Mux", "Dmic", "DMIC1"},
+	{"ADC 0 Mux", "Mic", "MIC1"},
+	{"ADC 1 Mux", "Dmic", "DMIC2"},
+	{"ADC 1 Mux", "Mic", "MIC1"},
+
+	{"ADC 0", NULL, "ADC 0 Mux"},
+	{"ADC 1", NULL, "ADC 1 Mux"},
+
+	{"AIF1TX", NULL, "ADC 0"},
+	{"AIF2TX", NULL, "ADC 1"},
+
+	{"DAC 0", NULL, "AIF1RX"},
+	{"DAC 1", NULL, "AIF2RX"},
+
+	{"Front", "DAC Switch", "DAC 0"},
+	{"Front", "RECMIX Switch", "RECMIX"},
+
+	{"Surround", NULL, "DAC 1"},
+
+	{"SPK Mux", "Front", "Front"},
+	{"SPK Mux", "Surround", "Surround"},
+
+	{"HPO Mux", "Front", "Front"},
+	{"HPO Mux", "Surround", "Surround"},
+
+	{"SPO", NULL, "SPK Mux"},
+	{"HPO", NULL, "HPO Mux"},
+	{"HPO", NULL, "HP Power"},
+
+	{"SPOL", NULL, "SPO"},
+	{"SPOR", NULL, "SPO"},
+	{"HPO Pin", NULL, "HPO"},
+};
+
+static int rt286_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val = 0;
+	int d_len_code;
+
+	switch (params_rate(params)) {
+	/* bit 14 0:48K 1:44.1K */
+	case 44100:
+		val |= 0x4000;
+		break;
+	case 48000:
+		break;
+	default:
+		dev_err(codec->dev, "Unsupported sample rate %d\n",
+					params_rate(params));
+		return -EINVAL;
+	}
+	switch (rt286->sys_clk) {
+	case 12288000:
+	case 24576000:
+		if (params_rate(params) != 48000) {
+			dev_err(codec->dev, "Sys_clk is not matched (%d %d)\n",
+					params_rate(params), rt286->sys_clk);
+			return -EINVAL;
+		}
+		break;
+	case 11289600:
+	case 22579200:
+		if (params_rate(params) != 44100) {
+			dev_err(codec->dev, "Sys_clk is not matched (%d %d)\n",
+					params_rate(params), rt286->sys_clk);
+			return -EINVAL;
+		}
+		break;
+	}
+
+	if (params_channels(params) <= 16) {
+		/* bit 3:0 Number of Channel */
+		val |= (params_channels(params) - 1);
+	} else {
+		dev_err(codec->dev, "Unsupported channels %d\n",
+					params_channels(params));
+		return -EINVAL;
+	}
+
+	d_len_code = 0;
+	switch (params_format(params)) {
+	/* bit 6:4 Bits per Sample */
+	case SNDRV_PCM_FORMAT_S16_LE:
+		d_len_code = 0;
+		val |= (0x1 << 4);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		d_len_code = 2;
+		val |= (0x4 << 4);
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		d_len_code = 1;
+		val |= (0x2 << 4);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		d_len_code = 2;
+		val |= (0x3 << 4);
+		break;
+	case SNDRV_PCM_FORMAT_S8:
+		break;
+	default:
+		return -EINVAL;
+	}
+	rt286_index_update_bits(codec,
+		NODE_ID_VENDOR_REGISTERS, 0x09, 0x0018, d_len_code << 3);
+	pr_debug("format val = 0x%lx\n", val);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		rt286_update_bits(codec, AC_VERB_SET_STREAM_FORMAT,
+			NODE_ID_DAC_OUT1, 0, 0x407f, val);
+	else
+		rt286_update_bits(codec, AC_VERB_SET_STREAM_FORMAT,
+			NODE_ID_ADC_IN1, 0, 0x407f, val);
+
+	return 0;
+}
+
+static int rt286_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x09, 0x0800, 0x800);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x09, 0x0800, 0x0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x09, 0x0300, 0x0);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x09, 0x0300, 0x1 << 8);
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x09, 0x0300, 0x2 << 8);
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x09, 0x0300, 0x3 << 8);
+		break;
+	default:
+		return -EINVAL;
+	}
+	/* bit 15 Stream Type 0:PCM 1:Non-PCM */
+	rt286_update_bits(codec, AC_VERB_SET_STREAM_FORMAT,
+		NODE_ID_DAC_OUT1, 0, 0x8000, 0x0);
+	rt286_update_bits(codec, AC_VERB_SET_STREAM_FORMAT,
+		NODE_ID_ADC_IN1, 0, 0x8000, 0x0);
+
+	return 0;
+}
+
+static int rt286_set_dai_sysclk(struct snd_soc_dai *dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+
+	pr_debug("%s freq=%d\n", __func__, freq);
+
+	if (RT286_SCLK_S_MCLK == clk_id) {
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x0a, 0x0100, 0x0);
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x49, 0x0020, 0x0020);
+	} else {
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x0a, 0x0100, 0x0100);
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x63, 0x4, 0x4);
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x49, 0x20, 0x0);
+	}
+
+	switch (freq) {
+	case 19200000:
+	case 24000000:
+		if (RT286_SCLK_S_MCLK == clk_id) {
+			dev_err(codec->dev, "Should not use MCLK\n");
+			return -EINVAL;
+		}
+		break;
+	case 12288000:
+	case 11289600:
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x0a, 0x8, 0x0);
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x0b, 0xfc1e, 0x0004);
+		break;
+	case 24576000:
+	case 22579200:
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x0a, 0x8, 0x8);
+		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
+			0x0b, 0xfc1e, 0x5406);
+		break;
+	default:
+		dev_err(codec->dev, "Unsupported system clock\n");
+		return -EINVAL;
+	}
+
+	rt286->sys_clk = freq;
+
+	return 0;
+}
+
+static int rt286_set_dai_dfs(struct snd_soc_dai *dai, unsigned int fs)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	pr_debug("%s fs=%d\n", __func__, fs);
+	if (50 == fs)
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x09, 0x1000, 0x1000);
+	else
+		rt286_index_update_bits(codec,
+			NODE_ID_VENDOR_REGISTERS, 0x09, 0x1000, 0x0);
+
+
+	return 0;
+}
+
+static int rt286_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level)
+			rt286_write(codec, AC_VERB_SET_POWER_STATE,
+				NODE_ID_AUDIO_FUNCTION_GROUP, AC_PWRST_D0);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		rt286_write(codec, AC_VERB_SET_POWER_STATE,
+			NODE_ID_AUDIO_FUNCTION_GROUP, AC_PWRST_D3);
+		break;
+
+	default:
+		break;
+	}
+	codec->dapm.bias_level = level;
+
+	return 0;
+}
+
+static int rt286_probe(struct snd_soc_codec *codec)
+{
+	hw_configure(codec);
+	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
+
+	return 0;
+}
+
+static int rt286_remove(struct snd_soc_codec *codec)
+{
+	rt286_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+#define RT286_STEREO_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+#define RT286_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
+
+struct snd_soc_dai_ops rt286_aif_dai_ops = {
+	.hw_params = rt286_hw_params,
+	.set_fmt = rt286_set_dai_fmt,
+	.set_sysclk = rt286_set_dai_sysclk,
+	.set_dfs = rt286_set_dai_dfs,
+};
+
+struct snd_soc_dai_driver rt286_dai[] = {
+	{
+	 .name = "rt286-aif1",
+	 .id = RT286_AIF1,
+	 .playback = {
+		      .stream_name = "AIF1 Playback",
+		      .channels_min = 1,
+		      .channels_max = 2,
+		      .rates = RT286_STEREO_RATES,
+		      .formats = RT286_FORMATS,
+		      },
+	 .capture = {
+		     .stream_name = "AIF1 Capture",
+		     .channels_min = 1,
+		     .channels_max = 2,
+		     .rates = RT286_STEREO_RATES,
+		     .formats = RT286_FORMATS,
+		     },
+	 .ops = &rt286_aif_dai_ops,
+	 },
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_rt286 = {
+	.probe = rt286_probe,
+	.remove = rt286_remove,
+	.set_bias_level = rt286_set_bias_level,
+	.idle_bias_off = true,
+	.controls = rt286_snd_controls,
+	.num_controls = ARRAY_SIZE(rt286_snd_controls),
+	.dapm_widgets = rt286_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt286_dapm_widgets),
+	.dapm_routes = rt286_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt286_dapm_routes),
+};
+
+static const struct regmap_config rt286_regmap = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_write = rt286_hw_write,
+	.reg_read = rt286_hw_read,
+	.readable_reg = rt286_readable_register,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const struct i2c_device_id rt286_i2c_id[] = {
+	{"rt5640", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, rt286_i2c_id);
+
+static struct acpi_device_id rt286_acpi_match[] = {
+	{ "INT33CA", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
+
+static int rt286_i2c_probe(struct i2c_client *i2c,
+			   const struct i2c_device_id *id)
+{
+	struct rt286_platform_data *pdata = dev_get_platdata(&i2c->dev);
+	struct rt286_priv *rt286;
+	struct device *dev = &i2c->dev;
+	int ret;
+
+	rt286 = devm_kzalloc(&i2c->dev,
+				sizeof(struct rt286_priv),
+				GFP_KERNEL);
+	if (NULL == rt286)
+		return -ENOMEM;
+
+	rt286->regmap = devm_regmap_init(dev, NULL, i2c, &rt286_regmap);
+	if (IS_ERR(rt286->regmap)) {
+		ret = PTR_ERR(rt286->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(i2c, rt286);
+
+	if (pdata)
+		rt286->pdata = *pdata;
+
+	ret = devm_snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt286,
+				     rt286_dai, ARRAY_SIZE(rt286_dai));
+	if (ret < 0)
+		goto err;
+
+	return 0;
+err:
+	return ret;
+}
+
+static int rt286_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+
+	return 0;
+}
+
+struct i2c_driver rt286_i2c_driver = {
+	.driver = {
+		   .name = "rt5640",
+		   .owner = THIS_MODULE,
+		   .acpi_match_table = ACPI_PTR(rt286_acpi_match),
+		   },
+	.probe = rt286_i2c_probe,
+	.remove = rt286_i2c_remove,
+	.id_table = rt286_i2c_id,
+};
+
+static int __init rt286_modinit(void)
+{
+	return i2c_add_driver(&rt286_i2c_driver);
+}
+
+module_init(rt286_modinit);
+
+static void __exit rt286_modexit(void)
+{
+	i2c_del_driver(&rt286_i2c_driver);
+}
+
+module_exit(rt286_modexit);
+
+MODULE_DESCRIPTION("ASoC RT286 driver");
+MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/rt286.h b/sound/soc/codecs/rt286.h
new file mode 100644
index 0000000..c579c53
--- /dev/null
+++ b/sound/soc/codecs/rt286.h
@@ -0,0 +1,89 @@
+/*
+ * rt286.h  --  RT286 ALSA SoC audio driver
+ *
+ * Copyright 2011 Realtek Microelectronics
+ * Author: Johnny Hsu <johnnyhsu@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __RT286_H__
+#define __RT286_H__
+
+#define NODE_ID_AUDIO_FUNCTION_GROUP			0x01
+#define NODE_ID_DAC_OUT1				0x02
+#define NODE_ID_DAC_OUT2				0x03
+#define NODE_ID_ADC_IN1					0x09
+#define NODE_ID_ADC_IN2					0x08
+#define NODE_ID_MIXER_IN				0x0b
+#define NODE_ID_MIXER_OUT1				0x0c
+#define NODE_ID_MIXER_OUT2				0x0d
+#define NODE_ID_DMIC1					0x12
+#define NODE_ID_DMIC2					0x13
+#define NODE_ID_SPK_OUT					0x14
+#define NODE_ID_MIC1					0x18
+#define NODE_ID_LINE1					0x1a
+#define NODE_ID_BEEP					0x1d
+#define NODE_ID_SPDIF					0x1e
+#define NODE_ID_VENDOR_REGISTERS			0x20
+#define NODE_ID_HP_OUT					0x21
+#define NODE_ID_MIXER_IN1				0x22
+#define NODE_ID_MIXER_IN2				0x23
+#define TOTAL_NODE_ID					0x23
+
+#define CONNECTION_INDEX_MIC1				0X0
+#define CONNECTION_INDEX_DMIC				0X5
+
+/* SPDIF (0x06) */
+#define RT286_SPDIF_SEL_SFT	0
+#define RT286_SPDIF_SEL_PCM0	0
+#define RT286_SPDIF_SEL_PCM1	1
+#define RT286_SPDIF_SEL_SPOUT	2
+#define RT286_SPDIF_SEL_PP	3
+
+/* RECMIX (0x0b) */
+#define RT286_M_REC_BEEP_SFT	0
+#define RT286_M_REC_LINE1_SFT	1
+#define RT286_M_REC_MIC1_SFT	2
+#define RT286_M_REC_I2S_SFT	3
+
+/* Front (0x0c) */
+#define RT286_M_FRONT_DAC_SFT	0
+#define RT286_M_FRONT_REC_SFT	1
+
+/* SPK-OUT (0x14) */
+#define RT286_SPK_SEL_MASK	0x1
+#define RT286_SPK_SEL_SFT	0
+#define RT286_SPK_SEL_F		0
+#define RT286_SPK_SEL_S		1
+
+/* HP-OUT (0x21) */
+#define RT286_HP_SEL_MASK	0x1
+#define RT286_HP_SEL_SFT	0
+#define RT286_HP_SEL_F		0
+#define RT286_HP_SEL_S		1
+
+/* ADC (0x22) (0x23) */
+#define RT286_ADC_SEL_MASK	0x7
+#define RT286_ADC_SEL_SFT	0
+#define RT286_ADC_SEL_SURR	0
+#define RT286_ADC_SEL_FRONT	1
+#define RT286_ADC_SEL_DMIC	2
+#define RT286_ADC_SEL_BEEP	4
+#define RT286_ADC_SEL_LINE1	5
+#define RT286_ADC_SEL_I2S	6
+#define RT286_ADC_SEL_MIC1	7
+
+#define RT286_SCLK_S_MCLK	0
+#define RT286_SCLK_S_PLL	1
+
+enum {
+	RT286_AIF1,
+	RT286_AIFS,
+};
+
+int rt286_jack_detect(struct snd_soc_codec *codec, bool *hp, bool *mic);
+
+#endif /* __RT286_H__ */
-- 
1.8.1.1.439.g50a6b54
