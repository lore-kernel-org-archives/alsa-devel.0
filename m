From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] Update CS4270 driver to ASoC V2
Date: Mon, 28 Apr 2008 15:22:24 -0500
Message-ID: <1209414144-16010-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AFC72442D
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Apr 2008 22:22:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Update the CS4270 ASoC codec driver to support ASoC V2.  A side-effect is the
the removal of partial-support for stand-alone mode (no I2C interface).
However, this change also makes the driver into a cross-platform new-style I2C
driver.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This code has not yet been tested, since full support for the Freescale 
MPC8610HPCD is not ready in ASoC V2.  However, this patch does at least
fix all the compilation errors.

 sound/soc/codecs/Kconfig  |    2 +-
 sound/soc/codecs/cs4270.c |  469 +++++++++++++++-----------------------------
 2 files changed, 161 insertions(+), 310 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7c5d576..31b567a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -85,7 +85,7 @@ config SND_SOC_WM9713
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
-	depends on SND_SOC
+	depends on SND_SOC && I2C
 
 # Cirrus Logic CS4270 Codec Hardware Mute Support
 # Select if you have external muting circuitry attached to your CS4270.
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 799f326..b47e1d8 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -3,20 +3,17 @@
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
- * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * Copyright 2007-2008 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  *
  * This is an ASoC device driver for the Cirrus Logic CS4270 codec.
  *
  * Current features/limitations:
  *
- * 1) Software mode is supported.  Stand-alone mode is automatically
- *    selected if I2C is disabled or if a CS4270 is not found on the I2C
- *    bus.  However, stand-alone mode is only partially implemented because
- *    there is no mechanism yet for this driver and the soc_card driver to
- *    communicate the values of the M0, M1, MCLK1, and MCLK2 pins.
+ * 1) Software mode is supported. Stand-alone mode is not supported.
  * 2) Only I2C is supported, not SPI
  * 3) Only Master mode is supported, not Slave.
  * 4) The soc_card driver's 'startup' function must call
@@ -27,28 +24,14 @@
  */
 
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc-codec.h>
 #include <sound/soc-dai.h>
+#include <sound/soc-card.h>
 #include <sound/initval.h>
 #include <linux/i2c.h>
 
-#include "cs4270.h"
-
-/* If I2C is defined, then we support software mode.  However, if we're
-   not compiled as module but I2C is, then we can't use I2C calls. */
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-#define USE_I2C
-#endif
-
-/* Private data for the CS4270 */
-struct cs4270_private {
-	unsigned int mclk; /* Input frequency of the MCLK pin */
-	unsigned int mode; /* The mode (I2S or left-justified) */
-};
-
 /*
  * The codec isn't really big-endian or little-endian, since the I2S
  * interface requires data to be sent serially with the MSbit first.
@@ -62,8 +45,6 @@ struct cs4270_private {
 			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE | \
 			SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE)
 
-#ifdef USE_I2C
-
 /* CS4270 registers addresses */
 #define CS4270_CHIPID	0x01	/* Chip ID */
 #define CS4270_PWRCTL	0x02	/* Power Control */
@@ -123,6 +104,20 @@ struct cs4270_private {
 #define CS4270_MUTE_DAC_A	0x01
 #define CS4270_MUTE_DAC_B	0x02
 
+/* Private data for the CS4270 */
+struct cs4270_private {
+	struct snd_soc_codec codec;
+	char name[16];
+	unsigned int mclk; /* Input frequency of the MCLK pin */
+	unsigned int mode; /* The mode (I2S or left-justified) */
+	struct snd_soc_dai_ops dai_ops;
+	struct snd_soc_dai *dai;
+	struct snd_soc_dai_new dai_new;
+	struct snd_soc_dai_caps playback;
+	struct snd_soc_dai_caps capture;
+	u8 reg_cache[CS4270_NUMREGS];
+};
+
 /*
  * Clock Ratio Selection for Master Mode with I2C enabled
  *
@@ -207,7 +202,8 @@ static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs4270_private *cs4270 = codec->private_data;
+	struct cs4270_private *cs4270 =
+		container_of(codec, struct cs4270_private, codec);
 	unsigned int rates = 0;
 	unsigned int rate_min = -1;
 	unsigned int rate_max = 0;
@@ -257,7 +253,8 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs4270_private *cs4270 = codec->private_data;
+	struct cs4270_private *cs4270 =
+		container_of(codec, struct cs4270_private, codec);
 	int ret = 0;
 
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -274,41 +271,6 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 /*
- * A list of addresses on which this CS4270 could use.  I2C addresses are
- * 7 bits.  For the CS4270, the upper four bits are always 1001, and the
- * lower three bits are determined via the AD2, AD1, and AD0 pins
- * (respectively).
- */
-static const unsigned short normal_i2c[] = {
-	0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, I2C_CLIENT_END
-};
-I2C_CLIENT_INSMOD;
-
-/*
- * Pre-fill the CS4270 register cache.
- *
- * We use the auto-increment feature of the CS4270 to read all registers in
- * one shot.
- */
-static int cs4270_fill_cache(struct snd_soc_codec *codec)
-{
-	u8 *cache = codec->reg_cache;
-	struct i2c_client *i2c_client = codec->control_data;
-	s32 length;
-
-	length = i2c_smbus_read_i2c_block_data(i2c_client,
-		CS4270_FIRSTREG | 0x80, CS4270_NUMREGS, cache);
-
-	if (length != CS4270_NUMREGS) {
-		printk(KERN_ERR "cs4270: I2C read failure, addr=0x%x\n",
-		       i2c_client->addr);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/*
  * Read from the CS4270 register cache.
  *
  * This CS4270 registers are cached to avoid excessive I2C I/O operations.
@@ -318,7 +280,9 @@ static int cs4270_fill_cache(struct snd_soc_codec *codec)
 static unsigned int cs4270_read_reg_cache(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
+	struct cs4270_private *cs4270 =
+		container_of(codec, struct cs4270_private, codec);
+	u8 *cache = cs4270->reg_cache;
 
 	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
 		return -EIO;
@@ -339,7 +303,9 @@ static unsigned int cs4270_read_reg_cache(struct snd_soc_codec *codec,
 static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 			    unsigned int value)
 {
-	u8 *cache = codec->reg_cache;
+	struct cs4270_private *cs4270 =
+		container_of(codec, struct cs4270_private, codec);
+	u8 *cache = cs4270->reg_cache;
 
 	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
 		return -EIO;
@@ -347,6 +313,7 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 	/* Only perform an I2C operation if the new value is different */
 	if (cache[reg - CS4270_FIRSTREG] != value) {
 		struct i2c_client *client = codec->control_data;
+
 		if (i2c_smbus_write_byte_data(client, reg, value)) {
 			printk(KERN_ERR "cs4270: I2C write failed\n");
 			return -EIO;
@@ -372,8 +339,9 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct cs4270_private *cs4270 = codec->private_data;
-	unsigned int ret = 0;
+	struct cs4270_private *cs4270 =
+		container_of(codec, struct cs4270_private, codec);
+	int ret = 0;
 	unsigned int i;
 	unsigned int rate;
 	unsigned int ratio;
@@ -397,9 +365,9 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	/* Freeze and power-down the codec */
 
-	ret = snd_soc_write(codec, CS4270_PWRCTL, CS4270_PWRCTL_FREEZE |
-			    CS4270_PWRCTL_PDN_ADC | CS4270_PWRCTL_PDN_DAC |
-			    CS4270_PWRCTL_PDN);
+	ret = cs4270_i2c_write(codec, CS4270_PWRCTL, CS4270_PWRCTL_FREEZE |
+		CS4270_PWRCTL_PDN_ADC | CS4270_PWRCTL_PDN_DAC |
+		CS4270_PWRCTL_PDN);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: I2C write failed\n");
 		return ret;
@@ -407,11 +375,11 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	/* Program the mode control register */
 
-	reg = snd_soc_read(codec, CS4270_MODE);
+	reg = cs4270_read_reg_cache(codec, CS4270_MODE);
 	reg &= ~(CS4270_MODE_SPEED_MASK | CS4270_MODE_DIV_MASK);
 	reg |= cs4270_mode_ratios[i].speed_mode | cs4270_mode_ratios[i].mclk;
 
-	ret = snd_soc_write(codec, CS4270_MODE, reg);
+	ret = cs4270_i2c_write(codec, CS4270_MODE, reg);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: I2C write failed\n");
 		return ret;
@@ -419,7 +387,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	/* Program the format register */
 
-	reg = snd_soc_read(codec, CS4270_FORMAT);
+	reg = cs4270_read_reg_cache(codec, CS4270_FORMAT);
 	reg &= ~(CS4270_FORMAT_DAC_MASK | CS4270_FORMAT_ADC_MASK);
 
 	switch (cs4270->mode) {
@@ -434,7 +402,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	ret = snd_soc_write(codec, CS4270_FORMAT, reg);
+	ret = cs4270_i2c_write(codec, CS4270_FORMAT, reg);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: I2C write failed\n");
 		return ret;
@@ -443,9 +411,9 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	/* Disable auto-mute.  This feature appears to be buggy, because in
 	   some situations, auto-mute will not deactivate when it should. */
 
-	reg = snd_soc_read(codec, CS4270_MUTE);
+	reg = cs4270_read_reg_cache(codec, CS4270_MUTE);
 	reg &= ~CS4270_MUTE_AUTO;
-	ret = snd_soc_write(codec, CS4270_MUTE, reg);
+	ret = cs4270_i2c_write(codec, CS4270_MUTE, reg);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: I2C write failed\n");
 		return ret;
@@ -453,7 +421,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	/* Thaw and power-up the codec */
 
-	ret = snd_soc_write(codec, CS4270_PWRCTL, 0);
+	ret = cs4270_i2c_write(codec, CS4270_PWRCTL, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: I2C write failed\n");
 		return ret;
@@ -463,7 +431,6 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 }
 
 #ifdef CONFIG_SND_SOC_CS4270_HWMUTE
-
 /*
  * Set the CS4270 external mute
  *
@@ -477,7 +444,7 @@ static int cs4270_mute(struct snd_soc_dai *dai, int mute)
 	struct snd_soc_codec *codec = dai->codec;
 	int reg6;
 
-	reg6 = snd_soc_read(codec, CS4270_MUTE);
+	reg6 = cs4270_read_reg_cache(codec, CS4270_MUTE);
 
 	if (mute)
 		reg6 |= CS4270_MUTE_ADC_A | CS4270_MUTE_ADC_B |
@@ -486,73 +453,18 @@ static int cs4270_mute(struct snd_soc_dai *dai, int mute)
 		reg6 &= ~(CS4270_MUTE_ADC_A | CS4270_MUTE_ADC_B |
 			  CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B);
 
-	return snd_soc_write(codec, CS4270_MUTE, reg6);
+	return cs4270_i2c_write(codec, CS4270_MUTE, reg6);
 }
-
+#else
+#define cs4270_mute NULL
 #endif
 
-static int cs4270_i2c_probe(struct i2c_adapter *adap, int addr, int kind);
-
-/*
- * Notify the driver that a new I2C bus has been found.
- *
- * This function is called for each I2C bus in the system.  The function
- * then asks the I2C subsystem to probe that bus at the addresses on which
- * our device (the CS4270) could exist.  If a device is found at one of
- * those addresses, then our probe function (cs4270_i2c_probe) is called.
- */
-static int cs4270_i2c_attach(struct i2c_adapter *adapter)
-{
-	return i2c_probe(adapter, &addr_data, cs4270_i2c_probe);
-}
-
-static int cs4270_i2c_detach(struct i2c_client *client)
-{
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-
-	i2c_detach_client(client);
-	codec->control_data = NULL;
-
-	kfree(codec->reg_cache);
-	codec->reg_cache = NULL;
-
-	kfree(client);
-	return 0;
-}
-
 /* A list of non-DAPM controls that the CS4270 supports */
 static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 	SOC_DOUBLE_R("Master Playback Volume",
 		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
 };
 
-static struct i2c_driver cs4270_i2c_driver = {
-	.driver = {
-		.name = "CS4270 I2C",
-		.owner = THIS_MODULE,
-	},
-	.id =             I2C_DRIVERID_CS4270,
-	.attach_adapter = cs4270_i2c_attach,
-	.detach_client =  cs4270_i2c_detach,
-};
-
-/*
- * Global variable to store socdev for i2c probe function.
- *
- * If struct i2c_driver had a private_data field, we wouldn't need to use
- * cs4270_socdec.  This is the only way to pass the socdev structure to
- * cs4270_i2c_probe().
- *
- * The real solution to cs4270_socdev is to create a mechanism
- * that maps I2C addresses to snd_soc_device structures.  Perhaps the
- * creation of the snd_soc_device object should be moved out of
- * cs4270_probe() and into cs4270_i2c_probe(), but that would make this
- * driver dependent on I2C.  The CS4270 supports "stand-alone" mode, whereby
- * the chip is *not* connected to the I2C bus, but is instead configured via
- * input pins.
- */
-static struct snd_soc_device *cs4270_socdev;
-
 /*
  * Initialize the I2C interface of the CS4270
  *
@@ -562,239 +474,178 @@ static struct snd_soc_device *cs4270_socdev;
  * Note: snd_soc_new_pcms() must be called before this function can be called,
  * because of snd_ctl_add().
  */
-static int cs4270_i2c_probe(struct i2c_adapter *adapter, int addr, int kind)
+static int cs4270_i2c_probe(struct i2c_client *client)
 {
-	struct snd_soc_device *socdev = cs4270_socdev;
-	struct snd_soc_codec *codec = socdev->codec;
-	struct i2c_client *i2c_client = NULL;
+	struct cs4270_private *cs4270;
+	struct snd_soc_codec *codec = NULL;
 	int i;
 	int ret = 0;
+	int registered = 0;	/* 1 == the codec has been registered */
+
+	/* Verify that we have a CS4270 */
 
-	/* Probing all possible addresses has one drawback: if there are
-	   multiple CS4270s on the bus, then you cannot specify which
-	   socdev is matched with which CS4270.  For now, we just reject
-	   this I2C device if the socdev already has one attached. */
-	if (codec->control_data)
+	ret = i2c_smbus_read_byte_data(client, CS4270_CHIPID);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to read I2C\n");
+		return ret;
+	}
+	/* The top four bits of the chip ID should be 1100. */
+	if ((ret & 0xF0) != 0xC0)
+		/* The device at this address is not a CS4270 codec */
 		return -ENODEV;
 
-	/* Note: codec_dai->codec is NULL here */
+	dev_info(&client->dev, "found device at address %X\n", client->addr);
+	dev_info(&client->dev, "hardware revision %X\n", ret & 0xF);
 
-	i2c_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (!i2c_client) {
-		printk(KERN_ERR "cs4270: could not allocate I2C client\n");
+	/*
+	 * Normally, we'd call snd_soc_new_codec, but that function
+	 * allocates a snd_soc_codec struct, and we don't want that.
+	 */
+	cs4270 = kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
+	if (!cs4270) {
+		dev_err(&client->dev, "could not allocate codec structure\n");
 		return -ENOMEM;
 	}
 
-	codec->reg_cache = kzalloc(CS4270_NUMREGS, GFP_KERNEL);
-	if (!codec->reg_cache) {
-		printk(KERN_ERR "cs4270: could not allocate register cache\n");
-		ret = -ENOMEM;
+	/* The I2C interface is set up, so pre-fill our register cache */
+	ret = i2c_smbus_read_i2c_block_data(client, CS4270_FIRSTREG | 0x80,
+		CS4270_NUMREGS, cs4270->reg_cache);
+	if (ret != CS4270_NUMREGS) {
+		dev_err(&client->dev, "failed to fill register cache\n");
+		ret = -EIO;
 		goto error;
 	}
 
-	i2c_set_clientdata(i2c_client, codec);
-	strcpy(i2c_client->name, "CS4270");
+	strcpy(cs4270->name, "CS4270");
 
-	i2c_client->driver = &cs4270_i2c_driver;
-	i2c_client->adapter = adapter;
-	i2c_client->addr = addr;
+	cs4270->playback.stream_name = "Playback";
+	cs4270->playback.channels_min = 1;
+	cs4270->playback.channels_max = 2;
+	cs4270->playback.formats = CS4270_FORMATS;
 
-	/* Verify that we have a CS4270 */
+	cs4270->capture.stream_name = "Capture";
+	cs4270->capture.channels_min = 1;
+	cs4270->capture.channels_max = 2;
+	cs4270->capture.formats = CS4270_FORMATS;
 
-	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
-	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to read I2C\n");
-		goto error;
-	}
-	/* The top four bits of the chip ID should be 1100. */
-	if ((ret & 0xF0) != 0xC0) {
-		/* The device at this address is not a CS4270 codec */
-		ret = -ENODEV;
-		goto error;
-	}
+	cs4270->dai_ops.hw_params = cs4270_hw_params;
+	cs4270->dai_ops.set_sysclk = cs4270_set_dai_sysclk;
+	cs4270->dai_ops.set_fmt = cs4270_set_dai_fmt;
+	cs4270->dai_ops.digital_mute = cs4270_mute;
 
-	printk(KERN_INFO "cs4270: found device at I2C address %X\n", addr);
-	printk(KERN_INFO "cs4270: hardware revision %X\n", ret & 0xF);
+	codec = &cs4270->codec;
 
-	/* Tell the I2C layer a new client has arrived */
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->list);
+	INIT_LIST_HEAD(&codec->dai_list);
+	codec->name = cs4270->name;
+
+	codec->control_data = client;
 
-	ret = i2c_attach_client(i2c_client);
-	if (ret) {
-		printk(KERN_ERR "cs4270: could not attach codec, "
-			"I2C address %x, error code %i\n", addr, ret);
+	ret = snd_soc_register_codec(codec, &client->dev);
+	if (ret < 0) {
+		printk(KERN_ERR "cs4270: failed to register card\n");
 		goto error;
 	}
+	registered = 1;
 
-	codec->control_data = i2c_client;
-	codec->read = cs4270_read_reg_cache;
-	codec->write = cs4270_i2c_write;
-	codec->reg_cache_size = CS4270_NUMREGS;
+	cs4270->dai_new.playback = &cs4270->playback;
+	cs4270->dai_new.capture = &cs4270->capture;
+	cs4270->dai_new.ops = &cs4270->dai_ops;
 
-	/* The I2C interface is set up, so pre-fill our register cache */
-
-	ret = cs4270_fill_cache(codec);
-	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to fill register cache\n");
+	cs4270->dai =
+		snd_soc_register_codec_dai(&cs4270->dai_new, &client->dev);
+	if (!cs4270->dai) {
+		ret = -EINVAL;
 		goto error;
 	}
 
 	/* Add the non-DAPM controls */
 
 	for (i = 0; i < ARRAY_SIZE(cs4270_snd_controls); i++) {
-		struct snd_kcontrol *kctrl =
-		snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
+		struct snd_kcontrol *kctrl;
+
+		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
 
-		ret = snd_ctl_add(codec->card, kctrl);
+		ret = snd_ctl_add(codec->soc_card->card, kctrl);
 		if (ret < 0)
 			goto error;
 	}
 
+	i2c_set_clientdata(client, codec);
+
 	return 0;
 
 error:
-	if (codec->control_data) {
-		i2c_detach_client(i2c_client);
-		codec->control_data = NULL;
-	}
+	if (cs4270->dai)
+		snd_soc_unregister_codec_dai(cs4270->dai);
 
-	kfree(codec->reg_cache);
-	codec->reg_cache = NULL;
-	codec->reg_cache_size = 0;
+	if (registered)
+		snd_soc_unregister_codec(codec);
 
-	kfree(i2c_client);
+	kfree(cs4270);
 
 	return ret;
 }
 
-#endif /* USE_I2C*/
-
-struct snd_soc_dai cs4270_dai = {
-	.name = "CS4270",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = 0,
-		.formats = CS4270_FORMATS,
-	},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = 0,
-		.formats = CS4270_FORMATS,
-	},
-};
-EXPORT_SYMBOL_GPL(cs4270_dai);
-
-/*
- * ASoC probe function
- *
- * This function is called when the soc_card driver calls
- * platform_device_add().
- */
-static int cs4270_probe(struct platform_device *pdev)
+static int cs4270_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	printk(KERN_INFO "CS4270 ALSA SoC Codec\n");
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
+	struct cs4270_private *cs4270 =
+		container_of(codec, struct cs4270_private, codec);
 
-	/* Allocate enough space for the snd_soc_codec structure
-	   and our private data together. */
-	codec = kzalloc(ALIGN(sizeof(struct snd_soc_codec), 4) +
-			sizeof(struct cs4270_private), GFP_KERNEL);
-	if (!codec) {
-		printk(KERN_ERR "cs4270: Could not allocate codec structure\n");
-		return -ENOMEM;
-	}
+	i2c_set_clientdata(client, NULL);
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
+	snd_soc_unregister_codec_dai(cs4270->dai);
+	snd_soc_unregister_codec(codec);
 
-	codec->name = "CS4270";
-	codec->owner = THIS_MODULE;
-	codec->dai = &cs4270_dai;
-	codec->num_dai = 1;
-	codec->private_data = (void *) codec +
-		ALIGN(sizeof(struct snd_soc_codec), 4);
+	kfree(cs4270);
 
-	socdev->codec = codec;
+	return 0;
+}
 
-	/* Register PCMs */
+static struct i2c_driver cs4270_i2c_driver = {
+	.driver = {
+		.name = "cs4270",
+		.owner = THIS_MODULE,
+	},
+	.id = I2C_DRIVERID_CS4270,
+	.probe = cs4270_i2c_probe,
+	.remove = cs4270_i2c_remove,
+};
 
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to create PCMs\n");
-		return ret;
-	}
+/**
+ * cs4270_init: codec driver initialization.
+ *
+ * This function is called when this module is loaded.
+ */
+static int __init cs4270_init(void)
+{
+	int ret;
 
-#ifdef USE_I2C
-	cs4270_socdev = socdev;
+	printk(KERN_INFO "Cirrus Logic CS4270 ALSA SoC codec driver\n");
 
+	/* i2c_add_driver() will call cs4270_i2c_probe() */
 	ret = i2c_add_driver(&cs4270_i2c_driver);
-	if (ret) {
-		printk(KERN_ERR "cs4270: failed to attach driver");
-		snd_soc_free_pcms(socdev);
-		return ret;
-	}
 
-	/* Did we find a CS4270 on the I2C bus? */
-	if (codec->control_data) {
-		/* Initialize codec ops */
-		cs4270_dai.ops.hw_params = cs4270_hw_params;
-		cs4270_dai.dai_ops.set_sysclk = cs4270_set_dai_sysclk;
-		cs4270_dai.dai_ops.set_fmt = cs4270_set_dai_fmt;
-#ifdef CONFIG_SND_SOC_CS4270_HWMUTE
-		cs4270_dai.dai_ops.digital_mute = cs4270_mute;
-#endif
-	} else
-		printk(KERN_INFO "cs4270: no I2C device found, "
-			"using stand-alone mode\n");
-#else
-	printk(KERN_INFO "cs4270: I2C disabled, using stand-alone mode\n");
-#endif
-
-	ret = snd_soc_register_card(socdev);
-	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to register card\n");
-		snd_soc_free_pcms(socdev);
-		return ret;
-	}
+	if (ret)
+		printk(KERN_ERR "cs4270: failed to register I2C driver\n");
 
 	return ret;
 }
 
-static int cs4270_remove(struct platform_device *pdev)
+/**
+ * cs4270_exit: codec driver exit
+ *
+ * This function is called when this driver is unloaded.
+ */
+static void __exit cs4270_exit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-
-#ifdef USE_I2C
-	if (socdev->codec->control_data)
-		i2c_del_driver(&cs4270_i2c_driver);
-#endif
-
-	kfree(socdev->codec);
-	socdev->codec = NULL;
-
-	return 0;
+	i2c_del_driver(&cs4270_i2c_driver);
 }
 
-/*
- * ASoC codec device structure
- *
- * Assign this variable to the codec_dev field of the soc_card driver's
- * snd_soc_device structure.
- */
-struct snd_soc_codec_device soc_codec_device_cs4270 = {
-	.probe = 	cs4270_probe,
-	.remove = 	cs4270_remove
-};
-EXPORT_SYMBOL_GPL(soc_codec_device_cs4270);
+module_init(cs4270_init);
+module_exit(cs4270_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Cirrus Logic CS4270 ALSA SoC Codec Driver");
-- 
1.5.5.1
