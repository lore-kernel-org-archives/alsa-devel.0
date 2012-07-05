From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5102: Allow routing through the
	ASRCs
Date: Thu,  5 Jul 2012 17:32:57 +0100
Message-ID: <1341505977-10904-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1341505977-10904-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F87E2445C
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 18:33:00 +0200 (CEST)
In-Reply-To: <1341505977-10904-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This enables common telephony use cases.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index be74a78..3827fa2 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -275,6 +275,11 @@ ARIZONA_MIXER_ENUMS(AIF2TX2, ARIZONA_AIF2TX2MIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(AIF3TX1, ARIZONA_AIF3TX1MIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(AIF3TX2, ARIZONA_AIF3TX2MIX_INPUT_1_SOURCE);
 
+ARIZONA_MIXER_ENUMS(ASRC1L, ARIZONA_ASRC1LMIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(ASRC1R, ARIZONA_ASRC1RMIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(ASRC2L, ARIZONA_ASRC2LMIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(ASRC2R, ARIZONA_ASRC2RMIX_INPUT_1_SOURCE);
+
 static const struct snd_soc_dapm_widget wm5102_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
 		    0, NULL, 0),
@@ -363,6 +368,15 @@ SND_SOC_DAPM_PGA("PWM1 Driver", ARIZONA_PWM_DRIVE_1, ARIZONA_PWM1_ENA_SHIFT,
 SND_SOC_DAPM_PGA("PWM2 Driver", ARIZONA_PWM_DRIVE_1, ARIZONA_PWM2_ENA_SHIFT,
 		 0, NULL, 0),
 
+SND_SOC_DAPM_PGA("ASRC1L", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC1L_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("ASRC1R", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC1R_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("ASRC2L", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC2L_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("ASRC2R", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC2R_ENA_SHIFT, 0,
+		 NULL, 0),
+
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", NULL, 0,
 		     ARIZONA_AIF1_TX_ENABLES, ARIZONA_AIF1TX1_ENA_SHIFT, 0),
 SND_SOC_DAPM_AIF_OUT("AIF1TX2", NULL, 0,
@@ -491,6 +505,11 @@ ARIZONA_MIXER_WIDGETS(AIF2TX2, "AIF2TX2"),
 ARIZONA_MIXER_WIDGETS(AIF3TX1, "AIF3TX1"),
 ARIZONA_MIXER_WIDGETS(AIF3TX2, "AIF3TX2"),
 
+ARIZONA_MIXER_WIDGETS(ASRC1L, "ASRC1L"),
+ARIZONA_MIXER_WIDGETS(ASRC1R, "ASRC1R"),
+ARIZONA_MIXER_WIDGETS(ASRC2L, "ASRC2L"),
+ARIZONA_MIXER_WIDGETS(ASRC2R, "ASRC2R"),
+
 SND_SOC_DAPM_OUTPUT("HPOUT1L"),
 SND_SOC_DAPM_OUTPUT("HPOUT1R"),
 SND_SOC_DAPM_OUTPUT("HPOUT2L"),
@@ -539,7 +558,11 @@ SND_SOC_DAPM_OUTPUT("SPKDAT1R"),
 	{ name, "LHPF1", "LHPF1" }, \
 	{ name, "LHPF2", "LHPF2" }, \
 	{ name, "LHPF3", "LHPF3" }, \
-	{ name, "LHPF4", "LHPF4" }
+	{ name, "LHPF4", "LHPF4" }, \
+	{ name, "ASRC1L", "ASRC1L" }, \
+	{ name, "ASRC1R", "ASRC1R" }, \
+	{ name, "ASRC2L", "ASRC2L" }, \
+	{ name, "ASRC2R", "ASRC2R" }
 
 static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "AIF2 Capture", NULL, "DBVDD2" },
@@ -660,6 +683,11 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	ARIZONA_MIXER_ROUTES("LHPF3", "LHPF3"),
 	ARIZONA_MIXER_ROUTES("LHPF4", "LHPF4"),
 
+	ARIZONA_MIXER_ROUTES("ASRC1L", "ASRC1L"),
+	ARIZONA_MIXER_ROUTES("ASRC1R", "ASRC1R"),
+	ARIZONA_MIXER_ROUTES("ASRC2L", "ASRC2L"),
+	ARIZONA_MIXER_ROUTES("ASRC2R", "ASRC2R"),
+
 	{ "HPOUT1L", NULL, "OUT1L" },
 	{ "HPOUT1R", NULL, "OUT1R" },
 
-- 
1.7.10
