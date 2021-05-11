Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B1DC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:00:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4883361625
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4883361625
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E6BE18A5;
	Tue, 11 May 2021 19:59:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E6BE18A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620756019;
	bh=hlJ5PiHWfmQkSjGNsTOjPaEoWWYj2P7a+7hc5E9dhOw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WLWraZshbModhl9RpppegcSgQdE3VWJL++m9e+XeOMDpRBIcJOQF37kG/7rIeUtxo
	 iKpq1WuV+S/hOandNNfXBqrPhqgk/RZX4aoeJPt34VvcaA1A62R+kzIMvEX16ZuQxA
	 59ksL4rz0vByYt9eapMiBcnoqn7ovENEFMYcKZm0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 672F9F804AD;
	Tue, 11 May 2021 19:57:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0820EF80475; Tue, 11 May 2021 19:57:35 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CD8AF8013A
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 19:57:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CD8AF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="dnUzhzLc"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14BHvKv3028332; Tue, 11 May 2021 12:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=VUgP11qyqxEo4+q4DELogDEUKERUvulZRLUXW7iacII=;
 b=dnUzhzLc/jM2mb6qetuKaRAlQ9PNLGv9Fri2gjl4PzNNFPoQvkTmK4pglx/c1eBxucRj
 rTa0/Fio6UHuxreP/ubkQG0L2RGULzEdySVVcGn5OleeaxJSqpkAyCGXm5MKjsIZn0+q
 y0xVESEY2PZQxLPaJqtwRZHPBh4rVg8iOMtFjuujPz/Att+mLDpeH9jKhXG4ukUa87ti
 GzChwb3L6jTnGrpx/18AWNpByXFJ7MWW8RYwaB7SxrnS1+l3q/fmoY9PT9SecihaFwBu
 Hcqal7OqQLe9mq9ksII/UFeEv+KzcBB8dBaVK5sYL+9nUAMJhSjPdlhnqLBOd+X7qUDr DQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 38f2d4sy5v-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 11 May 2021 12:57:21 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 18:57:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 18:57:19 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0AE6B11CD;
 Tue, 11 May 2021 17:57:19 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 5/5] ASoC: cs42l52: Minor tidy up of error paths
Date: Tue, 11 May 2021 18:57:18 +0100
Message-ID: <20210511175718.15416-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210511175718.15416-1-ckeepax@opensource.cirrus.com>
References: <20210511175718.15416-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: -SYyJygOds_QKdLBAGDhnR4eOhYoogP2
X-Proofpoint-ORIG-GUID: -SYyJygOds_QKdLBAGDhnR4eOhYoogP2
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110121
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, lgirdwood@gmail.com, james.schulman@cirrus.com,
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

Fixup a needlessly initialised variable and an unchecked return
value.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l56.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index c44a5cdb796ec..7cdffdf6b8cf0 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1175,7 +1175,7 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 	struct cs42l56_platform_data *pdata =
 		dev_get_platdata(&i2c_client->dev);
 	int ret, i;
-	unsigned int devid = 0;
+	unsigned int devid;
 	unsigned int alpha_rev, metal_rev;
 	unsigned int reg;
 
@@ -1245,6 +1245,11 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	ret = regmap_read(cs42l56->regmap, CS42L56_CHIP_ID_1, &reg);
+	if (ret) {
+		dev_err(&i2c_client->dev, "Failed to read chip ID: %d\n", ret);
+		return ret;
+	}
+
 	devid = reg & CS42L56_CHIP_ID_MASK;
 	if (devid != CS42L56_DEVID) {
 		dev_err(&i2c_client->dev,
-- 
2.11.0

