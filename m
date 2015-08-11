From: John Lin <john.lin@realtek.com>
Subject: [PATCH] ASoC: rt5640: fix line out no sound issue
Date: Tue, 11 Aug 2015 14:27:25 +0800
Message-ID: <1439274445-22547-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 190472604A9
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 08:28:01 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, John Lin <john.lin@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The power for line out was not turned on when line out is enabled.
So we add "LOUT amp" widget to turn on the power for line out.

Signed-off-by: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rt5640.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 7d488d8..3c5b496 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -985,6 +985,35 @@ static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5640_lout_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		hp_amp_power_on(codec);
+		snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+			RT5640_PWR_LM, RT5640_PWR_LM);
+		snd_soc_update_bits(codec, RT5640_OUTPUT,
+			RT5640_L_MUTE | RT5640_R_MUTE, 0);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5640_OUTPUT,
+			RT5640_L_MUTE | RT5640_R_MUTE,
+			RT5640_L_MUTE | RT5640_R_MUTE);
+		snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+			RT5640_PWR_LM, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static int rt5640_hp_power_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
@@ -1180,13 +1209,16 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 		0, rt5640_spo_l_mix, ARRAY_SIZE(rt5640_spo_l_mix)),
 	SND_SOC_DAPM_MIXER("SPOR MIX", SND_SOC_NOPM, 0,
 		0, rt5640_spo_r_mix, ARRAY_SIZE(rt5640_spo_r_mix)),
-	SND_SOC_DAPM_MIXER("LOUT MIX", RT5640_PWR_ANLG1, RT5640_PWR_LM_BIT, 0,
+	SND_SOC_DAPM_MIXER("LOUT MIX", SND_SOC_NOPM, 0, 0,
 		rt5640_lout_mix, ARRAY_SIZE(rt5640_lout_mix)),
 	SND_SOC_DAPM_SUPPLY_S("Improve HP Amp Drv", 1, SND_SOC_NOPM,
 		0, 0, rt5640_hp_power_event, SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0,
 		rt5640_hp_event,
 		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("LOUT amp", 1, SND_SOC_NOPM, 0, 0,
+		rt5640_lout_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("HP L Amp", RT5640_PWR_ANLG1,
 		RT5640_PWR_HP_L_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("HP R Amp", RT5640_PWR_ANLG1,
@@ -1501,8 +1533,10 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"HP R Playback", "Switch", "HP Amp"},
 	{"HPOL", NULL, "HP L Playback"},
 	{"HPOR", NULL, "HP R Playback"},
-	{"LOUTL", NULL, "LOUT MIX"},
-	{"LOUTR", NULL, "LOUT MIX"},
+
+	{"LOUT amp", NULL, "LOUT MIX"},
+	{"LOUTL", NULL, "LOUT amp"},
+	{"LOUTR", NULL, "LOUT amp"},
 };
 
 static const struct snd_soc_dapm_route rt5640_specific_dapm_routes[] = {
-- 
1.8.1.1.439.g50a6b54
