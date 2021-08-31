Return-Path: <SRS0=fy3w=NW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2811BC432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 08:41:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B1960F25
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 08:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A9B1960F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38E371729;
	Tue, 31 Aug 2021 10:40:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38E371729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630399267;
	bh=4NInJVLGLsJ6t5D3kpXQBQ2bcBirU3Y3x479RwH5rWc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uhFpfY/tTYq//QvtRWJq0/scdHoNosk9Dxf1+XvYuaUWFR/je61H/ka0u9dTZKzI6
	 Gi8UTgeq76hYygg8myQEzmz+hZVf3+ie8M2ZsV09eEx4mlYtEEBxffsM357CnKVOdp
	 N7k/t6dKb+c155hPmbWFgXf21ThPzkzEM2CpTDPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F390F80254;
	Tue, 31 Aug 2021 10:40:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 507D3F8025B; Tue, 31 Aug 2021 10:40:15 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1C08F800BE
 for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2021 10:40:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1C08F800BE
X-UUID: c2bb3395cc704301b8105ff7d3b932e2-20210831
X-UUID: c2bb3395cc704301b8105ff7d3b932e2-20210831
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1722613409; Tue, 31 Aug 2021 16:39:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 16:39:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Tue, 31 Aug 2021 16:39:57 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: mt8195: remove dependent headers in the
 example
Date: Tue, 31 Aug 2021 16:39:56 +0800
Message-ID: <20210831083956.9804-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, linux-arm-kernel@lists.infradead.org
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

Drop the use of the defines including clock and power id, so that
we can remove the headers which are not applied in the example.

Fixes: b5bac34fcfb4 ("dt-bindings: mediatek: mt8195: add audio afe document")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../bindings/sound/mt8195-afe-pcm.yaml        | 40 +++++++++----------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
index 53e9434a6d9d..dcf790b053d2 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
@@ -130,36 +130,34 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/mt8195-clk.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/power/mt8195-power.h>
 
     afe: mt8195-afe-pcm@10890000 {
         compatible = "mediatek,mt8195-audio";
         reg = <0x10890000 0x10000>;
         interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
         mediatek,topckgen = <&topckgen>;
-        power-domains = <&spm MT8195_POWER_DOMAIN_AUDIO>;
+        power-domains = <&spm 7>; //MT8195_POWER_DOMAIN_AUDIO
         clocks = <&clk26m>,
-                 <&topckgen CLK_TOP_APLL1>,
-                 <&topckgen CLK_TOP_APLL2>,
-                 <&topckgen CLK_TOP_APLL12_DIV0>,
-                 <&topckgen CLK_TOP_APLL12_DIV1>,
-                 <&topckgen CLK_TOP_APLL12_DIV2>,
-                 <&topckgen CLK_TOP_APLL12_DIV3>,
-                 <&topckgen CLK_TOP_APLL12_DIV9>,
-                 <&topckgen CLK_TOP_A1SYS_HP_SEL>,
-                 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
-                 <&topckgen CLK_TOP_AUDIO_H_SEL>,
-                 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS_SEL>,
-                 <&topckgen CLK_TOP_DPTX_M_SEL>,
-                 <&topckgen CLK_TOP_I2SO1_M_SEL>,
-                 <&topckgen CLK_TOP_I2SO2_M_SEL>,
-                 <&topckgen CLK_TOP_I2SI1_M_SEL>,
-                 <&topckgen CLK_TOP_I2SI2_M_SEL>,
-                 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>,
-                 <&scp_adsp CLK_SCP_ADSP_AUDIODSP>;
+                 <&topckgen 163>, //CLK_TOP_APLL1
+                 <&topckgen 166>, //CLK_TOP_APLL2
+                 <&topckgen 233>, //CLK_TOP_APLL12_DIV0
+                 <&topckgen 234>, //CLK_TOP_APLL12_DIV1
+                 <&topckgen 235>, //CLK_TOP_APLL12_DIV2
+                 <&topckgen 236>, //CLK_TOP_APLL12_DIV3
+                 <&topckgen 238>, //CLK_TOP_APLL12_DIV9
+                 <&topckgen 100>, //CLK_TOP_A1SYS_HP_SEL
+                 <&topckgen 33>, //CLK_TOP_AUD_INTBUS_SEL
+                 <&topckgen 34>, //CLK_TOP_AUDIO_H_SEL
+                 <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS_SEL
+                 <&topckgen 98>, //CLK_TOP_DPTX_M_SEL
+                 <&topckgen 94>, //CLK_TOP_I2SO1_M_SEL
+                 <&topckgen 95>, //CLK_TOP_I2SO2_M_SEL
+                 <&topckgen 96>, //CLK_TOP_I2SI1_M_SEL
+                 <&topckgen 97>, //CLK_TOP_I2SI2_M_SEL
+                 <&infracfg_ao 50>, //CLK_INFRA_AO_AUDIO_26M_B
+                 <&scp_adsp 0>; //CLK_SCP_ADSP_AUDIODSP
         clock-names = "clk26m",
                       "apll1_ck",
                       "apll2_ck",
-- 
2.18.0

