From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/3] ARM: dts: imx: Add mclk0 clock for SAI
Date: Tue, 28 May 2019 13:21:00 +0000
Message-ID: <20190528132034.3908-2-daniel.baluta@nxp.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528132034.3908-1-daniel.baluta@nxp.com>
Content-Language: en-US
Content-ID: <20D3443DBB6CC84981BDDFDA2756471E@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Audio MCLK source option is selected with a 4:1 MUX
controller using MCLK Select bits in SAI xCR2 register.

On imx6/7 mclk0 and mclk1 always point to the same clock
source. Anyhow, this is no longer true for imx8.

For this reason, we need to add mclk0 and handle it
in a generic way in SAI driver.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 6 ++++--
 arch/arm/boot/dts/imx6ul.dtsi | 9 ++++++---
 arch/arm/boot/dts/imx7s.dtsi  | 9 ++++++---
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index b16a123990a2..682207b5d868 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1071,9 +1071,10 @@
 				reg =3D <0x021d4000 0x4000>;
 				interrupts =3D <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 				clocks =3D <&clks IMX6SX_CLK_SAI1_IPG>,
+					 <&clks IMX6SX_CLK_SAI1>,
 					 <&clks IMX6SX_CLK_SAI1>,
 					 <&clks 0>, <&clks 0>;
-				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 				dma-names =3D "rx", "tx";
 				dmas =3D <&sdma 31 24 0>, <&sdma 32 24 0>;
 				status =3D "disabled";
@@ -1090,9 +1091,10 @@
 				reg =3D <0x021dc000 0x4000>;
 				interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 				clocks =3D <&clks IMX6SX_CLK_SAI2_IPG>,
+					 <&clks IMX6SX_CLK_SAI2>,
 					 <&clks IMX6SX_CLK_SAI2>,
 					 <&clks 0>, <&clks 0>;
-				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 				dma-names =3D "rx", "tx";
 				dmas =3D <&sdma 33 24 0>, <&sdma 34 24 0>;
 				status =3D "disabled";
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index bbf010c73336..e9691306f557 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -304,9 +304,10 @@
 					reg =3D <0x02028000 0x4000>;
 					interrupts =3D <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX6UL_CLK_SAI1_IPG>,
+						 <&clks IMX6UL_CLK_SAI1>,
 						 <&clks IMX6UL_CLK_SAI1>,
 						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
-					clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+					clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 					dmas =3D <&sdma 35 24 0>,
 					       <&sdma 36 24 0>;
 					dma-names =3D "rx", "tx";
@@ -319,9 +320,10 @@
 					reg =3D <0x0202c000 0x4000>;
 					interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX6UL_CLK_SAI2_IPG>,
+						 <&clks IMX6UL_CLK_SAI2>,
 						 <&clks IMX6UL_CLK_SAI2>,
 						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
-					clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+					clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 					dmas =3D <&sdma 37 24 0>,
 					       <&sdma 38 24 0>;
 					dma-names =3D "rx", "tx";
@@ -334,9 +336,10 @@
 					reg =3D <0x02030000 0x4000>;
 					interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX6UL_CLK_SAI3_IPG>,
+						 <&clks IMX6UL_CLK_SAI3>,
 						 <&clks IMX6UL_CLK_SAI3>,
 						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
-					clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+					clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 					dmas =3D <&sdma 39 24 0>,
 					       <&sdma 40 24 0>;
 					dma-names =3D "rx", "tx";
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 106711d2c01b..c345a2e6d824 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -886,10 +886,11 @@
 					reg =3D <0x308a0000 0x10000>;
 					interrupts =3D <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX7D_SAI1_IPG_CLK>,
+						 <&clks IMX7D_SAI1_ROOT_CLK>,
 						 <&clks IMX7D_SAI1_ROOT_CLK>,
 						 <&clks IMX7D_CLK_DUMMY>,
 						 <&clks IMX7D_CLK_DUMMY>;
-					clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+					clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 					dma-names =3D "rx", "tx";
 					dmas =3D <&sdma 8 24 0>, <&sdma 9 24 0>;
 					status =3D "disabled";
@@ -901,10 +902,11 @@
 					reg =3D <0x308b0000 0x10000>;
 					interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX7D_SAI2_IPG_CLK>,
+						 <&clks IMX7D_SAI2_ROOT_CLK>,
 						 <&clks IMX7D_SAI2_ROOT_CLK>,
 						 <&clks IMX7D_CLK_DUMMY>,
 						 <&clks IMX7D_CLK_DUMMY>;
-					clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+					clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 					dma-names =3D "rx", "tx";
 					dmas =3D <&sdma 10 24 0>, <&sdma 11 24 0>;
 					status =3D "disabled";
@@ -916,10 +918,11 @@
 					reg =3D <0x308c0000 0x10000>;
 					interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX7D_SAI3_IPG_CLK>,
+						 <&clks IMX7D_SAI3_ROOT_CLK>,
 						 <&clks IMX7D_SAI3_ROOT_CLK>,
 						 <&clks IMX7D_CLK_DUMMY>,
 						 <&clks IMX7D_CLK_DUMMY>;
-					clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+					clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 					dma-names =3D "rx", "tx";
 					dmas =3D <&sdma 12 24 0>, <&sdma 13 24 0>;
 					status =3D "disabled";
--=20
2.17.1
