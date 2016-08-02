From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1167/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:22:34 +0800
Message-ID: <20160802122234.27946-1-baolex.ni@intel.com>
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
 sound/drivers/serial-u16550.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 1927b89..465541c 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -78,28 +78,28 @@ static int ins[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};	/* 1 to 16 */
 static int adaptor[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = SNDRV_SERIAL_SOUNDCANVAS};
 static bool droponfull[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS -1)] = SNDRV_SERIAL_NORMALBUFF };
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Serial MIDI.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Serial MIDI.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable UART16550A chip.");
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for UART16550A chip.");
-module_param_array(irq, int, NULL, 0444);
+module_param_array(irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "IRQ # for UART16550A chip.");
-module_param_array(speed, int, NULL, 0444);
+module_param_array(speed, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(speed, "Speed in bauds.");
-module_param_array(base, int, NULL, 0444);
+module_param_array(base, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(base, "Base for divisor in bauds.");
-module_param_array(outs, int, NULL, 0444);
+module_param_array(outs, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(outs, "Number of MIDI outputs.");
-module_param_array(ins, int, NULL, 0444);
+module_param_array(ins, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ins, "Number of MIDI inputs.");
-module_param_array(droponfull, bool, NULL, 0444);
+module_param_array(droponfull, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(droponfull, "Flag to enable drop-on-full buffer mode");
 
-module_param_array(adaptor, int, NULL, 0444);
+module_param_array(adaptor, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(adaptor, "Type of adaptor.");
 
 /*#define SNDRV_SERIAL_MS124W_MB_NOCOMBO 1*/  /* Address outs as 0-3 instead of bitmap */
-- 
2.9.2
