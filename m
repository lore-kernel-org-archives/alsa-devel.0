From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH V6 08/10] ARM: dts: Modify SPI nodes according generic DMA DT
 bindings
Date: Fri, 18 Jan 2013 17:17:07 +0530
Message-ID: <1358509629-20471-9-git-send-email-padma.v@samsung.com>
References: <1358509629-20471-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1358509629-20471-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: padma.v@samsung.com, padma.kvr@gmail.com, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: sbkim73@samsung.com, broonie@opensource.wolfsonmicro.com, vinod.koul@intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, boojin.kim@samsung.com, kgene.kim@samsung.com, jassisinghbrar@gmail.com, thomas.abraham@linaro.org, lrg@ti.com, tiwai@suse.de, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

This patch removes custom way of adding spi dma channels and
adds according to new generic DMA DT bindings.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3aaa8ce..c6c69b2 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -217,8 +217,9 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d20000 0x100>;
 		interrupts = <0 66 0>;
-		tx-dma-channel = <&pdma0 5>; /* preliminary */
-		rx-dma-channel = <&pdma0 4>; /* preliminary */
+		dmas = <&pdma0 5
+			&pdma0 4>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -227,8 +228,9 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d30000 0x100>;
 		interrupts = <0 67 0>;
-		tx-dma-channel = <&pdma1 5>; /* preliminary */
-		rx-dma-channel = <&pdma1 4>; /* preliminary */
+		dmas = <&pdma1 5
+			&pdma1 4>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -237,8 +239,9 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d40000 0x100>;
 		interrupts = <0 68 0>;
-		tx-dma-channel = <&pdma0 7>; /* preliminary */
-		rx-dma-channel = <&pdma0 6>; /* preliminary */
+		dmas = <&pdma0 7
+			&pdma0 6>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
1.7.4.4
