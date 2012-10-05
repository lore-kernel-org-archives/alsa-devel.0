From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: wm2200: Implement AEC loopback
	support
Date: Fri,  5 Oct 2012 19:55:31 +0100
Message-ID: <1349463336-10871-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1B762650CB
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 20:55:42 +0200 (CEST)
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
 sound/soc/codecs/wm2200.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 6ca9bcc..367d1e5 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -880,7 +880,7 @@ static DECLARE_TLV_DB_SCALE(out_tlv, -6400, 100, 0);
 static const char *wm2200_mixer_texts[] = {
 	"None",
 	"Tone Generator",
-	"AEC loopback",
+	"AEC Loopback",
 	"IN1L",
 	"IN1R",
 	"IN2L",
@@ -1066,6 +1066,7 @@ WM2200_MIXER_ENUMS(LHPF2, WM2200_LHPF2MIX_INPUT_1_SOURCE);
 
 #define WM2200_MIXER_INPUT_ROUTES(name)	\
 	{ name, "Tone Generator", "Tone Generator" }, \
+	{ name, "AEC Loopback", "AEC Loopback" }, \
         { name, "IN1L", "IN1L PGA" }, \
         { name, "IN1R", "IN1R PGA" }, \
         { name, "IN2L", "IN2L PGA" }, \
@@ -1106,6 +1107,20 @@ WM2200_MIXER_ENUMS(LHPF2, WM2200_LHPF2MIX_INPUT_1_SOURCE);
 	WM2200_MIXER_INPUT_ROUTES(name " Input 3"), \
 	WM2200_MIXER_INPUT_ROUTES(name " Input 4")
 
+
+static const char *wm2200_aec_loopback_texts[] = {
+	"OUT1L", "OUT1R", "OUT2L", "OUT2R",
+};
+
+static const struct soc_enum wm2200_aec_loopback =
+	SOC_ENUM_SINGLE(WM2200_DAC_AEC_CONTROL_1,
+			WM2200_AEC_LOOPBACK_SRC_SHIFT,
+			ARRAY_SIZE(wm2200_aec_loopback_texts),
+			wm2200_aec_loopback_texts);
+
+static const struct snd_kcontrol_new wm2200_aec_loopback_mux =
+	SOC_DAPM_ENUM("AEC Loopback", wm2200_aec_loopback);
+
 static const struct snd_soc_dapm_widget wm2200_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", WM2200_CLOCKING_3, WM2200_SYSCLK_ENA_SHIFT, 0,
 		    NULL, 0),
@@ -1181,6 +1196,9 @@ SND_SOC_DAPM_AIF_OUT("AIF1TX5", "Capture", 4,
 SND_SOC_DAPM_AIF_OUT("AIF1TX6", "Capture", 5,
 		    WM2200_AUDIO_IF_1_22, WM2200_AIF1TX6_ENA_SHIFT, 0),
 
+SND_SOC_DAPM_MUX("AEC Loopback", WM2200_DAC_AEC_CONTROL_1,
+		 WM2200_AEC_LOOPBACK_ENA_SHIFT, 0, &wm2200_aec_loopback_mux),
+
 SND_SOC_DAPM_PGA_S("OUT1L", 0, WM2200_OUTPUT_ENABLES,
 		   WM2200_OUT1L_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("OUT1R", 0, WM2200_OUTPUT_ENABLES,
@@ -1326,6 +1344,11 @@ static const struct snd_soc_dapm_route wm2200_dapm_routes[] = {
 	{ "SPK", NULL, "OUT2L" },
 	{ "SPK", NULL, "OUT2R" },
 
+	{ "AEC Loopback", "OUT1L", "OUT1L" },
+	{ "AEC Loopback", "OUT1R", "OUT1R" },
+	{ "AEC Loopback", "OUT2L", "OUT2L" },
+	{ "AEC Loopback", "OUT2R", "OUT2R" },
+
 	WM2200_MIXER_ROUTES("DSP1", "DSP1L"),
 	WM2200_MIXER_ROUTES("DSP1", "DSP1R"),
 	WM2200_MIXER_ROUTES("DSP2", "DSP2L"),
-- 
1.7.10.4
