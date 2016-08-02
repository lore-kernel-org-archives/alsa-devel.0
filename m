From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1265/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:32:53 +0800
Message-ID: <20160802123253.2368-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/sh/aica.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index ad3d9ae..e6bfee8 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -56,11 +56,11 @@ MODULE_FIRMWARE("aica_firmware.bin");
 static int index = -1;
 static char *id;
 static bool enable = 1;
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
-module_param(enable, bool, 0644);
+module_param(enable, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
 
 /* Use workqueue */
-- 
2.9.2
