From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/3] dt-bindings: sound: Add Xilinx logicPD-I2S FPGA IP
 bindings
Date: Fri, 30 Aug 2019 23:06:06 +0200
Message-ID: <20190830210607.22644-2-miquel.raynal@bootlin.com>
References: <20190830210607.22644-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190830210607.22644-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, alexandre@bootlin.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Document the logicPD I2S FPGA block bindings in yaml.

Syntax verified with dt-doc-validate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/sound/xlnx,logicpd-i2s.yaml      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml b/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml
new file mode 100644
index 000000000000..cbff641af199
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xlnx,logicpd-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device-Tree bindings for Xilinx logicPD I2S FPGA block
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+description: |
+  The IP supports I2S playback/capture audio. It acts as a slave and
+  clocks should come from the codec. It only supports two channels and
+  S16_LE format.
+
+properties:
+  compatible:
+    items:
+      - const: xlnx,logicpd-i2s
+
+  reg:
+    maxItems: 1
+    description:
+      Base address and size of the IP core instance.
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: tx interrupt
+      - description: rx interrupt
+    description:
+      Either the Tx interruption or the Rx interruption or both.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupts-controller
+
+examples:
+  - |
+    logii2s_dai: logii2s-dai@43c10000 {
+        reg = <0x43c10000 0x1000>;
+        compatible = "xlnx,logicpd-i2s-dai";
+        interrupt-parent = <&intc>;
+        interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>, <0 30 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "rx", "tx";
+    };
-- 
2.20.1
