From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1241/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:30:21 +0800
Message-ID: <20160802123021.585-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@rainbow-software.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/maestro3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 17ae926..c1892d2 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -68,15 +68,15 @@ static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* all enabled */
 static bool external_amp[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 static int amp_gpio[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable this soundcard.");
-module_param_array(external_amp, bool, NULL, 0444);
+module_param_array(external_amp, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(external_amp, "Enable external amp for " CARD_NAME " soundcard.");
-module_param_array(amp_gpio, int, NULL, 0444);
+module_param_array(amp_gpio, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(amp_gpio, "GPIO pin number for external amp. (default = -1)");
 
 #define MAX_PLAYBACKS	2
-- 
2.9.2
