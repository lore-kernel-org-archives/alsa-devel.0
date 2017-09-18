From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v11 1/2] ASoC: rt5514: Add devicetree binding support for rt5514-spi
Date: Mon, 18 Sep 2017 19:14:34 +0800
Message-ID: <20170918111435.11411-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: briannorris@chromium.org, broonie@kernel.org, mka@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: alsa-devel@alsa-project.org

Add devicetree binding support for rt5514 spi dsp codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v11:
Use same compatible for rt5514-i2c & rt5514-spi.

Changes in v10:
Put rt5514-i2c doc & rt5514-spi doc together.

Changes in v9:
Address comments from Brian.

 Documentation/devicetree/bindings/sound/rt5514.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
index 929ca6756b02..4f33b0d96afe 100644
--- a/Documentation/devicetree/bindings/sound/rt5514.txt
+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
@@ -1,22 +1,27 @@
 RT5514 audio CODEC
 
-This device supports I2C only.
+This device supports both I2C and SPI.
 
 Required properties:
 
 - compatible : "realtek,rt5514".
 
-- reg : The I2C address of the device.
+- reg : the I2C address of the device for I2C, the chip select
+        number for SPI.
 
 Optional properties:
 
 - clocks: The phandle of the master clock to the CODEC
 - clock-names: Should be "mclk"
 
+- interrupt-parent: The phandle for the interrupt controller.
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+	      depends on the interrupt controller.
+
 - realtek,dmic-init-delay-ms
-  Set the DMIC initial delay (ms) to wait it ready.
+  Set the DMIC initial delay (ms) to wait it ready for I2C.
 
-Pins on the device (for linking into audio routes) for RT5514:
+Pins on the device (for linking into audio routes) for I2C:
 
   * DMIC1L
   * DMIC1R
-- 
2.11.0
