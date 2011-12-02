From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM8994 MICBIASes to supply
	widgets
Date: Fri,  2 Dec 2011 16:02:43 +0000
Message-ID: <1322841763-29766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 657FE24477
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 17:02:46 +0100 (CET)
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

There are some in tree systems using the driver but none use the MICBIAS
widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index d1debfb..2a61094 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -610,8 +610,8 @@ SND_SOC_DAPM_INPUT("IN1RP"),
 SND_SOC_DAPM_INPUT("IN2RN"),
 SND_SOC_DAPM_INPUT("IN2RP:VXRP"),
 
-SND_SOC_DAPM_MICBIAS("MICBIAS2", WM8993_POWER_MANAGEMENT_1, 5, 0),
-SND_SOC_DAPM_MICBIAS("MICBIAS1", WM8993_POWER_MANAGEMENT_1, 4, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS2", WM8993_POWER_MANAGEMENT_1, 5, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS1", WM8993_POWER_MANAGEMENT_1, 4, 0, NULL, 0),
 
 SND_SOC_DAPM_MIXER("IN1L PGA", WM8993_POWER_MANAGEMENT_2, 6, 0,
 		   in1l_pga, ARRAY_SIZE(in1l_pga)),
-- 
1.7.7.3
