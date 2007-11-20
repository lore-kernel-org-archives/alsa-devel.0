From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Add ASoC TLV320 Codec driver.
Date: Tue, 20 Nov 2007 09:25:39 +0000
Message-ID: <1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F95824A09
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:44:08 +0100 (CET)
In-Reply-To: <1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: liam.girdwood@opensource.wolfsonmicro.com, Liam Girdwood <liam@localhost.localdomain>, i2c@lm-sensors.org, Nicola Perrino <nicola.perrino@atlab.it>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam@localhost.localdomain>

Signed-off-by: Nicola Perrino <nicola.perrino@atlab.it>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: i2c@lm-sensors.org
---
 include/linux/i2c-id.h    |    1 +
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/tlv320.c |  603 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320.h |  111 +++++++++
 5 files changed, 721 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320.c
 create mode 100644 sound/soc/codecs/tlv320.h

diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 5ced329..f6a1ddf 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -122,6 +122,7 @@
 #define I2C_DRIVERID_VP27SMPX	93	/* Panasonic VP27s tuner internal MPX */
 #define I2C_DRIVERID_CS4270	94	/* Cirrus Logic 4270 audio codec */
 #define I2C_DRIVERID_AK4535	95	/* AK4525 audio codec */
+#define I2C_DRIVERID_TLV320	97	/* TLV 320 audio codec */
 
 #define I2C_DRIVERID_I2CDEV	900
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8244107..2608499 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -6,6 +6,10 @@ config SND_SOC_AK4535
 	tristate
 	depends on SND_SOC
 
+config SND_SOC_TLV320
+	tristate
+	depends on SND_SOC
+
 config SND_SOC_WM8731
 	tristate
 	depends on SND_SOC
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6859145..3cce68b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,5 +1,6 @@
 snd-soc-ac97-objs := ac97.o
 snd-soc-ak4535-objs := ak4535.o
+snd-soc-tlv320-objs := tlv320.o
 snd-soc-wm8731-objs := wm8731.o
 snd-soc-wm8750-objs := wm8750.o
 snd-soc-wm8753-objs := wm8753.o
@@ -9,6 +10,7 @@ snd-soc-cs4270-objs := cs4270.o
 
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
+obj-$(CONFIG_SND_SOC_TLV320)	+= snd-soc-tlv320.o
 obj-$(CONFIG_SND_SOC_WM8731)	+= snd-soc-wm8731.o
 obj-$(CONFIG_SND_SOC_WM8750)	+= snd-soc-wm8750.o
 obj-$(CONFIG_SND_SOC_WM8753)	+= snd-soc-wm8753.o
diff --git a/sound/soc/codecs/tlv320.c b/sound/soc/codecs/tlv320.c
new file mode 100644
index 0000000..58c7c3e
--- /dev/null
+++ b/sound/soc/codecs/tlv320.c
@@ -0,0 +1,603 @@
+/*
+ * tlv320.c  --  TLV 320 ALSA Soc Audio driver
+ *
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2006 Atlab srl.
+ *
+ * Authors: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *          Nicola Perrino <nicola.perrino@atlab.it>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "tlv320.h"
+
+#define AUDIO_NAME "tlv320"
+#define TLV320_VERSION "0.1"
+
+/*
+ * Debug
+ */
+
+//#define TLV320_DEBUG 0
+
+#ifdef TLV320_DEBUG
+#define dbg(format, arg...) \
+	printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
+#else
+#define dbg(format, arg...) do {} while (0)
+#endif
+#define err(format, arg...) \
+	printk(KERN_ERR AUDIO_NAME ": " format "\n" , ## arg)
+#define info(format, arg...) \
+	printk(KERN_INFO AUDIO_NAME ": " format "\n" , ## arg)
+#define warn(format, arg...) \
+	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
+
+
+#define TLV320_VOICE_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000)
+
+
+#define TLV320_VOICE_BITS \
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+
+static int caps_charge = 2000;
+static int setting = 1;
+module_param(caps_charge, int, 0);
+module_param(setting, int, 0);
+MODULE_PARM_DESC(caps_charge, "TLV320 cap charge time (msecs)");
+
+static struct workqueue_struct *tlv320_workq = NULL;
+//static struct work_struct tlv320_dapm_work;
+
+/* codec private data */
+struct tlv320_priv {
+	unsigned int sysclk;
+	unsigned int pcmclk;
+};
+
+
+#ifdef TLV320AIC24K
+/* ADDR table */
+static const unsigned char tlv320_reg_addr[] = {
+	0x00,	/* CONTROL REG 0 No Operation */
+	0x01,	/* CONTROL REG 1  */
+        0x02,	/* CONTROL REG 2  */
+        0x03,	/* CONTROL REG 3A */
+        0x03,	/* CONTROL REG 3B */
+        0x03, 	/* CONTROL REG 3C */
+        0x03,	/* CONTROL REG 3D */
+        0x04,	/* CONTROL REG 4  */
+        0x04,	/* CONTROL REG 4 Bis */
+        0x05,	/* CONTROL REG 5A */
+        0x05,	/* CONTROL REG 5B */
+        0x05,	/* CONTROL REG 5C */
+        0x05,	/* CONTROL REG 5D */
+        0x06,	/* CONTROL REG 6A */
+        0x06,	/* CONTROL REG 6B */
+};
+
+/*
+ *  DATA case digital SET1:
+ *     SSP -> DAC -> OUT
+ *     IN  -> ADC -> SSP
+ *     IN = HNSI (MIC)
+ *     OUT = HDSO (SPKG)
+ *  Usage: playback, capture streams
+ */
+static const unsigned char tlv320_reg_data_init_set1[] = {
+	0x00,	/* CONTROL REG 0 No Operation */
+	0x49,	/* CONTROL REG 1  */
+        0x20,	/* CONTROL REG 2  */
+        0x01,	/* CONTROL REG 3A */
+        0x40,	/* CONTROL REG 3B */
+        0x81,	/* CONTROL REG 3C */
+        0xc0,	/* CONTROL REG 3D */
+        0x02,//0x42(16khz),//0x10,	/* CONTROL REG 4  */
+        0x88,//0x90,	/* CONTROL REG 4 Bis */
+        0x00,	/* CONTROL REG 5A */
+        0x40,//(0dB)	/* CONTROL REG 5B */
+        0xbf,	/* CONTROL REG 5C */
+        0xc0,	/* CONTROL REG 5D */
+        0x02,//(HNSI) 	/* CONTROL REG 6A */
+        0x81 //(HDSO) 	/* CONTROL REG 6B */
+};
+
+/*
+ *  DATA case digital SET2:
+ *     SSP -> DAC -> OUT
+ *     IN  -> ADC -> SSP
+ *     IN = HDSI (PHONE IN)
+ *     OUT = HNSO (PHONE OUT)
+ *  Usage: playback, capture streams
+ */
+static const unsigned char tlv320_reg_data_init_set2[] = {
+	0x00,	/* CONTROL REG 0 No Operation */
+	0x49,	/* CONTROL REG 1  */
+        0x20,	/* CONTROL REG 2  */
+        0x01,	/* CONTROL REG 3A */
+        0x40,	/* CONTROL REG 3B */
+        0x81,	/* CONTROL REG 3C */
+        0xc0,	/* CONTROL REG 3D */
+        0x02,//0x42(16khz),//0x10,	/* CONTROL REG 4  */
+        0x88,//0x90,	/* CONTROL REG 4 Bis */
+        0x00,	/* CONTROL REG 5A */
+        0x52,//(-27dB) 	/* CONTROL REG 5B */
+        0xbf,	/* CONTROL REG 5C */
+        0xc0,	/* CONTROL REG 5D */
+        0x01,//(PHONE IN) 	/* CONTROL REG 6A */
+        0x82 //(PHONE OUT) 	/* CONTROL REG 6B */
+};
+
+/*
+ *  DATA case analog:
+ *     ADC, DAC, SSP off
+ *     Headset input to output (HDSI2O -> 1)
+ *     Handset input to output (HNSI2O -> 1)
+ *  Usage: room monitor
+ */
+static const unsigned char tlv320_reg_data_init_set3[] = {
+	0x00,	/* CONTROL REG 0 No Operation */
+	0x08,   /* CONTROL REG 1  */
+        0x20,   /* CONTROL REG 2  */
+        0x11,   /* CONTROL REG 3A */
+        0x40,	/* CONTROL REG 3B */
+        0x80,   /* CONTROL REG 3C */
+        0xc0,   /* CONTROL REG 3D */
+        0x00,   /* CONTROL REG 4  */
+        0x00,   /* CONTROL REG 5A */
+        0x40,   /* CONTROL REG 5B */
+        0x80,   /* CONTROL REG 5C */
+        0xc0,   /* CONTROL REG 5D */
+        0x60,   /* CONTROL REG 6A */
+        0x80    /* CONTROL REG 6B */
+};
+
+#else // TLV320AIC14k
+
+/* ADDR table */
+static const unsigned char tlv320_reg_addr[] = {
+	0x00,	/* CONTROL REG 0 No Operation */
+	0x01,	/* CONTROL REG 1  */
+        0x02,	/* CONTROL REG 2  */
+        0x03,	/* CONTROL REG 3 */
+        0x04,	/* CONTROL REG 4  */
+        0x04,	/* CONTROL REG 4 Bis */
+        0x05,	/* CONTROL REG 5A */
+        0x05,	/* CONTROL REG 5B */
+        0x05,	/* CONTROL REG 5C */
+        0x05,	/* CONTROL REG 5D */
+        0x06	/* CONTROL REG 6 */
+};
+
+/*
+ *  DATA case digital:
+ *     SSP -> DAC -> OUT
+ *     IN  -> ADC -> SSP
+ *  Usage: playback, capture streams
+ */
+static const unsigned char tlv320_reg_data_init_set1[] = {
+	0x00,	/* CONTROL REG 0 No Operation */
+	0x41,	/* CONTROL REG 1  */
+        0x20,	/* CONTROL REG 2  */
+        0x09,	/* CONTROL REG 3 */
+        0x02,//0x42(16khz),//0x10,	/* CONTROL REG 4  */
+        0x88,//0x90,	/* CONTROL REG 4 Bis */
+        0x2A,	/* CONTROL REG 5A */
+        0x6A,	/* CONTROL REG 5B */
+        0xbc,	/* CONTROL REG 5C */
+        0xc0,	/* CONTROL REG 5D */
+        0x00	/* CONTROL REG 6 */
+};
+#endif
+/*
+ * read tlv320 register cache
+ */
+static inline unsigned int tlv320_read_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u8 *cache = codec->reg_cache;
+	if (reg > ARRAY_SIZE(tlv320_reg_addr))
+		return -1;
+	return cache[reg];
+}
+
+/*
+ * write tlv320 register cache
+ */
+static inline void tlv320_write_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg, unsigned int value)
+{
+	u8 *cache = codec->reg_cache;
+	if (reg > ARRAY_SIZE(tlv320_reg_addr))
+		return;
+	cache[reg] = value;
+}
+
+/*
+ * read tlv320
+ */
+static int tlv320_read (struct snd_soc_codec *codec, u8 reg)
+{
+	return i2c_smbus_read_byte_data(codec->control_data, reg);
+}
+
+/*
+ * write tlv320
+ */
+static int tlv320_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int value)
+{
+	if (tlv320_reg_addr[reg] > 0x06)
+		return -1;
+
+	tlv320_write_reg_cache (codec, reg, value);
+
+	return i2c_smbus_write_byte_data(codec->control_data, tlv320_reg_addr[reg], value);
+}
+
+
+/*
+ * write block tlv320
+ */
+static int tlv320_write_block (struct snd_soc_codec *codec,
+	const u8 *data, unsigned int len)
+{
+	int ret = -1;
+	int i;
+
+	for (i=0; i<len; i++) {
+		dbg("addr = 0x%02x, data = 0x%02x", tlv320_reg_addr[i], data[i]);
+		if ((ret = tlv320_write(codec, i, data[i])) < 0)
+			break;
+	}
+
+	return ret;
+}
+
+
+static int tlv320_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+		unsigned int fmt)
+{
+	dbg("tlv320_set_dai_fmt enter");
+	return 0;
+}
+
+/*
+ * Set PCM DAI bit size and sample rate.
+ */
+static int tlv320_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	dbg("tlv320_pcm_hw_params enter");
+	return 0;
+}
+
+
+static int tlv320_config_pcm_sysclk(struct snd_soc_codec_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	dbg("tlv320_config_pcm_sysclk enter");
+	return 0;
+}
+
+
+/*
+ *  Voice over PCM DAI
+ */
+struct snd_soc_codec_dai tlv320_dai[] = {
+{	.name = "TLV320 Voice",
+	.id = 1,
+	.playback = {
+		.stream_name = "Voice Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = TLV320_VOICE_RATES,
+		.formats = TLV320_VOICE_BITS,},
+	.capture = {
+		.stream_name = "Voice Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = TLV320_VOICE_RATES,
+		.formats = TLV320_VOICE_BITS,},
+	.ops = {
+		.hw_params = tlv320_pcm_hw_params,},
+	.dai_ops = {
+		.digital_mute = NULL,
+		.set_fmt = tlv320_set_dai_fmt,
+		.set_clkdiv = NULL,
+		.set_pll = NULL,
+		.set_sysclk = tlv320_config_pcm_sysclk,
+	},
+},
+
+
+};
+EXPORT_SYMBOL_GPL(tlv320_dai);
+
+
+static void tlv320_work(struct work_struct *work)
+{
+#if 0
+	struct snd_soc_codec *codec =
+		container_of(work, struct snd_soc_codec, delayed_work.work);
+	//wm8753_dapm_event(codec, codec->dapm_state);
+#endif
+}
+
+/*
+ * initialise the TLV320 driver
+ * register the mixer and dsp interfaces with the kernel
+ */
+static int tlv320_init(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret = 0;
+
+	codec->name = "TLV320";
+	codec->owner = THIS_MODULE;
+	codec->read = tlv320_read_reg_cache;
+	codec->write = tlv320_write;
+	codec->dai = tlv320_dai;
+	codec->num_dai = ARRAY_SIZE(tlv320_dai);
+	codec->reg_cache_size = sizeof(tlv320_reg_addr);
+
+	codec->reg_cache =
+		kmemdup(tlv320_reg_addr, sizeof(tlv320_reg_addr), GFP_KERNEL);
+	if (codec->reg_cache == NULL)
+		return -ENOMEM;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		kfree(codec->reg_cache);
+		return ret;
+	}
+
+	queue_delayed_work(tlv320_workq,
+		&codec->delayed_work, msecs_to_jiffies(caps_charge));
+
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		snd_soc_free_pcms(socdev);
+		snd_soc_dapm_free(socdev);
+	}
+
+	return ret;
+}
+
+/* If the i2c layer weren't so broken, we could pass this kind of data
+   around */
+static struct snd_soc_device *tlv320_socdev;
+
+#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+
+static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
+
+/* Magic definition of all other variables and things */
+I2C_CLIENT_INSMOD;
+
+static struct i2c_driver tlv320_i2c_driver;
+static struct i2c_client client_template;
+
+static int tlv320_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct snd_soc_device *socdev = tlv320_socdev;
+	struct tlv320_setup_data *setup = socdev->codec_data;
+	struct snd_soc_codec *codec = socdev->codec;
+	struct i2c_client *i2c;
+	int ret, len;
+        const unsigned char *data;
+
+	if (addr != setup->i2c_address)
+		return -ENODEV;
+
+	client_template.adapter = adap;
+	client_template.addr = addr;
+
+	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
+	if (i2c == NULL){
+		kfree(codec);
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = i2c_attach_client(i2c);
+	if (ret < 0) {
+		err("failed to attach codec at addr %x\n", addr);
+		goto err;
+	}
+
+	ret = tlv320_init(socdev);
+	if (ret < 0) {
+		err("failed to initialise TLV320\n");
+		goto err;
+	}
+
+	switch(setting) {
+	case 1:
+		data = tlv320_reg_data_init_set1;
+		len = sizeof(tlv320_reg_data_init_set1);
+		break;
+	case 2:
+		data = tlv320_reg_data_init_set2;
+		len = sizeof(tlv320_reg_data_init_set2);
+		break;
+	case 3:
+		data = tlv320_reg_data_init_set3;
+		len = sizeof(tlv320_reg_data_init_set3);
+		break;
+	default:
+		data = tlv320_reg_data_init_set1;
+		len = sizeof(tlv320_reg_data_init_set1);
+		break;
+	}
+
+	ret = tlv320_write_block(codec, data, len);
+
+	if (ret < 0) {
+		err("attach error: init status %d\n", ret);
+	} else {
+		info("attach: chip tlv320 at address 0x%02x",
+			tlv320_read(codec, 0x02) << 1);
+	}
+
+        //tlv320_write(codec, CODEC_REG6B, 0x80);
+#if 0
+	int value;
+	int i;
+
+	for (i=0; i<len; i++) {
+		value = tlv320_read(codec, tlv320_reg_addr[i]);
+		dbg("read addr = 0x%02x, data = 0x%02x", tlv320_reg_addr[i], value);
+		mdelay(10);
+	}
+
+#endif
+
+
+	return ret;
+
+err:
+	kfree(codec);
+	kfree(i2c);
+	return ret;
+}
+
+static int tlv320_i2c_detach(struct i2c_client *client)
+{
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
+	i2c_detach_client(client);
+	kfree(codec->reg_cache);
+	kfree(client);
+	return 0;
+}
+
+static int tlv320_i2c_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, tlv320_codec_probe);
+}
+
+/* tlv320 i2c codec control layer */
+static struct i2c_driver tlv320_i2c_driver = {
+	.driver = {
+		.name = "tlv320 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.id =             I2C_DRIVERID_TLV320,
+	.attach_adapter = tlv320_i2c_attach,
+	.detach_client =  tlv320_i2c_detach,
+	.command =        NULL,
+};
+
+static struct i2c_client client_template = {
+	.name =   "tlv320",
+	.driver = &tlv320_i2c_driver,
+};
+#endif
+
+static int tlv320_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct tlv320_setup_data *setup;
+	struct snd_soc_codec *codec;
+	int ret = 0;
+	struct tlv320_priv *tlv320;
+
+	info("TLV320 Audio Codec %s", TLV320_VERSION);
+
+	setup = socdev->codec_data;
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
+	tlv320 = kzalloc(sizeof(struct tlv320_priv), GFP_KERNEL);
+	if (tlv320 == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	codec->private_data = tlv320;
+
+	socdev->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+	tlv320_socdev = socdev;
+
+	INIT_DELAYED_WORK(&codec->delayed_work, tlv320_work);
+	tlv320_workq = create_workqueue("tlv320");
+	if (tlv320_workq == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+	if (setup->i2c_address) {
+		normal_i2c[0] = setup->i2c_address;
+		codec->hw_write = (hw_write_t)i2c_master_send;
+		ret = i2c_add_driver(&tlv320_i2c_driver);
+		if (ret != 0)
+			printk(KERN_ERR "can't add i2c driver");
+	}
+#else
+		/* Add other interfaces here */
+#endif
+	return ret;
+}
+
+/* power down chip */
+static int tlv320_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	if (tlv320_workq)
+		destroy_workqueue(tlv320_workq);
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+	i2c_del_driver(&tlv320_i2c_driver);
+#endif
+	kfree(codec->private_data);
+	kfree(codec);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_tlv320 = {
+	.probe = 	tlv320_probe,
+	.remove = 	tlv320_remove,
+};
+
+EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320);
+
+MODULE_DESCRIPTION("ASoC TLV320 driver");
+MODULE_AUTHOR("Nicola Perrino");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320.h b/sound/soc/codecs/tlv320.h
new file mode 100644
index 0000000..bbcd53d
--- /dev/null
+++ b/sound/soc/codecs/tlv320.h
@@ -0,0 +1,111 @@
+/*
+ * tlv320.h  --  TLV 320 ALSA Soc Audio driver
+ *
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2006 Atlab srl.
+ *
+ * Authors: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *          Nicola Perrino <nicola.perrino@atlab.it>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef _TLV320_H
+#define _TLV320_H
+
+#define TLV320AIC24K
+
+
+/* TLV320 register space */
+#define CODEC_NOOP	0x00
+#define CODEC_REG1	0x01
+#define CODEC_REG2	0x02
+#define CODEC_REG3A	0x03
+#define CODEC_REG3B	0x04
+#define CODEC_REG3C	0x05
+#define CODEC_REG3D	0x06
+#define CODEC_REG4A	0x07
+#define CODEC_REG4B	0x08
+#define CODEC_REG5A	0x09
+#define CODEC_REG5B	0x0a
+#define CODEC_REG5C	0x0b
+#define CODEC_REG5D	0x0c
+#define CODEC_REG6A	0x0d
+#define CODEC_REG6B	0x0e
+
+
+//	Control Register 1
+#define REG1_CONTINUOUS			0x40
+#define REG1_IIR_EN			0x20
+#define REG1_MIC_BIAS_235		0x08
+#define REG1_ANALOG_LOOP_BACK		0x04
+#define REG1_DIGITAL_LOOP_BACK		0x02
+#define REG1_DAC16			0x01
+
+//	Control Register 2
+#define REG2_TURBO_EN			0x80
+#define REG2_FIR_BYPASS			0x40
+#define REG2_GPIO			0x02
+#define REG2_GPIO_1			0x06
+
+//	Control Register 3A
+#define REG3_PWDN_ALL			0x30
+#define REG3_PWDN_ADC			0x10
+#define REG3_PWDN_DAC			0x20
+#define REG3_SW_RESET			0x08
+#define REG3_SAMPLING_FACTOR1		0x01
+#define REG3_SAMPLING_FACTOR2		0x02
+
+//	Control Register 3B
+#define REG3_8KBP_EN			0x60
+#define REG3_MUTE_OUTP1			0x42
+#define REG3_MUTE_OUTP2			0x48
+#define REG3_MUTE_OUTP3			0x44
+
+//	Control Register 4
+#define REG4_FSDIV_M			0x85	//M=5
+#define REG4_FSDIV_NP			0x08	//N=1, P=8
+//#define REG4_FSDIV_NP			0x01	//N=1, P=8
+#define REG4_FSDIV_NP1			0x02	//N=16, P=2
+
+//	Control Register 5
+#define REG5A_ADC_GAIN			0x02	//3dB
+#define REG5A_ADC_MUTE			0x0f	//Mute
+#define REG5B_DAC_GAIN			0x42	//-3dB
+#define REG5B_DAC_MUTE			0x4f	//Mute
+#define REG5C_SIDETONE_MUTE		0xBF
+
+//	Control Register 6
+#define REG6A_AIC24A_CH1_IN		0x08	//INP1 to ADC
+#define REG6B_AIC24A_CH1_OUT		0x82	//OUTP2 to DAC
+#define REG6A_AIC24A_CH2_IN		0x02	//INP2 to ADC
+#define REG6B_AIC24A_CH2_OUT		0x81	//OUTP3 to DAC
+
+/* clock inputs */
+#define TLV320_MCLK		0
+#define TLV320_PCMCLK		1
+
+
+struct tlv320_setup_data {
+	unsigned short i2c_address;
+};
+
+/* DAI ifmodes */
+/* mode 1 IFMODE = 00 */
+#define TLV320_DAI_MODE1_VOICE	0
+#define TLV320_DAI_MODE1_HIFI	1
+/* mode 2 IFMODE = 01 */
+#define TLV320_DAI_MODE2_VOICE	2
+/* mode 3 IFMODE = 10 */
+#define TLV320_DAI_MODE3_HIFI	3
+/* mode 4 IFMODE = 11 */
+#define TLV320_DAI_MODE4_HIFI	4
+
+extern struct snd_soc_codec_dai tlv320_dai[5];
+extern struct snd_soc_codec_device soc_codec_dev_tlv320;
+
+#endif
-- 
1.5.3.5
