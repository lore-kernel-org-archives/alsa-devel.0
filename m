From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 2/2] ASoC: rt5677: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 16:23:02 +0100
Message-ID: <20161215152302.7939-2-clabbe.montjoie@gmail.com>
References: <20161215152302.7939-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161215152302.7939-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/rt5677-spi.c does not use any miscdevice so this patch
remove this unnecessary inclusion.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 sound/soc/codecs/rt5677-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index ebd0f7c..bd51f36 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -21,7 +21,6 @@
 #include <linux/gpio.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
-#include <linux/miscdevice.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_qos.h>
 #include <linux/sysfs.h>
-- 
2.10.2
