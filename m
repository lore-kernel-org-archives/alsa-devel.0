From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2] ASoC: tpa6130a2: Remove CPVSS and HPVdd
	supplies
Date: Wed, 19 May 2010 10:30:12 +0300
Message-ID: <1274254212-31786-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com
	[209.85.219.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 23DFB24560
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 09:30:18 +0200 (CEST)
Received: by ewy9 with SMTP id 9so2100240ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 00:30:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Ilkka Koskinen <ilkka.koskinen@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

These pins are for decoupling capacitors for the internal charge pumps
in TPA6130A2 and TPA6140A2 and not for connecting external supply.

Thanks to Eduardo Valentin <eduardo.valentin@nokia.com> for pointing out the
issue with TPA6130A2 and Ilkka Koskinen <ilkka.koskinen@nokia.com> with
TPA6140A2.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Reviewed-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
v2:
- I took freedom to add ack and reviewed by lines as Peter and Ilkka gave
  those to v1
- HPVdd for the TPA6140A2 is also removed as it's for decoupling capacitor
  as well
- No need to use regulator_bulk API as there s only single supply for both
  supported chips now
---
 sound/soc/codecs/tpa6130a2.c |   50 ++++++++++++++---------------------------
 1 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 221bb90..f9b3d6d 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -36,22 +36,11 @@
 
 static struct i2c_client *tpa6130a2_client;
 
-#define TPA6130A2_NUM_SUPPLIES 2
-static const char *tpa6130a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
-	"CPVSS",
-	"Vdd",
-};
-
-static const char *tpa6140a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
-	"HPVdd",
-	"AVdd",
-};
-
 /* This struct is used to save the context */
 struct tpa6130a2_data {
 	struct mutex mutex;
 	unsigned char regs[TPA6130A2_CACHEREGNUM];
-	struct regulator_bulk_data supplies[TPA6130A2_NUM_SUPPLIES];
+	struct regulator *supply;
 	int power_gpio;
 	unsigned char power_state;
 	enum tpa_model id;
@@ -136,11 +125,10 @@ static int tpa6130a2_power(int power)
 		if (data->power_gpio >= 0)
 			gpio_set_value(data->power_gpio, 1);
 
-		ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies),
-					    data->supplies);
+		ret = regulator_enable(data->supply);
 		if (ret != 0) {
 			dev_err(&tpa6130a2_client->dev,
-				"Failed to enable supplies: %d\n", ret);
+				"Failed to enable supply: %d\n", ret);
 			goto exit;
 		}
 
@@ -161,11 +149,10 @@ static int tpa6130a2_power(int power)
 		if (data->power_gpio >= 0)
 			gpio_set_value(data->power_gpio, 0);
 
-		ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies),
-					     data->supplies);
+		ret = regulator_disable(data->supply);
 		if (ret != 0) {
 			dev_err(&tpa6130a2_client->dev,
-				"Failed to disable supplies: %d\n", ret);
+				"Failed to disable supply: %d\n", ret);
 			goto exit;
 		}
 
@@ -412,6 +399,7 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 	struct device *dev;
 	struct tpa6130a2_data *data;
 	struct tpa6130a2_platform_data *pdata;
+	const char *regulator;
 	int i, ret;
 
 	dev = &client->dev;
@@ -454,25 +442,21 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 	}
 
 	switch (data->id) {
+	default:
+		dev_warn(dev, "Unknown TPA model (%d). Assuming 6130A2\n",
+			 pdata->id);
 	case TPA6130A2:
-		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
-			data->supplies[i].supply = tpa6130a2_supply_names[i];
+		regulator = "Vdd";
 		break;
 	case TPA6140A2:
-		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
-			data->supplies[i].supply = tpa6140a2_supply_names[i];;
+		regulator = "AVdd";
 		break;
-	default:
-		dev_warn(dev, "Unknown TPA model (%d). Assuming 6130A2\n",
-			 pdata->id);
-		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
-			data->supplies[i].supply = tpa6130a2_supply_names[i];
 	}
 
-	ret = regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
-				 data->supplies);
-	if (ret != 0) {
-		dev_err(dev, "Failed to request supplies: %d\n", ret);
+	data->supply = regulator_get(dev, regulator);
+	if (IS_ERR(data->supply)) {
+		ret = PTR_ERR(data->supply);
+		dev_err(dev, "Failed to request supply: %d\n", ret);
 		goto err_regulator;
 	}
 
@@ -495,7 +479,7 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 	return 0;
 
 err_power:
-	regulator_bulk_free(ARRAY_SIZE(data->supplies), data->supplies);
+	regulator_put(data->supply);
 err_regulator:
 	if (data->power_gpio >= 0)
 		gpio_free(data->power_gpio);
@@ -516,7 +500,7 @@ static int __devexit tpa6130a2_remove(struct i2c_client *client)
 	if (data->power_gpio >= 0)
 		gpio_free(data->power_gpio);
 
-	regulator_bulk_free(ARRAY_SIZE(data->supplies), data->supplies);
+	regulator_put(data->supply);
 
 	kfree(data);
 	tpa6130a2_client = NULL;
-- 
1.7.1
