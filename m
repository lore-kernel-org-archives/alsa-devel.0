From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1234/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:29:37 +0800
Message-ID: <20160802122937.32559-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, subhransu.s.prusty@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/ice1712/ice1712.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 8ae3bb7..22b71a0 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -89,19 +89,19 @@ static bool omni[SNDRV_CARDS];				/* Delta44 & 66 Omni I/O support */
 static int cs8427_timeout[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = 500}; /* CS8427 S/PDIF transceiver reset timeout value in msec */
 static int dxr_enable[SNDRV_CARDS];			/* DXR enable for DMX6FIRE */
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for ICE1712 soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for ICE1712 soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable ICE1712 soundcard.");
-module_param_array(omni, bool, NULL, 0444);
+module_param_array(omni, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(omni, "Enable Midiman M-Audio Delta Omni I/O support.");
-module_param_array(cs8427_timeout, int, NULL, 0444);
+module_param_array(cs8427_timeout, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(cs8427_timeout, "Define reset timeout for cs8427 chip in msec resolution.");
-module_param_array(model, charp, NULL, 0444);
+module_param_array(model, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(model, "Use the given board model.");
-module_param_array(dxr_enable, int, NULL, 0444);
+module_param_array(dxr_enable, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dxr_enable, "Enable DXR support for Terratec DMX6FIRE.");
 
 
-- 
2.9.2
