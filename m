From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1226/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:28:37 +0800
Message-ID: <20160802122838.31957-1-baolex.ni@intel.com>
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
 sound/pci/ens1370.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 626cd21..4116d6f 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -98,25 +98,25 @@ static int spdif[SNDRV_CARDS];
 static int lineio[SNDRV_CARDS];
 #endif
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Ensoniq AudioPCI soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Ensoniq AudioPCI soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Ensoniq AudioPCI soundcard.");
 #ifdef SUPPORT_JOYSTICK
 #ifdef CHIP1371
-module_param_array(joystick_port, int, NULL, 0444);
+module_param_array(joystick_port, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick_port, "Joystick port address.");
 #else
-module_param_array(joystick, bool, NULL, 0444);
+module_param_array(joystick, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick, "Enable joystick.");
 #endif
 #endif /* SUPPORT_JOYSTICK */
 #ifdef CHIP1371
-module_param_array(spdif, int, NULL, 0444);
+module_param_array(spdif, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(spdif, "S/PDIF output (-1 = none, 0 = auto, 1 = force).");
-module_param_array(lineio, int, NULL, 0444);
+module_param_array(lineio, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(lineio, "Line In to Rear Out (0 = auto, 1 = force).");
 #endif
 
-- 
2.9.2
