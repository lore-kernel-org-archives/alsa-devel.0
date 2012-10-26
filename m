From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm5102: Hook up DSP1
Date: Fri, 26 Oct 2012 19:36:34 +0100
Message-ID: <1351276594-30453-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1351276594-30453-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDCEC265B76
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 20:36:37 +0200 (CEST)
In-Reply-To: <1351276594-30453-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/Kconfig  |    2 ++
 sound/soc/codecs/wm5102.c |   38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 91cbbe0..c5c01bd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -150,7 +150,9 @@ config SND_SOC_WM_HUBS
 config SND_SOC_WM_ADSP
 	tristate
 	default y if SND_SOC_WM2200=y
+	default y if SND_SOC_WM5102=y
 	default m if SND_SOC_WM2200=m
+	default y if SND_SOC_WM5102=m
 
 config SND_SOC_AB8500_CODEC
 	tristate
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 94d9d7a..de40204 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -31,6 +31,7 @@
 
 #include "arizona.h"
 #include "wm5102.h"
+#include "wm_adsp.h"
 
 struct wm5102_priv {
 	struct arizona_priv core;
@@ -561,6 +562,13 @@ static const struct reg_default wm5102_sysclk_reva_patch[] = {
 	{ 0x025e, 0x0112 },
 };
 
+static const struct wm_adsp_region wm5102_dsp1_regions[] = {
+	{ .type = WMFW_ADSP2_PM, .base = 0x100000 },
+	{ .type = WMFW_ADSP2_ZM, .base = 0x180000 },
+	{ .type = WMFW_ADSP2_XM, .base = 0x190000 },
+	{ .type = WMFW_ADSP2_YM, .base = 0x1a0000 },
+};
+
 static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
@@ -687,6 +695,9 @@ ARIZONA_MIXER_CONTROLS("LHPF2", ARIZONA_HPLP2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF3", ARIZONA_HPLP3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF4", ARIZONA_HPLP4MIX_INPUT_1_SOURCE),
 
+ARIZONA_MIXER_CONTROLS("DSP1L", ARIZONA_DSP1LMIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("DSP1R", ARIZONA_DSP1RMIX_INPUT_1_SOURCE),
+
 SOC_ENUM("LHPF1 Mode", arizona_lhpf1_mode),
 SOC_ENUM("LHPF2 Mode", arizona_lhpf2_mode),
 SOC_ENUM("LHPF3 Mode", arizona_lhpf3_mode),
@@ -824,6 +835,10 @@ ARIZONA_MIXER_ENUMS(ASRC1R, ARIZONA_ASRC1RMIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(ASRC2L, ARIZONA_ASRC2LMIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(ASRC2R, ARIZONA_ASRC2RMIX_INPUT_1_SOURCE);
 
+ARIZONA_MIXER_ENUMS(DSP1L, ARIZONA_DSP1LMIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(DSP1R, ARIZONA_DSP1RMIX_INPUT_1_SOURCE);
+
+ARIZONA_DSP_AUX_ENUMS(DSP1, ARIZONA_DSP1AUX1MIX_INPUT_1_SOURCE);
 
 static const char *wm5102_aec_loopback_texts[] = {
 	"HPOUT1L", "HPOUT1R", "HPOUT2L", "HPOUT2R", "EPOUT",
@@ -996,6 +1011,8 @@ SND_SOC_DAPM_AIF_IN("AIF3RX1", NULL, 0,
 SND_SOC_DAPM_AIF_IN("AIF3RX2", NULL, 0,
 		    ARIZONA_AIF3_RX_ENABLES, ARIZONA_AIF3RX2_ENA_SHIFT, 0),
 
+WM_ADSP2("DSP1", ARIZONA_DSP1_CONTROL_1),
+
 SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
 		       ARIZONA_AEC_LOOPBACK_ENA, 0, &wm5102_aec_loopback_mux),
 
@@ -1076,6 +1093,8 @@ ARIZONA_MIXER_WIDGETS(ASRC1R, "ASRC1R"),
 ARIZONA_MIXER_WIDGETS(ASRC2L, "ASRC2L"),
 ARIZONA_MIXER_WIDGETS(ASRC2R, "ASRC2R"),
 
+WM_ADSP2("DSP1", 0),
+
 SND_SOC_DAPM_OUTPUT("HPOUT1L"),
 SND_SOC_DAPM_OUTPUT("HPOUT1R"),
 SND_SOC_DAPM_OUTPUT("HPOUT2L"),
@@ -1127,7 +1146,13 @@ SND_SOC_DAPM_OUTPUT("SPKDAT1R"),
 	{ name, "ASRC1L", "ASRC1L" }, \
 	{ name, "ASRC1R", "ASRC1R" }, \
 	{ name, "ASRC2L", "ASRC2L" }, \
-	{ name, "ASRC2R", "ASRC2R" }
+	{ name, "ASRC2R", "ASRC2R" }, \
+	{ name, "DSP1.1", "DSP1" }, \
+	{ name, "DSP1.2", "DSP1" }, \
+	{ name, "DSP1.3", "DSP1" }, \
+	{ name, "DSP1.4", "DSP1" }, \
+	{ name, "DSP1.5", "DSP1" }, \
+	{ name, "DSP1.6", "DSP1" }
 
 static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "AIF2 Capture", NULL, "DBVDD2" },
@@ -1260,6 +1285,8 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	ARIZONA_MIXER_ROUTES("ASRC2L", "ASRC2L"),
 	ARIZONA_MIXER_ROUTES("ASRC2R", "ASRC2R"),
 
+	ARIZONA_DSP_ROUTES("DSP1"),
+
 	{ "AEC Loopback", "HPOUT1L", "OUT1L" },
 	{ "AEC Loopback", "HPOUT1R", "OUT1R" },
 	{ "HPOUT1L", NULL, "OUT1L" },
@@ -1434,6 +1461,15 @@ static int __devinit wm5102_probe(struct platform_device *pdev)
 
 	wm5102->core.arizona = arizona;
 
+	wm5102->core.adsp[0].part = "wm5102";
+	wm5102->core.adsp[0].num = 1;
+	wm5102->core.adsp[0].type = WMFW_ADSP2;
+	wm5102->core.adsp[0].base = ARIZONA_DSP1_CONTROL_1;
+	wm5102->core.adsp[0].dev = arizona->dev;
+	wm5102->core.adsp[0].regmap = arizona->regmap;
+	wm5102->core.adsp[0].mem = wm5102_dsp1_regions;
+	wm5102->core.adsp[0].num_mems = ARRAY_SIZE(wm5102_dsp1_regions);
+
 	for (i = 0; i < ARRAY_SIZE(wm5102->fll); i++)
 		wm5102->fll[i].vco_mult = 1;
 
-- 
1.7.10.4
