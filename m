From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1146/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:20:26 +0800
Message-ID: <20160802122026.26520-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: johannes@sipsolutions.net, perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/aoa/soundbus/i2sbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 1cbf210..2b741a4 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -27,7 +27,7 @@ MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
 MODULE_DESCRIPTION("Apple Soundbus: I2S support");
 
 static int force;
-module_param(force, int, 0444);
+module_param(force, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(force, "Force loading i2sbus even when"
 			" no layout-id property is present");
 
-- 
2.9.2
