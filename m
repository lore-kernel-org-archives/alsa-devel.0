From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/6] ASoC: TWL4030: Code clean up for codec
	power up and down
Date: Tue, 27 Jan 2009 11:29:40 +0200
Message-ID: <1233048584-29662-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id BC6E71037EA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 10:29:59 +0100 (CET)
In-Reply-To: <1233048584-29662-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Merge the codec up and down functions to a simple one.
Codec is powered down by default (reg_cache change).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   43 +++++++++++++++++--------------------------
 1 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index df72a21..7d35cd4 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -42,7 +42,7 @@
  */
 static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* this register not used		*/
-	0x93, /* REG_CODEC_MODE		(0x1)	*/
+	0x91, /* REG_CODEC_MODE		(0x1)	*/
 	0xc3, /* REG_OPTION		(0x2)	*/
 	0x00, /* REG_UNKNOWN		(0x3)	*/
 	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
@@ -154,26 +154,17 @@ static int twl4030_write(struct snd_soc_codec *codec,
 	return twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value, reg);
 }
 
-static void twl4030_clear_codecpdz(struct snd_soc_codec *codec)
+static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
 {
 	u8 mode;
 
 	mode = twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE);
-	twl4030_write(codec, TWL4030_REG_CODEC_MODE,
-		mode & ~TWL4030_CODECPDZ);
+	if (enable)
+		mode |= TWL4030_CODECPDZ;
+	else
+		mode &= ~TWL4030_CODECPDZ;
 
-	/* REVISIT: this delay is present in TI sample drivers */
-	/* but there seems to be no TRM requirement for it     */
-	udelay(10);
-}
-
-static void twl4030_set_codecpdz(struct snd_soc_codec *codec)
-{
-	u8 mode;
-
-	mode = twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE);
-	twl4030_write(codec, TWL4030_REG_CODEC_MODE,
-		mode | TWL4030_CODECPDZ);
+	twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
 
 	/* REVISIT: this delay is present in TI sample drivers */
 	/* but there seems to be no TRM requirement for it     */
@@ -185,7 +176,7 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 	int i;
 
 	/* clear CODECPDZ prior to setting register defaults */
-	twl4030_clear_codecpdz(codec);
+	twl4030_codec_enable(codec, 0);
 
 	/* set all audio section registers to reasonable defaults */
 	for (i = TWL4030_REG_OPTION; i <= TWL4030_REG_MISC_SET_2; i++)
@@ -895,7 +886,7 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 	int i = 0;
 
 	/* set CODECPDZ to turn on codec */
-	twl4030_set_codecpdz(codec);
+	twl4030_codec_enable(codec, 1);
 
 	/* initiate offset cancellation */
 	anamicl = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
@@ -922,8 +913,8 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 		regmisc1 | TWL4030_SMOOTH_ANAVOL_EN);
 
 	/* toggle CODECPDZ as per TRM */
-	twl4030_clear_codecpdz(codec);
-	twl4030_set_codecpdz(codec);
+	twl4030_codec_enable(codec, 0);
+	twl4030_codec_enable(codec, 1);
 
 	/* program anti-pop with bias ramp delay */
 	popn = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
@@ -952,7 +943,7 @@ static void twl4030_power_down(struct snd_soc_codec *codec)
 	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
 
 	/* power down */
-	twl4030_clear_codecpdz(codec);
+	twl4030_codec_enable(codec, 0);
 }
 
 static int twl4030_set_bias_level(struct snd_soc_codec *codec,
@@ -1030,7 +1021,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 	if (mode != old_mode) {
 		/* change rate and set CODECPDZ */
 		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
-		twl4030_set_codecpdz(codec);
+		twl4030_codec_enable(codec, 1);
 	}
 
 	/* sample size */
@@ -1053,13 +1044,13 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 	if (format != old_format) {
 
 		/* clear CODECPDZ before changing format (codec requirement) */
-		twl4030_clear_codecpdz(codec);
+		twl4030_codec_enable(codec, 0);
 
 		/* change format */
 		twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
 
 		/* set CODECPDZ afterwards */
-		twl4030_set_codecpdz(codec);
+		twl4030_codec_enable(codec, 1);
 	}
 	return 0;
 }
@@ -1129,13 +1120,13 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	if (format != old_format) {
 
 		/* clear CODECPDZ before changing format (codec requirement) */
-		twl4030_clear_codecpdz(codec);
+		twl4030_codec_enable(codec, 0);
 
 		/* change format */
 		twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
 
 		/* set CODECPDZ afterwards */
-		twl4030_set_codecpdz(codec);
+		twl4030_codec_enable(codec, 1);
 	}
 
 	return 0;
-- 
1.6.1
