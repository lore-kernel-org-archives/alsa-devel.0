Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E9BC2BD09
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:54:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC24B850;
	Tue,  9 Jul 2024 16:53:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC24B850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720536840;
	bh=w6bnO4FXGLkv0kiWma3TyTD9lix6tsitqIFPbJa90q8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=A6czPYy/roVSWUyyCVqIXdhBM3KkesS8f7pU9y0ijHiSQ0LdWdI/8MeZSnqysrgS4
	 8vT94qhBoG8+EIx3+z5e1JIVYWFF4DFJwdo5/AEpK+AzkE8L1eYyJQBbw1rmIZWRaG
	 mY3ohbDs8ph6DVFdSw2/Qgjq6lbWKQWvVfxTmaf0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E49E5F80606; Tue,  9 Jul 2024 16:53:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA36BF805E0;
	Tue,  9 Jul 2024 16:53:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5445DF804FC; Tue,  9 Jul 2024 16:52:11 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1F2C8F80074
	for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2024 16:52:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F2C8F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=VUws4sia
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id
 4699SgHc015345;
	Tue, 9 Jul 2024 09:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=y76QHNI6/5GC9gzkTC3WfDuRlPen11I/0SbKaKMkNqM=; b=
	VUws4siaXvIgH8n/5KY2eRNsHN1kOazRMM2FjxnGmoQz1D3aIxVTnuRslCkxSxmb
	2j2/JvBh8P2gPrFESl66f2OfYo20qq1TJ0y4pWd0Sg5WWPs38DRA2Tz8FaBD3f+U
	0qkK+RMe6das0eeZBmLI5VtaQLZq/UfgUM69iLwzOhPAYNvD9HruF1lrJkwr10fY
	wT7vEDUAdltc7y6V+9Qv0tCDGavpBF+jePjutW4ombpyBEK69ZfgVjYHg2UQGD5n
	RCwW2Hl75SLj5vgwUUcXH+8P7Vhk+M27Pb5q8diU2ElXbPdfjdmrAvvAEq0fVyOI
	JE0Y0oDzDLoVgdLxfoVmaw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4073axtqjf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:52:00 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 15:51:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Jul 2024 15:51:57 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com
 [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 17D36820258;
	Tue,  9 Jul 2024 14:51:57 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 3/4] firmware: cs_dsp: Merge wmfw format log message into INFO
 message
Date: Tue, 9 Jul 2024 15:51:55 +0100
Message-ID: <20240709145156.268074-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240709145156.268074-1-rf@opensource.cirrus.com>
References: <20240709145156.268074-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hsy1gjFLOG2l16JQZJITqkqtyPPGJWSr
X-Proofpoint-GUID: hsy1gjFLOG2l16JQZJITqkqtyPPGJWSr
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: P5LHVJPTJD3FDGSDIPPLLTBHDCZTPN3W
X-Message-ID-Hash: P5LHVJPTJD3FDGSDIPPLLTBHDCZTPN3W
X-MailFrom: prvs=4920b5cb13=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P5LHVJPTJD3FDGSDIPPLLTBHDCZTPN3W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Log the WMFW file format version with the INFO_TEST message.

The behaviour of firmware controls depends on the WMFW format version,
so this is useful information to log for debugging. But there's no
need to use a separate log line just for this value.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 1bc2e0b6d40b..141a6c9d6737 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1502,7 +1502,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		goto out_fw;
 	}
 
-	cs_dsp_info(dsp, "Firmware version: %d\n", header->ver);
 	dsp->fw_ver = header->ver;
 
 	if (header->core != dsp->type) {
@@ -1552,7 +1551,7 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		case WMFW_INFO_TEXT:
 		case WMFW_NAME_TEXT:
 			region_name = "Info/Name";
-			cs_dsp_info(dsp, "%s: %.*s\n", file,
+			cs_dsp_info(dsp, "%s (rev %d): %.*s\n", file, dsp->fw_ver,
 				    min(le32_to_cpu(region->len), 100), region->data);
 			break;
 		case WMFW_ALGORITHM_DATA:
-- 
2.39.2

