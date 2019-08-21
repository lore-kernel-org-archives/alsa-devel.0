From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 1/3] dt-bindings: dsp: fsl: Add DSP core binding support
Date: Wed, 21 Aug 2019 11:47:28 -0500
Message-ID: <20190821164730.7385-2-pierre-louis.bossart@linux.intel.com>
References: <20190821164730.7385-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821164730.7385-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, devicetree@vger.kernel.org, Xiubo.Lee@gmail.com, shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com, robh+dt@kernel.org, linux-imx@nxp.com, viorel.suman@nxp.com, festevam@gmail.com, Daniel Baluta <daniel.baluta@nxp.com>, Rob Herring <robh@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This describes the DSP device tree node.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
new file mode 100644
index 000000000000..3248595dc93c
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/fsl,dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8 DSP core
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+description: |
+  Some boards from i.MX8 family contain a DSP core used for
+  advanced pre- and post- audio processing.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-dsp
+
+  reg:
+    description: Should contain register location and length
+
+  clocks:
+    items:
+      - description: ipg clock
+      - description: ocram clock
+      - description: core clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ocram
+      - const: core
+
+  power-domains:
+    description:
+      List of phandle and PM domain specifier as documented in
+      Documentation/devicetree/bindings/power/power_domain.txt
+    maxItems: 4
+
+  mboxes:
+    description:
+      List of <&phandle type channel> - 2 channels for TXDB, 2 channels for RXDB
+      (see mailbox/fsl,mu.txt)
+    maxItems: 4
+
+  mbox-names:
+    items:
+      - const: txdb0
+      - const: txdb1
+      - const: rxdb0
+      - const: rxdb1
+
+  memory-region:
+    description:
+       phandle to a node describing reserved memory (System RAM memory)
+       used by DSP (see bindings/reserved-memory/reserved-memory.txt)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - mboxes
+  - mbox-names
+  - memory-region
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/clock/imx8-clock.h>
+    dsp@596e8000 {
+        compatible = "fsl,imx8qxp-dsp";
+        reg = <0x596e8000 0x88000>;
+        clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
+                 <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
+                 <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
+        clock-names = "ipg", "ocram", "core";
+        power-domains = <&pd IMX_SC_R_MU_13A>,
+                        <&pd IMX_SC_R_MU_13B>,
+                        <&pd IMX_SC_R_DSP>,
+                        <&pd IMX_SC_R_DSP_RAM>;
+        mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+        mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
+    };
-- 
2.20.1
