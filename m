From: <ilkka.koskinen@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Remove CPVSS supply
Date: Wed, 19 May 2010 08:51:13 +0200
Message-ID: <F80267346F10C541946CBE8909F1C39E26E7BF8C34@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1274211085-20261-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DAE824527
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 08:51:33 +0200 (CEST)
In-Reply-To: <1274211085-20261-1-git-send-email-jhnikula@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jhnikula@gmail.com, alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


Hi,

On Tue, 18 May 2010, Jarkko Nikila wrote:
>I believe there is no need for the CPVSS supply as this pin is for
>decoupling capacitor for the internal charge pump.

Yes, you're right. I have a vague feeling that I put it there due to
some previous comments...

Anyway, I believe tpa6140's HPVdd is similar case and, thus, not
needed either. Would you like to make a patch for that or shall I do
it?

Cheers, Ilkka

>Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
>Cc: Ilkka Koskinen <ilkka.koskinen@nokia.com>
>---
> sound/soc/codecs/tpa6130a2.c |   40 
>+++++++++++++++++++++-------------------
> 1 files changed, 21 insertions(+), 19 deletions(-)
>
>diff --git a/sound/soc/codecs/tpa6130a2.c 
>b/sound/soc/codecs/tpa6130a2.c
>index 221bb90..87a5b09 100644
>--- a/sound/soc/codecs/tpa6130a2.c
>+++ b/sound/soc/codecs/tpa6130a2.c
>@@ -36,13 +36,14 @@
> 
> static struct i2c_client *tpa6130a2_client;
> 
>-#define TPA6130A2_NUM_SUPPLIES 2
>+#define TPA6130A2_NUM_SUPPLIES 1
>+#define TPA6140A2_NUM_SUPPLIES 2
>+#define TPA61x0A2_MAX_SUPPLIES 2
> static const char *tpa6130a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
>-	"CPVSS",
> 	"Vdd",
> };
> 
>-static const char *tpa6140a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
>+static const char *tpa6140a2_supply_names[TPA6140A2_NUM_SUPPLIES] = {
> 	"HPVdd",
> 	"AVdd",
> };
>@@ -51,7 +52,8 @@ static const char 
>*tpa6140a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
> struct tpa6130a2_data {
> 	struct mutex mutex;
> 	unsigned char regs[TPA6130A2_CACHEREGNUM];
>-	struct regulator_bulk_data supplies[TPA6130A2_NUM_SUPPLIES];
>+	struct regulator_bulk_data supplies[TPA61x0A2_MAX_SUPPLIES];
>+	int num_supplies;
> 	int power_gpio;
> 	unsigned char power_state;
> 	enum tpa_model id;
>@@ -136,7 +138,7 @@ static int tpa6130a2_power(int power)
> 		if (data->power_gpio >= 0)
> 			gpio_set_value(data->power_gpio, 1);
> 
>-		ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies),
>+		ret = regulator_bulk_enable(data->num_supplies,
> 					    data->supplies);
> 		if (ret != 0) {
> 			dev_err(&tpa6130a2_client->dev,
>@@ -161,7 +163,7 @@ static int tpa6130a2_power(int power)
> 		if (data->power_gpio >= 0)
> 			gpio_set_value(data->power_gpio, 0);
> 
>-		ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies),
>+		ret = regulator_bulk_disable(data->num_supplies,
> 					     data->supplies);
> 		if (ret != 0) {
> 			dev_err(&tpa6130a2_client->dev,
>@@ -412,6 +414,7 @@ static int __devinit 
>tpa6130a2_probe(struct i2c_client *client,
> 	struct device *dev;
> 	struct tpa6130a2_data *data;
> 	struct tpa6130a2_platform_data *pdata;
>+	const char **supply_names;
> 	int i, ret;
> 
> 	dev = &client->dev;
>@@ -454,23 +457,22 @@ static int __devinit 
>tpa6130a2_probe(struct i2c_client *client,
> 	}
> 
> 	switch (data->id) {
>+	default:
>+		dev_warn(dev, "Unknown TPA model (%d). Assuming 
>6130A2\n",
>+			 pdata->id);
> 	case TPA6130A2:
>-		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
>-			data->supplies[i].supply = 
>tpa6130a2_supply_names[i];
>+		data->num_supplies = TPA6130A2_NUM_SUPPLIES;
>+		supply_names = tpa6130a2_supply_names;
> 		break;
> 	case TPA6140A2:
>-		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
>-			data->supplies[i].supply = 
>tpa6140a2_supply_names[i];;
>+		data->num_supplies = TPA6140A2_NUM_SUPPLIES;
>+		supply_names = tpa6140a2_supply_names;
> 		break;
>-	default:
>-		dev_warn(dev, "Unknown TPA model (%d). Assuming 
>6130A2\n",
>-			 pdata->id);
>-		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
>-			data->supplies[i].supply = 
>tpa6130a2_supply_names[i];
> 	}
>+	for (i = 0; i < data->num_supplies; i++)
>+		data->supplies[i].supply = supply_names[i];
> 
>-	ret = regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
>-				 data->supplies);
>+	ret = regulator_bulk_get(dev, data->num_supplies, 
>data->supplies);
> 	if (ret != 0) {
> 		dev_err(dev, "Failed to request supplies: %d\n", ret);
> 		goto err_regulator;
>@@ -495,7 +497,7 @@ static int __devinit 
>tpa6130a2_probe(struct i2c_client *client,
> 	return 0;
> 
> err_power:
>-	regulator_bulk_free(ARRAY_SIZE(data->supplies), data->supplies);
>+	regulator_bulk_free(data->num_supplies, data->supplies);
> err_regulator:
> 	if (data->power_gpio >= 0)
> 		gpio_free(data->power_gpio);
>@@ -516,7 +518,7 @@ static int __devexit 
>tpa6130a2_remove(struct i2c_client *client)
> 	if (data->power_gpio >= 0)
> 		gpio_free(data->power_gpio);
> 
>-	regulator_bulk_free(ARRAY_SIZE(data->supplies), data->supplies);
>+	regulator_bulk_free(data->num_supplies, data->supplies);
> 
> 	kfree(data);
> 	tpa6130a2_client = NULL;
>-- 
>1.7.1
>
>
