From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1200/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:26:00 +0800
Message-ID: <20160802122600.30190-1-baolex.ni@intel.com>
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
 sound/mips/sgio2audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index f07aa39..7c3815e 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -51,9 +51,9 @@ MODULE_SUPPORTED_DEVICE("{{Silicon Graphics, O2 Audio}}");
 static int index = SNDRV_DEFAULT_IDX1;  /* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;   /* ID for this card */
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for SGI O2 soundcard.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for SGI O2 soundcard.");
 
 
-- 
2.9.2
