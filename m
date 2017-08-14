From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Fine tune for the headphone
	output pop sound
Date: Mon, 14 Aug 2017 09:46:59 +0800
Message-ID: <1502675219-23718-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 92190266CC9
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 03:47:14 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch fine tunes for the headphone output pop sound.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 8119819..c98a8a7 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1565,6 +1565,10 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		val = snd_soc_read(codec, RT5663_EM_JACK_TYPE_2) & 0x0003;
 		dev_dbg(codec->dev, "%s val = %d\n", __func__, val);
 
+		snd_soc_update_bits(codec, RT5663_HP_CHARGE_PUMP_1,
+			RT5663_OSW_HP_L_MASK | RT5663_OSW_HP_R_MASK,
+			RT5663_OSW_HP_L_EN | RT5663_OSW_HP_R_EN);
+
 		switch (val) {
 		case 1:
 		case 2:
@@ -2073,6 +2077,8 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 			snd_soc_write(codec, RT5663_ANA_BIAS_CUR_1, 0x7766);
 			snd_soc_write(codec, RT5663_HP_BIAS, 0xafaa);
 			snd_soc_write(codec, RT5663_CHARGE_PUMP_2, 0x7777);
+			snd_soc_update_bits(codec, RT5663_STO_DRE_1, 0x8000,
+				0x8000);
 			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x3000,
 				0x3000);
 		}
@@ -2105,14 +2111,19 @@ static int rt5663_charge_pump_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (rt5663->codec_ver == CODEC_VER_0)
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x003b,
-				0x003b);
+		if (rt5663->codec_ver == CODEC_VER_0) {
+			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0030,
+				0x0030);
+			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0003,
+				0x0003);
+		}
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		if (rt5663->codec_ver == CODEC_VER_0)
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x003b, 0);
+		if (rt5663->codec_ver == CODEC_VER_0) {
+			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0003, 0);
+			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0030, 0);
+		}
 		break;
 
 	default:
-- 
2.7.4
