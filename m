From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1187/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:24:42 +0800
Message-ID: <20160802122442.29306-1-baolex.ni@intel.com>
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
 sound/isa/msnd/msnd_pinnacle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 4c07266..7a4e277 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -787,7 +787,7 @@ static int calibrate_signal;
 
 #ifdef CONFIG_PNP
 static bool isapnp[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
-module_param_array(isapnp, bool, NULL, 0444);
+module_param_array(isapnp, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(isapnp, "ISA PnP detection for specified soundcard.");
 #define has_isapnp(x) isapnp[x]
 #else
-- 
2.9.2
