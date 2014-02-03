From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] devicetree: Add devicetree bindings documentation for the ADAU1977
Date: Mon,  3 Feb 2014 15:57:07 +0100
Message-ID: <1391439428-3198-1-git-send-email-lars@metafoo.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The ADAU1977 is a four channel audio ADC. It can either be connected to an I2C
or a SPI bus. Both bindings are described in this document. Other than the
standard I2C and SPI bus properties a regulator for the AVDD supply needs to be
specified in the bindings. Optionally, if present in the hardware design, a
regulator for the DVDD supply and a GPIO connected to the chips reset pin can be
specified. The bindings also allow to specify the microphone bias voltage that
should be used with the hardware design.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 .../devicetree/bindings/sound/adi,adau1977.txt     | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
new file mode 100644
index 0000000..3cf03d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
@@ -0,0 +1,58 @@
+Analog Devices ADAU1977, ADAU1978, ADAU1979 devicetree bindings
+
+The ADAU1977 is a four channel audio ADC. It can either be connected to an I2C
+or a SPI bus. Both bindings are described in this document. Depending on the bus
+type different properties must/can be specified.
+
+Shared required properties:
+ - compatible: Must be "adi,adau1977", "adi,adau1978" or adi,adau1979"
+ - AVDD-supply: A handle to the power supply connected to the AVDD pin
+
+Shared optional properties:
+ - DVDD-supply: A handle to the power supply connected to the DVDD pin. If
+   specified the internal LDO will be disabled.
+ - reset-gpios: GPIO chip handle and specifier that define which GPIO is
+   connected to the chips PD/RST pin. If not specified the reset pin is assumed
+   to be hardwired to VCC.
+ - adi,micbias: Configures the voltage setting for the MICBIAS pin. If not
+   specified the default value will be 8.5 Volts. This property is only valid
+   for the ADAU1977.
+   Valid values for this property are:
+	0: 5.0V
+	1: 5.5V
+	2: 6.0V
+	3: 6.5V
+	4: 7.0V
+	5: 7.5V
+	6: 8.0V
+	7: 8.5V
+	8: 9.0V
+
+I2C required properties:
+ - reg: The I2C address of the chip
+
+SPI required properties:
+ - reg: The SPI chipselect signal of the SPI master associated with this chip
+ - spi-max-frequency: Maximum spi frequency to use.
+
+Examples:
+
+&i2c_bus {
+	adau1977: codec@11 {
+		compatible = "adi,adau1977";
+		reg = <0x11>;
+		reset-gpios = <&gpio 5 0>;
+		AVDD-supply = <&codec_avdd_supply>;
+		DVDD-supply = <&codec_dvdd_supply>;
+	};
+};
+
+&spi_bus {
+	adau1977: codec@1 {
+		compatible = "adi,adau1977";
+		reg = <0x1>;
+		spi-max-frequency = <10000000>;
+		AVDD-supply = <&codec_avdd_supply>;
+		adi,micbias = <5>;
+	};
+};
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
