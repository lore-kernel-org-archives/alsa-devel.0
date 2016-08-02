From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1214/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:27:23 +0800
Message-ID: <20160802122723.31140-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/pci/bt87x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 5925b71..d1d8a12 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -46,15 +46,15 @@ static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card
 static int digital_rate[SNDRV_CARDS];	/* digital input rate */
 static bool load_all;	/* allow to load the non-whitelisted cards */
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Bt87x soundcard");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Bt87x soundcard");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Bt87x soundcard");
-module_param_array(digital_rate, int, NULL, 0444);
+module_param_array(digital_rate, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(digital_rate, "Digital input rate for Bt87x soundcard");
-module_param(load_all, bool, 0444);
+module_param(load_all, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(load_all, "Allow to load the non-whitelisted cards");
 
 
-- 
2.9.2
