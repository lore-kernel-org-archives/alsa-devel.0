From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1237/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:29:55 +0800
Message-ID: <20160802122955.32764-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, mst@redhat.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/intel8x0m.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 1bc98c8..4101fac 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -60,16 +60,16 @@ static int index = -2; /* Exclude the first card */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
 static int ac97_clock;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Intel i8x0 modemcard.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Intel i8x0 modemcard.");
-module_param(ac97_clock, int, 0444);
+module_param(ac97_clock, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_clock, "AC'97 codec clock (0 = auto-detect).");
 
 /* just for backward compatibility */
 static bool enable;
-module_param(enable, bool, 0444);
+module_param(enable, bool, S_IRUSR | S_IRGRP | S_IROTH);
 
 /*
  *  Direct registers
-- 
2.9.2
