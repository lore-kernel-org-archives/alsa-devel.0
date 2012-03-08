From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8996: Remove separate output stage
	enable step
Date: Thu,  8 Mar 2012 16:49:00 +0000
Message-ID: <1331225340-2655-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8BCF24450
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 17:49:03 +0100 (CET)
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

Marginally improve performance during startup.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index dd94cd0..a1cfffb 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -890,8 +890,8 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 		val = 0;
 		mask = 0;
 		if (wm8996->hpout_pending & HPOUT1L) {
-			val |= WM8996_HPOUT1L_RMV_SHORT;
-			mask |= WM8996_HPOUT1L_RMV_SHORT;
+			val |= WM8996_HPOUT1L_RMV_SHORT | WM8996_HPOUT1L_OUTP;
+			mask |= WM8996_HPOUT1L_RMV_SHORT | WM8996_HPOUT1L_OUTP;
 		} else {
 			mask |= WM8996_HPOUT1L_RMV_SHORT |
 				WM8996_HPOUT1L_OUTP |
@@ -899,8 +899,8 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 		}
 
 		if (wm8996->hpout_pending & HPOUT1R) {
-			val |= WM8996_HPOUT1R_RMV_SHORT;
-			mask |= WM8996_HPOUT1R_RMV_SHORT;
+			val |= WM8996_HPOUT1R_RMV_SHORT | WM8996_HPOUT1R_OUTP;
+			mask |= WM8996_HPOUT1R_RMV_SHORT | WM8996_HPOUT1R_OUTP;
 		} else {
 			mask |= WM8996_HPOUT1R_RMV_SHORT |
 				WM8996_HPOUT1R_OUTP |
@@ -912,8 +912,8 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 		val = 0;
 		mask = 0;
 		if (wm8996->hpout_pending & HPOUT2L) {
-			val |= WM8996_HPOUT2L_RMV_SHORT;
-			mask |= WM8996_HPOUT2L_RMV_SHORT;
+			val |= WM8996_HPOUT2L_RMV_SHORT | WM8996_HPOUT2L_OUTP;
+			mask |= WM8996_HPOUT2L_RMV_SHORT | WM8996_HPOUT2L_OUTP;
 		} else {
 			mask |= WM8996_HPOUT2L_RMV_SHORT |
 				WM8996_HPOUT2L_OUTP |
@@ -921,8 +921,8 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 		}
 
 		if (wm8996->hpout_pending & HPOUT2R) {
-			val |= WM8996_HPOUT2R_RMV_SHORT;
-			mask |= WM8996_HPOUT2R_RMV_SHORT;
+			val |= WM8996_HPOUT2R_RMV_SHORT | WM8996_HPOUT2R_OUTP;
+			mask |= WM8996_HPOUT2R_RMV_SHORT | WM8996_HPOUT2R_OUTP;
 		} else {
 			mask |= WM8996_HPOUT2R_RMV_SHORT |
 				WM8996_HPOUT2R_OUTP |
@@ -1214,7 +1214,6 @@ SND_SOC_DAPM_PGA_S("HPOUT2L PGA", 0, WM8996_POWER_MANAGEMENT_1, 7, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2L_DLY", 1, WM8996_ANALOGUE_HP_2, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2L_DCS", 2, WM8996_DC_SERVO_1, 2, 0, dcs_start,
 		   SND_SOC_DAPM_POST_PMU),
-SND_SOC_DAPM_PGA_S("HPOUT2L_OUTP", 3, WM8996_ANALOGUE_HP_2, 6, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2L_RMV_SHORT", 3, SND_SOC_NOPM, HPOUT2L, 0,
 		   rmv_short_event,
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -1223,7 +1222,6 @@ SND_SOC_DAPM_PGA_S("HPOUT2R PGA", 0, WM8996_POWER_MANAGEMENT_1, 6, 0,NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2R_DLY", 1, WM8996_ANALOGUE_HP_2, 1, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2R_DCS", 2, WM8996_DC_SERVO_1, 3, 0, dcs_start,
 		   SND_SOC_DAPM_POST_PMU),
-SND_SOC_DAPM_PGA_S("HPOUT2R_OUTP", 3, WM8996_ANALOGUE_HP_2, 2, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT2R_RMV_SHORT", 3, SND_SOC_NOPM, HPOUT2R, 0,
 		   rmv_short_event,
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -1232,7 +1230,6 @@ SND_SOC_DAPM_PGA_S("HPOUT1L PGA", 0, WM8996_POWER_MANAGEMENT_1, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT1L_DLY", 1, WM8996_ANALOGUE_HP_1, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT1L_DCS", 2, WM8996_DC_SERVO_1, 0, 0, dcs_start,
 		   SND_SOC_DAPM_POST_PMU),
-SND_SOC_DAPM_PGA_S("HPOUT1L_OUTP", 3, WM8996_ANALOGUE_HP_1, 6, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPOUT1L_RMV_SHORT", 3, SND_SOC_NOPM, HPOUT1L, 0,
 		   rmv_short_event,
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -1434,32 +1431,28 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
 	{ "HPOUT2L PGA", NULL, "DAC2L" },
 	{ "HPOUT2L_DLY", NULL, "HPOUT2L PGA" },
 	{ "HPOUT2L_DCS", NULL, "HPOUT2L_DLY" },
-	{ "HPOUT2L_OUTP", NULL, "HPOUT2L_DCS" },
-	{ "HPOUT2L_RMV_SHORT", NULL, "HPOUT2L_OUTP" },
+	{ "HPOUT2L_RMV_SHORT", NULL, "HPOUT2L_DCS" },
 
 	{ "HPOUT2R PGA", NULL, "Charge Pump" },
 	{ "HPOUT2R PGA", NULL, "Bandgap" },
 	{ "HPOUT2R PGA", NULL, "DAC2R" },
 	{ "HPOUT2R_DLY", NULL, "HPOUT2R PGA" },
 	{ "HPOUT2R_DCS", NULL, "HPOUT2R_DLY" },
-	{ "HPOUT2R_OUTP", NULL, "HPOUT2R_DCS" },
-	{ "HPOUT2R_RMV_SHORT", NULL, "HPOUT2R_OUTP" },
+	{ "HPOUT2R_RMV_SHORT", NULL, "HPOUT2R_DCS" },
 
 	{ "HPOUT1L PGA", NULL, "Charge Pump" },
 	{ "HPOUT1L PGA", NULL, "Bandgap" },
 	{ "HPOUT1L PGA", NULL, "DAC1L" },
 	{ "HPOUT1L_DLY", NULL, "HPOUT1L PGA" },
 	{ "HPOUT1L_DCS", NULL, "HPOUT1L_DLY" },
-	{ "HPOUT1L_OUTP", NULL, "HPOUT1L_DCS" },
-	{ "HPOUT1L_RMV_SHORT", NULL, "HPOUT1L_OUTP" },
+	{ "HPOUT1L_RMV_SHORT", NULL, "HPOUT1L_DCS" },
 
 	{ "HPOUT1R PGA", NULL, "Charge Pump" },
 	{ "HPOUT1R PGA", NULL, "Bandgap" },
 	{ "HPOUT1R PGA", NULL, "DAC1R" },
 	{ "HPOUT1R_DLY", NULL, "HPOUT1R PGA" },
 	{ "HPOUT1R_DCS", NULL, "HPOUT1R_DLY" },
-	{ "HPOUT1R_OUTP", NULL, "HPOUT1R_DCS" },
-	{ "HPOUT1R_RMV_SHORT", NULL, "HPOUT1R_OUTP" },
+	{ "HPOUT1R_RMV_SHORT", NULL, "HPOUT1R_DCS" },
 
 	{ "HPOUT2L", NULL, "HPOUT2L_RMV_SHORT" },
 	{ "HPOUT2R", NULL, "HPOUT2R_RMV_SHORT" },
-- 
1.7.9.1
