From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: zoom2: Remove HS mux GPIO handling to
	avoid kernel crash due to BUG_ON()
Date: Mon, 3 Dec 2012 09:39:08 +0100
Message-ID: <1354523948-23835-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C97292615D9
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 09:39:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The machine driver try to use GPIO15 of twl4030 for HS MUX which supposed to
select between TWL's HSOL/R and tlv320aic3254's HPL/R.
The TWL's GPIO allocated dynamically so the (OMAP_MAX_GPIO_LINES + 15) is no
longer valid GPIO number causing a kernel crash due to BUG_ON()
Also the current machine driver supports only TWL audio currently: there is
no need to control the GPIO.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Liam, Mark,

I just got one zoom2 board and this patch is needed to get the board booting
when audio is enabled.
For 3.9 I will convert the machine driver to platform device/driver, but to get
3.8 kernel booting this patch is needed.

Regards,
Peter

 sound/soc/omap/zoom2.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 1ff6bb9..771bff2 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -37,8 +37,6 @@
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
 
-#define ZOOM2_HEADSET_MUX_GPIO		(OMAP_MAX_GPIO_LINES + 15)
-
 static int zoom2_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
@@ -187,9 +185,6 @@ static int __init zoom2_soc_init(void)
 	if (ret)
 		goto err1;
 
-	BUG_ON(gpio_request(ZOOM2_HEADSET_MUX_GPIO, "hs_mux") < 0);
-	gpio_direction_output(ZOOM2_HEADSET_MUX_GPIO, 0);
-
 	return 0;
 
 err1:
@@ -202,8 +197,6 @@ module_init(zoom2_soc_init);
 
 static void __exit zoom2_soc_exit(void)
 {
-	gpio_free(ZOOM2_HEADSET_MUX_GPIO);
-
 	platform_device_unregister(zoom2_snd_device);
 }
 module_exit(zoom2_soc_exit);
-- 
1.8.0
