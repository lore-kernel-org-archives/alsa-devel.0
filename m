From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1228/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:28:49 +0800
Message-ID: <20160802122850.32093-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, mchehab@osg.samsung.com, Julia.Lawall@lip6.fr, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/es1968.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 514f260..833be2c 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -144,29 +144,29 @@ static bool joystick[SNDRV_CARDS];
 #endif
 static int radio_nr[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
-module_param_array(total_bufsize, int, NULL, 0444);
+module_param_array(total_bufsize, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(total_bufsize, "Total buffer size in kB.");
-module_param_array(pcm_substreams_p, int, NULL, 0444);
+module_param_array(pcm_substreams_p, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pcm_substreams_p, "PCM Playback substreams for " CARD_NAME " soundcard.");
-module_param_array(pcm_substreams_c, int, NULL, 0444);
+module_param_array(pcm_substreams_c, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pcm_substreams_c, "PCM Capture substreams for " CARD_NAME " soundcard.");
-module_param_array(clock, int, NULL, 0444);
+module_param_array(clock, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(clock, "Clock on " CARD_NAME " soundcard.  (0 = auto-detect)");
-module_param_array(use_pm, int, NULL, 0444);
+module_param_array(use_pm, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(use_pm, "Toggle power-management.  (0 = off, 1 = on, 2 = auto)");
-module_param_array(enable_mpu, int, NULL, 0444);
+module_param_array(enable_mpu, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable_mpu, "Enable MPU401.  (0 = off, 1 = on, 2 = auto)");
 #ifdef SUPPORT_JOYSTICK
-module_param_array(joystick, bool, NULL, 0444);
+module_param_array(joystick, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick, "Enable joystick.");
 #endif
-module_param_array(radio_nr, int, NULL, 0444);
+module_param_array(radio_nr, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(radio_nr, "Radio device numbers");
 
 
-- 
2.9.2
