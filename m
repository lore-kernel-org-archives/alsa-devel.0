Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D087C4BA13
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:22:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCE3206E6
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="grYmXAe2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zv3tIkZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCE3206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0687F1616;
	Wed, 26 Feb 2020 17:21:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0687F1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582734161;
	bh=EvCB0bMRBhu7WzGOnGdh+1Nje9yFHfKbig5KLfd/3oI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=grYmXAe261rQubbwggJ3var8lRPojqrUlHJWr0lUC4e2WHl6Ow4wsxfYN7GhICz7w
	 eYv4zjX/TECYdGQFPKKBlblCTvSGJGc9wYdLgyOQ9Kaa38/PcFJjhEsh4I39KG02f4
	 fqjgTtfYlW80pHuVhUQIqqqhj6pPg9wxsCtEr/34=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F35FF8014E;
	Wed, 26 Feb 2020 17:21:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 221D1F80171; Wed, 26 Feb 2020 17:21:48 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6E2DF80089
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 17:21:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6E2DF80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zv3tIkZT"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QGLgFg121430;
 Wed, 26 Feb 2020 10:21:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1582734102;
 bh=qYRk9Qh2iIroRJl+3iF1hS7lDL46mTc+W347ZyPJ/Y4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Zv3tIkZTlNxl061VWhv5IRD7r/Wuj0GamrHOZepyhdddPGavnbn4oblg+TozaglJF
 elHnb96ezQRKVsCR+NwFF3ZFVb1inIxImkuqSOKLXbkEIO90bNcjDbw1nKB2oJqRQt
 7enTOTyUIWoL4Re/TfiSq4ihakWkiPVb9kBgddNs=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01QGLgvT064850
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2020 10:21:42 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 10:21:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 10:21:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QGLgqE074809;
 Wed, 26 Feb 2020 10:21:42 -0600
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [RESEND PATCH for-next 2/3] ASoC: dt-bindings: Add TAS2563 compatible
 to the TAS2562 binding
Date: Wed, 26 Feb 2020 10:16:27 -0600
Message-ID: <20200226161628.29960-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226161628.29960-1-dmurphy@ti.com>
References: <20200226161628.29960-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Dan Murphy <dmurphy@ti.com>
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

Add the Texas Instruments TAS2563 audio amplifier to the TAS262
binding.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
index 658e1fb18a99..94796b547184 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -8,7 +8,7 @@ real time monitoring of loudspeaker behavior.
 Required properties:
  - #address-cells  - Should be <1>.
  - #size-cells     - Should be <0>.
- - compatible:	   - Should contain "ti,tas2562".
+ - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
  - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
  - ti,imon-slot-no:- TDM TX current sense time slot.
 
-- 
2.25.0

