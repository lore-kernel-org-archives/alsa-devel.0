From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1248/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:31:00 +0800
Message-ID: <20160802123100.1063-1-baolex.ni@intel.com>
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
 sound/pci/riptide/riptide.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 94639d6..e73a45b 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -130,19 +130,19 @@ static int joystick_port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS - 1)] = 0x200 };
 static int mpu_port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS - 1)] = 0x330 };
 static int opl3_port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS - 1)] = 0x388 };
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Riptide soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Riptide soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Riptide soundcard.");
 #ifdef SUPPORT_JOYSTICK
-module_param_array(joystick_port, int, NULL, 0444);
+module_param_array(joystick_port, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick_port, "Joystick port # for Riptide soundcard.");
 #endif
-module_param_array(mpu_port, int, NULL, 0444);
+module_param_array(mpu_port, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU401 port # for Riptide driver.");
-module_param_array(opl3_port, int, NULL, 0444);
+module_param_array(opl3_port, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(opl3_port, "OPL3 port # for Riptide driver.");
 
 /*
-- 
2.9.2
