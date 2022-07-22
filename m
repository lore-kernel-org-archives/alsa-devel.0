Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2865C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jul 2022 10:55:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E082B186B;
	Fri, 22 Jul 2022 12:54:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E082B186B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658487308;
	bh=ULB/0LTVjxXBxKpsv0Yz+1mtf91q05k5SK+ffiilKSg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oCS2l77ZX4A2E7A0hJ6MIvXLOYd3OslVRiEZAAHGqOW6Hsn9IejofxRcVAVLBmWj2
	 ezsvxf9M+AfsJEPiRaO8lrc/8sIURQwd/abHbdDBroQtaSIqlsttyZn1JdZrutVxPq
	 e+TWYefledVsPkUGfpKznrCEHNK4Tg7YA3uCY+Ug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48B00F8023B;
	Fri, 22 Jul 2022 12:54:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB8E4F80246; Fri, 22 Jul 2022 12:54:14 +0200 (CEST)
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95E69F80166
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2022 12:54:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95E69F80166
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from LAPTOP-39QA2GAC.localdomain (unknown[192.163.20.102])
 by rmsmtp-lg-appmail-43-12057 (RichMail) with SMTP id 2f1962da81bc3a1-d0054;
 Fri, 22 Jul 2022 18:54:01 +0800 (CST)
X-RM-TRANSID: 2f1962da81bc3a1-d0054
From: Raphael-Xu <13691752556@139.com>
To: robh+dt@kernel.org
Subject: [PATCH v7] ASoc: dt-bindings: tas2780: remove tas2780 and will merge
 it to tas27xx
Date: Fri, 22 Jul 2022 18:53:45 +0800
Message-Id: <20220722105345.175-1-13691752556@139.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 shenghao-ding@ti.com, kevin-lu@ti.com, broonie@kernel.org,
 Raphael-Xu <13691752556@139.com>, raphael-xu@ti.com
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

remove tas2780

Signed-off-by: Raphael-Xu <13691752556@139.com>
---
 .../devicetree/bindings/sound/tas2780.yaml    | 75 -------------------
 1 file changed, 75 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/tas2780.yaml

diff --git a/Documentation/devicetree/bindings/sound/tas2780.yaml b/Documentation/devicetree/bindings/sound/tas2780.yaml
deleted file mode 100644
index 21389a16fdb9..000000000000
--- a/Documentation/devicetree/bindings/sound/tas2780.yaml
+++ /dev/null
@@ -1,75 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-# Copyright (C) 2020-2022 Texas Instruments Incorporated
-%YAML 1.2
----
-$id: "http://devicetree.org/schemas/sound/tas2780.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
-
-title: Texas Instruments TAS2780 Smart PA
-
-maintainers:
-  - Raphael Xu <raphael-xu@ti.com>
-
-description: |
-  The TAS2780 is a mono, digital input Class-D audio amplifier optimized for
-  efficiently driving high peak power into small loudspeakers.
-  Integrated speaker voltage and current sense provides for
-  real time monitoring of loudspeaker behavior.
-
-properties:
-  compatible:
-    enum:
-      - ti,tas2780
-
-  reg:
-    description:
-       I2C address of the device can be between 0x38 to 0x3f.
-    minimum: 0x38
-    maximum: 0x3f
-
-  reset-gpios:
-    description: GPIO used to reset the device.
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-  ti,imon-slot-no:
-    description: TDM TX current sense time slot.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 3
-
-  ti,vmon-slot-no:
-    description: TDM TX voltage sense time slot.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 3
-
-  '#sound-dai-cells':
-    const: 1
-
-required:
-  - compatible
-  - reg
-
-additionalProperties: false
-
-examples:
-  - |
-   #include <dt-bindings/gpio/gpio.h>
-   i2c0 {
-     #address-cells = <1>;
-     #size-cells = <0>;
-     codec: codec@38 {
-       compatible = "ti,tas2780";
-       reg = <0x38>;
-       #sound-dai-cells = <1>;
-       interrupts = <14>;
-       reset-gpios = <&gpio1 15 0>;
-       ti,imon-slot-no = <0>;
-       ti,vmon-slot-no = <2>;
-     };
-   };
-
-...
-- 
2.35.1


