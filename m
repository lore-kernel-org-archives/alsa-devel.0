Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87231C10DCE
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:29:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090F320873
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Mc/idAcX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="E6e68ev7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090F320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EA1D1655;
	Tue, 10 Mar 2020 20:28:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EA1D1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583868542;
	bh=jWi9zrGbFuDqrlrQTuG6fNSXP6MBXN+Y5nCrdb/KHa8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mc/idAcXtLikLLzLFNlxegCEnLyFkgSZ6Xyufo84ScvlVvdAB4NEGgL7O5aE1c23W
	 Xmt+hvd/RSU3tGamEEjuzEkjzGT0r7VVqF/mq9HxOzIwsF/YvIwE0JjEUlJbPLLeuS
	 EMXyeWby5kM5QEbyWaE82XoXcyM16NlBUgvWU1Xw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7FFBF8020C;
	Tue, 10 Mar 2020 20:28:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A1E0F80217; Tue, 10 Mar 2020 20:28:06 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91210F80123
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 20:27:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91210F80123
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="E6e68ev7"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02AJOKX9005731; Tue, 10 Mar 2020 14:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=2qcbzYtwhuiHBID3Z1kpmlz6CHOFwkeqJRlMF3CqpI4=;
 b=E6e68ev7L7RbiLp2ZLyA1sARDA8ELik0gZVXJuvIBKae+sAvdw5j9tW5XI77mZzxPk+h
 6qxFJ+Rf6BzG4ttexV3NFEDhWqvHREZ17UE6iK0846jyoNOjH0FDOlpjtltiY/4qyQNe
 YP0cfE+f+lcYXaO16dQrEcLmZUIJE8cqC5DlWB5yUOsCp+HQXX1F4ySRmF+IRrJ2A6N4
 4Av4mkXe2WYZ88HXl/N9RsQO1uELvyzlDdl7oHdAlj+7xdOlT3evCCSJpiXDvuW89R9x
 GwGsy6eh3GTfopdhCvSOl7A1eDEDpqVqrOd67rwOYrHCkZLMYWDD0xRWaHo2D3HJe5Tt vw== 
Authentication-Results: ppops.net;
 spf=pass smtp.mailfrom=James.Schulman@cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 2ym9w95b34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 10 Mar 2020 14:27:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 10 Mar
 2020 19:27:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Tue, 10 Mar 2020 19:27:54 +0000
Received: from james-tower.crystal.cirrus.com (james-tower.ad.cirrus.com
 [141.131.206.65])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4022B2AB;
 Tue, 10 Mar 2020 19:27:53 +0000 (UTC)
From: James Schulman <james.schulman@cirrus.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH] MAINTAINERS: Update Cirrus Logic codec driver maintainers
Date: Tue, 10 Mar 2020 14:27:51 -0500
Message-ID: <20200310192751.24487-1-james.schulman@cirrus.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 include:_spf1.cirrus.com include:_spf2.cirrus.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=834 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100114
Cc: brian.austin@cirrus.com, James Schulman <james.schulman@cirrus.com>,
 ckeepax@opensource.cirrus.com, paul.handrigan@cirrus.com,
 david.rhodes@cirrus.com
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

Brian & Paul are no longer active audio codec driver
maintainers. Update list to reflect myself and David
Rhodes as the active maintainers.

Signed-off-by: James Schulman <james.schulman@cirrus.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6fbdf354d34..73f1539d430e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4021,8 +4021,8 @@ F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
 
 CIRRUS LOGIC AUDIO CODEC DRIVERS
-M:	Brian Austin <brian.austin@cirrus.com>
-M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
+M:	James Schulman <james.schulman@cirrus.com>
+M:	David Rhodes <david.rhodes@cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	sound/soc/codecs/cs*
-- 
2.17.1

