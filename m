From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v6] ARM: DTS: imx5* imx6*, use imx51-ssi
Date: Mon, 20 Jan 2014 13:13:43 +0100
Message-ID: <1390220023-6423-1-git-send-email-mpa@pengutronix.de>
References: <20140118083840.GD3430@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id EFAFB2615FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 13:13:58 +0100 (CET)
In-Reply-To: <20140118083840.GD3430@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
reconfiguration and needs this for correct interaction with SDMA. This
patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
Hi Shawn,

Sorry for that last patch. I fixed it in this patch.

Thanks,

Markus

 arch/arm/boot/dts/imx50.dtsi   |  7 +++++--
 arch/arm/boot/dts/imx53.dtsi   | 10 +++++++---
 arch/arm/boot/dts/imx6qdl.dtsi | 12 +++++++++---
 arch/arm/boot/dts/imx6sl.dtsi  | 12 +++++++++---
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 01c0499..24df4f4f 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -140,7 +140,9 @@
 				};
 
 				ssi2: ssi@50014000 {
-					compatible = "fsl,imx50-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx50-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>;
@@ -445,7 +447,8 @@
 			};
 
 			ssi1: ssi@63fcc000 {
-				compatible = "fsl,imx50-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx50-ssi", "fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4dbde25..73e103b 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -171,7 +171,9 @@
 				};
 
 				ssi2: ssi@50014000 {
-					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx53-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>;
@@ -590,7 +592,8 @@
 			};
 
 			ssi1: ssi@63fcc000 {
-				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx53-ssi", "fsl,imx51-ssi",
+						"fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>;
@@ -617,7 +620,8 @@
 			};
 
 			ssi3: ssi@63fe8000 {
-				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx53-ssi", "fsl,imx51-ssi",
+						"fsl,imx21-ssi";
 				reg = <0x63fe8000 0x4000>;
 				interrupts = <96>;
 				clocks = <&clks IMX5_CLK_SSI3_IPG_GATE>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 8a86502..cf7956e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -247,7 +247,9 @@
 				};
 
 				ssi1: ssi@02028000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 178>;
@@ -260,7 +262,9 @@
 				};
 
 				ssi2: ssi@0202c000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 179>;
@@ -273,7 +277,9 @@
 				};
 
 				ssi3: ssi@02030000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 180>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a449c4f..95bb37b 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -226,7 +226,9 @@
 				};
 
 				ssi1: ssi@02028000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
@@ -238,7 +240,9 @@
 				};
 
 				ssi2: ssi@0202c000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
@@ -250,7 +254,9 @@
 				};
 
 				ssi3: ssi@02030000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
-- 
1.8.5.2
