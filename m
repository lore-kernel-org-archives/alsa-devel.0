From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1259/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:32:17 +0800
Message-ID: <20160802123217.1889-1-baolex.ni@intel.com>
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
 sound/pci/vx222/vx222.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index ecbaf47..3731554 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -41,15 +41,15 @@ static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card
 static bool mic[SNDRV_CARDS]; /* microphone */
 static int ibl[SNDRV_CARDS]; /* microphone */
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Digigram " CARD_NAME " soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Digigram " CARD_NAME " soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Digigram " CARD_NAME " soundcard.");
-module_param_array(mic, bool, NULL, 0444);
+module_param_array(mic, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mic, "Enable Microphone.");
-module_param_array(ibl, int, NULL, 0444);
+module_param_array(ibl, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ibl, "Capture IBL size.");
 
 /*
-- 
2.9.2
