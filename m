From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH v2 5/5] ASoC: adau17x1: Support platform data via DT
Date: Tue, 16 Feb 2016 13:56:45 +0100
Message-ID: <1455627405-18155-6-git-send-email-andire@axis.com>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455627405-18155-1-git-send-email-andire@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

Currently, it is only possible to configure HW-specific options to the
adau17x1 codecs by providing a platform data struct. With this patch,
it is possible to provide the same data via DT instead.

Signed-off-by: Andreas Irest=C3=A5l <andire@axis.com>
---
 .../devicetree/bindings/sound/adi,adau17x1.txt     |  31 +++++
 include/dt-bindings/sound/adau17x1.h               |  14 +++
 sound/soc/codecs/adau1761.c                        | 127 +++++++++++++=
++++++++
 sound/soc/codecs/adau1781.c                        |  48 ++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 include/dt-bindings/sound/adau17x1.h

diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt b=
/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
index 8dbce0e..6050602 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
@@ -13,6 +13,32 @@ Required properties:
  - reg:			The i2c address. Value depends on the state of ADDR0
 			and ADDR1, as wired in hardware.
=20
+Optional properties:
+
+ - adi,input-differential	bool to set if the input is differential
+ - adi,digital-microphone	bool to set if there is a digital microphone
+				connected to digmic/jackdet pin.
+ - adi,micbias-vg		Microphone bias voltage
+	MICBIAS_0_90_AVDD - 0.9 * AVDD
+	MICBIAS_0_65_AVDD - 0.65 * AVDD
+
+Optional properties (ADAU1361/ADAU1461/ADAU1761/ADAU1961 only)
+
+ - adi,jack-detection	If present, configures codec to use the digmic/j=
ackdet
+			pin for jack detection. must provide one of
+			JACKDETECT_ACTIVE_LO or JACKDETECT_ACTIVE_HI followed
+			by debounce time in ms, which must be 5, 10, 20, or 40.
+
+ - adi,lineout-mode	Set output mode of the lineout pins.
+ - adi,headphone-mode	Set output mode of the headphone pins.
+
+The output mode must be one of:
+	OUTPUT_MODE_HEADPHONE           - Headphone output
+	OUTPUT_MODE_HEADPHONE_CAPLESS   - Capless headphone output
+	OUTPUT_MODE_LINE                - Line output
+
+
+
 Examples:
 #include <dt-bindings/sound/adau17x1.h>
=20
@@ -20,5 +46,10 @@ Examples:
 		adau1361@38 {
 			compatible =3D "adi,adau1761";
 			reg =3D <0x38>;
+			input-differential;
+			jack-detection =3D <JACKDETECT_ACTIVE_LO 40>;
+			lineout-mode =3D <OUTPUT_MODE_LINE>;
+			headphone-mode =3D <OUTPUT_MODE_HEADPHONE>;
+			micbias-vg =3D <MICBIAS_0_90_AVDD>;
 		};
 	};
diff --git a/include/dt-bindings/sound/adau17x1.h b/include/dt-bindings=
/sound/adau17x1.h
new file mode 100644
index 0000000..3152019
--- /dev/null
+++ b/include/dt-bindings/sound/adau17x1.h
@@ -0,0 +1,14 @@
+#ifndef __DT_ADAU17X1_H
+#define __DT_ADAU17X1_H
+
+#define MICBIAS_0_90_AVDD		0
+#define MICBIAS_0_65_AVDD		1
+
+#define OUTPUT_MODE_HEADPHONE		0
+#define OUTPUT_MODE_HEADPHONE_CAPLESS	1
+#define OUTPUT_MODE_LINE		2
+
+#define JACKDETECT_ACTIVE_HI		0
+#define JACKDETECT_ACTIVE_LO		1
+
+#endif
diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 16fed36..caba102 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -18,6 +18,7 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/platform_data/adau17x1.h>
+#include <dt-bindings/sound/adau17x1.h>
=20
 #include "adau17x1.h"
 #include "adau1761.h"
@@ -709,6 +710,122 @@ static int adau1761_codec_probe(struct snd_soc_co=
dec *codec)
 	return 0;
 }
=20
+#ifdef CONFIG_OF
+static inline void adau1761_parse_of_outmode(struct device *dev,
+					    uint32_t of_val,
+					    enum adau1761_output_mode *mode)
+{
+	switch (of_val) {
+	case OUTPUT_MODE_HEADPHONE:
+		*mode =3D ADAU1761_OUTPUT_MODE_HEADPHONE;
+		break;
+	case OUTPUT_MODE_HEADPHONE_CAPLESS:
+		*mode =3D ADAU1761_OUTPUT_MODE_HEADPHONE_CAPLESS;
+		break;
+	case OUTPUT_MODE_LINE:
+		*mode =3D ADAU1761_OUTPUT_MODE_LINE;
+		break;
+	default:
+		dev_warn(dev, "Invalid output mode %d\n", of_val);
+		*mode =3D ADAU1761_OUTPUT_MODE_LINE;
+		break;
+	}
+}
+
+static void adau1761_pdata_from_of(struct device *dev,
+				   struct adau1761_platform_data *pdata)
+{
+	struct device_node *np =3D dev->of_node;
+	uint32_t val;
+	uint32_t debounce_pars[2];
+
+	pdata->input_differential =3D
+		of_property_read_bool(np, "adi,input-differential");
+
+	if (of_get_property(np, "adi,jack-detection", NULL)) {
+		pdata->digmic_jackdetect_pin_mode =3D
+			ADAU1761_DIGMIC_JACKDET_PIN_MODE_JACKDETECT;
+		if (!of_property_read_u32_array(np, "adi,jack-detection",
+						debounce_pars, 2)) {
+			pdata->jackdetect_active_low =3D
+				debounce_pars[0] =3D=3D JACKDETECT_ACTIVE_LO;
+			switch (debounce_pars[1]) {
+			case 5:
+				pdata->jackdetect_debounce_time =3D
+					ADAU1761_JACKDETECT_DEBOUNCE_5MS;
+				break;
+			case 10:
+				pdata->jackdetect_debounce_time =3D
+					ADAU1761_JACKDETECT_DEBOUNCE_10MS;
+				break;
+			case 20:
+				pdata->jackdetect_debounce_time =3D
+					ADAU1761_JACKDETECT_DEBOUNCE_20MS;
+				break;
+			case 40:
+				pdata->jackdetect_debounce_time =3D
+					ADAU1761_JACKDETECT_DEBOUNCE_40MS;
+				break;
+			default:
+				dev_warn(dev, "Invalid debounce_time %d\n",
+					debounce_pars[1]);
+				pdata->jackdetect_debounce_time =3D
+					ADAU1761_JACKDETECT_DEBOUNCE_40MS;
+				break;
+			}
+		} else if (!of_property_read_u32_array(np, "adi,jack-detection",
+						debounce_pars, 1)) {
+			dev_warn(dev, "Debounce time not provided\n");
+			pdata->jackdetect_active_low =3D
+				debounce_pars[0] =3D=3D JACKDETECT_ACTIVE_LO;
+		} else {
+			dev_warn(dev, "No jack detection settings found\n");
+			pdata->jackdetect_active_low =3D 0;
+			pdata->jackdetect_debounce_time =3D
+				ADAU1761_JACKDETECT_DEBOUNCE_40MS;
+		}
+	} else if (of_property_read_bool(np, "adi,digital-microphone")) {
+		pdata->digmic_jackdetect_pin_mode =3D
+			ADAU1761_DIGMIC_JACKDET_PIN_MODE_DIGMIC;
+	} else {
+		pdata->digmic_jackdetect_pin_mode =3D
+			ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE;
+	}
+
+	if (!of_property_read_u32(np, "adi,headphone-mode", &val))
+		adau1761_parse_of_outmode(dev, val, &pdata->headphone_mode);
+	else
+		pdata->headphone_mode =3D ADAU1761_OUTPUT_MODE_LINE;
+
+	if (!of_property_read_u32(np, "adi,lineout-mode", &val))
+		adau1761_parse_of_outmode(dev, val, &pdata->lineout_mode);
+	else
+		pdata->lineout_mode =3D ADAU1761_OUTPUT_MODE_LINE;
+
+	if (!of_property_read_u32(np, "adi,micbias-vg", &val)) {
+		switch (val) {
+		case MICBIAS_0_65_AVDD:
+			pdata->micbias_voltage =3D ADAU17X1_MICBIAS_0_65_AVDD;
+			break;
+		case MICBIAS_0_90_AVDD:
+			pdata->micbias_voltage =3D ADAU17X1_MICBIAS_0_90_AVDD;
+			break;
+		default:
+			dev_warn(dev, "Invalid micbias voltage setting\n");
+			pdata->micbias_voltage =3D ADAU17X1_MICBIAS_0_90_AVDD;
+			break;
+		}
+	} else {
+		pdata->micbias_voltage =3D ADAU17X1_MICBIAS_0_90_AVDD;
+	}
+}
+#else
+static void adau1761_pdata_from_of(struct device *dev,
+				   struct adau1761_platform_data *pdata)
+{
+}
+#endif
+
 static const struct snd_soc_codec_driver adau1761_codec_driver =3D {
 	.probe =3D adau1761_codec_probe,
 	.resume	=3D adau17x1_resume,
@@ -768,6 +885,8 @@ int adau1761_probe(struct device *dev, struct regma=
p *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev))
 {
 	struct snd_soc_dai_driver *dai_drv;
+	struct adau1761_platform_data *of_pdata;
+	struct device_node *np =3D dev->of_node;
 	const char *firmware_name;
 	int ret;
=20
@@ -779,6 +898,14 @@ int adau1761_probe(struct device *dev, struct regm=
ap *regmap,
 		firmware_name =3D ADAU1761_FIRMWARE;
 	}
=20
+	if (!dev->platform_data && np) {
+		of_pdata =3D devm_kzalloc(dev, sizeof(*of_pdata), GFP_KERNEL);
+		if (!of_pdata)
+			return -ENOMEM;
+		adau1761_pdata_from_of(dev, of_pdata);
+		dev->platform_data =3D of_pdata;
+	}
+
 	ret =3D adau17x1_probe(dev, regmap, type, switch_mode, firmware_name)=
;
 	if (ret)
 		return ret;
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index bc1bb56..401220e 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -18,6 +18,7 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/platform_data/adau17x1.h>
+#include <dt-bindings/sound/adau17x1.h>
=20
 #include "adau17x1.h"
 #include "adau1781.h"
@@ -426,6 +427,43 @@ static int adau1781_codec_probe(struct snd_soc_cod=
ec *codec)
 	return 0;
 }
=20
+#ifdef CONFIG_OF
+static void adau1781_pdata_from_of(struct device *dev,
+				   struct adau1781_platform_data *pdata)
+{
+	struct device_node *np =3D dev->of_node;
+	uint32_t val;
+
+	val =3D of_property_read_bool(np, "adi,input-differential");
+	pdata->left_input_differential =3D val;
+	pdata->right_input_differential =3D val;
+
+	of_property_read_bool(np, "adi,digital-microphone");
+
+	if (!of_property_read_u32(np, "adi,micbias-vg", &val)) {
+		switch (val) {
+		case MICBIAS_0_65_AVDD:
+			pdata->micbias_voltage =3D ADAU17X1_MICBIAS_0_65_AVDD;
+			break;
+		case MICBIAS_0_90_AVDD:
+			pdata->micbias_voltage =3D ADAU17X1_MICBIAS_0_90_AVDD;
+			break;
+		default:
+			dev_warn(dev, "Invalid micbias voltage setting\n");
+			pdata->micbias_voltage =3D ADAU17X1_MICBIAS_0_90_AVDD;
+			break;
+		}
+	} else {
+		pdata->micbias_voltage =3D ADAU17X1_MICBIAS_0_90_AVDD;
+	}
+}
+#else
+static void adau1781_pdata_from_of(struct device *dev,
+				   struct adau1781_platform_data *pdata)
+{
+}
+#endif
+
 static const struct snd_soc_codec_driver adau1781_codec_driver =3D {
 	.probe =3D adau1781_codec_probe,
 	.resume =3D adau17x1_resume,
@@ -479,6 +517,8 @@ int adau1781_probe(struct device *dev, struct regma=
p *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev))
 {
 	const char *firmware_name;
+	struct adau1781_platform_data *of_pdata;
+	struct device_node *np =3D dev->of_node;
 	int ret;
=20
 	switch (type) {
@@ -492,6 +532,14 @@ int adau1781_probe(struct device *dev, struct regm=
ap *regmap,
 		return -EINVAL;
 	}
=20
+	if (!dev->platform_data && np) {
+		of_pdata =3D devm_kzalloc(dev, sizeof(*of_pdata), GFP_KERNEL);
+		if (!of_pdata)
+			return -ENOMEM;
+		adau1781_pdata_from_of(dev, of_pdata);
+		dev->platform_data =3D of_pdata;
+	}
+
 	ret =3D adau17x1_probe(dev, regmap, type, switch_mode, firmware_name)=
;
 	if (ret)
 		return ret;
--=20
2.1.4
