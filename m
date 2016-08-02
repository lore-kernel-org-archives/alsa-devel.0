From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1148/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:20:38 +0800
Message-ID: <20160802122038.26656-1-baolex.ni@intel.com>
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
 sound/core/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/misc.c b/sound/core/misc.c
index f2e8226..4683c43 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -36,7 +36,7 @@
 #endif
 
 static int debug = DEFAULT_DEBUG_LEVEL;
-module_param(debug, int, 0644);
+module_param(debug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Debug level (0 = disable)");
 
 #endif /* CONFIG_SND_DEBUG */
-- 
2.9.2
