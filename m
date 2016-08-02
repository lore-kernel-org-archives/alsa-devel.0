From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1230/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:29:05 +0800
Message-ID: <20160802122905.32285-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, han.lu@intel.com, lukas@wunner.de, daniel.vetter@ffwll.ch, xiong.y.zhang@intel.com, libin.yang@linux.intel.com, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/hda/hda_intel.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 94089fc..056451c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -137,36 +137,36 @@ static bool beep_mode[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] =
 					CONFIG_SND_HDA_INPUT_BEEP_MODE};
 #endif
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Intel HD audio interface.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Intel HD audio interface.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Intel HD audio interface.");
-module_param_array(model, charp, NULL, 0444);
+module_param_array(model, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(model, "Use the given board model.");
-module_param_array(position_fix, int, NULL, 0444);
+module_param_array(position_fix, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(position_fix, "DMA pointer read method."
 		 "(-1 = system default, 0 = auto, 1 = LPIB, 2 = POSBUF, 3 = VIACOMBO, 4 = COMBO).");
-module_param_array(bdl_pos_adj, int, NULL, 0644);
+module_param_array(bdl_pos_adj, int, NULL, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(bdl_pos_adj, "BDL position adjustment offset.");
-module_param_array(probe_mask, int, NULL, 0444);
+module_param_array(probe_mask, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(probe_mask, "Bitmask to probe codecs (default = -1).");
-module_param_array(probe_only, int, NULL, 0444);
+module_param_array(probe_only, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(probe_only, "Only probing and no codec initialization.");
-module_param_array(jackpoll_ms, int, NULL, 0444);
+module_param_array(jackpoll_ms, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(jackpoll_ms, "Ms between polling for jack events (default = 0, using unsol events only)");
-module_param(single_cmd, bool, 0444);
+module_param(single_cmd, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(single_cmd, "Use single command to communicate with codecs "
 		 "(for debugging only).");
-module_param(enable_msi, bint, 0444);
+module_param(enable_msi, bint, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable_msi, "Enable Message Signaled Interrupt (MSI)");
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
-module_param_array(patch, charp, NULL, 0444);
+module_param_array(patch, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(patch, "Patch file for Intel HD audio interface.");
 #endif
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
-module_param_array(beep_mode, bool, NULL, 0444);
+module_param_array(beep_mode, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(beep_mode, "Select HDA Beep registration mode "
 			    "(0=off, 1=on) (default=1).");
 #endif
@@ -180,7 +180,7 @@ static const struct kernel_param_ops param_ops_xint = {
 #define param_check_xint param_check_int
 
 static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
-module_param(power_save, xint, 0644);
+module_param(power_save, xint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
 
@@ -189,20 +189,20 @@ MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
  * wake up.
  */
 static bool power_save_controller = 1;
-module_param(power_save_controller, bool, 0644);
+module_param(power_save_controller, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(power_save_controller, "Reset controller in power save mode.");
 #else
 #define power_save	0
 #endif /* CONFIG_PM */
 
 static int align_buffer_size = -1;
-module_param(align_buffer_size, bint, 0644);
+module_param(align_buffer_size, bint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(align_buffer_size,
 		"Force buffer and period sizes to be multiple of 128 bytes.");
 
 #ifdef CONFIG_X86
 static int hda_snoop = -1;
-module_param_named(snoop, hda_snoop, bint, 0444);
+module_param_named(snoop, hda_snoop, bint, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(snoop, "Enable/disable snooping");
 #else
 #define hda_snoop		true
-- 
2.9.2
