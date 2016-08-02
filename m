From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1173/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:23:11 +0800
Message-ID: <20160802122311.28354-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/isa/adlib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/isa/adlib.c b/sound/isa/adlib.c
index 120c524..8b51385 100644
--- a/sound/isa/adlib.c
+++ b/sound/isa/adlib.c
@@ -21,13 +21,13 @@ static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 
 static int snd_adlib_match(struct device *dev, unsigned int n)
-- 
2.9.2
