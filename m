From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 7/8] ASoC: wcd9335: add audio routings
Date: Thu, 10 Jan 2019 15:06:15 +0000
Message-ID: <20190110150616.2332-8-srinivas.kandagatla@linaro.org>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds audio routing for both playback and capture.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 189 +++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 3c9a5158997d..4e39be04f701 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -100,6 +100,67 @@
 /* vout step value */
 #define WCD9335_CALCULATE_VOUT_D(req_mv) (((req_mv - 650) * 10) / 25)
 
+#define WCD9335_INTERPOLATOR_PATH(id)			\
+	{"RX INT" #id "_1 MIX1 INP0", "RX0", "SLIM RX0"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX1", "SLIM RX1"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX2", "SLIM RX2"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX3", "SLIM RX3"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX4", "SLIM RX4"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX5", "SLIM RX5"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX6", "SLIM RX6"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX7", "SLIM RX7"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX0", "SLIM RX0"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX1", "SLIM RX1"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX2", "SLIM RX2"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX3", "SLIM RX3"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX4", "SLIM RX4"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX5", "SLIM RX5"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX6", "SLIM RX6"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX7", "SLIM RX7"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX0", "SLIM RX0"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX1", "SLIM RX1"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX2", "SLIM RX2"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX3", "SLIM RX3"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX4", "SLIM RX4"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX5", "SLIM RX5"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX6", "SLIM RX6"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX7", "SLIM RX7"},	\
+	{"RX INT" #id "_2 MUX", "RX0", "SLIM RX0"},	\
+	{"RX INT" #id "_2 MUX", "RX1", "SLIM RX1"},	\
+	{"RX INT" #id "_2 MUX", "RX2", "SLIM RX2"},	\
+	{"RX INT" #id "_2 MUX", "RX3", "SLIM RX3"},	\
+	{"RX INT" #id "_2 MUX", "RX4", "SLIM RX4"},	\
+	{"RX INT" #id "_2 MUX", "RX5", "SLIM RX5"},	\
+	{"RX INT" #id "_2 MUX", "RX6", "SLIM RX6"},	\
+	{"RX INT" #id "_2 MUX", "RX7", "SLIM RX7"},	\
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP0"},	\
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP1"},	\
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP2"},	\
+	{"RX INT" #id " SEC MIX", NULL, "RX INT" #id "_2 MUX"},		\
+	{"RX INT" #id " SEC MIX", NULL, "RX INT" #id "_1 MIX1"},	\
+	{"RX INT" #id " MIX2", NULL, "RX INT" #id " SEC MIX"},		\
+	{"RX INT" #id " INTERP", NULL, "RX INT" #id " MIX2"}
+
+#define WCD9335_ADC_MUX_PATH(id)			\
+	{"AIF1_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id " MUX"}, \
+	{"AIF2_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id " MUX"}, \
+	{"AIF3_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id " MUX"}, \
+	{"SLIM TX" #id " MUX", "DEC" #id, "ADC MUX" #id}, \
+	{"ADC MUX" #id, "DMIC", "DMIC MUX" #id},	\
+	{"ADC MUX" #id, "AMIC", "AMIC MUX" #id},	\
+	{"DMIC MUX" #id, "DMIC0", "DMIC0"},		\
+	{"DMIC MUX" #id, "DMIC1", "DMIC1"},		\
+	{"DMIC MUX" #id, "DMIC2", "DMIC2"},		\
+	{"DMIC MUX" #id, "DMIC3", "DMIC3"},		\
+	{"DMIC MUX" #id, "DMIC4", "DMIC4"},		\
+	{"DMIC MUX" #id, "DMIC5", "DMIC5"},		\
+	{"AMIC MUX" #id, "ADC1", "ADC1"},		\
+	{"AMIC MUX" #id, "ADC2", "ADC2"},		\
+	{"AMIC MUX" #id, "ADC3", "ADC3"},		\
+	{"AMIC MUX" #id, "ADC4", "ADC4"},		\
+	{"AMIC MUX" #id, "ADC5", "ADC5"},		\
+	{"AMIC MUX" #id, "ADC6", "ADC6"}
+
 enum {
 	WCD9335_RX0 = 0,
 	WCD9335_RX1,
@@ -2352,6 +2413,132 @@ static const struct snd_kcontrol_new wcd9335_snd_controls[] = {
 	SOC_ENUM("TX8 HPF cut off", cf_dec8_enum),
 };
 
+static const struct snd_soc_dapm_route wcd9335_audio_map[] = {
+	{"SLIM RX0 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX1 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX2 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX3 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX4 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX5 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX6 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX7 MUX", "AIF1_PB", "AIF1 PB"},
+
+	{"SLIM RX0 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX1 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX2 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX3 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX4 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX5 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX6 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX7 MUX", "AIF2_PB", "AIF2 PB"},
+
+	{"SLIM RX0 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX1 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX2 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX3 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX4 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX5 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX6 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX7 MUX", "AIF3_PB", "AIF3 PB"},
+
+	{"SLIM RX0 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX1 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX2 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX3 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX4 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX5 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX6 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX7 MUX", "AIF4_PB", "AIF4 PB"},
+
+	{"SLIM RX0", NULL, "SLIM RX0 MUX"},
+	{"SLIM RX1", NULL, "SLIM RX1 MUX"},
+	{"SLIM RX2", NULL, "SLIM RX2 MUX"},
+	{"SLIM RX3", NULL, "SLIM RX3 MUX"},
+	{"SLIM RX4", NULL, "SLIM RX4 MUX"},
+	{"SLIM RX5", NULL, "SLIM RX5 MUX"},
+	{"SLIM RX6", NULL, "SLIM RX6 MUX"},
+	{"SLIM RX7", NULL, "SLIM RX7 MUX"},
+
+	WCD9335_INTERPOLATOR_PATH(0),
+	WCD9335_INTERPOLATOR_PATH(1),
+	WCD9335_INTERPOLATOR_PATH(2),
+	WCD9335_INTERPOLATOR_PATH(3),
+	WCD9335_INTERPOLATOR_PATH(4),
+	WCD9335_INTERPOLATOR_PATH(5),
+	WCD9335_INTERPOLATOR_PATH(6),
+	WCD9335_INTERPOLATOR_PATH(7),
+	WCD9335_INTERPOLATOR_PATH(8),
+
+	/* EAR PA */
+	{"RX INT0 DEM MUX", "CLSH_DSM_OUT", "RX INT0 INTERP"},
+	{"RX INT0 DAC", NULL, "RX INT0 DEM MUX"},
+	{"RX INT0 DAC", NULL, "RX_BIAS"},
+	{"EAR PA", NULL, "RX INT0 DAC"},
+	{"EAR", NULL, "EAR PA"},
+
+	/* HPHL */
+	{"RX INT1 DEM MUX", "CLSH_DSM_OUT", "RX INT1 INTERP"},
+	{"RX INT1 DAC", NULL, "RX INT1 DEM MUX"},
+	{"RX INT1 DAC", NULL, "RX_BIAS"},
+	{"HPHL PA", NULL, "RX INT1 DAC"},
+	{"HPHL", NULL, "HPHL PA"},
+
+	/* HPHR */
+	{"RX INT2 DEM MUX", "CLSH_DSM_OUT", "RX INT2 INTERP"},
+	{"RX INT2 DAC", NULL, "RX INT2 DEM MUX"},
+	{"RX INT2 DAC", NULL, "RX_BIAS"},
+	{"HPHR PA", NULL, "RX INT2 DAC"},
+	{"HPHR", NULL, "HPHR PA"},
+
+	/* LINEOUT1 */
+	{"RX INT3 DAC", NULL, "RX INT3 INTERP"},
+	{"RX INT3 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT1 PA", NULL, "RX INT3 DAC"},
+	{"LINEOUT1", NULL, "LINEOUT1 PA"},
+
+	/* LINEOUT2 */
+	{"RX INT4 DAC", NULL, "RX INT4 INTERP"},
+	{"RX INT4 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT2 PA", NULL, "RX INT4 DAC"},
+	{"LINEOUT2", NULL, "LINEOUT2 PA"},
+
+	/* LINEOUT3 */
+	{"RX INT5 DAC", NULL, "RX INT5 INTERP"},
+	{"RX INT5 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT3 PA", NULL, "RX INT5 DAC"},
+	{"LINEOUT3", NULL, "LINEOUT3 PA"},
+
+	/* LINEOUT4 */
+	{"RX INT6 DAC", NULL, "RX INT6 INTERP"},
+	{"RX INT6 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT4 PA", NULL, "RX INT6 DAC"},
+	{"LINEOUT4", NULL, "LINEOUT4 PA"},
+
+	/* SLIMBUS Connections */
+	{"AIF1 CAP", NULL, "AIF1_CAP Mixer"},
+	{"AIF2 CAP", NULL, "AIF2_CAP Mixer"},
+	{"AIF3 CAP", NULL, "AIF3_CAP Mixer"},
+
+	/* ADC Mux */
+	WCD9335_ADC_MUX_PATH(0),
+	WCD9335_ADC_MUX_PATH(1),
+	WCD9335_ADC_MUX_PATH(2),
+	WCD9335_ADC_MUX_PATH(3),
+	WCD9335_ADC_MUX_PATH(4),
+	WCD9335_ADC_MUX_PATH(5),
+	WCD9335_ADC_MUX_PATH(6),
+	WCD9335_ADC_MUX_PATH(7),
+	WCD9335_ADC_MUX_PATH(8),
+
+	/* ADC Connections */
+	{"ADC1", NULL, "AMIC1"},
+	{"ADC2", NULL, "AMIC2"},
+	{"ADC3", NULL, "AMIC3"},
+	{"ADC4", NULL, "AMIC4"},
+	{"ADC5", NULL, "AMIC5"},
+	{"ADC6", NULL, "AMIC6"},
+};
+
 static int wcd9335_micbias_control(struct snd_soc_component *component,
 				   int micb_num, int req, bool is_dapm)
 {
@@ -4756,6 +4943,8 @@ static const struct snd_soc_component_driver wcd9335_component_drv = {
 	.num_controls = ARRAY_SIZE(wcd9335_snd_controls),
 	.dapm_widgets = wcd9335_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd9335_dapm_widgets),
+	.dapm_routes = wcd9335_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd9335_audio_map),
 };
 
 static int wcd9335_probe(struct wcd9335_codec *wcd)
-- 
2.20.1
