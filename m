From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: TWL4030: Use usleep_range when
	appropriate
Date: Fri, 22 Oct 2010 15:11:21 +0300
Message-ID: <1287749481-12203-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1287749481-12203-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 212D01037EC
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 14:11:35 +0200 (CEST)
In-Reply-To: <1287749481-12203-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Change the busy loop delays with usleep_range or msleep calls.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index cbebec6..2ec330c 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -233,6 +233,16 @@ static int twl4030_write(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static inline void twl4030_wait_ms(int time)
+{
+	if (time < 60) {
+		time *= 1000;
+		usleep_range(time, time + 500);
+	} else {
+		msleep(time);
+	}
+}
+
 static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
 {
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
@@ -338,10 +348,18 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 	twl4030_write(codec, TWL4030_REG_ANAMICL,
 		reg | TWL4030_CNCL_OFFSET_START);
 
-	/* wait for offset cancellation to complete */
+	/*
+	 * Wait for offset cancellation to complete.
+	 * Since this takes a while, do not slam the i2c.
+	 * The least amount of time is not known, but measurement showed, that
+	 * the cancelation usually finishes 20 - 28 ms, when
+	 * TWL4030_OFFSET_CNCL_SEL == 1.
+	 * Start polling the status after 10ms.
+	 */
+	usleep_range(10000, 11000);
 	do {
 		/* this takes a little while, so don't slam i2c */
-		udelay(2000);
+		usleep_range(1000, 2000);
 		twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
 				    TWL4030_REG_ANAMICL);
 	} while ((i++ < 100) &&
@@ -725,9 +743,12 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 	/* Base values for ramp delay calculation: 2^19 - 2^26 */
 	unsigned int ramp_base[] = {524288, 1048576, 2097152, 4194304,
 				    8388608, 16777216, 33554432, 67108864};
+	unsigned int delay;
 
 	hs_gain = twl4030_read_reg_cache(codec, TWL4030_REG_HS_GAIN_SET);
 	hs_pop = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
+	delay = (ramp_base[(hs_pop & TWL4030_RAMP_DELAY) >> 2] /
+		twl4030->sysclk) + 1;
 
 	/* Enable external mute control, this dramatically reduces
 	 * the pop-noise */
@@ -751,16 +772,14 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 		hs_pop |= TWL4030_RAMP_EN;
 		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 		/* Wait ramp delay time + 1, so the VMID can settle */
-		mdelay((ramp_base[(hs_pop & TWL4030_RAMP_DELAY) >> 2] /
-			twl4030->sysclk) + 1);
+		twl4030_wait_ms(delay);
 	} else {
 		/* Headset ramp-down _not_ according to
 		 * the TRM, but in a way that it is working */
 		hs_pop &= ~TWL4030_RAMP_EN;
 		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 		/* Wait ramp delay time + 1, so the VMID can settle */
-		mdelay((ramp_base[(hs_pop & TWL4030_RAMP_DELAY) >> 2] /
-			twl4030->sysclk) + 1);
+		twl4030_wait_ms(delay);
 		/* Bypass the reg_cache to mute the headset */
 		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 					hs_gain & (~0x0f),
@@ -835,7 +854,7 @@ static int digimic_event(struct snd_soc_dapm_widget *w,
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec);
 
 	if (twl4030->digimic_delay)
-		mdelay(twl4030->digimic_delay);
+		twl4030_wait_ms(twl4030->digimic_delay);
 	return 0;
 }
 
-- 
1.7.3.1
