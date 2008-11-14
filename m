From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Add WM8728 codec driver
Date: Fri, 14 Nov 2008 14:58:46 +0000
Message-ID: <1226674726-11678-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081114145705.GA11635@rakim.wolfsonmicro.main>
	<1226674726-11678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226674726-11678-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226674726-11678-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B10051037F3
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 15:58:47 +0100 (CET)
In-Reply-To: <1226674726-11678-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8728 is a high performance stereo DAC designed for applications
such as DVD, home theatre and digital TV.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/wm8728.c |  574 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8728.h |   30 +++
 4 files changed, 610 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wm8728.c
 create mode 100644 sound/soc/codecs/wm8728.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b73c36a..8a84460 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -13,6 +13,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WM8510 if (I2C || SPI_MASTER)
 	select SND_SOC_WM8580 if I2C
+	select SND_SOC_WM8728 if (I2C || SPI_MASTER)
 	select SND_SOC_WM8731 if (I2C || SPI_MASTER)
 	select SND_SOC_WM8750 if (I2C || SPI_MASTER)
 	select SND_SOC_WM8753 if (I2C || SPI_MASTER)
@@ -93,6 +94,9 @@ config SND_SOC_WM8510
 config SND_SOC_WM8580
 	tristate
 
+config SND_SOC_WM8728
+	tristate
+
 config SND_SOC_WM8731
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3b9b58a..7ae17a6 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -11,6 +11,7 @@ snd-soc-twl4030-objs := twl4030.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wm8510-objs := wm8510.o
 snd-soc-wm8580-objs := wm8580.o
+snd-soc-wm8728-objs := wm8728.o
 snd-soc-wm8731-objs := wm8731.o
 snd-soc-wm8750-objs := wm8750.o
 snd-soc-wm8753-objs := wm8753.o
@@ -34,6 +35,7 @@ obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WM8510)	+= snd-soc-wm8510.o
 obj-$(CONFIG_SND_SOC_WM8580)	+= snd-soc-wm8580.o
+obj-$(CONFIG_SND_SOC_WM8728)	+= snd-soc-wm8728.o
 obj-$(CONFIG_SND_SOC_WM8731)	+= snd-soc-wm8731.o
 obj-$(CONFIG_SND_SOC_WM8750)	+= snd-soc-wm8750.o
 obj-$(CONFIG_SND_SOC_WM8753)	+= snd-soc-wm8753.o
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
new file mode 100644
index 0000000..3e39dea
--- /dev/null
+++ b/sound/soc/codecs/wm8728.c
@@ -0,0 +1,574 @@
+/*
+ * wm8728.c  --  WM8728 ALSA SoC Audio driver
+ *
+ * Copyright 2008 Wolfson Microelectronics plc
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
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
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "wm8728.h"
+
+struct snd_soc_codec_device soc_codec_dev_wm8728;
+
+/*
+ * We can't read the WM8728 register space so we cache them instead.
+ * Note that the defaults here aren't the physical defaults, we latch
+ * the volume update bits, mute the output and enable infinite zero
+ * detect.
+ */
+static const u16 wm8728_reg_defaults[] = {
+	0x1ff,
+	0x1ff,
+	0x001,
+	0x100,
+};
+
+static inline unsigned int wm8728_read_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+	BUG_ON(reg > ARRAY_SIZE(wm8728_reg_defaults));
+	return cache[reg];
+}
+
+static inline void wm8728_write_reg_cache(struct snd_soc_codec *codec,
+	u16 reg, unsigned int value)
+{
+	u16 *cache = codec->reg_cache;
+	BUG_ON(reg > ARRAY_SIZE(wm8728_reg_defaults));
+	cache[reg] = value;
+}
+
+/*
+ * write to the WM8728 register space
+ */
+static int wm8728_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int value)
+{
+	u8 data[2];
+
+	/* data is
+	 *   D15..D9 WM8728 register offset
+	 *   D8...D0 register data
+	 */
+	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
+	data[1] = value & 0x00ff;
+
+	wm8728_write_reg_cache(codec, reg, value);
+
+	if (codec->hw_write(codec->control_data, data, 2) == 2)
+		return 0;
+	else
+		return -EIO;
+}
+
+static const DECLARE_TLV_DB_SCALE(wm8728_tlv, -12750, 50, 1);
+
+static const struct snd_kcontrol_new wm8728_snd_controls[] = {
+
+SOC_DOUBLE_R_TLV("Digital Playback Volume", WM8728_DACLVOL, WM8728_DACRVOL,
+		 0, 255, 0, wm8728_tlv),
+
+SOC_SINGLE("Deemphasis", WM8728_DACCTL, 1, 1, 0),
+};
+
+static int wm8728_add_controls(struct snd_soc_codec *codec)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(wm8728_snd_controls); i++) {
+		err = snd_ctl_add(codec->card,
+				  snd_soc_cnew(&wm8728_snd_controls[i],
+						codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * DAPM controls.
+ */
+static const struct snd_soc_dapm_widget wm8728_dapm_widgets[] = {
+SND_SOC_DAPM_DAC("DAC", "HiFi Playback", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_OUTPUT("VOUTL"),
+SND_SOC_DAPM_OUTPUT("VOUTR"),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"VOUTL", NULL, "DAC"},
+	{"VOUTR", NULL, "DAC"},
+};
+
+static int wm8728_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, wm8728_dapm_widgets,
+				  ARRAY_SIZE(wm8728_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	snd_soc_dapm_new_widgets(codec);
+
+	return 0;
+}
+
+static int wm8728_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 mute_reg = wm8728_read_reg_cache(codec, WM8728_DACCTL);
+
+	if (mute)
+		wm8728_write(codec, WM8728_DACCTL, mute_reg | 1);
+	else
+		wm8728_write(codec, WM8728_DACCTL, mute_reg & ~1);
+
+	return 0;
+}
+
+static int wm8728_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	u16 dac = wm8728_read_reg_cache(codec, WM8728_DACCTL);
+
+	dac &= ~0x18;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		dac |= 0x10;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dac |= 0x08;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	wm8728_write(codec, WM8728_DACCTL, dac);
+
+	return 0;
+}
+
+static int wm8728_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 iface = wm8728_read_reg_cache(codec, WM8728_IFCTL);
+
+	/* Currently only I2S is supported by the driver, though the
+	 * hardware is more flexible.
+	 */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface |= 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* The hardware only support full slave mode */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		iface &= ~0x22;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface |=  0x20;
+		iface &= ~0x02;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		iface |= 0x02;
+		iface &= ~0x20;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		iface |= 0x22;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	wm8728_write(codec, WM8728_IFCTL, iface);
+	return 0;
+}
+
+static int wm8728_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	u16 reg;
+	int i;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+	case SND_SOC_BIAS_STANDBY:
+		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			/* Power everything up... */
+			reg = wm8728_read_reg_cache(codec, WM8728_DACCTL);
+			wm8728_write(codec, WM8728_DACCTL, reg & ~0x4);
+
+			/* ..then sync in the register cache. */
+			for (i = 0; i < ARRAY_SIZE(wm8728_reg_defaults); i++)
+				wm8728_write(codec, i,
+					     wm8728_read_reg_cache(codec, i));
+		}
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		reg = wm8728_read_reg_cache(codec, WM8728_DACCTL);
+		wm8728_write(codec, WM8728_DACCTL, reg | 0x4);
+		break;
+	}
+	codec->bias_level = level;
+	return 0;
+}
+
+#define WM8728_RATES (SNDRV_PCM_RATE_8000_192000)
+
+#define WM8728_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+	SNDRV_PCM_FMTBIT_S24_LE)
+
+struct snd_soc_dai wm8728_dai = {
+	.name = "WM8728",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = WM8728_RATES,
+		.formats = WM8728_FORMATS,
+	},
+	.ops = {
+		 .hw_params = wm8728_hw_params,
+	},
+	.dai_ops = {
+		 .digital_mute = wm8728_mute,
+		 .set_fmt = wm8728_set_dai_fmt,
+	}
+};
+EXPORT_SYMBOL_GPL(wm8728_dai);
+
+static int wm8728_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	wm8728_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int wm8728_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	wm8728_set_bias_level(codec, codec->suspend_bias_level);
+
+	return 0;
+}
+
+/*
+ * initialise the WM8728 driver
+ * register the mixer and dsp interfaces with the kernel
+ */
+static int wm8728_init(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret = 0;
+
+	codec->name = "WM8728";
+	codec->owner = THIS_MODULE;
+	codec->read = wm8728_read_reg_cache;
+	codec->write = wm8728_write;
+	codec->set_bias_level = wm8728_set_bias_level;
+	codec->dai = &wm8728_dai;
+	codec->num_dai = 1;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->reg_cache_size = ARRAY_SIZE(wm8728_reg_defaults);
+	codec->reg_cache = kmemdup(wm8728_reg_defaults,
+				   sizeof(wm8728_reg_defaults),
+				   GFP_KERNEL);
+	if (codec->reg_cache == NULL)
+		return -ENOMEM;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8728: failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	/* power on device */
+	wm8728_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	wm8728_add_controls(codec);
+	wm8728_add_widgets(codec);
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8728: failed to register card\n");
+		goto card_err;
+	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	kfree(codec->reg_cache);
+	return ret;
+}
+
+static struct snd_soc_device *wm8728_socdev;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+
+/*
+ * WM8728 2 wire address is determined by GPIO5
+ * state during powerup.
+ *    low  = 0x1a
+ *    high = 0x1b
+ */
+
+static int wm8728_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct snd_soc_device *socdev = wm8728_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = wm8728_init(socdev);
+	if (ret < 0)
+		pr_err("failed to initialise WM8728\n");
+
+	return ret;
+}
+
+static int wm8728_i2c_remove(struct i2c_client *client)
+{
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
+	kfree(codec->reg_cache);
+	return 0;
+}
+
+static const struct i2c_device_id wm8728_i2c_id[] = {
+	{ "wm8728", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8728_i2c_id);
+
+static struct i2c_driver wm8728_i2c_driver = {
+	.driver = {
+		.name = "WM8728 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.probe =    wm8728_i2c_probe,
+	.remove =   wm8728_i2c_remove,
+	.id_table = wm8728_i2c_id,
+};
+
+static int wm8728_add_i2c_device(struct platform_device *pdev,
+				 const struct wm8728_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&wm8728_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->i2c_address;
+	strlcpy(info.type, "wm8728", I2C_NAME_SIZE);
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
+	i2c_del_driver(&wm8728_i2c_driver);
+	return -ENODEV;
+}
+#endif
+
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8728_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = wm8728_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	codec->control_data = spi;
+
+	ret = wm8728_init(socdev);
+	if (ret < 0)
+		dev_err(&spi->dev, "failed to initialise WM8728\n");
+
+	return ret;
+}
+
+static int __devexit wm8728_spi_remove(struct spi_device *spi)
+{
+	return 0;
+}
+
+static struct spi_driver wm8728_spi_driver = {
+	.driver = {
+		.name	= "wm8728",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wm8728_spi_probe,
+	.remove		= __devexit_p(wm8728_spi_remove),
+};
+
+static int wm8728_spi_write(struct spi_device *spi, const char *data, int len)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 msg[2];
+
+	if (len <= 0)
+		return 0;
+
+	msg[0] = data[0];
+	msg[1] = data[1];
+
+	spi_message_init(&m);
+	memset(&t, 0, (sizeof t));
+
+	t.tx_buf = &msg[0];
+	t.len = len;
+
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	return len;
+}
+#endif /* CONFIG_SPI_MASTER */
+
+static int wm8728_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct wm8728_setup_data *setup;
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	setup = socdev->codec_data;
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
+	socdev->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	wm8728_socdev = socdev;
+	ret = -ENODEV;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	if (setup->i2c_address) {
+		codec->hw_write = (hw_write_t)i2c_master_send;
+		ret = wm8728_add_i2c_device(pdev, setup);
+	}
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	if (setup->spi) {
+		codec->hw_write = (hw_write_t)wm8728_spi_write;
+		ret = spi_register_driver(&wm8728_spi_driver);
+		if (ret != 0)
+			printk(KERN_ERR "can't add spi driver");
+	}
+#endif
+
+	if (ret != 0)
+		kfree(codec);
+
+	return ret;
+}
+
+/* power down chip */
+static int wm8728_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	if (codec->control_data)
+		wm8728_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
+	i2c_del_driver(&wm8728_i2c_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8728_spi_driver);
+#endif
+	kfree(codec);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8728 = {
+	.probe = 	wm8728_probe,
+	.remove = 	wm8728_remove,
+	.suspend = 	wm8728_suspend,
+	.resume =	wm8728_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8728);
+
+MODULE_DESCRIPTION("ASoC WM8728 driver");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8728.h b/sound/soc/codecs/wm8728.h
new file mode 100644
index 0000000..d269c13
--- /dev/null
+++ b/sound/soc/codecs/wm8728.h
@@ -0,0 +1,30 @@
+/*
+ * wm8728.h  --  WM8728 ASoC codec driver
+ *
+ * Copyright 2008 Wolfson Microelectronics plc
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _WM8728_H
+#define _WM8728_H
+
+#define WM8728_DACLVOL   0x00
+#define WM8728_DACRVOL   0x01
+#define WM8728_DACCTL    0x02
+#define WM8728_IFCTL     0x03
+
+struct wm8728_setup_data {
+	int            spi;
+	int            i2c_bus;
+	unsigned short i2c_address;
+};
+
+extern struct snd_soc_dai wm8728_dai;
+extern struct snd_soc_codec_device soc_codec_dev_wm8728;
+
+#endif
-- 
1.5.6.5
