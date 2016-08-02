From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1147/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:20:32 +0800
Message-ID: <20160802122032.26588-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, hkallweit1@gmail.com, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/core/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 6bda843..993b21c 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -55,7 +55,7 @@ EXPORT_SYMBOL(snd_cards);
 static DEFINE_MUTEX(snd_card_mutex);
 
 static char *slots[SNDRV_CARDS];
-module_param_array(slots, charp, NULL, 0444);
+module_param_array(slots, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(slots, "Module names assigned to the slots.");
 
 /* return non-zero if the given index is reserved for the given
-- 
2.9.2
