From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH] ASoC: Intel: kbl: Enable mclk and ssp sclk
	early for rt5663
Date: Mon, 19 Feb 2018 08:15:02 +0530
Message-ID: <1519008302-24432-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EC4E266E7D
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 03:45:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, naveen.m@intel.com, broonie@kernel.org, Kevin Cheng <kevin.cheng@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

rt5663 requires mclk/sclk early to synchronize its internal clocks.
Enable these clocks early.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Kevin Cheng <kevin.cheng@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 3c9585eb6860..0e6b7e79441c 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -204,13 +204,18 @@ static const struct snd_soc_dapm_widget kabylake_5663_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SPK("DP", NULL),
 	SND_SOC_DAPM_SPK("HDMI", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route kabylake_5663_map[] = {
+	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
 
 	/* other jacks */
+	{ "Headset Mic", NULL, "Platform Clock" },
 	{ "IN1P", NULL, "Headset Mic" },
 	{ "IN1N", NULL, "Headset Mic" },
 
-- 
2.7.4
