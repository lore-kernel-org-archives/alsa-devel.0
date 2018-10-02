From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] ASoC: dt-bindings: add dt bindings for
	adau1977 audio codec
Date: Tue, 2 Oct 2018 15:06:30 +0300
Message-ID: <20181002120630.17799-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730058.outbound.protection.outlook.com [40.107.73.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AD8C267819
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 14:10:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
List-Id: alsa-devel@alsa-project.org

Add device-tree bindings documentation file for ADAU1977 audio codec.
This describes device-tree fields that are already supported by the driver.

The driver supports both I2C AND and SPI, and this doc covers both aspects
of the DT configuration.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/sound/adi,adau1977.txt           | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
new file mode 100644
index 000000000000..e79aeef73f28
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
@@ -0,0 +1,54 @@
+Analog Devices ADAU1977/ADAU1978/ADAU1979
+
+Datasheets:
+http://www.analog.com/media/en/technical-documentation/data-sheets/ADAU1977.pdf
+http://www.analog.com/media/en/technical-documentation/data-sheets/ADAU1978.pdf
+http://www.analog.com/media/en/technical-documentation/data-sheets/ADAU1979.pdf
+
+This driver supports both the I2C and SPI bus.
+
+Required properties:
+ - compatible: Should contain one of the following:
+               "adi,adau1977"
+               "adi,adau1978"
+               "adi,adau1979"
+
+ - AVDD-supply: analog power supply for the device, please consult
+                Documentation/devicetree/bindings/regulator/regulator.txt
+
+Optional properties:
+ - reset-gpio:  the reset pin for the chip, for more details consult
+                Documentation/devicetree/bindings/gpio/gpio.txt
+
+ - DVDD-supply: supply voltage for the digital core, please consult
+                Documentation/devicetree/bindings/regulator/regulator.txt
+
+For required properties on SPI, please consult
+Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Required properties on I2C:
+
+ - reg:         The i2c address. Value depends on the state of ADDR0
+                and ADDR1, as wired in hardware.
+
+Examples:
+
+	adau1977_spi: adau1977@0 {
+		compatible = "adi,adau1977";
+		spi-max-frequency = <600000>;
+
+		AVDD-supply = <&regulator>;
+		DVDD-supply = <&regulator_digital>;
+
+		reset_gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
+	};
+
+	adau1977_i2c: adau1977@11 {
+		compatible = "adi,adau1977";
+		reg = <0x11>;
+
+		AVDD-supply = <&regulator>;
+		DVDD-supply = <&regulator_digital>;
+
+		reset_gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
+	};
-- 
2.17.1
