Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F29C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 14:01:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1846058D
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 14:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D1846058D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6863F1765;
	Mon, 18 Oct 2021 16:00:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6863F1765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634565663;
	bh=UnEGcDiRRWZSFCo8YxIR1gys5VCJR5eedXD4h8g0xUk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PRx+FwyNVXq46Dch51DMFbN/GrHQBxNd8yknTWVe05O8622Fy7i9oY0B0QLOCwomN
	 tjbFADUA1RgiUHytdCMVxDyA8pzTGhpY9pqf+A0MgU7tEpuTwKs3OaRQfqREoyZ3xC
	 13dXBZZ/RpI5vZM5oqQny/EZe1GopO5x57JmvpDo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1579F804EC;
	Mon, 18 Oct 2021 15:59:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 132D7F804E0; Mon, 18 Oct 2021 15:59:24 +0200 (CEST)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0D5DF80224
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 15:59:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0D5DF80224
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e87a:7c37:aec5:5884])
 by baptiste.telenet-ops.be with bizsmtp
 id 7RzB2600i22VXnz01RzBx9; Mon, 18 Oct 2021 15:59:11 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mcTAV-005uyu-FW; Mon, 18 Oct 2021 15:59:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mcTAV-00Ddit-3j; Mon, 18 Oct 2021 15:59:11 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH 2/2] ASoC: dt-bindings: wlf,wm8962: Convert to json-schema
Date: Mon, 18 Oct 2021 15:59:03 +0200
Message-Id: <b0868d2f62fd57499c79d96298e99e5f9e4fbc76.1634565154.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634565154.git.geert+renesas@glider.be>
References: <cover.1634565154.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
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

Convert the Wolfson WM8962 Ultra-Low Power Stereo CODEC Device Tree
binding documentation to json-schema.

Add missing *-supply and port properties.
Update the example.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/sound/wlf,wm8962.yaml | 118 ++++++++++++++++++
 .../devicetree/bindings/sound/wm8962.txt      |  43 -------
 2 files changed, 118 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8962.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
new file mode 100644
index 0000000000000000..0e6249d7c1330f7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8962.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wolfson WM8962 Ultra-Low Power Stereo CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+properties:
+  compatible:
+    const: wlf,wm8962
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  AVDD-supply:
+    description: Analogue supply.
+
+  CPVDD-supply:
+    description: Charge pump power supply.
+
+  DBVDD-supply:
+    description: Digital Buffer Supply.
+
+  DCVDD-supply:
+    description: Digital Core Supply.
+
+  MICVDD-supply:
+    description: Microphone bias amp supply.
+
+  PLLVDD-supply:
+    description: PLL Supply
+
+  SPKVDD1-supply:
+    description: Supply for left speaker drivers.
+
+  SPKVDD2-supply:
+    description: Supply for right speaker drivers.
+
+  spk-mono:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, the SPK_MONO bit of R51 (Class D Control 2) gets set,
+      indicating that the speaker is in mono mode.
+
+  mic-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Default register value for R48 (Additional Control 4).
+      If absent, the default should be the register default.
+
+  gpio-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 6
+    maxItems: 6
+    description:
+      A list of GPIO configuration register values.  If absent, no
+      configuration of these registers is performed.  Note that only values
+      within [0x0, 0xffff] are valid.  Any other value is regarded as setting
+      the GPIO register to its reset value 0x0.
+
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - AVDD-supply
+  - CPVDD-supply
+  - DBVDD-supply
+  - DCVDD-supply
+  - MICVDD-supply
+  - PLLVDD-supply
+  - SPKVDD1-supply
+  - SPKVDD2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+
+    i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          wm8962: codec@1a {
+                  compatible = "wlf,wm8962";
+                  reg = <0x1a>;
+                  clocks = <&clks IMX6QDL_CLK_CKO>;
+                  DCVDD-supply = <&reg_audio>;
+                  DBVDD-supply = <&reg_audio>;
+                  AVDD-supply = <&reg_audio>;
+                  CPVDD-supply = <&reg_audio>;
+                  MICVDD-supply = <&reg_audio>;
+                  PLLVDD-supply = <&reg_audio>;
+                  SPKVDD1-supply = <&reg_audio>;
+                  SPKVDD2-supply = <&reg_audio>;
+                  gpio-cfg = <
+                          0x0000 /* 0:Default */
+                          0x0000 /* 1:Default */
+                          0x0013 /* 2:FN_DMICCLK */
+                          0x0000 /* 3:Default */
+                          0x8014 /* 4:FN_DMICCDAT */
+                          0x0000 /* 5:Default */
+                  >;
+          };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8962.txt b/Documentation/devicetree/bindings/sound/wm8962.txt
deleted file mode 100644
index c36c649ddfd04f37..0000000000000000
--- a/Documentation/devicetree/bindings/sound/wm8962.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-WM8962 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "wlf,wm8962"
-
-  - reg : the I2C address of the device.
-
-Optional properties:
-
-  - clocks : The clock source of the mclk
-
-  - spk-mono: This is a boolean property. If present, the SPK_MONO bit
-    of R51 (Class D Control 2) gets set, indicating that the speaker is
-    in mono mode.
-
-  - mic-cfg : Default register value for R48 (Additional Control 4).
-    If absent, the default should be the register default.
-
-  - gpio-cfg : A list of GPIO configuration register values. The list must
-    be 6 entries long. If absent, no configuration of these registers is
-    performed. And note that only the value within [0x0, 0xffff] is valid.
-    Any other value is regarded as setting the GPIO register by its reset
-    value 0x0.
-
-Example:
-
-wm8962: codec@1a {
-	compatible = "wlf,wm8962";
-	reg = <0x1a>;
-	clocks = <&clks IMX6QDL_CLK_CKO>;
-
-	gpio-cfg = <
-		0x0000 /* 0:Default */
-		0x0000 /* 1:Default */
-		0x0013 /* 2:FN_DMICCLK */
-		0x0000 /* 3:Default */
-		0x8014 /* 4:FN_DMICCDAT */
-		0x0000 /* 5:Default */
-	>;
-};
-- 
2.25.1

