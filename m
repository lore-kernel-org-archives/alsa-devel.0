From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] ASoC: wm0010: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 16:19:43 +0100
Message-ID: <20161215151943.5076-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/wm0010.c does not use any miscdevice so this patch
remove this unnecessary inclusion.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 sound/soc/codecs/wm0010.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 0eb5dcf..4f5f571 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -21,7 +21,6 @@
 #include <linux/firmware.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
-#include <linux/miscdevice.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mutex.h>
-- 
2.10.2
