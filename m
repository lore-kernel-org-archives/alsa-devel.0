From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH RESEND v2 1/4] ASoC: cs42l52: Add platform data
	for reset gpio
Date: Fri, 25 Oct 2013 10:01:14 -0500
Message-ID: <1382713277-10306-2-git-send-email-brian.austin@cirrus.com>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DFB226562E
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 16:59:06 +0200 (CEST)
In-Reply-To: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
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

This patch adds platform data support for a reset GPIO.
Also uses reset_gpio to toggle reset of the CODEC

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 include/sound/cs42l52.h    |  2 ++
 sound/soc/codecs/cs42l52.c | 21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/sound/cs42l52.h b/include/sound/cs42l52.h
index 4c68955..7c2be4a 100644
--- a/include/sound/cs42l52.h
+++ b/include/sound/cs42l52.h
@@ -31,6 +31,8 @@ struct cs42l52_platform_data {
 	/* Charge Pump Freq. Check datasheet Pg73 */
 	unsigned int chgfreq;
 
+	/* Reset GPIO */
+	unsigned int reset_gpio;
 };
 
 #endif /* __CS42L52_H */
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index be2ba1b..8367f3c 100644
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
@@ -1222,11 +1224,22 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	i2c_set_clientdata(i2c_client, cs42l52);
+	if (pdata)
+		cs42l52->pdata = *pdata;
 
-	if (dev_get_platdata(&i2c_client->dev))
-		memcpy(&cs42l52->pdata, dev_get_platdata(&i2c_client->dev),
-		       sizeof(cs42l52->pdata));
+	if (cs42l52->pdata.reset_gpio) {
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
+	i2c_set_clientdata(i2c_client, cs42l52);
 
 	ret = regmap_register_patch(cs42l52->regmap, cs42l52_threshold_patch,
 				    ARRAY_SIZE(cs42l52_threshold_patch));
-- 
1.8.4.rc3
