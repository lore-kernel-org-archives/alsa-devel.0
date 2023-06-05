Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219EFC77B73
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jun 2023 14:34:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB24874C;
	Mon,  5 Jun 2023 16:33:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB24874C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685975650;
	bh=wOzyoNeDgnhde/WTWUyO2NFOW8doH4Uyy34rUaE3i34=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Rt0OEYrxEZXaOQ28qe7PJnUFhKYdv6XaZlgMCGCHI2fZNPX1zMG9AosoQzC4CWP4w
	 laZNIm23Lxyb/391ydebMhl7EPDcNnrXAgJI8xiJi0Hb8Mgt6bIX5ZizydokIdlvv/
	 WMG2ZaxlPN2Ft/ws097WF0UJSIicEHEqVRtThgwU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFD6FF80199; Mon,  5 Jun 2023 16:32:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 96B6EF80199;
	Mon,  5 Jun 2023 16:32:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21005F80199; Mon,  5 Jun 2023 16:32:49 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B95CF800ED
	for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2023 16:32:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B95CF800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=E0A7Z1dT
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3558e8mf010267;
	Mon, 5 Jun 2023 09:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=BUg/70VlLSF5CVdl4IkVb4amOpOKudh8xy6hs1SyEI8=;
 b=E0A7Z1dTyhJOn3BxfODvSXLAgR1BU0UwsmtqSmdM12D+s2MVPQl9FaJWx9Hx88K9kTd7
 NsFAYsYM2P9DxKvetl4/rSfcm34Vx+OQadx9B18wJwYMpTYeF+zeILOrwWSikRK+9Q4P
 IFrWcUQStX7w02pqsQPjcXK3OvEoGUZD9AhDfL7b81kUj1zfI+9NPDi9D6Cem1uq2pgn
 x+ho3xgWdiO8zoubvQFGJ0BFKyxpkZUSeeXJC2WaIzQjuw8yf8ZGMQid12Q20boaO8Mj
 mTH+rTKlTBiJnCsQJ56dfM+akTYWqlagOiSObMx52c8+k6n12hvtJ9TIrdnSAro5g3xC wQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xn9y0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jun 2023 09:32:40 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 5 Jun
 2023 15:32:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 15:32:38 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com
 [198.90.251.127])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8E557458;
	Mon,  5 Jun 2023 14:32:38 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cs_dsp: Log correct region name in bin error
 messages
Date: Mon, 5 Jun 2023 15:32:38 +0100
Message-ID: <20230605143238.4001982-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1UcXCkDZowLuqpgA1f1A0IgzBBonALag
X-Proofpoint-GUID: 1UcXCkDZowLuqpgA1f1A0IgzBBonALag
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: X4QHECXOUDOGCOULNNMAMWWIDCJQ2MA7
X-Message-ID-Hash: X4QHECXOUDOGCOULNNMAMWWIDCJQ2MA7
X-MailFrom: prvs=1520472a2a=rf@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X4QHECXOUDOGCOULNNMAMWWIDCJQ2MA7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In cs_dsp_load_coeff() region_name should be set in the XM/YM/ZM
cases otherwise any errors will log the region as "Unknown".

While doing this also change one error message that logged the
region type ID to log the region_name instead. This makes it
consistent with other messages in the same function.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index d7e46a57ecf9..6a9aa97373d3 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -2124,6 +2124,7 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 				   file, blocks, le32_to_cpu(blk->len),
 				   type, le32_to_cpu(blk->id));
 
+			region_name = cs_dsp_mem_region_name(type);
 			mem = cs_dsp_find_region(dsp, type);
 			if (!mem) {
 				cs_dsp_err(dsp, "No base for region %x\n", type);
@@ -2147,8 +2148,8 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 				reg = dsp->ops->region_to_reg(mem, reg);
 				reg += offset;
 			} else {
-				cs_dsp_err(dsp, "No %x for algorithm %x\n",
-					   type, le32_to_cpu(blk->id));
+				cs_dsp_err(dsp, "No %s for algorithm %x\n",
+					   region_name, le32_to_cpu(blk->id));
 			}
 			break;
 
-- 
2.30.2

