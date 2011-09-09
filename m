From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: tpa6130a2: Remove obsolete cleanup for clientdata
Date: Fri, 09 Sep 2011 16:47:00 +0800
Message-ID: <1315558020.2332.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The i2c core will clear the clientdata pointer automatically,
we don't have to set the `data' field to NULL in remove() or
if probe() failed anymore.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tpa6130a2.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 239e0c4..b2572c4 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -446,7 +446,6 @@ err_regulator:
 		gpio_free(data->power_gpio);
 err_gpio:
 	kfree(data);
-	i2c_set_clientdata(tpa6130a2_client, NULL);
 	tpa6130a2_client = NULL;
 
 	return ret;
-- 
1.7.4.1
