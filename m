From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v3 2/3] ASoC: zx-i2s: introduce pclk for zx2967
	family
Date: Wed,  8 Feb 2017 11:02:34 +0800
Message-ID: <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id CC31E266947
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 04:04:08 +0100 (CET)
Received: by mail-pf0-f176.google.com with SMTP id e4so38049107pfg.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Feb 2017 19:04:08 -0800 (PST)
In-Reply-To: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, baoyou.xie@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, perex@perex.cz, tiwai@suse.com, shawn.guo@linaro.org, vinod.koul@intel.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, mathieu.poirier@linaro.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

ZTE's zx2967 I2S controller driver introduces pclk, this
patch documents this fact.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
index 7e5aa6f..77390c0 100644
--- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
@@ -4,7 +4,7 @@ Required properties:
  - compatible : Must be "zte,zx296702-i2s"
  - reg : Must contain I2S core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
- - clock-names: "tx" for the clock to the I2S interface.
+ - clock-names: "wclk" for the wclk, "pclk" for the pclk to the I2S interface.
  - dmas: Pairs of phandle and specifier for the DMA channel that is used by
    the core. The core expects two dma channels for transmit.
  - dma-names : Must be "tx" and "rx"
@@ -15,13 +15,17 @@ please check:
 	* clock/clock-bindings.txt
 	* dma/dma.txt
 
+Please note that ZTE ZX296702 I2S controller driver is compatible for zx296702
+and zx296718, so compatible string might be set as follow:
+	"zte,zx296718-i2s", "zte,zx296702-i2s"
+
 Example:
 	i2s0: i2s0@0b005000 {
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
