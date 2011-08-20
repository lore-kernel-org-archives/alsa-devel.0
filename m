From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix configuration of WM8996 input enables
Date: Sat, 20 Aug 2011 18:38:51 +0100
Message-ID: <1313861931-28100-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85A9810381B
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 19:38:54 +0200 (CEST)
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

There's no need for separate widgets for the enables (as the map already
shows).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 0371736..0936ae5 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -988,15 +988,10 @@ SND_SOC_DAPM_MICBIAS("MICB1", WM8996_POWER_MANAGEMENT_1, 8, 0),
 SND_SOC_DAPM_PGA("IN1L PGA", WM8996_POWER_MANAGEMENT_2, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA("IN1R PGA", WM8996_POWER_MANAGEMENT_2, 4, 0, NULL, 0),
 
-SND_SOC_DAPM_MUX("IN1L Mux", SND_SOC_NOPM, 0, 0, &in1_mux),
-SND_SOC_DAPM_MUX("IN1R Mux", SND_SOC_NOPM, 0, 0, &in1_mux),
-SND_SOC_DAPM_MUX("IN2L Mux", SND_SOC_NOPM, 0, 0, &in2_mux),
-SND_SOC_DAPM_MUX("IN2R Mux", SND_SOC_NOPM, 0, 0, &in2_mux),
-
-SND_SOC_DAPM_PGA("IN1L", WM8996_POWER_MANAGEMENT_7, 2, 0, NULL, 0),
-SND_SOC_DAPM_PGA("IN1R", WM8996_POWER_MANAGEMENT_7, 3, 0, NULL, 0),
-SND_SOC_DAPM_PGA("IN2L", WM8996_POWER_MANAGEMENT_7, 6, 0, NULL, 0),
-SND_SOC_DAPM_PGA("IN2R", WM8996_POWER_MANAGEMENT_7, 7, 0, NULL, 0),
+SND_SOC_DAPM_MUX("IN1L Mux", WM8996_POWER_MANAGEMENT_7, 2, 0, &in1_mux),
+SND_SOC_DAPM_MUX("IN1R Mux", WM8996_POWER_MANAGEMENT_7, 3, 0, &in1_mux),
+SND_SOC_DAPM_MUX("IN2L Mux", WM8996_POWER_MANAGEMENT_7, 6, 0, &in2_mux),
+SND_SOC_DAPM_MUX("IN2R Mux", WM8996_POWER_MANAGEMENT_7, 7, 0, &in2_mux),
 
 SND_SOC_DAPM_SUPPLY("DMIC2", WM8996_POWER_MANAGEMENT_7, 9, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("DMIC1", WM8996_POWER_MANAGEMENT_7, 8, 0, NULL, 0),
-- 
1.7.5.4
