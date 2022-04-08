Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565CAC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Apr 2022 06:07:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 849E518BC;
	Fri,  8 Apr 2022 08:06:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 849E518BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649398052;
	bh=GLFuaCNmt0T5ooucqRAD45L21dY4NNuzEaGxpVf+//I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BQtl7+ctvUi8AiQhgbpbyrYJTA8MHIY0w29rQzq6k48kYG75qN38nu5a7jP1OMnKk
	 KagO5Izw4BXxyc3427EWbtJaqyQ8XoAKn3act9Wi9dHCybdaX9lkfAGlDak+LGWwNT
	 Yc3URvQ1NXJo24nkrDztFh/mNskzFzAF+wb5igdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16BD6F8012A;
	Fri,  8 Apr 2022 08:06:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E68C9F80516; Fri,  8 Apr 2022 08:06:11 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3BF0F80128
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2022 08:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3BF0F80128
X-UUID: 3f9f06ffd33c420a8f17e2ced917d64d-20220408
X-UUID: 3f9f06ffd33c420a8f17e2ced917d64d-20220408
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 93902839; Fri, 08 Apr 2022 14:05:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Apr 2022 14:05:55 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 14:05:54 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <nfraprado@collabora.com>,
 <tzungbi@google.com>
Subject: [v10 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible and
 new properties
Date: Fri, 8 Apr 2022 14:05:49 +0800
Message-ID: <20220408060552.26607-2-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408060552.26607-1-jiaxin.yu@mediatek.com>
References: <20220408060552.26607-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N
Cc: devicetree@vger.kernel.org, linmq006@gmail.com,
 Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
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

1. Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for machines
with rt1015p and rt5682s.
2. Adds new property "headset-codec" for getting headset codec.
3. Adds new property "speaker-codecs" for getting speaker codecs.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index 5a5b765b859a..4fa179909c62 100644
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
2.25.1

