From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: add dt bindings for
	adau1977 audio codec" to the asoc tree
Date: Fri,  5 Oct 2018 14:25:00 +0100 (BST)
Message-ID: <20181005132500.A26F3112229A@debutante.sirena.org.uk>
References: <20181002120630.17799-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F17426783D
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 15:25:01 +0200 (CEST)
In-Reply-To: <20181002120630.17799-1-alexandru.ardelean@analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: add dt bindings for adau1977 audio codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d5a5dcd3f815c82e719fd6563f027673160f88e1 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Tue, 2 Oct 2018 15:06:30 +0300
Subject: [PATCH] ASoC: dt-bindings: add dt bindings for adau1977 audio codec

Add device-tree bindings documentation file for ADAU1977 audio codec.
This describes device-tree fields that are already supported by the driver.

The driver supports both I2C AND and SPI, and this doc covers both aspects
of the DT configuration.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
