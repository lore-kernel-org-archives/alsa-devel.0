From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: wm8960: remove 'dres' field from
	platform data structure
Date: Thu, 20 Sep 2012 13:57:27 -0500
Message-ID: <1348167447-18489-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B32F265B88
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 20:57:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The 'dres' field (discharge resistance for headphone outputs) is no longer
used in the driver, so remove it.

It was used in the original version of the driver when entering standby
from off, but we stopped using it when we switched from having a single
startup sequence to having separate cap and capless sequences.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 include/sound/wm8960.h    |    2 --
 sound/soc/codecs/wm8960.c |    5 -----
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/include/sound/wm8960.h b/include/sound/wm8960.h
index b5a1ab9e..e8ce8ee 100644
--- a/include/sound/wm8960.h
+++ b/include/sound/wm8960.h
@@ -18,8 +18,6 @@
 struct wm8960_data {
 	bool capless;  /* Headphone outputs configured in capless mode */
 
-	int dres;  /* Discharge resistance for headphone outputs */
-
 	bool shared_lrclk;  /* DAC and ADC LRCLKs are wired together */
 };
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 782faa0..f0f6f660 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -962,11 +962,6 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 	if (!pdata) {
 		dev_warn(codec->dev, "No platform data supplied\n");
 	} else {
-		if (pdata->dres > WM8960_DRES_MAX) {
-			dev_err(codec->dev, "Invalid DRES: %d\n", pdata->dres);
-			pdata->dres = 0;
-		}
-
 		if (pdata->capless)
 			wm8960->set_bias_level = wm8960_set_bias_level_capless;
 	}
-- 
1.7.3.4
