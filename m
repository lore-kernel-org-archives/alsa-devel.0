From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 2/2] ASoC: rt5645: Simplify
	rt5645_enable_push_button_irq
Date: Thu, 16 Jul 2015 13:42:34 +0800
Message-ID: <1437025354-22678-2-git-send-email-drinkcat@chromium.org>
References: <1437025354-22678-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DA84266085
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 07:42:43 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so38165047pdj.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 22:42:42 -0700 (PDT)
In-Reply-To: <1437025354-22678-1-git-send-email-drinkcat@chromium.org>
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

LDO2/Mic Det Power pins are already enabled/disabled in rt5645_jack_detect
(the jack out code path previously did not disable those if button function
is enabled: modify it to make it so).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a56bca6..ff2d4a4 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2766,13 +2766,9 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	if (enable) {
-		snd_soc_dapm_mutex_lock(dapm);
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "ADC L power");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "ADC R power");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO2");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "Mic Det Power");
-		snd_soc_dapm_sync_unlocked(dapm);
-		snd_soc_dapm_mutex_unlock(dapm);
+		snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
+		snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
+		snd_soc_dapm_sync(dapm);
 
 		snd_soc_update_bits(codec,
 					RT5645_INT_IRQ_ST, 0x8, 0x8);
@@ -2785,14 +2781,9 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
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
+		snd_soc_dapm_disable_pin(dapm, "ADC L power");
+		snd_soc_dapm_disable_pin(dapm, "ADC R power");
+		snd_soc_dapm_sync(dapm);
 	}
 }
 
@@ -2847,14 +2838,14 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 
 	} else { /* jack out */
 		rt5645->jack_type = 0;
+
 		if (rt5645->en_button_func)
 			rt5645_enable_push_button_irq(codec, false);
-		else {
-			if (rt5645->pdata.jd_mode == 0)
-				snd_soc_dapm_disable_pin(dapm, "LDO2");
-			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
-			snd_soc_dapm_sync(dapm);
-		}
+
+		if (rt5645->pdata.jd_mode == 0)
+			snd_soc_dapm_disable_pin(dapm, "LDO2");
+		snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+		snd_soc_dapm_sync(dapm);
 	}
 
 	return rt5645->jack_type;
-- 
2.4.3.573.g4eafbef
