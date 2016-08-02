From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1255/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:31:47 +0800
Message-ID: <20160802123147.1613-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/pci/sonicvibes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 1b6fad7..2072879 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -56,17 +56,17 @@ static bool reverb[SNDRV_CARDS];
 static bool mge[SNDRV_CARDS];
 static unsigned int dmaio = 0x7a00;	/* DDMA i/o address */
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for S3 SonicVibes soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for S3 SonicVibes soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable S3 SonicVibes soundcard.");
-module_param_array(reverb, bool, NULL, 0444);
+module_param_array(reverb, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(reverb, "Enable reverb (SRAM is present) for S3 SonicVibes soundcard.");
-module_param_array(mge, bool, NULL, 0444);
+module_param_array(mge, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mge, "MIC Gain Enable for S3 SonicVibes soundcard.");
-module_param(dmaio, uint, 0444);
+module_param(dmaio, uint, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dmaio, "DDMA i/o base address for S3 SonicVibes soundcard.");
 
 /*
-- 
2.9.2
