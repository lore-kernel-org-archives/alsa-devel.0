From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] ASoC: tlv320aic3x: Support for OCMV configuration
Date: Thu, 31 Aug 2017 11:49:47 +0300
Message-ID: <20170831084947.13793-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

=EF=BB=BFIn aic3x class of devices Output Common-Mode Voltage can be config=
ured for
better analog performance.
The OCMV value depends on the Analog and digital domain power supply
voltage configuration.

The default OCMV of 1.35V gives best performance when AVDD is around 2.7V
and DVDD is 1.525V, but for higher AVDD/DVDD higher OCMV setting is
recommended.

The patch gives an automatic way of guessing the best OCMV which can be
overwritten by a DT parameter if needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
Hi,

Change since v1:
- Correction for the lower supported voltage range (when OCMV would be set =
to
  1.35V)

Regards,
Peter
=20
 .../devicetree/bindings/sound/tlv320aic3x.txt      |  5 +++
 sound/soc/codecs/tlv320aic3x.c                     | 45 ++++++++++++++++++=
++++
 sound/soc/codecs/tlv320aic3x.h                     |  8 ++++
 3 files changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Docu=
mentation/devicetree/bindings/sound/tlv320aic3x.txt
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
 - AVDD-supply, IOVDD-supply, DRVDD-supply, DVDD-supply : power supplies fo=
r the
   device as covered in Documentation/devicetree/bindings/regulator/regulat=
or.txt
=20
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.=
c
index 405f4602888a..06f92571eba4 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -93,6 +93,8 @@ struct aic3x_priv {
=20
 	/* Selects the micbias voltage */
 	enum aic3x_micbias_voltage micbias_vg;
+	/* Output Common-Mode Voltage */
+	u8 ocmv;
 };
=20
 static const struct reg_default aic3x_reg[] =3D {
@@ -1572,6 +1574,10 @@ static int aic3x_init(struct snd_soc_codec *codec)
 		break;
 	}
=20
+	/*  Output common-mode voltage =3D 1.5 V */
+	snd_soc_update_bits(codec, HPOUT_SC, HPOUT_SC_OCMV_MASK,
+			    aic3x->ocmv << HPOUT_SC_OCMV_SHIFT);
+
 	return 0;
 }
=20
@@ -1699,6 +1705,43 @@ static const struct snd_soc_codec_driver soc_codec_d=
ev_aic3x =3D {
 	},
 };
=20
+static void aic3x_configure_ocmv(struct i2c_client *client)
+{
+	struct device_node *np =3D client->dev.of_node;
+	struct aic3x_priv *aic3x =3D i2c_get_clientdata(client);
+	u32 value;
+	int dvdd, avdd;
+
+	if (np && !of_property_read_u32(np, "ai3x-ocmv", &value)) {
+		/* OCMV setting is forced by DT */
+		if (value <=3D 3) {
+			aic3x->ocmv =3D value;
+			return;
+		}
+	}
+
+	dvdd =3D regulator_get_voltage(aic3x->supplies[1].consumer);
+	avdd =3D regulator_get_voltage(aic3x->supplies[2].consumer);
+
+	if (avdd > 3600000 || dvdd > 1950000) {
+		dev_warn(&client->dev,
+			 "Too high supply voltage(s) AVDD: %d, DVDD: %d\n",
+			 avdd, dvdd);
+	} else if (avdd =3D=3D 3600000 && dvdd =3D=3D 1950000) {
+		aic3x->ocmv =3D HPOUT_SC_OCMV_1_8V;
+	} else if (avdd > 3300000 && dvdd > 1800000) {
+		aic3x->ocmv =3D HPOUT_SC_OCMV_1_65V;
+	} else if (avdd > 3000000 && dvdd > 1650000) {
+		aic3x->ocmv =3D HPOUT_SC_OCMV_1_5V;
+	} else if (avdd >=3D 2700000 && dvdd >=3D 1525000) {
+		aic3x->ocmv =3D HPOUT_SC_OCMV_1_35V;
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
=20
+	aic3x_configure_ocmv(i2c);
+
 	if (aic3x->model =3D=3D AIC3X_MODEL_3007) {
 		ret =3D regmap_register_patch(aic3x->regmap, aic3007_class_d,
 					    ARRAY_SIZE(aic3007_class_d));
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.=
h
index 89fa692df206..34c35196aa0d 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -243,6 +243,14 @@
 #define MICBIAS_LEVEL_SHIFT	(6)
 #define MICBIAS_LEVEL_MASK	(3 << 6)
=20
+/* HPOUT_SC */
+#define HPOUT_SC_OCMV_MASK	(3 << 6)
+#define HPOUT_SC_OCMV_SHIFT	(6)
+#define HPOUT_SC_OCMV_1_35V	0
+#define HPOUT_SC_OCMV_1_5V	1
+#define HPOUT_SC_OCMV_1_65V	2
+#define HPOUT_SC_OCMV_1_8V	3
+
 /* headset detection / button API */
=20
 /* The AIC3x supports detection of stereo headsets (GND + left + right sig=
nal)
--=20
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
