Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B6EC2D0A3
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:13:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DBF207BB
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IeXjMl+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DBF207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7356A166E;
	Wed,  4 Nov 2020 21:12:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7356A166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604520829;
	bh=A6y3yy9m7cH1cveovCQSDdrh+CsC2xxk9F+ZWr+fhKc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IeXjMl+1HHEQuxH8IQgKOc9jc+RokaMy8373pxKXlQYYpYuJTALAMmghIfxMwxNtA
	 nDVNNcwRbhfv7yRAMH0LSKfVN/EoqtVK+FQDectYo1P1HXSSrXpjSE6ssH51ENeNdN
	 Hzi9Hg+CZusB1TAAh7bpF4jsIz/825tW42/BXEBk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F4011F800EC;
	Wed,  4 Nov 2020 21:12:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE76CF80234; Wed,  4 Nov 2020 21:12:57 +0100 (CET)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25C58F800EC
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 21:12:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25C58F800EC
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr
 [86.194.74.19]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 867C7240002;
 Wed,  4 Nov 2020 20:12:49 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] dt-bindings: sound: adau1372: Add bindings documentation
Date: Wed,  4 Nov 2020 21:12:08 +0100
Message-Id: <20201104201209.907018-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>
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

Add device tree binding documentation for Analog Devices ADAU1372.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Cc: Rob Herring <robh+dt@kernel.org>

 .../bindings/sound/adi,adau1372.yaml          | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1372.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1372.yaml b/Documentation/devicetree/bindings/sound/adi,adau1372.yaml
new file mode 100644
index 000000000000..701449311fec
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau1372.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,adau1372.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+
+title: Analog Devices ADAU1372 CODEC
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.om>
+
+description: |
+  Analog Devices ADAU1372 four inputs and two outputs codec.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADAU1372.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adau1372
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
+    const: "mclk"
+
+  powerdown-gpios:
+    description: GPIO used for hardware power-down.
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@3c {
+                compatible = "adi,adau1372";
+                reg = <0x3c>;
+                #sound-dai-cells = <0>;
+                clock-names = "mclk";
+                clocks = <&adau1372z_xtal>;
+        };
+    };
+
+    adau1372z_xtal: clock {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <12288000>;
+    };
+...
+
-- 
2.28.0

