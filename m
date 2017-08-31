From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: tlv320aic3x: Support for OCMV configuration" to the asoc tree
Date: Thu, 31 Aug 2017 10:30:16 +0100
Message-ID: <E1dnLnk-0004fD-Mr@debutante>
References: <20170831084947.13793-1-peter.ujfalusi@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170831084947.13793-1-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic3x: Support for OCMV configuration

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 19b0fa11bb1c0c24296c9f670a37c091bd3c815d Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Date: Thu, 31 Aug 2017 11:49:47 +0300
Subject: [PATCH] ASoC: tlv320aic3x: Support for OCMV configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

﻿In aic3x class of devices Output Common-Mode Voltage can be configured for
better analog performance.
The OCMV value depends on the Analog and digital domain power supply
voltage configuration.

The default OCMV of 1.35V gives best performance when AVDD is around 2.7V
and DVDD is 1.525V, but for higher AVDD/DVDD higher OCMV setting is
recommended.

The patch gives an automatic way of guessing the best OCMV which can be
overwritten by a DT parameter if needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/tlv320aic3x.txt      |  5 +++
 sound/soc/codecs/tlv320aic3x.c                     | 45 ++++++++++++++++++++++
 sound/soc/codecs/tlv320aic3x.h                     |  8 ++++
 3 files changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index 47a213c411ce..ba5b45c483f5 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -26,6 +26,11 @@ Optional properties:
 	3 - MICBIAS output is connected to AVDD,
 	If this node is not mentioned or if the value is incorrect, then MicBias
 	is powered down.
+- ai3x-ocmv - Output Common-Mode Voltage selection:
+	0 - 1.35V,
+	1 - 1.5V,
+	2 - 1.65V,
+	3 - 1.8V
 - AVDD-supply, IOVDD-supply, DRVDD-supply, DVDD-supply : power supplies for the
   device as covered in Documentation/devicetree/bindings/regulator/regulator.txt
 
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 29bf8c81ae02..ca880859f0c3 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -93,6 +93,8 @@ struct aic3x_priv {
 
 	/* Selects the micbias voltage */
 	enum aic3x_micbias_voltage micbias_vg;
+	/* Output Common-Mode Voltage */
+	u8 ocmv;
 };
 
 static const struct reg_default aic3x_reg[] = {
@@ -1572,6 +1574,10 @@ static int aic3x_init(struct snd_soc_codec *codec)
 		break;
 	}
 
+	/*  Output common-mode voltage = 1.5 V */
+	snd_soc_update_bits(codec, HPOUT_SC, HPOUT_SC_OCMV_MASK,
+			    aic3x->ocmv << HPOUT_SC_OCMV_SHIFT);
+
 	return 0;
 }
 
@@ -1699,6 +1705,43 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
 	},
 };
 
+static void aic3x_configure_ocmv(struct i2c_client *client)
+{
+	struct device_node *np = client->dev.of_node;
+	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
+	u32 value;
+	int dvdd, avdd;
+
+	if (np && !of_property_read_u32(np, "ai3x-ocmv", &value)) {
+		/* OCMV setting is forced by DT */
+		if (value <= 3) {
+			aic3x->ocmv = value;
+			return;
+		}
+	}
+
+	dvdd = regulator_get_voltage(aic3x->supplies[1].consumer);
+	avdd = regulator_get_voltage(aic3x->supplies[2].consumer);
+
+	if (avdd > 3600000 || dvdd > 1950000) {
+		dev_warn(&client->dev,
+			 "Too high supply voltage(s) AVDD: %d, DVDD: %d\n",
+			 avdd, dvdd);
+	} else if (avdd == 3600000 && dvdd == 1950000) {
+		aic3x->ocmv = HPOUT_SC_OCMV_1_8V;
+	} else if (avdd > 3300000 && dvdd > 1800000) {
+		aic3x->ocmv = HPOUT_SC_OCMV_1_65V;
+	} else if (avdd > 3000000 && dvdd > 1650000) {
+		aic3x->ocmv = HPOUT_SC_OCMV_1_5V;
+	} else if (avdd >= 2700000 && dvdd >= 1525000) {
+		aic3x->ocmv = HPOUT_SC_OCMV_1_35V;
+	} else {
+		dev_warn(&client->dev,
+			 "Invalid supply voltage(s) AVDD: %d, DVDD: %d\n",
+			 avdd, dvdd);
+	}
+}
+
 /*
  * AIC3X 2 wire address can be up to 4 devices with device addresses
  * 0x18, 0x19, 0x1A, 0x1B
@@ -1816,6 +1859,8 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		goto err_gpio;
 	}
 
+	aic3x_configure_ocmv(i2c);
+
 	if (aic3x->model == AIC3X_MODEL_3007) {
 		ret = regmap_register_patch(aic3x->regmap, aic3007_class_d,
 					    ARRAY_SIZE(aic3007_class_d));
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 89fa692df206..34c35196aa0d 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -243,6 +243,14 @@
 #define MICBIAS_LEVEL_SHIFT	(6)
 #define MICBIAS_LEVEL_MASK	(3 << 6)
 
+/* HPOUT_SC */
+#define HPOUT_SC_OCMV_MASK	(3 << 6)
+#define HPOUT_SC_OCMV_SHIFT	(6)
+#define HPOUT_SC_OCMV_1_35V	0
+#define HPOUT_SC_OCMV_1_5V	1
+#define HPOUT_SC_OCMV_1_65V	2
+#define HPOUT_SC_OCMV_1_8V	3
+
 /* headset detection / button API */
 
 /* The AIC3x supports detection of stereo headsets (GND + left + right signal)
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
