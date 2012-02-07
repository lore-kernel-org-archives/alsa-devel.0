From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_hubs: Convert most output drivers to
	OUT_DRV widgets
Date: Tue,  7 Feb 2012 14:25:26 +0000
Message-ID: <1328624726-5838-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A561103BE9
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 15:25:35 +0100 (CET)
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

No practical impact but now we have the control type we may as well use
it for the slightly nicer sequencing.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index e469483..a53daf6 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -656,10 +656,10 @@ SND_SOC_DAPM_MIXER("SPKR Boost", SND_SOC_NOPM, 0, 0,
 		   right_speaker_boost, ARRAY_SIZE(right_speaker_boost)),
 
 SND_SOC_DAPM_SUPPLY("TSHUT", WM8993_POWER_MANAGEMENT_2, 14, 0, NULL, 0),
-SND_SOC_DAPM_PGA("SPKL Driver", WM8993_POWER_MANAGEMENT_1, 12, 0,
-		 NULL, 0),
-SND_SOC_DAPM_PGA("SPKR Driver", WM8993_POWER_MANAGEMENT_1, 13, 0,
-		 NULL, 0),
+SND_SOC_DAPM_OUT_DRV("SPKL Driver", WM8993_POWER_MANAGEMENT_1, 12, 0,
+		     NULL, 0),
+SND_SOC_DAPM_OUT_DRV("SPKR Driver", WM8993_POWER_MANAGEMENT_1, 13, 0,
+		     NULL, 0),
 
 SND_SOC_DAPM_MIXER("LINEOUT1 Mixer", SND_SOC_NOPM, 0, 0,
 		   line1_mix, ARRAY_SIZE(line1_mix)),
@@ -675,14 +675,14 @@ SND_SOC_DAPM_MIXER("LINEOUT2N Mixer", SND_SOC_NOPM, 0, 0,
 SND_SOC_DAPM_MIXER("LINEOUT2P Mixer", SND_SOC_NOPM, 0, 0,
 		   line2p_mix, ARRAY_SIZE(line2p_mix)),
 
-SND_SOC_DAPM_PGA("LINEOUT1N Driver", WM8993_POWER_MANAGEMENT_3, 13, 0,
-		 NULL, 0),
-SND_SOC_DAPM_PGA("LINEOUT1P Driver", WM8993_POWER_MANAGEMENT_3, 12, 0,
-		 NULL, 0),
-SND_SOC_DAPM_PGA("LINEOUT2N Driver", WM8993_POWER_MANAGEMENT_3, 11, 0,
-		 NULL, 0),
-SND_SOC_DAPM_PGA("LINEOUT2P Driver", WM8993_POWER_MANAGEMENT_3, 10, 0,
-		 NULL, 0),
+SND_SOC_DAPM_OUT_DRV("LINEOUT1N Driver", WM8993_POWER_MANAGEMENT_3, 13, 0,
+		     NULL, 0),
+SND_SOC_DAPM_OUT_DRV("LINEOUT1P Driver", WM8993_POWER_MANAGEMENT_3, 12, 0,
+		     NULL, 0),
+SND_SOC_DAPM_OUT_DRV("LINEOUT2N Driver", WM8993_POWER_MANAGEMENT_3, 11, 0,
+		     NULL, 0),
+SND_SOC_DAPM_OUT_DRV("LINEOUT2P Driver", WM8993_POWER_MANAGEMENT_3, 10, 0,
+		     NULL, 0),
 
 SND_SOC_DAPM_OUTPUT("SPKOUTLP"),
 SND_SOC_DAPM_OUTPUT("SPKOUTLN"),
-- 
1.7.9.rc1
