From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: dapm: Add flags to regulator supplies
Date: Fri,  7 Sep 2012 13:01:53 +0800
Message-ID: <1346994116-17873-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7400C26036E
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 07:02:18 +0200 (CEST)
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

This will be used to enable additional control of the regulators.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h        |    5 +++--
 sound/soc/codecs/ab8500-codec.c |    8 ++++----
 sound/soc/codecs/wm2200.c       |    4 ++--
 sound/soc/codecs/wm5100.c       |    6 +++---
 sound/soc/codecs/wm5102.c       |   12 ++++++------
 sound/soc/codecs/wm5110.c       |   12 ++++++------
 sound/soc/codecs/wm8996.c       |    2 +-
 7 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 07e2510..c96bf5a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -244,10 +244,11 @@ struct device;
 {	.id = snd_soc_dapm_supply, .name = wname, .reg = wreg,	\
 	.shift = wshift, .invert = winvert, .event = wevent, \
 	.event_flags = wflags}
-#define SND_SOC_DAPM_REGULATOR_SUPPLY(wname, wdelay) \
+#define SND_SOC_DAPM_REGULATOR_SUPPLY(wname, wdelay, wflags)	    \
 {	.id = snd_soc_dapm_regulator_supply, .name = wname, \
 	.reg = SND_SOC_NOPM, .shift = wdelay, .event = dapm_regulator_event, \
-	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD, \
+	.invert = wflags}
 
 
 /* dapm kcontrol types */
diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index b783650..3f46bff 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -390,10 +390,10 @@ static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {
 	SND_SOC_DAPM_CLOCK_SUPPLY("audioclk"),
 
 	/* Regulators */
-	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AUD", 0),
-	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AMIC1", 0),
-	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AMIC2", 0),
-	SND_SOC_DAPM_REGULATOR_SUPPLY("V-DMIC", 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AUD", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AMIC1", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AMIC2", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("V-DMIC", 0, 0),
 
 	/* Power */
 	SND_SOC_DAPM_SUPPLY("Audio Power",
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 71debd0..efa93dbb 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1117,8 +1117,8 @@ SND_SOC_DAPM_SUPPLY("MICBIAS1", WM2200_MIC_BIAS_CTRL_1, WM2200_MICB1_ENA_SHIFT,
 		    0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("MICBIAS2", WM2200_MIC_BIAS_CTRL_2, WM2200_MICB2_ENA_SHIFT,
 		    0, NULL, 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20),
-SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 20),
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 20, 0),
 
 SND_SOC_DAPM_INPUT("IN1L"),
 SND_SOC_DAPM_INPUT("IN1R"),
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 33aa363..f4b327e 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -893,9 +893,9 @@ SND_SOC_DAPM_SUPPLY("SYSCLK", WM5100_CLOCKING_3, WM5100_SYSCLK_ENA_SHIFT, 0,
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", WM5100_CLOCKING_6, WM5100_ASYNC_CLK_ENA_SHIFT,
 		    0, NULL, 0),
 
-SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20),
-SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0, 0),
 
 SND_SOC_DAPM_SUPPLY("CP1", WM5100_HP_CHARGE_PUMP_1, WM5100_CP1_ENA_SHIFT, 0,
 		    NULL, 0),
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 97223e4..3f5da8c 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -312,12 +312,12 @@ SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
 SND_SOC_DAPM_SUPPLY("ASYNCOPCLK", ARIZONA_OUTPUT_ASYNC_CLOCK,
 		    ARIZONA_OPCLK_ASYNC_ENA_SHIFT, 0, NULL, 0),
 
-SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20),
-SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDL", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDL", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0, 0),
 
 SND_SOC_DAPM_SIGGEN("TONE"),
 SND_SOC_DAPM_SIGGEN("NOISE"),
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 94cd4f1..e7f8d17 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -359,12 +359,12 @@ SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
 SND_SOC_DAPM_SUPPLY("ASYNCOPCLK", ARIZONA_OUTPUT_ASYNC_CLOCK,
 		    ARIZONA_OPCLK_ASYNC_ENA_SHIFT, 0, NULL, 0),
 
-SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20),
-SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDL", 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDL", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0, 0),
 
 SND_SOC_DAPM_SIGGEN("TONE"),
 SND_SOC_DAPM_SIGGEN("NOISE"),
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 00f183d..6dcb02c 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -931,7 +931,7 @@ SND_SOC_DAPM_INPUT("IN2RP"),
 SND_SOC_DAPM_INPUT("DMIC1DAT"),
 SND_SOC_DAPM_INPUT("DMIC2DAT"),
 
-SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20),
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
 SND_SOC_DAPM_SUPPLY_S("SYSCLK", 1, WM8996_AIF_CLOCKING_1, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("SYSDSPCLK", 2, WM8996_CLOCKING_1, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("AIFCLK", 2, WM8996_CLOCKING_1, 2, 0, NULL, 0),
-- 
1.7.10.4
