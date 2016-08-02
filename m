From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1282/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:34:28 +0800
Message-ID: <20160802123428.3647-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/usb/misc/ua101.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index c19a5dd..c48d874 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -55,13 +55,13 @@ static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 static unsigned int queue_length = 21;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "card index");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "enable card");
-module_param(queue_length, uint, 0644);
+module_param(queue_length, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(queue_length, "USB queue length in microframes, "
 		 __stringify(MIN_QUEUE_LENGTH)"-"__stringify(MAX_QUEUE_LENGTH));
 
-- 
2.9.2
