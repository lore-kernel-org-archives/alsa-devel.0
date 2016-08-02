From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1205/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:26:28 +0800
Message-ID: <20160802122628.30529-1-baolex.ni@intel.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/ad1889.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 1fc6d8b..d27552f 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -58,19 +58,19 @@ MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Analog Devices,AD1889}}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for the AD1889 soundcard.");
 
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for the AD1889 soundcard.");
 
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable AD1889 soundcard.");
 
 static char *ac97_quirk[SNDRV_CARDS];
-module_param_array(ac97_quirk, charp, NULL, 0444);
+module_param_array(ac97_quirk, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
 
 #define DEVNAME "ad1889"
-- 
2.9.2

