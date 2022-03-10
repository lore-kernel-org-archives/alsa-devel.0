Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AEDC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 15:40:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05B751943;
	Thu, 10 Mar 2022 16:39:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05B751943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646926798;
	bh=0j7gcw1dmXFiuwwhi0AZMeJT/mC71ZNc64p3q3zZORQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hPWmbz0Ki6h4UgxzaOeDOrUOUa/ejW8ipO5ycbrGU4jY79FJ6NBWaYDgQXW5FHnDb
	 Wf03fnqnvwSKXDiiw2hd5oW0kf/pCSHpzQHeRE/M0UxLxSn88PCUQ2Plxd6XnyHRzP
	 CjqsisSmI9m2fL2p9zhJfrXO9zWygXW11k5WXTlk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BFA0F8016C;
	Thu, 10 Mar 2022 16:38:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCA5EF8027B; Thu, 10 Mar 2022 16:38:33 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E49DF8012C
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 16:38:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E49DF8012C
X-UUID: 204b4042b3ac4eec86e7a14bec49661e-20220310
X-UUID: 204b4042b3ac4eec86e7a14bec49661e-20220310
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 451625714; Thu, 10 Mar 2022 23:38:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 10 Mar 2022 23:38:15 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Mar 2022 23:38:14 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>
Subject: [v2 1/2] ASoC: dt-bindings: mt8192-mt6359: add new compatible for
 using rt1015p and rt5682
Date: Thu, 10 Mar 2022 23:37:06 +0800
Message-ID: <20220310153707.29722-2-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310153707.29722-1-jiaxin.yu@mediatek.com>
References: <20220310153707.29722-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, linmq006@gmail.com, alsa-devel@alsa-project.org,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com,
 linux-arm-kernel@lists.infradead.org
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

Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for machines
with rt1015p and rt5682s.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 .../devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index a781e7aaaa38..4b0b0478018a 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - mediatek,mt8192_mt6359_rt1015_rt5682
       - mediatek,mt8192_mt6359_rt1015p_rt5682
+      - mediatek,mt8192_mt6359_rt1015p_rt5682s
 
   mediatek,platform:
     $ref: "/schemas/types.yaml#/definitions/phandle"
-- 
2.18.0

