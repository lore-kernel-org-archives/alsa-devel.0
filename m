Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EFC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8AE207DD
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cwBGXjZu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H/Fy23zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8AE207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEEF918A4;
	Wed, 24 Jun 2020 19:50:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEEF918A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593021053;
	bh=X9gJlOVmYgX+dnnImHx3UzxP1R9p/y5i+/WcgjNqnrI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwBGXjZuJYnM5QCAQr1YlJMT9YYJq1akVfOVp72twmkdENT2r8haO6Hexx4m8xt4/
	 s/LGbXuhg66nXUbDNN65HNoeoQUe3/2BYzgseVMRWXfTCwEjK6L2fgIF1KpIQft0av
	 nEeko7UPXwSkgardZLP7YdgAlenEQPdTLsVewtck=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05F9BF80276;
	Wed, 24 Jun 2020 19:49:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABA30F80276; Wed, 24 Jun 2020 19:49:51 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00A51F80084
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 19:49:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00A51F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H/Fy23zn"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnho6062623;
 Wed, 24 Jun 2020 12:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1593020983;
 bh=kULjw8GNfWNWdNFzaMSzkxUfYNEK2eh4pWXT0B+D/Fs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=H/Fy23zn1NqDybmM73ewTSCcoaz0B8fPFUVmsLeSba1Mt2M51JHSZEX86z02VWAFw
 nE6Zv7gmPe+0liXImGeWxlWP5xuYFVefa9eE/oCbP14BMyWm32CbYSyiAYjWdZSgcL
 z2u4s58MoqqRA3Wn07ZH4BtWVH+C/07S+HbwuALE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnhXo081997;
 Wed, 24 Jun 2020 12:49:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:49:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:49:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnhee035721;
 Wed, 24 Jun 2020 12:49:43 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH v6 1/7] dt-bindings: tas2562: Fix shut-down gpio property
Date: Wed, 24 Jun 2020 12:49:26 -0500
Message-ID: <20200624174932.9604-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624174932.9604-1-dmurphy@ti.com>
References: <20200624174932.9604-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robh@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Dan Murphy <dmurphy@ti.com>, devicetree@vger.kernel.org
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

Fix the shut-down gpio property to be shut-down-gpio and fix the
example.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
index 94796b547184..fd0ac8636c01 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -16,7 +16,7 @@ Optional properties:
 - interrupt-parent: phandle to the interrupt controller which provides
                     the interrupt.
 - interrupts: (GPIO) interrupt to which the chip is connected.
-- shut-down: GPIO used to control the state of the device.
+- shut-down-gpio: GPIO used to control the state of the device.
 
 Examples:
 tas2562@4c {
@@ -28,7 +28,7 @@ tas2562@4c {
         interrupt-parent = <&gpio1>;
         interrupts = <14>;
 
-	shut-down = <&gpio1 15 0>;
+	shut-down-gpio = <&gpio1 15 0>;
         ti,imon-slot-no = <0>;
 };
 
-- 
2.26.2

