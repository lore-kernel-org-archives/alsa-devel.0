From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: fix capture doesn't work at some
	cases
Date: Thu, 21 Jan 2016 14:10:48 +0800
Message-ID: <1453356648-27625-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 764912604EF
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 07:11:03 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, dharageswari.r@intel.com, john.lin@realtek.com, lars@metafoo.de, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

RT286_CBJ_CTRL1(0x4f) bit 10 is needed for headset capture. It
will be turned off when "VREF" widget is on and be turned on when
bias level is ON. It is odd. And if "VREF" is turned on in bias
level is ON, RT286_CBJ_CTRL1(0x4f) bit 10 will be turned off.
This patch move the bit control from rt286_set_bias_level and
rt298_vref_event to rt286_jack_detect. So it will be turned on
once a jack is plugged in.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
The bit is already set in rt286_jack_detect's jack in case,
So, it is not on the patch.
---
 sound/soc/codecs/rt286.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index bc08f0c..1bd3164 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -266,6 +266,8 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 		} else {
 			*mic = false;
 			regmap_write(rt286->regmap, RT286_SET_MIC1, 0x20);
+			regmap_update_bits(rt286->regmap,
+				RT286_CBJ_CTRL1, 0x0400, 0x0000);
 		}
 	} else {
 		regmap_read(rt286->regmap, RT286_GET_HP_SENSE, &buf);
@@ -470,24 +472,6 @@ static int rt286_set_dmic1_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rt286_vref_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec,
-			RT286_CBJ_CTRL1, 0x0400, 0x0000);
-		mdelay(50);
-		break;
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
 static int rt286_ldo2_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
@@ -536,7 +520,7 @@ static const struct snd_soc_dapm_widget rt286_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("HV", 1, RT286_POWER_CTRL1,
 		12, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("VREF", RT286_POWER_CTRL1,
-		0, 1, rt286_vref_event, SND_SOC_DAPM_PRE_PMU),
+		0, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("LDO1", 1, RT286_POWER_CTRL2,
 		2, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("LDO2", 2, RT286_POWER_CTRL1,
@@ -911,8 +895,6 @@ static int rt286_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_ON:
 		mdelay(10);
 		snd_soc_update_bits(codec,
-			RT286_CBJ_CTRL1, 0x0400, 0x0400);
-		snd_soc_update_bits(codec,
 			RT286_DC_GAIN, 0x200, 0x0);
 
 		break;
@@ -920,8 +902,6 @@ static int rt286_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		snd_soc_write(codec,
 			RT286_SET_AUDIO_POWER, AC_PWRST_D3);
-		snd_soc_update_bits(codec,
-			RT286_CBJ_CTRL1, 0x0400, 0x0000);
 		break;
 
 	default:
-- 
1.8.1.1.439.g50a6b54
