From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Correct channel numbers for WM8996 AIF2
Date: Sat, 10 Sep 2011 22:36:46 -0700
Message-ID: <1315719406-18513-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C69A2445A
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 12:25:19 +0200 (CEST)
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

The AIF1 channels are numbered from zero than one; do the same thing for
AIF2 too.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index cbd0206..b3b0a9d 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1046,14 +1046,14 @@ SND_SOC_DAPM_DAC("DAC2R", NULL, WM8996_POWER_MANAGEMENT_5, 2, 0),
 SND_SOC_DAPM_DAC("DAC1L", NULL, WM8996_POWER_MANAGEMENT_5, 1, 0),
 SND_SOC_DAPM_DAC("DAC1R", NULL, WM8996_POWER_MANAGEMENT_5, 0, 0),
 
-SND_SOC_DAPM_AIF_IN("AIF2RX1", "AIF2 Playback", 1,
+SND_SOC_DAPM_AIF_IN("AIF2RX1", "AIF2 Playback", 0,
 		    WM8996_POWER_MANAGEMENT_4, 9, 0),
-SND_SOC_DAPM_AIF_IN("AIF2RX0", "AIF2 Playback", 2,
+SND_SOC_DAPM_AIF_IN("AIF2RX0", "AIF2 Playback", 1,
 		    WM8996_POWER_MANAGEMENT_4, 8, 0),
 
-SND_SOC_DAPM_AIF_IN("AIF2TX1", "AIF2 Capture", 1,
+SND_SOC_DAPM_AIF_IN("AIF2TX1", "AIF2 Capture", 0,
 		    WM8996_POWER_MANAGEMENT_6, 9, 0),
-SND_SOC_DAPM_AIF_IN("AIF2TX0", "AIF2 Capture", 2,
+SND_SOC_DAPM_AIF_IN("AIF2TX0", "AIF2 Capture", 1,
 		    WM8996_POWER_MANAGEMENT_6, 8, 0),
 
 SND_SOC_DAPM_AIF_IN("AIF1RX5", "AIF1 Playback", 5,
-- 
1.7.5.4
