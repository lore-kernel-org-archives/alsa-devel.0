From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.30] ASoC: fix documentation in CS4270 codec
	driver
Date: Fri, 30 Jan 2009 11:14:49 -0600
Message-ID: <1233335689-16276-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BF961037E3
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 18:15:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Spruce up the documentation in the CS4270 codec.  Use kerneldoc where
appropriate.  Fix incorrect comments.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |  163 +++++++++++++++++++++++++++++----------------
 1 files changed, 105 insertions(+), 58 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index adc1150..e5f5afd 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -3,10 +3,10 @@
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
- * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * Copyright 2007-2009 Freescale Semiconductor, Inc.  This file is licensed
+ * under the terms of the GNU General Public License version 2.  This
+ * program is licensed "as is" without any warranty of any kind, whether
+ * express or implied.
  *
  * This is an ASoC device driver for the Cirrus Logic CS4270 codec.
  *
@@ -111,8 +111,13 @@ struct cs4270_private {
 	unsigned int mode; /* The mode (I2S or left-justified) */
 };
 
-/*
- * Clock Ratio Selection for Master Mode with I2C enabled
+/**
+ * struct cs4270_mode_ratios - clock ratio tables
+ * @ratio: the ratio of MCLK to the sample rate
+ * @speed_mode: the Speed Mode bits to set in the Mode Control register for
+ *              this ratio
+ * @mclk: the Ratio Select bits to set in the Mode Control register for this
+ *        ratio
  *
  * The data for this chart is taken from Table 5 of the CS4270 reference
  * manual.
@@ -121,31 +126,30 @@ struct cs4270_private {
  * It is also used by cs4270_set_dai_sysclk() to tell ALSA which sampling
  * rates the CS4270 currently supports.
  *
- * Each element in this array corresponds to the ratios in mclk_ratios[].
- * These two arrays need to be in sync.
- *
- * 'speed_mode' is the corresponding bit pattern to be written to the
+ * @speed_mode is the corresponding bit pattern to be written to the
  * MODE bits of the Mode Control Register
  *
- * 'mclk' is the corresponding bit pattern to be wirten to the MCLK bits of
+ * @mclk is the corresponding bit pattern to be wirten to the MCLK bits of
  * the Mode Control Register.
  *
  * In situations where a single ratio is represented by multiple speed
  * modes, we favor the slowest speed.  E.g, for a ratio of 128, we pick
  * double-speed instead of quad-speed.  However, the CS4270 errata states
- * that Divide-By-1.5 can cause failures, so we avoid that mode where
+ * that divide-By-1.5 can cause failures, so we avoid that mode where
  * possible.
  *
- * ERRATA: There is an errata for the CS4270 where divide-by-1.5 does not
- * work if VD = 3.3V.  If this effects you, select the
+ * Errata: There is an errata for the CS4270 where divide-by-1.5 does not
+ * work if Vd is 3.3V.  If this effects you, select the
  * CONFIG_SND_SOC_CS4270_VD33_ERRATA Kconfig option, and the driver will
  * never select any sample rates that require divide-by-1.5.
  */
-static struct {
+struct cs4270_mode_ratios {
 	unsigned int ratio;
 	u8 speed_mode;
 	u8 mclk;
-} cs4270_mode_ratios[] = {
+};
+
+static struct cs4270_mode_ratios[] = {
 	{64, CS4270_MODE_4X, CS4270_MODE_DIV1},
 #ifndef CONFIG_SND_SOC_CS4270_VD33_ERRATA
 	{96, CS4270_MODE_4X, CS4270_MODE_DIV15},
@@ -162,34 +166,27 @@ static struct {
 /* The number of MCLK/LRCK ratios supported by the CS4270 */
 #define NUM_MCLK_RATIOS		ARRAY_SIZE(cs4270_mode_ratios)
 
-/*
- * Determine the CS4270 samples rates.
+/**
+ * cs4270_set_dai_sysclk - determine the CS4270 samples rates.
+ * @codec_dai: the codec DAI
+ * @clk_id: the clock ID (ignored)
+ * @freq: the MCLK input frequency
+ * @dir: the clock direction (ignored)
  *
- * 'freq' is the input frequency to MCLK.  The other parameters are ignored.
+ * This function is used to tell the codec driver what the input MCLK
+ * frequency is.
  *
  * The value of MCLK is used to determine which sample rates are supported
  * by the CS4270.  The ratio of MCLK / Fs must be equal to one of nine
- * support values: 64, 96, 128, 192, 256, 384, 512, 768, and 1024.
+ * supported values - 64, 96, 128, 192, 256, 384, 512, 768, and 1024.
  *
  * This function calculates the nine ratios and determines which ones match
  * a standard sample rate.  If there's a match, then it is added to the list
- * of support sample rates.
+ * of supported sample rates.
  *
  * This function must be called by the machine driver's 'startup' function,
  * otherwise the list of supported sample rates will not be available in
  * time for ALSA.
- *
- * Note that in stand-alone mode, the sample rate is determined by input
- * pins M0, M1, MDIV1, and MDIV2.  Also in stand-alone mode, divide-by-3
- * is not a programmable option.  However, divide-by-3 is not an available
- * option in stand-alone mode.  This cases two problems: a ratio of 768 is
- * not available (it requires divide-by-3) and B) ratios 192 and 384 can
- * only be selected with divide-by-1.5, but there is an errate that make
- * this selection difficult.
- *
- * In addition, there is no mechanism for communicating with the machine
- * driver what the input settings can be.  This would need to be implemented
- * for stand-alone mode to work.
  */
 static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
@@ -230,8 +227,10 @@ static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-/*
- * Configure the codec for the selected audio format
+/**
+ * cs4270_set_dai_fmt - configure the codec for the selected audio format
+ * @codec_dai: the codec DAI
+ * @format: a SND_SOC_DAIFMT_x value indicating the data format
  *
  * This function takes a bitmask of SND_SOC_DAIFMT_x bits and programs the
  * codec accordingly.
@@ -261,8 +260,16 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return ret;
 }
 
-/*
- * Pre-fill the CS4270 register cache.
+/**
+ * cs4270_fill_cache - pre-fill the CS4270 register cache.
+ * @codec: the codec for this CS4270
+ *
+ * This function fills in the CS4270 register cache by reading the register
+ * values from the hardware.
+ *
+ * This CS4270 registers are cached to avoid excessive I2C I/O operations.
+ * After the initial read to pre-fill the cache, the CS4270 never updates
+ * the register values, so we won't have a cache coherency problem.
  *
  * We use the auto-increment feature of the CS4270 to read all registers in
  * one shot.
@@ -285,12 +292,17 @@ static int cs4270_fill_cache(struct snd_soc_codec *codec)
 	return 0;
 }
 
-/*
- * Read from the CS4270 register cache.
+/**
+ * cs4270_read_reg_cache - read from the CS4270 register cache.
+ * @codec: the codec for this CS4270
+ * @reg: the register to read
+ *
+ * This function returns the value for a given register.  It reads only from
+ * the register cache, not the hardware itself.
  *
  * This CS4270 registers are cached to avoid excessive I2C I/O operations.
  * After the initial read to pre-fill the cache, the CS4270 never updates
- * the register values, so we won't have a cache coherncy problem.
+ * the register values, so we won't have a cache coherency problem.
  */
 static unsigned int cs4270_read_reg_cache(struct snd_soc_codec *codec,
 	unsigned int reg)
@@ -303,8 +315,11 @@ static unsigned int cs4270_read_reg_cache(struct snd_soc_codec *codec,
 	return cache[reg - CS4270_FIRSTREG];
 }
 
-/*
- * Write to a CS4270 register via the I2C bus.
+/**
+ * cs4270_i2c_write - write to a CS4270 register via the I2C bus.
+ * @codec: the codec for this CS4270
+ * @reg: the register to write
+ * @value: the value to write to the register
  *
  * This function writes the given value to the given CS4270 register, and
  * also updates the register cache.
@@ -336,11 +351,17 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 	return 0;
 }
 
-/*
- * Program the CS4270 with the given hardware parameters.
+/**
+ * cs4270_hw_params - program the CS4270 with the given hardware parameters.
+ * @substream: the audio stream
+ * @params: the hardware parameters to set
+ * @dai: the SOC DAI (ignored)
  *
- * The .ops functions are used to provide board-specific data, like
- * input frequencies, to this driver.  This function takes that information,
+ * This function programs the hardware with the values provided.
+ * Specifically, the sample rate and the data format.
+ *
+ * The .ops functions are used to provide board-specific data, like input
+ * frequencies, to this driver.  This function takes that information,
  * combines it with the hardware parameters provided, and programs the
  * hardware accordingly.
  */
@@ -455,8 +476,10 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 }
 
 #ifdef CONFIG_SND_SOC_CS4270_HWMUTE
-/*
- * Set the CS4270 external mute
+/**
+ * cs4270_mute - enable/disable the CS4270 external mute
+ * @dai: the SOC DAI
+ * @mute: 0 = disable mute, 1 = enable mute
  *
  * This function toggles the mute bits in the MUTE register.  The CS4270's
  * mute capability is intended for external muting circuitry, so if the
@@ -490,7 +513,7 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 };
 
 /*
- * Global variable to store codec for the ASoC probe function.
+ * cs4270_codec - global variable to store codec for the ASoC probe function
  *
  * If struct i2c_driver had a private_data field, we wouldn't need to use
  * cs4270_codec.  This is the only way to pass the codec structure from
@@ -527,8 +550,12 @@ struct snd_soc_dai cs4270_dai = {
 };
 EXPORT_SYMBOL_GPL(cs4270_dai);
 
-/*
- * ASoC probe function
+/**
+ * cs4270_probe - ASoC probe function
+ * @pdev: platform device
+ *
+ * This function is called when ASoC has all the pieces it needs to
+ * instantiate a sound driver.
  */
 static int cs4270_probe(struct platform_device *pdev)
 {
@@ -582,6 +609,12 @@ error_free_pcms:
 	return ret;
 }
 
+/**
+ * cs4270_remove - ASoC remove function
+ * @pdev: platform device
+ *
+ * This function is the counterpart to cs4270_probe().
+ */
 static int cs4270_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -591,14 +624,13 @@ static int cs4270_remove(struct platform_device *pdev)
 	return 0;
 };
 
-/*
- * Initialize the I2C interface of the CS4270
- *
- * This function is called for whenever the I2C subsystem finds a device
- * at a particular address.
+/**
+ * cs4270_i2c_probe - initialize the I2C interface of the CS4270
+ * @i2c_client: the I2C client object
+ * @id: the I2C device ID (ignored)
  *
- * Note: snd_soc_new_pcms() must be called before this function can be called,
- * because of snd_ctl_add().
+ * This function is called whenever the I2C subsystem finds a device that
+ * matches the device ID given via a prior call to i2c_add_driver().
  */
 static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	const struct i2c_device_id *id)
@@ -690,6 +722,12 @@ error_free_codec:
 	return ret;
 }
 
+/**
+ * cs4270_i2c_remove - remove an I2C device
+ * @i2c_client: the I2C client object
+ *
+ * This function is the counterpart to cs4270_i2c_probe().
+ */
 static int cs4270_i2c_remove(struct i2c_client *i2c_client)
 {
 	struct cs4270_private *cs4270 = i2c_get_clientdata(i2c_client);
@@ -699,12 +737,21 @@ static int cs4270_i2c_remove(struct i2c_client *i2c_client)
 	return 0;
 }
 
+/*
+ * cs4270_id - I2C device IDs supported by this driver
+ */
 static struct i2c_device_id cs4270_id[] = {
 	{"cs4270", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, cs4270_id);
 
+/*
+ * cs4270_i2c_driver - I2C device identification
+ *
+ * This structure tells the I2C subsystem how to identify and support a
+ * given I2C device type.
+ */
 static struct i2c_driver cs4270_i2c_driver = {
 	.driver = {
 		.name = "cs4270",
-- 
1.5.5
