Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34D3C48BE8
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 13:57:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB1A61241
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB1A61241
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19774169E;
	Wed, 16 Jun 2021 15:56:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19774169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623851833;
	bh=HAnZAoxW7ZgtOzzzm1riyNXI3NSrWJgdT+odTiF6koY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OgV+648tA9UXZHdG9FYqLPYKYVcN8ufzvL8rfJgmkO0y4Iq/meLqL+9JgOCgp3uQy
	 TVhomIcFy+ykSPe5JsxXD9e5h+2Yzb9ee2o9KTXmaWnfUeSKAbROfw7TI9ocfrB7rS
	 aSck3F5hzTvSwAe4z6V8Y8VeScqM+dbH28iUSMM0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1226F8028B;
	Wed, 16 Jun 2021 15:56:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DC3FF802E8; Wed, 16 Jun 2021 15:56:21 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74DB2F80165
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 15:56:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74DB2F80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="dMOuz5qV"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15GDtur2003960; Wed, 16 Jun 2021 08:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=z4ir6OwFS6D0/KhBWykA4un0BnM5Kr4vp3bJU94cqYA=;
 b=dMOuz5qV5HfNYC/fKjVn+CppN+YTU0XS4WxjeVCCHiCyk2zMcPEM3Ihe/bXb+NE5XG7z
 IqGKLjzkmwwUrsMtyGtTy0CMEOvih/t7DeAMLbPR+LUjvMaIFBmdnYJrmVgX/2Lpy3Ul
 ojV78GZJUZqe4DoQ6rS2WJbW2ZWQ70woeFMed03KEgrXM5xsBvAaBUp7O91EvG61BbDF
 0xBKIhKJYUR9Lz+qldZSvSJlcXQ/ndBZNDtCGM23zMfaaEK7IMsNIqHhP0D+stIWju1i
 GjybU6MJ6sgjQz2w2T4XD2bhtd4Joq4FeXRqqzL0oo6Be/e/9zprrah5m+q54998U4q/ 8Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 397ab2gn60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 16 Jun 2021 08:56:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 14:56:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 16 Jun 2021 14:56:07 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.65.68])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5DF2E2B2;
 Wed, 16 Jun 2021 13:56:06 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: cs42l42: Correct definition of CS42L42_ADC_PDN_MASK
Date: Wed, 16 Jun 2021 14:56:04 +0100
Message-ID: <20210616135604.19363-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Vr5Xh5MzxCjSkwp-T4ItcZmvOhW9gSEr
X-Proofpoint-GUID: Vr5Xh5MzxCjSkwp-T4ItcZmvOhW9gSEr
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0
 spamscore=0 mlxlogscore=707 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106160081
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

The definition of CS42L42_ADC_PDN_MASK was incorrectly defined
as the HP_PDN bit.

Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 7bf05ff05f74..206b3c81d3e0 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -79,7 +79,7 @@
 #define CS42L42_HP_PDN_SHIFT		3
 #define CS42L42_HP_PDN_MASK		(1 << CS42L42_HP_PDN_SHIFT)
 #define CS42L42_ADC_PDN_SHIFT		2
-#define CS42L42_ADC_PDN_MASK		(1 << CS42L42_HP_PDN_SHIFT)
+#define CS42L42_ADC_PDN_MASK		(1 << CS42L42_ADC_PDN_SHIFT)
 #define CS42L42_PDN_ALL_SHIFT		0
 #define CS42L42_PDN_ALL_MASK		(1 << CS42L42_PDN_ALL_SHIFT)
 
-- 
2.20.1

