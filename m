Return-Path: <SRS0=sDoq=M5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734B8C4338F
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 10:31:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52ED960E52
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 10:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52ED960E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C15A616F3;
	Fri,  6 Aug 2021 12:31:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C15A616F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628245910;
	bh=gSFUkqx10sMXCWYEUgE2uBt8dWt/ogyCo/WvnR8G7C0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=odneCKbtx0UnIsiu1sma3UJksKU4ejA8GLHdY5d3eSm0q9691BlmXaGgPuLsBqQL9
	 FC/FpK+nAJWUk99dajSMxOob/LDVPsj/b0v9sFdMpmLwXf1t9Ob12IgGwXI8ztC291
	 wFT1YsnhEIoCsFqIwmiwTr126PEnkqDFMYspXN5I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1F32F804CB;
	Fri,  6 Aug 2021 12:30:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF76BF80268; Fri,  6 Aug 2021 12:30:02 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id D47E9F8025F
 for <alsa-devel@alsa-project.org>; Fri,  6 Aug 2021 12:29:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D47E9F8025F
X-IronPort-AV: E=Sophos;i="5.84,300,1620658800"; d="scan'208";a="90032332"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 06 Aug 2021 19:29:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2F76542208EF;
 Fri,  6 Aug 2021 19:29:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 2/3] ASoC: dt-bindings: sound: renesas,
 rz-ssi: Update slave dma channel configuration parameters
Date: Fri,  6 Aug 2021 11:29:29 +0100
Message-Id: <20210806102930.3024-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210806102930.3024-1-biju.das.jz@bp.renesas.com>
References: <20210806102930.3024-1-biju.das.jz@bp.renesas.com>
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

The DMAC driver on RZ/G2L expects the slave channel configuration
to be passed in dmas property.
This patch updates the example node to include the encoded slave
channel configuration.

Fixes: 5df6dfbb6de815ba3a("ASoC: dt-bindings: sound: renesas,rz-ssi: Document DMA support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note:-
 This patch is based on [1]
 [1]:- https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210806095322.2326-2-biju.das.jz@bp.renesas.com/

v3->v4:
 * Updated bindings as the DMAC driver on RZ/G2L expects the
   slave channel configuration to be passed in dmas property.
v2->v3:
 * Merged the binding patch with dmas added
 * Updated dt binding example with encoded #dma-cells value.
v1->v2:
 * Rebased on 5.14-rc2.
---
 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 471937cb8d05..9923e7b8264f 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -93,8 +93,8 @@ examples:
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

