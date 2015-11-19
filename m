From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Add DAPM/routing hookup for the
	ANC block
Date: Thu, 19 Nov 2015 16:11:10 +0000
Message-ID: <1447949470-9312-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B21AC265FFA
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 17:27:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The wm5110 device contains a hardware ANC block, this patch connects up
controls and routing for this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |  119 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    7 ++
 sound/soc/codecs/wm5110.c  |  136 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index b3ea24d..e76ecc7 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -702,6 +702,100 @@ const struct soc_enum arizona_in_dmic_osr[] = {
 };
 EXPORT_SYMBOL_GPL(arizona_in_dmic_osr);
 
+static const char * const arizona_anc_input_src_text[] = {
+	"None", "IN1", "IN2", "IN3", "IN4",
+};
+
+static const char * const arizona_anc_channel_src_text[] = {
+	"None", "Left", "Right", "Combine",
+};
+
+const struct soc_enum arizona_anc_input_src[] = {
+	SOC_ENUM_SINGLE(ARIZONA_ANC_SRC,
+			ARIZONA_IN_RXANCL_SEL_SHIFT,
+			ARRAY_SIZE(arizona_anc_input_src_text),
+			arizona_anc_input_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_FCL_ADC_REFORMATTER_CONTROL,
+			ARIZONA_FCL_MIC_MODE_SEL,
+			ARRAY_SIZE(arizona_anc_channel_src_text),
+			arizona_anc_channel_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_ANC_SRC,
+			ARIZONA_IN_RXANCR_SEL_SHIFT,
+			ARRAY_SIZE(arizona_anc_input_src_text),
+			arizona_anc_input_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_FCR_ADC_REFORMATTER_CONTROL,
+			ARIZONA_FCR_MIC_MODE_SEL,
+			ARRAY_SIZE(arizona_anc_channel_src_text),
+			arizona_anc_channel_src_text),
+};
+EXPORT_SYMBOL_GPL(arizona_anc_input_src);
+
+static const char * const arizona_anc_ng_texts[] = {
+	"None",
+	"Internal",
+	"External",
+};
+
+SOC_ENUM_SINGLE_DECL(arizona_anc_ng_enum, SND_SOC_NOPM, 0,
+		     arizona_anc_ng_texts);
+EXPORT_SYMBOL_GPL(arizona_anc_ng_enum);
+
+static const char * const arizona_output_anc_src_text[] = {
+	"None", "RXANCL", "RXANCR",
+};
+
+const struct soc_enum arizona_output_anc_src[] = {
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_1L,
+			ARIZONA_OUT1L_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_1R,
+			ARIZONA_OUT1R_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_2L,
+			ARIZONA_OUT2L_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_2R,
+			ARIZONA_OUT2R_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_3L,
+			ARIZONA_OUT3L_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_DAC_VOLUME_LIMIT_3R,
+			ARIZONA_OUT3R_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_4L,
+			ARIZONA_OUT4L_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_4R,
+			ARIZONA_OUT4R_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_5L,
+			ARIZONA_OUT5L_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_5R,
+			ARIZONA_OUT5R_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_6L,
+			ARIZONA_OUT6L_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_6R,
+			ARIZONA_OUT6R_ANC_SRC_SHIFT,
+			ARRAY_SIZE(arizona_output_anc_src_text),
+			arizona_output_anc_src_text),
+};
+EXPORT_SYMBOL_GPL(arizona_output_anc_src);
+
 static void arizona_in_set_vu(struct snd_soc_codec *codec, int ena)
 {
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
@@ -1023,6 +1117,31 @@ void arizona_init_dvfs(struct arizona_priv *priv)
 }
 EXPORT_SYMBOL_GPL(arizona_init_dvfs);
 
+int arizona_anc_ev(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol,
+		   int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	unsigned int mask = 0x3 << w->shift;
+	unsigned int val;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		val = 1 << w->shift;
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		val = 1 << (w->shift + 1);
+		break;
+	default:
+		return 0;
+	}
+
+	snd_soc_update_bits(codec, ARIZONA_CLOCK_CONTROL, mask, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_anc_ev);
+
 static unsigned int arizona_opclk_ref_48k_rates[] = {
 	6144000,
 	12288000,
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index fea8b8a..01a367c 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -242,6 +242,10 @@ extern const struct soc_enum arizona_in_dmic_osr[];
 
 extern const struct snd_kcontrol_new arizona_adsp2_rate_controls[];
 
+extern const struct soc_enum arizona_anc_input_src[];
+extern const struct soc_enum arizona_anc_ng_enum;
+extern const struct soc_enum arizona_output_anc_src[];
+
 extern int arizona_in_ev(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
 			 int event);
@@ -251,6 +255,9 @@ extern int arizona_out_ev(struct snd_soc_dapm_widget *w,
 extern int arizona_hp_ev(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
 			 int event);
+extern int arizona_anc_ev(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event);
 
 extern int arizona_eq_coeff_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol);
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c04c0bc..e93e542 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -575,6 +575,33 @@ static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 	SOC_SINGLE(name " NG SPKDAT2L Switch", base, 10, 1, 0), \
 	SOC_SINGLE(name " NG SPKDAT2R Switch", base, 11, 1, 0)
 
+#define WM5110_RXANC_INPUT_ROUTES(widget, name) \
+	{ widget, NULL, name " NG Mux" }, \
+	{ name " NG Internal", NULL, "RXANC NG Clock" }, \
+	{ name " NG Internal", NULL, name " Channel" }, \
+	{ name " NG External", NULL, "RXANC NG External Clock" }, \
+	{ name " NG External", NULL, name " Channel" }, \
+	{ name " NG Mux", "None", name " Channel" }, \
+	{ name " NG Mux", "Internal", name " NG Internal" }, \
+	{ name " NG Mux", "External", name " NG External" }, \
+	{ name " Channel", "Left", name " Left Input" }, \
+	{ name " Channel", "Combine", name " Left Input" }, \
+	{ name " Channel", "Right", name " Right Input" }, \
+	{ name " Channel", "Combine", name " Right Input" }, \
+	{ name " Left Input", "IN1", "IN1L PGA" }, \
+	{ name " Right Input", "IN1", "IN1R PGA" }, \
+	{ name " Left Input", "IN2", "IN2L PGA" }, \
+	{ name " Right Input", "IN2", "IN2R PGA" }, \
+	{ name " Left Input", "IN3", "IN3L PGA" }, \
+	{ name " Right Input", "IN3", "IN3R PGA" }, \
+	{ name " Left Input", "IN4", "IN4L PGA" }, \
+	{ name " Right Input", "IN4", "IN4R PGA" }
+
+#define WM5110_RXANC_OUTPUT_ROUTES(widget, name) \
+	{ widget, NULL, name " ANC Source" }, \
+	{ name " ANC Source", "RXANCL", "RXANCL" }, \
+	{ name " ANC Source", "RXANCR", "RXANCR" }
+
 static const struct snd_kcontrol_new wm5110_snd_controls[] = {
 SOC_ENUM("IN1 OSR", arizona_in_dmic_osr[0]),
 SOC_ENUM("IN2 OSR", arizona_in_dmic_osr[1]),
@@ -639,6 +666,15 @@ SOC_SINGLE_TLV("IN4R Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_4R,
 SOC_ENUM("Input Ramp Up", arizona_in_vi_ramp),
 SOC_ENUM("Input Ramp Down", arizona_in_vd_ramp),
 
+SND_SOC_BYTES("RXANC Coefficients", ARIZONA_ANC_COEFF_START,
+	      ARIZONA_ANC_COEFF_END - ARIZONA_ANC_COEFF_START + 1),
+SND_SOC_BYTES("RXANCL Config", ARIZONA_FCL_FILTER_CONTROL, 1),
+SND_SOC_BYTES("RXANCL Coefficients", ARIZONA_FCL_COEFF_START,
+	      ARIZONA_FCL_COEFF_END - ARIZONA_FCL_COEFF_START + 1),
+SND_SOC_BYTES("RXANCR Config", ARIZONA_FCR_FILTER_CONTROL, 1),
+SND_SOC_BYTES("RXANCR Coefficients", ARIZONA_FCR_COEFF_START,
+	      ARIZONA_FCR_COEFF_END - ARIZONA_FCR_COEFF_START + 1),
+
 ARIZONA_MIXER_CONTROLS("EQ1", ARIZONA_EQ1MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
@@ -995,6 +1031,31 @@ static const struct soc_enum wm5110_aec_loopback =
 static const struct snd_kcontrol_new wm5110_aec_loopback_mux =
 	SOC_DAPM_ENUM("AEC Loopback", wm5110_aec_loopback);
 
+static const struct snd_kcontrol_new wm5110_anc_input_mux[] = {
+	SOC_DAPM_ENUM("RXANCL Input", arizona_anc_input_src[0]),
+	SOC_DAPM_ENUM("RXANCL Channel", arizona_anc_input_src[1]),
+	SOC_DAPM_ENUM("RXANCR Input", arizona_anc_input_src[2]),
+	SOC_DAPM_ENUM("RXANCR Channel", arizona_anc_input_src[3]),
+};
+
+static const struct snd_kcontrol_new wm5110_anc_ng_mux =
+	SOC_DAPM_ENUM("RXANC NG Source", arizona_anc_ng_enum);
+
+static const struct snd_kcontrol_new wm5110_output_anc_src[] = {
+	SOC_DAPM_ENUM("HPOUT1L ANC Source", arizona_output_anc_src[0]),
+	SOC_DAPM_ENUM("HPOUT1R ANC Source", arizona_output_anc_src[1]),
+	SOC_DAPM_ENUM("HPOUT2L ANC Source", arizona_output_anc_src[2]),
+	SOC_DAPM_ENUM("HPOUT2R ANC Source", arizona_output_anc_src[3]),
+	SOC_DAPM_ENUM("HPOUT3L ANC Source", arizona_output_anc_src[4]),
+	SOC_DAPM_ENUM("HPOUT3R ANC Source", arizona_output_anc_src[5]),
+	SOC_DAPM_ENUM("SPKOUTL ANC Source", arizona_output_anc_src[6]),
+	SOC_DAPM_ENUM("SPKOUTR ANC Source", arizona_output_anc_src[7]),
+	SOC_DAPM_ENUM("SPKDAT1L ANC Source", arizona_output_anc_src[8]),
+	SOC_DAPM_ENUM("SPKDAT1R ANC Source", arizona_output_anc_src[9]),
+	SOC_DAPM_ENUM("SPKDAT2L ANC Source", arizona_output_anc_src[10]),
+	SOC_DAPM_ENUM("SPKDAT2R ANC Source", arizona_output_anc_src[11]),
+};
+
 static const struct snd_soc_dapm_widget wm5110_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
 		    0, wm5110_sysclk_ev, SND_SOC_DAPM_POST_PMU),
@@ -1185,6 +1246,65 @@ SND_SOC_DAPM_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
 		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
 		       &wm5110_aec_loopback_mux),
 
+SND_SOC_DAPM_SUPPLY("RXANC NG External Clock", SND_SOC_NOPM,
+		   ARIZONA_EXT_NG_SEL_SET_SHIFT, 0, arizona_anc_ev,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA("RXANCL NG External", SND_SOC_NOPM, 0, 0, NULL, 0),
+SND_SOC_DAPM_PGA("RXANCR NG External", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+SND_SOC_DAPM_SUPPLY("RXANC NG Clock", SND_SOC_NOPM,
+		   ARIZONA_CLK_NG_ENA_SET_SHIFT, 0, arizona_anc_ev,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA("RXANCL NG Internal", SND_SOC_NOPM, 0, 0, NULL, 0),
+SND_SOC_DAPM_PGA("RXANCR NG Internal", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+SND_SOC_DAPM_MUX("RXANCL Left Input", SND_SOC_NOPM, 0, 0,
+		 &wm5110_anc_input_mux[0]),
+SND_SOC_DAPM_MUX("RXANCL Right Input", SND_SOC_NOPM, 0, 0,
+		 &wm5110_anc_input_mux[0]),
+SND_SOC_DAPM_MUX("RXANCL Channel", SND_SOC_NOPM, 0, 0,
+		 &wm5110_anc_input_mux[1]),
+SND_SOC_DAPM_MUX("RXANCL NG Mux", SND_SOC_NOPM, 0, 0, &wm5110_anc_ng_mux),
+SND_SOC_DAPM_MUX("RXANCR Left Input", SND_SOC_NOPM, 0, 0,
+		 &wm5110_anc_input_mux[2]),
+SND_SOC_DAPM_MUX("RXANCR Right Input", SND_SOC_NOPM, 0, 0,
+		 &wm5110_anc_input_mux[2]),
+SND_SOC_DAPM_MUX("RXANCR Channel", SND_SOC_NOPM, 0, 0,
+		 &wm5110_anc_input_mux[3]),
+SND_SOC_DAPM_MUX("RXANCR NG Mux", SND_SOC_NOPM, 0, 0, &wm5110_anc_ng_mux),
+
+SND_SOC_DAPM_PGA_E("RXANCL", SND_SOC_NOPM, ARIZONA_CLK_L_ENA_SET_SHIFT,
+		   0, NULL, 0, arizona_anc_ev,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_E("RXANCR", SND_SOC_NOPM, ARIZONA_CLK_R_ENA_SET_SHIFT,
+		   0, NULL, 0, arizona_anc_ev,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
+SND_SOC_DAPM_MUX("HPOUT1L ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[0]),
+SND_SOC_DAPM_MUX("HPOUT1R ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[1]),
+SND_SOC_DAPM_MUX("HPOUT2L ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[2]),
+SND_SOC_DAPM_MUX("HPOUT2R ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[3]),
+SND_SOC_DAPM_MUX("HPOUT3L ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[4]),
+SND_SOC_DAPM_MUX("HPOUT3R ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[5]),
+SND_SOC_DAPM_MUX("SPKOUTL ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[6]),
+SND_SOC_DAPM_MUX("SPKOUTR ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[7]),
+SND_SOC_DAPM_MUX("SPKDAT1L ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[8]),
+SND_SOC_DAPM_MUX("SPKDAT1R ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[9]),
+SND_SOC_DAPM_MUX("SPKDAT2L ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[10]),
+SND_SOC_DAPM_MUX("SPKDAT2R ANC Source", SND_SOC_NOPM, 0, 0,
+		 &wm5110_output_anc_src[11]),
+
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", NULL, 0,
 		     ARIZONA_AIF1_TX_ENABLES, ARIZONA_AIF1TX1_ENA_SHIFT, 0),
 SND_SOC_DAPM_AIF_OUT("AIF1TX2", NULL, 0,
@@ -1838,6 +1958,22 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "SPKDAT2L", NULL, "OUT6L" },
 	{ "SPKDAT2R", NULL, "OUT6R" },
 
+	WM5110_RXANC_INPUT_ROUTES("RXANCL", "RXANCL"),
+	WM5110_RXANC_INPUT_ROUTES("RXANCR", "RXANCR"),
+
+	WM5110_RXANC_OUTPUT_ROUTES("OUT1L", "HPOUT1L"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT1R", "HPOUT1R"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT2L", "HPOUT2L"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT2R", "HPOUT2R"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT3L", "HPOUT3L"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT3R", "HPOUT3R"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT4L", "SPKOUTL"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT4R", "SPKOUTR"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT5L", "SPKDAT1L"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT5R", "SPKDAT1R"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT6L", "SPKDAT2L"),
+	WM5110_RXANC_OUTPUT_ROUTES("OUT6R", "SPKDAT2R"),
+
 	{ "MICSUPP", NULL, "SYSCLK" },
 
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
-- 
1.7.2.5
