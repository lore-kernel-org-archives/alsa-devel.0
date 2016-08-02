From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1262/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:32:36 +0800
Message-ID: <20160802123236.2095-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pcmcia/vx/vxpocket.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index b16f42d..4a8d286 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -42,13 +42,13 @@ static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable switches */
 static int ibl[SNDRV_CARDS];
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for VXPocket soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for VXPocket soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable VXPocket soundcard.");
-module_param_array(ibl, int, NULL, 0444);
+module_param_array(ibl, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ibl, "Capture IBL size for VXPocket soundcard.");
  
 
-- 
2.9.2
