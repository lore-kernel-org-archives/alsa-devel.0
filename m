From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 7/8] ARM: dts: sun8i-h3: Add device nodes for audio codec
 and its analog controls
Date: Fri, 25 Nov 2016 20:34:41 +0800
Message-ID: <20161125123442.28410-8-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161125123442.28410-1-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Now that we support the audio codec found on the Allwinner H3 SoC, add
device nodes for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index fca66bf2dec5..496efc564bbe 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -465,6 +465,20 @@
 			status = "disabled";
 		};
 
+		codec: codec@01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-codec";
+			reg = <0x01c22c00 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "codec";
+			resets = <&ccu RST_BUS_CODEC>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			allwinner,codec-analog-controls = <&codec_analog>;
+			status = "disabled";
+		};
+
 		uart0: serial@01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
@@ -580,6 +594,11 @@
 			#reset-cells = <1>;
 		};
 
+		codec_analog: codec-analog@01f015c0 {
+			compatible = "allwinner,sun8i-h3-codec-analog";
+			reg = <0x01f015c0 0x4>;
+		};
+
 		ir: ir@01f02000 {
 			compatible = "allwinner,sun5i-a13-ir";
 			clocks = <&apb0_gates 1>, <&ir_clk>;
-- 
2.10.2
