Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA817C00140
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Aug 2022 22:13:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 295E01622;
	Thu, 11 Aug 2022 00:13:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 295E01622
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660169637;
	bh=LZG1Yu1e13ZQRx9TpY/AW1Dlp74/GBy7D8ziQvXWB+Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VW1wAAVM+GBq6QZeYfx1LLMnVUIHoIp2z+3yB3a2pF9Ii0n8tGuyeg61/1LgTZo9U
	 YOc/dmUTyl/Pdx+ecq0bW/x2gtGRhJSDiPwtU24M5ZNZ0Sk6JWxo/v4AQ5xGyE8obx
	 YYuoVgtezvQjgUiG28InvaeCNXdHd8TAWDFuWtRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA257F80154;
	Thu, 11 Aug 2022 00:13:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B26D7F801F5; Thu, 11 Aug 2022 00:13:02 +0200 (CEST)
Received: from dev.flatmax.com (unknown
 [IPv6:2406:3400:213:70c0:9df6:7e57:88ce:1bea])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DD05F8012A
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2022 00:12:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DD05F8012A
Received: by dev.flatmax.com (Postfix, from userid 1000)
 id 0E2EC3846DF8; Thu, 11 Aug 2022 08:12:51 +1000 (AEST)
From: Matt Flax <flatmax@flatmax.com>
To: devicetree@vger.kernel.org
Subject: [PATCH v2] ASoC: codecs: dt bind. doc for the new TI SRC4392 codec
Date: Thu, 11 Aug 2022 08:12:32 +1000
Message-Id: <20220810221232.1596488-1-flatmax@flatmax.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 Matt Flax <flatmax@flatmax.com>
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

Signed-off-by: Matt Flax <flatmax@flatmax.com>
---

Notes:
    v2:
    * Added myself as the maintainer

 .../devicetree/bindings/sound/src4xxx.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/src4xxx.yaml

diff --git a/Documentation/devicetree/bindings/sound/src4xxx.yaml b/Documentation/devicetree/bindings/sound/src4xxx.yaml
new file mode 100644
index 000000000000..368bb4ba1a77
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/src4xxx.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/src4xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments SRC4392 Device Tree Bindings
+
+description: |
+  The SRC4392 is a digital audio codec that can be connected via
+  I2C or SPI. Currently, only I2C bus is supported.
+
+maintainers:
+  - Matt Flax <flatmax@flatmax.com>
+
+allOf:
+  - $ref: name-prefix.yaml#
+
+properties:
+  compatible:
+    const: ti,src4392
+
+  "#sound-dai-cells":
+    const: 0
+
+  reg:
+    description:
+      The I2C address of the device
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        src4392@70 {
+            #sound-dai-cells = <0>;
+            compatible = "ti,src4392";
+            reg = <0x70>;
+        };
+    };
+...
-- 
2.34.1

