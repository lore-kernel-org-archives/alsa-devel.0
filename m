From: Bogdan Togorean <bogdan.togorean@gmail.com>
Subject: [PATCH 1/2] ASoC: adau1977: Add MICBIAS example in DT bindings
Date: Tue, 19 Feb 2019 16:11:38 +0200
Message-ID: <20190219141139.24216-2-bogdan.togorean@gmail.com>
References: <20190219141139.24216-1-bogdan.togorean@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219141139.24216-1-bogdan.togorean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, tiwai@suse.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bogdan Togorean <bogdan.togorean@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add MICBIAS property to the optional devicetree bindings.

Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
---
 Documentation/devicetree/bindings/sound/adi,adau1977.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
index e79aeef73f28..87c16e6f2e7c 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1977.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
@@ -23,6 +23,12 @@ Optional properties:
  - DVDD-supply: supply voltage for the digital core, please consult
                 Documentation/devicetree/bindings/regulator/regulator.txt
 
+- adi,micbias: configures the voltage setting for the MICBIAS pin.
+		Select 0/1/2/3/4/5/6/7/8 to specify MICBIAS voltage
+		5V/5.5V/6V/6.5V/7V/7.5V/8V/8.5V/9V
+		If not specified the default value will be "7" meaning 8.5 Volts.
+		This property is only valid for the ADAU1977
+
 For required properties on SPI, please consult
 Documentation/devicetree/bindings/spi/spi-bus.txt
 
@@ -40,6 +46,7 @@ Examples:
 		AVDD-supply = <&regulator>;
 		DVDD-supply = <&regulator_digital>;
 
+		adi,micbias = <3>;
 		reset_gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
 	};
 
-- 
2.20.1
