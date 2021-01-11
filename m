Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71350C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:39:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0744221FD
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0744221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CAD016D3;
	Mon, 11 Jan 2021 14:38:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CAD016D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610372376;
	bh=dt2i6oHAQEj79hx3zJYnr/ztPsyhurC6JViEWtRR/9I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SiHhXajH+tjOu8Frh0TFhSAMV8dd6LIf7y9BF8ENXuq2MGXt61FquK0SUQ4sX2AVi
	 iivD8P0W9uMFHktMq8FUSrBeeb7msk8MHn7zbsaI1MRfhOPNvWLF0gAuTLRi25AiJ4
	 Qs+F8wYyJ+FlUX3PvXrT0SwoGNF87/ibb+xgOkus=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A76B1F8016C;
	Mon, 11 Jan 2021 14:38:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09D5CF8016D; Mon, 11 Jan 2021 14:38:43 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8848F8013D
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 14:38:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8848F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="MHVILp82"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10BDaN87021911; Mon, 11 Jan 2021 07:38:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=dj/afU35e9If0LpEXtndT0z7ZC1EFJEfmUbXASkboj8=;
 b=MHVILp821vdOdbtDE/WQP0PUo2Yu/mlmr/7Ea83MmNBb1RO2rZgF8kqymhdSw75KM5gs
 BXlHSlb7KEVjDp9NXux/deoyW6+OuL6FqB+3Ur40dtrtnIK+DlADEt0WknQ1JgxlbyWh
 4R4CSn2A9gmBFv/RIvIEPz9dSze+IY+4WJYBTzQmziXO1a3eZ+zXPrixeZsndtdjgce2
 w+cRxxrclMTB+MdKyA85/FLH7nABozfMfyzNg9njdKHUYOhZwmXYBvUo4VOBfzMFCknp
 iZU32+eV8jWV07fSKi4kn18VE8HcHuGTY/I9/mqJZisQXyYzf2tW1dPw3g+WS07tDC2B 1w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 35y9srt3v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 11 Jan 2021 07:38:31 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 Jan
 2021 13:38:29 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 11 Jan 2021 13:38:29 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.65.3])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E3F0F45;
 Mon, 11 Jan 2021 13:38:28 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: wm_adsp: Fix uninitialized variable warnings
Date: Mon, 11 Jan 2021 13:38:25 +0000
Message-ID: <20210111133825.8758-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110082
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

wm_adsp_read_data_word() used if (ret) to check for an error from
wm_adsp_read_raw_data_block(). While this is perfectly valid,
wm_adsp_read_raw_data_block() itself uses if (ret < 0) and three
calls to wm_adsp_read_data_word() also use if (ret < 0).

This creates an error check chain like this:

  1st) if (ret < 0) return ret;
  2nd) if (ret) return ret;
  3rd) if (ret < 0) ...

This can confuse the compiler into thinking that there are possible
returns > 0 from the middle if() that are not handled by the final
if(). If this was true it would lead to using uninitialized variables
later in the outer function.

Fix this by changing the test in wm_adsp_read_data_word() to be
if (ret < 0).

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f8ad768364c2..1fc7bc1970ea 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3694,7 +3694,7 @@ static inline int wm_adsp_read_data_word(struct wm_adsp *dsp, int mem_type,
 	int ret;
 
 	ret = wm_adsp_read_raw_data_block(dsp, mem_type, mem_addr, 1, &raw);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	*data = be32_to_cpu(raw) & 0x00ffffffu;
-- 
2.20.1

