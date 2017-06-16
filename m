From: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 1/2] dt-bindings: stm32: add h7 support for sai
Date: Fri, 16 Jun 2017 14:16:23 +0200
Message-ID: <1497615384-7407-2-git-send-email-olivier.moysan@st.com>
References: <1497615384-7407-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497615384-7407-1-git-send-email-olivier.moysan-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olivier.moysan-qxv4g6HH51o@public.gmane.org
Cc: arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Document device tree bindings for STM32H7 SAI.

Signed-off-by: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
---
 .../devicetree/bindings/sound/st,stm32-sai.txt         | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index a0feeed..f1c5ae5 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -6,7 +6,7 @@ The SAI contains two independent audio sub-blocks. Each sub-block has
 its own clock generator and I/O lines controller.
 
 Required properties:
-  - compatible: Should be "st,stm32f4-sai"
+  - compatible: Should be "st,stm32f4-sai" or "st,stm32h7-sai"
   - reg: Base address and size of SAI common register set.
   - clocks: Must contain phandle and clock specifier pairs for each entry
 	in clock-names.
@@ -47,24 +47,24 @@ sound_card {
 };
 
 sai1: sai1@40015800 {
-	compatible = "st,stm32f4-sai";
+	compatible = "st,stm32h7-sai";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0 0x40015800 0x400>;
 	reg = <0x40015800 0x4>;
-	clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
+	clocks = <&rcc PLL1_Q>, <&rcc PLL2_P>;
 	clock-names = "x8k", "x11k";
 	interrupts = <87>;
 
-	sai1b: audio-controller@40015824 {
-		compatible = "st,stm32-sai-sub-b";
-		reg = <0x24 0x1C>;
-		clocks = <&rcc 1 CLK_SAI2>;
+	sai1a: audio-controller@40015804 {
+		compatible = "st,stm32-sai-sub-a";
+		reg = <0x4 0x1C>;
+		clocks = <&rcc SAI1_CK>;
 		clock-names = "sai_ck";
-		dmas = <&dma2 5 0 0x400 0x0>;
+		dmas = <&dmamux1 1 87 0x400 0x0>;
 		dma-names = "tx";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sai1b>;
+		pinctrl-0 = <&pinctrl_sai1a>;
 
 		sai1b_port: port {
 			cpu_endpoint: endpoint {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
