Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31446C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Mar 2022 06:47:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 550731733;
	Thu, 24 Mar 2022 07:46:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 550731733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648104436;
	bh=AdD+FYqkHhyvO9nnB0rM0ADHG8Guva7A6FG1UuLKBa4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r0fca/RcKhr2Cb+aykPEiwc0e1GQnjoYZ9uTbCyRRlLaYa/3ELtyTsd8Xk3t5P0Y3
	 DOwkBKo5owl3n0CRNACeJRTJwCMUVKBDFNLj4hETTETwTYd9eIpLqTyl6gLtfNDC4s
	 fQjhowZbTDwSBGkxO7I5Nr7/lkY1f4lMcDbc+sOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9147DF80515;
	Thu, 24 Mar 2022 07:45:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C35EAF80165; Thu, 24 Mar 2022 07:45:35 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04CD4F80139
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2022 07:45:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04CD4F80139
X-UUID: 1fba6cc0bd5d453cb67ce44f57f86331-20220324
X-UUID: 1fba6cc0bd5d453cb67ce44f57f86331-20220324
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 349442330; Thu, 24 Mar 2022 14:45:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 24 Mar 2022 14:45:15 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 14:45:14 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <tzungbi@google.com>
Subject: [v7 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible and new
 properties
Date: Thu, 24 Mar 2022 14:45:08 +0800
Message-ID: <20220324064511.10665-2-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
References: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, linmq006@gmail.com, alsa-devel@alsa-project.org,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com,
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

1. Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for machine
with rt1015p and rt5682s.
2. Adds new property "headset-codec" for getting headset codec.
3. Adds new property "speaker-codecs" for getting speaker codecs.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index a781e7aaaa38..385fcf5dd40f 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - mediatek,mt8192_mt6359_rt1015_rt5682
       - mediatek,mt8192_mt6359_rt1015p_rt5682
+      - mediatek,mt8192_mt6359_rt1015p_rt5682s
 
   mediatek,platform:
     $ref: "/schemas/types.yaml#/definitions/phandle"
@@ -27,11 +28,33 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description: The phandle of HDMI codec.
 
+  headset-codec:
+    type: object
+    properties:
+      sound-dai:
+        $ref: /schemas/types.yaml#/definitions/phandle
+    required:
+      - sound-dai
+
+  speaker-codecs:
+    type: object
+    properties:
+      sound-dai:
+        minItems: 1
+        maxItems: 2
+        items:
+          maxItems: 1
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+    required:
+      - sound-dai
+
 additionalProperties: false
 
 required:
   - compatible
   - mediatek,platform
+  - headset-codec
+  - speaker-codecs
 
 examples:
   - |
@@ -44,6 +67,15 @@ examples:
                         "aud_clk_mosi_on";
         pinctrl-0 = <&aud_clk_mosi_off>;
         pinctrl-1 = <&aud_clk_mosi_on>;
+
+        headset-codec {
+            sound-dai = <&rt5682>;
+        };
+
+        speaker-codecs {
+            sound-dai = <&rt1015_l>,
+                        <&rt1015_r>;
+        };
     };
 
 ...
-- 
2.18.0

