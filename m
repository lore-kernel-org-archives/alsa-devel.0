From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1152/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:21:03 +0800
Message-ID: <20160802122103.26928-1-baolex.ni@intel.com>
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
 sound/core/seq/oss/seq_oss_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 92c96a9..4d25f28 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -37,7 +37,7 @@
  * common variables
  */
 static int maxqlen = SNDRV_SEQ_OSS_MAX_QLEN;
-module_param(maxqlen, int, 0444);
+module_param(maxqlen, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(maxqlen, "maximum queue length");
 
 static int system_client = -1; /* ALSA sequencer client number */
-- 
2.9.2
