From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 6/7] ARM: DTS: da850: Add McBSP0 and McBSP1
Date: Mon, 18 Apr 2016 14:32:45 +0200
Message-ID: <1460982766-18632-7-git-send-email-petr@barix.com>
References: <1460982766-18632-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460982766-18632-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add SoC nodes for McBSP0 and McBSP1 as well as the corresponding pinmux
configurations.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
---
v1: initial
v2: add missing TC channel in dmas properties (for compatibility with the new EDMA3 binding)
    remove "-audio" postfix from the compatible string
v3: no change

 arch/arm/boot/dts/da850.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 5996e765e59c..708d48e1b6d1 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -148,7 +148,24 @@
 					0xc 0x88888888 0xffffffff
 				>;
 			};
-
+			mcbsp0_pins: pinmux_mcbsp0_pins {
+				pinctrl-single,bits = <
+					/* PINMUX2:
+					* CLKS0, DX0, DR0, FSX0
+					* FSR0, CLKX0, CLKR0
+					*/
+					0x8 0x02222220 0xfffffff0
+				>;
+			};
+			mcbsp1_pins: pinmux_mcbsp1_pins {
+				pinctrl-single,bits = <
+					/* PINMUX1:
+					* CLKS1, DX1, DR1, FSX1,
+					* FSR1, CLKX1, CLKR1
+					*/
+					0x4 0x22222220 0xfffffff0
+				>;
+			};
 		};
 		edma0: edma@01c00000 {
 			compatible = "ti,edma3-tpcc";
@@ -335,6 +352,32 @@
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 		};
+
+		mcbsp0: mcbsp@1d10000 {
+			compatible = "ti,da850-mcbsp";
+			reg =	<0x00110000 0x1000>,
+				<0x00310000 0x1000>;
+			reg-names = "mpu", "dat";
+			interrupts = <97 98>;
+			interrupts-names = "rx", "tx";
+			dmas = <&edma0 3 1
+				&edma0 2 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+		mcbsp1: mcbsp@1d11000 {
+			compatible = "ti,da850-mcbsp";
+			reg =	<0x00111000 0x1000>,
+				<0x00311000 0x1000>;
+			reg-names = "mpu", "dat";
+			interrupts = <99 100>;
+			interrupts-names = "rx", "tx";
+			dmas = <&edma0 5 1
+				&edma0 4 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 	};
 	nand_cs3@62000000 {
 		compatible = "ti,davinci-nand";
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
