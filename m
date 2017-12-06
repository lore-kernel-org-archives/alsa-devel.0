From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Subject: [PATCH 30/45] sound: soc: hisilicon: remove duplicate includes
Date: Wed,  6 Dec 2017 23:09:00 +0530
Message-ID: <1512581940-6407-1-git-send-email-pravin.shedge4linux@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, broonie@kernel.org, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, pravin.shedge4linux@gmail.com
List-Id: alsa-devel@alsa-project.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 sound/soc/hisilicon/hi6210-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 0c8f86d..07a5720 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -36,7 +36,6 @@
 #include <linux/of_irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/reset-controller.h>
-#include <linux/clk.h>
 
 #include "hi6210-i2s.h"
 
-- 
2.7.4
