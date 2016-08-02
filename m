From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1163/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:22:09 +0800
Message-ID: <20160802122209.27676-1-baolex.ni@intel.com>
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
 sound/drivers/opl3/opl3_seq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/opl3/opl3_seq.c b/sound/drivers/opl3/opl3_seq.c
index fdae5d7..d24bb27 100644
--- a/sound/drivers/opl3/opl3_seq.c
+++ b/sound/drivers/opl3/opl3_seq.c
@@ -33,7 +33,7 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ALSA driver for OPL3 FM synth");
 
 bool use_internal_drums = 0;
-module_param(use_internal_drums, bool, 0444);
+module_param(use_internal_drums, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(use_internal_drums, "Enable internal OPL2/3 drums.");
 
 int snd_opl3_synth_use_inc(struct snd_opl3 * opl3)
-- 
2.9.2
