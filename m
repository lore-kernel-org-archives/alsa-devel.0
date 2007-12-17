From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] cs4270: wrong sample rate when
	CONFIG_SND_SOC_CS4270_VD33_ERRATA is set
Date: Mon, 17 Dec 2007 11:01:20 -0600
Message-ID: <1197910880673-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 797811038C5
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 18:01:56 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lBHH1MWY029379
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 10:01:40 -0700 (MST)
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
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

When CONFIG_SND_SOC_CS4270_VD33_ERRATA is set, there was a mismatch between
the mclk_ratios[] and cs4270_mode_ratios[] arrays.  The two arrays have been
merged and code has been shuffled.  One side effect is that the
cs4270_set_dai_sysclk() and cs4270_set_dai_fmt() functions are available only
if I2C has been enabled.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |  261 ++++++++++++++++++++++-----------------------
 1 files changed, 128 insertions(+), 133 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index abac628..bebb4ba 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -48,12 +48,130 @@ struct cs4270_private {
 	unsigned int mode; /* The mode (I2S or left-justified) */
 };
 
-/* The number of MCLK/LRCK ratios supported by the CS4270 */
-#define NUM_MCLK_RATIOS		9
+/*
+ * The codec isn't really big-endian or little-endian, since the I2S
+ * interface requires data to be sent serially with the MSbit first.
+ * However, to support BE and LE I2S devices, we specify both here.  That
+ * way, ALSA will always match the bit patterns.
+ */
+#define CS4270_FORMATS (SNDRV_PCM_FMTBIT_S8      | \
+			SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE  | \
+			SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S18_3BE | \
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE | \
+			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE | \
+			SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE)
+
+#ifdef USE_I2C
+
+/* CS4270 registers addresses */
+#define CS4270_CHIPID	0x01	/* Chip ID */
+#define CS4270_PWRCTL	0x02	/* Power Control */
+#define CS4270_MODE	0x03	/* Mode Control */
+#define CS4270_FORMAT	0x04	/* Serial Format, ADC/DAC Control */
+#define CS4270_TRANS	0x05	/* Transition Control */
+#define CS4270_MUTE	0x06	/* Mute Control */
+#define CS4270_VOLA	0x07	/* DAC Channel A Volume Control */
+#define CS4270_VOLB	0x08	/* DAC Channel B Volume Control */
+
+#define CS4270_FIRSTREG	0x01
+#define CS4270_LASTREG	0x08
+#define CS4270_NUMREGS	(CS4270_LASTREG - CS4270_FIRSTREG + 1)
 
-/* The actual MCLK/LRCK ratios, in increasing numerical order */
-static unsigned int mclk_ratios[NUM_MCLK_RATIOS] =
-	{64, 96, 128, 192, 256, 384, 512, 768, 1024};
+/* Bit masks for the CS4270 registers */
+#define CS4270_CHIPID_ID	0xF0
+#define CS4270_CHIPID_REV	0x0F
+#define CS4270_PWRCTL_FREEZE	0x80
+#define CS4270_PWRCTL_PDN_ADC	0x20
+#define CS4270_PWRCTL_PDN_DAC	0x02
+#define CS4270_PWRCTL_PDN	0x01
+#define CS4270_MODE_SPEED_MASK	0x30
+#define CS4270_MODE_1X		0x00
+#define CS4270_MODE_2X		0x10
+#define CS4270_MODE_4X		0x20
+#define CS4270_MODE_SLAVE	0x30
+#define CS4270_MODE_DIV_MASK	0x0E
+#define CS4270_MODE_DIV1	0x00
+#define CS4270_MODE_DIV15	0x02
+#define CS4270_MODE_DIV2	0x04
+#define CS4270_MODE_DIV3	0x06
+#define CS4270_MODE_DIV4	0x08
+#define CS4270_MODE_POPGUARD	0x01
+#define CS4270_FORMAT_FREEZE_A	0x80
+#define CS4270_FORMAT_FREEZE_B	0x40
+#define CS4270_FORMAT_LOOPBACK	0x20
+#define CS4270_FORMAT_DAC_MASK	0x18
+#define CS4270_FORMAT_DAC_LJ	0x00
+#define CS4270_FORMAT_DAC_I2S	0x08
+#define CS4270_FORMAT_DAC_RJ16	0x18
+#define CS4270_FORMAT_DAC_RJ24	0x10
+#define CS4270_FORMAT_ADC_MASK	0x01
+#define CS4270_FORMAT_ADC_LJ	0x00
+#define CS4270_FORMAT_ADC_I2S	0x01
+#define CS4270_TRANS_ONE_VOL	0x80
+#define CS4270_TRANS_SOFT	0x40
+#define CS4270_TRANS_ZERO	0x20
+#define CS4270_TRANS_INV_ADC_A	0x08
+#define CS4270_TRANS_INV_ADC_B	0x10
+#define CS4270_TRANS_INV_DAC_A	0x02
+#define CS4270_TRANS_INV_DAC_B	0x04
+#define CS4270_TRANS_DEEMPH	0x01
+#define CS4270_MUTE_AUTO	0x20
+#define CS4270_MUTE_ADC_A	0x08
+#define CS4270_MUTE_ADC_B	0x10
+#define CS4270_MUTE_POLARITY	0x04
+#define CS4270_MUTE_DAC_A	0x01
+#define CS4270_MUTE_DAC_B	0x02
+
+/*
+ * Clock Ratio Selection for Master Mode with I2C enabled
+ *
+ * The data for this chart is taken from Table 5 of the CS4270 reference
+ * manual.
+ *
+ * This table is used to determine how to program the Mode Control register.
+ * It is also used by cs4270_set_dai_sysclk() to tell ALSA which sampling
+ * rates the CS4270 currently supports.
+ *
+ * Each element in this array corresponds to the ratios in mclk_ratios[].
+ * These two arrays need to be in sync.
+ *
+ * 'speed_mode' is the corresponding bit pattern to be written to the
+ * MODE bits of the Mode Control Register
+ *
+ * 'mclk' is the corresponding bit pattern to be wirten to the MCLK bits of
+ * the Mode Control Register.
+ *
+ * In situations where a single ratio is represented by multiple speed
+ * modes, we favor the slowest speed.  E.g, for a ratio of 128, we pick
+ * double-speed instead of quad-speed.  However, the CS4270 errata states
+ * that Divide-By-1.5 can cause failures, so we avoid that mode where
+ * possible.
+ *
+ * ERRATA: There is an errata for the CS4270 where divide-by-1.5 does not
+ * work if VD = 3.3V.  If this effects you, select the
+ * CONFIG_SND_SOC_CS4270_VD33_ERRATA Kconfig option, and the driver will
+ * never select any sample rates that require divide-by-1.5.
+ */
+static struct {
+	unsigned int ratio;
+	u8 speed_mode;
+	u8 mclk;
+} cs4270_mode_ratios[] = {
+	{64, CS4270_MODE_4X, CS4270_MODE_DIV1},
+#ifndef CONFIG_SND_SOC_CS4270_VD33_ERRATA
+	{96, CS4270_MODE_4X, CS4270_MODE_DIV15},
+#endif
+	{128, CS4270_MODE_2X, CS4270_MODE_DIV1},
+	{192, CS4270_MODE_4X, CS4270_MODE_DIV3},
+	{256, CS4270_MODE_1X, CS4270_MODE_DIV1},
+	{384, CS4270_MODE_2X, CS4270_MODE_DIV3},
+	{512, CS4270_MODE_1X, CS4270_MODE_DIV2},
+	{768, CS4270_MODE_1X, CS4270_MODE_DIV3},
+	{1024, CS4270_MODE_1X, CS4270_MODE_DIV4}
+};
+
+/* The number of MCLK/LRCK ratios supported by the CS4270 */
+#define NUM_MCLK_RATIOS		ARRAY_SIZE(cs4270_mode_ratios)
 
 /*
  * Determine the CS4270 samples rates.
@@ -97,7 +215,7 @@ static int cs4270_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 	cs4270->mclk = freq;
 
 	for (i = 0; i < NUM_MCLK_RATIOS; i++) {
-		unsigned int rate = freq / mclk_ratios[i];
+		unsigned int rate = freq / cs4270_mode_ratios[i].ratio;
 		rates |= snd_pcm_rate_to_rate_bit(rate);
 		if (rate < rate_min)
 			rate_min = rate;
@@ -155,80 +273,6 @@ static int cs4270_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 }
 
 /*
- * The codec isn't really big-endian or little-endian, since the I2S
- * interface requires data to be sent serially with the MSbit first.
- * However, to support BE and LE I2S devices, we specify both here.  That
- * way, ALSA will always match the bit patterns.
- */
-#define CS4270_FORMATS (SNDRV_PCM_FMTBIT_S8      | \
-			SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE  | \
-			SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S18_3BE | \
-			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE | \
-			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE | \
-			SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE)
-
-#ifdef USE_I2C
-
-/* CS4270 registers addresses */
-#define CS4270_CHIPID	0x01	/* Chip ID */
-#define CS4270_PWRCTL	0x02	/* Power Control */
-#define CS4270_MODE	0x03	/* Mode Control */
-#define CS4270_FORMAT	0x04	/* Serial Format, ADC/DAC Control */
-#define CS4270_TRANS	0x05	/* Transition Control */
-#define CS4270_MUTE	0x06	/* Mute Control */
-#define CS4270_VOLA	0x07	/* DAC Channel A Volume Control */
-#define CS4270_VOLB	0x08	/* DAC Channel B Volume Control */
-
-#define CS4270_FIRSTREG	0x01
-#define CS4270_LASTREG	0x08
-#define CS4270_NUMREGS	(CS4270_LASTREG - CS4270_FIRSTREG + 1)
-
-/* Bit masks for the CS4270 registers */
-#define CS4270_CHIPID_ID	0xF0
-#define CS4270_CHIPID_REV	0x0F
-#define CS4270_PWRCTL_FREEZE	0x80
-#define CS4270_PWRCTL_PDN_ADC	0x20
-#define CS4270_PWRCTL_PDN_DAC	0x02
-#define CS4270_PWRCTL_PDN	0x01
-#define CS4270_MODE_SPEED_MASK	0x30
-#define CS4270_MODE_1X		0x00
-#define CS4270_MODE_2X		0x10
-#define CS4270_MODE_4X		0x20
-#define CS4270_MODE_SLAVE	0x30
-#define CS4270_MODE_DIV_MASK	0x0E
-#define CS4270_MODE_DIV1	0x00
-#define CS4270_MODE_DIV15	0x02
-#define CS4270_MODE_DIV2	0x04
-#define CS4270_MODE_DIV3	0x06
-#define CS4270_MODE_DIV4	0x08
-#define CS4270_MODE_POPGUARD	0x01
-#define CS4270_FORMAT_FREEZE_A	0x80
-#define CS4270_FORMAT_FREEZE_B	0x40
-#define CS4270_FORMAT_LOOPBACK	0x20
-#define CS4270_FORMAT_DAC_MASK	0x18
-#define CS4270_FORMAT_DAC_LJ	0x00
-#define CS4270_FORMAT_DAC_I2S	0x08
-#define CS4270_FORMAT_DAC_RJ16	0x18
-#define CS4270_FORMAT_DAC_RJ24	0x10
-#define CS4270_FORMAT_ADC_MASK	0x01
-#define CS4270_FORMAT_ADC_LJ	0x00
-#define CS4270_FORMAT_ADC_I2S	0x01
-#define CS4270_TRANS_ONE_VOL	0x80
-#define CS4270_TRANS_SOFT	0x40
-#define CS4270_TRANS_ZERO	0x20
-#define CS4270_TRANS_INV_ADC_A	0x08
-#define CS4270_TRANS_INV_ADC_B	0x10
-#define CS4270_TRANS_INV_DAC_A	0x02
-#define CS4270_TRANS_INV_DAC_B	0x04
-#define CS4270_TRANS_DEEMPH	0x01
-#define CS4270_MUTE_AUTO	0x20
-#define CS4270_MUTE_ADC_A	0x08
-#define CS4270_MUTE_ADC_B	0x10
-#define CS4270_MUTE_POLARITY	0x04
-#define CS4270_MUTE_DAC_A	0x01
-#define CS4270_MUTE_DAC_B	0x02
-
-/*
  * A list of addresses on which this CS4270 could use.  I2C addresses are
  * 7 bits.  For the CS4270, the upper four bits are always 1001, and the
  * lower three bits are determined via the AD2, AD1, and AD0 pins
@@ -315,53 +359,6 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 }
 
 /*
- * Clock Ratio Selection for Master Mode with I2C enabled
- *
- * The data for this chart is taken from Table 5 of the CS4270 reference
- * manual.
- *
- * This table is used to determine how to program the Mode Control register.
- * It is also used by cs4270_set_dai_sysclk() to tell ALSA which sampling
- * rates the CS4270 currently supports.
- *
- * Each element in this array corresponds to the ratios in mclk_ratios[].
- * These two arrays need to be in sync.
- *
- * 'speed_mode' is the corresponding bit pattern to be written to the
- * MODE bits of the Mode Control Register
- *
- * 'mclk' is the corresponding bit pattern to be wirten to the MCLK bits of
- * the Mode Control Register.
- *
- * In situations where a single ratio is represented by multiple speed
- * modes, we favor the slowest speed.  E.g, for a ratio of 128, we pick
- * double-speed instead of quad-speed.  However, the CS4270 errata states
- * that Divide-By-1.5 can cause failures, so we avoid that mode where
- * possible.
- *
- * ERRATA: There is an errata for the CS4270 where divide-by-1.5 does not
- * work if VD = 3.3V.  If this effects you, select the
- * CONFIG_SND_SOC_CS4270_VD33_ERRATA Kconfig option, and the driver will
- * never select any sample rates that require divide-by-1.5.
- */
-static struct {
-	u8 speed_mode;
-	u8 mclk;
-} cs4270_mode_ratios[NUM_MCLK_RATIOS] = {
-	{CS4270_MODE_4X, CS4270_MODE_DIV1},	/* 64 */
-#ifndef CONFIG_SND_SOC_CS4270_VD33_ERRATA
-	{CS4270_MODE_4X, CS4270_MODE_DIV15},    /* 96 */
-#endif
-	{CS4270_MODE_2X, CS4270_MODE_DIV1},     /* 128 */
-	{CS4270_MODE_4X, CS4270_MODE_DIV3},     /* 192 */
-	{CS4270_MODE_1X, CS4270_MODE_DIV1},     /* 256 */
-	{CS4270_MODE_2X, CS4270_MODE_DIV3},     /* 384 */
-	{CS4270_MODE_1X, CS4270_MODE_DIV2},     /* 512 */
-	{CS4270_MODE_1X, CS4270_MODE_DIV3},     /* 768 */
-	{CS4270_MODE_1X, CS4270_MODE_DIV4}      /* 1024 */
-};
-
-/*
  * Program the CS4270 with the given hardware parameters.
  *
  * The .dai_ops functions are used to provide board-specific data, like
@@ -388,7 +385,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	ratio = cs4270->mclk / rate;	/* MCLK/LRCK ratio */
 
 	for (i = 0; i < NUM_MCLK_RATIOS; i++) {
-		if (mclk_ratios[i] == ratio)
+		if (cs4270_mode_ratios[i].ratio == ratio)
 			break;
 	}
 
@@ -669,7 +666,7 @@ error:
 	return ret;
 }
 
-#endif
+#endif /* USE_I2C*/
 
 struct snd_soc_codec_dai cs4270_dai = {
 	.name = "CS4270",
@@ -687,10 +684,6 @@ struct snd_soc_codec_dai cs4270_dai = {
 		.rates = 0,
 		.formats = CS4270_FORMATS,
 	},
-	.dai_ops = {
-		.set_sysclk = cs4270_set_dai_sysclk,
-		.set_fmt = cs4270_set_dai_fmt,
-	}
 };
 EXPORT_SYMBOL_GPL(cs4270_dai);
 
@@ -752,6 +745,8 @@ static int cs4270_probe(struct platform_device *pdev)
 	if (codec->control_data) {
 		/* Initialize codec ops */
 		cs4270_dai.ops.hw_params = cs4270_hw_params;
+		cs4270_dai.dai_ops.set_sysclk = cs4270_set_dai_sysclk;
+		cs4270_dai.dai_ops.set_fmt = cs4270_set_dai_fmt;
 #ifdef CONFIG_SND_SOC_CS4270_HWMUTE
 		cs4270_dai.dai_ops.digital_mute = cs4270_mute;
 #endif
-- 
1.5.2.4
