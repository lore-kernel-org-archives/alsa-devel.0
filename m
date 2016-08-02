From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1257/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:32:04 +0800
Message-ID: <20160802123204.1750-1-baolex.ni@intel.com>
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
 sound/pci/via82xx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 3dd038b..0d23ae7 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -88,30 +88,30 @@ static int dxs_support;
 static int dxs_init_volume = 31;
 static int nodelay;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for VIA 82xx bridge.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for VIA 82xx bridge.");
-module_param(mpu_port, long, 0444);
+module_param(mpu_port, long, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port. (VT82C686x only)");
 #ifdef SUPPORT_JOYSTICK
-module_param(joystick, bool, 0444);
+module_param(joystick, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick, "Enable joystick. (VT82C686x only)");
 #endif
-module_param(ac97_clock, int, 0444);
+module_param(ac97_clock, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_clock, "AC'97 codec clock (default 48000Hz).");
-module_param(ac97_quirk, charp, 0444);
+module_param(ac97_quirk, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
-module_param(dxs_support, int, 0444);
+module_param(dxs_support, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dxs_support, "Support for DXS channels (0 = auto, 1 = enable, 2 = disable, 3 = 48k only, 4 = no VRA, 5 = enable any sample rate)");
-module_param(dxs_init_volume, int, 0644);
+module_param(dxs_init_volume, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dxs_init_volume, "initial DXS volume (0-31)");
-module_param(nodelay, int, 0444);
+module_param(nodelay, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nodelay, "Disable 500ms init delay");
 
 /* just for backward compatibility */
 static bool enable;
-module_param(enable, bool, 0444);
+module_param(enable, bool, S_IRUSR | S_IRGRP | S_IROTH);
 
 
 /* revision numbers for via686 */
-- 
2.9.2
