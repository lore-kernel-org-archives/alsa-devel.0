From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 2/2] ASoC: intel: byt: Fix quirk for KIANO laptop
Date: Tue, 21 Nov 2017 17:15:46 +0000
Message-ID: <20171121171546.5656-3-carlo@caione.org>
References: <20171121171546.5656-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171121171546.5656-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

This laptop has actually two different analog mics, no just one. Fix the
quirk to reflect the correct configuration.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e3d5e6ea707f..488ec48f296a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -264,7 +264,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
 		},
-		.driver_data = (void *)(BYT_RT5651_IN2_MAP),
+		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
 };
-- 
2.14.1
