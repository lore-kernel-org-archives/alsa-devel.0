From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] ASoC: atmel-i2s: add DT bindings for I2S controller
Date: Tue, 29 Sep 2015 16:09:19 +0200
Message-ID: <6a06f4e889b02ebfe42ebaa74022cd980fb66085.1443535188.git.cyrille.pitchen@atmel.com>
References: <cover.1443535188.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1443535188.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds DT bindings for the new Atmel I2S controller embedded
inside sama5d2x SoCs.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/sound/atmel-i2s.txt        | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
new file mode 100644
index 000000000000..83bc6b9070bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
@@ -0,0 +1,43 @@
+* Atmel I2S controller
+
+Required properties:
+- compatible:     Should be "atmel,sama5d2-i2s".
+- reg:            Should be the physical base address of the controller and the
+                  length of memory mapped region.
+- interrupts:     Should contain the interrupt for the controller.
+- dmas:           Should be a list of pairs of DMA controller phandle and flags.
+- dma-names:      Should be a list of DMA channel name among "rx", "tx" or
+                  "rx-tx".
+- clocks:         Should be a list of phandles of clocks used by the controller
+                  (1).
+- clock-names:    Should be a list matching the clocks phandles list:
+                  - "pclk" (peripheral clock) Required.
+                  - "gclk" (generated clock) Optional (1).
+                  - "aclk" (Audio PLL clock) Optional (1).
+
+Optional properties:
+- pinctrl-0:      Should specify pin control groups used for this controller.
+- princtrl-names: Should contain only one value - "default".
+
+
+(1) : Only the peripheral clock is required. The generated clock and the Audio
+      PLL clock are optional and should only be set together.
+
+Example:
+
+	i2s@f8050000 {
+		compatible = "atmel,sama5d2-i2s";
+		reg = <0xf8050000 0x300>;
+		interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(31))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(32))>;
+		dma-names = "tx", "rx";
+		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>;
+		clock-names = "pclk", "gclk", "aclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s0_default>;
+	};
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
