From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1278/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:34:06 +0800
Message-ID: <20160802123406.3376-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, fabio.estevam@nxp.com, linus.walleij@linaro.org, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/usb/6fire/chip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index dcddfc3..afce091 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -38,11 +38,11 @@ static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable card */
 static struct sfire_chip *chips[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 static struct usb_device *devices[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for the 6fire sound device");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for the 6fire sound device.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable the 6fire sound device.");
 
 static DEFINE_MUTEX(register_mutex);
-- 
2.9.2
