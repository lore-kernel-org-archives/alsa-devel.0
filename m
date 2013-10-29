From: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: imx: use dual-fifo sdma script for ssi
Date: Tue, 29 Oct 2013 20:33:17 +0800
Message-ID: <730199f43b43b1ea5b4c2de88a67f659f7b4384b.1383047327.git.b42378@freescale.com>
References: <cover.1383047327.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1383047327.git.b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: timur-N01EOCouUvQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Use dual-fifo sdma scripts instead of shared scripts for ssi on i.MX series.

Signed-off-by: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/arm/boot/dts/imx51.dtsi   |  4 ++--
 arch/arm/boot/dts/imx53.dtsi   |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++++------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 54cee65..1a71eac 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -154,8 +154,8 @@
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
-					dmas = <&sdma 24 1 0>,
-					       <&sdma 25 1 0>;
+					dmas = <&sdma 24 22 0>,
+					       <&sdma 25 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..7208fde 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -153,8 +153,8 @@
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
-					dmas = <&sdma 24 1 0>,
-					       <&sdma 25 1 0>;
+					dmas = <&sdma 24 22 0>,
+					       <&sdma 25 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 57e9c38..6e096ca 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -223,8 +223,8 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks 178>;
-					dmas = <&sdma 37 1 0>,
-					       <&sdma 38 1 0>;
+					dmas = <&sdma 37 22 0>,
+					       <&sdma 38 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <38 37>;
@@ -236,8 +236,8 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks 179>;
-					dmas = <&sdma 41 1 0>,
-					       <&sdma 42 1 0>;
+					dmas = <&sdma 41 22 0>,
+					       <&sdma 42 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <42 41>;
@@ -249,8 +249,8 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks 180>;
-					dmas = <&sdma 45 1 0>,
-					       <&sdma 46 1 0>;
+					dmas = <&sdma 45 22 0>,
+					       <&sdma 46 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <46 45>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c46651e..b32ba99 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -195,8 +195,8 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
-					dmas = <&sdma 37 1 0>,
-					       <&sdma 38 1 0>;
+					dmas = <&sdma 37 22 0>,
+					       <&sdma 38 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
@@ -207,8 +207,8 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
-					dmas = <&sdma 41 1 0>,
-					       <&sdma 42 1 0>;
+					dmas = <&sdma 41 22 0>,
+					       <&sdma 42 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
@@ -219,8 +219,8 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
-					dmas = <&sdma 45 1 0>,
-					       <&sdma 46 1 0>;
+					dmas = <&sdma 45 22 0>,
+					       <&sdma 46 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
-- 
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
