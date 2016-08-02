From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1150/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:20:50 +0800
Message-ID: <20160802122050.26792-1-baolex.ni@intel.com>
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
 sound/core/pcm_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index b45f6aa..f93f9cd 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -32,11 +32,11 @@
 #include <sound/initval.h>
 
 static int preallocate_dma = 1;
-module_param(preallocate_dma, int, 0444);
+module_param(preallocate_dma, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(preallocate_dma, "Preallocate DMA memory when the PCM devices are initialized.");
 
 static int maximum_substreams = 4;
-module_param(maximum_substreams, int, 0444);
+module_param(maximum_substreams, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(maximum_substreams, "Maximum substreams with preallocated DMA memory.");
 
 static const size_t snd_minimum_buffer = 16384;
-- 
2.9.2
