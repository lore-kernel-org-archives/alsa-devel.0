Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ED2C4708D
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Jan 2023 16:40:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10E2614845;
	Fri,  6 Jan 2023 17:39:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10E2614845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673023236;
	bh=yVWMvrwxBCA7+qZ9NUNyz+Aj9hDZKmIuifJLdQcfhg8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JLA1801em3ZeO/sZWMRmSXtN0KAE900bwq9fZ4ikONVGEA+lJZH023s09O4byKFLJ
	 d2Yr1hL7198MTcZ6K3cO3sOrVHtjCMrw8getGxVxED37e6BWIEy7Nr0FHuyYyB1ELj
	 /PnDrcLLWeQvDIFjOz7TDQSUHEZ/gC2EXiMlBcdU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5751F80570;
	Fri,  6 Jan 2023 17:38:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34EADF80571; Fri,  6 Jan 2023 17:38:16 +0100 (CET)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::231])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14656F8055B
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2023 17:38:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14656F8055B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=UadNlEan
Received: (Authenticated sender: herve.codina@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id 09A49100004;
 Fri,  6 Jan 2023 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1673023092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=za07u3am99m9O8qsvHnffjPQ4VUp9cGlF/y8sTJ/oEc=;
 b=UadNlEanFI/dCSWobeBNNUgZTNpR1IV9cLkljoUr2PkVozD+o5PLzlIoBwHHoO+hfsxV61
 mNS4MSLlKQOVaapHK/Tjw2PaoIqFEav7FASYVVCfGX92s0fML1812FKzOB06TTljJ2wrDG
 m2Mnl9EeQ7r911JAciuI82VlSfryiysDkNoCCFztBPjI+65HiEnzWWqgZ2m4Kx6ZqwmQyp
 XSx8cvseZqAnzWThjWSy0d0OO3F01rmUHVA2AeKSbSFWfaqi0NFvL9cO9g9uaYCOQ9BmMd
 11Gsi9Nt97tPS5mmzZd9t48iidHiua7ZVQUxuHLzBIVKGHrymMXBU7AJwSVrSg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 05/10] dt-bindings: soc: fsl: cpm_qe: Add QMC controller
Date: Fri,  6 Jan 2023 17:37:41 +0100
Message-Id: <20230106163746.439717-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230106163746.439717-1-herve.codina@bootlin.com>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add support for the QMC (QUICC Multichannel Controller)
available in some PowerQUICC SoC such as MPC885 or MPC866.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/soc/fsl/cpm_qe/fsl,qmc.yaml      | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
new file mode 100644
index 000000000000..caf71f3a3f3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PowerQUICC CPM QUICC Multichannel Controller (QMC)
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The QMC (QUICC Multichannel Controller) emulates up to 64 channels within
+  one serial controller using the same TDM physical interface routed from
+  TSA.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc885-scc-qmc
+          - fsl,mpc866-scc-qmc
+      - const: fsl,cpm1-scc-qmc
+
+  reg:
+    items:
+      - description: SCC (Serial communication controller) register base
+      - description: SCC parameter ram base
+      - description: Dual port ram base
+
+  reg-names:
+    items:
+      - const: scc_regs
+      - const: scc_pram
+      - const: dpram
+
+  interrupts:
+    description: SCC interrupt line in the CPM interrupt controller
+
+  fsl,cpm-command:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Cf. soc/fsl/cpm_qe/cpm.txt
+
+  tsa:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the TSA
+
+  tsa-cell-id:
+    enum: [1, 2, 3]
+    description: |
+      TSA cell ID (dt-bindings/soc/fsl-tsa.h defines these values)
+       - 1: SCC2
+       - 2: SCC3
+       - 3: SCC4
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#chan-cells':
+    const: 1
+
+patternProperties:
+  "^channel@([0-9]|[1-5][0-9]|6[0-3])$":
+    description:
+      A channel managed by this controller
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 63
+        description:
+          The channel number
+
+      fsl,mode:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum: [transparent, hdlc]
+        default: transparent
+        description: Operational mode
+
+      fsl,reverse-data:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The bit order as seen on the channels is reversed,
+          transmitting/receiving the MSB of each octet first.
+          This flag is used only in 'transparent' mode.
+
+      tx-ts-mask:
+        $ref: /schemas/types.yaml#/definitions/uint64
+        description:
+          Channel assigned Tx time-slots within the Tx time-slots routed
+          by the TSA to this cell.
+
+      rx-ts-mask:
+        $ref: /schemas/types.yaml#/definitions/uint64
+        description:
+          Channel assigned Rx time-slots within the Rx time-slots routed
+          by the TSA to this cell.
+
+    required:
+      - reg
+      - tx-ts-mask
+      - rx-ts-mask
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - tsa
+  - tsa-cell-id
+  - '#address-cells'
+  - '#size-cells'
+  - '#chan-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/fsl-tsa.h>
+
+    scc_qmc@a60 {
+        compatible = "fsl,mpc885-scc-qmc", "fsl,cpm1-scc-qmc";
+        reg = <0xa60 0x20>,
+              <0x3f00 0xc0>,
+              <0x2000 0x1000>;
+        reg-names = "scc_regs", "scc_pram", "dpram";
+        interrupts = <27>;
+        interrupt-parent = <&CPM_PIC>;
+        fsl,cpm-command = <0xc0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #chan-cells = <1>;
+
+        tsa = <&tsa>;
+        tsa-cell-id = <FSL_CPM_TSA_SCC4>;
+
+        channel@16 {
+            /* Ch16 : First 4 even TS from all routed from TSA */
+            reg = <16>;
+            fsl,mode = "transparent";
+            fsl,reverse-data;
+            tx-ts-mask = <0x00000000 0x000000AA>;
+            rx-ts-mask = <0x00000000 0x000000AA>;
+        };
+
+        channel@17 {
+            /* Ch17 : First 4 odd TS from all routed from TSA */
+            reg = <17>;
+            fsl,mode = "transparent";
+            fsl,reverse-data;
+            tx-ts-mask = <0x00000000 0x00000055>;
+            rx-ts-mask = <0x00000000 0x00000055>;
+        };
+
+        channel@19 {
+            /* Ch19 : 8 TS (TS 8..15) from all routed from TSA */
+            reg = <19>;
+            fsl,mode = "hdlc";
+            tx-ts-mask = <0x00000000 0x0000FF00>;
+            rx-ts-mask = <0x00000000 0x0000FF00>;
+        };
+    };
-- 
2.38.1

