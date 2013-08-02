From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5640: change widget sequence for depop
Date: Fri, 2 Aug 2013 10:38:02 +0800
Message-ID: <1375411082-7780-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E39C265628
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 04:38:31 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Add mute/unmute control in widget event and modify the power on/off sequence to avoid pop noise.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5640.c | 387 ++++++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/rt5640.h |  15 ++
 2 files changed, 352 insertions(+), 50 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 4db7314..3490f38 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -378,21 +378,119 @@ static const SOC_ENUM_SINGLE_DECL(rt5640_if2_adc_enum, RT5640_DIG_INF_DATA,
 static const char * const rt5640_clsd_spk_ratio[] = {"1.66x", "1.83x", "1.94x",
 	"2x", "2.11x", "2.22x", "2.33x", "2.44x", "2.55x", "2.66x", "2.77x"};
 
+static const char * const rt5640_mute_mode[] = {"mute", "unmute"};
+
+static const SOC_ENUM_SINGLE_DECL(rt5640_hp_enum, 0, 0, rt5640_mute_mode);
+static const SOC_ENUM_SINGLE_DECL(rt5640_spo_enum, 0, 0, rt5640_mute_mode);
+
 static const SOC_ENUM_SINGLE_DECL(
 	rt5640_clsd_spk_ratio_enum, RT5640_CLS_D_OUT,
 	RT5640_CLSD_RATIO_SFT, rt5640_clsd_spk_ratio);
 
+static int rt5640_spo_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = !rt5640->spo_l_mute;
+	ucontrol->value.integer.value[1] = !rt5640->spo_r_mute;
+
+	return 0;
+}
+
+static int rt5640_spo_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	unsigned int pow;
+
+	pow = snd_soc_read(codec, RT5640_PWR_DIG1) & RT5640_PWR_CLS_D;
+
+	if (ucontrol->value.integer.value[0]) {
+		rt5640->spo_l_mute = false;
+		if (pow)
+			snd_soc_update_bits(codec, RT5640_SPK_VOL,
+				    RT5640_L_MUTE, 0);
+	} else {
+		rt5640->spo_l_mute = true;
+		snd_soc_update_bits(codec, RT5640_SPK_VOL,
+				    RT5640_L_MUTE,
+				    RT5640_L_MUTE);
+	}
+	if (ucontrol->value.integer.value[1]) {
+		rt5640->spo_r_mute = false;
+		if (pow)
+			snd_soc_update_bits(codec, RT5640_SPK_VOL,
+				    RT5640_R_MUTE, 0);
+	} else {
+		rt5640->spo_r_mute = true;
+		snd_soc_update_bits(codec, RT5640_SPK_VOL,
+				    RT5640_R_MUTE,
+				    RT5640_R_MUTE);
+	}
+
+	return 0;
+}
+
+static int rt5640_hp_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = !rt5640->hp_l_mute;
+	ucontrol->value.integer.value[1] = !rt5640->hp_r_mute;
+
+	return 0;
+}
+
+static int rt5640_hp_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	unsigned int pow;
+
+	pow = snd_soc_read(codec,  RT5640_PWR_ANLG1);
+
+	if (ucontrol->value.integer.value[0]) {
+		rt5640->hp_l_mute = false;
+		if (pow & RT5640_PWR_HP_L)
+			snd_soc_update_bits(codec, RT5640_HP_VOL,
+				RT5640_L_MUTE, 0);
+	} else {
+		rt5640->hp_l_mute = true;
+		snd_soc_update_bits(codec, RT5640_HP_VOL,
+			RT5640_L_MUTE, RT5640_L_MUTE);
+	}
+	if (ucontrol->value.integer.value[1]) {
+		rt5640->hp_r_mute = false;
+		if (pow & RT5640_PWR_HP_R)
+			snd_soc_update_bits(codec, RT5640_HP_VOL,
+				RT5640_R_MUTE, 0);
+	} else {
+		rt5640->hp_r_mute = true;
+		snd_soc_update_bits(codec, RT5640_HP_VOL,
+			RT5640_R_MUTE, RT5640_R_MUTE);
+	}
+
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 	/* Speaker Output Volume */
-	SOC_DOUBLE("Speaker Playback Switch", RT5640_SPK_VOL,
-		RT5640_L_MUTE_SFT, RT5640_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE_EXT("Speaker Playback Switch", SND_SOC_NOPM,
+		0, 1, 1, 0, rt5640_spo_get, rt5640_spo_put),
 	SOC_DOUBLE("Speaker Channel Switch", RT5640_SPK_VOL,
 		RT5640_VOL_L_SFT, RT5640_VOL_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("Speaker Playback Volume", RT5640_SPK_VOL,
 		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 39, 1, out_vol_tlv),
 	/* Headphone Output Volume */
-	SOC_DOUBLE("HP Playback Switch", RT5640_HP_VOL,
-		RT5640_L_MUTE_SFT, RT5640_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE_EXT("HP Playback Switch", SND_SOC_NOPM,
+		0, 1, 1, 0, rt5640_hp_get, rt5640_hp_put),
 	SOC_DOUBLE("HP Channel Switch", RT5640_HP_VOL,
 		RT5640_VOL_L_SFT, RT5640_VOL_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("HP Playback Volume", RT5640_HP_VOL,
@@ -868,33 +966,6 @@ static const SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5640_sdi_mux =
 	SOC_DAPM_ENUM("SDI select", rt5640_sdi_sel_enum);
 
-static int spk_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		regmap_update_bits(rt5640->regmap, RT5640_PWR_DIG1,
-					0x0001, 0x0001);
-		regmap_update_bits(rt5640->regmap, RT5640_PR_BASE + 0x1c,
-					0xf000, 0xf000);
-		break;
-
-	case SND_SOC_DAPM_PRE_PMD:
-		regmap_update_bits(rt5640->regmap, RT5640_PR_BASE + 0x1c,
-					0xf000, 0x0000);
-		regmap_update_bits(rt5640->regmap, RT5640_PWR_DIG1,
-					0x0001, 0x0000);
-		break;
-
-	default:
-		return 0;
-	}
-	return 0;
-}
-
 static int rt5640_set_dmic1_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -943,6 +1014,216 @@ static int rt5640_set_dmic2_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5640_spo_r_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (!rt5640->spo_r_mute)
+			snd_soc_update_bits(codec, RT5640_SPK_VOL,
+					    RT5640_R_MUTE, 0);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5640_SPK_VOL,
+				    RT5640_R_MUTE,
+				    RT5640_R_MUTE);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5640_spo_l_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (!rt5640->spo_l_mute)
+			snd_soc_update_bits(codec, RT5640_SPK_VOL,
+					    RT5640_L_MUTE, 0);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5640_SPK_VOL,
+				    RT5640_L_MUTE, RT5640_L_MUTE);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+void hp_amp_power_on(struct snd_soc_codec *codec)
+{
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	/* depop parameters */
+	regmap_update_bits(rt5640->regmap, RT5640_PR_BASE +
+		RT5640_CHPUMP_INT_REG1, 0x0700, 0x0200);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M2,
+			    RT5640_DEPOP_MASK,
+			    RT5640_DEPOP_MAN);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_HP_CP_MASK |
+			    RT5640_HP_SG_MASK |
+			    RT5640_HP_CB_MASK,
+			    RT5640_HP_CP_PU | RT5640_HP_SG_DIS |
+			    RT5640_HP_CB_PU);
+	regmap_write(rt5640->regmap, RT5640_PR_BASE + RT5640_HP_DCC_INT1,
+			   0x9f00);
+	/* headphone amp power on */
+	regmap_update_bits(rt5640->regmap, RT5640_PWR_ANLG1,
+			    RT5640_PWR_FV1 | RT5640_PWR_FV2, 0);
+	regmap_update_bits(rt5640->regmap, RT5640_PWR_ANLG1,
+			    RT5640_PWR_HA,
+			    RT5640_PWR_HA);
+	usleep_range(20000, 25000);
+	regmap_update_bits(rt5640->regmap, RT5640_PWR_ANLG1,
+			    RT5640_PWR_FV1 | RT5640_PWR_FV2,
+			    RT5640_PWR_FV1 | RT5640_PWR_FV2);
+
+	regmap_update_bits(rt5640->regmap, RT5640_CHARGE_PUMP,
+			    RT5640_PM_HP_MASK, RT5640_PM_HP_HV);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_HP_CO_MASK |
+			    RT5640_HP_SG_MASK,
+			    RT5640_HP_CO_EN | RT5640_HP_SG_EN);
+	regmap_update_bits(rt5640->regmap, RT5640_PR_BASE +
+		RT5640_CHPUMP_INT_REG1, 0x0700, 0x0400);
+}
+
+static void rt5640_pmu_depop(struct snd_soc_codec *codec)
+{
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val = 0, pow;
+
+	regmap_read(rt5640->regmap,  RT5640_PWR_ANLG1, &pow);
+	if (rt5640->hp_l_mute || !(pow & RT5640_PWR_HP_L))
+		val |= RT5640_L_MUTE;
+	if (rt5640->hp_r_mute || !(pow & RT5640_PWR_HP_R))
+		val |= RT5640_R_MUTE;
+	/* headphone unmute sequence */
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M3,
+			    RT5640_CP_FQ1_MASK | RT5640_CP_FQ2_MASK |
+			    RT5640_CP_FQ3_MASK,
+			    (RT5640_CP_FQ_192_KHZ << RT5640_CP_FQ1_SFT) |
+			    (RT5640_CP_FQ_12_KHZ << RT5640_CP_FQ2_SFT) |
+			    (RT5640_CP_FQ_192_KHZ << RT5640_CP_FQ3_SFT));
+	regmap_write(rt5640->regmap,
+		RT5640_PR_BASE + RT5640_MAMP_INT_REG2, 0xfc00);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_SMT_TRIG_MASK, RT5640_SMT_TRIG_EN);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_RSTN_MASK, RT5640_RSTN_EN);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_RSTN_MASK | RT5640_HP_L_SMT_MASK |
+			    RT5640_HP_R_SMT_MASK,
+			    RT5640_RSTN_DIS | RT5640_HP_L_SMT_EN |
+			    RT5640_HP_R_SMT_EN);
+	regmap_update_bits(rt5640->regmap, RT5640_HP_VOL,
+			    RT5640_L_MUTE | RT5640_R_MUTE, val);
+	usleep_range(40000, 45000);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_HP_SG_MASK | RT5640_HP_L_SMT_MASK |
+			    RT5640_HP_R_SMT_MASK, RT5640_HP_SG_DIS |
+			    RT5640_HP_L_SMT_DIS | RT5640_HP_R_SMT_DIS);
+
+}
+
+static void rt5640_pmd_depop(struct snd_soc_codec *codec)
+{
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	/* headphone mute sequence */
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M3,
+			    RT5640_CP_FQ1_MASK | RT5640_CP_FQ2_MASK |
+			    RT5640_CP_FQ3_MASK,
+			    (RT5640_CP_FQ_96_KHZ << RT5640_CP_FQ1_SFT) |
+			    (RT5640_CP_FQ_12_KHZ << RT5640_CP_FQ2_SFT) |
+			    (RT5640_CP_FQ_96_KHZ << RT5640_CP_FQ3_SFT));
+	regmap_write(rt5640->regmap,
+		RT5640_PR_BASE + RT5640_MAMP_INT_REG2, 0xfc00);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_HP_SG_MASK, RT5640_HP_SG_EN);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_RSTP_MASK, RT5640_RSTP_EN);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+			    RT5640_RSTP_MASK | RT5640_HP_L_SMT_MASK |
+			    RT5640_HP_R_SMT_MASK, RT5640_RSTP_DIS |
+			    RT5640_HP_L_SMT_EN | RT5640_HP_R_SMT_EN);
+
+	regmap_update_bits(rt5640->regmap, RT5640_HP_VOL,
+			    RT5640_L_MUTE | RT5640_R_MUTE,
+			    RT5640_L_MUTE | RT5640_R_MUTE);
+	usleep_range(40000, 45000);
+
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+					    RT5640_HP_SG_MASK |
+					    RT5640_HP_L_SMT_MASK |
+					    RT5640_HP_R_SMT_MASK,
+					    RT5640_HP_SG_DIS |
+					    RT5640_HP_L_SMT_DIS |
+					    RT5640_HP_R_SMT_DIS);
+	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M1,
+					    RT5640_SMT_TRIG_MASK |
+					    RT5640_HP_CD_PD_MASK |
+					    RT5640_HP_CO_MASK |
+					    RT5640_HP_CP_MASK |
+					    RT5640_HP_SG_MASK |
+					    RT5640_HP_CB_MASK,
+					    RT5640_SMT_TRIG_DIS |
+					    RT5640_HP_CD_PD_EN |
+					    RT5640_HP_CO_DIS | RT5640_HP_CP_PD |
+					    RT5640_HP_SG_EN | RT5640_HP_CB_PD);
+}
+
+static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		rt5640_pmu_depop(codec);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		rt5640_pmd_depop(codec);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5640_hp_power_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		hp_amp_power_on(codec);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PLL1", RT5640_PWR_ANLG2,
 			RT5640_PWR_PLL_BIT, 0, NULL, 0),
@@ -1132,15 +1413,23 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 		rt5640_mono_mix, ARRAY_SIZE(rt5640_mono_mix)),
 	SND_SOC_DAPM_SUPPLY("Improve MONO Amp Drv", RT5640_PWR_ANLG1,
 		RT5640_PWR_MA_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("Improve HP Amp Drv", RT5640_PWR_ANLG1,
-		SND_SOC_NOPM, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("HP L Amp", RT5640_PWR_ANLG1,
+	SND_SOC_DAPM_SUPPLY_S("Improve HP Amp Drv", 1, SND_SOC_NOPM,
+		0, 0, rt5640_hp_power_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0,
+		rt5640_hp_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_SUPPLY("HP L Amp", RT5640_PWR_ANLG1,
 		RT5640_PWR_HP_L_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("HP R Amp", RT5640_PWR_ANLG1,
+	SND_SOC_DAPM_SUPPLY("HP R Amp", RT5640_PWR_ANLG1,
 		RT5640_PWR_HP_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_E("SPO L Amp", SND_SOC_NOPM,
+		0, 0, NULL, 0, rt5640_spo_l_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_PGA_E("SPO R Amp", SND_SOC_NOPM,
+		0, 0, NULL, 0, rt5640_spo_r_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_SUPPLY("Improve SPK Amp Drv", RT5640_PWR_DIG1,
-		SND_SOC_NOPM, 0, spk_event,
-		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+		RT5640_PWR_CLS_D_BIT, 0, NULL, 0),
 	/* Output Lines */
 	SND_SOC_DAPM_OUTPUT("SPOLP"),
 	SND_SOC_DAPM_OUTPUT("SPOLN"),
@@ -1396,13 +1685,15 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"Mono MIX", "OUTVOL L Switch", "OUTVOL L"},
 	{"Mono MIX", "BST1 Switch", "BST1"},
 
-	{"HP L Amp", NULL, "HPO MIX L"},
-	{"HP R Amp", NULL, "HPO MIX R"},
+	{"HP Amp", NULL, "HPO MIX L"},
+	{"HP Amp", NULL, "HPO MIX R"},
 
-	{"SPOLP", NULL, "SPOL MIX"},
-	{"SPOLN", NULL, "SPOL MIX"},
-	{"SPORP", NULL, "SPOR MIX"},
-	{"SPORN", NULL, "SPOR MIX"},
+	{"SPO L Amp", NULL, "SPOL MIX"},
+	{"SPO R Amp", NULL, "SPOR MIX"},
+	{"SPOLP", NULL, "SPO L Amp"},
+	{"SPOLN", NULL, "SPO L Amp"},
+	{"SPORP", NULL, "SPO R Amp"},
+	{"SPORN", NULL, "SPO R Amp"},
 
 	{"SPOLP", NULL, "Improve SPK Amp Drv"},
 	{"SPOLN", NULL, "Improve SPK Amp Drv"},
@@ -1412,7 +1703,9 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"HPOL", NULL, "Improve HP Amp Drv"},
 	{"HPOR", NULL, "Improve HP Amp Drv"},
 
+	{"HPOL", NULL, "HP Amp"},
 	{"HPOL", NULL, "HP L Amp"},
+	{"HPOR", NULL, "HP Amp"},
 	{"HPOR", NULL, "HP R Amp"},
 	{"LOUTL", NULL, "LOUT MIX"},
 	{"LOUTR", NULL, "LOUT MIX"},
@@ -1792,17 +2085,13 @@ static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 				RT5640_PWR_BG | RT5640_PWR_VREF2,
 				RT5640_PWR_VREF1 | RT5640_PWR_MB |
 				RT5640_PWR_BG | RT5640_PWR_VREF2);
-			mdelay(10);
+			usleep_range(15000, 20000);
 			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
 				RT5640_PWR_FV1 | RT5640_PWR_FV2,
 				RT5640_PWR_FV1 | RT5640_PWR_FV2);
 			regcache_sync(rt5640->regmap);
 			snd_soc_update_bits(codec, RT5640_DUMMY1,
 						0x0301, 0x0301);
-			snd_soc_update_bits(codec, RT5640_DEPOP_M1,
-						0x001d, 0x0019);
-			snd_soc_update_bits(codec, RT5640_DEPOP_M2,
-						0x2000, 0x2000);
 			snd_soc_update_bits(codec, RT5640_MICBIAS,
 						0x0030, 0x0030);
 		}
@@ -1846,8 +2135,6 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 	rt5640_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_update_bits(codec, RT5640_DUMMY1, 0x0301, 0x0301);
-	snd_soc_update_bits(codec, RT5640_DEPOP_M1, 0x001d, 0x0019);
-	snd_soc_update_bits(codec, RT5640_DEPOP_M2, 0x2000, 0x2000);
 	snd_soc_update_bits(codec, RT5640_MICBIAS, 0x0030, 0x0030);
 	snd_soc_update_bits(codec, RT5640_DSP_PATH2, 0xfc00, 0x0c00);
 
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index c48286d..cb6bce9 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -145,6 +145,8 @@
 
 
 /* Index of Codec Private Register definition */
+#define RT5640_CHPUMP_INT_REG1			0x24
+#define RT5640_MAMP_INT_REG2			0x37
 #define RT5640_3D_SPK				0x63
 #define RT5640_WND_1				0x6c
 #define RT5640_WND_2				0x6d
@@ -153,6 +155,7 @@
 #define RT5640_WND_5				0x70
 #define RT5640_WND_8				0x73
 #define RT5640_DIP_SPK_INF			0x75
+#define RT5640_HP_DCC_INT1			0x77
 #define RT5640_EQ_BW_LOP			0xa0
 #define RT5640_EQ_GN_LOP			0xa1
 #define RT5640_EQ_FC_BP1			0xa2
@@ -1201,6 +1204,14 @@
 #define RT5640_CP_FQ2_SFT			4
 #define RT5640_CP_FQ3_MASK			(0x7)
 #define RT5640_CP_FQ3_SFT			0
+#define RT5640_CP_FQ_1_5_KHZ			0
+#define RT5640_CP_FQ_3_KHZ			1
+#define RT5640_CP_FQ_6_KHZ			2
+#define RT5640_CP_FQ_12_KHZ			3
+#define RT5640_CP_FQ_24_KHZ			4
+#define RT5640_CP_FQ_48_KHZ			5
+#define RT5640_CP_FQ_96_KHZ			6
+#define RT5640_CP_FQ_192_KHZ			7
 
 /* HPOUT charge pump (0x91) */
 #define RT5640_OSW_L_MASK			(0x1 << 11)
@@ -2087,6 +2098,10 @@ struct rt5640_priv {
 	int pll_out;
 
 	int dmic_en;
+	bool spo_l_mute;
+	bool spo_r_mute;
+	bool hp_l_mute;
+	bool hp_r_mute;
 };
 
 #endif
-- 
1.8.1.1.439.g50a6b54
