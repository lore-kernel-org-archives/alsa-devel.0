Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B087BC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Mar 2022 06:04:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1CFF1779;
	Wed, 16 Mar 2022 07:03:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1CFF1779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647410660;
	bh=qGGqUnjcTT7Qaiixy1LUikRDUOTdzU22iLKwo4fwcxI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Im1w/l8yujn/YXfPhvZgaosYKSyZ9H54sLNdMN/9LHWa3OfXqrlJXDYNsLPmbuTCb
	 hauLBWphWJh7LOMNUgG4iuFzvMEncb11DhIMW3h5k+6UAdKjrGCtB3qMQpNZFhW2/r
	 nzSP5jp3lKYiTev+bvXik3wiH+AzgQs89sCutTY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3075FF80524;
	Wed, 16 Mar 2022 07:02:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 813A9F80526; Wed, 16 Mar 2022 07:02:18 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7FAE7F801F5
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2022 07:02:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FAE7F801F5
X-UUID: 89fbff96aaf04f49b71891b93f7038b2-20220316
X-UUID: 89fbff96aaf04f49b71891b93f7038b2-20220316
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1299534393; Wed, 16 Mar 2022 14:01:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Mar 2022 14:01:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 16 Mar 2022 14:01:46 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [PATCH v2 5/5] ASoC: dt-bindings: mediatek: mt8195: support
 mt8195-mt6359-max98390-rt5682
Date: Wed, 16 Mar 2022 14:01:39 +0800
Message-ID: <20220316060139.6211-6-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220316060139.6211-1-trevor.wu@mediatek.com>
References: <20220316060139.6211-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, yc.hung@mediatek.com, aaronyu@google.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

This patch adds compatible string "mediatek,mt8195-mt6359-max98390-rt5682"
to support mt8195 board with mt6359, max98390 and rt5682.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
index 74227fba91c7..6222ef2cf7e4 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - mediatek,mt8195_mt6359_rt1019_rt5682
       - mediatek,mt8195_mt6359_rt1011_rt5682
+      - mediatek,mt8195_mt6359_max98390_rt5682
 
   model:
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.18.0

