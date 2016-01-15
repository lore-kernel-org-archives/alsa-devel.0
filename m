From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Subject: [PATCH 2/2] ASoC: fsl-mpc5200: Use usleep_range() instead of msleep()
Date: Fri, 15 Jan 2016 19:35:25 +0800
Message-ID: <1452857725-32414-3-git-send-email-lixiubo@cmss.chinamobile.com>
References: <1452857725-32414-1-git-send-email-lixiubo@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452857725-32414-1-git-send-email-lixiubo@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <lixiubo@cmss.chinamobile.com>
List-Id: alsa-devel@alsa-project.org

Since msleep() will sleep longer than intended time for values less
than 20ms, this patch allows the use of usleep_range for just 1ms.
usleep_range is a finer precision implementation of msleep and is
designed to be a drop-in replacement for udelay where a precise
sleep/busy-wait is unnecessary.

More details see Documentation/timers/timers-howto.txt.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
---
 sound/soc/fsl/mpc5200_psc_ac97.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 0bab760..243700c 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -13,6 +13,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
+#include <linux/time.h>
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -127,7 +128,7 @@ static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 
 	mutex_unlock(&psc_dma->mutex);
 
-	msleep(1);
+	usleep_range(1000, 2000);
 	psc_ac97_warm_reset(ac97);
 }
 
-- 
1.8.3.1
