From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1202/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:26:11 +0800
Message-ID: <20160802122611.30327-1-baolex.ni@intel.com>
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
 sound/oss/uart401.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/oss/uart401.c b/sound/oss/uart401.c
index dae4d43..a245eda 100644
--- a/sound/oss/uart401.c
+++ b/sound/oss/uart401.c
@@ -429,8 +429,8 @@ static struct address_info cfg_mpu;
 static int io = -1;
 static int irq = -1;
 
-module_param(io, int, 0444);
-module_param(irq, int, 0444);
+module_param(io, int, S_IRUSR | S_IRGRP | S_IROTH);
+module_param(irq, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 
 static int __init init_uart401(void)
-- 
2.9.2
