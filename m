From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1166/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:22:26 +0800
Message-ID: <20160802122226.27878-1-baolex.ni@intel.com>
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
 sound/drivers/pcsp/pcsp_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index 3689f5f..18de63c 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -15,7 +15,7 @@
 #include "pcsp.h"
 
 static bool nforce_wa;
-module_param(nforce_wa, bool, 0444);
+module_param(nforce_wa, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nforce_wa, "Apply NForce chipset workaround "
 		"(expect bad sound)");
 
-- 
2.9.2
