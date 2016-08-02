From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1216/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:27:35 +0800
Message-ID: <20160802122735.31276-1-baolex.ni@intel.com>
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
 sound/pci/cmipci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 24cdcba..a45c7bf 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -62,20 +62,20 @@ static bool soft_ac3[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)]=1};
 static int joystick_port[SNDRV_CARDS];
 #endif
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for C-Media PCI soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for C-Media PCI soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable C-Media PCI soundcard.");
-module_param_array(mpu_port, long, NULL, 0444);
+module_param_array(mpu_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port.");
-module_param_array(fm_port, long, NULL, 0444);
+module_param_array(fm_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fm_port, "FM port.");
-module_param_array(soft_ac3, bool, NULL, 0444);
+module_param_array(soft_ac3, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(soft_ac3, "Software-conversion of raw SPDIF packets (model 033 only).");
 #ifdef SUPPORT_JOYSTICK
-module_param_array(joystick_port, int, NULL, 0444);
+module_param_array(joystick_port, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick_port, "Joystick port address.");
 #endif
 
-- 
2.9.2
