From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1149/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:20:44 +0800
Message-ID: <20160802122044.26724-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, hofrat@osadl.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/core/oss/pcm_oss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index ebc9fdf..0ff0dd8 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -53,11 +53,11 @@ static bool nonblock_open = 1;
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Abramo Bagnara <abramo@alsa-project.org>");
 MODULE_DESCRIPTION("PCM OSS emulation for ALSA.");
 MODULE_LICENSE("GPL");
-module_param_array(dsp_map, int, NULL, 0444);
+module_param_array(dsp_map, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dsp_map, "PCM device number assigned to 1st OSS device.");
-module_param_array(adsp_map, int, NULL, 0444);
+module_param_array(adsp_map, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(adsp_map, "PCM device number assigned to 2nd OSS device.");
-module_param(nonblock_open, bool, 0644);
+module_param(nonblock_open, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nonblock_open, "Don't block opening busy PCM devices.");
 MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_PCM);
 MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_PCM1);
-- 
2.9.2
