Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B935C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 09:14:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AE06024A
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 09:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57AE06024A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BAB9189E;
	Fri, 13 Aug 2021 11:13:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BAB9189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628846043;
	bh=gRrajjpsBPvz80+LVq2A7+49eF2iJnh3g1GqrqKU1XM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pqDd1t/K65aOOhe5jucZWHaMUrXg4PAh+HF/f4Aw7AvNd+Mspzz4/MoO5BDKCPzFS
	 0fQQBBRAJFxltNN+nEWPqhfKcUEPoPGFAvy8G0Slrl17BuyYjmxSmMYw5UtTjJvs3u
	 CppnwExXRtWlAoNcMqnZDeH0qSjIgbAkxv2eYto8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD5AEF802D2;
	Fri, 13 Aug 2021 11:12:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73DB8F804CC; Fri, 13 Aug 2021 11:12:23 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id 77B35F800AF
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 11:12:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77B35F800AF
X-IronPort-AV: E=Sophos;i="5.84,318,1620658800"; d="scan'208";a="90541571"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 13 Aug 2021 18:12:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 877124228B65;
 Fri, 13 Aug 2021 18:12:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 2/3] ASoC: dt-bindings: renesas,
 rz-ssi: Update slave dma channel configuration parameter
Date: Fri, 13 Aug 2021 10:11:55 +0100
Message-Id: <20210813091156.10700-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210813091156.10700-1-biju.das.jz@bp.renesas.com>
References: <20210813091156.10700-1-biju.das.jz@bp.renesas.com>
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

The DMAC on RZ/G2L has specific slave channel configuration
parameters for SSI.
This patch updates the dmas description and example node to include
the encoded slave channel configuration.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note:-
 This patch is based on [1]
 [1]:- https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210806095322.2326-2-biju.das.jz@bp.renesas.com/
v4->v5:
 * Updated dmas description and removed fixes as it is an enhancement
   now.
v3->v4:
 * Updated bindings as the DMAC driver on RZ/G2L expects the
   slave channel configuration to be passed in dmas property.
v2->v3:
 * Merged the binding patch with dmas added
 * Updated dt binding example with encoded #dma-cells value.
v1->v2:
 * Rebased on 5.14-rc2.
---
 .../bindings/sound/renesas,rz-ssi.yaml        | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 471937cb8d05..414ff8035a4e 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -48,6 +48,24 @@ properties:
   dmas:
     minItems: 1
     maxItems: 2
+    description:
+      The first cell represents a phandle to dmac
+      The second cell specifies the encoded MID/RID values of the SSI port
+      connected to the DMA client and the slave channel configuration
+      parameters.
+      bits[0:9]   - Specifies MID/RID value of a SSI channel as below
+                    MID/RID value of SSI rx0 = 0x256
+                    MID/RID value of SSI tx0 = 0x255
+                    MID/RID value of SSI rx1 = 0x25a
+                    MID/RID value of SSI tx1 = 0x259
+                    MID/RID value of SSI rt2 = 0x25f
+                    MID/RID value of SSI rx3 = 0x262
+                    MID/RID value of SSI tx3 = 0x261
+      bit[10]     - HIEN = 1, Detects a request in response to the rising edge
+                    of the signal
+      bit[11]     - LVL = 0, Detects based on the edge
+      bits[12:14] - AM = 2, Bus cycle mode
+      bit[15]     - TM = 0, Single transfer mode
 
   dma-names:
     oneOf:
@@ -93,8 +111,8 @@ examples:
             clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
             power-domains = <&cpg>;
             resets = <&cpg R9A07G044_SSI0_RST_M2_REG>;
-            dmas = <&dmac 0x255>,
-                   <&dmac 0x256>;
+            dmas = <&dmac 0x2655>,
+                   <&dmac 0x2656>;
             dma-names = "tx", "rx";
             #sound-dai-cells = <0>;
     };
-- 
2.17.1

