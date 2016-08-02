From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1254/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:31:41 +0800
Message-ID: <20160802123141.1515-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, thierry.reding@gmail.com, gnurou@gmail.com, kadlec@blackhole.kfki.hu, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 sound/pci/sis7019.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index f3860b8..1b68640 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -43,13 +43,13 @@ static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
 static bool enable = 1;
 static int codecs = 1;
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for SiS7019 Audio Accelerator.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for SiS7019 Audio Accelerator.");
-module_param(enable, bool, 0444);
+module_param(enable, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable SiS7019 Audio Accelerator.");
-module_param(codecs, int, 0444);
+module_param(codecs, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(codecs, "Set bit to indicate that codec number is expected to be present (default 1)");
 
 static const struct pci_device_id snd_sis7019_ids[] = {
-- 
2.9.2
