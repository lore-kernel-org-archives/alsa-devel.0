From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 4/8] ASoC: TWL4030: Optimize the power up
	sequence
Date: Wed, 26 May 2010 11:38:17 +0300
Message-ID: <1274863101-18514-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 50320103941
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 10:39:36 +0200 (CEST)
In-Reply-To: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Since the reg cache now contains the chip default values
for all registers (REG_OPTION is reset to it's default
within this patch), there is no longer need to rewrite
_all_ registers.
Initialize only few selected registers.

According to the latest information, the offset cancellation
need to be done only once, when the codec is powered on, so
there is no need for the power up wrapper.

Move all chip initialization code under chip_init, and do
it when the codec is initialized.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |  133 ++++++++++++++++++++------------------------
 1 files changed, 60 insertions(+), 73 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index a6cbaf3..08f24de 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -43,7 +43,7 @@
 static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* this register not used		*/
 	0x00, /* REG_CODEC_MODE		(0x1)	*/
-	0xc3, /* REG_OPTION		(0x2)	*/
+	0x00, /* REG_OPTION		(0x2)	*/
 	0x00, /* REG_UNKNOWN		(0x3)	*/
 	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
 	0x00, /* REG_ANAMICL		(0x5)	*/
@@ -243,62 +243,52 @@ static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
 	udelay(10);
 }

-static void twl4030_init_chip(struct snd_soc_codec *codec)
-{
-	u8 *cache = codec->reg_cache;
-	int i;
-
-	/* clear CODECPDZ prior to setting register defaults */
-	twl4030_codec_enable(codec, 0);
-
-	/* set all audio section registers to reasonable defaults */
-	for (i = TWL4030_REG_OPTION; i <= TWL4030_REG_MISC_SET_2; i++)
-		if (i != TWL4030_REG_APLL_CTL)
-			twl4030_write(codec, i,	cache[i]);
-
-}
-
-static void twl4030_apll_enable(struct snd_soc_codec *codec, int enable)
+static void twl4030_init_chip(struct platform_device *pdev)
 {
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct twl4030_setup_data *setup = socdev->codec_data;
+	struct snd_soc_codec *codec = socdev->card->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
-	int status = -1;
+	u8 reg, byte;
+	int i = 0;

-	if (enable) {
-		twl4030->apll_enabled++;
-		if (twl4030->apll_enabled == 1)
-			status = twl4030_codec_enable_resource(
-							TWL4030_CODEC_RES_APLL);
-	} else {
-		twl4030->apll_enabled--;
-		if (!twl4030->apll_enabled)
-			status = twl4030_codec_disable_resource(
-							TWL4030_CODEC_RES_APLL);
-	}
+	/* Refresh APLL_CTL register from HW */
+	twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
+			    TWL4030_REG_APLL_CTL);
+	twl4030_write_reg_cache(codec, TWL4030_REG_APLL_CTL, byte);

-	if (status >= 0)
-		twl4030_write_reg_cache(codec, TWL4030_REG_APLL_CTL, status);
-}
+	/* anti-pop when changing analog gain */
+	reg = twl4030_read_reg_cache(codec, TWL4030_REG_MISC_SET_1);
+	twl4030_write(codec, TWL4030_REG_MISC_SET_1,
+		reg | TWL4030_SMOOTH_ANAVOL_EN);

-static void twl4030_power_up(struct snd_soc_codec *codec)
-{
-	struct snd_soc_device *socdev = codec->socdev;
-	struct twl4030_setup_data *setup = socdev->codec_data;
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
-	u8 anamicl, regmisc1, byte;
-	int i = 0;
+	twl4030_write(codec, TWL4030_REG_OPTION,
+		TWL4030_ATXL1_EN | TWL4030_ATXR1_EN |
+		TWL4030_ARXL2_EN | TWL4030_ARXR2_EN);

-	if (twl4030->codec_powered)
+	/* Machine dependent setup */
+	if (!setup)
 		return;

-	/* set CODECPDZ to turn on codec */
-	twl4030_codec_enable(codec, 1);
+	/* Configuration for headset ramp delay from setup data */
+	if (setup->sysclk != twl4030->sysclk)
+		dev_warn(codec->dev,
+				"Mismatch in APLL mclk: %u (configured: %u)\n",
+				setup->sysclk, twl4030->sysclk);
+
+	reg = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
+	reg &= ~TWL4030_RAMP_DELAY;
+	reg |= (setup->ramp_delay_value << 2);
+	twl4030_write_reg_cache(codec, TWL4030_REG_HS_POPN_SET, reg);

 	/* initiate offset cancellation */
-	anamicl = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
-	anamicl &= ~TWL4030_OFFSET_CNCL_SEL;
-	anamicl |= setup->offset_cncl_path;
+	twl4030_codec_enable(codec, 1);
+
+	reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
+	reg &= ~TWL4030_OFFSET_CNCL_SEL;
+	reg |= setup->offset_cncl_path;
 	twl4030_write(codec, TWL4030_REG_ANAMICL,
-		anamicl | TWL4030_CNCL_OFFSET_START);
+		reg | TWL4030_CNCL_OFFSET_START);

 	/* wait for offset cancellation to complete */
 	do {
@@ -313,14 +303,28 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 	/* Make sure that the reg_cache has the same value as the HW */
 	twl4030_write_reg_cache(codec, TWL4030_REG_ANAMICL, byte);

-	/* anti-pop when changing analog gain */
-	regmisc1 = twl4030_read_reg_cache(codec, TWL4030_REG_MISC_SET_1);
-	twl4030_write(codec, TWL4030_REG_MISC_SET_1,
-		regmisc1 | TWL4030_SMOOTH_ANAVOL_EN);
-
-	/* toggle CODECPDZ as per TRM */
 	twl4030_codec_enable(codec, 0);
-	twl4030_codec_enable(codec, 1);
+}
+
+static void twl4030_apll_enable(struct snd_soc_codec *codec, int enable)
+{
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
+	int status = -1;
+
+	if (enable) {
+		twl4030->apll_enabled++;
+		if (twl4030->apll_enabled == 1)
+			status = twl4030_codec_enable_resource(
+							TWL4030_CODEC_RES_APLL);
+	} else {
+		twl4030->apll_enabled--;
+		if (!twl4030->apll_enabled)
+			status = twl4030_codec_disable_resource(
+							TWL4030_CODEC_RES_APLL);
+	}
+
+	if (status >= 0)
+		twl4030_write_reg_cache(codec, TWL4030_REG_APLL_CTL, status);
 }

 /* Earpiece */
@@ -1599,7 +1603,7 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF)
-			twl4030_power_up(codec);
+			twl4030_codec_enable(codec, 1);
 		break;
 	case SND_SOC_BIAS_OFF:
 		twl4030_codec_enable(codec, 0);
@@ -2196,31 +2200,16 @@ static struct snd_soc_codec *twl4030_codec;
 static int twl4030_soc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct twl4030_setup_data *setup = socdev->codec_data;
 	struct snd_soc_codec *codec;
-	struct twl4030_priv *twl4030;
 	int ret;

 	BUG_ON(!twl4030_codec);

 	codec = twl4030_codec;
-	twl4030 = snd_soc_codec_get_drvdata(codec);
 	socdev->card->codec = codec;

-	/* Configuration for headset ramp delay from setup data */
-	if (setup) {
-		unsigned char hs_pop;
-
-		if (setup->sysclk != twl4030->sysclk)
-			dev_warn(&pdev->dev,
-				 "Mismatch in APLL mclk: %u (configured: %u)\n",
-				 setup->sysclk, twl4030->sysclk);
-
-		hs_pop = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
-		hs_pop &= ~TWL4030_RAMP_DELAY;
-		hs_pop |= (setup->ramp_delay_value << 2);
-		twl4030_write_reg_cache(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
-	}
+	twl4030_init_chip(pdev);
+	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
@@ -2296,9 +2285,7 @@ static int __devinit twl4030_codec_probe(struct platform_device *pdev)

 	/* Set the defaults, and power up the codec */
 	twl4030->sysclk = twl4030_codec_get_mclk() / 1000;
-	twl4030_init_chip(codec);
 	codec->bias_level = SND_SOC_BIAS_OFF;
-	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
--
1.7.1
