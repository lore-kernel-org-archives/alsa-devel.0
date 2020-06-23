Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59799C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:41:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97E420724
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ujCn6OOC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sVizWFAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97E420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65B2017CC;
	Tue, 23 Jun 2020 13:41:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65B2017CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592912516;
	bh=x6xfztmK2o/deuCSCL7osGdxRA1MW1vAi2pscu2gcR4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ujCn6OOC/vZQBBCQQIRtVRHcFR9hykEFjL9cMhS8OPtDdzBb7JIjsi/yz9mwsPStI
	 54urvTeUd6icGYZ+IRSa+cKVT+mncarEKUYfqk3bpRQzHqlcz0cJWH+asSqkxIYxUc
	 jqdYSJqdtlG46zP6Y+YPXGBuc2AWLIl8XOATehns=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8CC7F802A2;
	Tue, 23 Jun 2020 13:40:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13C4AF80249; Tue, 23 Jun 2020 13:40:49 +0200 (CEST)
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B11CF80249
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 13:40:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B11CF80249
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com
 header.b="sVizWFAT"
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net
 [126.90.202.47]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 05NBe8ci003070;
 Tue, 23 Jun 2020 20:40:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 05NBe8ci003070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1592912410;
 bh=PygYU/2RRMrfiio7nz6fPQ9Z7mq5YCkWc1Sf7EhnCkI=;
 h=From:To:Cc:Subject:Date:From;
 b=sVizWFATWNcpy5d9L3all7xagM7c44OaE+nOQol8xIWPF1MVnRFYRK+KAyHkpv+Di
 K0ohhgAFzmEXqysWpfY+oy9zqY8dlFfcvS7uTwCnWxFtcA9BtjqO2tiz2Opou6yamU
 OQDbKdbG89dg+9GLB1EHru5JKHnKyuXLcpjRJm1jzx3444+h8jKKOvJtWjR1NcF06p
 ebdnrAdGVhto+zkF6R/d7tKHpxWO4gjBmdj4cWAkWl5Utk5NAF3uAOwWx66gkL8fcy
 trtsxYJwBvJj/kYN2jxwGKo7YronIzoFNQBUX5USckS9u6fIQKRCmGW7XmbVQefPgM
 971JdwhmVLzhA==
X-Nifty-SrcIP: [126.90.202.47]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to
 json-schema
Date: Tue, 23 Jun 2020 20:40:05 +0900
Message-Id: <20200623114005.791643-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: - <alsa-devel@alsa-project.org>, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Convert the UniPhier EVEA sound codec binding to DT schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add schema for subnode 'port'

 .../sound/socionext,uniphier-evea.yaml        | 70 +++++++++++++++++++
 .../bindings/sound/uniphier,evea.txt          | 26 -------
 2 files changed, 70 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt

diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
new file mode 100644
index 000000000000..228168f685cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/socionext,uniphier-evea.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier EVEA SoC-internal sound codec
+
+maintainers:
+  - <alsa-devel@alsa-project.org>
+
+properties:
+  compatible:
+    const: socionext,uniphier-evea
+
+  reg:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: evea
+      - const: exiv
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: evea
+      - const: exiv
+      - const: adamv
+
+  resets:
+    minItems: 3
+    maxItems: 3
+
+  "#sound-dai-cells":
+    const: 1
+
+patternProperties:
+  "^port@[0-9]$":
+    type: object
+    properties:
+      endpoint: true
+    required:
+      - endpoint
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clock-names
+  - clocks
+  - reset-names
+  - resets
+  - "#sound-dai-cells"
+
+examples:
+  - |
+    codec@57900000 {
+        compatible = "socionext,uniphier-evea";
+        reg = <0x57900000 0x1000>;
+        clock-names = "evea", "exiv";
+        clocks = <&sys_clk 41>, <&sys_clk 42>;
+        reset-names = "evea", "exiv", "adamv";
+        resets = <&sys_rst 41>, <&sys_rst 42>, <&adamv_rst 0>;
+        #sound-dai-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/uniphier,evea.txt b/Documentation/devicetree/bindings/sound/uniphier,evea.txt
deleted file mode 100644
index 3f31b235f18b..000000000000
--- a/Documentation/devicetree/bindings/sound/uniphier,evea.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Socionext EVEA - UniPhier SoC internal codec driver
-
-Required properties:
-- compatible      : should be "socionext,uniphier-evea".
-- reg             : offset and length of the register set for the device.
-- clock-names     : should include following entries:
-                    "evea", "exiv"
-- clocks          : a list of phandle, should contain an entry for each
-                    entries in clock-names.
-- reset-names     : should include following entries:
-                    "evea", "exiv", "adamv"
-- resets          : a list of phandle, should contain reset entries of
-                    reset-names.
-- #sound-dai-cells: should be 1.
-
-Example:
-
-	codec {
-		compatible = "socionext,uniphier-evea";
-		reg = <0x57900000 0x1000>;
-		clock-names = "evea", "exiv";
-		clocks = <&sys_clk 41>, <&sys_clk 42>;
-		reset-names = "evea", "exiv", "adamv";
-		resets = <&sys_rst 41>, <&sys_rst 42>, <&adamv_rst 0>;
-		#sound-dai-cells = <1>;
-	};
-- 
2.25.1

