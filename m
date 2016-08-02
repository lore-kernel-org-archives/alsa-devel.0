From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1249/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:31:09 +0800
Message-ID: <20160802123109.1135-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lars@metafoo.de, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/rme32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index cd94ac5..c932c09 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -91,13 +91,13 @@ static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
 static bool fullduplex[SNDRV_CARDS]; // = {[0 ... (SNDRV_CARDS - 1)] = 1};
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for RME Digi32 soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for RME Digi32 soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable RME Digi32 soundcard.");
-module_param_array(fullduplex, bool, NULL, 0444);
+module_param_array(fullduplex, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fullduplex, "Support full-duplex mode.");
 MODULE_AUTHOR("Martin Langer <martin-langer@gmx.de>, Pilo Chambert <pilo.c@wanadoo.fr>");
 MODULE_DESCRIPTION("RME Digi32, Digi32/8, Digi32 PRO");
-- 
2.9.2
