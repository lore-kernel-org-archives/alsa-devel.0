From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt298: fix capture doesn't work at
	some cases
Date: Tue, 26 Apr 2016 18:07:11 +0800
Message-ID: <1461665231-14070-2-git-send-email-bardliao@realtek.com>
References: <1461665231-14070-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D935F2606D2
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 12:07:24 +0200 (CEST)
In-Reply-To: <1461665231-14070-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, ramesh.babu@intel.com, Bard Liao <bardliao@realtek.com>, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

RT298_CBJ_CTRL1(0x4f) bit 10 is needed for headset capture. It
will be turned off when "VREF" widget is on and be turned on when
bias level is ON. It is odd. And if "VREF" is turned on in bias
level is ON, RT298_CBJ_CTRL1(0x4f) bit 10 will be turned off.
This patch move the bit control from rt298_set_bias_level and
rt298_vref_event to rt298_jack_detect. So it will be turned on
once a jack is plugged in.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 178b1cc..68cf8d5 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -275,6 +275,8 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 		} else {
 			*mic = false;
 			regmap_write(rt298->regmap, RT298_SET_MIC1, 0x20);
+			regmap_update_bits(rt298->regmap,
+				RT298_CBJ_CTRL1, 0x0400, 0x0000);
 		}
 	} else {
 		regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
@@ -539,30 +541,12 @@ static int rt298_mic1_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rt298_vref_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec,
-			RT298_CBJ_CTRL1, 0x0400, 0x0000);
-		mdelay(50);
-		break;
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
 static const struct snd_soc_dapm_widget rt298_dapm_widgets[] = {
 
 	SND_SOC_DAPM_SUPPLY_S("HV", 1, RT298_POWER_CTRL1,
 		12, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("VREF", RT298_POWER_CTRL1,
-		0, 1, rt298_vref_event, SND_SOC_DAPM_PRE_PMU),
+		0, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("BG_MBIAS", 1, RT298_POWER_CTRL2,
 		1, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("LDO1", 1, RT298_POWER_CTRL2,
@@ -953,18 +937,9 @@ static int rt298_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 
-	case SND_SOC_BIAS_ON:
-		mdelay(30);
-		snd_soc_update_bits(codec,
-			RT298_CBJ_CTRL1, 0x0400, 0x0400);
-
-		break;
-
 	case SND_SOC_BIAS_STANDBY:
 		snd_soc_write(codec,
 			RT298_SET_AUDIO_POWER, AC_PWRST_D3);
-		snd_soc_update_bits(codec,
-			RT298_CBJ_CTRL1, 0x0400, 0x0000);
 		break;
 
 	default:
-- 
1.8.1.1.439.g50a6b54
