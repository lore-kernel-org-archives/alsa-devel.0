From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] ASoC: Analog Devices AD193X I2S codec family
	driver.
Date: Thu, 18 Sep 2008 15:03:09 +0200
Message-ID: <20080918130309.GA14895@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id C84C2243B2
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 15:03:23 +0200 (CEST)
Content-Disposition: inline
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Driver for the Analog Devices AD1935/AD1937 I2C and
AD1938/AD1939 SPI codecs.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 sound/soc/codecs/Kconfig  |    3 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/ad1939.c |  897 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad1939.h |  122 ++++++
 4 files changed, 1024 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/ad1939.c
 create mode 100644 sound/soc/codecs/ad1939.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1db04a2..466d7cb 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2,6 +2,9 @@ config SND_SOC_AC97_CODEC
 	tristate
 	select SND_AC97_CODEC
 
+config SND_SOC_AD1939
+	tristate
+
 config SND_SOC_AK4535
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d7b97ab..cfb5d22 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,4 +1,5 @@
 snd-soc-ac97-objs := ac97.o
+snd-soc-ad1939-objs := ad1939.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wm8510-objs := wm8510.o
@@ -12,6 +13,7 @@ snd-soc-cs4270-objs := cs4270.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
+obj-$(CONFIG_SND_SOC_AD1939)	+= snd-soc-ad1939.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WM8510)	+= snd-soc-wm8510.o
diff --git a/sound/soc/codecs/ad1939.c b/sound/soc/codecs/ad1939.c
new file mode 100644
index 0000000..092f09c
--- /dev/null
+++ b/sound/soc/codecs/ad1939.c
@@ -0,0 +1,897 @@
+/*
+ * AD1935/AD1936/AD1937/AD1938/AD1939 I2S ASoC Codec driver
+ *
+ * Copyright (c) 2007-2008 MSC Vertriebsges.m.b.H,	www.exm32.com
+ *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * licensed under the GPLv2
+ *
+ * Code for the AD193X family of I2S codecs with I2C and SPI control
+ * interface.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/workqueue.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "ad1939.h"
+
+#define CODEC_NAME "ad1939"
+
+struct ad1939_private {
+	unsigned char tdm_mode;
+	unsigned char dev_addr;
+	unsigned char drvflags;
+	unsigned char mixpairs;
+};
+
+/* default register contents after reset */
+static const u16 ad1939_regcache[AD1939_REGCOUNT] = {
+	0, 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 0, 0, 0
+};
+
+/* Does the codec have power?  In case of STANDBY/OFF BIAS levels, the
+ * hardware access functions below assume the codec is without power
+ * to avoid futile bus transactions.
+ */
+static int codec_is_powered(struct snd_soc_codec *c)
+{
+	return (c->bias_level == SND_SOC_BIAS_PREPARE) ||
+		(c->bias_level == SND_SOC_BIAS_ON);
+}
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static int ad1939_i2c_write(struct snd_soc_codec *codec, unsigned int r,
+			    unsigned int v)
+{
+	struct i2c_msg msg;
+	struct i2c_client *c;
+	u16 *cache = codec->reg_cache;
+	u8 data[2];
+	int ret;
+
+	c = (struct i2c_client *)codec->control_data;
+	data[0] = r & 0xff;
+	data[1] = v & 0xff;
+	msg.addr = c->addr;
+	msg.flags = 0;	/* write */
+	msg.buf = &data[0];
+	msg.len = 2;
+
+	/* no power? just update the cache then */
+	if (codec_is_powered(codec))
+		ret = i2c_transfer(c->adapter, &msg, 1);
+	else
+		ret = 1;
+
+	if (ret == 1)
+		cache[r] = v;
+	return (ret == 1) ? 0 : -EIO;
+}
+
+static unsigned int ad1939_i2c_read(struct snd_soc_codec *codec,
+				    unsigned int r)
+{
+	struct i2c_msg msg[2];
+	struct i2c_client *c;
+	u16 *cache = codec->reg_cache;
+	u8 data[2];
+	int ret;
+
+	/* no power? cached value is all we have */
+	if (!codec_is_powered(codec))
+		return cache[r];
+
+	c = (struct i2c_client *)codec->control_data;
+	data[0] = r & 0xff;
+	msg[0].addr = c->addr;
+	msg[0].flags = 0;
+	msg[0].buf = &data[0];
+	msg[0].len = 1;
+
+	msg[1].addr = c->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].buf = &data[1];
+	msg[1].len = 1;
+
+	ret = i2c_transfer(c->adapter, &msg[0], 2);
+	if (ret == 2)
+		cache[r] = data[1];
+
+	return (ret == 2) ? data[1] : -EIO;
+}
+#endif
+
+#if defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)
+/* SPI communications for AD1938/AD1939:
+ * 24 bit data, LSB first; (I2C style, including R/W bit)
+ * <7bit global address|R/W#><8bit register address><8bit reg data>
+ */
+static int ad1939_spi_write(struct snd_soc_codec *codec, unsigned int r,
+			    unsigned int v)
+{
+	struct spi_device *spi = codec->control_data;
+	struct ad1939_private *ad = codec->private_data;
+	u16 *cache = codec->reg_cache;
+	int ret;
+	u8 data[3];
+
+	data[0] = ad->dev_addr << 1;
+	data[1] = r;
+	data[2] = v;
+
+	/* no power? just update the cache then */
+	if (codec_is_powered(codec))
+		ret = spi_write(spi, &data[0], 3);
+	else
+		ret = 0;
+
+	if (ret == 0)
+		cache[r] = v;
+
+	return ret;
+}
+
+static unsigned int ad1939_spi_read(struct snd_soc_codec *codec,
+				    unsigned int r)
+{
+	struct spi_device *spi = codec->control_data;
+	struct ad1939_private *ad = codec->private_data;
+	u16 *cache = codec->reg_cache;
+	u8 data_w[3], data_r[3];
+	int ret;
+
+	/* no power? cached value is all we have */
+	if (!codec_is_powered(codec))
+		return cache[r];
+
+	data_r[0] = data_w[0] = (ad->dev_addr << 1) | 1;
+	data_r[1] = data_w[1] = r;
+	data_r[2] = data_w[2] = cache[r];
+
+	ret = spi_write_then_read(spi, data_w, 3, data_r, 3);
+
+	if (ret == 0)
+		cache[r] = data_r[2];
+	return (ret) ? ret : data_r[2];
+}
+#endif
+
+/* standard accessor functions.  Reads can generally be satisfied by
+ * the cached value, writes don't hit the chip if the cached value
+ * is identical.
+ */
+static inline unsigned int ad1939_read(struct snd_soc_codec *codec,
+				       unsigned int r)
+{
+	unsigned int v;
+	u16 *cache = codec->reg_cache;
+
+	/* the PLLCTL1 has one read-only bit: PLL lock indicator.
+	 * all other regs keep what was set.
+	 * If powered-down the chip can't be reached so just return
+	 * the cached value.
+	 */
+	if (unlikely(r == AD1939_PLLCTL1))
+		v = codec->read(codec, r);
+	else
+		v = cache[r];
+
+	return v;
+}
+
+static inline int ad1939_write(struct snd_soc_codec *codec,
+			       unsigned int r, unsigned int v)
+{
+	u16 *cache = codec->reg_cache;
+	if (cache[r] == v)
+		return 0;
+	return codec->write(codec, r, v);
+}
+
+/***** controls ******/
+
+static const char *dac_deemph[] = {"Flat", "48kHz", "44.1kHz", "32kHz"};
+static const char *dac_outpol[] = {"Normal", "Inverted"};
+
+static const struct soc_enum ad1939_enum[] = {
+      /*SOC_ENUM_SINGLE(register, startbit, choices, choices-texts) */
+	SOC_ENUM_SINGLE(AD1939_DACCTL2, 1, 4, dac_deemph),
+	SOC_ENUM_SINGLE(AD1939_DACCTL2, 5, 2, dac_outpol),
+};
+
+/* Mixer controls. Keep the Playback Attenuation controls at the top,
+ * or the limiter breaks (see ad1939_add_controls())
+ */
+static const struct snd_kcontrol_new ad1939_snd_ctls[] = {
+SOC_DOUBLE_R("Master Playback", AD1939_VOL1L, AD1939_VOL1R, 0, 255, 1),
+SOC_DOUBLE_R("Channel 2 Playback", AD1939_VOL2L, AD1939_VOL2R, 0, 255, 1),
+SOC_DOUBLE_R("Channel 3 Playback", AD1939_VOL3L, AD1939_VOL3R, 0, 255, 1),
+SOC_DOUBLE_R("Channel 4 Playback", AD1939_VOL4L, AD1939_VOL4R, 0, 255, 1),
+SOC_ENUM("DAC Deemphasis", ad1939_enum[0]),
+SOC_ENUM("DAC output polarity", ad1939_enum[1]),
+};
+
+/* add non dapm controls */
+static int ad1939_add_controls(struct snd_soc_codec *codec)
+{
+	struct ad1939_private *ad = codec->private_data;
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(ad1939_snd_ctls); i++) {
+		if ((i <= 3) && (i >= ad->mixpairs))
+			continue;
+		err = snd_ctl_add(codec->card,
+			snd_soc_cnew(&ad1939_snd_ctls[i], codec, NULL));
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+/***** chip interface config ******/
+
+static int ad1939_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	struct ad1939_private *ad = codec->private_data;
+	unsigned char dac0, dac1, dac2, adc0, adc1, adc2;
+	unsigned long rate;
+	unsigned int bits;
+
+	dac0 = ad1939_read(codec, AD1939_DACCTL0);
+	dac1 = ad1939_read(codec, AD1939_DACCTL1);
+	dac2 = ad1939_read(codec, AD1939_DACCTL2);
+	adc0 = ad1939_read(codec, AD1939_ADCCTL0);
+	adc1 = ad1939_read(codec, AD1939_ADCCTL1);
+	adc2 = ad1939_read(codec, AD1939_ADCCTL2);
+
+	rate = params_rate(params);
+	bits = params->msbits;
+
+	/* sample rate */
+	dac0 &= ~(3<<1);	/* 48kHz */
+	adc0 &= ~(3<<6);	/* 48kHz */
+	switch (rate) {
+	case 32000 ... 48000:
+		break;
+	case 64000 ... 96000:
+		dac0 |= (1<<1);
+		adc0 |= (1<<6);
+		break;
+	case 128000 ... 192000:
+		dac0 |= (2<<1);
+		adc0 |= (2<<6);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* sample width (bits) */
+	dac2 &= ~(3<<3);	/* 24 bits */
+	adc1 &= ~(3<<0);	/* 24 bits */
+
+
+	/* channels */
+	dac0 &= ~(3<<6);	/* DAC I2S stereo */
+	dac1 &= ~(3<<1);	/* 2 channels */
+	adc1 &= ~(3<<5);	/* ADC I2S stereo */
+	adc2 &= ~(3<<4);	/* 2 channels */
+	switch (params_channels(params)) {
+	case 2:	/* I2S stereo mode */
+		if (ad->drvflags & AD1939_DRV_TDM_STEREO) {
+			dac0 |= (ad->tdm_mode & 3) << 6;
+			adc1 |= (ad->tdm_mode & 3) << 5;
+		}
+		break;
+	case 4:	/* TDM mode */
+		dac0 |= (ad->tdm_mode & 3) << 6;
+		dac1 |= (1<<1);
+		adc1 |= (ad->tdm_mode & 3) << 5;
+		adc2 |= (1<<4);
+		break;
+	case 8:	/* TDM mode */
+		dac0 |= (ad->tdm_mode & 3) << 6;
+		dac1 |= (2<<1);
+		adc1 |= (ad->tdm_mode & 3) << 5;
+		adc2 |= (2<<4);
+		break;
+	case 16: /* TDM mode */
+		dac0 |= (ad->tdm_mode & 3) << 6;
+		dac1 |= (3<<1);
+		adc1 |= (ad->tdm_mode & 3) << 5;
+		adc2 |= (3<<4);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ad1939_write(codec, AD1939_DACCTL0, dac0);
+	ad1939_write(codec, AD1939_DACCTL1, dac1);
+	ad1939_write(codec, AD1939_DACCTL2, dac2);
+	ad1939_write(codec, AD1939_ADCCTL0, adc0);
+	ad1939_write(codec, AD1939_ADCCTL1, adc1);
+	ad1939_write(codec, AD1939_ADCCTL2, adc2);
+
+	return 0;
+}
+
+static int ad1939_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct ad1939_private *ad = codec->private_data;
+	unsigned char dac0, dac1, adc1, adc2;
+
+	dac0 = ad1939_read(codec, AD1939_DACCTL0);
+	dac1 = ad1939_read(codec, AD1939_DACCTL1);
+	adc1 = ad1939_read(codec, AD1939_ADCCTL1);
+	adc2 = ad1939_read(codec, AD1939_ADCCTL2);
+
+	/* codec clocks master/slave setup */
+	dac1 &= ~((1<<4) | (1<<5)); /* LRCK BCK slave */
+	adc2 &= ~((1<<3) | (1<<6)); /* LRCK BCK slave */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:	 /* BCK/LCK master */
+		dac1 |= (1<<4) | (1<<5); /* LRCK BCK master */
+		adc2 |= (1<<3) | (1<<6); /* LRCK BCK master */
+		if (ad->drvflags & AD1939_DRV_ADCDAC_COMMON_BCK) {
+			if (ad->drvflags & AD1939_DRV_ADC_BCK_MASTER)
+				dac1 &= ~(1<<5); /* DAC BCLK slave */
+			else
+				adc2 &= ~(1<<6); /* ADC BCLK slave */
+		}
+		if (ad->drvflags & AD1939_DRV_ADCDAC_COMMON_LRCK) {
+			if (ad->drvflags & AD1939_DRV_ADC_LRCK_MASTER)
+				dac1 &= ~(1<<4); /* DAC LRCK slave */
+			else
+				adc2 &= ~(1<<3); /* ADC LRCK slave */
+		}
+		break;
+
+	case SND_SOC_DAIFMT_CBS_CFS:	/* BCK/LCK slave */
+		break;
+
+	case SND_SOC_DAIFMT_CBM_CFS:	/* BCK master, LRCK slave */
+		dac1 &= ~(1<<4);	/* DAC LRCK slave */
+		adc2 &= ~(1<<3);	/* ADC LRCK slave */
+		dac1 |= (1<<5);		/* DAC BCK master */
+		adc2 |= (1<<6);		/* ADC BCK master */
+		if (ad->drvflags & AD1939_DRV_ADCDAC_COMMON_BCK) {
+			if (ad->drvflags & AD1939_DRV_ADC_BCK_MASTER)
+				dac1 &= ~(1<<5); /* DAC BCLK slave */
+			else
+				adc2 &= ~(1<<6); /* ADC BCLK slave */
+		}
+		break;
+
+	case SND_SOC_DAIFMT_CBS_CFM:
+		dac1 &= ~(1<<5);	/* DAC BCK slave */
+		adc2 &= ~(1<<6);	/* ADC BCK slave */
+		dac1 |= (1<<4);		/* DAC LRCK master */
+		adc2 |= (1<<3);		/* ADC LRCK master */
+		if (ad->drvflags & AD1939_DRV_ADCDAC_COMMON_LRCK) {
+			if (ad->drvflags & AD1939_DRV_ADC_LRCK_MASTER)
+				dac1 &= ~(1<<4); /* DAC LRCK slave */
+			else
+				adc2 &= ~(1<<3); /* ADC LRCK slave */
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* interface format */
+	dac0 &= ~(7<<3); /* DAC: SDATA delay 1 (I2S) */
+	adc1 &= ~(7<<2); /* ADC: SDATA delay 1 (I2S) */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+
+	case SND_SOC_DAIFMT_MSB: /* LEFT_J */
+		dac0 |= (1<<3);	/* no SDATA delay */
+		adc1 |= (1<<2); /* no SDATA delay */
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* clock format */
+	dac1 &= ~((1<<7) | (1<<3)); /* norm BCK LRCK */
+	adc2 &= ~((1<<1) | (1<<2)); /* norm BCK LRCK */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+
+	case SND_SOC_DAIFMT_NB_IF:
+		dac1 |= (1<<3);		/* inv LRCK */
+		adc2 |= (1<<2);
+		break;
+
+	case SND_SOC_DAIFMT_IB_NF:
+		dac1 |= (1<<7);		/* inv BCK */
+		adc2 |= (1<<1);
+		break;
+
+	case SND_SOC_DAIFMT_IB_IF:
+		dac1 |= (1<<3) | (1<<7); /* inv LRCK BCK */
+		adc2 |= (1<<1) | (1<<2);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ad1939_write(codec, AD1939_DACCTL0, dac0);
+	ad1939_write(codec, AD1939_DACCTL1, dac1);
+	ad1939_write(codec, AD1939_ADCCTL1, adc1);
+	ad1939_write(codec, AD1939_ADCCTL2, adc2);
+
+	return 0;
+}
+
+static int ad1939_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	unsigned char pll0, adc0, dac0;
+	u16 *cache = codec->reg_cache;
+	int i;
+
+	pll0 = ad1939_read(codec, AD1939_PLLCTL0) & 0xfe;
+	dac0 = ad1939_read(codec, AD1939_DACCTL0) & 0xfe;
+	adc0 = ad1939_read(codec, AD1939_ADCCTL0) & 0xfe;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:			/* power up */
+	case SND_SOC_BIAS_PREPARE:
+		if (!codec_is_powered(codec)) {
+			/* writes need to hit the chip */
+			codec->bias_level = level;
+
+			for (i = 0; i < AD1939_REGCOUNT; i++)
+				codec->write(codec, i, cache[i]);
+
+			ad1939_write(codec, AD1939_PLLCTL0, pll0);
+			ad1939_write(codec, AD1939_DACCTL0, dac0);
+			ad1939_write(codec, AD1939_ADCCTL0, adc0);
+		}
+		break;
+
+	case SND_SOC_BIAS_STANDBY:		/* power down */
+	case SND_SOC_BIAS_OFF:
+		if (codec_is_powered(codec)) {
+			/* turn off internal PLL and DAC/ADCs */
+			ad1939_write(codec, AD1939_PLLCTL0, pll0 | 1);
+			ad1939_write(codec, AD1939_DACCTL0, dac0 | 1);
+			ad1939_write(codec, AD1939_ADCCTL0, adc0 | 1);
+		}
+		break;
+	}
+	codec->bias_level = level;
+	return 0;
+}
+
+static int ad1939_digmute(struct snd_soc_dai *dai, int mute)
+{
+	ad1939_write(dai->codec, AD1939_DACMUTE, mute ? 0xff : 0);
+	return 0;
+}
+
+static int ad1939_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	int ret;
+
+	switch (freq) {
+	case 12288000:
+		ret = 0;	/* I know this one works okay */
+	default:
+		ret = -EINVAL;	/* don't know about others */
+	}
+	return ret;
+}
+
+#define AD1939_RATES	\
+	(SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
+	 SNDRV_PCM_RATE_192000)
+
+#define AD1939_FORMATS	\
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+
+struct snd_soc_dai ad1939_dai = {
+	.name			= CODEC_NAME,
+	.playback = {
+		.stream_name	= "Playback",
+		.channels_min	= 2,
+		.channels_max	= 4,	/* 4/8 in single/dualline TDM */
+		.rates		= AD1939_RATES,
+		.formats	= AD1939_FORMATS,
+	},
+	.capture = {
+		.stream_name	= "Capture",
+		.channels_min	= 2,
+		.channels_max	= 4,	/* 2 ADCs */
+		.rates		= AD1939_RATES,
+		.formats	= AD1939_FORMATS,
+	},
+	.ops = {
+		.hw_params	= ad1939_hw_params,
+	},
+	.dai_ops = {
+		.digital_mute	= ad1939_digmute,
+		.set_sysclk	= ad1939_set_dai_sysclk,
+		.set_fmt	= ad1939_set_dai_fmt,
+	}
+};
+EXPORT_SYMBOL_GPL(ad1939_dai);
+
+static int ad1939_init(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->codec;
+	struct ad1939_setup_data *setup = socdev->codec_data;
+	struct ad1939_private *ad = codec->private_data;
+	unsigned char r0, r1;
+	int ret;
+
+	codec->name = CODEC_NAME;
+	codec->owner = THIS_MODULE;
+	codec->set_bias_level = ad1939_set_bias_level;
+	codec->dai = &ad1939_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = sizeof(ad1939_regcache);
+	codec->reg_cache = kmemdup(ad1939_regcache,
+				   sizeof(ad1939_regcache),
+				   GFP_KERNEL);
+	if (!codec->reg_cache)
+		return -ENOMEM;
+
+	/* assume chip has no power. This way, all writes go straight
+	 * to the cache.  Once ASoC decides to wake us up, the bias
+	 * handler will write the cache straight to the chip.
+	 */
+	codec->bias_level = SND_SOC_BIAS_OFF;
+
+	/* remember TDM mode and set up internal clock routing */
+	ad->tdm_mode = setup->tdm_mode;
+	ad->drvflags = setup->drvflags;
+
+	/* limit output attenuation controls to requested number */
+	ad->mixpairs = setup->mixpairs;
+	if ((ad->mixpairs < 1) || (ad->mixpairs > 4))
+		ad->mixpairs = 4;
+
+	/* use default TDM mode if noone wants one */
+	if ((ad->tdm_mode > AD1939_TDM_MODE_DUALLINE) || (ad->tdm_mode < 1))
+		ad->tdm_mode = AD1939_TDM_MODE_TDM;
+
+	/* setup clocks */
+	r0 = ad1939_read(codec, AD1939_PLLCTL0) & ~(0xf << 3);
+	r1 = ad1939_read(codec, AD1939_PLLCTL1) & 3;
+
+	r0 |= (setup->pll_src & 3) << 5;
+	r0 |= (1<<7);	/* enable internal master clock */
+	r0 |= (setup->mclk_xo & 3) << 3;
+	r1 |= setup->dac_adc_clksrc & 7; /* DACclk/ADCclk/VREF */
+	r1 ^= AD1939_CLKSRC_ENABLE_ONCHIP_VREF;	/* VREF bit is inverted */
+
+	ad1939_write(codec, AD1939_PLLCTL0, r0);
+	ad1939_write(codec, AD1939_PLLCTL1, r1);
+
+	/* Bitclock sources for the ADC and DAC I2S interfaces */
+	r0 = ad1939_read(codec, AD1939_DACCTL1);
+	r1 = ad1939_read(codec, AD1939_ADCCTL2);
+	r0 &= ~AD1939_BCLKSRC_DAC_PLL;
+	r1 &= ~AD1939_BCLKSRC_ADC_PLL;
+	r0 |= setup->dac_adc_clksrc & AD1939_BCLKSRC_DAC_PLL;
+	r1 |= setup->dac_adc_clksrc & AD1939_BCLKSRC_ADC_PLL;
+	ad1939_write(codec, AD1939_DACCTL1, r0);
+	ad1939_write(codec, AD1939_ADCCTL2, r1);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1,
+			       SNDRV_DEFAULT_STR1);
+	if (unlikely(ret < 0)) {
+		printk(KERN_ERR CODEC_NAME ": cannot create pcms\n");
+		goto pcm_err;
+	}
+
+	ad1939_add_controls(codec);
+
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR CODEC_NAME ": cannot register card\n");
+		goto card_err;
+	}
+
+	return 0;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	kfree(codec->reg_cache);
+	return ret;
+}
+
+static void ad1939_deinit(struct snd_soc_device *socdev)
+{
+	if (socdev) {
+		ad1939_set_bias_level(socdev->codec, SND_SOC_BIAS_OFF);
+		snd_soc_free_pcms(socdev);
+		snd_soc_dapm_free(socdev);
+		/* free memory allocated in ad1939_probe() */
+		kfree(socdev->codec->private_data);
+		kfree(socdev->codec->reg_cache);
+		kfree(socdev->codec);
+	}
+}
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static int ad1939_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct snd_soc_device *socdev = client->dev.platform_data;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	codec->control_data = client;
+	i2c_set_clientdata(client, socdev);
+
+	codec->read = ad1939_i2c_read;
+	codec->write = ad1939_i2c_write;
+
+	ret = ad1939_init(socdev);
+	if (ret == 0)
+		return 0;
+
+	printk(KERN_ERR CODEC_NAME ": i2c codec init failed\n");
+
+	/* undo allocations made by platform probe */
+	kfree(codec->private_data);
+	kfree(codec);
+	return ret;
+}
+
+static int ad1939_i2c_remove(struct i2c_client *client)
+{
+	struct snd_soc_device *socdev = i2c_get_clientdata(client);
+
+	ad1939_deinit(socdev);
+
+	return 0;
+}
+
+#define ad1939_i2c_suspend NULL
+#define ad1939_i2c_resume NULL
+
+static const struct i2c_device_id ad1939_i2c_id[] = {
+	{ "ad1939", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad1939_i2c_id);
+
+static struct i2c_driver ad1939_i2c_driver = {
+	.driver = {
+		.name	= "ad1939",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad1939_i2c_probe,
+	.remove		= ad1939_i2c_remove,
+	.suspend	= ad1939_i2c_suspend,
+	.resume		= ad1939_i2c_resume,
+	.id_table	= ad1939_i2c_id,
+};
+
+static int ad1939_add_i2c_device(struct platform_device *pdev,
+				 struct ad1939_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&ad1939_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->dev_address;
+	info.platform_data = platform_get_drvdata(pdev);
+	strlcpy(info.type, "ad1939", I2C_NAME_SIZE);
+
+	adapter = i2c_get_adapter(setup->i2c_bus);
+	if (!adapter) {
+		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
+			setup->i2c_bus);
+		goto err_driver;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
+			(unsigned int)info.addr);
+		goto err_driver;
+	}
+
+	return 0;
+
+err_driver:
+	i2c_del_driver(&ad1939_i2c_driver);
+	return -ENODEV;
+}
+#endif	/* I2C */
+
+#if defined(CONFIG_SPI) && defined(CONFIG_SPI_MASTER)
+static int ad1939_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = spi->dev.platform_data;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	codec->control_data = spi;
+	codec->read = ad1939_spi_read;
+	codec->write = ad1939_spi_write;
+
+	spi_set_drvdata(spi, socdev);
+
+	ret = ad1939_init(socdev);
+	if (ret == 0)
+		return 0;
+
+	printk(KERN_ERR CODEC_NAME ": SPI codec init failed\n");
+
+	/* undo allocations made by platform probe */
+	kfree(codec->private_data);
+	kfree(codec);
+	return ret;
+}
+
+static int ad1939_spi_remove(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = spi_get_drvdata(spi);
+	ad1939_deinit(socdev);
+	return 0;
+}
+
+#define ad1939_spi_suspend NULL
+#define ad1939_spi_resume NULL
+
+static struct spi_driver ad1939_spi_driver = {
+	.driver =	{
+		.name	= "ad1939",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad1939_spi_probe,
+	.remove		= ad1939_spi_remove,
+	.suspend	= ad1939_spi_suspend,
+	.resume		= ad1939_spi_resume,
+};
+
+static int ad1939_add_spi_device(struct platform_device *pdev,
+				 struct ad1939_setup_data *setup)
+{
+	struct spi_master *master;
+	struct spi_device *spidev;
+	int ret;
+
+	ret = spi_register_driver(&ad1939_spi_driver);
+	if (ret) {
+		dev_err(&pdev->dev, "can't add spi driver\n");
+		return ret;
+	}
+
+	ret = -ENODEV;
+
+	/* pass on socdev to spi probe (spi->dev.platform_data) */
+	setup->spi_info.platform_data = platform_get_drvdata(pdev);
+
+	master = spi_busnum_to_master(setup->spi_info.bus_num);
+	if (!master) {
+		dev_err(&pdev->dev, "can't get spi master\n");
+		goto out;
+	}
+
+	spidev = spi_new_device(master, &setup->spi_info);
+	spi_master_put(master);
+	if (!spidev) {
+		dev_err(&pdev->dev, "can't register spi device\n");
+		goto out;
+	}
+
+	return 0;
+
+out:
+	spi_unregister_driver(&ad1939_spi_driver);
+	return ret;
+}
+#endif	/* SPI */
+
+static int ad1939_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct ad1939_setup_data *setup = socdev->codec_data;
+	struct snd_soc_codec *codec;
+	struct ad1939_private *ad;
+	int ret;
+
+	ret = -ENOMEM;
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		goto out;
+
+	ad = kzalloc(sizeof(struct ad1939_private), GFP_KERNEL);
+	if (ad == NULL)
+		goto out1;
+
+	codec->private_data = ad;
+	socdev->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	ad->dev_addr = setup->dev_address;	/* I2C/SPI device addr */
+
+	ret = -ENODEV;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	if (setup->bus_mode == AD1939_BUS_MODE_I2C)
+		ret = ad1939_add_i2c_device(pdev, setup);
+#endif
+#if defined(CONFIG_SPI) && defined(CONFIG_SPI_MASTER)
+	if (setup->bus_mode == AD1939_BUS_MODE_SPI)
+		ret = ad1939_add_spi_device(pdev, setup);
+#endif
+
+	if (!ret)
+		return 0;
+
+	kfree(ad);
+out1:
+	kfree(codec);
+out:
+	return ret;
+}
+
+static int ad1939_remove(struct platform_device *pdev)
+{
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&ad1939_i2c_driver);
+#endif
+#if defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)
+	spi_unregister_driver(&ad1939_spi_driver);
+#endif
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_ad1939 = {
+	.probe		= ad1939_probe,
+	.remove		= ad1939_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_ad1939);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ASoC AD1935-AD1939 I2S Codec family driver");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/codecs/ad1939.h b/sound/soc/codecs/ad1939.h
new file mode 100644
index 0000000..72931d5
--- /dev/null
+++ b/sound/soc/codecs/ad1939.h
@@ -0,0 +1,122 @@
+/*
+ * AD1935/AD1936/AD1937/AD1938/AD1939 I2S ASoC Codec driver
+ *
+ * Copyright (c) 2007-2008 MSC Vertriebsges.m.b.H,	www.exm32.com
+ *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * licensed under the GPLv2
+ *
+ */
+
+#ifndef _AD1939_H_
+#define _AD1939_H_
+
+#include <linux/spi/spi.h>
+
+#define AD1939_PLLCTL0	0x00
+#define AD1939_PLLCTL1	0x01
+#define AD1939_DACCTL0	0x02
+#define AD1939_DACCTL1	0x03
+#define AD1939_DACCTL2	0x04
+#define AD1939_DACMUTE	0x05
+#define AD1939_VOL1L	0x06
+#define AD1939_VOL1R	0x07
+#define AD1939_VOL2L	0x08
+#define AD1939_VOL2R	0x09
+#define AD1939_VOL3L	0x0A
+#define AD1939_VOL3R	0x0B
+#define AD1939_VOL4L	0x0C
+#define AD1939_VOL4R	0x0D
+#define AD1939_ADCCTL0	0x0E
+#define AD1939_ADCCTL1	0x0F
+#define AD1939_ADCCTL2	0x10
+
+#define AD1939_REGCOUNT	0x11
+
+/*
+ * AD1939 setup data
+ */
+
+/* TDM modes. Have a look at the manual to understand what these do. */
+#define AD1939_TDM_MODE_TDM		1
+#define AD1939_TDM_MODE_AUX		2
+#define AD1939_TDM_MODE_DUALLINE	3
+
+/* Master PLL clock source, select one */
+#define AD1939_PLL_SRC_MCLK		0	/* external clock */
+#define AD1939_PLL_SRC_DACLRCK		1	/* get from DAC LRCLK */
+#define AD1939_PLL_SRC_ADCLRCK		2	/* get from ADC LRCLK */
+
+/* clock sources for ADC, DAC. Refer to the manual for more information
+ * (for 192000kHz modes, internal PLL _MUST_ be used). Select one for ADC
+ * and DAC.
+ */
+#define AD1939_CLKSRC_DAC_PLL		0	/* DAC clocked by int. PLL */
+#define AD1939_CLKSRC_DAC_MCLK		(1<<0)	/* DAC clocked by ext. MCK */
+#define AD1939_CLKSRC_ADC_PLL		0	/* ADC clocked by int. PLL */
+#define AD1939_CLKSRC_ADC_MCLK		(1<<1)	/* ADC clocked by ext. MCK */
+#define AD1939_CLKSRC_ENABLE_ONCHIP_VREF	(1<<2)
+
+/* I2S Bitclock sources for DAC and ADC I2S interfaces.
+ * OR it to ad1939_setup_data.dac_adc_clksrc. Select one for ADC and DAC.
+ */
+#define AD1939_BCLKSRC_DAC_EXT		0	/* DAC I2SCLK from DBCLK pin */
+#define AD1939_BCLKSRC_DAC_PLL		(1<<6)	/* DAC I2SCLK from int. PLL */
+#define AD1939_BCLKSRC_ADC_EXT		0	/* DAC I2SCLK from DBCLK pin */
+#define AD1939_BCLKSRC_ADC_PLL		(1<<7)	/* DAC I2SCLK from int. PLL */
+
+/* MCLK_XO pin configuration */
+#define AD1939_MCLKXO_MCLKXI		0	/* mirror MCLK_XI pin */
+#define AD1939_MCLKXO_256FS		1
+#define AD1939_MCLKXO_512FS		2
+#define AD1939_MCLKXO_OFF		3	/* disable MCLK_XO output */
+
+/* driver specific flags */
+/* specify these flags if the LRCK and/or BCK pins of the ADC and DAC
+ * parts are wired together on the PCB; to prevent both units from driving
+ * the pin and resulting bad signals.  You then have to specify WHICH
+ * unit gets to be the Master (clock generator) and which is slave.
+ * NOTE: this is only used if the CODEC is configured as either BCK or
+ * LRCK master; if the codec is BCK/LRCK slave (BCK and LRCK are driven
+ * by external components) these settings are ignored!
+ */
+#define AD1939_DRV_ADCDAC_COMMON_BCK	(1<<0)
+#define AD1939_DRV_ADCDAC_COMMON_LRCK	(1<<1)
+
+/* define which unit gets to drive the BCK/LRCK pins if the codec is
+ * required to be either BCK or LRCK master
+ */
+#define AD1939_DRV_DAC_LRCK_MASTER	0
+#define AD1939_DRV_ADC_LRCK_MASTER	(1<<2)
+#define AD1939_DRV_DAC_BCK_MASTER	0
+#define AD1939_DRV_ADC_BCK_MASTER	(1<<3)
+
+/* use TDM mode even for stereo (2-channel) signals */
+#define AD1939_DRV_TDM_STEREO		(1<<4)
+
+#define AD1939_BUS_MODE_I2C		1
+#define AD1939_BUS_MODE_SPI		2
+
+struct ad1939_setup_data {
+	/* control interface configuration */
+	/* device address, WITHOUT the R/W bit! (default 0x04) */
+	unsigned char dev_address;	/* I2C or SPI device address */
+	unsigned char bus_mode;		/* which framework to register with */
+
+	unsigned char i2c_bus;		/* I2C bus the device is on */
+
+	struct spi_board_info	spi_info;	/* SPI conn info */
+
+	/* configuration */
+	unsigned char tdm_mode;		/* one of AD1939_TDM_MODE_* */
+	unsigned char pll_src;		/* one of AD1939_PLL_SRC_* */
+	unsigned char dac_adc_clksrc;	/* AD1939_{B,}CLKSRC_* or'ed */
+	unsigned char mclk_xo;		/* one of AD1939_MCLKXO_* */
+	unsigned char drvflags;		/* driver flags */
+	unsigned char mixpairs;		/* mixer pairs (L-R) to advertise */
+};
+
+extern struct snd_soc_codec_device	soc_codec_dev_ad1939;
+extern struct snd_soc_dai		ad1939_dai;
+
+#endif
-- 
1.6.0.1
