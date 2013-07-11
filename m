From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v5 3/7] Documentation: DT: update atmel SSC with DMA binding
Date: Thu, 11 Jul 2013 18:15:55 +0200
Message-ID: <1373559359-31607-4-git-send-email-richard.genoud@gmail.com>
References: <1373559359-31607-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373559359-31607-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Bo Shen <voice.shen@atmel.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: alsa-devel@alsa-project.org

As atmel-ssc can be used with DMA, the documentation should be updated.
Also, a configuration DMA example is given.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../devicetree/bindings/misc/atmel-ssc.txt         |   23 +++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index 38e51ad..a45ae08 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -7,9 +7,30 @@ Required properties:
 - reg: Should contain SSC registers location and length
 - interrupts: Should contain SSC interrupt
 
-Example:
+
+Required properties for devices compatible with "atmel,at91sam9g45-ssc":
+- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+  the memory interface and SSC DMA channel ID (for tx and rx).
+  See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
+- dma-names: Must be "tx", "rx".
+
+Examples:
+- PDC transfer:
 ssc0: ssc@fffbc000 {
 	compatible = "atmel,at91rm9200-ssc";
 	reg = <0xfffbc000 0x4000>;
 	interrupts = <14 4 5>;
 };
+
+- DMA transfer:
+ssc0: ssc@f0010000 {
+      compatible = "atmel,at91sam9g45-ssc";
+      reg = <0xf0010000 0x4000>;
+      interrupts = <28 4 5>;
+      dmas = <&dma0 1 13>,
+	     <&dma0 1 14>;
+      dma-names = "tx", "rx";
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
+      status = "disabled";
+};
-- 
1.7.10.4
