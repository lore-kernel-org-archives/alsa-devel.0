Return-Path: <SRS0=gvoF=NC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A598CC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 19:01:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D78610A4
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 19:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58D78610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D5CF17D7;
	Wed, 11 Aug 2021 21:00:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D5CF17D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628708492;
	bh=cUhIIEH0SclylOQXB8syfQ51Xt8G5NjVL8rzT0vTDEQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GpH4l9UBTaiHPTrXiKYzKdjhLP7g8cndEfaapZ+NyjmGCZypAbvWSQmzh0KQd1EP6
	 3f9/msjkTd1nfgfOyzuwDd/YAApOjK5ghairOR77K8pDkFbp4nS03c0PYQT/jrKn2n
	 /vC4oeMDQbPuVomIcOuBkYhLreRF1peccD9DWzRk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AADF5F80524;
	Wed, 11 Aug 2021 20:57:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9CF4F80510; Wed, 11 Aug 2021 20:57:46 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B004F804B4
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 20:57:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B004F804B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Y5HXUx7s"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17BIq9wl001296; 
 Wed, 11 Aug 2021 13:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=awilKzSw3qZlWxNowWBgqv9Ed/o7D2qPqYYTaJjzmVM=;
 b=Y5HXUx7s3loVaUQDvJBmqnNJCDsizvQ5q2L650zQPgfX/fOL+IZEp/+4sDTTZEdIwt5w
 4TDTOmFpN6HlKzh8ImfBvJ9+A/Y40LimQ46m392G/0YWhnfZFbWcMsQYsRE90fALwtpb
 Y1wYtJ0cJQqnFDHDE/S1hDO3plYmWMd/lVGIuNRWby7hQpjePxr1BXnv6voAQMjyJOSy
 QxmgpdysGi/QEC2unltlSs8JEYUShFmXTTOFRJe/UuVMGU3wUjHYM3w1EPUZY06QSd62
 SjQAoaVifZOLN2ZIh8pwPnMqWdDglzEqsKcpCW/xhUCVO6X+JinASmbhBRatk4oTRoJb rQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3acgjkra4r-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 11 Aug 2021 13:57:31 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Wed, 11 Aug 2021 19:57:26 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 86D2645D;
 Wed, 11 Aug 2021 18:57:26 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v4 04/27] ALSA: hda/cs8409: Mask all CS42L42 interrupts on
 initialization
Date: Wed, 11 Aug 2021 19:56:31 +0100
Message-ID: <20210811185654.6837-5-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: od5XfxIhQKIrrsnbO4KY-JxgfqZ_dmNT
X-Proofpoint-ORIG-GUID: od5XfxIhQKIrrsnbO4KY-JxgfqZ_dmNT
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110130
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Stefan Binding <sbinding@opensource.cirrus.com>
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

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409-tables.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 5766433325a9..91b6a5b2824a 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -159,6 +159,18 @@ const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ 0x1105, 0x00 },
 	{ 0x1112, 0xC0 },
 	{ 0x1101, 0x02 },
+	{ 0x1316, 0xff },
+	{ 0x1317, 0xff },
+	{ 0x1318, 0xff },
+	{ 0x1319, 0xff },
+	{ 0x131a, 0xff },
+	{ 0x131b, 0xff },
+	{ 0x131c, 0xff },
+	{ 0x131e, 0xff },
+	{ 0x131f, 0xff },
+	{ 0x1320, 0xff },
+	{ 0x1b79, 0xff },
+	{ 0x1b7a, 0xff },
 	{} /* Terminator */
 };
 
-- 
2.25.1

