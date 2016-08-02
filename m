From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1281/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:34:23 +0800
Message-ID: <20160802123423.3580-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, ONeukum@suse.com, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/usb/hiface/chip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/hiface/chip.c b/sound/usb/hiface/chip.c
index 2670d646..d2f4d9a 100644
--- a/sound/usb/hiface/chip.c
+++ b/sound/usb/hiface/chip.c
@@ -50,11 +50,11 @@ static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable this card
 #define DRIVER_NAME "snd-usb-hiface"
 #define CARD_NAME "hiFace"
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
 
 static DEFINE_MUTEX(register_mutex);
-- 
2.9.2
