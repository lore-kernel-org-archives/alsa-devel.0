From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 1/2] ASoC: cs42l52: Add support for platform
	data reset GPIO
Date: Thu, 24 Oct 2013 09:20:08 -0500
Message-ID: <1382624409-10419-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 18D382608CA
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 16:18:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for grabbing a reset GPIO from platform data and resetting the codec

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 include/sound/cs42l52.h    |  3 +++
 sound/soc/codecs/cs42l52.c | 25 ++++++++++++++++++++-----
 sound/soc/codecs/cs42l52.h |  2 +-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/sound/cs42l52.h b/include/sound/cs42l52.h
index a902e51..853df80 100644
--- a/include/sound/cs42l52.h
+++ b/include/sound/cs42l52.h
@@ -33,6 +33,9 @@ struct cs42l52_platform_data {
 
 	/* MCLK Freq */
 	unsigned int mclk_freq;
+	
+	/* !RST GPIO */
+	unsigned int reset_gpio;
 };
 
 #endif /* __CS42L52_H */
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index be2ba1b..6782d4875 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -1205,6 +1206,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 			     const struct i2c_device_id *id)
 {
 	struct cs42l52_private *cs42l52;
+	struct cs42l52_platform_data *pdata = dev_get_platdata(&i2c_client->dev);
 	int ret;
 	unsigned int devid = 0;
 	unsigned int reg;
@@ -1222,12 +1224,23 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
+	if (pdata)
+		cs42l52->pdata = *pdata;
+	
+	if ( cs42l52->pdata.reset_gpio) {
+		ret = gpio_request_one(cs42l52->pdata.reset_gpio,
+				       GPIOF_OUT_INIT_HIGH, "CS42L52 /RST");
+		if (ret < 0) {
+			dev_err(&i2c_client->dev, "Failed to request /RST %d: %d\n",
+				cs42l52->pdata.reset_gpio, ret);
+			return ret;
+		}
+		gpio_set_value_cansleep(cs42l52->pdata.reset_gpio, 0);
+		gpio_set_value_cansleep(cs42l52->pdata.reset_gpio, 1);
+	}
+	
 	i2c_set_clientdata(i2c_client, cs42l52);
-
-	if (dev_get_platdata(&i2c_client->dev))
-		memcpy(&cs42l52->pdata, dev_get_platdata(&i2c_client->dev),
-		       sizeof(cs42l52->pdata));
-
+	
 	ret = regmap_register_patch(cs42l52->regmap, cs42l52_threshold_patch,
 				    ARRAY_SIZE(cs42l52_threshold_patch));
 	if (ret != 0)
@@ -1243,6 +1256,8 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 			devid, CS42L52_CHIP_ID);
 		return ret;
 	}
+	dev_info(&i2c_client->dev,
+		 "Cirrus Logic CS42L52, Revision: %02X\n", reg & 0xFF);
 
 	regcache_cache_only(cs42l52->regmap, true);
 
diff --git a/sound/soc/codecs/cs42l52.h b/sound/soc/codecs/cs42l52.h
index 4277012..1a9412d 100644
--- a/sound/soc/codecs/cs42l52.h
+++ b/sound/soc/codecs/cs42l52.h
@@ -269,6 +269,6 @@
 #define CS42L52_FIX_BITS1			0x3E
 #define CS42L52_FIX_BITS2			0x47
 
-#define CS42L52_MAX_REGISTER			0x34
+#define CS42L52_MAX_REGISTER			0x47
 
 #endif
-- 
1.8.4.rc3
