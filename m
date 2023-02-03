Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1183EC61DA4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Feb 2023 11:15:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E8E9AEA;
	Fri,  3 Feb 2023 12:15:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E8E9AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675422956;
	bh=mji/ytLc7tOYCEPwqs1EmgoUqcX+zNXR6koMZjD50wc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JqB2jNXsRBvAkm49uTks/wphQs/GaTn5Ps3EcoFTpd25VeT+fogdIWgDriYo3HODv
	 euqVwSmAC3vLU8UdxnAOJY8OQxevVeF2hUlYJaRxOdIvsgPbYqXfEkaYbqaEWyrHZC
	 945uVHJmpNM7k79Ld9WDPq9+Q5UgjILncGIx33d0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A544F8047D;
	Fri,  3 Feb 2023 12:14:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC3BBF80519; Fri,  3 Feb 2023 12:14:38 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2137EF80254
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2023 12:14:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2137EF80254
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=UbXmpiwI
Received: (Authenticated sender: herve.codina@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id 172631C001B;
 Fri,  3 Feb 2023 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1675422875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ge7sHeo6XljC/uKf8NYIO4UCkI+QIvq5OQ52h7yZfUg=;
 b=UbXmpiwIu3ZB6+OqqIWbGfPOjGbwGfKL7KdYSW+SquC2V9jkSdxG2VQr36U0xLtXJiaCCk
 JPkt1o9C1KOTlid8qdIFFC9lY6wh1pRvaru66d2cKX+5TkWj3qZQ6N2tEYNwEHd+mSd4SD
 iBC8b8U7B4vjHQA75eRogPEumGJPiGirVL+jb0P60e1AomONNedYXVHEKDALaKTp0euAqb
 H1C5FQ68496XDVXAHxMPc9UM1pESp1GEtmm+BAtdjKXtRnW1FhttXF06RKqwPfVcybzDIt
 241ZpWs6fGx78aYg6F0dDm0HSONM1ss1dtweSpC1wW848jNZ4ZRLNDSShXF8vg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/3] dt-bindings: sound: Add the Renesas X9250 potentiometers
Date: Fri,  3 Feb 2023 12:14:20 +0100
Message-Id: <20230203111422.142479-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203111422.142479-1-herve.codina@bootlin.com>
References: <20230203111422.142479-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The Renesas X9250 is a quad digitally controlled potentiometers.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/renesas,x9250.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,x9250.yaml

diff --git a/Documentation/devicetree/bindings/sound/renesas,x9250.yaml b/Documentation/devicetree/bindings/sound/renesas,x9250.yaml
new file mode 100644
index 000000000000..ad29ef465a18
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/renesas,x9250.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/renesas,x9250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas X9250 quad potentiometers
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The Renesas X9250 is a quad digitally controlled potentiometers.
+
+  In the audio path, it can be present on amplifiers designs and it can be used
+  in ALSA as an auxiliary audio device to control these amplifiers.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: renesas,x9250
+
+  reg:
+    description:
+      SPI device address.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 2000000
+
+patternProperties:
+  "^renesas,cmd[0-3]-invert$":
+    description:
+      The related command is inverted meaning that the minimum command value
+      set the wiper to Rh and the maximum command value set the wiper to Rl.
+      Without this property, the minimum command value set the wiper to Rl and
+      the maximum to Rh.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        x9250@0 {
+            compatible = "renesas,x9250";
+            reg = <0>;
+            spi-max-frequency = <2000000>;
+            renesas,cmd3-invert;
+        };
+    };
-- 
2.39.0

