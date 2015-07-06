From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: rt5645: Replace direct snd_soc_codec
	dapm field access
Date: Mon,  6 Jul 2015 15:38:06 +0200
Message-ID: <1436189891-15343-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 53BE52605C8
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:38:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Yang A Fang <yang.a.fang@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Kevin Cernekee <cernekee@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
other manual access to codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/rt5645.c | 73 +++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a5bc96a..6335746 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2642,7 +2642,7 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
-		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
+		if (SND_SOC_BIAS_STANDBY == snd_soc_codec_get_bias_level(codec)) {
 			snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 				RT5645_PWR_VREF1 | RT5645_PWR_MB |
 				RT5645_PWR_BG | RT5645_PWR_VREF2,
@@ -2760,20 +2760,17 @@ static int rt5650_calibration(struct rt5645_priv *rt5645)
 static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	bool enable)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	if (enable) {
-		snd_soc_dapm_mutex_lock(&codec->dapm);
-		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
-							"ADC L power");
-		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
-							"ADC R power");
-		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
-							"LDO2");
-		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
-							"Mic Det Power");
-		snd_soc_dapm_sync_unlocked(&codec->dapm);
-		snd_soc_dapm_mutex_unlock(&codec->dapm);
+		snd_soc_dapm_mutex_lock(dapm);
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, "ADC L power");
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, "ADC R power");
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO2");
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, "Mic Det Power");
+		snd_soc_dapm_sync_unlocked(dapm);
+		snd_soc_dapm_mutex_unlock(dapm);
 
 		snd_soc_update_bits(codec,
 					RT5645_INT_IRQ_ST, 0x8, 0x8);
@@ -2786,23 +2783,20 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD2, 0x8000, 0x0);
 		snd_soc_update_bits(codec, RT5645_INT_IRQ_ST, 0x8, 0x0);
 
-		snd_soc_dapm_mutex_lock(&codec->dapm);
-		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
-							"ADC L power");
-		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
-							"ADC R power");
+		snd_soc_dapm_mutex_lock(dapm);
+		snd_soc_dapm_disable_pin_unlocked(dapm, "ADC L power");
+		snd_soc_dapm_disable_pin_unlocked(dapm, "ADC R power");
 		if (rt5645->pdata.jd_mode == 0)
-			snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
-								"LDO2");
-		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
-							"Mic Det Power");
-		snd_soc_dapm_sync_unlocked(&codec->dapm);
-		snd_soc_dapm_mutex_unlock(&codec->dapm);
+			snd_soc_dapm_disable_pin_unlocked(dapm, "LDO2");
+		snd_soc_dapm_disable_pin_unlocked(dapm, "Mic Det Power");
+		snd_soc_dapm_sync_unlocked(dapm);
+		snd_soc_dapm_mutex_unlock(dapm);
 	}
 }
 
 static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
 
@@ -2811,10 +2805,9 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 
 		if (codec->component.card->instantiated) {
 			/* for jack type detect */
-			snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO2");
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-				"Mic Det Power");
-			snd_soc_dapm_sync(&codec->dapm);
+			snd_soc_dapm_force_enable_pin(dapm, "LDO2");
+			snd_soc_dapm_force_enable_pin(dapm, "Mic Det Power");
+			snd_soc_dapm_sync(dapm);
 		} else {
 			/* Power up necessary bits for JD if dapm is
 			   not ready yet */
@@ -2847,9 +2840,8 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			}
 		} else {
 			if (codec->component.card->instantiated) {
-				snd_soc_dapm_disable_pin(&codec->dapm,
-					"Mic Det Power");
-				snd_soc_dapm_sync(&codec->dapm);
+				snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+				snd_soc_dapm_sync(dapm);
 			} else
 				regmap_update_bits(rt5645->regmap,
 					RT5645_PWR_VOL, RT5645_PWR_MIC_DET, 0);
@@ -2863,11 +2855,9 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		else {
 			if (codec->component.card->instantiated) {
 				if (rt5645->pdata.jd_mode == 0)
-					snd_soc_dapm_disable_pin(&codec->dapm,
-						"LDO2");
-				snd_soc_dapm_disable_pin(&codec->dapm,
-					"Mic Det Power");
-				snd_soc_dapm_sync(&codec->dapm);
+					snd_soc_dapm_disable_pin(dapm, "LDO2");
+				snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+				snd_soc_dapm_sync(dapm);
 			} else {
 				if (rt5645->pdata.jd_mode == 0)
 					regmap_update_bits(rt5645->regmap,
@@ -3043,21 +3033,22 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
 
 static int rt5645_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	rt5645->codec = codec;
 
 	switch (rt5645->codec_type) {
 	case CODEC_TYPE_RT5645:
-		snd_soc_dapm_add_routes(&codec->dapm,
+		snd_soc_dapm_add_routes(dapm,
 			rt5645_specific_dapm_routes,
 			ARRAY_SIZE(rt5645_specific_dapm_routes));
 		break;
 	case CODEC_TYPE_RT5650:
-		snd_soc_dapm_new_controls(&codec->dapm,
+		snd_soc_dapm_new_controls(dapm,
 			rt5650_specific_dapm_widgets,
 			ARRAY_SIZE(rt5650_specific_dapm_widgets));
-		snd_soc_dapm_add_routes(&codec->dapm,
+		snd_soc_dapm_add_routes(dapm,
 			rt5650_specific_dapm_routes,
 			ARRAY_SIZE(rt5650_specific_dapm_routes));
 		break;
@@ -3067,9 +3058,9 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 
 	/* for JD function */
 	if (rt5645->pdata.jd_mode) {
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "JD Power");
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO2");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_force_enable_pin(dapm, "JD Power");
+		snd_soc_dapm_force_enable_pin(dapm, "LDO2");
+		snd_soc_dapm_sync(dapm);
 	}
 
 	return 0;
-- 
2.1.4
