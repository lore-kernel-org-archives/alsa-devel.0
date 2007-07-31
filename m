From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] CS4270 driver does not compile with I2C
	disabled
Date: Tue, 31 Jul 2007 18:15:33 -0500
Message-ID: <11859237332561-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 427DA24589
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 01:15:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Fix compilation errors with the CS4270 when I2C is not enabled.  Updated
some comments to indicate that that stand-alone mode is not fully implemented,
because there is no mechanism for the CS4270 driver and the machine driver to
communicate the values of various input pins.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch applies on top of the initial CS4270 patch, labeled "[PATCH v3]
ASoC CS4270 codec device driver".

 sound/soc/codecs/cs4270.c |  319 ++++++++++++++++++++++++---------------------
 1 files changed, 172 insertions(+), 147 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index b659a5d..8beae65 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -12,9 +12,11 @@
  *
  * Current features/limitations:
  *
- * 1) Stand-alone and software mode is supported.  Stand-alone is
- *    automatically selected if I2C is disabled or if a CS4270 is not found
- *    on the I2C bus.
+ * 1) Software mode is supported.  Stand-alone mode is automatically
+ *    selected if I2C is disabled or if a CS4270 is not found on the I2C
+ *    bus.  However, stand-alone mode is only partially implemented because
+ *    there is no mechanism yet for this driver and the machine driver to
+ *    communicate the values of the M0, M1, MCLK1, and MCLK2 pins.
  * 2) Only I2C is supported, not SPI
  * 3) Only Master mode is supported, not Slave.
  * 4) The machine driver's 'startup' function must call
@@ -34,12 +36,157 @@
 
 #include "cs4270.h"
 
+/* If I2C is defined, then we support software mode.  However, if we're
+   not compiled as module but I2C is, then we can't use I2C calls. */
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+#define USE_I2C
+#endif
+
 /* Private data for the CS4270 */
 struct cs4270_private {
 	unsigned int mclk; /* Input frequency of the MCLK pin */
 	unsigned int mode; /* The mode (I2S or left-justified) */
 };
 
+/* The number of MCLK/LRCK ratios supported by the CS4270 */
+#define NUM_MCLK_RATIOS		9
+
+/* The actual MCLK/LRCK ratios, in increasing numerical order */
+static unsigned int mclk_ratios[NUM_MCLK_RATIOS] =
+	{64, 96, 128, 192, 256, 384, 512, 768, 1024};
+
+/*
+ * Sampling rate <-> bit patter mapping
+ *
+ * This array maps sampling rates to their SNDRV_PCM_RATE_x equivalent.
+ *
+ * This is really something that ALSA should provide.
+ *
+ * This table is used by cs4270_set_dai_sysclk() to tell ALSA which sampling
+ * rates the CS4270 currently supports.
+ */
+static struct {
+	unsigned int rate;
+	unsigned int bit;
+} rate_map[] = {
+	{5512, SNDRV_PCM_RATE_5512},
+	{8000, SNDRV_PCM_RATE_8000},
+	{11025, SNDRV_PCM_RATE_11025},
+	{16000, SNDRV_PCM_RATE_16000},
+	{22050, SNDRV_PCM_RATE_22050},
+	{32000, SNDRV_PCM_RATE_32000},
+	{44100, SNDRV_PCM_RATE_44100},
+	{48000, SNDRV_PCM_RATE_48000},
+	{64000, SNDRV_PCM_RATE_64000},
+	{88200, SNDRV_PCM_RATE_88200},
+	{96000, SNDRV_PCM_RATE_96000},
+	{176400, SNDRV_PCM_RATE_176400},
+	{192000, SNDRV_PCM_RATE_192000}
+};
+
+/*
+ * Determine the CS4270 samples rates.
+ *
+ * 'freq' is the input frequency to MCLK.  The other parameters are ignored.
+ *
+ * The value of MCLK is used to determine which sample rates are supported
+ * by the CS4270.  The ratio of MCLK / Fs must be equal to one of nine
+ * support values: 64, 96, 128, 192, 256, 384, 512, 768, and 1024.
+ *
+ * This function calculates the nine ratios and determines which ones match
+ * a standard sample rate.  If there's a match, then it is added to the list
+ * of support sample rates.
+ *
+ * This function must be called by the machine driver's 'startup' function,
+ * otherwise the list of supported sample rates will not be available in
+ * time for ALSA.
+ *
+ * Note that in stand-alone mode, the sample rate is determined by input
+ * pins M0, M1, MDIV1, and MDIV2.  Also in stand-alone mode, divide-by-3
+ * is not a programmable option.  However, divide-by-3 is not an available
+ * option in stand-alone mode.  This cases two problems: a ratio of 768 is
+ * not available (it requires divide-by-3) and B) ratios 192 and 384 can
+ * only be selected with divide-by-1.5, but there is an errate that make
+ * this selection difficult.
+ *
+ * In addition, there is no mechanism for communicating with the machine
+ * driver what the input settings can be.  This would need to be implemented
+ * for stand-alone mode to work.
+ */
+static int cs4270_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs4270_private *cs4270 = codec->private_data;
+	unsigned int rates = 0;
+	unsigned int rate_min = -1;
+	unsigned int rate_max = 0;
+	unsigned int i;
+
+	cs4270->mclk = freq;
+
+	for (i = 0; i < NUM_MCLK_RATIOS; i++) {
+		unsigned int rate;
+		unsigned int j;
+		rate = freq / mclk_ratios[i];
+		for (j = 0; j < ARRAY_SIZE(rate_map); j++) {
+			if (rate == rate_map[j].rate) {
+				rates |= rate_map[j].bit;
+				if (rate < rate_min)
+					rate_min = rate;
+				if (rate > rate_max)
+					rate_max = rate;
+			}
+		}
+	}
+
+	if (!rates) {
+		printk(KERN_ERR "cs4270: could not find a valid sample rate\n");
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
+/*
+ * Configure the codec for the selected audio format
+ *
+ * This function takes a bitmask of SND_SOC_DAIFMT_x bits and programs the
+ * codec accordingly.
+ *
+ * Currently, this function only supports SND_SOC_DAIFMT_I2S and
+ * SND_SOC_DAIFMT_LEFT_J.  The CS4270 codec also supports right-justified
+ * data for playback only, but ASoC currently does not support different
+ * formats for playback vs. record.
+ */
+static int cs4270_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+			      unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs4270_private *cs4270 = codec->private_data;
+	int ret = 0;
+
+	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+		cs4270->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		printk(KERN_ERR "cs4270: invalid DAI format\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 /*
  * The codec isn't really big-endian or little-endian, since the I2S
  * interface requires data to be sent serially with the MSbit first.
@@ -53,7 +200,7 @@ struct cs4270_private {
 			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE | \
 			SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE)
 
-#ifdef CONFIG_I2C
+#ifdef USE_I2C
 
 /* CS4270 registers addresses */
 #define CS4270_CHIPID	0x01	/* Chip ID */
@@ -141,7 +288,7 @@ static int cs4270_fill_cache(struct snd_soc_codec *codec)
 		CS4270_FIRSTREG | 0x80, CS4270_NUMREGS, cache);
 
 	if (length != CS4270_NUMREGS) {
-		printk(KERN_ERR "cs4270: I2C read failure, addr=%u\n",
+		printk(KERN_ERR "cs4270: I2C read failure, addr=0x%x\n",
 		       i2c_client->addr);
 		return -EIO;
 	}
@@ -189,13 +336,14 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 		cache[reg - CS4270_FIRSTREG] = value;
 		return 0;
 	} else {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		printk(KERN_ERR "cs4270: I2C write of register %u failed\n",
+			reg);
 		return -EIO;
 	}
 }
 
 /*
- * Clock Ratio Selection for Master Mode.
+ * Clock Ratio Selection for Master Mode with I2C enabled
  *
  * The data for this chart is taken from Table 5 of the CS4270 reference
  * manual.
@@ -204,10 +352,8 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
  * It is also used by cs4270_set_dai_sysclk() to tell ALSA which sampling
  * rates the CS4270 currently supports.
  *
- * 'ratio' is the MCLK/LRCK ratio.  MCLK is usually a fixed input frequency,
- * and LRCK is equal to the sampling rate. The CS4270 only supports sampling
- * rates where this ratio is one of: 64, 96, 128, 192, 256, 384, 512, 768 or
- * 1024.
+ * Each element in this array corresponds to the ratios in mclk_ratios[].
+ * These two arrays need to be in sync.
  *
  * 'speed_mode' is the corresponding bit pattern to be written to the
  * MODE bits of the Mode Control Register
@@ -227,21 +373,20 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
  * never select any sample rates that require divide-by-1.5.
  */
 static struct {
-	unsigned int ratio;
 	u8 speed_mode;
 	u8 mclk;
-} cs4270_mode_ratios[] = {
-	{64, CS4270_MODE_4X, CS4270_MODE_DIV1},
+} cs4270_mode_ratios[NUM_MCLK_RATIOS] = {
+	{CS4270_MODE_4X, CS4270_MODE_DIV1},	/* 64 */
 #ifndef CONFIG_SND_SOC_CS4270_VD33_ERRATA
-	{96, CS4270_MODE_4X, CS4270_MODE_DIV15},
+	{CS4270_MODE_4X, CS4270_MODE_DIV15},    /* 96 */
 #endif
-	{128, CS4270_MODE_2X, CS4270_MODE_DIV1},
-	{192, CS4270_MODE_4X, CS4270_MODE_DIV3},
-	{256, CS4270_MODE_1X, CS4270_MODE_DIV1},
-	{384, CS4270_MODE_2X, CS4270_MODE_DIV3},
-	{512, CS4270_MODE_1X, CS4270_MODE_DIV2},
-	{768, CS4270_MODE_1X, CS4270_MODE_DIV3},
-	{1024, CS4270_MODE_1X, CS4270_MODE_DIV4}
+	{CS4270_MODE_2X, CS4270_MODE_DIV1},     /* 128 */
+	{CS4270_MODE_4X, CS4270_MODE_DIV3},     /* 192 */
+	{CS4270_MODE_1X, CS4270_MODE_DIV1},     /* 256 */
+	{CS4270_MODE_2X, CS4270_MODE_DIV3},     /* 384 */
+	{CS4270_MODE_1X, CS4270_MODE_DIV2},     /* 512 */
+	{CS4270_MODE_1X, CS4270_MODE_DIV3},     /* 768 */
+	{CS4270_MODE_1X, CS4270_MODE_DIV4}      /* 1024 */
 };
 
 /*
@@ -270,12 +415,12 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	rate = params_rate(params);	/* Sampling rate, in Hz */
 	ratio = cs4270->mclk / rate;	/* MCLK/LRCK ratio */
 
-	for (i = 0; i < ARRAY_SIZE(cs4270_mode_ratios); i++) {
-		if (cs4270_mode_ratios[i].ratio == ratio)
+	for (i = 0; i < NUM_MCLK_RATIOS; i++) {
+		if (mclk_ratios[i] == ratio)
 			break;
 	}
 
-	if (i == ARRAY_SIZE(cs4270_mode_ratios)) {
+	if (i == NUM_MCLK_RATIOS) {
 		/* We did not find a matching ratio */
 		printk(KERN_ERR "cs4270: could not find matching ratio\n");
 		return -EINVAL;
@@ -377,126 +522,6 @@ static int cs4270_mute(struct snd_soc_codec_dai *dai, int mute)
 
 #endif
 
-/*
- * Sampling rate <-> bit patter mapping
- *
- * This array maps sampling rates to their SNDRV_PCM_RATE_x equivalent.
- *
- * This is really something that ALSA should provide.
- *
- * This table is used by cs4270_set_dai_sysclk() to tell ALSA which sampling
- * rates the CS4270 currently supports.
- */
-static struct {
-	unsigned int rate;
-	unsigned int bit;
-} rate_map[] = {
-	{5512, SNDRV_PCM_RATE_5512},
-	{8000, SNDRV_PCM_RATE_8000},
-	{11025, SNDRV_PCM_RATE_11025},
-	{16000, SNDRV_PCM_RATE_16000},
-	{22050, SNDRV_PCM_RATE_22050},
-	{32000, SNDRV_PCM_RATE_32000},
-	{44100, SNDRV_PCM_RATE_44100},
-	{48000, SNDRV_PCM_RATE_48000},
-	{64000, SNDRV_PCM_RATE_64000},
-	{88200, SNDRV_PCM_RATE_88200},
-	{96000, SNDRV_PCM_RATE_96000},
-	{176400, SNDRV_PCM_RATE_176400},
-	{192000, SNDRV_PCM_RATE_192000}
-};
-
-/*
- * Determine the CS4270 samples rates.
- *
- * 'freq' is the input frequency to MCLK.  The other parameters are ignored.
- *
- * The value of MCLK is used to determine which sample rates are supported
- * by the CS4270.  The ratio of MCLK / Fs must be equal to one of nine
- * support values: 64, 96, 128, 192, 256, 384, 512, 768, and 1024.
- *
- * This function calculates the nine ratios and determines which ones match
- * a standard sample rate.  If there's a match, then it is added to the list
- * of support sample rates.
- *
- * This function must be called by the machine driver's 'startup' function,
- * otherwise the list of supported sample rates will not be available in
- * time for ALSA.
- */
-static int cs4270_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
-				 int clk_id, unsigned int freq, int dir)
-{
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs4270_private *cs4270 = codec->private_data;
-	unsigned int rates = 0;
-	unsigned int rate_min = -1;
-	unsigned int rate_max = 0;
-	unsigned int i;
-
-	cs4270->mclk = freq;
-
-	for (i = 0; i < ARRAY_SIZE(cs4270_mode_ratios); i++) {
-		unsigned int rate;
-		unsigned int j;
-		rate = freq / cs4270_mode_ratios[i].ratio;
-		for (j = 0; j < ARRAY_SIZE(rate_map); j++) {
-			if (rate == rate_map[j].rate) {
-				rates |= rate_map[j].bit;
-				if (rate < rate_min)
-					rate_min = rate;
-				if (rate > rate_max)
-					rate_max = rate;
-			}
-		}
-	}
-
-	if (!rate_max) {
-		printk(KERN_ERR "cs4270: could not find a valid rate\n");
-		return -EINVAL;
-	}
-
-	codec_dai->playback.rates = rates;
-	codec_dai->playback.rate_min = rate_min;
-	codec_dai->playback.rate_max = rate_max;
-
-	codec_dai->capture.rates = rates;
-	codec_dai->capture.rate_min = rate_min;
-	codec_dai->capture.rate_max = rate_max;
-
-	return 0;
-}
-
-/*
- * Configure the codec for the selected audio format
- *
- * This function takes a bitmask of SND_SOC_DAIFMT_x bits and programs the
- * codec accordingly.
- *
- * Currently, this function only supports SND_SOC_DAIFMT_I2S and
- * SND_SOC_DAIFMT_LEFT_J.  The CS4270 codec also supports right-justified
- * data for playback only, but ASoC currently does not support different
- * formats for playback vs. record.
- */
-static int cs4270_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
-			      unsigned int format)
-{
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs4270_private *cs4270 = codec->private_data;
-	int ret = 0;
-
-	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-	case SND_SOC_DAIFMT_LEFT_J:
-		cs4270->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
-		break;
-	default:
-		printk(KERN_ERR "cs4270: invalid DAI format\n");
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
 static int cs4270_i2c_probe(struct i2c_adapter *adap, int addr, int kind);
 
 /*
@@ -740,7 +765,7 @@ static int cs4270_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-#ifdef CONFIG_I2C
+#ifdef USE_I2C
 	cs4270_socdev = socdev;
 
 	ret = i2c_add_driver(&cs4270_i2c_driver);
@@ -780,7 +805,7 @@ static int cs4270_remove(struct platform_device *pdev)
 
 	snd_soc_free_pcms(socdev);
 
-#ifdef CONFIG_I2C
+#ifdef USE_I2C
 	if (socdev->codec->control_data)
 		i2c_del_driver(&cs4270_i2c_driver);
 #endif
-- 
1.5.2.4
