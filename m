From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 1/2] ASoC: rt5645: Update dapm pins when the
	card is not instantiated yet
Date: Thu, 16 Jul 2015 13:42:33 +0800
Message-ID: <1437025354-22678-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D6926607E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 07:42:41 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so36747442pac.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 22:42:40 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

This makes sure the dapm state is consistent when the card is
instantiated.

However, if the card is not instantiated yet, we still update the
registers manually in the "jack in" case, so that we can immediately
report if a mic is present or not.

Disabling "Mic Det Power" after detection, and on jack out, can
wait until the card gets instantiated.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 093a41d..a56bca6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2805,12 +2805,11 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	if (jack_insert) {
 		regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0006);
 
-		if (codec->component.card->instantiated) {
-			/* for jack type detect */
-			snd_soc_dapm_force_enable_pin(dapm, "LDO2");
-			snd_soc_dapm_force_enable_pin(dapm, "Mic Det Power");
-			snd_soc_dapm_sync(dapm);
-		} else {
+		/* for jack type detect */
+		snd_soc_dapm_force_enable_pin(dapm, "LDO2");
+		snd_soc_dapm_force_enable_pin(dapm, "Mic Det Power");
+		snd_soc_dapm_sync(dapm);
+		if (!dapm->card->instantiated) {
 			/* Power up necessary bits for JD if dapm is
 			   not ready yet */
 			regmap_update_bits(rt5645->regmap, RT5645_PWR_ANLG1,
@@ -2841,12 +2840,8 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 				rt5645_enable_push_button_irq(codec, true);
 			}
 		} else {
-			if (codec->component.card->instantiated) {
-				snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
-				snd_soc_dapm_sync(dapm);
-			} else
-				regmap_update_bits(rt5645->regmap,
-					RT5645_PWR_VOL, RT5645_PWR_MIC_DET, 0);
+			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
 
@@ -2855,19 +2850,10 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		if (rt5645->en_button_func)
 			rt5645_enable_push_button_irq(codec, false);
 		else {
-			if (codec->component.card->instantiated) {
-				if (rt5645->pdata.jd_mode == 0)
-					snd_soc_dapm_disable_pin(dapm, "LDO2");
-				snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
-				snd_soc_dapm_sync(dapm);
-			} else {
-				if (rt5645->pdata.jd_mode == 0)
-					regmap_update_bits(rt5645->regmap,
-						RT5645_PWR_MIXER,
-						RT5645_PWR_LDO2, 0);
-				regmap_update_bits(rt5645->regmap,
-					RT5645_PWR_VOL, RT5645_PWR_MIC_DET, 0);
-			}
+			if (rt5645->pdata.jd_mode == 0)
+				snd_soc_dapm_disable_pin(dapm, "LDO2");
+			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+			snd_soc_dapm_sync(dapm);
 		}
 	}
 
-- 
2.4.3.573.g4eafbef
