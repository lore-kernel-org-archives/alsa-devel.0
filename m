From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 8/8] ASoC: arizona: Add support for new
	micbias regulators
Date: Tue, 28 Mar 2017 15:14:44 +0100
Message-ID: <1490710484-25277-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 835B7266DF2
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 16:13:50 +0200 (CEST)
In-Reply-To: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

Change the widgets from the old SND_SOC_DAPM_SUPPLY widgets into
SND_SOC_DAPM_REGULATOR_SUPPLY widgets now that we have proper regulator
support for the micbiases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

No changes since v1.

 sound/soc/codecs/cs47l24.c | 6 ++----
 sound/soc/codecs/wm5102.c  | 9 +++------
 sound/soc/codecs/wm5110.c  | 9 +++------
 sound/soc/codecs/wm8997.c  | 9 +++------
 sound/soc/codecs/wm8998.c  | 9 +++------
 5 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 47e6fdd..c5dc322 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -386,10 +386,8 @@ SND_SOC_DAPM_PGA_E("IN2R PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN2R_ENA_SHIFT,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
-SND_SOC_DAPM_SUPPLY("MICBIAS1", ARIZONA_MIC_BIAS_CTRL_1,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS2", ARIZONA_MIC_BIAS_CTRL_2,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS1", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS2", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
 
 SND_SOC_DAPM_PGA("Noise Generator", ARIZONA_COMFORT_NOISE_GENERATOR,
 		 ARIZONA_NOISE_GEN_ENA_SHIFT, 0, NULL, 0),
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 1fe358e..2a817f8 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1137,12 +1137,9 @@ SND_SOC_DAPM_PGA_E("IN3R PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN3R_ENA_SHIFT,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
-SND_SOC_DAPM_SUPPLY("MICBIAS1", ARIZONA_MIC_BIAS_CTRL_1,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS2", ARIZONA_MIC_BIAS_CTRL_2,
-		    ARIZONA_MICB2_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS3", ARIZONA_MIC_BIAS_CTRL_3,
-		    ARIZONA_MICB3_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS1", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS2", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS3", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
 
 SND_SOC_DAPM_PGA("Noise Generator", ARIZONA_COMFORT_NOISE_GENERATOR,
 		 ARIZONA_NOISE_GEN_ENA_SHIFT, 0, NULL, 0),
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 1bc9421..57f3b41 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1157,12 +1157,9 @@ SND_SOC_DAPM_PGA_E("IN4R PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN4R_ENA_SHIFT,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
-SND_SOC_DAPM_SUPPLY("MICBIAS1", ARIZONA_MIC_BIAS_CTRL_1,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS2", ARIZONA_MIC_BIAS_CTRL_2,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS3", ARIZONA_MIC_BIAS_CTRL_3,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS1", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS2", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS3", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
 
 SND_SOC_DAPM_PGA("Noise Generator", ARIZONA_COMFORT_NOISE_GENERATOR,
 		 ARIZONA_NOISE_GEN_ENA_SHIFT, 0, NULL, 0),
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 49401a8..455d88a 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -452,12 +452,9 @@ SND_SOC_DAPM_PGA_E("IN2R PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN2R_ENA_SHIFT,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
-SND_SOC_DAPM_SUPPLY("MICBIAS1", ARIZONA_MIC_BIAS_CTRL_1,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS2", ARIZONA_MIC_BIAS_CTRL_2,
-		    ARIZONA_MICB2_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS3", ARIZONA_MIC_BIAS_CTRL_3,
-		    ARIZONA_MICB3_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS1", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS2", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS3", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
 
 SND_SOC_DAPM_PGA("Noise Generator", ARIZONA_COMFORT_NOISE_GENERATOR,
 		 ARIZONA_NOISE_GEN_ENA_SHIFT, 0, NULL, 0),
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 44f4471..a5e87ba 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -587,12 +587,9 @@ SND_SOC_DAPM_PGA_E("IN2 PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN2L_ENA_SHIFT,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
-SND_SOC_DAPM_SUPPLY("MICBIAS1", ARIZONA_MIC_BIAS_CTRL_1,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS2", ARIZONA_MIC_BIAS_CTRL_2,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS3", ARIZONA_MIC_BIAS_CTRL_3,
-		    ARIZONA_MICB1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS1", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS2", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICBIAS3", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
 
 SND_SOC_DAPM_PGA("Tone Generator 1", ARIZONA_TONE_GENERATOR_1,
 		 ARIZONA_TONE1_ENA_SHIFT, 0, NULL, 0),
-- 
2.1.4
