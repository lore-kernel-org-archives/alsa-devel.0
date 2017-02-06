From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v1 2/3] dt: Document for the ZTE zx296718 I2S controller
Date: Mon,  6 Feb 2017 21:50:19 +0800
Message-ID: <1486389020-29432-2-git-send-email-baoyou.xie@linaro.org>
References: <1486389020-29432-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486389020-29432-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-clk-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, baoyou.xie@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, perex@perex.cz, tiwai@suse.com, shawn.guo@linaro.org, vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, shawnguo@kernel.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
List-Id: alsa-devel@alsa-project.org

This patch documents the devicetree for the ZTE's zx296718
I2S audio controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
index 7e5aa6f..c405561 100644
--- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
@@ -1,10 +1,12 @@
 ZTE ZX296702 I2S controller
 
 Required properties:
- - compatible : Must be "zte,zx296702-i2s"
+ - compatible : Should include one of the following strings:
+	"zte,zx296702-i2s","zte,zx296718-i2s".
  - reg : Must contain I2S core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
- - clock-names: "tx" for the clock to the I2S interface.
+ - clock-names: "tx" for the wclk, "pclk" for the pclk to the I2S interface.
+	must contain pclk for zx296718 SoC.
  - dmas: Pairs of phandle and specifier for the DMA channel that is used by
    the core. The core expects two dma channels for transmit.
  - dma-names : Must be "tx" and "rx"
-- 
2.7.4

