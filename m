From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Add AEC routing control
Date: Thu, 16 Aug 2012 20:32:48 +0100
Message-ID: <1345145568-29283-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 135C1265FF8
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 21:11:45 +0200 (CEST)
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
 sound/soc/codecs/wm5102.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a5aea03..e2fb07e 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -274,6 +274,27 @@ ARIZONA_MIXER_ENUMS(ASRC1R, ARIZONA_ASRC1RMIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(ASRC2L, ARIZONA_ASRC2LMIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(ASRC2R, ARIZONA_ASRC2RMIX_INPUT_1_SOURCE);
 
+
+static const char *wm5102_aec_loopback_texts[] = {
+	"HPOUT1L", "HPOUT1R", "HPOUT2L", "HPOUT2R", "EPOUT",
+	"SPKOUTL", "SPKOUTR", "SPKDAT1L", "SPKDAT1R",
+};
+
+static const unsigned int wm5102_aec_loopback_values[] = {
+	0, 1, 2, 3, 4, 6, 7, 8, 9,
+};
+
+static const struct soc_enum wm5102_aec_loopback =
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_DAC_AEC_CONTROL_1,
+			      ARIZONA_AEC_LOOPBACK_SRC_SHIFT,
+			      ARIZONA_AEC_LOOPBACK_SRC_MASK,
+			      ARRAY_SIZE(wm5102_aec_loopback_texts),
+			      wm5102_aec_loopback_texts,
+			      wm5102_aec_loopback_values);
+
+static const struct snd_kcontrol_new wm5102_aec_loopback_mux =
+	SOC_DAPM_VALUE_ENUM("AEC Loopback", wm5102_aec_loopback);
+
 static const struct snd_soc_dapm_widget wm5102_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
 		    0, NULL, 0),
@@ -425,6 +446,9 @@ SND_SOC_DAPM_AIF_IN("AIF3RX1", NULL, 0,
 SND_SOC_DAPM_AIF_IN("AIF3RX2", NULL, 0,
 		    ARIZONA_AIF3_RX_ENABLES, ARIZONA_AIF3RX2_ENA_SHIFT, 0),
 
+SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
+		       ARIZONA_AEC_LOOPBACK_ENA, 0, &wm5102_aec_loopback_mux),
+
 SND_SOC_DAPM_PGA_E("OUT1L", ARIZONA_OUTPUT_ENABLES_1,
 		   ARIZONA_OUT1L_ENA_SHIFT, 0, NULL, 0, arizona_out_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
@@ -520,6 +544,7 @@ SND_SOC_DAPM_OUTPUT("SPKDAT1R"),
 	{ name, "Noise Generator", "Noise Generator" }, \
 	{ name, "Tone Generator 1", "Tone Generator 1" }, \
 	{ name, "Tone Generator 2", "Tone Generator 2" }, \
+	{ name, "AEC", "AEC Loopback" }, \
 	{ name, "IN1L", "IN1L PGA" }, \
 	{ name, "IN1R", "IN1R PGA" }, \
 	{ name, "IN2L", "IN2L PGA" }, \
@@ -685,21 +710,30 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	ARIZONA_MIXER_ROUTES("ASRC2L", "ASRC2L"),
 	ARIZONA_MIXER_ROUTES("ASRC2R", "ASRC2R"),
 
+	{ "AEC Loopback", "HPOUT1L", "OUT1L" },
+	{ "AEC Loopback", "HPOUT1R", "OUT1R" },
 	{ "HPOUT1L", NULL, "OUT1L" },
 	{ "HPOUT1R", NULL, "OUT1R" },
 
+	{ "AEC Loopback", "HPOUT2L", "OUT2L" },
+	{ "AEC Loopback", "HPOUT2R", "OUT2R" },
 	{ "HPOUT2L", NULL, "OUT2L" },
 	{ "HPOUT2R", NULL, "OUT2R" },
 
+	{ "AEC Loopback", "EPOUT", "OUT3L" },
 	{ "EPOUTN", NULL, "OUT3L" },
 	{ "EPOUTP", NULL, "OUT3L" },
 
+	{ "AEC Loopback", "SPKOUTL", "OUT4L" },
 	{ "SPKOUTLN", NULL, "OUT4L" },
 	{ "SPKOUTLP", NULL, "OUT4L" },
 
+	{ "AEC Loopback", "SPKOUTR", "OUT4R" },
 	{ "SPKOUTRN", NULL, "OUT4R" },
 	{ "SPKOUTRP", NULL, "OUT4R" },
 
+	{ "AEC Loopback", "SPKDAT1L", "OUT5L" },
+	{ "AEC Loopback", "SPKDAT1R", "OUT5R" },
 	{ "SPKDAT1L", NULL, "OUT5L" },
 	{ "SPKDAT1R", NULL, "OUT5R" },
 };
-- 
1.7.10.4
