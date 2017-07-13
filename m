From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 4/9] ARM: dts: at91: sama5d2: add classd nodes
Date: Thu, 13 Jul 2017 09:49:22 +0200
Message-ID: <20170713074927.10882-5-quentin.schulz@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, cyrille.pitchen@wedev4u.fr, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds nodes for the classd device and its generated clock.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index cc06da394366..a564cd1ba327 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -494,6 +494,24 @@
 					clocks = <&plla>;
 				};
 
+				audio_pll_frac: audiopll_fracck {
+					compatible = "atmel,sama5d2-clk-audio-pll-frac";
+					#clock-cells = <0>;
+					clocks = <&main>;
+				};
+
+				audio_pll_pad: audiopll_padck {
+					compatible = "atmel,sama5d2-clk-audio-pll-pad";
+					#clock-cells = <0>;
+					clocks = <&audio_pll_frac>;
+				};
+
+				audio_pll_pmc: audiopll_pmcck {
+					compatible = "atmel,sama5d2-clk-audio-pll-pmc";
+					#clock-cells = <0>;
+					clocks = <&audio_pll_frac>;
+				};
+
 				utmi: utmick {
 					compatible = "atmel,at91sam9x5-clk-utmi";
 					#clock-cells = <0>;
@@ -895,7 +913,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					interrupt-parent = <&pmc>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>, <&audio_pll_pmc>;
 
 					sdmmc0_gclk: sdmmc0_gclk {
 						#clock-cells = <0>;
@@ -951,6 +969,12 @@
 						reg = <57>;
 						atmel,clk-output-range = <0 80000000>;
 					};
+
+					classd_gclk: classd_gclk {
+						#clock-cells = <0>;
+						reg = <59>;
+						atmel,clk-output-range = <0 100000000>;
+					};
 				};
 			};
 
@@ -1406,6 +1430,19 @@
 				status = "okay";
 			};
 
+			classd: classd@fc048000 {
+				compatible = "atmel,sama5d2-classd";
+				reg = <0xfc048000 0x100>;
+				interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(47))>;
+				dma-names = "tx";
+				clocks = <&classd_clk>, <&classd_gclk>;
+				clock-names = "pclk", "gclk";
+				status = "disabled";
+			};
+
 			can1: can@fc050000 {
 				compatible = "bosch,m_can";
 				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
-- 
2.11.0
