From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8996 only needs bandgap for analogue
	functionality
Date: Fri, 16 Sep 2011 17:40:00 +0100
Message-ID: <1316191200-3438-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D38B8243A1
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:40:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Rather than managing the bandgap in the bias level control use a supply
widget as we only actually need to enable it for analogue paths, not
fully digital ones.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   37 +++++++++++++++++++++++++++++--------
 1 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 5ca9d76..93fbb5b 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -666,6 +666,25 @@ SOC_SINGLE_TLV("DSP2 EQ B5 Volume", WM8996_DSP2_RX_EQ_GAINS_2, 6, 31, 0,
 	       eq_tlv),
 };
 
+static int bg_event(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		msleep(2);
+		break;
+	default:
+		BUG();
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int cp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
@@ -999,7 +1018,8 @@ SND_SOC_DAPM_SUPPLY_S("AIFCLK", 2, WM8996_CLOCKING_1, 2, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("Charge Pump", 2, WM8996_CHARGE_PUMP_1, 15, 0, cp_event,
 		      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 		      SND_SOC_DAPM_POST_PMD),
-
+SND_SOC_DAPM_SUPPLY("Bandgap", WM8996_POWER_MANAGEMENT_1, WM8996_BG_ENA, 0,
+		    bg_event, SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_SUPPLY("LDO2", WM8996_POWER_MANAGEMENT_2, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("MICB1 Audio", WM8996_MICBIAS_1, 4, 1, NULL, 0),
 SND_SOC_DAPM_SUPPLY("MICB2 Audio", WM8996_MICBIAS_2, 4, 1, NULL, 0),
@@ -1159,18 +1179,22 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
 
 	{ "MICB1", NULL, "LDO2" },
 	{ "MICB1", NULL, "MICB1 Audio" },
+	{ "MICB1", NULL, "Bandgap" },
 	{ "MICB2", NULL, "LDO2" },
 	{ "MICB2", NULL, "MICB2 Audio" },
+	{ "MICB2", NULL, "Bandgap" },
 
 	{ "IN1L PGA", NULL, "IN2LN" },
 	{ "IN1L PGA", NULL, "IN2LP" },
 	{ "IN1L PGA", NULL, "IN1LN" },
 	{ "IN1L PGA", NULL, "IN1LP" },
+	{ "IN1L PGA", NULL, "Bandgap" },
 
 	{ "IN1R PGA", NULL, "IN2RN" },
 	{ "IN1R PGA", NULL, "IN2RP" },
 	{ "IN1R PGA", NULL, "IN1RN" },
 	{ "IN1R PGA", NULL, "IN1RP" },
+	{ "IN1R PGA", NULL, "Bandgap" },
 
 	{ "ADCL", NULL, "IN1L PGA" },
 
@@ -1304,6 +1328,7 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
 	{ "DAC2R", NULL, "DAC2R Mixer" },
 
 	{ "HPOUT2L PGA", NULL, "Charge Pump" },
+	{ "HPOUT2L PGA", NULL, "Bandgap" },
 	{ "HPOUT2L PGA", NULL, "DAC2L" },
 	{ "HPOUT2L_DLY", NULL, "HPOUT2L PGA" },
 	{ "HPOUT2L_DCS", NULL, "HPOUT2L_DLY" },
@@ -1311,6 +1336,7 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
 	{ "HPOUT2L_RMV_SHORT", NULL, "HPOUT2L_OUTP" },
 
 	{ "HPOUT2R PGA", NULL, "Charge Pump" },
+	{ "HPOUT2R PGA", NULL, "Bandgap" },
 	{ "HPOUT2R PGA", NULL, "DAC2R" },
 	{ "HPOUT2R_DLY", NULL, "HPOUT2R PGA" },
 	{ "HPOUT2R_DCS", NULL, "HPOUT2R_DLY" },
@@ -1318,6 +1344,7 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
 	{ "HPOUT2R_RMV_SHORT", NULL, "HPOUT2R_OUTP" },
 
 	{ "HPOUT1L PGA", NULL, "Charge Pump" },
+	{ "HPOUT1L PGA", NULL, "Bandgap" },
 	{ "HPOUT1L PGA", NULL, "DAC1L" },
 	{ "HPOUT1L_DLY", NULL, "HPOUT1L PGA" },
 	{ "HPOUT1L_DCS", NULL, "HPOUT1L_DLY" },
@@ -1325,6 +1352,7 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
 	{ "HPOUT1L_RMV_SHORT", NULL, "HPOUT1L_OUTP" },
 
 	{ "HPOUT1R PGA", NULL, "Charge Pump" },
+	{ "HPOUT1R PGA", NULL, "Bandgap" },
 	{ "HPOUT1R PGA", NULL, "DAC1R" },
 	{ "HPOUT1R_DLY", NULL, "HPOUT1R PGA" },
 	{ "HPOUT1R_DCS", NULL, "HPOUT1R_DLY" },
@@ -1643,14 +1671,7 @@ static int wm8996_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		break;
-
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
-			snd_soc_update_bits(codec, WM8996_POWER_MANAGEMENT_1,
-					    WM8996_BG_ENA, WM8996_BG_ENA);
-			msleep(2);
-		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-- 
1.7.6.3
