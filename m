From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 1/3] ASoC: cs42l73: Add platform data support
	for cs42l73 codec
Date: Thu, 17 Oct 2013 11:03:33 -0500
Message-ID: <1382025815-7912-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 93FCA260307
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 18:01:39 +0200 (CEST)
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

Add support for RST GPIO and Charge Pump Freq in platform data

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 include/sound/cs42l73.h    | 22 ++++++++++++++++++++
 sound/soc/codecs/cs42l73.c | 51 ++++++++++++++++++++++++++++++----------------
 sound/soc/codecs/cs42l73.h |  1 +
 3 files changed, 56 insertions(+), 18 deletions(-)
 create mode 100644 include/sound/cs42l73.h

diff --git a/include/sound/cs42l73.h b/include/sound/cs42l73.h
new file mode 100644
index 0000000..f354be4
--- /dev/null
+++ b/include/sound/cs42l73.h
@@ -0,0 +1,22 @@
+/*
+ * linux/sound/cs42l73.h -- Platform data for CS42L73
+ *
+ * Copyright (c) 2012 Cirrus Logic Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CS42L73_H
+#define __CS42L73_H
+
+struct cs42l73_platform_data {
+	/* RST GPIO */
+	unsigned int reset_gpio;
+	unsigned int chgfreq;
+	int jack_detection;
+	unsigned int mclk_freq;
+};
+
+#endif /* __CS42L73_H */
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 3b20c86..dfdb715 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -28,6 +29,7 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <sound/cs42l73.h>
 #include "cs42l73.h"
 
 struct sp_config {
@@ -35,6 +37,7 @@ struct sp_config {
 	u32 srate;
 };
 struct  cs42l73_private {
+	struct cs42l73_platform_data pdata;
 	struct sp_config config[3];
 	struct regmap *regmap;
 	u32 sysclk;
@@ -310,15 +313,6 @@ static const struct soc_enum ng_delay_enum =
 	SOC_ENUM_SINGLE(CS42L73_NGCAB, 0,
 		ARRAY_SIZE(cs42l73_ng_delay_text), cs42l73_ng_delay_text);
 
-static const char * const charge_pump_freq_text[] = {
-	"0", "1", "2", "3", "4",
-	"5", "6", "7", "8", "9",
-	"10", "11", "12", "13", "14", "15" };
-
-static const struct soc_enum charge_pump_enum =
-	SOC_ENUM_SINGLE(CS42L73_CPFCHC, 4,
-		ARRAY_SIZE(charge_pump_freq_text), charge_pump_freq_text);
-
 static const char * const cs42l73_mono_mix_texts[] = {
 	"Left", "Right", "Mono Mix"};
 
@@ -511,8 +505,6 @@ static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
 	SOC_SINGLE("NG Threshold", CS42L73_NGCAB, 2, 7, 0),
 	SOC_ENUM("NG Delay", ng_delay_enum),
 
-	SOC_ENUM("Charge Pump Frequency", charge_pump_enum),
-
 	SOC_DOUBLE_R_TLV("XSP-IP Volume",
 			CS42L73_XSPAIPAA, CS42L73_XSPBIPBA, 0, 0x3F, 1,
 			attn_tlv),
@@ -1367,11 +1359,16 @@ static int cs42l73_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	regcache_cache_only(cs42l73->regmap, true);
-
 	cs42l73_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	cs42l73->mclksel = CS42L73_CLKID_MCLK1;	/* MCLK1 as master clk */
+	/* Set Charge Pump Frequency */
+	if (cs42l73->pdata.chgfreq)
+		snd_soc_update_bits(codec, CS42L73_CPFCHC,
+				    CS42L73_CHARGEPUMP_MASK,
+					cs42l73->pdata.chgfreq << 4);
+
+	/* MCLK1 as master clk */
+	cs42l73->mclksel = CS42L73_CLKID_MCLK1;
 	cs42l73->mclk = 0;
 
 	return ret;
@@ -1415,6 +1412,7 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 			     const struct i2c_device_id *id)
 {
 	struct cs42l73_private *cs42l73;
+	struct cs42l73_platform_data *pdata = dev_get_platdata(&i2c_client->dev);
 	int ret;
 	unsigned int devid = 0;
 	unsigned int reg;
@@ -1426,14 +1424,32 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 		return -ENOMEM;
 	}
 
-	i2c_set_clientdata(i2c_client, cs42l73);
-
 	cs42l73->regmap = devm_regmap_init_i2c(i2c_client, &cs42l73_regmap);
 	if (IS_ERR(cs42l73->regmap)) {
 		ret = PTR_ERR(cs42l73->regmap);
 		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
 		return ret;
 	}
+
+	if (pdata)
+		cs42l73->pdata = *pdata;
+
+	i2c_set_clientdata(i2c_client, cs42l73);
+
+	if (cs42l73->pdata.reset_gpio) {
+		ret = gpio_request_one(cs42l73->pdata.reset_gpio,
+				       GPIOF_OUT_INIT_HIGH, "CS42L73 /RST");
+		if (ret < 0) {
+			dev_err(&i2c_client->dev, "Failed to request /RST %d: %d\n",
+				cs42l73->pdata.reset_gpio, ret);
+			return ret;
+		}
+		gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 0);
+		gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 1);
+	}
+
+	regcache_cache_bypass(cs42l73->regmap, true);
+
 	/* initialize codec */
 	ret = regmap_read(cs42l73->regmap, CS42L73_DEVID_AB, &reg);
 	devid = (reg & 0xFF) << 12;
@@ -1444,7 +1460,6 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	ret = regmap_read(cs42l73->regmap, CS42L73_DEVID_E, &reg);
 	devid |= (reg & 0xF0) >> 4;
 
-
 	if (devid != CS42L73_DEVID) {
 		ret = -ENODEV;
 		dev_err(&i2c_client->dev,
@@ -1462,7 +1477,7 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	dev_info(&i2c_client->dev,
 		 "Cirrus Logic CS42L73, Revision: %02X\n", reg & 0xFF);
 
-	regcache_cache_only(cs42l73->regmap, true);
+	regcache_cache_bypass(cs42l73->regmap, false);
 
 	ret =  snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_dev_cs42l73, cs42l73_dai,
diff --git a/sound/soc/codecs/cs42l73.h b/sound/soc/codecs/cs42l73.h
index f30a4c4..4f83d39 100644
--- a/sound/soc/codecs/cs42l73.h
+++ b/sound/soc/codecs/cs42l73.h
@@ -159,6 +159,7 @@
 #define THMOVLD_115C		2
 #define THMOVLD_098C		3
 
+#define CS42L73_CHARGEPUMP_MASK	(0xF0)
 
 /* CS42L73_ASPC, CS42L73_XSPC, CS42L73_VSPC */
 #define	SP_3ST			(1 << 7)
-- 
1.8.4.rc3
