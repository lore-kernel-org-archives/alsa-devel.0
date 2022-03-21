Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEE5C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Mar 2022 07:25:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C316216B5;
	Mon, 21 Mar 2022 08:24:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C316216B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647847515;
	bh=CPitSryausqUiz4Mie7htyfMx9b3w8JcMpS7Q6LVdyI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DrGAXAC26ihg0xPstJ+GPLoABW0ObKjpt7IxVg5KBnZCt7ceBs69+MjOeOu7nrsVh
	 ZKyrQ0o3/QQyTHubchXjha8iZTa1XmXImVqGW+2l3vlQbkGZ6OtUYVdFsvl67/0zwb
	 5UGL8zt8i3Zona7a3XfEE4xc6v0crfFYpc4nt5i4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02E11F80518;
	Mon, 21 Mar 2022 08:23:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5ECDAF80517; Mon, 21 Mar 2022 08:23:35 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8597BF801D8
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2022 08:23:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8597BF801D8
X-UUID: d5b037d265ea4a21adc927d3a8e69352-20220321
X-UUID: d5b037d265ea4a21adc927d3a8e69352-20220321
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1558775644; Mon, 21 Mar 2022 15:23:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Mar 2022 15:23:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 21 Mar 2022 15:23:15 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [PATCH v3 3/6] ASoC: dt-bindings: mediatek: mt8195: merge mt8195
 machine yaml
Date: Mon, 21 Mar 2022 15:23:09 +0800
Message-ID: <20220321072312.14972-4-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220321072312.14972-1-trevor.wu@mediatek.com>
References: <20220321072312.14972-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 yc.hung@mediatek.com, aaronyu@google.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com
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

Because the same binding components can be shared by all codecs
combinations, we only reserve one binding file for mt8195 machine driver
and rename to a generic name.

We use compatible string to separate different codec combination instead
of creating a new binding file for new codec combination.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    | 51 -------------------
 ...-rt1019-rt5682.yaml => mt8195-mt6359.yaml} |  8 +--
 2 files changed, 5 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
 rename Documentation/devicetree/bindings/sound/{mt8195-mt6359-rt1019-rt5682.yaml => mt8195-mt6359.yaml} (87%)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
deleted file mode 100644
index cf6ad7933e23..000000000000
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
+++ /dev/null
@@ -1,51 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/mt8195-mt6359-rt1011-rt5682.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mediatek MT8195 with MT6359, RT1011 and RT5682 ASoC sound card driver
-
-maintainers:
-  - Trevor Wu <trevor.wu@mediatek.com>
-
-description:
-  This binding describes the MT8195 sound card with RT1011 and RT5682.
-
-properties:
-  compatible:
-    const: mediatek,mt8195_mt6359_rt1011_rt5682
-
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
-  mediatek,platform:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 ASoC platform.
-
-  mediatek,dptx-codec:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 Display Port Tx codec node.
-
-  mediatek,hdmi-codec:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 HDMI codec node.
-
-additionalProperties: false
-
-required:
-  - compatible
-  - mediatek,platform
-
-examples:
-  - |
-
-    sound: mt8195-sound {
-        compatible = "mediatek,mt8195_mt6359_rt1011_rt5682";
-        mediatek,platform = <&afe>;
-        pinctrl-names = "default";
-        pinctrl-0 = <&aud_pins_default>;
-    };
-
-...
diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
similarity index 87%
rename from Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
rename to Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
index 8f177e02ad35..74227fba91c7 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/mt8195-mt6359-rt1019-rt5682.yaml#
+$id: http://devicetree.org/schemas/sound/mt8195-mt6359.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8195 with MT6359, RT1019 and RT5682 ASoC sound card driver
+title: Mediatek MT8195 ASoC sound card driver
 
 maintainers:
   - Trevor Wu <trevor.wu@mediatek.com>
@@ -14,7 +14,9 @@ description:
 
 properties:
   compatible:
-    const: mediatek,mt8195_mt6359_rt1019_rt5682
+    enum:
+      - mediatek,mt8195_mt6359_rt1019_rt5682
+      - mediatek,mt8195_mt6359_rt1011_rt5682
 
   model:
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.18.0

