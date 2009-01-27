From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 5/6] ASoC: TWL4030: Move the twl4030_power_up
	and _power_down function
Date: Tue, 27 Jan 2009 11:29:43 +0200
Message-ID: <1233048584-29662-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-2-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-3-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-4-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id DABAE1037EC
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 10:30:01 +0100 (CET)
In-Reply-To: <1233048584-29662-5-git-send-email-peter.ujfalusi@nokia.com>
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

Move the twl4030_power_up and twl4030_power_down function
earlier to facilitate the analog bypass implementation.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   85 +++++++++++++++++++++----------------------
 1 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 651be7f..8c77271 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -184,6 +184,48 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
+static void twl4030_power_up(struct snd_soc_codec *codec)
+{
+	u8 anamicl, regmisc1, byte;
+	int i = 0;
+
+	/* set CODECPDZ to turn on codec */
+	twl4030_codec_enable(codec, 1);
+
+	/* initiate offset cancellation */
+	anamicl = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
+	twl4030_write(codec, TWL4030_REG_ANAMICL,
+		anamicl | TWL4030_CNCL_OFFSET_START);
+
+	/* wait for offset cancellation to complete */
+	do {
+		/* this takes a little while, so don't slam i2c */
+		udelay(2000);
+		twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
+				    TWL4030_REG_ANAMICL);
+	} while ((i++ < 100) &&
+		 ((byte & TWL4030_CNCL_OFFSET_START) ==
+		  TWL4030_CNCL_OFFSET_START));
+
+	/* Make sure that the reg_cache has the same value as the HW */
+	twl4030_write_reg_cache(codec, TWL4030_REG_ANAMICL, byte);
+
+	/* anti-pop when changing analog gain */
+	regmisc1 = twl4030_read_reg_cache(codec, TWL4030_REG_MISC_SET_1);
+	twl4030_write(codec, TWL4030_REG_MISC_SET_1,
+		regmisc1 | TWL4030_SMOOTH_ANAVOL_EN);
+
+	/* toggle CODECPDZ as per TRM */
+	twl4030_codec_enable(codec, 0);
+	twl4030_codec_enable(codec, 1);
+}
+
+static void twl4030_power_down(struct snd_soc_codec *codec)
+{
+	/* power down */
+	twl4030_codec_enable(codec, 0);
+}
+
 /* Earpiece */
 static const char *twl4030_earpiece_texts[] =
 		{"Off", "DACL1", "DACL2", "DACR1"};
@@ -922,49 +964,6 @@ static int twl4030_add_widgets(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static void twl4030_power_up(struct snd_soc_codec *codec)
-{
-	u8 anamicl, regmisc1, byte;
-	int i = 0;
-
-	/* set CODECPDZ to turn on codec */
-	twl4030_codec_enable(codec, 1);
-
-	/* initiate offset cancellation */
-	anamicl = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
-	twl4030_write(codec, TWL4030_REG_ANAMICL,
-		anamicl | TWL4030_CNCL_OFFSET_START);
-
-
-	/* wait for offset cancellation to complete */
-	do {
-		/* this takes a little while, so don't slam i2c */
-		udelay(2000);
-		twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
-				    TWL4030_REG_ANAMICL);
-	} while ((i++ < 100) &&
-		 ((byte & TWL4030_CNCL_OFFSET_START) ==
-		  TWL4030_CNCL_OFFSET_START));
-
-	/* Make sure that the reg_cache has the same value as the HW */
-	twl4030_write_reg_cache(codec, TWL4030_REG_ANAMICL, byte);
-
-	/* anti-pop when changing analog gain */
-	regmisc1 = twl4030_read_reg_cache(codec, TWL4030_REG_MISC_SET_1);
-	twl4030_write(codec, TWL4030_REG_MISC_SET_1,
-		regmisc1 | TWL4030_SMOOTH_ANAVOL_EN);
-
-	/* toggle CODECPDZ as per TRM */
-	twl4030_codec_enable(codec, 0);
-	twl4030_codec_enable(codec, 1);
-}
-
-static void twl4030_power_down(struct snd_soc_codec *codec)
-{
-	/* power down */
-	twl4030_codec_enable(codec, 0);
-}
-
 static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
-- 
1.6.1
