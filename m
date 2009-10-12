From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: Codec driver for Texas Instruments
	tlv320dac33 codec
Date: Mon, 12 Oct 2009 14:48:58 +0300
Message-ID: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 06FAC103884
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 13:49:30 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Driver for Texas Instruments TLV320DAC33 (SLAS546) low power stereo
audio DAC.

TLV320DAC33 is a stereo audio codec with integrated 24KB FIFO for low
power audio playback.

The digital interface can use I2S, DSP (A or B), Right and Left
justified formats.
DAC33 has stereo analog input, which can be bypassed to the analog
outputs.

Regarding to the internal 24KB FIFO the driver implements 'FIFO bypass'
mode (default) and nSample mode (FIFO is in use).
a) In 'FIFO bypass' mode the internal FIFO is not in use, the codec is
working synchronously as a normal codec (it needs constant stream of
data on the digital interface).

b) The nSample mode implementation uses one interrupt line from DAC33 to
the host:
Alarm threshold is set to 10ms of audio data (limit by the driver
implementation).
DAC33 will signal an interrupt, when the FIFO level goes under the
Alarm threshold.
The host will write to nSample register a value (number of stereo
samples), to tell DAC33 how many samples it should read in a burst from
the host. When the DAC33 received the number of samples, it disables the
clocks on the I2S bus. When the FIFO use again goes under the Alarm
threshold, DAC33 signals the host with an interrupt, and the process is
repeated.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/tlv320dac33-plat.h |   20 +
 sound/soc/codecs/Kconfig         |    4 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/tlv320dac33.c   | 1178 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320dac33.h   |  267 +++++++++
 5 files changed, 1471 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/tlv320dac33-plat.h
 create mode 100644 sound/soc/codecs/tlv320dac33.c
 create mode 100644 sound/soc/codecs/tlv320dac33.h

diff --git a/include/sound/tlv320dac33-plat.h b/include/sound/tlv320dac33-plat.h
new file mode 100644
index 0000000..5858d06
--- /dev/null
+++ b/include/sound/tlv320dac33-plat.h
@@ -0,0 +1,20 @@
+/*
+ * Platform header for Texas Instruments TLV320DAC33 codec driver
+ *
+ * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *
+ * Copyright:   (C) 2009 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __TLV320DAC33_PLAT_H
+#define __TLV320DAC33_PLAT_H
+
+struct tlv320dac33_platform_data {
+	int power_gpio;
+};
+
+#endif /* __TLV320DAC33_PLAT_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index fab01c9..49bab93 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -29,6 +29,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC3X if I2C
+	select SND_SOC_TLV320DAC33 if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
 	select SND_SOC_UDA134X
@@ -142,6 +143,9 @@ config SND_SOC_TLV320AIC26
 config SND_SOC_TLV320AIC3X
 	tristate
 
+config SND_SOC_TLV320DAC33
+	tristate
+
 config SND_SOC_TWL4030
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2f14391..8f519ee 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -17,6 +17,7 @@ snd-soc-stac9766-objs := stac9766.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
+snd-soc-tlv320dac33-objs := tlv320dac33.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
@@ -70,6 +71,7 @@ obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
+obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
new file mode 100644
index 0000000..6170b5d
--- /dev/null
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -0,0 +1,1178 @@
+/*
+ * ALSA SoC Texas Instruments TLV320DAC33 codec driver
+ *
+ * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *
+ * Copyright:   (C) 2009 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include <sound/tlv320dac33-plat.h>
+#include "tlv320dac33.h"
+
+#define DAC33_BUFFER_SIZE_BYTES		24576	/* bytes, 12288 16 bit words,
+						 * 6144 stereo */
+#define DAC33_BUFFER_SIZE_SAMPLES	6144
+
+#define NSAMPLE_MAX		5700
+
+#define LATENCY_TIME_MS		20
+
+static struct i2c_client *tlv320dac33_client;
+static struct snd_soc_codec *tlv320dac33_codec;
+
+enum dac33_state {
+	DAC33_IDLE = 0,
+	DAC33_PREFILL,
+	DAC33_PLAYBACK,
+	DAC33_FLUSH,
+};
+
+struct tlv320dac33_priv {
+	struct mutex mutex;
+	struct work_struct work;
+	struct snd_soc_codec codec;
+	int power_gpio;
+	int power_state;
+	int irq;
+	unsigned int refclk;
+
+	unsigned int alarm_threshold;	/* set to be half of LATENCY_TIME_MS */
+	unsigned int nsample_min;	/* nsample should not be lower than
+					 * this */
+	unsigned int nsample_max;	/* nsample should not be higher than
+					 * this */
+	unsigned int nsample_switch;	/* Use FIFO or bypass FIFO switch */
+	unsigned int nsmaple_cmode;	/* Currently used nsample mode */
+	unsigned int nsample;		/* burst read amount from host */
+
+	enum dac33_state state;
+};
+
+static struct workqueue_struct *dac33_wq;
+
+static const u8 dac33_reg[DAC33_CACHEREGNUM] = {
+0x00, 0x00, 0x00, 0x00, /* 0x00 - 0x03 */
+0x00, 0x00, 0x00, 0x00, /* 0x04 - 0x07 */
+0x00, 0x00, 0x00, 0x00, /* 0x08 - 0x0b */
+0x00, 0x00, 0x00, 0x00, /* 0x0c - 0x0f */
+0x00, 0x00, 0x00, 0x00, /* 0x10 - 0x13 */
+0x00, 0x00, 0x00, 0x00, /* 0x14 - 0x17 */
+0x00, 0x00, 0x00, 0x00, /* 0x18 - 0x1b */
+0x00, 0x00, 0x00, 0x00, /* 0x1c - 0x1f */
+0x00, 0x00, 0x00, 0x00, /* 0x20 - 0x23 */
+0x00, 0x00, 0x00, 0x00, /* 0x24 - 0x27 */
+0x00, 0x00, 0x00, 0x00, /* 0x28 - 0x2b */
+0x00, 0x00, 0x00, 0x80, /* 0x2c - 0x2f */
+0x80, 0x00, 0x00, 0x00, /* 0x30 - 0x33 */
+0x00, 0x00, 0x00, 0x00, /* 0x34 - 0x37 */
+0x00, 0x00,             /* 0x38 - 0x39 */
+/* Registers 0x3a - 0x3f are reserved  */
+            0x00, 0x00, /* 0x3a - 0x3b */
+0x00, 0x00, 0x00, 0x00, /* 0x3c - 0x3f */
+
+0x00, 0x00, 0x00, 0x00, /* 0x40 - 0x43 */
+0x00, 0x80,             /* 0x44 - 0x45 */
+/* Registers 0x46 - 0x47 are reserved  */
+            0x80, 0x80, /* 0x46 - 0x47 */
+
+0x80, 0x00, 0x00,       /* 0x48 - 0x4a */
+/* Registers 0x4b - 0x7c are reserved  */
+                  0x00, /* 0x4b        */
+0x00, 0x00, 0x00, 0x00, /* 0x4c - 0x4f */
+0x00, 0x00, 0x00, 0x00, /* 0x50 - 0x53 */
+0x00, 0x00, 0x00, 0x00, /* 0x54 - 0x57 */
+0x00, 0x00, 0x00, 0x00, /* 0x58 - 0x5b */
+0x00, 0x00, 0x00, 0x00, /* 0x5c - 0x5f */
+0x00, 0x00, 0x00, 0x00, /* 0x60 - 0x63 */
+0x00, 0x00, 0x00, 0x00, /* 0x64 - 0x67 */
+0x00, 0x00, 0x00, 0x00, /* 0x68 - 0x6b */
+0x00, 0x00, 0x00, 0x00, /* 0x6c - 0x6f */
+0x00, 0x00, 0x00, 0x00, /* 0x70 - 0x73 */
+0x00, 0x00, 0x00, 0x00, /* 0x74 - 0x77 */
+0x00, 0x00, 0x00, 0x00, /* 0x78 - 0x7b */
+0x00,                   /* 0x7c        */
+
+      0xda, 0x33, 0x03, /* 0x7d - 0x7f */
+};
+
+/* Register read and write */
+static inline unsigned int dac33_read_reg_cache(struct snd_soc_codec *codec,
+						unsigned reg)
+{
+	u8 *cache = codec->reg_cache;
+	if (reg >= DAC33_CACHEREGNUM)
+		return 0;
+
+	return cache[reg];
+}
+
+static inline void dac33_write_reg_cache(struct snd_soc_codec *codec,
+					 u8 reg, u8 value)
+{
+	u8 *cache = codec->reg_cache;
+	if (reg >= DAC33_CACHEREGNUM)
+		return;
+
+	cache[reg] = value;
+}
+
+static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
+		      u8 *value)
+{
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	int val;
+
+	*value = reg & 0xff;
+
+	/* If powered off, return the cached value */
+	mutex_lock(&dac33->mutex);
+	if (dac33->power_state) {
+		val = i2c_smbus_read_byte_data(codec->control_data, value[0]);
+		if (val < 0) {
+			dev_err(codec->dev, "Read failed\n");
+			value[0] = dac33_read_reg_cache(codec, reg);
+		} else {
+			value[0] = val;
+			dac33_write_reg_cache(codec, reg, val);
+		}
+
+	} else {
+		value[0] = dac33_read_reg_cache(codec, reg);
+	}
+	mutex_unlock(&dac33->mutex);
+
+	return 0;
+}
+
+static int dac33_write(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value)
+{
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	u8 data[2];
+	int ret = 0;
+
+	/*
+	 * data is
+	 *   D15..D8 dac33 register offset
+	 *   D7...D0 register data
+	 */
+	data[0] = reg & 0xff;
+	data[1] = value & 0xff;
+
+	dac33_write_reg_cache(codec, data[0], data[1]);
+	mutex_lock(&dac33->mutex);
+	if (dac33->power_state) {
+		if (codec->hw_write(codec->control_data, data, 2) != 2) {
+			dev_err(codec->dev, "Write failed\n");
+			ret = -EIO;
+		}
+	}
+	mutex_unlock(&dac33->mutex);
+
+	return ret;
+}
+
+#define DAC33_I2C_ADDR_AUTOINC	0x80
+static int dac33_write16(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value)
+{
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	u8 data[3];
+	int ret = 0;
+
+	/*
+	 * data is
+	 *   D23..D16 dac33 register offset
+	 *   D15..D8  register data MSB
+	 *   D7...D0  register data LSB
+	 */
+	data[0] = reg & 0xff;
+	data[1] = (value >> 8) & 0xff;
+	data[2] = value & 0xff;
+
+	dac33_write_reg_cache(codec, data[0], data[1]);
+	dac33_write_reg_cache(codec, data[0] + 1, data[2]);
+
+	mutex_lock(&dac33->mutex);
+	if (dac33->power_state) {
+		/* We need to set autoincrement mode for 16 bit writes */
+		data[0] |= DAC33_I2C_ADDR_AUTOINC;
+		if (codec->hw_write(codec->control_data, data, 3) != 3)
+			ret = -EIO;
+	}
+	mutex_unlock(&dac33->mutex);
+
+	return ret;
+}
+
+static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
+{
+	u8 reg;
+
+	reg = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
+	if (power)
+		reg |= PDNALLB;
+	else
+		reg &= ~PDNALLB;
+	dac33_write(codec, DAC33_PWR_CTRL, reg);
+}
+
+static void dac33_set_power(struct snd_soc_codec *codec, int power)
+{
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+
+	if (power) {
+		if (dac33->power_gpio >= 0) {
+			mutex_lock(&dac33->mutex);
+			gpio_set_value(dac33->power_gpio, 1);
+			dac33->power_state = 1;
+			mutex_unlock(&dac33->mutex);
+		}
+		dac33_soft_power(codec, 1);
+	} else {
+		dac33_soft_power(codec, 0);
+		if (dac33->power_gpio >= 0) {
+			mutex_lock(&dac33->mutex);
+			gpio_set_value(dac33->power_gpio, 0);
+			dac33->power_state = 0;
+			mutex_unlock(&dac33->mutex);
+		}
+	}
+
+}
+
+static int dac33_get_nsample(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+
+	ucontrol->value.integer.value[0] = dac33->nsample;
+
+	return 0;
+}
+
+static int dac33_set_nsample(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	int ret = -EINVAL;
+
+	if (dac33->nsample == ucontrol->value.integer.value[0])
+		return 0;
+	if (ucontrol->value.integer.value[0] < dac33->nsample_min)
+		dac33->nsample = dac33->nsample_min;
+	else if (ucontrol->value.integer.value[0] > dac33->nsample_max)
+		dac33->nsample = dac33->nsample_max;
+	else {
+		dac33->nsample = ucontrol->value.integer.value[0];
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int dac33_get_nsample_switch(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+
+	ucontrol->value.integer.value[0] = dac33->nsample_switch;
+
+	return 0;
+}
+
+static int dac33_set_nsample_switch(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	int ret = -EINVAL;
+
+	if (dac33->nsample_switch == ucontrol->value.integer.value[0])
+		return 0;
+	if (ucontrol->value.integer.value[0] < 0)
+		dac33->nsample_switch = 0;
+	else if (ucontrol->value.integer.value[0] > 1)
+		dac33->nsample_switch = 1;
+	else {
+		dac33->nsample_switch = ucontrol->value.integer.value[0];
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * DACL/R digital volume control:
+ * from 0 dB to -63.5 in 0.5 dB steps
+ * Need to be inverted later on:
+ * 0x00 == 0 dB
+ * 0x7f == -63.5 dB
+ */
+static DECLARE_TLV_DB_SCALE(dac_digivol_tlv, -6350, 50, 0);
+
+static const struct snd_kcontrol_new dac33_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("DAC Digital Playback Volume",
+		DAC33_LDAC_DIG_VOL_CTRL, DAC33_RDAC_DIG_VOL_CTRL,
+		0, 0x7f, 1, dac_digivol_tlv),
+	SOC_DOUBLE_R("DAC Digital Playback Switch",
+		 DAC33_LDAC_DIG_VOL_CTRL, DAC33_RDAC_DIG_VOL_CTRL, 7, 1, 1),
+	SOC_DOUBLE_R("Line to Line Out Volume",
+		 DAC33_LINEL_TO_LLO_VOL, DAC33_LINER_TO_RLO_VOL, 0, 127, 1),
+	SOC_SINGLE_EXT("nSample", 0, 0, 5900, 0,
+		 dac33_get_nsample, dac33_set_nsample),
+	SOC_SINGLE_EXT("nSample Switch", 0, 0, 1, 0,
+		 dac33_get_nsample_switch, dac33_set_nsample_switch),
+};
+
+/* Analog bypass */
+static const struct snd_kcontrol_new dac33_dapm_abypassl_control =
+	SOC_DAPM_SINGLE("Switch", DAC33_LINEL_TO_LLO_VOL, 7, 1, 1);
+
+static const struct snd_kcontrol_new dac33_dapm_abypassr_control =
+	SOC_DAPM_SINGLE("Switch", DAC33_LINER_TO_RLO_VOL, 7, 1, 1);
+
+static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("LEFT_LO"),
+	SND_SOC_DAPM_OUTPUT("RIGHT_LO"),
+
+	SND_SOC_DAPM_INPUT("LINEL"),
+	SND_SOC_DAPM_INPUT("LINER"),
+
+	SND_SOC_DAPM_DAC("DACL", "Left Playback", DAC33_LDAC_PWR_CTRL, 2, 0),
+	SND_SOC_DAPM_DAC("DACR", "Right Playback", DAC33_RDAC_PWR_CTRL, 2, 0),
+
+	/* Analog bypass */
+	SND_SOC_DAPM_SWITCH("Analog Left Bypass", SND_SOC_NOPM, 0, 0,
+				&dac33_dapm_abypassl_control),
+	SND_SOC_DAPM_SWITCH("Analog Right Bypass", SND_SOC_NOPM, 0, 0,
+				&dac33_dapm_abypassr_control),
+
+	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Left Amp Power",
+			 DAC33_OUT_AMP_PWR_CTRL, 6, 3, 3, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Right Amp Power",
+			 DAC33_OUT_AMP_PWR_CTRL, 4, 3, 3, 0),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Analog bypass */
+	{"Analog Left Bypass", "Switch", "LINEL"},
+	{"Analog Right Bypass", "Switch", "LINER"},
+
+	{"Output Left Amp Power", NULL, "DACL"},
+	{"Output Right Amp Power", NULL, "DACR"},
+
+	{"Output Left Amp Power", NULL, "Analog Left Bypass"},
+	{"Output Right Amp Power", NULL, "Analog Right Bypass"},
+
+	/* output */
+	{"LEFT_LO", NULL, "Output Left Amp Power"},
+	{"RIGHT_LO", NULL, "Output Right Amp Power"},
+};
+
+static int dac33_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, dac33_dapm_widgets,
+				  ARRAY_SIZE(dac33_dapm_widgets));
+
+	/* set up audio path interconnects */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_widgets(codec);
+
+	return 0;
+}
+
+static int dac33_set_bias_level(struct snd_soc_codec *codec,
+				enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		dac33_soft_power(codec, 1);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		dac33_soft_power(codec, 0);
+		break;
+	case SND_SOC_BIAS_OFF:
+		dac33_set_power(codec, 0);
+		break;
+	}
+	codec->bias_level = level;
+
+	return 0;
+}
+
+static void dac33_work(struct work_struct *work)
+{
+	struct snd_soc_codec *codec;
+	struct tlv320dac33_priv *dac33;
+	u8 reg;
+
+	dac33 = container_of(work, struct tlv320dac33_priv, work);
+	codec = &dac33->codec;
+
+	switch (dac33->state) {
+	case DAC33_PREFILL:
+		dac33->state = DAC33_PLAYBACK;
+		dac33_write16(codec, DAC33_NSAMPLE_MSB,
+				THRREG(dac33->nsample));
+		dac33_write16(codec, DAC33_PREFILL_MSB,
+				THRREG(dac33->alarm_threshold));
+		break;
+	case DAC33_PLAYBACK:
+		dac33_write16(codec, DAC33_NSAMPLE_MSB, THRREG(dac33->nsample));
+		break;
+	case DAC33_IDLE:
+		break;
+	case DAC33_FLUSH:
+		/* flush fifo */
+		dac33->state = DAC33_IDLE;
+		reg = dac33_read_reg_cache(codec, DAC33_FIFO_CTRL_A);
+		reg |= FIFOFLUSH;
+		dac33_write(codec, DAC33_FIFO_CTRL_A, reg);
+		break;
+	}
+}
+
+static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
+{
+	struct snd_soc_codec *codec = dev;
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+
+	if (dac33->state == DAC33_PLAYBACK)
+		queue_work(dac33_wq, &dac33->work);
+
+	return IRQ_HANDLED;
+}
+
+static int dac33_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	int err;
+
+	/* Save the nsample mode to be used until the stream terminates */
+	dac33->nsmaple_cmode = dac33->nsample_switch;
+
+	/* We only need the interrupt in nSample mode */
+	if (dac33->nsmaple_cmode) {
+		err = request_irq(dac33->irq, dac33_interrupt_handler,
+				  IRQF_TRIGGER_RISING | IRQF_DISABLED,
+				  codec->name, codec);
+		if (err < 0) {
+			dev_err(codec->dev, "Could not request IRQ\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static void dac33_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	unsigned int pwr_ctrl;
+
+	/* Only in nSample mode */
+	if (dac33->nsmaple_cmode)
+		free_irq(dac33->irq, codec);
+
+	pwr_ctrl = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
+	pwr_ctrl &= ~(OSCPDNB | DACRPDNB | DACLPDNB);
+	dac33_write(codec, DAC33_PWR_CTRL, pwr_ctrl);
+}
+
+static void dac33_oscwait(struct snd_soc_codec *codec)
+{
+	int timeout = 20;
+	u8 reg;
+
+	do {
+		msleep(1);
+		dac33_read(codec, DAC33_INT_OSC_STATUS, &reg);
+	} while (((reg & 0x03) != OSCSTATUS_NORMAL) && timeout--);
+	if ((reg & 0x03) != OSCSTATUS_NORMAL)
+		dev_err(codec->dev,
+			"internal oscillator calibration failed\n");
+}
+
+static int dac33_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	/* Check parameters for validity */
+	switch (params_rate(params)) {
+	case 44100:
+	case 48000:
+		break;
+	default:
+		dev_err(codec->dev, "unsupported rate %d\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	default:
+		dev_err(codec->dev, "unsupported format %d\n",
+			params_format(params));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#define CALC_OSCSET(rate, refclk) ( \
+	((((rate * 10000) / refclk) * 4096) + 5000) / 10000)
+#define CALC_RATIOSET(rate, refclk) ( \
+	((((refclk  * 100000) / rate) * 16384) + 50000) / 100000)
+
+/*
+ * tlv320dac33 is strict on the sequence of the register writes, if the register
+ * writes happens in different order, than dac33 might end up in unknown state.
+ * Use the known, working sequence of register writes to initialize the dac33.
+ */
+static int dac33_prepare_chip(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	unsigned int oscset, ratioset, pwr_ctrl, reg_tmp;
+	u8 aictrl_a, fifoctrl_a;
+
+	switch (substream->runtime->rate) {
+	case 44100:
+	case 48000:
+		oscset = CALC_OSCSET(substream->runtime->rate, dac33->refclk);
+		ratioset = CALC_RATIOSET(substream->runtime->rate,
+					 dac33->refclk);
+		break;
+	default:
+		dev_err(codec->dev, "unsupported rate %d\n",
+			substream->runtime->rate);
+		return -EINVAL;
+	}
+
+	aictrl_a = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_A);
+	aictrl_a &= ~(NCYCL_MASK | WLEN_MASK);
+	fifoctrl_a = dac33_read_reg_cache(codec, DAC33_FIFO_CTRL_A);
+	fifoctrl_a &= ~WIDTH;
+	switch (substream->runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		aictrl_a |= (NCYCL_16 | WLEN_16);
+		fifoctrl_a |= WIDTH;
+		break;
+	default:
+		dev_err(codec->dev, "unsupported format %d\n",
+			substream->runtime->format);
+		return -EINVAL;
+	}
+	dac33_soft_power(codec, 1);
+
+	reg_tmp = dac33_read_reg_cache(codec, DAC33_INT_OSC_CTRL);
+	dac33_write(codec, DAC33_INT_OSC_CTRL, reg_tmp);
+
+	/* Write registers 0x08 and 0x09 (MSB, LSB) */
+	dac33_write16(codec, DAC33_INT_OSC_FREQ_RAT_A, oscset);
+
+	/* calib time: 128 is a nice number ;) */
+	dac33_write(codec, DAC33_CALIB_TIME, 128);
+
+	/* adjustment treshold & step */
+	dac33_write(codec, DAC33_INT_OSC_CTRL_B, ADJTHRSHLD(2) | ADJSTEP(1));
+
+	/* div=4 / gain=1 / div */
+	dac33_write(codec, DAC33_INT_OSC_CTRL_C, REFDIV(4));
+
+	pwr_ctrl = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
+	pwr_ctrl |= OSCPDNB | DACRPDNB | DACLPDNB;
+	dac33_write(codec, DAC33_PWR_CTRL, pwr_ctrl);
+
+	dac33_oscwait(codec);
+
+	if (dac33->nsmaple_cmode) {
+		/* 50-51 : ASRC Control registers */
+		dac33_write(codec, DAC33_ASRC_CTRL_A, (1 << 4)); /* div=2 */
+		dac33_write(codec, DAC33_ASRC_CTRL_B, 1); /* ??? */
+
+		/* Write registers 0x34 and 0x35 (MSB, LSB) */
+		dac33_write16(codec, DAC33_SRC_REF_CLK_RATIO_A, ratioset);
+
+		/* Set interrupts to high active */
+		dac33_write(codec, DAC33_INTP_CTRL_A, INTPM_AHIGH);
+
+		dac33_write(codec, DAC33_FIFO_IRQ_MODE_B,
+			    ATM(FIFO_IRQ_MODE_LEVEL));
+		dac33_write(codec, DAC33_FIFO_IRQ_MASK, MAT);
+	} else {
+		/* 50-51 : ASRC Control registers */
+		dac33_write(codec, DAC33_ASRC_CTRL_A, SRCBYP);
+		dac33_write(codec, DAC33_ASRC_CTRL_B, 0); /* ??? */
+	}
+
+	if (dac33->nsmaple_cmode)
+		fifoctrl_a &= ~FBYPAS;
+	else
+		fifoctrl_a |= FBYPAS;
+	dac33_write(codec, DAC33_FIFO_CTRL_A, fifoctrl_a);
+
+	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
+	reg_tmp = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
+	if (dac33->nsmaple_cmode)
+		reg_tmp &= ~BCLKON;
+	else
+		reg_tmp |= BCLKON;
+	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, reg_tmp);
+
+	if (dac33->nsmaple_cmode) {
+		/* 20: BCLK divide ratio */
+		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 3);
+
+		dac33_write16(codec, DAC33_ATHR_MSB,
+			      THRREG(dac33->alarm_threshold));
+	} else {
+		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
+	}
+
+	return 0;
+}
+
+static void dac33_calculate_times(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	unsigned int nsample_limit;
+
+	/* Number of samples (16bit, stereo) in one period */
+	dac33->nsample_min = snd_pcm_lib_period_bytes(substream) / 4;
+
+	/* Number of samples (16bit, stereo) in ALSA buffer */
+	dac33->nsample_max = snd_pcm_lib_buffer_bytes(substream) / 4;
+	/* Subtract one period from the total */
+	dac33->nsample_max -= dac33->nsample_min;
+
+	/* Number of samples for LATENCY_TIME_MS / 2 */
+	dac33->alarm_threshold = substream->runtime->rate /
+				 (1000 / (LATENCY_TIME_MS / 2));
+
+	/* Find and fix up the lowest nsmaple limit */
+	nsample_limit = substream->runtime->rate / (1000 / LATENCY_TIME_MS);
+
+	if (dac33->nsample_min < nsample_limit)
+		dac33->nsample_min = nsample_limit;
+
+	if (dac33->nsample < dac33->nsample_min)
+		dac33->nsample = dac33->nsample_min;
+
+	/*
+	 * Find and fix up the highest nsmaple limit
+	 * In order to not overflow the DAC33 buffer substract the
+	 * alarm_threshold value from the size of the DAC33 buffer
+	 */
+	nsample_limit = DAC33_BUFFER_SIZE_SAMPLES - dac33->alarm_threshold;
+
+	if (dac33->nsample_max > nsample_limit)
+		dac33->nsample_max = nsample_limit;
+
+	if (dac33->nsample > dac33->nsample_max)
+		dac33->nsample = dac33->nsample_max;
+}
+
+static int dac33_pcm_prepare(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	dac33_calculate_times(substream);
+	dac33_prepare_chip(substream);
+
+	return 0;
+}
+
+static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (dac33->nsmaple_cmode) {
+			dac33->state = DAC33_PREFILL;
+			queue_work(dac33_wq, &dac33->work);
+		}
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (dac33->nsmaple_cmode) {
+			dac33->state = DAC33_FLUSH;
+			queue_work(dac33_wq, &dac33->work);
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int dac33_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tlv320dac33_priv *dac33 = codec->private_data;
+	u8 ioc_reg, asrcb_reg;
+
+	ioc_reg = dac33_read_reg_cache(codec, DAC33_INT_OSC_CTRL);
+	asrcb_reg = dac33_read_reg_cache(codec, DAC33_ASRC_CTRL_B);
+	switch (clk_id) {
+	case TLV320DAC33_MCLK:
+		ioc_reg |= REFSEL;
+		asrcb_reg |= SRCREFSEL;
+		break;
+	case TLV320DAC33_SLEEPCLK:
+		ioc_reg &= ~REFSEL;
+		asrcb_reg &= ~SRCREFSEL;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid clock ID (%d)\n", clk_id);
+		break;
+	}
+	dac33->refclk = freq;
+
+	dac33_write_reg_cache(codec, DAC33_INT_OSC_CTRL, ioc_reg);
+	dac33_write_reg_cache(codec, DAC33_ASRC_CTRL_B, asrcb_reg);
+
+	return 0;
+}
+
+static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			     unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u8 aictrl_a, aictrl_b;
+
+	aictrl_a = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_A);
+	aictrl_b = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* Codec Master */
+		aictrl_a |= (MSBCLK | MSWCLK);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Codec Slave */
+		aictrl_a &= ~(MSBCLK | MSWCLK);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	aictrl_a &= ~AFMT_MASK;
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		aictrl_a |= AFMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		aictrl_a |= AFMT_DSP;
+		aictrl_b &= ~DATA_DELAY_MASK;
+		aictrl_b |= DATA_DELAY(1); /* 1 bit delay */
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		aictrl_a |= AFMT_DSP;
+		aictrl_b &= ~DATA_DELAY_MASK; /* No delay */
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		aictrl_a |= AFMT_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		aictrl_a |= AFMT_LEFT_J;
+		break;
+	default:
+		dev_err(codec->dev, "Unsupported format (%u)\n",
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	dac33_write_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
+	dac33_write_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B, aictrl_b);
+
+	return 0;
+}
+
+static void dac33_init_chip(struct snd_soc_codec *codec)
+{
+	/* 44-46: DAC Control Registers */
+	/* A : DAC sample rate Fsref/1.5 */
+	dac33_write(codec, DAC33_DAC_CTRL_A, DACRATE(1));
+	/* B : DAC src=normal, not muted */
+	dac33_write(codec, DAC33_DAC_CTRL_B, DACSRCR_RIGHT | DACSRCL_LEFT);
+	/* C : (defaults) */
+	dac33_write(codec, DAC33_DAC_CTRL_C, 0x00);
+
+	/* 64-65 : L&R DAC power control
+	 Line In -> OUT 1V/V Gain, DAC -> OUT 4V/V Gain*/
+	dac33_write(codec, DAC33_LDAC_PWR_CTRL, LROUT_GAIN(2));
+	dac33_write(codec, DAC33_RDAC_PWR_CTRL, LROUT_GAIN(2));
+
+	/* 73 : volume soft stepping control,
+	 clock source = internal osc (?) */
+	dac33_write(codec, DAC33_ANA_VOL_SOFT_STEP_CTRL, VOLCLKEN);
+
+	/* 66 : LOP/LOM Modes */
+	dac33_write(codec, DAC33_OUT_AMP_CM_CTRL, 0xff);
+
+	/* 68 : LOM inverted from LOP */
+	dac33_write(codec, DAC33_OUT_AMP_CTRL, (3<<2));
+
+	dac33_write(codec, DAC33_PWR_CTRL, PDNALLB);
+}
+
+static int dac33_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	struct tlv320dac33_priv *dac33;
+	int ret = 0;
+
+	BUG_ON(!tlv320dac33_codec);
+
+	codec = tlv320dac33_codec;
+	socdev->card->codec = codec;
+	dac33 = codec->private_data;
+
+	/* Power up the codec */
+	dac33_set_power(codec, 1);
+	/* Set default configuration */
+	dac33_init_chip(codec);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	snd_soc_add_controls(codec, dac33_snd_controls,
+				ARRAY_SIZE(dac33_snd_controls));
+	dac33_add_widgets(codec);
+
+	/* power on device */
+	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to register card\n");
+		goto card_err;
+	}
+
+	return 0;
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	dac33_set_power(codec, 0);
+	return ret;
+}
+
+static int dac33_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	dac33_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+static int dac33_soc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	dac33_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int dac33_soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	dac33_set_power(codec, 1);
+	dac33_init_chip(codec);
+
+	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	dac33_set_bias_level(codec, codec->suspend_bias_level);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_tlv320dac33 = {
+	.probe = dac33_soc_probe,
+	.remove = dac33_soc_remove,
+	.suspend = dac33_soc_suspend,
+	.resume = dac33_soc_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320dac33);
+
+#define DAC33_RATES	(SNDRV_PCM_RATE_44100 | \
+			 SNDRV_PCM_RATE_48000)
+#define DAC33_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
+
+static struct snd_soc_dai_ops dac33_dai_ops = {
+	.startup	= dac33_startup,
+	.shutdown	= dac33_shutdown,
+	.hw_params	= dac33_hw_params,
+	.prepare	= dac33_pcm_prepare,
+	.trigger	= dac33_pcm_trigger,
+	.set_sysclk	= dac33_set_dai_sysclk,
+	.set_fmt	= dac33_set_dai_fmt,
+};
+
+struct snd_soc_dai dac33_dai = {
+	.name = "tlv320dac33",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = DAC33_RATES,
+		.formats = DAC33_FORMATS,},
+	.ops = &dac33_dai_ops,
+};
+EXPORT_SYMBOL_GPL(dac33_dai);
+
+static int dac33_i2c_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	struct tlv320dac33_platform_data *pdata;
+	struct tlv320dac33_priv *dac33;
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	if (client->dev.platform_data == NULL) {
+		dev_err(&client->dev, "Platform data not set\n");
+		return -ENODEV;
+	}
+	pdata = (struct tlv320dac33_platform_data *)client->dev.platform_data;
+
+	dac33 = kzalloc(sizeof(struct tlv320dac33_priv), GFP_KERNEL);
+	if (dac33 == NULL)
+		return -ENOMEM;
+
+	codec = &dac33->codec;
+	codec->private_data = dac33;
+	codec->control_data = client;
+
+	mutex_init(&codec->mutex);
+	mutex_init(&dac33->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->name = "tlv320dac33";
+	codec->owner = THIS_MODULE;
+	codec->read = dac33_read_reg_cache;
+	codec->write = dac33_write;
+	codec->hw_write = (hw_write_t) i2c_master_send;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = dac33_set_bias_level;
+	codec->dai = &dac33_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = ARRAY_SIZE(dac33_reg);
+	codec->reg_cache = kmemdup(dac33_reg, ARRAY_SIZE(dac33_reg),
+				   GFP_KERNEL);
+	if (codec->reg_cache == NULL) {
+		ret = -ENOMEM;
+		goto error_reg;
+	}
+
+	tlv320dac33_client = client;
+
+	i2c_set_clientdata(tlv320dac33_client, dac33);
+
+	dac33->power_gpio = pdata->power_gpio;
+	dac33->irq = client->irq;
+	dac33->nsample = NSAMPLE_MAX;
+	/* Disable FIFO use by default */
+	dac33->nsample_switch = 0;
+
+	tlv320dac33_codec = codec;
+
+	/* Setup work queue */
+	dac33_wq = create_rt_workqueue("tlv320dac33");
+	if (dac33_wq == NULL) {
+		ret = -ENOMEM;
+		goto error_wq;
+	}
+
+	INIT_WORK(&dac33->work, dac33_work);
+
+	codec->dev = &client->dev;
+	dac33_dai.dev = codec->dev;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto error_codec;
+	}
+
+	ret = snd_soc_register_dai(&dac33_dai);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
+		snd_soc_unregister_codec(codec);
+		goto error_codec;
+	}
+
+	if (dac33->power_gpio >= 0) {
+		ret = gpio_request(dac33->power_gpio, "tlv320dac33 reset");
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to request reset GPIO (%d)\n",
+				dac33->power_gpio);
+			snd_soc_unregister_dai(&dac33_dai);
+			snd_soc_unregister_codec(codec);
+			goto error_codec;
+		}
+		gpio_direction_output(dac33->power_gpio, 0);
+	}
+
+	dac33->power_state = 1;
+
+	/* Shut down the codec for now */
+	dac33_soft_power(codec, 0);
+
+	return ret;
+
+error_codec:
+	destroy_workqueue(dac33_wq);
+error_wq:
+	kfree(codec->reg_cache);
+error_reg:
+	tlv320dac33_codec = NULL;
+	kfree(dac33);
+
+	return ret;
+}
+
+static int dac33_i2c_remove(struct i2c_client *client)
+{
+	struct tlv320dac33_priv *dac33;
+
+	dac33 = i2c_get_clientdata(client);
+	dac33_set_power(&dac33->codec, 0);
+
+	if (dac33->power_gpio >= 0)
+		gpio_free(dac33->power_gpio);
+
+	destroy_workqueue(dac33_wq);
+	snd_soc_unregister_dai(&dac33_dai);
+	snd_soc_unregister_codec(&dac33->codec);
+	kfree(dac33->codec.reg_cache);
+	kfree(dac33);
+	tlv320dac33_codec = NULL;
+	tlv320dac33_client = NULL;
+
+	return 0;
+}
+
+static const struct i2c_device_id tlv320dac33_i2c_id[] = {
+	{
+		.name = "tlv320dac33",
+		.driver_data = 0,
+	},
+	{ },
+};
+
+static struct i2c_driver tlv320dac33_i2c_driver = {
+	.driver = {
+		.name = "tlv320dac33",
+		.owner = THIS_MODULE,
+	},
+	.probe		= dac33_i2c_probe,
+	.remove		= __devexit_p(dac33_i2c_remove),
+	.id_table	= tlv320dac33_i2c_id,
+};
+
+static int __init dac33_module_init(void)
+{
+	int r;
+	r = i2c_add_driver(&tlv320dac33_i2c_driver);
+	if (r < 0) {
+		printk(KERN_ERR "DAC33: driver registration failed\n");
+		return r;
+	}
+	return 0;
+}
+module_init(dac33_module_init);
+
+static void __exit dac33_module_exit(void)
+{
+	i2c_del_driver(&tlv320dac33_i2c_driver);
+}
+module_exit(dac33_module_exit);
+
+
+MODULE_DESCRIPTION("ASoC TLV320DAC33 codec driver");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@nokia.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320dac33.h b/sound/soc/codecs/tlv320dac33.h
new file mode 100644
index 0000000..c391bae
--- /dev/null
+++ b/sound/soc/codecs/tlv320dac33.h
@@ -0,0 +1,267 @@
+/*
+ * ALSA SoC Texas Instruments TLV320DAC33 codec driver
+ *
+ * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *
+ * Copyright:   (C) 2009 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __TLV320DAC33_H
+#define __TLV320DAC33_H
+
+#define DAC33_PAGE_SELECT		0x00
+#define DAC33_PWR_CTRL			0x01
+#define DAC33_PLL_CTRL_A		0x02
+#define DAC33_PLL_CTRL_B		0x03
+#define DAC33_PLL_CTRL_C		0x04
+#define DAC33_PLL_CTRL_D		0x05
+#define DAC33_PLL_CTRL_E		0x06
+#define DAC33_INT_OSC_CTRL		0x07
+#define DAC33_INT_OSC_FREQ_RAT_A	0x08
+#define DAC33_INT_OSC_FREQ_RAT_B	0x09
+#define DAC33_INT_OSC_DAC_RATIO_SET	0x0A
+#define DAC33_CALIB_TIME		0x0B
+#define DAC33_INT_OSC_CTRL_B		0x0C
+#define DAC33_INT_OSC_CTRL_C		0x0D
+#define DAC33_INT_OSC_STATUS		0x0E
+#define DAC33_INT_OSC_DAC_RATIO_READ	0x0F
+#define DAC33_INT_OSC_FREQ_RAT_READ_A	0x10
+#define DAC33_INT_OSC_FREQ_RAT_READ_B	0x11
+#define DAC33_SER_AUDIOIF_CTRL_A	0x12
+#define DAC33_SER_AUDIOIF_CTRL_B	0x13
+#define DAC33_SER_AUDIOIF_CTRL_C	0x14
+#define DAC33_FIFO_CTRL_A		0x15
+#define DAC33_UTHR_MSB			0x16
+#define DAC33_UTHR_LSB			0x17
+#define DAC33_ATHR_MSB			0x18
+#define DAC33_ATHR_LSB			0x19
+#define DAC33_LTHR_MSB			0x1A
+#define DAC33_LTHR_LSB			0x1B
+#define DAC33_PREFILL_MSB		0x1C
+#define DAC33_PREFILL_LSB		0x1D
+#define DAC33_NSAMPLE_MSB		0x1E
+#define DAC33_NSAMPLE_LSB		0x1F
+#define DAC33_FIFO_WPTR_MSB		0x20
+#define DAC33_FIFO_WPTR_LSB		0x21
+#define DAC33_FIFO_RPTR_MSB		0x22
+#define DAC33_FIFO_RPTR_LSB		0x23
+#define DAC33_FIFO_DEPTH_MSB		0x24
+#define DAC33_FIFO_DEPTH_LSB		0x25
+#define DAC33_SAMPLES_REMAINING_MSB	0x26
+#define DAC33_SAMPLES_REMAINING_LSB	0x27
+#define DAC33_FIFO_IRQ_FLAG		0x28
+#define DAC33_FIFO_IRQ_MASK		0x29
+#define DAC33_FIFO_IRQ_MODE_A		0x2A
+#define DAC33_FIFO_IRQ_MODE_B		0x2B
+#define DAC33_DAC_CTRL_A		0x2C
+#define DAC33_DAC_CTRL_B		0x2D
+#define DAC33_DAC_CTRL_C		0x2E
+#define DAC33_LDAC_DIG_VOL_CTRL		0x2F
+#define DAC33_RDAC_DIG_VOL_CTRL		0x30
+#define DAC33_DAC_STATUS_FLAGS		0x31
+#define DAC33_ASRC_CTRL_A		0x32
+#define DAC33_ASRC_CTRL_B		0x33
+#define DAC33_SRC_REF_CLK_RATIO_A	0x34
+#define DAC33_SRC_REF_CLK_RATIO_B	0x35
+#define DAC33_SRC_EST_REF_CLK_RATIO_A	0x36
+#define DAC33_SRC_EST_REF_CLK_RATIO_B	0x37
+#define DAC33_INTP_CTRL_A		0x38
+#define DAC33_INTP_CTRL_B		0x39
+/* Registers 0x3A - 0x3F Reserved */
+#define DAC33_LDAC_PWR_CTRL		0x40
+#define DAC33_RDAC_PWR_CTRL		0x41
+#define DAC33_OUT_AMP_CM_CTRL		0x42
+#define DAC33_OUT_AMP_PWR_CTRL		0x43
+#define DAC33_OUT_AMP_CTRL		0x44
+#define DAC33_LINEL_TO_LLO_VOL		0x45
+/* Registers 0x45 - 0x47 Reserved */
+#define DAC33_LINER_TO_RLO_VOL		0x48
+#define DAC33_ANA_VOL_SOFT_STEP_CTRL	0x49
+#define DAC33_OSC_TRIM			0x4A
+/* Registers 0x4B - 0x7C Reserved */
+#define DAC33_DEVICE_ID_MSB		0x7D
+#define DAC33_DEVICE_ID_LSB		0x7E
+#define DAC33_DEVICE_REV_ID		0x7F
+
+#define DAC33_CACHEREGNUM               128
+
+/* Bit definitions */
+
+/* DAC33_PWR_CTRL (0x01) */
+#define DACRPDNB			(0x01 << 0)
+#define DACLPDNB			(0x01 << 1)
+#define OSCPDNB				(0x01 << 2)
+#define PLLPDNB				(0x01 << 3)
+#define PDNALLB				(0x01 << 4)
+#define SOFT_RESET			(0x01 << 7)
+
+/* DAC33_INT_OSC_CTRL (0x07) */
+#define REFSEL				(0x01 << 1)
+
+/* DAC33_INT_OSC_CTRL_B (0x0C) */
+#define ADJSTEP(x)			(x << 0)
+#define ADJTHRSHLD(x)			(x << 4)
+
+/* DAC33_INT_OSC_CTRL_C (0x0D) */
+#define REFDIV(x)			(x << 4)
+
+/* DAC33_INT_OSC_STATUS (0x0E) */
+#define OSCSTATUS_IDLE_CALIB		(0x00)
+#define OSCSTATUS_NORMAL		(0x01)
+#define OSCSTATUS_ADJUSTMENT		(0x03)
+#define OSCSTATUS_NOT_USED		(0x02)
+
+/* DAC33_SER_AUDIOIF_CTRL_A (0x12) */
+#define MSWCLK				(0x01 << 0)
+#define MSBCLK				(0x01 << 1)
+#define AFMT_MASK			(0x03 << 2)
+#define AFMT_I2S			(0x00 << 2)
+#define AFMT_DSP			(0x01 << 2)
+#define AFMT_RIGHT_J			(0x02 << 2)
+#define AFMT_LEFT_J			(0x03 << 2)
+#define WLEN_MASK			(0x03 << 4)
+#define WLEN_16				(0x00 << 4)
+#define WLEN_20				(0x01 << 4)
+#define WLEN_24				(0x02 << 4)
+#define WLEN_32				(0x03 << 4)
+#define NCYCL_MASK			(0x03 << 6)
+#define NCYCL_16			(0x00 << 6)
+#define NCYCL_20			(0x01 << 6)
+#define NCYCL_24			(0x02 << 6)
+#define NCYCL_32			(0x03 << 6)
+
+/* DAC33_SER_AUDIOIF_CTRL_B (0x13) */
+#define DATA_DELAY_MASK			(0x03 << 2)
+#define DATA_DELAY(x)			(x << 2)
+#define BCLKON				(0x01 << 5)
+
+/* DAC33_FIFO_CTRL_A (0x15) */
+#define WIDTH				(0x01 << 0)
+#define FBYPAS				(0x01 << 1)
+#define FAUTO				(0x01 << 2)
+#define FIFOFLUSH			(0x01 << 3)
+
+/*
+ * UTHR, ATHR, LTHR, PREFILL, NSAMPLE (0x16 - 0x1F)
+ * 13-bit values
+*/
+#define THRREG(x)			(((x) & 0x1FFF) << 3)
+
+/* DAC33_FIFO_IRQ_MASK (0x29) */
+#define MNS				(0x01 << 0)
+#define MPS				(0x01 << 1)
+#define MAT				(0x01 << 2)
+#define MLT				(0x01 << 3)
+#define MUT				(0x01 << 4)
+#define MUF				(0x01 << 5)
+#define MOF				(0x01 << 6)
+
+#define FIFO_IRQ_MODE_MASK		(0x03)
+#define FIFO_IRQ_MODE_RISING		(0x00)
+#define FIFO_IRQ_MODE_FALLING		(0x01)
+#define FIFO_IRQ_MODE_LEVEL		(0x02)
+#define FIFO_IRQ_MODE_EDGE		(0x03)
+
+/* DAC33_FIFO_IRQ_MODE_A (0x2A) */
+#define UTM(x)				(x << 0)
+#define UFM(x)				(x << 2)
+#define OFM(x)				(x << 4)
+
+/* DAC33_FIFO_IRQ_MODE_B (0x2B) */
+#define NSM(x)				(x << 0)
+#define PSM(x)				(x << 2)
+#define ATM(x)				(x << 4)
+#define LTM(x)				(x << 4)
+
+/* DAC33_DAC_CTRL_A (0x2C) */
+#define DACRATE(x)			(x << 0)
+#define DACDUAL				(0x01 << 4)
+#define DACLKSEL_MASK			(0x03 << 5)
+#define DACLKSEL_INTSOC			(0x00 << 5)
+#define DACLKSEL_PLL			(0x01 << 5)
+#define DACLKSEL_MCLK			(0x02 << 5)
+#define DACLKSEL_BCLK			(0x03 << 5)
+
+/* DAC33_DAC_CTRL_B (0x2D) */
+#define DACSRCR_MASK			(0x03 << 0)
+#define DACSRCR_MUTE			(0x00 << 0)
+#define DACSRCR_RIGHT			(0x01 << 0)
+#define DACSRCR_LEFT			(0x02 << 0)
+#define DACSRCR_MONOMIX			(0x03 << 0)
+#define DACSRCL_MASK			(0x03 << 2)
+#define DACSRCL_MUTE			(0x00 << 2)
+#define DACSRCL_LEFT			(0x01 << 2)
+#define DACSRCL_RIGHT			(0x02 << 2)
+#define DACSRCL_MONOMIX			(0x03 << 2)
+#define DVOLSTEP_MASK			(0x03 << 4)
+#define DVOLSTEP_SS_PERFS		(0x00 << 4)
+#define DVOLSTEP_SS_PER2FS		(0x01 << 4)
+#define DVOLSTEP_SS_DISABLED		(0x02 << 4)
+#define DVOLCTRL_MASK			(0x03 << 6)
+#define DVOLCTRL_LR_INDEPENDENT1	(0x00 << 6)
+#define DVOLCTRL_LR_RIGHT_CONTROL	(0x01 << 6)
+#define DVOLCTRL_LR_LEFT_CONTROL	(0x02 << 6)
+#define DVOLCTRL_LR_INDEPENDENT2	(0x03 << 6)
+
+/* DAC33_DAC_CTRL_C (0x2E) */
+#define DEEMENR				(0x01 << 0)
+#define EFFENR				(0x01 << 1)
+#define DEEMENL				(0x01 << 2)
+#define EFFENL				(0x01 << 3)
+#define EN3D				(0x01 << 4)
+#define RESYNMUTE			(0x01 << 5)
+#define RESYNEN				(0x01 << 6)
+
+/* DAC33_ASRC_CTRL_A (0x32) */
+#define SRCBYP				(0x01 << 0)
+#define SRCLKSEL_MASK			(0x03 << 1)
+#define SRCLKSEL_INTSOC			(0x00 << 1)
+#define SRCLKSEL_PLL			(0x01 << 1)
+#define SRCLKSEL_MCLK			(0x02 << 1)
+#define SRCLKSEL_BCLK			(0x03 << 1)
+#define SRCLKDIV(x)			(x << 3)
+
+/* DAC33_ASRC_CTRL_B (0x33) */
+#define SRCSETUP(x)			(x << 0)
+#define SRCREFSEL			(0x01 << 4)
+#define SRCREFDIV(x)			(x << 5)
+
+/* DAC33_INTP_CTRL_A (0x38) */
+#define INTPSEL				(0x01 << 0)
+#define INTPM_MASK			(0x03 << 1)
+#define INTPM_ALOW_OPENDRAIN		(0x00 << 1)
+#define INTPM_ALOW			(0x01 << 1)
+#define INTPM_AHIGH			(0x02 << 1)
+
+/* DAC33_LDAC_PWR_CTRL (0x40) */
+/* DAC33_RDAC_PWR_CTRL (0x41) */
+#define DACLRNUM			(0x01 << 2)
+#define LROUT_GAIN(x)			(x << 0)
+
+/* DAC33_ANA_VOL_SOFT_STEP_CTRL (0x49) */
+#define VOLCLKSEL			(0x01 << 0)
+#define VOLCLKEN			(0x01 << 1)
+#define VOLBYPASS			(0x01 << 2)
+
+#define TLV320DAC33_MCLK		0
+#define TLV320DAC33_SLEEPCLK		1
+
+extern struct snd_soc_dai dac33_dai;
+extern struct snd_soc_codec_device soc_codec_dev_tlv320dac33;
+
+#endif /* __TLV320DAC33_H */
-- 
1.6.5.rc2
