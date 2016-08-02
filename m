From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1280/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:34:17 +0800
Message-ID: <20160802123417.3512-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, mchehab@osg.samsung.com, shuahkh@osg.samsung.com, ONeukum@suse.com, chuansheng.liu@intel.com, baolex.ni@intel.com, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/usb/card.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 69860da..4808173 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -84,24 +84,24 @@ static bool ignore_ctl_error;
 static bool autoclock = true;
 static char *quirk_alias[SNDRV_CARDS];
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for the USB audio adapter.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for the USB audio adapter.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable USB audio adapter.");
-module_param_array(vid, int, NULL, 0444);
+module_param_array(vid, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(vid, "Vendor ID for the USB audio device.");
-module_param_array(pid, int, NULL, 0444);
+module_param_array(pid, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pid, "Product ID for the USB audio device.");
-module_param_array(device_setup, int, NULL, 0444);
+module_param_array(device_setup, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(device_setup, "Specific device setup (if needed).");
-module_param(ignore_ctl_error, bool, 0444);
+module_param(ignore_ctl_error, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ignore_ctl_error,
 		 "Ignore errors from USB controller for mixer interfaces.");
-module_param(autoclock, bool, 0444);
+module_param(autoclock, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(autoclock, "Enable auto-clock selection for UAC2 devices (default: yes).");
-module_param_array(quirk_alias, charp, NULL, 0444);
+module_param_array(quirk_alias, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(quirk_alias, "Quirk aliases, e.g. 0123abcd:5678beef.");
 
 /*
-- 
2.9.2
