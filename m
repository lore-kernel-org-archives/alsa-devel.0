From: Markus Pargmann <mpa@pengutronix.de>
Subject: [RFC 9/9] ARM: DTS: imx5* imx6*, use imx50-ssi
Date: Fri, 15 Nov 2013 16:49:44 +0100
Message-ID: <1384530584-31273-10-git-send-email-mpa@pengutronix.de>
References: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 939E426531A
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 16:52:44 +0100 (CET)
In-Reply-To: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

imx50-ssi and imx21-ssi are different IPs. imx50-ssi supports online
reconfiguration and needs this for correct interaction with SDMA. Move
from imx21-ssi to imx50-ssi for all imx5/imx6 SoCs.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi   | 6 +++---
 arch/arm/boot/dts/imx53.dtsi   | 6 +++---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
 arch/arm/boot/dts/imx6sl.dtsi  | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 54cee65..22d4dbe 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -150,7 +150,7 @@
 				};
 
 				ssi2: ssi@70014000 {
-					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx51-ssi", "fsl,imx50-ssi";
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
@@ -427,7 +427,7 @@
 			};
 
 			ssi1: ssi@83fcc000 {
-				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx51-ssi", "fsl,imx50-ssi";
 				reg = <0x83fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks 48>;
@@ -479,7 +479,7 @@
 			};
 
 			ssi3: ssi@83fe8000 {
-				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx51-ssi", "fsl,imx50-ssi";
 				reg = <0x83fe8000 0x4000>;
 				interrupts = <96>;
 				clocks = <&clks 50>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..f1077f2 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -149,7 +149,7 @@
 				};
 
 				ssi2: ssi@50014000 {
-					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx53-ssi", "fsl,imx50-ssi";
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
@@ -1049,7 +1049,7 @@
 			};
 
 			ssi1: ssi@63fcc000 {
-				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx53-ssi", "fsl,imx50-ssi";
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks 48>;
@@ -1076,7 +1076,7 @@
 			};
 
 			ssi3: ssi@63fe8000 {
-				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx53-ssi", "fsl,imx50-ssi";
 				reg = <0x63fe8000 0x4000>;
 				interrupts = <96>;
 				clocks = <&clks 50>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ccd55c2..30d455e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -201,7 +201,7 @@
 				};
 
 				ssi1: ssi@02028000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi","fsl,imx50-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks 178>;
@@ -214,7 +214,7 @@
 				};
 
 				ssi2: ssi@0202c000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi","fsl,imx50-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks 179>;
@@ -227,7 +227,7 @@
 				};
 
 				ssi3: ssi@02030000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi","fsl,imx50-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks 180>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c46651e..1b19319 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -191,7 +191,7 @@
 				};
 
 				ssi1: ssi@02028000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi","fsl,imx50-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
@@ -203,7 +203,7 @@
 				};
 
 				ssi2: ssi@0202c000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi","fsl,imx50-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
@@ -215,7 +215,7 @@
 				};
 
 				ssi3: ssi@02030000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi","fsl,imx50-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
-- 
1.8.4.2
