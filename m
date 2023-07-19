Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C37EB64DA
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jul 2023 12:20:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 332D61FE;
	Wed, 19 Jul 2023 14:20:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 332D61FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689769254;
	bh=w8QgN80szna0uniayEpqCFNgVNaPz9uDgGXR6mVopZk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DPXnAuGkFDIoT64J7l+CCsIrAqYlxIaegsocf1vBRcMFIFgKs1QvA47XnPMdnS05R
	 z2nYLeVFlMSzJL+A54C6/xuAtM+8vR8ePQ2HTqa0ECdCUUQ4SLXyIqpXrtAyTLhPGA
	 1eryTenyg+b9FS1+dNj/EoS22jbPTmdxN2sdYHzg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A01FEF800D2; Wed, 19 Jul 2023 14:19:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3128FF8007E;
	Wed, 19 Jul 2023 14:19:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2976EF8047D; Wed, 19 Jul 2023 14:19:33 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it
 [IPv6:2001:4b7e:0:8::81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A21D0F800D2
	for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2023 14:19:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A21D0F800D2
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6AD99209A8;
	Wed, 19 Jul 2023 14:19:23 +0200 (CEST)
From: Francesco Dolcini <francesco@dolcini.it>
To: alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com
Subject: [PATCH v1] ASoC: dt-bindings: wm8904: Convert to dtschema
Date: Wed, 19 Jul 2023 14:19:18 +0200
Message-Id: <20230719121918.247397-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PL44M4YCALHKJAZCCBN5YPQVOS2ITXXP
X-Message-ID-Hash: PL44M4YCALHKJAZCCBN5YPQVOS2ITXXP
X-MailFrom: francesco@dolcini.it
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PL44M4YCALHKJAZCCBN5YPQVOS2ITXXP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Convert the WM8904 audio CODEC bindings to DT schema.

Compared to the original binding #sound-dai-cells and the missing power
supplies are added. The latter are all required as described in the
datasheet.

Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../devicetree/bindings/sound/wlf,wm8904.yaml | 74 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8904.txt      | 33 ---------
 2 files changed, 74 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
new file mode 100644
index 000000000000..329260cf0fa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wolfson WM8904/WM8912 audio codecs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  Pins on the device (for linking into audio routes):
+  IN1L, IN1R, IN2L, IN2R, IN3L, IN3R, HPOUTL, HPOUTR, LINEOUTL, LINEOUTR,
+  MICBIAS
+
+properties:
+  compatible:
+    enum:
+      - wlf,wm8904
+      - wlf,wm8912
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+  AVDD-supply: true
+  CPVDD-supply: true
+  DBVDD-supply: true
+  DCVDD-supply: true
+  MICVDD-supply: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - AVDD-supply
+  - CPVDD-supply
+  - DBVDD-supply
+  - DCVDD-supply
+  - MICVDD-supply
+
+allOf:
+  - $ref: dai-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "wlf,wm8904";
+            reg = <0x1a>;
+            clocks = <&pck0>;
+            clock-names = "mclk";
+            AVDD-supply = <&reg_1p8v>;
+            CPVDD-supply = <&reg_1p8v>;
+            DBVDD-supply = <&reg_1p8v>;
+            DCVDD-supply = <&reg_1p8v>;
+            MICVDD-supply = <&reg_1p8v>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt b/Documentation/devicetree/bindings/sound/wm8904.txt
deleted file mode 100644
index 66bf261423b9..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8904.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-WM8904 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-  - compatible: "wlf,wm8904" or "wlf,wm8912"
-  - reg: the I2C address of the device.
-  - clock-names: "mclk"
-  - clocks: reference to
-    <Documentation/devicetree/bindings/clock/clock-bindings.txt>
-
-Pins on the device (for linking into audio routes):
-
-  * IN1L
-  * IN1R
-  * IN2L
-  * IN2R
-  * IN3L
-  * IN3R
-  * HPOUTL
-  * HPOUTR
-  * LINEOUTL
-  * LINEOUTR
-  * MICBIAS
-
-Examples:
-
-codec: wm8904@1a {
-	compatible = "wlf,wm8904";
-	reg = <0x1a>;
-	clocks = <&pck0>;
-	clock-names = "mclk";
-};
-- 
2.25.1

