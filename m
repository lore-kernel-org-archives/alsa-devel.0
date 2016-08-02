From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1243/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:30:34 +0800
Message-ID: <20160802123034.721-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/pci/nm256/nm256.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 4735e27..6235b1e 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -64,30 +64,30 @@ static bool vaio_hack;			/* disabled */
 static bool reset_workaround;
 static bool reset_workaround_2;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
-module_param(playback_bufsize, int, 0444);
+module_param(playback_bufsize, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(playback_bufsize, "DAC frame size in kB for " CARD_NAME " soundcard.");
-module_param(capture_bufsize, int, 0444);
+module_param(capture_bufsize, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(capture_bufsize, "ADC frame size in kB for " CARD_NAME " soundcard.");
-module_param(force_ac97, bool, 0444);
+module_param(force_ac97, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(force_ac97, "Force to use AC97 codec for " CARD_NAME " soundcard.");
-module_param(buffer_top, int, 0444);
+module_param(buffer_top, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(buffer_top, "Set the top address of audio buffer for " CARD_NAME " soundcard.");
-module_param(use_cache, bool, 0444);
+module_param(use_cache, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(use_cache, "Enable the cache for coefficient table access.");
-module_param(vaio_hack, bool, 0444);
+module_param(vaio_hack, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(vaio_hack, "Enable workaround for Sony VAIO notebooks.");
-module_param(reset_workaround, bool, 0444);
+module_param(reset_workaround, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(reset_workaround, "Enable AC97 RESET workaround for some laptops.");
-module_param(reset_workaround_2, bool, 0444);
+module_param(reset_workaround_2, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(reset_workaround_2, "Enable extended AC97 RESET workaround for some other laptops.");
 
 /* just for backward compatibility */
 static bool enable;
-module_param(enable, bool, 0444);
+module_param(enable, bool, S_IRUSR | S_IRGRP | S_IROTH);
 
 
 
-- 
2.9.2
