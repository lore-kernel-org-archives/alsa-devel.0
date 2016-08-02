From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1145/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:20:19 +0800
Message-ID: <20160802122019.26450-1-baolex.ni@intel.com>
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
 sound/aoa/core/alsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/core/alsa.c b/sound/aoa/core/alsa.c
index 4a7e4e6..6af6fb6 100644
--- a/sound/aoa/core/alsa.c
+++ b/sound/aoa/core/alsa.c
@@ -9,7 +9,7 @@
 #include "alsa.h"
 
 static int index = -1;
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "index for AOA sound card.");
 
 static struct aoa_card *aoa_card;
-- 
2.9.2
