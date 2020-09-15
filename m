Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9AAC2D0E0
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:09:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD942078E
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EM8q1OC6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f+eXQdfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD942078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DB531694;
	Tue, 15 Sep 2020 21:08:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DB531694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600196970;
	bh=LnLrweuDDGN9zLmtGzgdvCrZR+MH3yUMQX6AOYqFQ+k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EM8q1OC6SibsTxsZ/UFwuxO/1h2QYunKI0SQZRpJyfAqvn4abwMJMVeHZXzNa9RuW
	 9aZ+R4vroT6m1QUxgT9G6z1jnOL6w8+zzg1vcy7f8lGax0VtDOgOVznmFd7KxRg/Oh
	 VbsQjCSFYwOQ8MoyfpVF8Gu2Uw81yBjV6AZFPQRk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7F1DF802E0;
	Tue, 15 Sep 2020 21:06:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B802F802E2; Tue, 15 Sep 2020 21:06:42 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66B89F802DF
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 21:06:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66B89F802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f+eXQdfT"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6Yx1060938;
 Tue, 15 Sep 2020 14:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600196794;
 bh=lfBspNnpVGK9fOkXASWVZnL//G/ZoFt7Tt8VaXOOno0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=f+eXQdfTJJPzfZ18SP6Yppv/ZTZ/M8SnbGBwRIuXdaalF2w1f7DFZMjXBl3f5iH/0
 Ovj6VPYU85xQA1Loly7Z5ZePVTi6T7i7Xfi9FydFLeh5+qKXGHpmwosdzqu5NAbRLA
 Rxf8L3EuUYRYdS+0jaRDoN0+1XmFP0J3AqUZ1sRM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6Yp9039687;
 Tue, 15 Sep 2020 14:06:34 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 14:06:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 14:06:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6YED008324;
 Tue, 15 Sep 2020 14:06:34 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
Subject: [PATCH 5/6] dt-bindings: tlv320adcx140: Add slot programming property
Date: Tue, 15 Sep 2020 14:06:05 -0500
Message-ID: <20200915190606.1744-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200915190606.1744-1-dmurphy@ti.com>
References: <20200915190606.1744-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>, camel.guo@axis.com
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

Add a property to configure the each channel to a specific TDM slot.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/sound/tlv320adcx140.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index e79f8d1891e4..dfc00308da94 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -114,6 +114,24 @@ properties:
       When set the device will set the Tx ASI output to a Hi-Z state for unused
       data cycles. Default is to drive the output low on unused ASI cycles.
 
+  ti,slot-mapping:
+    type: boolean
+    description: |
+      Each channel can be assigned a specific TDM slot for either a left or
+      right channel. The left channel values are from 0-31d and the right
+      channel values are from 32-63d. If the right channel value is 32 then the
+      right channel slot will be slot 31.
+      The array index is sequential audio channel to be set.
+      [ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8]
+      If the channel is not to be used then the channel should be set to it's
+      default value.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    items:
+      maximum: 63
+    default: [0, 1, 2, 3, 4, 5, 6, 7]
+
 patternProperties:
   '^ti,gpo-config-[1-4]$':
     $ref: /schemas/types.yaml#/definitions/uint32-array
-- 
2.28.0

