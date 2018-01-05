From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/4] ASoC: Intel: bytcr_rt5651: fix Kiano DMI
	quirk
Date: Fri,  5 Jan 2018 13:20:21 -0600
Message-ID: <20180105192023.11229-5-pierre-louis.bossart@linux.intel.com>
References: <20180105192023.11229-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 00252267ABE
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 20:20:34 +0100 (CET)
In-Reply-To: <20180105192023.11229-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, Carlo Caione <carlo@caione.org>, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

The current code doesn't enable the MCLK which reduces audio quality
(PLL driven from BLCK), fix the quirk

Tested-by: Carlo Caione <carlo@caione.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 7d95008f1795..dfe6435f8ed0 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -281,7 +281,8 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
 		},
-		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP),
+		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
 };
-- 
2.14.1
