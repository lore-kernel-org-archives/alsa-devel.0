From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: tpa6130a2: Use devm_* APIs
Date: Fri,  7 Dec 2012 16:32:26 +0530
Message-ID: <1354878146-28222-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5046A261654
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 12:09:22 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so365157pad.38
 for <alsa-devel@alsa-project.org>; Fri, 07 Dec 2012 03:09:21 -0800 (PST)
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
Cc: patches@linaro.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, sachin.kamat@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Converted to use devm_gpio_request and devm_regulator_get APIs.
These are device managed and make error handling and cleanup
a bit simpler.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Compile tested on for-next branch of following tree:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
---
 sound/soc/codecs/tpa6130a2.c |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 565ff39..ec78073 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -398,7 +398,8 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 						TPA6130A2_MUTE_L;
 
 	if (data->power_gpio >= 0) {
-		ret = gpio_request(data->power_gpio, "tpa6130a2 enable");
+		ret = devm_gpio_request(dev, data->power_gpio,
+					"tpa6130a2 enable");
 		if (ret < 0) {
 			dev_err(dev, "Failed to request power GPIO (%d)\n",
 				data->power_gpio);
@@ -419,16 +420,16 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 		break;
 	}
 
-	data->supply = regulator_get(dev, regulator);
+	data->supply = devm_regulator_get(dev, regulator);
 	if (IS_ERR(data->supply)) {
 		ret = PTR_ERR(data->supply);
 		dev_err(dev, "Failed to request supply: %d\n", ret);
-		goto err_regulator;
+		goto err_gpio;
 	}
 
 	ret = tpa6130a2_power(1);
 	if (ret != 0)
-		goto err_power;
+		goto err_gpio;
 
 
 	/* Read version */
@@ -440,15 +441,10 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 	/* Disable the chip */
 	ret = tpa6130a2_power(0);
 	if (ret != 0)
-		goto err_power;
+		goto err_gpio;
 
 	return 0;
 
-err_power:
-	regulator_put(data->supply);
-err_regulator:
-	if (data->power_gpio >= 0)
-		gpio_free(data->power_gpio);
 err_gpio:
 	tpa6130a2_client = NULL;
 
@@ -457,14 +453,7 @@ err_gpio:
 
 static int __devexit tpa6130a2_remove(struct i2c_client *client)
 {
-	struct tpa6130a2_data *data = i2c_get_clientdata(client);
-
 	tpa6130a2_power(0);
-
-	if (data->power_gpio >= 0)
-		gpio_free(data->power_gpio);
-
-	regulator_put(data->supply);
 	tpa6130a2_client = NULL;
 
 	return 0;
-- 
1.7.4.1
