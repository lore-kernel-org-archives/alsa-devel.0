From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1165/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:22:19 +0800
Message-ID: <20160802122219.27810-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/drivers/pcsp/pcsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 72e2d00..aff31e6 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -29,13 +29,13 @@ static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
 static bool enable = SNDRV_DEFAULT_ENABLE1;	/* Enable this card */
 static bool nopcm;	/* Disable PCM capability of the driver */
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for pcsp soundcard.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for pcsp soundcard.");
-module_param(enable, bool, 0444);
+module_param(enable, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable PC-Speaker sound.");
-module_param(nopcm, bool, 0444);
+module_param(nopcm, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nopcm, "Disable PC-Speaker PCM sound. Only beeps remain.");
 
 struct snd_pcsp pcsp_chip;
-- 
2.9.2
