From: Chris Gorman <chrisjohgorman@gmail.com>
Subject: [PATCH 2/2] soc: codecs: rt5645: fixed coding style issuses
Date: Thu,  6 Jul 2017 21:05:03 -0400
Message-ID: <1499389503-6308-1-git-send-email-chrisjohgorman@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Chris Gorman <chrisjohgorman@gmail.com>, Chris Gorman <chrisjohgorman@bell.net>
List-Id: alsa-devel@alsa-project.org

fixed coding style issues 6 warnings and 1 error

left two warnings alone because I was unsure about changing the logic and
felt the 80 + character line necessary
sound/soc/codecs/rt5645.c:702: WARNING: else is not generally useful after a break or return
sound/soc/codecs/rt5645.c:3024: WARNING: line over 80 characters

Signed-off-by: Chris Gorman <chrisjohgorman@bell.net>
---
 sound/soc/codecs/rt5645.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 87844a4..7c14317 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3021,7 +3021,7 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
-		if (SND_SOC_BIAS_STANDBY == snd_soc_codec_get_bias_level(codec)) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
 			snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 				RT5645_PWR_VREF1 | RT5645_PWR_MB |
 				RT5645_PWR_BG | RT5645_PWR_VREF2,
@@ -3117,7 +3117,8 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		snd_soc_dapm_sync(dapm);
 		if (!dapm->card->instantiated) {
 			/* Power up necessary bits for JD if dapm is
-			   not ready yet */
+			 * not ready yet
+			 */
 			regmap_update_bits(rt5645->regmap, RT5645_PWR_ANLG1,
 				RT5645_PWR_MB | RT5645_PWR_VREF2,
 				RT5645_PWR_MB | RT5645_PWR_VREF2);
@@ -3143,9 +3144,8 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 
 		if (val == 1 || val == 2) {
 			rt5645->jack_type = SND_JACK_HEADSET;
-			if (rt5645->en_button_func) {
+			if (rt5645->en_button_func)
 				rt5645_enable_push_button_irq(codec, true);
-			}
 		} else {
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
@@ -3262,10 +3262,11 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 			report = SND_JACK_HEADSET;
 			btn_type = rt5645_button_detect(rt5645->codec);
 			/* rt5650 can report three kinds of button behavior,
-			   one click, double click and hold. However,
-			   currently we will report button pressed/released
-			   event. So all the three button behaviors are
-			   treated as button pressed. */
+			 * one click, double click and hold. However,
+			 * currently we will report button pressed/released
+			 * event. So all the three button behaviors are
+			 * treated as button pressed.
+			 */
 			switch (btn_type) {
 			case 0x8000:
 			case 0x4000:
@@ -3527,7 +3528,7 @@ static const struct regmap_config rt5650_regmap = {
 };
 
 static const struct regmap_config temp_regmap = {
-	.name="nocache",
+	.name = "nocache",
 	.reg_bits = 8,
 	.val_bits = 16,
 	.use_single_rw = true,
-- 
2.7.4
