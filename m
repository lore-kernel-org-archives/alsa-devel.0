From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1225/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:28:31 +0800
Message-ID: <20160802122831.31889-1-baolex.ni@intel.com>
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
 sound/pci/emu10k1/emufx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 56fc47b..2be47a8 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -52,7 +52,7 @@
 #endif
 
 static bool high_res_gpr_volume;
-module_param(high_res_gpr_volume, bool, 0444);
+module_param(high_res_gpr_volume, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(high_res_gpr_volume, "GPR mixer controls use 31-bit range.");
 
 /*
-- 
2.9.2
