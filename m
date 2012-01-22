From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8996: Call _POST_PMU callback for CPVDD
Date: Sun, 22 Jan 2012 15:56:04 +0000
Message-ID: <1327247764-21164-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2CE8024425
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 16:56:08 +0100 (CET)
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

We should be allowing a 5ms delay after the charge pump is started in
order to ensure it has finished ramping.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 8e8f8d1..390ccdd 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1120,7 +1120,8 @@ SND_SOC_DAPM_SUPPLY_S("SYSCLK", 1, WM8996_AIF_CLOCKING_1, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("SYSDSPCLK", 2, WM8996_CLOCKING_1, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("AIFCLK", 2, WM8996_CLOCKING_1, 2, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("Charge Pump", 2, WM8996_CHARGE_PUMP_1, 15, 0, cp_event,
-		      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+		      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		      SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("Bandgap", SND_SOC_NOPM, 0, 0, bg_event,
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("LDO2", WM8996_POWER_MANAGEMENT_2, 1, 0, NULL, 0),
-- 
1.7.7.3
