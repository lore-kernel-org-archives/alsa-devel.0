From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for I2S Multi-Channel Controller" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:43 +0000 (GMT)
Message-ID: <20190321150643.92D1B11288EC@debutante.sirena.org.uk>
References: <20190305112610.9641-1-codrin.ciubotariu@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305112610.9641-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@bootlin.com, Nicolas.Ferre@microchip.com, robh+dt@kernel.org, Ludovic.Desroches@microchip.combroonie@kernel.org, Codrin.Ciubotariu@microchip.com, Cristian.Birsan@microchip.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for I2S Multi-Channel Controller

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

>From 4c798984c0dcd7649a6ff8a3d64361ba896efe61 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 5 Mar 2019 11:26:42 +0000
Subject: [PATCH] ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for I2S
 Multi-Channel Controller

This patch adds DT bindings for the new Microchip I2S Multi-Channel
controller embedded inside sam9x60 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/mchp-i2s-mcc.txt           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt

diff --git a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
new file mode 100644
index 000000000000..91ec83a6faed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
@@ -0,0 +1,43 @@
+* Microchip I2S Multi-Channel Controller
+
+Required properties:
+- compatible:     Should be "microchip,sam9x60-i2smcc".
+- reg:            Should be the physical base address of the controller and the
+                  length of memory mapped region.
+- interrupts:     Should contain the interrupt for the controller.
+- dmas:           Should be one per channel name listed in the dma-names property,
+                  as described in atmel-dma.txt and dma.txt files.
+- dma-names:      Identifier string for each DMA request line in the dmas property.
+		  Two dmas have to be defined, "tx" and "rx".
+- clocks:         Must contain an entry for each entry in clock-names.
+                  Please refer to clock-bindings.txt.
+- clock-names:    Should be one of each entry matching the clocks phandles list:
+                  - "pclk" (peripheral clock) Required.
+                  - "gclk" (generated clock) Optional (1).
+
+Optional properties:
+- pinctrl-0:      Should specify pin control groups used for this controller.
+- princtrl-names: Should contain only one value - "default".
+
+
+(1) : Only the peripheral clock is required. The generated clock is optional
+      and should be set mostly when Master Mode is required.
+
+Example:
+
+	i2s@f001c000 {
+		compatible = "microchip,sam9x60-i2smcc";
+		reg = <0xf001c000 0x100>;
+		interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(36))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(37))>;
+		dma-names = "tx", "rx";
+		clocks = <&i2s_clk>, <&i2s_gclk>;
+		clock-names = "pclk", "gclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s_default>;
+	};
-- 
2.20.1
