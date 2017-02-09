From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v4 2/3] ASoC: zx-i2s: Add the info of pclk to the binding document for zx2967 family
Date: Thu,  9 Feb 2017 11:12:57 +0800
Message-ID: <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, baoyou.xie@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, perex@perex.cz, tiwai@suse.com, shawn.guo@linaro.org, vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, shawnguo@kernel.org, mathieu.poirier@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
List-Id: alsa-devel@alsa-project.org

ZTE's zx2967 I2S controller driver introduces pclk, this
patch documents this fact.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
index 7e5aa6f..292ad50 100644
--- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
@@ -1,10 +1,12 @@
 ZTE ZX296702 I2S controller
 
 Required properties:
- - compatible : Must be "zte,zx296702-i2s"
+ - compatible : Must be one of:
+	"zte,zx296718-i2s", "zte,zx296702-i2s"
+	"zte,zx296702-i2s"
  - reg : Must contain I2S core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
- - clock-names: "tx" for the clock to the I2S interface.
+ - clock-names: "wclk" for the wclk, "pclk" for the pclk to the I2S interface.
  - dmas: Pairs of phandle and specifier for the DMA channel that is used by
    the core. The core expects two dma channels for transmit.
  - dma-names : Must be "tx" and "rx"
@@ -16,12 +18,12 @@ please check:
 	* dma/dma.txt
 
 Example:
-	i2s0: i2s0@0b005000 {
+	i2s0: i2s@b005000 {
 		#sound-dai-cells = <0>;
-		compatible = "zte,zx296702-i2s";
+		compatible = "zte,zx296718-i2s", "zte,zx296702-i2s";
 		reg = <0x0b005000 0x1000>;
-		clocks = <&lsp0clk ZX296702_I2S0_DIV>;
-		clock-names = "tx";
+		clocks = <&audiocrm AUDIO_I2S0_WCLK>, <&audiocrm AUDIO_I2S0_PCLK>;
+		clock-names = "wclk", "pclk";
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&dma 5>, <&dma 6>;
 		dma-names = "tx", "rx";
-- 
2.7.4
