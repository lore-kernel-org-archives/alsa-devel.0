From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5663: Modify the power sequence
	for reducing the pop sound
Date: Fri, 7 Jul 2017 16:58:59 +0800
Message-ID: <1499417939-319-3-git-send-email-oder_chiou@realtek.com>
References: <1499417939-319-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A07426716B
 for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2017 10:59:14 +0200 (CEST)
In-Reply-To: <1499417939-319-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch modifies the power sequence for reducing the pop sound.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index ebd9ae0..82edbcf 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -2029,10 +2029,6 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 				RT5663_HP_SIG_SRC1_SILENCE);
 		} else {
 			snd_soc_write(codec, RT5663_DEPOP_2, 0x3003);
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x000b,
-				0x000b);
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0030,
-				0x0030);
 			snd_soc_update_bits(codec, RT5663_HP_CHARGE_PUMP_1,
 				RT5663_OVCD_HP_MASK, RT5663_OVCD_HP_DIS);
 			snd_soc_write(codec, RT5663_HP_CHARGE_PUMP_2, 0x1371);
@@ -2055,9 +2051,6 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x3000, 0x0);
 			snd_soc_update_bits(codec, RT5663_HP_CHARGE_PUMP_1,
 				RT5663_OVCD_HP_MASK, RT5663_OVCD_HP_EN);
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0030, 0x0);
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x000b,
-				0x000b);
 		}
 		break;
 
@@ -2068,6 +2061,31 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5663_charge_pump_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5663_priv *rt5663 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (rt5663->codec_ver == CODEC_VER_0)
+			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x003b,
+				0x003b);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		if (rt5663->codec_ver == CODEC_VER_0)
+			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x003b, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static int rt5663_bst2_power(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -2187,6 +2205,9 @@ static const struct snd_soc_dapm_widget rt5663_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC R", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* Headphone*/
+	SND_SOC_DAPM_SUPPLY("HP Charge Pump", SND_SOC_NOPM, 0, 0,
+		rt5663_charge_pump_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0, rt5663_hp_event,
 		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 
@@ -2343,6 +2364,7 @@ static const struct snd_soc_dapm_route rt5663_dapm_routes[] = {
 	{ "STO1 DAC MIXR", NULL, "STO1 DAC R Power" },
 	{ "STO1 DAC MIXR", NULL, "STO1 DAC Filter" },
 
+	{ "HP Amp", NULL, "HP Charge Pump" },
 	{ "HP Amp", NULL, "DAC L" },
 	{ "HP Amp", NULL, "DAC R" },
 };
-- 
2.7.4
