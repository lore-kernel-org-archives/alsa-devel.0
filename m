Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1800CC4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:20:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1381C206DB
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YDPB6NbO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KKLw2OZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1381C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D683A186D;
	Fri, 25 Sep 2020 11:19:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D683A186D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601025639;
	bh=TYaWEUuXgf8SrFir2JFSOxoxU7ix8kQv7VvBHRxTODE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YDPB6NbO/6VKXbTgr3oXXi1lbslIGDDHUPdCXwXu9nYfGZOUAcpa6mSPM2P6Tdk/R
	 UMzWRg/w8LpavXDhKqP7PKWImy2LgT71VG3j9/EaiGVp4Y0/0VZ1uvuabcP1TM9B5p
	 YjX/5l3wU3T+C7vsXT9UMGb/xPS/q0ppeAdeAZIk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D7C8F801EC;
	Fri, 25 Sep 2020 11:19:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E68E6F80254; Fri, 25 Sep 2020 11:19:01 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 555C0F801EC
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 11:18:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 555C0F801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="KKLw2OZc"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 08P9GBBf003459; Fri, 25 Sep 2020 04:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=J72k7oataLeTskram+R5dvF7s3C8RVc9QykzHum188Y=;
 b=KKLw2OZcr3tgf+C1fgM/ZVC1+vALW1FF8VJoxYzKw2FFdbg4DaxZqkFRmptWKd3/nGMj
 GemIPOXcjjXtXsLrBDhE4tSF/NPN2x333JsN3zQpuJLf4PEnbZBNcaR9FgbzGK1USZUP
 DwB9pxKW/brbrHxnZONKdSCuDzzBgOP3foWjd4teMqW1qsTRKM7IuDYM1R5cWrV9gOQG
 DMKi9Jbw4rIqcNBsvKGCpTdwTVQGAM8ox2n6/eyDmmO4mU/saf0l0OCgWxWqKX0lEoCG
 4ZPLcAsK6OaCCxuGOIdJyWTsE06G4I2/Be7gKMMrzLWsJgK1GuYgp9kkj1hAgMTitZlb Rg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 33nedn7te4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 25 Sep 2020 04:18:42 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 10:18:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 25 Sep 2020 10:18:36 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com
 [198.61.64.158])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7DE2D2A1;
 Fri, 25 Sep 2020 09:18:36 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: cs47l35: Fix EPOUT->HPOUT1 Mono Mux routing
Date: Fri, 25 Sep 2020 10:18:30 +0100
Message-ID: <20200925091830.7675-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925091830.7675-1-rf@opensource.cirrus.com>
References: <20200925091830.7675-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=910 suspectscore=1 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250065
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

EPOUT is always mono so should have a permanent routing through the
HPOUT1 Mono Mux.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs47l35.c b/sound/soc/codecs/cs47l35.c
index 7f5dd01f40c9..e967609da8a3 100644
--- a/sound/soc/codecs/cs47l35.c
+++ b/sound/soc/codecs/cs47l35.c
@@ -1305,6 +1305,7 @@ static const struct snd_soc_dapm_route cs47l35_dapm_routes[] = {
 	{ "SPKOUTP", NULL, "OUT4L" },
 
 	{ "OUT1R", NULL, "HPOUT1 Mono Mux" },
+	{ "HPOUT1 Mono Mux", "EPOUT", "OUT1L" },
 
 	{ "HPOUTL", "HPOUT", "HPOUT1 Demux" },
 	{ "HPOUTR", "HPOUT", "HPOUT1 Demux" },
@@ -1550,7 +1551,6 @@ static irqreturn_t cs47l35_adsp2_irq(int irq, void *data)
 
 static const struct snd_soc_dapm_route cs47l35_mono_routes[] = {
 	{ "HPOUT1 Mono Mux", "HPOUT", "OUT1L" },
-	{ "HPOUT1 Mono Mux", "EPOUT", "OUT1L" },
 };
 
 static int cs47l35_component_probe(struct snd_soc_component *component)
-- 
2.20.1

