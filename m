From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1206/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:26:34 +0800
Message-ID: <20160802122634.30597-1-baolex.ni@intel.com>
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
 sound/pci/ali5451/ali5451.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 36470af..8b8811c 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -50,18 +50,18 @@ static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
 static int pcm_channels = 32;
 static bool spdif;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for ALI M5451 PCI Audio.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for ALI M5451 PCI Audio.");
-module_param(pcm_channels, int, 0444);
+module_param(pcm_channels, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pcm_channels, "PCM Channels");
-module_param(spdif, bool, 0444);
+module_param(spdif, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(spdif, "Support SPDIF I/O");
 
 /* just for backward compatibility */
 static bool enable;
-module_param(enable, bool, 0444);
+module_param(enable, bool, S_IRUSR | S_IRGRP | S_IROTH);
 
 
 /*
-- 
2.9.2
