From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Support DSP function for VAD
	application
Date: Mon, 1 Sep 2014 20:27:47 +0800
Message-ID: <1409574467-12465-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AA075262629
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:28:24 +0200 (CEST)
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

The ALC5677 has a programmable DSP, and there is a SPI that is dadicated for DSP
firmware loading. Therefore, the patch includes a SPI driver for writing the DSP
firmware. The VAD(Voice Activaty Detection) has be implemented and use the DSP to
recognize the key phase.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/Makefile     |   2 +-
 sound/soc/codecs/rt5677-spi.c | 129 +++++++++++++++++++
 sound/soc/codecs/rt5677-spi.h |  21 ++++
 sound/soc/codecs/rt5677.c     | 286 +++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5677.h     |   6 +
 5 files changed, 439 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/codecs/rt5677-spi.c
 create mode 100644 sound/soc/codecs/rt5677-spi.h

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 20afe0f..0c6e080 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -75,7 +75,7 @@ snd-soc-rt5640-objs := rt5640.o
 snd-soc-rt5645-objs := rt5645.o
 snd-soc-rt5651-objs := rt5651.o
 snd-soc-rt5670-objs := rt5670.o
-snd-soc-rt5677-objs := rt5677.o
+snd-soc-rt5677-objs := rt5677.o rt5677-spi.o
 snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
 snd-soc-alc5632-objs := alc5632.o
diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
new file mode 100644
index 0000000..805db12
--- /dev/null
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -0,0 +1,129 @@
+/*
+ * rt5677-spi.c  --  RT5677 ALSA SoC audio codec driver
+ *
+ * Copyright 2013 Realtek Semiconductor Corp.
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/spi/spi.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_qos.h>
+#include <linux/sysfs.h>
+#include <linux/clk.h>
+#include <linux/firmware.h>
+
+#include "rt5677-spi.h"
+
+static struct spi_device *g_spi;
+
+/**
+ * rt5677_spi_write - Write data to SPI.
+ * @txbuf: Data Buffer for writing.
+ * @len: Data length.
+ *
+ *
+ * Returns true for success.
+ */
+int rt5677_spi_write(u8 *txbuf, size_t len)
+{
+	int status;
+
+	status = spi_write(g_spi, txbuf, len);
+
+	if (status)
+		dev_err(&g_spi->dev, "rt5677_spi_write error %d\n", status);
+
+	return status;
+}
+
+/**
+ * rt5677_spi_burst_write - Write data to SPI by rt5677 dsp memory address.
+ * @addr: Start address.
+ * @txbuf: Data Buffer for writng.
+ * @len: Data length, it must be a multiple of 8.
+ *
+ *
+ * Returns true for success.
+ */
+int rt5677_spi_burst_write(u32 addr, const struct firmware *fw)
+{
+	u8 spi_cmd = RT5677_SPI_CMD_BURST_WRITE;
+	u8 *write_buf;
+	unsigned int i, end, offset = 0;
+
+	write_buf = kmalloc(RT5677_SPI_BUF_LEN + 6, GFP_KERNEL);
+
+	if (write_buf == NULL)
+		return -ENOMEM;
+
+	while (offset < fw->size) {
+		if (offset + RT5677_SPI_BUF_LEN <= fw->size)
+			end = RT5677_SPI_BUF_LEN;
+		else
+			end = fw->size % RT5677_SPI_BUF_LEN;
+
+		write_buf[0] = spi_cmd;
+		write_buf[1] = ((addr + offset) & 0xff000000) >> 24;
+		write_buf[2] = ((addr + offset) & 0x00ff0000) >> 16;
+		write_buf[3] = ((addr + offset) & 0x0000ff00) >> 8;
+		write_buf[4] = ((addr + offset) & 0x000000ff) >> 0;
+
+		for (i = 0; i < end; i += 8) {
+			write_buf[i + 12] = fw->data[offset + i + 0];
+			write_buf[i + 11] = fw->data[offset + i + 1];
+			write_buf[i + 10] = fw->data[offset + i + 2];
+			write_buf[i +  9] = fw->data[offset + i + 3];
+			write_buf[i +  8] = fw->data[offset + i + 4];
+			write_buf[i +  7] = fw->data[offset + i + 5];
+			write_buf[i +  6] = fw->data[offset + i + 6];
+			write_buf[i +  5] = fw->data[offset + i + 7];
+		}
+
+		write_buf[end + 5] = spi_cmd;
+
+		rt5677_spi_write(write_buf, end + 6);
+
+		offset += RT5677_SPI_BUF_LEN;
+	}
+
+	kfree(write_buf);
+
+	return 0;
+}
+
+static int rt5677_spi_probe(struct spi_device *spi)
+{
+	g_spi = spi;
+	return 0;
+}
+
+static struct spi_driver rt5677_spi_driver = {
+	.driver = {
+			.name = "rt5677_spidev",
+			.bus = &spi_bus_type,
+			.owner = THIS_MODULE,
+	},
+	.probe = rt5677_spi_probe,
+};
+module_spi_driver(rt5677_spi_driver);
+
+MODULE_DESCRIPTION("ASoC RT5677 SPI driver");
+MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rt5677-spi.h b/sound/soc/codecs/rt5677-spi.h
new file mode 100644
index 0000000..7528bfd
--- /dev/null
+++ b/sound/soc/codecs/rt5677-spi.h
@@ -0,0 +1,21 @@
+/*
+ * rt5677-spi.h  --  RT5677 ALSA SoC audio codec driver
+ *
+ * Copyright 2013 Realtek Semiconductor Corp.
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __RT5671_SPI_H__
+#define __RT5671_SPI_H__
+
+#define RT5677_SPI_BUF_LEN 240
+#define RT5677_SPI_CMD_BURST_WRITE 0x05
+
+int rt5677_spi_write(u8 *txbuf, size_t len);
+int rt5677_spi_burst_write(u32 addr, const struct firmware *fw);
+
+#endif /* __RT5677_SPI_H__ */
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f0b751b..1a6a749 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/firmware.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -29,6 +30,7 @@
 
 #include "rl6231.h"
 #include "rt5677.h"
+#include "rt5677-spi.h"
 
 #define RT5677_DEVICE_ID 0x6327
 
@@ -535,6 +537,243 @@ static bool rt5677_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
+/**
+ * rt5677_dsp_mode_i2c_write_addr - Write value to address on DSP mode.
+ * @codec: SoC audio codec device.
+ * @addr: Address index.
+ * @value: Address data.
+ *
+ *
+ * Returns 0 for success or negative error code.
+ */
+static int rt5677_dsp_mode_i2c_write_addr(struct snd_soc_codec *codec,
+		unsigned int addr, unsigned int value, unsigned int opcode)
+{
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&rt5677->dsp_cmd_lock);
+
+	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_ADDR_MSB, addr >> 16);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set addr msb value: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_ADDR_LSB,
+		addr & 0xffff);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set addr lsb value: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_DATA_MSB,
+		value >> 16);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set data msb value: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_DATA_LSB,
+		value & 0xffff);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set data lsb value: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_OP_CODE, opcode);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set op code value: %d\n", ret);
+		goto err;
+	}
+
+err:
+	mutex_unlock(&rt5677->dsp_cmd_lock);
+
+	return ret;
+}
+
+/**
+ * rt5677_dsp_mode_i2c_read_addr - Read value from address on DSP mode.
+ * @codec: SoC audio codec device.
+ * @addr: Address index.
+ * @value: Address data.
+ *
+ * Returns 0 for success or negative error code.
+ */
+static int rt5677_dsp_mode_i2c_read_addr(
+	struct snd_soc_codec *codec, unsigned int addr, unsigned int *value)
+{
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+	unsigned int msb, lsb;
+
+	mutex_lock(&rt5677->dsp_cmd_lock);
+
+	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_ADDR_MSB, addr >> 16);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set addr msb value: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_ADDR_LSB,
+		addr & 0xffff);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set addr lsb value: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_OP_CODE , 0x0002);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set op code value: %d\n", ret);
+		goto err;
+	}
+
+	regmap_read(rt5677->regmap, RT5677_DSP_I2C_DATA_MSB, &msb);
+	regmap_read(rt5677->regmap, RT5677_DSP_I2C_DATA_LSB, &lsb);
+	*value = (msb << 16) | lsb;
+
+err:
+	mutex_unlock(&rt5677->dsp_cmd_lock);
+
+	return ret;
+}
+
+/**
+ * rt5677_dsp_mode_i2c_write - Write register on DSP mode.
+ * @codec: SoC audio codec device.
+ * @reg: Register index.
+ * @value: Register data.
+ *
+ *
+ * Returns 0 for success or negative error code.
+ */
+static int rt5677_dsp_mode_i2c_write(struct snd_soc_codec *codec,
+		unsigned int reg, unsigned int value)
+{
+	return rt5677_dsp_mode_i2c_write_addr(codec, 0x18020000 + reg * 2,
+		value, 0x0001);
+}
+
+/**
+ * rt5677_dsp_mode_i2c_read - Read register on DSP mode.
+ * @codec: SoC audio codec device.
+ * @reg: Register index.
+ *
+ *
+ * Returns Register value.
+ */
+static unsigned int rt5677_dsp_mode_i2c_read(
+	struct snd_soc_codec *codec, unsigned int reg)
+{
+	unsigned int value = 0;
+
+	rt5677_dsp_mode_i2c_read_addr(codec, 0x18020000 + reg * 2, &value);
+
+	return value;
+}
+
+/**
+ * rt5677_dsp_mode_i2c_update_bits - update register on DSP mode.
+ * @codec: audio codec
+ * @reg: register index.
+ * @mask: register mask
+ * @value: new value
+ *
+ *
+ * Returns 1 for change, 0 for no change, or negative error code.
+ */
+static int rt5677_dsp_mode_i2c_update_bits(struct snd_soc_codec *codec,
+	unsigned int reg, unsigned int mask, unsigned int value)
+{
+	unsigned int old, new;
+	int change, ret;
+
+	ret = rt5677_dsp_mode_i2c_read(codec, reg);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to read reg: %d\n", ret);
+		goto err;
+	}
+
+	old = ret;
+	new = (old & ~mask) | (value & mask);
+	change = old != new;
+	if (change) {
+		ret = rt5677_dsp_mode_i2c_write(codec, reg, new);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to write reg: %d\n", ret);
+			goto err;
+		}
+	}
+	return change;
+
+err:
+	return ret;
+}
+
+static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
+{
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	static bool activity;
+	int ret;
+
+	if (on && !activity) {
+		activity = true;
+
+		regcache_cache_only(rt5677->regmap, false);
+		regcache_cache_bypass(rt5677->regmap, true);
+
+		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x1, 0x1);
+		regmap_update_bits(rt5677->regmap,
+			RT5677_PR_BASE + RT5677_BIAS_CUR4, 0x0f00, 0x0f00);
+		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
+			RT5677_LDO1_SEL_MASK, 0x0);
+		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
+			RT5677_PWR_LDO1, RT5677_PWR_LDO1);
+		regmap_write(rt5677->regmap, RT5677_GLB_CLK2, 0x0080);
+		regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x07ff);
+		regmap_write(rt5677->regmap, RT5677_PWR_DSP1, 0x07ff);
+
+		ret = request_firmware(&rt5677->fw1, RT5677_FIRMWARE1,
+			codec->dev);
+		if (ret == 0) {
+			rt5677_spi_burst_write(0x50000000, rt5677->fw1);
+			release_firmware(rt5677->fw1);
+		}
+
+		ret = request_firmware(&rt5677->fw2, RT5677_FIRMWARE2,
+			codec->dev);
+		if (ret == 0) {
+			rt5677_spi_burst_write(0x60000000, rt5677->fw2);
+			release_firmware(rt5677->fw2);
+		}
+
+		rt5677_dsp_mode_i2c_update_bits(codec, RT5677_PWR_DSP1, 0x1,
+			0x0);
+
+		regcache_cache_bypass(rt5677->regmap, false);
+		regcache_cache_only(rt5677->regmap, true);
+	} else if (!on && activity) {
+		activity = false;
+
+		regcache_cache_only(rt5677->regmap, false);
+		regcache_cache_bypass(rt5677->regmap, true);
+
+		rt5677_dsp_mode_i2c_update_bits(codec, RT5677_PWR_DSP1, 0x1,
+			0x1);
+		rt5677_dsp_mode_i2c_write(codec, RT5677_PWR_DSP1, 0x0001);
+
+		regmap_write(rt5677->regmap, RT5677_RESET, 0x10ec);
+
+		regcache_cache_bypass(rt5677->regmap, false);
+		regcache_mark_dirty(rt5677->regmap);
+		regcache_sync(rt5677->regmap);
+	}
+
+	return 0;
+}
+
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
@@ -553,6 +792,31 @@ static unsigned int bst_tlv[] = {
 	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
 };
 
+static int rt5677_dsp_vad_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = rt5677->dsp_vad_en;
+
+	return 0;
+}
+
+static int rt5677_dsp_vad_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+
+	rt5677->dsp_vad_en = !!ucontrol->value.integer.value[0];
+
+	if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+		rt5677_set_dsp_vad(codec, rt5677->dsp_vad_en);
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 	/* OUTPUT Control */
 	SOC_SINGLE("OUT1 Playback Switch", RT5677_LOUT1,
@@ -620,6 +884,9 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 	SOC_DOUBLE_TLV("Mono ADC Boost Volume", RT5677_ADC_BST_CTRL2,
 		RT5677_MONO_ADC_L_BST_SFT, RT5677_MONO_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
+
+	SOC_SINGLE_EXT("DSP VAD Switch", SND_SOC_NOPM, 0, 1, 0,
+		rt5677_dsp_vad_get, rt5677_dsp_vad_put),
 };
 
 /**
@@ -3117,6 +3384,8 @@ static int rt5677_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+			rt5677_set_dsp_vad(codec, false);
+
 			regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
 				RT5677_LDO1_SEL_MASK | RT5677_LDO2_SEL_MASK,
 				0x0055);
@@ -3150,6 +3419,9 @@ static int rt5677_set_bias_level(struct snd_soc_codec *codec,
 		regmap_write(rt5677->regmap, RT5677_PWR_ANLG2, 0x0000);
 		regmap_update_bits(rt5677->regmap,
 			RT5677_PR_BASE + RT5677_BIAS_CUR4, 0x0f00, 0x0000);
+
+		if (rt5677->dsp_vad_en)
+			rt5677_set_dsp_vad(codec, true);
 		break;
 
 	default:
@@ -3181,6 +3453,8 @@ static int rt5677_probe(struct snd_soc_codec *codec)
 	regmap_write(rt5677->regmap, RT5677_DIG_MISC, 0x0020);
 	regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x0c00);
 
+	mutex_init(&rt5677->dsp_cmd_lock);
+
 	return 0;
 }
 
@@ -3198,8 +3472,10 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 {
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
-	regcache_cache_only(rt5677->regmap, true);
-	regcache_mark_dirty(rt5677->regmap);
+	if (!rt5677->dsp_vad_en) {
+		regcache_cache_only(rt5677->regmap, true);
+		regcache_mark_dirty(rt5677->regmap);
+	}
 
 	return 0;
 }
@@ -3208,8 +3484,10 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 {
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
-	regcache_cache_only(rt5677->regmap, false);
-	regcache_sync(rt5677->regmap);
+	if (!rt5677->dsp_vad_en) {
+		regcache_cache_only(rt5677->regmap, false);
+		regcache_sync(rt5677->regmap);
+	}
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 8791ab9..833c66d 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1403,6 +1403,9 @@
 #define RT5677_GPIO5_FUNC_GPIO			(0x0 << 9)
 #define RT5677_GPIO5_FUNC_DMIC			(0x1 << 9)
 
+#define RT5677_FIRMWARE1	"rt5677_dsp_fw1.bin"
+#define RT5677_FIRMWARE2	"rt5677_dsp_fw2.bin"
+
 /* System Clock Source */
 enum {
 	RT5677_SCLK_S_MCLK,
@@ -1432,6 +1435,8 @@ struct rt5677_priv {
 	struct snd_soc_codec *codec;
 	struct rt5677_platform_data pdata;
 	struct regmap *regmap;
+	const struct firmware *fw1, *fw2;
+	struct mutex dsp_cmd_lock;
 
 	int sysclk;
 	int sysclk_src;
@@ -1441,6 +1446,7 @@ struct rt5677_priv {
 	int pll_src;
 	int pll_in;
 	int pll_out;
+	bool dsp_vad_en;
 };
 
 #endif /* __RT5677_H__ */
-- 
1.8.1.1.439.g50a6b54
