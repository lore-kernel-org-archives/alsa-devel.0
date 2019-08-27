From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 2/5] dt-bindings: sound: Convert Allwinner A10 codec to a
 schema
Date: Tue, 27 Aug 2019 16:25:44 +0200
Message-ID: <20190827142547.14577-2-mripard@kernel.org>
References: <20190827142547.14577-1-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190827142547.14577-1-mripard@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The Allwinner SoCs have an embedded audio codec that is supported in Linux,
with a matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../sound/allwinner,sun4i-a10-codec.yaml      | 162 ++++++++++++++++++
 .../devicetree/bindings/sound/sun4i-codec.txt |  94 ----------
 2 files changed, 162 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
new file mode 100644
index 000000000000..44feefae0ef0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/allwinner,sun4i-a10-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 Codec Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - allwinner,sun4i-a10-codec
+      - allwinner,sun6i-a31-codec
+      - allwinner,sun7i-a20-codec
+      - allwinner,sun8i-a23-codec
+      - allwinner,sun8i-h3-codec
+      - allwinner,sun8i-v3s-codec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: apb
+      - const: codec
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  resets:
+    maxItems: 1
+
+  allwinner,audio-routing:
+    $ref: /schemas/types.yaml#definitions/non-unique-string-array
+    description: |-
+      A list of the connections between audio components.  Each entry
+      is a pair of strings, the first being the connection\'s sink, the
+      second being the connection\'s source. Valid names include
+
+        Audio pins on the SoC
+          HP
+          HPCOM
+          LINEIN    (not on sun8i-v3s)
+          LINEOUT   (not on sun8i-a23 or sun8i-v3s)
+          MIC1
+          MIC2      (not on sun8i-v3s)
+          MIC3      (only on sun6i-a31)
+
+        Microphone biases from the SoC
+          HBIAS
+          MBIAS     (not on sun8i-v3s)
+
+        Board connectors
+          Headphone
+          Headset Mic
+          Line In
+          Line Out
+          Mic
+          Speaker
+
+  allwinner,codec-analog-controls:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the codec analog controls in the PRCM
+
+  allwinner,pa-gpios:
+    description: GPIO to enable the external amplifier
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+if:
+  properties:
+    compatible:
+      enum:
+        - allwinner,sun6i-a31-codec
+        - allwinner,sun8i-a23-codec
+        - allwinner,sun8i-h3-codec
+        - allwinner,sun8i-v3s-codec
+
+then:
+  if:
+    properties:
+      compatible:
+        const: allwinner,sun6i-a31-codec
+
+  then:
+    required:
+      - resets
+      - allwinner,audio-routing
+
+  else:
+    required:
+      - resets
+      - allwinner,audio-routing
+      - allwinner,codec-analog-controls
+
+additionalProperties: false
+
+examples:
+  - |
+    codec@1c22c00 {
+        #sound-dai-cells = <0>;
+        compatible = "allwinner,sun7i-a20-codec";
+        reg = <0x01c22c00 0x40>;
+        interrupts = <0 30 4>;
+        clocks = <&apb0_gates 0>, <&codec_clk>;
+        clock-names = "apb", "codec";
+        dmas = <&dma 0 19>, <&dma 0 19>;
+        dma-names = "rx", "tx";
+    };
+
+  - |
+    codec@1c22c00 {
+        #sound-dai-cells = <0>;
+        compatible = "allwinner,sun6i-a31-codec";
+        reg = <0x01c22c00 0x98>;
+        interrupts = <0 29 4>;
+        clocks = <&ccu 61>, <&ccu 135>;
+        clock-names = "apb", "codec";
+        resets = <&ccu 42>;
+        dmas = <&dma 15>, <&dma 15>;
+        dma-names = "rx", "tx";
+        allwinner,audio-routing =
+            "Headphone", "HP",
+            "Speaker", "LINEOUT",
+            "LINEIN", "Line In",
+            "MIC1", "MBIAS",
+            "MIC1", "Mic",
+            "MIC2", "HBIAS",
+            "MIC2", "Headset Mic";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
deleted file mode 100644
index 66579bbd3294..000000000000
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-* Allwinner A10 Codec
-
-Required properties:
-- compatible: must be one of the following compatibles:
-		- "allwinner,sun4i-a10-codec"
-		- "allwinner,sun6i-a31-codec"
-		- "allwinner,sun7i-a20-codec"
-		- "allwinner,sun8i-a23-codec"
-		- "allwinner,sun8i-h3-codec"
-		- "allwinner,sun8i-v3s-codec"
-- reg: must contain the registers location and length
-- interrupts: must contain the codec interrupt
-- dmas: DMA channels for tx and rx dma. See the DMA client binding,
-	Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: should include "tx" and "rx".
-- clocks: a list of phandle + clock-specifer pairs, one for each entry
-  in clock-names.
-- clock-names: should contain the following:
-   - "apb": the parent APB clock for this controller
-   - "codec": the parent module clock
-
-Optional properties:
-- allwinner,pa-gpios: gpio to enable external amplifier
-
-Required properties for the following compatibles:
-		- "allwinner,sun6i-a31-codec"
-		- "allwinner,sun8i-a23-codec"
-		- "allwinner,sun8i-h3-codec"
-		- "allwinner,sun8i-v3s-codec"
-- resets: phandle to the reset control for this device
-- allwinner,audio-routing: A list of the connections between audio components.
-			   Each entry is a pair of strings, the first being the
-			   connection's sink, the second being the connection's
-			   source. Valid names include:
-
-			   Audio pins on the SoC:
-			   "HP"
-			   "HPCOM"
-			   "LINEIN"	(not on sun8i-v3s)
-			   "LINEOUT"	(not on sun8i-a23 or sun8i-v3s)
-			   "MIC1"
-			   "MIC2"	(not on sun8i-v3s)
-			   "MIC3"	(sun6i-a31 only)
-
-			   Microphone biases from the SoC:
-			   "HBIAS"
-			   "MBIAS"	(not on sun8i-v3s)
-
-			   Board connectors:
-			   "Headphone"
-			   "Headset Mic"
-			   "Line In"
-			   "Line Out"
-			   "Mic"
-			   "Speaker"
-
-Required properties for the following compatibles:
-		- "allwinner,sun8i-a23-codec"
-		- "allwinner,sun8i-h3-codec"
-		- "allwinner,sun8i-v3s-codec"
-- allwinner,codec-analog-controls: A phandle to the codec analog controls
-				   block in the PRCM.
-
-Example:
-codec: codec@1c22c00 {
-	#sound-dai-cells = <0>;
-	compatible = "allwinner,sun7i-a20-codec";
-	reg = <0x01c22c00 0x40>;
-	interrupts = <0 30 4>;
-	clocks = <&apb0_gates 0>, <&codec_clk>;
-	clock-names = "apb", "codec";
-	dmas = <&dma 0 19>, <&dma 0 19>;
-	dma-names = "rx", "tx";
-};
-
-codec: codec@1c22c00 {
-	#sound-dai-cells = <0>;
-	compatible = "allwinner,sun6i-a31-codec";
-	reg = <0x01c22c00 0x98>;
-	interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&ccu CLK_APB1_CODEC>, <&ccu CLK_CODEC>;
-	clock-names = "apb", "codec";
-	resets = <&ccu RST_APB1_CODEC>;
-	dmas = <&dma 15>, <&dma 15>;
-	dma-names = "rx", "tx";
-	allwinner,audio-routing =
-		"Headphone", "HP",
-		"Speaker", "LINEOUT",
-		"LINEIN", "Line In",
-		"MIC1",	"MBIAS",
-		"MIC1", "Mic",
-		"MIC2", "HBIAS",
-		"MIC2", "Headset Mic";
-};
-- 
2.21.0
