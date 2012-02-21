From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_hubs: Convert headphone driver to
	output driver widget
Date: Tue, 21 Feb 2012 09:38:18 +0000
Message-ID: <1329817098-6845-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D75924149
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 10:38:23 +0100 (CET)
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

Mostly for neatness, though it may help with sequencing in some
situations.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 9742c66..82b7e9d 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -670,9 +670,8 @@ SND_SOC_DAPM_PGA("Right Output PGA", WM8993_POWER_MANAGEMENT_3, 6, 0, NULL, 0),
 
 SND_SOC_DAPM_SUPPLY("Headphone Supply", SND_SOC_NOPM, 0, 0, hp_supply_event, 
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
-SND_SOC_DAPM_PGA_E("Headphone PGA", SND_SOC_NOPM, 0, 0,
-		   NULL, 0,
-		   hp_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_OUT_DRV_E("Headphone PGA", SND_SOC_NOPM, 0, 0, NULL, 0,
+		       hp_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_MIXER("Earpiece Mixer", SND_SOC_NOPM, 0, 0,
 		   earpiece_mixer, ARRAY_SIZE(earpiece_mixer)),
-- 
1.7.9
