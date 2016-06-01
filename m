From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 3/4] ARM: sun7i: Add mod1 clock nodes
Date: Wed,  1 Jun 2016 19:54:29 +0200
Message-ID: <20160601175430.11625-4-maxime.ripard@free-electrons.com>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andrea Venturi <ennesimamail.av@gmail.com>, Code Kipper <codekipper@gmail.com>, gianfranco@moddevices.com, =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

=46rom: Emilio L=C3=B3pez <emilio@elopez.com.ar>

This commit adds all the mod1 clocks available on A20 to its device
tree. This list was created by looking at the A20 user manual.

Signed-off-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 48 ++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i=
-a20.dtsi
index febdf4c72fb0..603fda5b7f94 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -366,9 +366,9 @@
 					<5>, <6>, <7>,
 					<8>, <10>;
 			clock-output-names =3D "apb0_codec", "apb0_spdif",
-				"apb0_ac97", "apb0_iis0", "apb0_iis1",
+				"apb0_ac97", "apb0_i2s0", "apb0_i2s1",
 				"apb0_pio", "apb0_ir0", "apb0_ir1",
-				"apb0_iis2", "apb0_keypad";
+				"apb0_i2s2", "apb0_keypad";
 		};
=20
 		apb1: clk@01c20058 {
@@ -518,6 +518,28 @@
 			clock-output-names =3D "ir1";
 		};
=20
+		i2s0_clk: clk@01c200b8 {
+			#clock-cells =3D <0>;
+			compatible =3D "allwinner,sun4i-a10-mod1-clk";
+			reg =3D <0x01c200b8 0x4>;
+			clocks =3D <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names =3D "i2s0";
+		};
+
+		ac97_clk: clk@01c200bc {
+			#clock-cells =3D <0>;
+			compatible =3D "allwinner,sun4i-a10-mod1-clk";
+			reg =3D <0x01c200bc 0x4>;
+			clocks =3D <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names =3D "ac97";
+		};
+
 		spdif_clk: clk@01c200c0 {
 			#clock-cells =3D <0>;
 			compatible =3D "allwinner,sun4i-a10-mod1-clk";
@@ -555,6 +577,28 @@
 			clock-output-names =3D "spi3";
 		};
=20
+		i2s1_clk: clk@01c200d8 {
+			#clock-cells =3D <0>;
+			compatible =3D "allwinner,sun4i-a10-mod1-clk";
+			reg =3D <0x01c200d8 0x4>;
+			clocks =3D <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names =3D "i2s1";
+		};
+
+		i2s2_clk: clk@01c200dc {
+			#clock-cells =3D <0>;
+			compatible =3D "allwinner,sun4i-a10-mod1-clk";
+			reg =3D <0x01c200dc 0x4>;
+			clocks =3D <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names =3D "i2s2";
+		};
+
 		dram_gates: clk@01c20100 {
 			#clock-cells =3D <1>;
 			compatible =3D "allwinner,sun4i-a10-dram-gates-clk";
--=20
2.8.3
