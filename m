From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 4/4] ASoC: tlv320aic3x: Add basic regulator
	support
Date: Mon, 26 Apr 2010 15:49:14 +0300
Message-ID: <1272286154-28392-4-git-send-email-jhnikula@gmail.com>
References: <1272286154-28392-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id C6D8C10381D
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 14:48:45 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 5so117408eyb.16
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 05:48:45 -0700 (PDT)
In-Reply-To: <1272286154-28392-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the TLV320AIC3x supplies and enables all of them for the
entire lifetime of the device.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

---

TODO:
In theory it should be possible to cut analogue powers of the codec while
it is idle or suspended but experimenting with this showed that e.g. HP
outputs were more silent after ramping up than they were before cutting the
analogue powers.
It seems that some sort of workaround might be needed for recovering.

I don't have a hardware test with digital power domain gating so now all
the supplies are grouped together and they are kept on always.
---
 sound/soc/codecs/tlv320aic3x.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d8f1b86..b2c2794 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regulator/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -50,9 +51,18 @@
 
 #include "tlv320aic3x.h"
 
+#define AIC3X_NUM_SUPPLIES	4
+static const char *aic3x_supply_names[AIC3X_NUM_SUPPLIES] = {
+	"IOVDD",	/* I/O Voltage */
+	"DVDD",		/* Digital Core Voltage */
+	"AVDD",		/* Analog DAC Voltage */
+	"DRVDD",	/* ADC Analog and Output Driver Voltage */
+};
+
 /* codec private data */
 struct aic3x_priv {
 	struct snd_soc_codec codec;
+	struct regulator_bulk_data supplies[AIC3X_NUM_SUPPLIES];
 	unsigned int sysclk;
 	int master;
 };
@@ -1269,6 +1279,9 @@ static int aic3x_unregister(struct aic3x_priv *aic3x)
 	snd_soc_unregister_dai(&aic3x_dai);
 	snd_soc_unregister_codec(&aic3x->codec);
 
+	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+
 	kfree(aic3x);
 	aic3x_codec = NULL;
 
@@ -1290,6 +1303,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 {
 	struct snd_soc_codec *codec;
 	struct aic3x_priv *aic3x;
+	int ret, i;
 
 	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
 	if (aic3x == NULL) {
@@ -1305,7 +1319,30 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, aic3x);
 
+	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
+		aic3x->supplies[i].supply = aic3x_supply_names[i];
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(aic3x->supplies),
+				 aic3x->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		goto err_get;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
+				    aic3x->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_enable;
+	}
+
 	return aic3x_register(codec);
+
+err_enable:
+	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+err_get:
+	kfree(aic3x);
+	return ret;
 }
 
 static int aic3x_i2c_remove(struct i2c_client *client)
-- 
1.7.0
