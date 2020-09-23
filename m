Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4BAC2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:27:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902FB206A5
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bcmPnZ/n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uvHtjwIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902FB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8ECB170A;
	Wed, 23 Sep 2020 15:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8ECB170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600867629;
	bh=Wh4FIJr56sJnOhRQweGOmA9v9M9HEfjXiyzHzMDIM3w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bcmPnZ/nSQotqBvBVQc2rtTiJw56yVlkuduw/qWj7jWc82MNYA+NMkoj6dCQgmW3T
	 ZrmO5KlBpkyDVoT8xPHc1MvBFXUONlD2PqizrTEm1RGDNsuTKefb3x/i5y9MA7rM2l
	 Q2RXVpjCg9B2OMkirzCRAjwRwScha/1TqdUzJWuk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 065B4F80162;
	Wed, 23 Sep 2020 15:26:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C9CEF80162; Wed, 23 Sep 2020 15:26:17 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC4C1F8010A
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 15:26:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC4C1F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uvHtjwIY"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQ64I079356;
 Wed, 23 Sep 2020 08:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600867566;
 bh=Jtx9TEjy/J58R+gZ76e1lApC4KJGiqGlJ+iQaXtH5Gw=;
 h=From:To:CC:Subject:Date;
 b=uvHtjwIYQv/sIz+smzPyt/5E1AgK0UvhBg/WOCgn0XvAgE8WrGK/QO3aoWTVmg/t1
 tOQpuv1ZKS07yFKWvDaBBY/H34GdX0fUsgzAfBPh65cGyLhr6CTxkRDafcreA6Lx1+
 BiuVbM4BGWu/2pEIZSW/3uCPuulocxq+xuKUEI40=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NDQ6Vs045148
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Sep 2020 08:26:06 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 08:26:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 08:26:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQ6dZ050553;
 Wed, 23 Sep 2020 08:26:06 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
Subject: [PATCH 1/6] dt-bindings: tas2770: Add shutdown gpio property
Date: Wed, 23 Sep 2020 08:25:55 -0500
Message-ID: <20200923132600.10652-1-dmurphy@ti.com>
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

Add the shutdown-gpios property to the yaml to define the GPIO that can
be used to place the device in shutdown mode or wake the device up.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2770.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index bb26d081c9fa..9fdf614add55 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -29,6 +29,9 @@ properties:
   reset-gpio:
     description: GPIO used to reset the device.
 
+  shutdown-gpios:
+    description: GPIO used to control the state of the device.
+
   interrupts:
     maxItems: 1
 
@@ -69,6 +72,7 @@ examples:
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpio = <&gpio1 15 0>;
+       shutdown-gpios = <&gpio1 14 0>;
        ti,imon-slot-no = <0>;
        ti,vmon-slot-no = <2>;
      };
-- 
2.28.0

