From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1203/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:26:17 +0800
Message-ID: <20160802122617.30395-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/parisc/harmony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 99b64cb..4531062 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -60,9 +60,9 @@
 
 static int index = SNDRV_DEFAULT_IDX1;	/* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Harmony driver.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Harmony driver.");
 
 
-- 
2.9.2
