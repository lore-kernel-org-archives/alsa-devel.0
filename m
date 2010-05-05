From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: tlv320aic3x: Add platform data and reset
	gpio handling
Date: Wed,  5 May 2010 11:13:20 +0300
Message-ID: <1273047200-5188-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com
	[209.85.219.222])
	by alsa0.perex.cz (Postfix) with ESMTP id B1917103843
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 10:12:13 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1566298ewy.17
	for <alsa-devel@alsa-project.org>; Wed, 05 May 2010 01:12:12 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/tlv320aic3x.h    |   17 +++++++++++++++++
 sound/soc/codecs/tlv320aic3x.c |   26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/tlv320aic3x.h

diff --git a/include/sound/tlv320aic3x.h b/include/sound/tlv320aic3x.h
new file mode 100644
index 0000000..e493a14
--- /dev/null
+++ b/include/sound/tlv320aic3x.h
@@ -0,0 +1,17 @@
+/*
+ * Platform data for Texas Instruments TLV320AIC3x codec
+ *
+ * Author: Jarkko Nikula <jhnikula@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __TLV320AIC3x_H__
+#define __TLV320AIC3x_H__
+
+struct aic3x_pdata {
+	int gpio_reset;
+};
+
+#endif
\ No newline at end of file
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b2c2794..cdcfb6b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -48,6 +49,7 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <sound/tlv320aic3x.h>
 
 #include "tlv320aic3x.h"
 
@@ -65,6 +67,7 @@ struct aic3x_priv {
 	struct regulator_bulk_data supplies[AIC3X_NUM_SUPPLIES];
 	unsigned int sysclk;
 	int master;
+	int gpio_reset;
 };
 
 /*
@@ -1279,6 +1282,10 @@ static int aic3x_unregister(struct aic3x_priv *aic3x)
 	snd_soc_unregister_dai(&aic3x_dai);
 	snd_soc_unregister_codec(&aic3x->codec);
 
+	if (aic3x->gpio_reset >= 0) {
+		gpio_set_value(aic3x->gpio_reset, 0);
+		gpio_free(aic3x->gpio_reset);
+	}
 	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 
@@ -1303,6 +1310,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 {
 	struct snd_soc_codec *codec;
 	struct aic3x_priv *aic3x;
+	struct aic3x_pdata *pdata = i2c->dev.platform_data;
 	int ret, i;
 
 	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
@@ -1319,6 +1327,15 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, aic3x);
 
+	aic3x->gpio_reset = -1;
+	if (pdata && pdata->gpio_reset >= 0) {
+		ret = gpio_request(pdata->gpio_reset, "tlv320aic3x reset");
+		if (ret != 0)
+			goto err_gpio;
+		aic3x->gpio_reset = pdata->gpio_reset;
+		gpio_direction_output(aic3x->gpio_reset, 0);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		aic3x->supplies[i].supply = aic3x_supply_names[i];
 
@@ -1336,11 +1353,20 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
+	if (aic3x->gpio_reset >= 0) {
+		udelay(1);
+		gpio_set_value(aic3x->gpio_reset, 1);
+	}
+
 	return aic3x_register(codec);
 
 err_enable:
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 err_get:
+	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+	if (aic3x->gpio_reset >= 0)
+		gpio_free(aic3x->gpio_reset);
+err_gpio:
 	kfree(aic3x);
 	return ret;
 }
-- 
1.7.0
