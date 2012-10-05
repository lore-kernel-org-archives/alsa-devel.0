From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: wm2200: Fully plumb the DSPs into
	the routing map
Date: Fri,  5 Oct 2012 19:55:33 +0100
Message-ID: <1349463336-10871-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 039AD2650D0
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 20:55:43 +0200 (CEST)
In-Reply-To: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |   55 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 1eafaae..f24ef0a 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1056,6 +1056,20 @@ static int wm2200_mixer_values[] = {
 	static WM2200_MUX_CTL_DECL(name##_in3); \
 	static WM2200_MUX_CTL_DECL(name##_in4)
 
+#define WM2200_DSP_ENUMS(name, base_reg) \
+	static WM2200_MUX_ENUM_DECL(name##_aux1_enum, base_reg);     \
+	static WM2200_MUX_ENUM_DECL(name##_aux2_enum, base_reg + 1); \
+	static WM2200_MUX_ENUM_DECL(name##_aux3_enum, base_reg + 2); \
+	static WM2200_MUX_ENUM_DECL(name##_aux4_enum, base_reg + 3); \
+	static WM2200_MUX_ENUM_DECL(name##_aux5_enum, base_reg + 4); \
+	static WM2200_MUX_ENUM_DECL(name##_aux6_enum, base_reg + 5); \
+	static WM2200_MUX_CTL_DECL(name##_aux1); \
+	static WM2200_MUX_CTL_DECL(name##_aux2); \
+	static WM2200_MUX_CTL_DECL(name##_aux3); \
+	static WM2200_MUX_CTL_DECL(name##_aux4); \
+	static WM2200_MUX_CTL_DECL(name##_aux5); \
+	static WM2200_MUX_CTL_DECL(name##_aux6);
+
 static const struct snd_kcontrol_new wm2200_snd_controls[] = {
 SOC_SINGLE("IN1 High Performance Switch", WM2200_IN1L_CONTROL,
 	   WM2200_IN1_OSR_SHIFT, 1, 0),
@@ -1131,6 +1145,9 @@ WM2200_MIXER_ENUMS(DSP1R, WM2200_DSP1RMIX_INPUT_1_SOURCE);
 WM2200_MIXER_ENUMS(DSP2L, WM2200_DSP2LMIX_INPUT_1_SOURCE);
 WM2200_MIXER_ENUMS(DSP2R, WM2200_DSP2RMIX_INPUT_1_SOURCE);
 
+WM2200_DSP_ENUMS(DSP1, WM2200_DSP1AUX1MIX_INPUT_1_SOURCE);
+WM2200_DSP_ENUMS(DSP2, WM2200_DSP2AUX1MIX_INPUT_1_SOURCE);
+
 WM2200_MIXER_ENUMS(LHPF1, WM2200_LHPF1MIX_INPUT_1_SOURCE);
 WM2200_MIXER_ENUMS(LHPF2, WM2200_LHPF2MIX_INPUT_1_SOURCE);
 
@@ -1144,6 +1161,16 @@ WM2200_MIXER_ENUMS(LHPF2, WM2200_LHPF2MIX_INPUT_1_SOURCE);
 	WM2200_MUX(name_str " Input 4", &name##_in4_mux), \
 	SND_SOC_DAPM_MIXER(name_str " Mixer", SND_SOC_NOPM, 0, 0, NULL, 0)
 
+#define WM2200_DSP_WIDGETS(name, name_str) \
+	WM2200_MIXER_WIDGETS(name##L, name_str "L"), \
+	WM2200_MIXER_WIDGETS(name##R, name_str "R"), \
+	WM2200_MUX(name_str " Aux 1", &name##_aux1_mux), \
+	WM2200_MUX(name_str " Aux 2", &name##_aux2_mux), \
+	WM2200_MUX(name_str " Aux 3", &name##_aux3_mux), \
+	WM2200_MUX(name_str " Aux 4", &name##_aux4_mux), \
+	WM2200_MUX(name_str " Aux 5", &name##_aux5_mux), \
+	WM2200_MUX(name_str " Aux 6", &name##_aux6_mux)
+
 #define WM2200_MIXER_INPUT_ROUTES(name)	\
 	{ name, "Tone Generator", "Tone Generator" }, \
 	{ name, "AEC Loopback", "AEC Loopback" }, \
@@ -1187,6 +1214,19 @@ WM2200_MIXER_ENUMS(LHPF2, WM2200_LHPF2MIX_INPUT_1_SOURCE);
 	WM2200_MIXER_INPUT_ROUTES(name " Input 3"), \
 	WM2200_MIXER_INPUT_ROUTES(name " Input 4")
 
+#define WM2200_DSP_AUX_ROUTES(name) \
+	{ name, NULL, name " Aux 1" }, \
+	{ name, NULL, name " Aux 2" }, \
+	{ name, NULL, name " Aux 3" }, \
+	{ name, NULL, name " Aux 4" }, \
+	{ name, NULL, name " Aux 5" }, \
+	{ name, NULL, name " Aux 6" }, \
+	WM2200_MIXER_INPUT_ROUTES(name " Aux 1"), \
+	WM2200_MIXER_INPUT_ROUTES(name " Aux 2"), \
+	WM2200_MIXER_INPUT_ROUTES(name " Aux 3"), \
+	WM2200_MIXER_INPUT_ROUTES(name " Aux 4"), \
+	WM2200_MIXER_INPUT_ROUTES(name " Aux 5"), \
+	WM2200_MIXER_INPUT_ROUTES(name " Aux 6")
 
 static const char *wm2200_aec_loopback_texts[] = {
 	"OUT1L", "OUT1R", "OUT2L", "OUT2R",
@@ -1260,8 +1300,10 @@ SND_SOC_DAPM_PGA("LHPF1", WM2200_HPLPF1_1, WM2200_LHPF1_ENA_SHIFT, 0,
 SND_SOC_DAPM_PGA("LHPF2", WM2200_HPLPF2_1, WM2200_LHPF2_ENA_SHIFT, 0,
 		 NULL, 0),
 
-SND_SOC_DAPM_PGA_E("DSP1", SND_SOC_NOPM, 0, 0, NULL, 0, NULL, 0),
-SND_SOC_DAPM_PGA_E("DSP2", SND_SOC_NOPM, 1, 0, NULL, 0, NULL, 0),
+SND_SOC_DAPM_PGA_E("DSP1", WM2200_DSP1_CONTROL_30, WM2200_DSP1_SYS_ENA_SHIFT,
+		   0, NULL, 0, NULL, 0),
+SND_SOC_DAPM_PGA_E("DSP2", WM2200_DSP2_CONTROL_30, WM2200_DSP2_SYS_ENA_SHIFT,
+		   0, NULL, 0, NULL, 0),
 
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", "Capture", 0,
 		    WM2200_AUDIO_IF_1_22, WM2200_AIF1TX1_ENA_SHIFT, 0),
@@ -1329,10 +1371,8 @@ WM2200_MIXER_WIDGETS(EQR, "EQR"),
 WM2200_MIXER_WIDGETS(LHPF1, "LHPF1"),
 WM2200_MIXER_WIDGETS(LHPF2, "LHPF2"),
 
-WM2200_MIXER_WIDGETS(DSP1L, "DSP1L"),
-WM2200_MIXER_WIDGETS(DSP1R, "DSP1R"),
-WM2200_MIXER_WIDGETS(DSP2L, "DSP2L"),
-WM2200_MIXER_WIDGETS(DSP2R, "DSP2R"),
+WM2200_DSP_WIDGETS(DSP1, "DSP1"),
+WM2200_DSP_WIDGETS(DSP2, "DSP2"),
 
 WM2200_MIXER_WIDGETS(AIF1TX1, "AIF1TX1"),
 WM2200_MIXER_WIDGETS(AIF1TX2, "AIF1TX2"),
@@ -1434,6 +1474,9 @@ static const struct snd_soc_dapm_route wm2200_dapm_routes[] = {
 	WM2200_MIXER_ROUTES("DSP2", "DSP2L"),
 	WM2200_MIXER_ROUTES("DSP2", "DSP2R"),
 
+	WM2200_DSP_AUX_ROUTES("DSP1"),
+	WM2200_DSP_AUX_ROUTES("DSP2"),
+
 	WM2200_MIXER_ROUTES("OUT1L", "OUT1L"),
 	WM2200_MIXER_ROUTES("OUT1R", "OUT1R"),
 	WM2200_MIXER_ROUTES("OUT2L", "OUT2L"),
-- 
1.7.10.4
