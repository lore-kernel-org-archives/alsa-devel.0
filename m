From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1231/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:29:11 +0800
Message-ID: <20160802122911.32355-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, daniel.vetter@ffwll.ch, xiong.y.zhang@intel.com, libin.yang@linux.intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/hda/hda_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 033aa84..09c5c76 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -29,7 +29,7 @@
 #include "hda_local.h"
 
 static int dump_coef = -1;
-module_param(dump_coef, int, 0644);
+module_param(dump_coef, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dump_coef, "Dump processing coefficients in codec proc file (-1=auto, 0=disable, 1=enable)");
 
 /* always use noncached version */
-- 
2.9.2
