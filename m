Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA392C43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:47:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4442F20857
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hnJUodu7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sc8lp1CH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4442F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A05F1664;
	Fri, 27 Mar 2020 17:30:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A05F1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585326685;
	bh=4jsy/fSCQEZtBM+IpNog+fc6XrxcCp3irpGXrEDl9aE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hnJUodu7CRvwEtMGKCZlZdRO6axIm7LIIvu8Angb7Qle3lU8qlDFLifWMGmz/Rfqk
	 vhMOtQBwLg9kSQP/x8ml6WO2wCWshKYKOC9Oak0UmsigNqUlPSAE7tjCN54YIWoBDc
	 9WuRv4/AiF+f8PqB75zw9DfPNascTI1x2efRZsj8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13691F80147;
	Fri, 27 Mar 2020 17:30:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 326ABF80158; Fri, 27 Mar 2020 17:30:32 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8805AF800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 17:30:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8805AF800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sc8lp1CH"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02RGUNhE049560;
 Fri, 27 Mar 2020 11:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1585326623;
 bh=l5rP1MJ098endPpFd2r/1F4oKnCHZocHpiIjl3Yjeas=;
 h=From:To:CC:Subject:Date;
 b=Sc8lp1CHfGpWMuD27YH+Bcn8tzIN/6RAV4Y2CV1gpPWmzxwl2bh1nDlLUNTieHG8D
 eW6qxaH8zrE5CuyAoKxEAds6hXvClCyw3yh4dMXddAF7OzkRMSKSNMKbAXMlcZbRyG
 55bU/nFPIx8puDDsl3/EWIX42V6nKj8zARloiPQo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02RGUNUc094613
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 27 Mar 2020 11:30:23 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 27
 Mar 2020 11:30:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 27 Mar 2020 11:30:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02RGUMvJ054778;
 Fri, 27 Mar 2020 11:30:22 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH] dt-bindings: sound: tlv320adcx140: Remove undocumented
 property
Date: Fri, 27 Mar 2020 11:24:32 -0500
Message-ID: <20200327162432.17067-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
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

Remove undocumented and unneeded ti,use-internal-reg from the example as
it was an artifact from initial development.  The code does not query
for this property and as the document indicates if areg-supply is
undefined then the internal regulator is used.

Fixes: 302c0b7490cd ("dt-bindings: sound: Add TLV320ADCx140 dt
bindings")
CC: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index 1433ff62b14f..ab2268c0ee67 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -76,7 +76,6 @@ examples:
       codec: codec@4c {
         compatible = "ti,tlv320adc5140";
         reg = <0x4c>;
-        ti,use-internal-areg;
         ti,mic-bias-source = <6>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
       };
-- 
2.25.1

