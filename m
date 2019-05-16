From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: sound: Convert Allwinner SPDIF binding to YAML"
 to the asoc tree
Date: Thu, 16 May 2019 19:02:59 +0100 (BST)
Message-ID: <20190516180259.46AC9112929D@debutante.sirena.org.uk>
References: <706cb97ae45cc9edc49c8709b2189ed786d2c7db.1557993523.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <706cb97ae45cc9edc49c8709b2189ed786d2c7db.1557993523.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: sound: Convert Allwinner SPDIF binding to YAML

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 506c7f9b0612c46732aa74317f59a28d9477905b Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Thu, 16 May 2019 09:59:25 +0200
Subject: [PATCH] dt-bindings: sound: Convert Allwinner SPDIF binding to YAML

The Allwinner SoCs feature an SPDIF controller across multiple SoC
generations.

However, earlier generations were a bit simpler than the subsequent ones,
and for example would always have RX and TX capabilities, and no reset
lines.

In order to express this, let's create two YAML schemas instead of the free
form text we had before.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../sound/allwinner,sun4i-a10-spdif.yaml      | 101 ++++++++++++++++++
 .../bindings/sound/sunxi,sun4i-spdif.txt      |  42 --------
 2 files changed, 101 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
new file mode 100644
index 000000000000..5d72d48e923e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/allwinner,sun4i-a10-spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 S/PDIF Controller Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    oneOf:
+      - const: allwinner,sun4i-a10-spdif
+      - const: allwinner,sun6i-a31-spdif
+      - const: allwinner,sun8i-h3-spdif
+      - items:
+          - const: allwinner,sun8i-a83t-spdif
+          - const: allwinner,sun8i-h3-spdif
+      - items:
+          - const: allwinner,sun50i-a64-spdif
+          - const: allwinner,sun8i-h3-spdif
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
+      - const: spdif
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
+  # Even though it only applies to subschemas under the conditionals,
+  # not listing them here will trigger a warning because of the
+  # additionalsProperties set to false.
+  resets:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun6i-a31-spdif
+              - allwinner,sun8i-h3-spdif
+
+    then:
+      required:
+        - resets
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
+additionalProperties: false
+
+examples:
+  - |
+    spdif: spdif@1c21000 {
+        #sound-dai-cells = <0>;
+        compatible = "allwinner,sun4i-a10-spdif";
+        reg = <0x01c21000 0x40>;
+        interrupts = <13>;
+        clocks = <&apb0_gates 1>, <&spdif_clk>;
+        clock-names = "apb", "spdif";
+        dmas = <&dma 0 2>, <&dma 0 2>;
+        dma-names = "rx", "tx";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
deleted file mode 100644
index 0c64a209c2e9..000000000000
--- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
-
-The Allwinner S/PDIF audio block is a transceiver that allows the
-processor to receive and transmit digital audio via an coaxial cable or
-a fibre cable.
-For now only playback is supported.
-
-Required properties:
-
-  - compatible		: should be one of the following:
-    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
-    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
-    - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
-
-  - reg			: Offset and length of the register set for the device.
-
-  - interrupts		: Contains the spdif interrupt.
-
-  - dmas		: Generic dma devicetree binding as described in
-			  Documentation/devicetree/bindings/dma/dma.txt.
-
-  - dma-names		: Two dmas have to be defined, "tx" and "rx".
-
-  - clocks		: Contains an entry for each entry in clock-names.
-
-  - clock-names		: Includes the following entries:
-	"apb"		  clock for the spdif bus.
-	"spdif"		  clock for spdif controller.
-
-  - resets		: reset specifier for the ahb reset (A31 and newer only)
-
-Example:
-
-spdif: spdif@1c21000 {
-	compatible = "allwinner,sun4i-a10-spdif";
-	reg = <0x01c21000 0x40>;
-	interrupts = <13>;
-	clocks = <&apb0_gates 1>, <&spdif_clk>;
-	clock-names = "apb", "spdif";
-	dmas = <&dma 0 2>, <&dma 0 2>;
-	dma-names = "rx", "tx";
-};
-- 
2.20.1
