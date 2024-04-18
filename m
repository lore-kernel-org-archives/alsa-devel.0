Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55972C4345F
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Apr 2024 10:34:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55B6CE85;
	Thu, 18 Apr 2024 12:33:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55B6CE85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713436441;
	bh=fXyGjhAm0JIkMbjnAel3FGNCVvKR94WIGzZRwngByII=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=iemc8YmsVBs1tBe6YpL71LgLCi9d1CcLScKYNS3VJJ4h1WWv4hYvf+h7MWTQoI4aI
	 KTIst0J1gIcx0W8VoQKF/JNAlEkBQ4PDriE57FXFzaYnzpkgriD2sKJvDiDL2lPcx5
	 rT5BCgYEsX9qj29vws1AHugiDJONOb/AJvconKk0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D70EF80580; Thu, 18 Apr 2024 12:33:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 343DAF80578;
	Thu, 18 Apr 2024 12:33:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD7EAF80236; Thu, 18 Apr 2024 12:33:24 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6824AF8003A
	for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2024 12:33:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6824AF8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=pydh4FwE
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id
 43I5jALP019878;
	Thu, 18 Apr 2024 05:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=j
	z5Rie3do+TgO9XWh4Mv9YDCnGPamrE2rEo8a/X/MDM=; b=pydh4FwEJLg1Qny7B
	eNSffSk6r0c+l22PehWiFHSC4f05Fxn/c4SbOvtZ0bs/oMp0WZZ0aRSxPSyTn3P3
	/RraFWKt823nGKkzRKq7QO/c27Y/RcESVC87hVQWSle6+FdYlA2SPJ8OJjdNO18R
	nPJu6Qn2ygM2BDnJux3yM4PlR+NmWCM7LVUEYMRdl4tRHSig0JpzWqsQuFwLPhW6
	800ZQjuBXDBZxiNAeKF1mMF7KpMKyCVog5+oGf7zm/r5oAzw7pKn9sJd2LU59Jli
	+vxnw4xkDUwnJS9r8Tp2T7495SMuAC2KLn2hBuwRPJh/iKGaR0yJfjzmIgbbuQW8
	bZG5g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhvmqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:33:19 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 11:33:17 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 18 Apr 2024 11:33:17 +0100
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com
 [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4BA24820245;
	Thu, 18 Apr 2024 10:33:17 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek
	<mstrozek@opensource.cirrus.com>
Subject: [PATCH v2] spi: cs42l43: Correct name of ACPI property
Date: Thu, 18 Apr 2024 11:33:15 +0100
Message-ID: <20240418103315.1487267-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: URX_4b8_yisaN-CnDypzhKTNTYFAWsep
X-Proofpoint-GUID: URX_4b8_yisaN-CnDypzhKTNTYFAWsep
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: QVIENJBMPNF5JMGT4XGH2BUJOJSXZ5ZE
X-Message-ID-Hash: QVIENJBMPNF5JMGT4XGH2BUJOJSXZ5ZE
X-MailFrom: prvs=183834ae71=mstrozek@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QVIENJBMPNF5JMGT4XGH2BUJOJSXZ5ZE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
v2: Corrected the Fixes tag to point to right commit

 drivers/spi/spi-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index cdc61cd089ad..9d747ea69926 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -267,7 +267,7 @@ static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
 			continue;

 		ret = fwnode_property_read_u32(ext_fwnode,
-					       "01fa-cirrus-sidecar-instances",
+					       "01fa-sidecar-instances",
 					       &val);

 		fwnode_handle_put(ext_fwnode);
--
2.34.1

