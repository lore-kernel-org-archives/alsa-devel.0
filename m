Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D066C28D13
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Aug 2022 14:06:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 453A915E5;
	Thu, 25 Aug 2022 16:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 453A915E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661436359;
	bh=lKx4eqhOZ7bV32gAHAxM3bz8qurI2i74vxW4Y0JQzgI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AdAGjHA07eVJ17aKiVD4DEWsXyTrKBfqEIYSyiv9EVi70/6xO2JxlefYGkXa7StUX
	 kTc2ayE0LN3hZD3yV+3PreRESF/PXjagxtktKej7atUtLG4YIqZcmAdUw92E0DGNo8
	 U4vb/1ZKWXCbc1Y65pYn4HIoUvcvIzOIIjPrXjGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97C42F8025A;
	Thu, 25 Aug 2022 16:04:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B150F8052D; Thu, 25 Aug 2022 16:04:55 +0200 (CEST)
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa1.perex.cz (Postfix) with ESMTP id DA205F80245
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2022 16:04:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA205F80245
Received: from hq-00021.fritz.box (p57bc9ceb.dip0.t-ipconnect.de
 [87.188.156.235])
 by mail.bugwerft.de (Postfix) with ESMTPSA id EEEEF4210DB;
 Thu, 25 Aug 2022 14:04:17 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: broonie@kernel.org,
	ryan.lee.analog@gmail.com
Subject: [PATCH v2 1/2] ASoC: dt-bindings: max98396: Document data monitor
 properties
Date: Thu, 25 Aug 2022 16:04:11 +0200
Message-Id: <20220825140412.2297211-1-daniel@zonque.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>
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

This device features a data monitor that puts the device in software reset
upon a configurable set of events.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
v1 -> v2: fix a typo and remove a stray blank line

 .../bindings/sound/adi,max98396.yaml          | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/adi,max98396.yaml b/Documentation/devicetree/bindings/sound/adi,max98396.yaml
index 8d2ef991db40..f4eefe10c494 100644
--- a/Documentation/devicetree/bindings/sound/adi,max98396.yaml
+++ b/Documentation/devicetree/bindings/sound/adi,max98396.yaml
@@ -78,6 +78,43 @@ properties:
       interleaved on a single output channel.
     type: boolean
 
+  adi,dmon-stuck-enable:
+    description:
+      Enables the "data monitor stuck" feature. Once the data monitor is
+      enabled, it actively monitors the selected input data (from DIN) to the
+      speaker amplifier. Once a data error is detected, the data monitor
+      automatically places the device into software shutdown.
+    type: boolean
+
+  adi,dmon-stuck-threshold-bits:
+    description:
+      Sets the threshold for the "data monitor stuck" feature, in bits.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [9, 11, 13, 15]
+    default: 15
+
+  adi,dmon-magnitude-enable:
+    description:
+      Enables the "data monitor magnitude" feature. Once the data monitor is
+      enabled, it actively monitors the selected input data (from DIN) to the
+      speaker amplifier. Once a data error is detected, the data monitor
+      automatically places the device into software shutdown.
+    type: boolean
+
+  adi,dmon-magnitude-threshold-bits:
+    description:
+      Sets the threshold for the "data monitor magnitude" feature, in bits.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [2, 3, 4, 5]
+    default: 5
+
+  adi,dmon-duration-msecs:
+    description:
+      Sets the duration for the "data monitor" feature, in milliseconds.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [64, 256, 1024, 4096]
+    default: 64
+
   reset-gpios:
     maxItems: 1
 
-- 
2.37.2

