From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 1/3] ASoC: rt5645: Simplify
	rt5645_enable_push_button_irq
Date: Tue, 14 Jul 2015 14:51:25 +0800
Message-ID: <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id B81C22606DD
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 08:52:07 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so581282pac.3
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 23:52:05 -0700 (PDT)
In-Reply-To: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

LDO2/Mic Det Power pins are already enabled/disabled in rt5645_jack_detect
(the jack out code path previously did not disable those: modify it to make
it so).

Also, provide an alternative if dapm is not ready yet.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 55 +++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9dfa431..45651f4 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2766,13 +2766,15 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	if (enable) {
-		snd_soc_dapm_mutex_lock(dapm);
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "ADC L power");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "ADC R power");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO2");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "Mic Det Power");
-		snd_soc_dapm_sync_unlocked(dapm);
-		snd_soc_dapm_mutex_unlock(dapm);
+		if (codec->component.card->instantiated) {
+			snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
+			snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
+			snd_soc_dapm_sync(dapm);
+		} else {
+			regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
+				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
+				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT);
+		}
 
 		snd_soc_update_bits(codec,
 					RT5645_INT_IRQ_ST, 0x8, 0x8);
@@ -2785,14 +2787,15 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD2, 0x8000, 0x0);
 		snd_soc_update_bits(codec, RT5645_INT_IRQ_ST, 0x8, 0x0);
 
-		snd_soc_dapm_mutex_lock(dapm);
-		snd_soc_dapm_disable_pin_unlocked(dapm, "ADC L power");
-		snd_soc_dapm_disable_pin_unlocked(dapm, "ADC R power");
-		if (rt5645->pdata.jd_mode == 0)
-			snd_soc_dapm_disable_pin_unlocked(dapm, "LDO2");
-		snd_soc_dapm_disable_pin_unlocked(dapm, "Mic Det Power");
-		snd_soc_dapm_sync_unlocked(dapm);
-		snd_soc_dapm_mutex_unlock(dapm);
+		if (codec->component.card->instantiated) {
+			snd_soc_dapm_disable_pin(dapm, "ADC L power");
+			snd_soc_dapm_disable_pin(dapm, "ADC R power");
+			snd_soc_dapm_sync(dapm);
+		} else {
+			regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
+				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
+				0);
+		}
 	}
 }
 
@@ -2852,22 +2855,22 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 
 	} else { /* jack out */
 		rt5645->jack_type = 0;
+
 		if (rt5645->en_button_func)
 			rt5645_enable_push_button_irq(codec, false);
-		else {
-			if (codec->component.card->instantiated) {
-				if (rt5645->pdata.jd_mode == 0)
-					snd_soc_dapm_disable_pin(dapm, "LDO2");
-				snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
-				snd_soc_dapm_sync(dapm);
-			} else {
-				if (rt5645->pdata.jd_mode == 0)
-					regmap_update_bits(rt5645->regmap,
+
+		if (codec->component.card->instantiated) {
+			if (rt5645->pdata.jd_mode == 0)
+				snd_soc_dapm_disable_pin(dapm, "LDO2");
+			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+			snd_soc_dapm_sync(dapm);
+		} else {
+			if (rt5645->pdata.jd_mode == 0)
+				regmap_update_bits(rt5645->regmap,
 						RT5645_PWR_MIXER,
 						RT5645_PWR_LDO2, 0);
-				regmap_update_bits(rt5645->regmap,
+			regmap_update_bits(rt5645->regmap,
 					RT5645_PWR_VOL, RT5645_PWR_MIC_DET, 0);
-			}
 		}
 	}
 
-- 
2.4.3.573.g4eafbef
