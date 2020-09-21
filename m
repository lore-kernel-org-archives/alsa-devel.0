Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE6C43466
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:39:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB95E20B1F
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="is60BvL9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fh+WCxWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB95E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B58C316BA;
	Mon, 21 Sep 2020 17:38:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B58C316BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600702768;
	bh=2kNYKmC4L369jV0ELF+DNpC2Epdh95RMVViJYbQEhM0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=is60BvL95qIliVz1d5YDOoVI2A2WOYaMQB7Gee/03KccKPmurOTukLQMTLnplPVbF
	 56xoPAePe6ph4dcQyZkwkU8uCtR2/X03pX0eh9adZbDJ+XH8UBCSevMq/nf1XClJt4
	 KfWV6TTyKOeErJUorlRgkEDJclVNMd/aMlwWXeMo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D6EDF80161;
	Mon, 21 Sep 2020 17:38:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 926CBF800B2; Mon, 21 Sep 2020 17:38:36 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C1D6F8010A
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 17:38:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C1D6F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fh+WCxWO"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LFcQqW005002;
 Mon, 21 Sep 2020 10:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600702706;
 bh=T+nRlCqX5IHRf3MYSSGGXbHZiGYKvj0laXcut/LHJ1w=;
 h=From:To:CC:Subject:Date;
 b=fh+WCxWOl72RuOuxnAc3z5Psv7QOfaHDtpgbEzef4TRwxFmsqVccP7/gupzKBidXF
 FALwR0DlIuWQDTVuc39cpwVF4fM5DFwV6FEmK8IJUx3V0S/mR2TyrLVUVVZ894oOWJ
 ff7J8hrB0hlUtRKGKrcg2mjKJuXZXhj/GhLgDTa8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08LFcQSC106713
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Sep 2020 10:38:26 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 10:38:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 10:38:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LFcQWL075280;
 Mon, 21 Sep 2020 10:38:26 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: tas2562: Add the TAS2110 amplifier
Date: Mon, 21 Sep 2020 10:38:19 -0500
Message-ID: <20200921153820.18357-1-dmurphy@ti.com>
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

Add the TAS2110 amplifier compatible.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

This patchset is based on top of patchset https://lore.kernel.org/patchwork/project/lkml/list/?series=463709

 Documentation/devicetree/bindings/sound/tas2562.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index d3ceda356aaa..27f7132ba2ef 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -20,6 +20,7 @@ description: |
     https://www.ti.com/lit/gpn/tas2562
     https://www.ti.com/lit/gpn/tas2563
     https://www.ti.com/lit/gpn/tas2564
+    https://www.ti.com/lit/gpn/tas2110
 
 properties:
   compatible:
@@ -27,6 +28,7 @@ properties:
       - ti,tas2562
       - ti,tas2563
       - ti,tas2564
+      - ti,tas2110
 
   reg:
     maxItems: 1
-- 
2.28.0

