From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/2] ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to aclk
Date: Tue, 3 Jul 2018 17:56:31 +0300
Message-ID: <20180703145631.15246-3-codrin.ciubotariu@microchip.com>
References: <20180703145631.15246-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703145631.15246-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, robh+dt@kernel.org, broonie@kernel.org, quentin.schulz@bootlin.com
Cc: Cristian.Birsan@microchip.com
List-Id: alsa-devel@alsa-project.org

The optional clock phandle to aclk (Audio PLL clock) is no longer needed
by the driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 Documentation/devicetree/bindings/sound/atmel-i2s.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
index 735368b8a73f..40549f496a81 100644
--- a/Documentation/devicetree/bindings/sound/atmel-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
@@ -15,7 +15,6 @@ Required properties:
 - clock-names:    Should be one of each entry matching the clocks phandles list:
                   - "pclk" (peripheral clock) Required.
                   - "gclk" (generated clock) Optional (1).
-                  - "aclk" (Audio PLL clock) Optional (1).
                   - "muxclk" (I2S mux clock) Optional (1).
 
 Optional properties:
@@ -23,9 +22,9 @@ Optional properties:
 - princtrl-names: Should contain only one value - "default".
 
 
-(1) : Only the peripheral clock is required. The generated clock, the Audio
-      PLL clock adn the I2S mux clock are optional and should only be set
-      together, when Master Mode is required.
+(1) : Only the peripheral clock is required. The generated clock and the I2S
+      mux clock are optional and should only be set together, when Master Mode
+      is required.
 
 Example:
 
@@ -40,8 +39,8 @@ Example:
 			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 			 AT91_XDMAC_DT_PERID(32))>;
 		dma-names = "tx", "rx";
-		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
-		clock-names = "pclk", "gclk", "aclk", "muxclk";
+		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&i2s0muxck>;
+		clock-names = "pclk", "gclk", "muxclk";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2s0_default>;
 	};
-- 
2.17.1
