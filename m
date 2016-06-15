From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 1/4] ASoC: sunxi: Add A10 I2S controller binding documentation
Date: Wed, 15 Jun 2016 23:11:20 +0200
Message-ID: <20160615211123.31068-2-maxime.ripard@free-electrons.com>
References: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160615211123.31068-1-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrea Venturi <ennesimamail.av-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gianfranco-25KmuZRQ+wx0ubjbjo6WXg@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Introduce the device tree binding for the I2S controller found in the
Allwinner A10 and later SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 .../devicetree/bindings/sound/sun4i-i2s.txt        | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
new file mode 100644
index 000000000000..7b526ec64991
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -0,0 +1,34 @@
+* Allwinner A10 I2S controller
+
+The I2S bus (Inter-IC sound bus) is a serial link for digital
+audio data transfer between devices in the system.
+
+Required properties:
+
+- compatible: should be one of the followings
+   - "allwinner,sun4i-a10-i2s"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: should contain the I2S interrupt.
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should include "tx" and "rx".
+- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
+- clock-names: should contain followings:
+   - "apb" : clock for the I2S bus interface
+   - "mod" : module clock for the I2S controller
+- #sound-dai-cells : Must be equal to 0
+
+Example:
+
+i2s0: i2s@01c22400 {
+	#sound-dai-cells = <0>;
+	compatible = "allwinner,sun4i-a10-i2s";
+	reg = <0x01c22400 0x400>;
+	interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&apb0_gates 3>, <&i2s0_clk>;
+	clock-names = "apb", "mod";
+	dmas = <&dma SUN4I_DMA_NORMAL 3>,
+	       <&dma SUN4I_DMA_NORMAL 3>;
+	dma-names = "rx", "tx";
+};
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
