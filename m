Return-Path: <SRS0=Qkbk=MV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A23C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 17:25:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569F760EE6
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 17:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 569F760EE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEBBF1EFF;
	Thu, 29 Jul 2021 19:24:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEBBF1EFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627579510;
	bh=bjs3Jw6qHAd9N6D/Obk6PW4tgQiHtTZpXrl6bsvLrGM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JwUHeJc4t8omemYvazKdbiLMbVReuz5EjgRcHpp10naN96nTa/Xs/Ixtn8Si9D1d+
	 BMoS2H7HU5PBGEnBr4expUrGY4z8MDrIseLKdhvGfpTs+6mX+quLXQ8khpPFICxMB3
	 LUDRoXEnTcp5ydagpR2jAh+SqSVrQDsUMfu+OrRQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DC44F804AF;
	Thu, 29 Jul 2021 19:23:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 213E8F804C1; Thu, 29 Jul 2021 19:23:30 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id 9A70EF80258
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 19:23:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A70EF80258
X-IronPort-AV: E=Sophos;i="5.84,279,1620658800"; d="scan'208";a="89179390"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2021 02:23:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id CDE0C4016D49;
 Fri, 30 Jul 2021 02:23:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/3] ASoC: dt-bindings: Document RZ/G2L bindings
Date: Thu, 29 Jul 2021 18:23:09 +0100
Message-Id: <20210729172311.31111-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210729172311.31111-1-biju.das.jz@bp.renesas.com>
References: <20210729172311.31111-1-biju.das.jz@bp.renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Biju Das <biju.das@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Chris Brandt <chris.brandt@renesas.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Document RZ/G2L ASoC serial sound interface bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note:-
 This base series for this patch is Linux 5.14-rc2(or +) otherwise bots would 
 complain about check failure

v2->v3:
 * Merged the binding patch with dmas added
 * Updated dt binding example with encoded #dma-cells value.
v1->v2:
 * Rebased on 5.14-rc2.
---
 .../bindings/sound/renesas,rz-ssi.yaml        | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
new file mode 100644
index 000000000000..9923e7b8264f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/renesas,rz-ssi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L ASoC Sound Serial Interface (SSIF-2)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
+      - const: renesas,rz-ssi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: int_req
+      - const: dma_rx
+      - const: dma_tx
+      - const: dma_rt
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: ssi
+      - const: ssi_sfr
+      - const: audio_clk1
+      - const: audio_clk2
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    minItems: 1
+    maxItems: 2
+
+  dma-names:
+    oneOf:
+      - items:
+          - const: tx
+          - const: rx
+      - items:
+          - const: rt
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    ssi0: ssi@10049c00 {
+        compatible = "renesas,r9a07g044-ssi",
+                     "renesas,rz-ssi";
+            reg = <0x10049c00 0x400>;
+            interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+            clocks = <&cpg CPG_MOD R9A07G044_SSI0_PCLK2>,
+                     <&cpg CPG_MOD R9A07G044_SSI0_PCLK_SFR>,
+                     <&audio_clk1>,
+                     <&audio_clk2>;
+            clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+            power-domains = <&cpg>;
+            resets = <&cpg R9A07G044_SSI0_RST_M2_REG>;
+            dmas = <&dmac 0x2655>,
+                   <&dmac 0x2656>;
+            dma-names = "tx", "rx";
+            #sound-dai-cells = <0>;
+    };
-- 
2.17.1

