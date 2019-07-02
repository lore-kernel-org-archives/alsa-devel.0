From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] ASoC: wcd934x: add audio routings
Date: Tue,  2 Jul 2019 09:09:20 +0100
Message-ID: <20190702080920.22623-7-srinivas.kandagatla@linaro.org>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 218DDF800F3
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 10:10:38 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id v14so16644566wrr.4
 for <alsa-devel@alsa-project.org>; Tue, 02 Jul 2019 01:10:38 -0700 (PDT)
In-Reply-To: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, srini@kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds audio routing for both playback and capture.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 327 +++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 285e816b5f8c..0e47a63c1300 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -158,6 +158,161 @@
 	} \
 }
 
+#define WCD934X_INTERPOLATOR_PATH(id)			\
+	{"RX INT" #id "_1 MIX1 INP0", "RX0", "CDC_IF RX0 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX1", "CDC_IF RX1 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX2", "CDC_IF RX2 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX3", "CDC_IF RX3 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX4", "CDC_IF RX4 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX5", "CDC_IF RX5 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX6", "CDC_IF RX6 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX7", "CDC_IF RX7 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "IIR0", "IIR0"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "IIR1", "IIR1"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX0", "CDC_IF RX0 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX1", "CDC_IF RX1 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX2", "CDC_IF RX2 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX3", "CDC_IF RX3 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX4", "CDC_IF RX4 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX5", "CDC_IF RX5 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX6", "CDC_IF RX6 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX7", "CDC_IF RX7 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "IIR0", "IIR0"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "IIR1", "IIR1"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX0", "CDC_IF RX0 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX1", "CDC_IF RX1 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX2", "CDC_IF RX2 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX3", "CDC_IF RX3 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX4", "CDC_IF RX4 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX5", "CDC_IF RX5 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX6", "CDC_IF RX6 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX7", "CDC_IF RX7 MUX"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "IIR0", "IIR0"},		\
+	{"RX INT" #id "_1 MIX1 INP2", "IIR1", "IIR1"},		\
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP0"}, \
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP1"}, \
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP2"}, \
+	{"RX INT" #id "_2 MUX", "RX0", "CDC_IF RX0 MUX"},	\
+	{"RX INT" #id "_2 MUX", "RX1", "CDC_IF RX1 MUX"},	\
+	{"RX INT" #id "_2 MUX", "RX2", "CDC_IF RX2 MUX"},	\
+	{"RX INT" #id "_2 MUX", "RX3", "CDC_IF RX3 MUX"},	\
+	{"RX INT" #id "_2 MUX", "RX4", "CDC_IF RX4 MUX"},	\
+	{"RX INT" #id "_2 MUX", "RX5", "CDC_IF RX5 MUX"},	\
+	{"RX INT" #id "_2 MUX", "RX6", "CDC_IF RX6 MUX"},	\
+	{"RX INT" #id "_2 MUX", "RX7", "CDC_IF RX7 MUX"},	\
+	{"RX INT" #id "_2 INTERP", NULL, "RX INT" #id "_2 MUX"},	\
+	{"RX INT" #id " SEC MIX", NULL, "RX INT" #id "_2 INTERP"},	\
+	{"RX INT" #id "_1 INTERP", NULL, "RX INT" #id "_1 MIX1"},	\
+	{"RX INT" #id " SEC MIX", NULL, "RX INT" #id "_1 INTERP"},	\
+	{"RX INT" #id " MIX2", NULL, "RX INT" #id " SEC MIX"},	\
+	{"RX INT" #id " MIX2", NULL, "RX INT" #id " MIX2 INP"}
+
+#define WCD934X_SLIM_RX_AIF_PATH(id)	\
+	{"SLIM RX" #id " MUX", "AIF1_PB", "AIF1 PB"},	\
+	{"SLIM RX" #id " MUX", "AIF2_PB", "AIF2 PB"},	\
+	{"SLIM RX" #id " MUX", "AIF3_PB", "AIF3 PB"},	\
+	{"SLIM RX" #id " MUX", "AIF4_PB", "AIF4 PB"},	\
+	{"SLIM RX" #id, NULL, "SLIM RX" #id " MUX"},	\
+	{"CDC_IF RX" #id " MUX", "SLIM RX" #id, "SLIM RX" #id}
+
+#define WCD934X_ADC_MUX(id) \
+	{"ADC MUX" #id, "DMIC", "DMIC MUX" #id },	\
+	{"ADC MUX" #id, "AMIC", "AMIC MUX" #id },	\
+	{"DMIC MUX" #id, "DMIC0", "DMIC0"},		\
+	{"DMIC MUX" #id, "DMIC1", "DMIC1"},		\
+	{"DMIC MUX" #id, "DMIC2", "DMIC2"},		\
+	{"DMIC MUX" #id, "DMIC3", "DMIC3"},		\
+	{"DMIC MUX" #id, "DMIC4", "DMIC4"},		\
+	{"DMIC MUX" #id, "DMIC5", "DMIC5"},		\
+	{"AMIC MUX" #id, "ADC1", "ADC1"},		\
+	{"AMIC MUX" #id, "ADC2", "ADC2"},		\
+	{"AMIC MUX" #id, "ADC3", "ADC3"},		\
+	{"AMIC MUX" #id, "ADC4", "ADC4"}
+
+	/*
+	 * SRC0, SRC1 inputs to Sidetone RX Mixer
+	 * on RX0, RX1, RX2, RX3, RX4 and RX7 chains
+	 */
+#define WCD934X_IIR_INP_MUX(id) \
+	{"IIR" #id, NULL, "IIR" #id " INP0 MUX"},	\
+	{"IIR" #id " INP0 MUX", "DEC0", "ADC MUX0"},	\
+	{"IIR" #id " INP0 MUX", "DEC1", "ADC MUX1"},	\
+	{"IIR" #id " INP0 MUX", "DEC2", "ADC MUX2"},	\
+	{"IIR" #id " INP0 MUX", "DEC3", "ADC MUX3"},	\
+	{"IIR" #id " INP0 MUX", "DEC4", "ADC MUX4"},	\
+	{"IIR" #id " INP0 MUX", "DEC5", "ADC MUX5"},	\
+	{"IIR" #id " INP0 MUX", "DEC6", "ADC MUX6"},	\
+	{"IIR" #id " INP0 MUX", "DEC7", "ADC MUX7"},	\
+	{"IIR" #id " INP0 MUX", "DEC8", "ADC MUX8"},	\
+	{"IIR" #id " INP0 MUX", "RX0", "CDC_IF RX0 MUX"},	\
+	{"IIR" #id " INP0 MUX", "RX1", "CDC_IF RX1 MUX"},	\
+	{"IIR" #id " INP0 MUX", "RX2", "CDC_IF RX2 MUX"},	\
+	{"IIR" #id " INP0 MUX", "RX3", "CDC_IF RX3 MUX"},	\
+	{"IIR" #id " INP0 MUX", "RX4", "CDC_IF RX4 MUX"},	\
+	{"IIR" #id " INP0 MUX", "RX5", "CDC_IF RX5 MUX"},	\
+	{"IIR" #id " INP0 MUX", "RX6", "CDC_IF RX6 MUX"},	\
+	{"IIR" #id " INP0 MUX", "RX7", "CDC_IF RX7 MUX"},	\
+	{"IIR" #id, NULL, "IIR" #id " INP1 MUX"},	\
+	{"IIR" #id " INP1 MUX", "DEC0", "ADC MUX0"},	\
+	{"IIR" #id " INP1 MUX", "DEC1", "ADC MUX1"},	\
+	{"IIR" #id " INP1 MUX", "DEC2", "ADC MUX2"},	\
+	{"IIR" #id " INP1 MUX", "DEC3", "ADC MUX3"},	\
+	{"IIR" #id " INP1 MUX", "DEC4", "ADC MUX4"},	\
+	{"IIR" #id " INP1 MUX", "DEC5", "ADC MUX5"},	\
+	{"IIR" #id " INP1 MUX", "DEC6", "ADC MUX6"},	\
+	{"IIR" #id " INP1 MUX", "DEC7", "ADC MUX7"},	\
+	{"IIR" #id " INP1 MUX", "DEC8", "ADC MUX8"},	\
+	{"IIR" #id " INP1 MUX", "RX0", "CDC_IF RX0 MUX"},	\
+	{"IIR" #id " INP1 MUX", "RX1", "CDC_IF RX1 MUX"},	\
+	{"IIR" #id " INP1 MUX", "RX2", "CDC_IF RX2 MUX"},	\
+	{"IIR" #id " INP1 MUX", "RX3", "CDC_IF RX3 MUX"},	\
+	{"IIR" #id " INP1 MUX", "RX4", "CDC_IF RX4 MUX"},	\
+	{"IIR" #id " INP1 MUX", "RX5", "CDC_IF RX5 MUX"},	\
+	{"IIR" #id " INP1 MUX", "RX6", "CDC_IF RX6 MUX"},	\
+	{"IIR" #id " INP1 MUX", "RX7", "CDC_IF RX7 MUX"},	\
+	{"IIR" #id, NULL, "IIR" #id " INP2 MUX"},	\
+	{"IIR" #id " INP2 MUX", "DEC0", "ADC MUX0"},	\
+	{"IIR" #id " INP2 MUX", "DEC1", "ADC MUX1"},	\
+	{"IIR" #id " INP2 MUX", "DEC2", "ADC MUX2"},	\
+	{"IIR" #id " INP2 MUX", "DEC3", "ADC MUX3"},	\
+	{"IIR" #id " INP2 MUX", "DEC4", "ADC MUX4"},	\
+	{"IIR" #id " INP2 MUX", "DEC5", "ADC MUX5"},	\
+	{"IIR" #id " INP2 MUX", "DEC6", "ADC MUX6"},	\
+	{"IIR" #id " INP2 MUX", "DEC7", "ADC MUX7"},	\
+	{"IIR" #id " INP2 MUX", "DEC8", "ADC MUX8"},	\
+	{"IIR" #id " INP2 MUX", "RX0", "CDC_IF RX0 MUX"},	\
+	{"IIR" #id " INP2 MUX", "RX1", "CDC_IF RX1 MUX"},	\
+	{"IIR" #id " INP2 MUX", "RX2", "CDC_IF RX2 MUX"},	\
+	{"IIR" #id " INP2 MUX", "RX3", "CDC_IF RX3 MUX"},	\
+	{"IIR" #id " INP2 MUX", "RX4", "CDC_IF RX4 MUX"},	\
+	{"IIR" #id " INP2 MUX", "RX5", "CDC_IF RX5 MUX"},	\
+	{"IIR" #id " INP2 MUX", "RX6", "CDC_IF RX6 MUX"},	\
+	{"IIR" #id " INP2 MUX", "RX7", "CDC_IF RX7 MUX"},	\
+	{"IIR" #id, NULL, "IIR" #id " INP3 MUX"},	\
+	{"IIR" #id " INP3 MUX", "DEC0", "ADC MUX0"},	\
+	{"IIR" #id " INP3 MUX", "DEC1", "ADC MUX1"},	\
+	{"IIR" #id " INP3 MUX", "DEC2", "ADC MUX2"},	\
+	{"IIR" #id " INP3 MUX", "DEC3", "ADC MUX3"},	\
+	{"IIR" #id " INP3 MUX", "DEC4", "ADC MUX4"},	\
+	{"IIR" #id " INP3 MUX", "DEC5", "ADC MUX5"},	\
+	{"IIR" #id " INP3 MUX", "DEC6", "ADC MUX6"},	\
+	{"IIR" #id " INP3 MUX", "DEC7", "ADC MUX7"},	\
+	{"IIR" #id " INP3 MUX", "DEC8", "ADC MUX8"},	\
+	{"IIR" #id " INP3 MUX", "RX0", "CDC_IF RX0 MUX"},	\
+	{"IIR" #id " INP3 MUX", "RX1", "CDC_IF RX1 MUX"},	\
+	{"IIR" #id " INP3 MUX", "RX2", "CDC_IF RX2 MUX"},	\
+	{"IIR" #id " INP3 MUX", "RX3", "CDC_IF RX3 MUX"},	\
+	{"IIR" #id " INP3 MUX", "RX4", "CDC_IF RX4 MUX"},	\
+	{"IIR" #id " INP3 MUX", "RX5", "CDC_IF RX5 MUX"},	\
+	{"IIR" #id " INP3 MUX", "RX6", "CDC_IF RX6 MUX"},	\
+	{"IIR" #id " INP3 MUX", "RX7", "CDC_IF RX7 MUX"}
+
+#define WCD934X_SLIM_TX_AIF_PATH(id)	\
+	{"AIF1_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id },	\
+	{"AIF2_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id },	\
+	{"AIF3_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id },	\
+	{"SLIM TX" #id, NULL, "CDC_IF TX" #id " MUX"}
+
 enum {
 	MIC_BIAS_1 = 1,
 	MIC_BIAS_2,
@@ -5280,6 +5435,176 @@ static const struct snd_soc_dapm_widget wcd934x_dapm_widgets[] = {
 			   ARRAY_SIZE(aif3_slim_cap_mixer)),
 };
 
+static const struct snd_soc_dapm_route wcd934x_audio_map[] = {
+	/* RX0-RX7 */
+	WCD934X_SLIM_RX_AIF_PATH(0),
+	WCD934X_SLIM_RX_AIF_PATH(1),
+	WCD934X_SLIM_RX_AIF_PATH(2),
+	WCD934X_SLIM_RX_AIF_PATH(3),
+	WCD934X_SLIM_RX_AIF_PATH(4),
+	WCD934X_SLIM_RX_AIF_PATH(5),
+	WCD934X_SLIM_RX_AIF_PATH(6),
+	WCD934X_SLIM_RX_AIF_PATH(7),
+
+	/* 7 Interpolators */
+	WCD934X_INTERPOLATOR_PATH(0),
+	WCD934X_INTERPOLATOR_PATH(1),
+	WCD934X_INTERPOLATOR_PATH(2),
+	WCD934X_INTERPOLATOR_PATH(3),
+	WCD934X_INTERPOLATOR_PATH(4),
+	WCD934X_INTERPOLATOR_PATH(7),
+	WCD934X_INTERPOLATOR_PATH(8),
+
+	/* RX0 Ear out */
+	{"RX INT0_1 INTERP", NULL, "RX INT0_1 MIX1"},
+	{"RX INT0 SEC MIX", NULL, "RX INT0_1 INTERP"},
+	{"RX INT0 MIX2 INP", "SRC0", "SRC0"},
+	{"RX INT0 MIX2 INP", "SRC1", "SRC1"},
+	{"RX INT0 MIX2", NULL, "RX INT0 SEC MIX"},
+	{"RX INT0 MIX2", NULL, "RX INT0 MIX2 INP"},
+	{"RX INT0 DEM MUX", "CLSH_DSM_OUT", "RX INT0 MIX2"},
+	{"RX INT0 DAC", NULL, "RX INT0 DEM MUX"},
+	{"RX INT0 DAC", NULL, "RX_BIAS"},
+	{"EAR PA", NULL, "RX INT0 DAC"},
+	{"EAR", NULL, "EAR PA"},
+
+	/* RX1 Headphone left */
+	{"RX INT1_1 INTERP", NULL, "RX INT1_1 MIX1"},
+	{"RX INT1 SEC MIX", NULL, "RX INT1_1 INTERP"},
+	{"RX INT1 MIX2 INP", "SRC0", "SRC0"},
+	{"RX INT1 MIX2 INP", "SRC1", "SRC1"},
+	{"RX INT1 MIX2", NULL, "RX INT1 SEC MIX"},
+	{"RX INT1 MIX2", NULL, "RX INT1 MIX2 INP"},
+	{"RX INT1 MIX3", NULL, "RX INT1 MIX2"},
+	{"RX INT1 DEM MUX", "CLSH_DSM_OUT", "RX INT1 MIX3"},
+	{"RX INT1 DAC", NULL, "RX INT1 DEM MUX"},
+	{"RX INT1 DAC", NULL, "RX_BIAS"},
+	{"HPHL PA", NULL, "RX INT1 DAC"},
+	{"HPHL", NULL, "HPHL PA"},
+
+	/* RX2 Headphone right */
+	{"RX INT2_1 INTERP", NULL, "RX INT2_1 MIX1"},
+	{"RX INT2 SEC MIX", NULL, "RX INT2_1 INTERP"},
+	{"RX INT2 MIX2 INP", "SRC0", "SRC0"},
+	{"RX INT2 MIX2 INP", "SRC1", "SRC1"},
+	{"RX INT2 MIX2", NULL, "RX INT2 SEC MIX"},
+	{"RX INT2 MIX2", NULL, "RX INT2 MIX2 INP"},
+	{"RX INT2 MIX3", NULL, "RX INT2 MIX2"},
+	{"RX INT2 DEM MUX", "CLSH_DSM_OUT", "RX INT2 MIX3"},
+	{"RX INT2 DAC", NULL, "RX INT2 DEM MUX"},
+	{"RX INT2 DAC", NULL, "RX_BIAS"},
+	{"HPHR PA", NULL, "RX INT2 DAC"},
+	{"HPHR", NULL, "HPHR PA"},
+
+	/* RX3 HIFi LineOut1 */
+	{"RX INT3_1 INTERP", NULL, "RX INT3_1 MIX1"},
+	{"RX INT3 SEC MIX", NULL, "RX INT3_1 INTERP"},
+	{"RX INT3 MIX2 INP", "SRC0", "SRC0"},
+	{"RX INT3 MIX2 INP", "SRC1", "SRC1"},
+	{"RX INT3 MIX2", NULL, "RX INT3 SEC MIX"},
+	{"RX INT3 MIX2", NULL, "RX INT3 MIX2 INP"},
+	{"RX INT3 MIX3", NULL, "RX INT3 MIX2"},
+	{"RX INT3 DAC", NULL, "RX INT3 MIX3"},
+	{"RX INT3 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT1 PA", NULL, "RX INT3 DAC"},
+	{"LINEOUT1", NULL, "LINEOUT1 PA"},
+
+	/* RX4 HIFi LineOut2 */
+	{"RX INT4_1 INTERP", NULL, "RX INT4_1 MIX1"},
+	{"RX INT4 SEC MIX", NULL, "RX INT4_1 INTERP"},
+	{"RX INT4 MIX2 INP", "SRC0", "SRC0"},
+	{"RX INT4 MIX2 INP", "SRC1", "SRC1"},
+	{"RX INT4 MIX2", NULL, "RX INT4 SEC MIX"},
+	{"RX INT4 MIX2", NULL, "RX INT4 MIX2 INP"},
+	{"RX INT4 SEC MIX", NULL, "RX INT4_1 MIX1"},
+	{"RX INT4 MIX3", NULL, "RX INT4 MIX2"},
+	{"RX INT4 DAC", NULL, "RX INT4 MIX3"},
+	{"RX INT4 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT2 PA", NULL, "RX INT4 DAC"},
+	{"LINEOUT2", NULL, "LINEOUT2 PA"},
+
+	/* RX7 Speaker Left Out PA */
+	{"RX INT7_1 INTERP", NULL, "RX INT7_1 MIX1"},
+	{"RX INT7 SEC MIX", NULL, "RX INT7_1 INTERP"},
+	{"RX INT7 MIX2 INP", "SRC0", "SRC0"},
+	{"RX INT7 MIX2 INP", "SRC1", "SRC1"},
+	{"RX INT7 MIX2", NULL, "RX INT7 SEC MIX"},
+	{"RX INT7 MIX2", NULL, "RX INT7 MIX2 INP"},
+	{"RX INT7 CHAIN", NULL, "RX INT7 MIX2"},
+	{"RX INT7 CHAIN", NULL, "RX_BIAS"},
+	{"SPK1 OUT", NULL, "RX INT7 CHAIN"},
+
+	/* RX8 Speaker Right Out PA */
+	{"RX INT8_1 INTERP", NULL, "RX INT8_1 MIX1"},
+	{"RX INT8 SEC MIX", NULL, "RX INT8_1 INTERP"},
+	{"RX INT8 SEC MIX", NULL, "RX INT8_1 MIX1"},
+	{"RX INT8 CHAIN", NULL, "RX INT8 SEC MIX"},
+	{"RX INT8 CHAIN", NULL, "RX_BIAS"},
+	{"SPK2 OUT", NULL, "RX INT8 CHAIN"},
+
+	/* Tx */
+	{"AIF1 CAP", NULL, "AIF1_CAP Mixer"},
+	{"AIF2 CAP", NULL, "AIF2_CAP Mixer"},
+	{"AIF3 CAP", NULL, "AIF3_CAP Mixer"},
+
+	WCD934X_SLIM_TX_AIF_PATH(0),
+	WCD934X_SLIM_TX_AIF_PATH(1),
+	WCD934X_SLIM_TX_AIF_PATH(2),
+	WCD934X_SLIM_TX_AIF_PATH(3),
+	WCD934X_SLIM_TX_AIF_PATH(4),
+	WCD934X_SLIM_TX_AIF_PATH(5),
+	WCD934X_SLIM_TX_AIF_PATH(6),
+	WCD934X_SLIM_TX_AIF_PATH(7),
+	WCD934X_SLIM_TX_AIF_PATH(8),
+
+	WCD934X_ADC_MUX(0),
+	WCD934X_ADC_MUX(1),
+	WCD934X_ADC_MUX(2),
+	WCD934X_ADC_MUX(3),
+	WCD934X_ADC_MUX(4),
+	WCD934X_ADC_MUX(5),
+	WCD934X_ADC_MUX(6),
+	WCD934X_ADC_MUX(7),
+	WCD934X_ADC_MUX(8),
+
+	{"CDC_IF TX0 MUX", "DEC0", "ADC MUX0"},
+	{"CDC_IF TX1 MUX", "DEC1", "ADC MUX1"},
+	{"CDC_IF TX2 MUX", "DEC2", "ADC MUX2"},
+	{"CDC_IF TX3 MUX", "DEC3", "ADC MUX3"},
+	{"CDC_IF TX4 MUX", "DEC4", "ADC MUX4"},
+	{"CDC_IF TX5 MUX", "DEC5", "ADC MUX5"},
+	{"CDC_IF TX6 MUX", "DEC6", "ADC MUX6"},
+	{"CDC_IF TX7 MUX", "DEC7", "ADC MUX7"},
+	{"CDC_IF TX8 MUX", "DEC8", "ADC MUX8"},
+
+	{"AMIC4_5 SEL", "AMIC4", "AMIC4"},
+	{"AMIC4_5 SEL", "AMIC5", "AMIC5"},
+
+	{ "DMIC0", NULL, "DMIC0 Pin" },
+	{ "DMIC1", NULL, "DMIC1 Pin" },
+	{ "DMIC2", NULL, "DMIC2 Pin" },
+	{ "DMIC3", NULL, "DMIC3 Pin" },
+	{ "DMIC4", NULL, "DMIC4 Pin" },
+	{ "DMIC5", NULL, "DMIC5 Pin" },
+
+	{"ADC1", NULL, "AMIC1"},
+	{"ADC2", NULL, "AMIC2"},
+	{"ADC3", NULL, "AMIC3"},
+	{"ADC4", NULL, "AMIC4_5 SEL"},
+
+	WCD934X_IIR_INP_MUX(0),
+	WCD934X_IIR_INP_MUX(1),
+
+	{"SRC0", NULL, "IIR0"},
+	{"SRC1", NULL, "IIR1"},
+
+	/* VI Feedback */
+	{"AIF4_VI Mixer", "SPKR_VI_1", "VIINPUT"},
+	{"AIF4_VI Mixer", "SPKR_VI_2", "VIINPUT"},
+	{"AIF4 VI", NULL, "AIF4_VI Mixer"},
+
+};
+
 static const struct snd_soc_component_driver wcd934x_component_drv = {
 	.probe = wcd934x_comp_probe,
 	.remove = wcd934x_comp_remove,
@@ -5288,6 +5613,8 @@ static const struct snd_soc_component_driver wcd934x_component_drv = {
 	.num_controls = ARRAY_SIZE(wcd934x_snd_controls),
 	.dapm_widgets = wcd934x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd934x_dapm_widgets),
+	.dapm_routes = wcd934x_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd934x_audio_map),
 };
 
 static int wcd934x_codec_probe(struct wcd934x_codec *wcd)
-- 
2.21.0
