From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1162/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:22:03 +0800
Message-ID: <20160802122203.27608-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/drivers/mtpav.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 30e8a1d..3178153 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -82,15 +82,15 @@ static long port = MTPAV_IOBASE;	/* 0x378, 0x278 */
 static int irq = MTPAV_IRQ;		/* 7, 5 */
 static int hwports = MTPAV_MAX_PORTS;	/* use hardware ports 1-8 */
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for MotuMTPAV MIDI.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for MotuMTPAV MIDI.");
-module_param(port, long, 0444);
+module_param(port, long, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Parallel port # for MotuMTPAV MIDI.");
-module_param(irq, int, 0444);
+module_param(irq, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "Parallel IRQ # for MotuMTPAV MIDI.");
-module_param(hwports, int, 0444);
+module_param(hwports, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(hwports, "Hardware ports # for MotuMTPAV MIDI.");
 
 static struct platform_device *device;
-- 
2.9.2
