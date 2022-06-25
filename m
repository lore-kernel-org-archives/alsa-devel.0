Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A546C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jun 2022 19:11:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74D1E16E8;
	Sat, 25 Jun 2022 21:10:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74D1E16E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656184300;
	bh=mZyYul5JuYSRCP9DhWsT74KkaJXa/Pg3Ki4F5x2CZGw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S/HyBr0lRlACcwE5esyBAc4EAMednE1iua/Ku+K1BGOu1Ddu3QAQWJX0k0tujEEY8
	 rTsK8rxQ2rMkDNbKb8gGrBjuasszG73w10QnjPWMzswsmd4uxXpJdNtVeiHySLDgUv
	 JcyaG/BNLzLxNODVkZb2i7qBkH1mrDvgPtCLGDL4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6A3EF80552;
	Sat, 25 Jun 2022 21:09:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09A7FF80543; Sat, 25 Jun 2022 21:09:22 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E105F80107
 for <alsa-devel@alsa-project.org>; Sat, 25 Jun 2022 21:09:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E105F80107
X-UUID: e715586d125c4138b54554f0676de03d-20220626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:832617ad-53a0-4b9b-a7ea-a1bd00b8a430, OB:0,
 LO
 B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:25
X-CID-META: VersionHash:b14ad71, CLOUDID:e503082e-1756-4fa3-be7f-474a6e4be921,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: e715586d125c4138b54554f0676de03d-20220626
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 28565535; Sun, 26 Jun 2022 03:09:08 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Sun, 26 Jun 2022 03:09:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 26 Jun 2022 03:09:06 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 26 Jun 2022 03:08:59 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>,
 <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v8 6/8] dt-bindings: mediatek: mt8186: add
 mt8186-mt6366-da7219-max98357 document
Date: Sun, 26 Jun 2022 03:08:50 +0800
Message-ID: <20220625190852.29130-7-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625190852.29130-1-jiaxin.yu@mediatek.com>
References: <20220625190852.29130-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com, julianbraha@gmail.com,
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

Add document for mt8186 board with mt6366, da7219 and max98357.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../sound/mt8186-mt6366-da7219-max98357.yaml  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml

diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
new file mode 100644
index 000000000000..513cd28b2027
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mt8186-mt6366-da7219-max98357.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT8186 with MT6366, DA7219 and MAX98357 ASoC sound card driver
+
+maintainers:
+  - Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+description:
+  This binding describes the MT8186 sound card.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8186-mt6366-da7219-max98357-sound
+
+  mediatek,platform:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of MT8186 ASoC platform.
+
+  headset-codec:
+    type: object
+    additionalProperties: false
+    properties:
+      sound-dai:
+        maxItems: 1
+    required:
+      - sound-dai
+
+  playback-codecs:
+    type: object
+    additionalProperties: false
+    properties:
+      sound-dai:
+        items:
+          - description: phandle of dp codec
+          - description: phandle of l channel speaker codec
+          - description: phandle of r channel speaker codec
+        minItems: 2
+    required:
+      - sound-dai
+
+additionalProperties: false
+
+required:
+  - compatible
+  - mediatek,platform
+  - headset-codec
+  - playback-codecs
+
+examples:
+  - |
+
+    sound: mt8186-sound {
+        compatible = "mediatek,mt8186-mt6366-da7219-max98357-sound";
+        mediatek,platform = <&afe>;
+        pinctrl-names = "aud_clk_mosi_off",
+                        "aud_clk_mosi_on";
+        pinctrl-0 = <&aud_clk_mosi_off>;
+        pinctrl-1 = <&aud_clk_mosi_on>;
+
+        headset-codec {
+            sound-dai = <&da7219>;
+        };
+
+        playback-codecs {
+            sound-dai = <&anx_bridge_dp>,
+                        <&max98357a>;
+        };
+    };
+
+...
-- 
2.18.0

