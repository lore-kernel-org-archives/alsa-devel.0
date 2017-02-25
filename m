From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH 8/9] ARM: dts: sun8i: add audio codec support
	into V3s DTSI
Date: Sat, 25 Feb 2017 20:30:28 +0800
Message-ID: <20170225123029.55939-8-icenowy@aosc.xyz>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward10o.cmail.yandex.net (forward10o.cmail.yandex.net
 [37.9.109.60]) by alsa0.perex.cz (Postfix) with ESMTP id D5F1C2671C0
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 13:33:29 +0100 (CET)
In-Reply-To: <20170225123029.55939-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Allwinner V3s SoC features an internal audio codec like the one in H3,
and a analog codec like the one in H3/A23 (but much simpler).

Add them in the DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 7e0342976ba8..5fb6cb69f7bc 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -250,6 +250,25 @@
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		codec: codec@01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-v3s-codec";
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
+		codec_analog: codec-analog@01c23000 {
+			compatible = "allwinner,sun8i-v3s-codec-analog";
+			reg = <0x01c23000 0x4>;
+		};
+
 		uart0: serial@01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.11.1
