Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C983BC04A68
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jul 2022 03:57:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2F231632;
	Thu, 28 Jul 2022 05:56:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2F231632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658980649;
	bh=sxwVMh/Ra+cYlUZIp5wupX/OrmGnm876oar4r+QM7no=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XFffS0aogMAOBeifeqNlA6w3Uko/8rbU3uHYCdSdKJrrmjHcOF4WH8WfAnXxgzfmJ
	 d2/8o/2W3dg5HEt6mVkK5xKojbw5kVEZ7We8tvZXftFO94cH/ECQ88Ha4dcbB0LT4E
	 /GpL2Rke3e68TcrWNImgk1/l59mbkJIAiDnSepGQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CB8BF80430;
	Thu, 28 Jul 2022 05:56:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07F08F804EC; Thu, 28 Jul 2022 05:56:38 +0200 (CEST)
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB867F8015B
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2022 05:56:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB867F8015B
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from LAPTOP-39QA2GAC.localdomain (unknown[192.163.20.102])
 by rmsmtp-lg-appmail-31-12045 (RichMail) with SMTP id 2f0d62e208dbae7-16378;
 Thu, 28 Jul 2022 11:56:24 +0800 (CST)
X-RM-TRANSID: 2f0d62e208dbae7-16378
From: Raphael-Xu <13691752556@139.com>
To: robh+dt@kernel.org
Subject: [PATCH v1] ASoc: dt-bindings: tas27xx: update maximum I2C address and
 revise the format
Date: Thu, 28 Jul 2022 11:56:10 +0800
Message-Id: <20220728035610.158-1-13691752556@139.com>
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

1.use correct maximum I2C address 2.revise the format

Signed-off-by: Raphael-Xu <13691752556@139.com>
---
 .../devicetree/bindings/sound/tas27xx.yaml       | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas27xx.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
index 66a0df8850ea..573652577462 100644
--- a/Documentation/devicetree/bindings/sound/tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/tas27xx.yaml
@@ -8,7 +8,7 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: Texas Instruments TAS2764/TAS2780 Smart PA
 
 maintainers:
-  - Shenghao Ding <shenghao-ding@ti.com>
+  - Raphael Xu <raphael-xu@ti.com>
 
 description: |
   The TAS2764/TAS2780 is a mono, digital input Class-D audio amplifier
@@ -23,17 +23,19 @@ properties:
       - ti,tas2780
 
   reg:
-    maxItems: 1
     description: |
-       I2C address of the device can be between 0x38 to 0x45.
+       I2C address of the device can be between 0x38 to 0x3f.
+    minimum: 0x38
+    maximum: 0x3f
 
   reset-gpios:
-    maxItems: 1
     description: GPIO used to reset the device.
+    maxItems: 1
 
   shutdown-gpios:
+    description: |
+       GPIO used to control the state of the device.Only for TAS2764.
     maxItems: 1
-    description: GPIO used to control the state of the device.
 
   interrupts:
     maxItems: 1
@@ -41,10 +43,14 @@ properties:
   ti,imon-slot-no:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: TDM TX current sense time slot.
+    minimum: 0
+    maximum: 3
 
   ti,vmon-slot-no:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: TDM TX voltage sense time slot.
+    minimum: 0
+    maximum: 3
 
   '#sound-dai-cells':
     const: 1
-- 
2.35.1


