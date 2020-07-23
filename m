Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B5CC433E5
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3229622B43
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MmSBglKA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C0nj4Eke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3229622B43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0F171683;
	Thu, 23 Jul 2020 18:09:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0F171683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595520640;
	bh=67+I9rV2CRyhAc4T1aCMSgR1gX1CX7g28hJKo0orWWQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MmSBglKAC/jpYOONcMRFeZKSXM7o5iOhpoArwPvEwpDvOdkHvxdWv7+qg9OrKSMBT
	 qyN+PgSvp4L3L9SJEACcQeK509jP9fztOyW59BrdxeiOu9Yqiee7dVO/Qy/9xR8iXA
	 XA0lPAa1ZAXbxtwqeUTnevufbEu+9U5g9N4hM4o4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29557F80268;
	Thu, 23 Jul 2020 18:09:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81593F8020D; Thu, 23 Jul 2020 18:08:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D66E7F8011F
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 18:08:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D66E7F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C0nj4Eke"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06NG8i0c021763;
 Thu, 23 Jul 2020 11:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1595520524;
 bh=uP42COOHI/Gb4zZlyWVEyG3GF7JuWum+Uudtqa+M438=;
 h=From:To:CC:Subject:Date;
 b=C0nj4EkeRMpoGFNE/j6P9HXwL0H1YiPzKFjxv0zRFEiH9wiJLayHYhHIr+id3Tg5s
 dADze4YYT+SkKCA3DTbG/8UfjnZGH5Wqm+8AFvnnrcpY6CWONOOBGAMRZdmV0WZwZi
 2LJOf5XJCQegBNdpi9jeSspaFw2OWVQJtCCrL00A=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06NG8iH7103767
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Jul 2020 11:08:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 11:08:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 11:08:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06NG8hsm002451;
 Thu, 23 Jul 2020 11:08:43 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: tas2562: Convert the tas2562 binding to
 yaml
Date: Thu, 23 Jul 2020 11:08:37 -0500
Message-ID: <20200723160838.9738-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
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

Convert the TAS2562 text file to yaml format.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tas2562.yaml    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
new file mode 100644
index 000000000000..8d75a798740b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/tas2562.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Texas Instruments TAS2562 Smart PA
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
+  efficiently driving high peak power into small loudspeakers.
+  Integrated speaker voltage and current sense provides for
+  real time monitoring of loudspeaker behavior.
+
+properties:
+  compatible:
+    enum:
+      - ti,tas2562
+      - ti,tas2563
+
+  reg:
+    maxItems: 1
+    description: |
+       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
+
+  shut-down-gpios:
+    description: GPIO used to control the state of the device.
+    deprecated: true
+
+  shutdown-gpios:
+    description: GPIO used to control the state of the device.
+
+  interrupts:
+    maxItems: 1
+
+  ti,imon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TDM TX current sense time slot.
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c0 {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec: codec@4c {
+       compatible = "ti,tas2562";
+       reg = <0x4c>;
+       #sound-dai-cells = <1>;
+       interrupt-parent = <&gpio1>;
+       interrupts = <14>;
+       shutdown-gpios = <&gpio1 15 0>;
+       ti,imon-slot-no = <0>;
+     };
+   };
+
-- 
2.27.0

