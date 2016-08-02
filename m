From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1239/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:30:08 +0800
Message-ID: <20160802123008.446-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/pci/lola/lola.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 9ff60008..c32d0bb 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -37,11 +37,11 @@ static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Digigram Lola driver.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Digigram Lola driver.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Digigram Lola driver.");
 
 /* Lola-specific options */
@@ -58,9 +58,9 @@ static int sample_rate_min[SNDRV_CARDS] = {
 	[0 ... (SNDRV_CARDS - 1) ] = 16000
 };
 
-module_param_array(granularity, int, NULL, 0444);
+module_param_array(granularity, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(granularity, "Granularity value");
-module_param_array(sample_rate_min, int, NULL, 0444);
+module_param_array(sample_rate_min, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(sample_rate_min, "Minimal sample rate");
 
 /*
@@ -73,7 +73,7 @@ MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 static int debug;
-module_param(debug, int, 0644);
+module_param(debug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 #define verbose_debug(fmt, args...)			\
 	do { if (debug > 1) pr_debug(SFX fmt, ##args); } while (0)
 #else
-- 
2.9.2
