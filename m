From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1274/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:33:42 +0800
Message-ID: <20160802123342.2983-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, fabio.estevam@nxp.com, linus.walleij@linaro.org, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/sound_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 99b73c6..2c3c09c 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -154,7 +154,7 @@ static int preclaim_oss = 1;
 static int preclaim_oss = 0;
 #endif
 
-module_param(preclaim_oss, int, 0444);
+module_param(preclaim_oss, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 static int soundcore_open(struct inode *, struct file *);
 
-- 
2.9.2
