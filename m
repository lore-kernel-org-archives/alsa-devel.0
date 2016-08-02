From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1236/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:29:49 +0800
Message-ID: <20160802122949.32696-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxbugs@vittgam.net, robbat2@gentoo.org, mst@redhat.com, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/intel8x0.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 9720a30..bc4476b 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -79,30 +79,30 @@ static bool xbox;
 static int spdif_aclink = -1;
 static int inside_vm = -1;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Intel i8x0 soundcard.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Intel i8x0 soundcard.");
-module_param(ac97_clock, int, 0444);
+module_param(ac97_clock, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_clock, "AC'97 codec clock (0 = whitelist + auto-detect, 1 = force autodetect).");
-module_param(ac97_quirk, charp, 0444);
+module_param(ac97_quirk, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
-module_param(buggy_semaphore, bool, 0444);
+module_param(buggy_semaphore, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(buggy_semaphore, "Enable workaround for hardwares with problematic codec semaphores.");
-module_param(buggy_irq, bint, 0444);
+module_param(buggy_irq, bint, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(buggy_irq, "Enable workaround for buggy interrupts on some motherboards.");
-module_param(xbox, bool, 0444);
+module_param(xbox, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xbox, "Set to 1 for Xbox, if you have problems with the AC'97 codec detection.");
-module_param(spdif_aclink, int, 0444);
+module_param(spdif_aclink, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(spdif_aclink, "S/PDIF over AC-link.");
-module_param(inside_vm, bint, 0444);
+module_param(inside_vm, bint, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(inside_vm, "KVM/Parallels optimization.");
 
 /* just for backward compatibility */
 static bool enable;
-module_param(enable, bool, 0444);
+module_param(enable, bool, S_IRUSR | S_IRGRP | S_IROTH);
 static int joystick;
-module_param(joystick, int, 0444);
+module_param(joystick, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 /*
  *  Direct registers
-- 
2.9.2
