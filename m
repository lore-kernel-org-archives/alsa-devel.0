From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1277/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:34:00 +0800
Message-ID: <20160802123400.3299-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, fabio.estevam@nxp.com, linus.walleij@linaro.org, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/sparc/dbri.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 0190cb6..4cc609e 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -82,11 +82,11 @@ static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 /* Enable this card */
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Sun DBRI soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Sun DBRI soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Sun DBRI soundcard.");
 
 #undef DBRI_DEBUG
@@ -99,7 +99,7 @@ MODULE_PARM_DESC(enable, "Enable Sun DBRI soundcard.");
 #define D_DESC	(1<<5)
 
 static int dbri_debug;
-module_param(dbri_debug, int, 0644);
+module_param(dbri_debug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dbri_debug, "Debug value for Sun DBRI soundcard.");
 
 #ifdef DBRI_DEBUG
-- 
2.9.2
