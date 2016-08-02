From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1209/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:26:54 +0800
Message-ID: <20160802122654.30801-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Julia.Lawall@lip6.fr, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/atiixp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 2ce0022..6252459 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -46,22 +46,22 @@ static char *ac97_quirk;
 static bool spdif_aclink = 1;
 static int ac97_codec = -1;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for ATI IXP controller.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for ATI IXP controller.");
-module_param(ac97_clock, int, 0444);
+module_param(ac97_clock, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_clock, "AC'97 codec clock (default 48000Hz).");
-module_param(ac97_quirk, charp, 0444);
+module_param(ac97_quirk, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
-module_param(ac97_codec, int, 0444);
+module_param(ac97_codec, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac97_codec, "Specify codec instead of probing.");
-module_param(spdif_aclink, bool, 0444);
+module_param(spdif_aclink, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(spdif_aclink, "S/PDIF over AC-link.");
 
 /* just for backward compatibility */
 static bool enable;
-module_param(enable, bool, 0444);
+module_param(enable, bool, S_IRUSR | S_IRGRP | S_IROTH);
 
 
 /*
-- 
2.9.2
