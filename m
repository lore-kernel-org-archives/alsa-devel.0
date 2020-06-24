Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43304C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:53:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77A72077D
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FfEBFzY6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UuIMApBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77A72077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EDED1888;
	Wed, 24 Jun 2020 19:53:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EDED1888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593021236;
	bh=cXJQRNG1rIjncQSzrZOWGrFA51ClBq3VrnQXzl1LhYs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FfEBFzY6xYlMf+IjKUf9z5YJp1ZlQ9NK2/06KhXfr7SmlhxFexPekEcG6U6HCysQc
	 jg2dRGl/NUehfbvGsHpAfGszXZExBWPoKp3dUVUQ+lMaqK859ITuftqOy7hE+XCDC4
	 orsB+bnZU4BKa0alqVp/sncTwU64lqjA1wwW1BAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61A5EF802E0;
	Wed, 24 Jun 2020 19:50:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBEC1F802E3; Wed, 24 Jun 2020 19:50:15 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A30A1F802E1
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 19:50:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A30A1F802E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UuIMApBC"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHo6po045222;
 Wed, 24 Jun 2020 12:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1593021006;
 bh=nvx312mv4VGvwwIjEoy4EfaLo8OvbsRscw5gPQDVBlY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UuIMApBCFrsUafHq38CHPN33dwMXPgJNpII9lsNB6m/ijyTl7/XrdhB3EO6oviq04
 zDezPyB3xAPVKVjR/PivPaJHGkJU88Y4yOfBCvPL5y5TyVW//ffKkmWPDYN2BJjzGQ
 59XUJNwvW2d/2O4ADpmouXYgrB7o27LJwnT9Qa2o=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OHo6R6065119
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jun 2020 12:50:06 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:50:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:50:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHo5r0120431;
 Wed, 24 Jun 2020 12:50:05 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH v6 5/7] dt-bindings: tas2562: Add voltage sense slot property
Date: Wed, 24 Jun 2020 12:49:30 -0500
Message-ID: <20200624174932.9604-6-dmurphy@ti.com>
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

Add a property to configure the slot for the voltage sense monitoring of
the device. Vsense data will be sent to the processor via the slot
defined by the property

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
index fd0ac8636c01..dc6d7362ded7 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -11,6 +11,8 @@ Required properties:
  - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
  - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
  - ti,imon-slot-no:- TDM TX current sense time slot.
+ - ti,vmon-slot-no:- TDM TX voltage sense time slot. This slot must always be
+		     greater then ti,imon-slot-no.
 
 Optional properties:
 - interrupt-parent: phandle to the interrupt controller which provides
@@ -30,5 +32,6 @@ tas2562@4c {
 
 	shut-down-gpio = <&gpio1 15 0>;
         ti,imon-slot-no = <0>;
+        ti,vmon-slot-no = <1>;
 };
 
-- 
2.26.2

