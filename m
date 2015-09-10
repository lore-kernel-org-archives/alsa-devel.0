From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5645: Remove incorrect settings
Date: Thu, 10 Sep 2015 13:40:16 +0800
Message-ID: <1441863617-15145-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 31CCB2612AE
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 07:40:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch removes the incorrect settings to avoid the pop sound in the
first playback with headphone after boot.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4972bf3..595ace9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2829,10 +2829,6 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
-
-		snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
-		snd_soc_write(codec, RT5645_DEPOP_M1, 0x001d);
-		snd_soc_write(codec, RT5645_DEPOP_M1, 0x0001);
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
@@ -2880,8 +2876,6 @@ int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 		rt5645->en_button_func = true;
 		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
-		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
-				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
 	}
-- 
1.8.1.1.439.g50a6b54
