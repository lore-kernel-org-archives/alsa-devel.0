Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460ECC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 17:58:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91FD616ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 17:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91FD616ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C4BB16D1;
	Tue, 11 May 2021 19:57:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C4BB16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620755903;
	bh=kdorbtaEV9sxsgUqSnMngbV/v/3w/kTd+nNN5omGmpE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P1MtpTEta3BxEtzDUOwBnR5+87eaalNjsMNJ+jtC6FOyEX0r843g3Lm6jeDB1wM5O
	 6tjNDV4Dn+6e9r8/zvFohHCm2R+CDmNNZ4LPGrZW8elqaO/4GojBeK4rvtqn0wkTus
	 te4ts5fHXnxcUFZMXnf6+d0Ix/PhTJKy1e0kaPc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C950CF8016B;
	Tue, 11 May 2021 19:57:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 538CBF80279; Tue, 11 May 2021 19:57:29 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47DA6F80129
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 19:57:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47DA6F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="OIoLkRwA"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14BHvKv2028332; Tue, 11 May 2021 12:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=rDkGDtZI61X8CUGHBelpZtIxppQvtE3n5F/pINSGka0=;
 b=OIoLkRwAGwWkrJZAws0fgmuXGFgWJG4+/eDL9RvupV3UuEzs1ExczojZMWBY01m2nWo5
 Z86FSkbwKSOABa5HwXsbuatvSZZfVKbbEtswDAq3rTJE5pgSquzMvNh1sWMJM82lpYa5
 602tt5FdDlCcim9RtyBX0kugkKSQdl1L8Xa18yJe+TjAug/W0aMVazfOBmTg1YdSPYkz
 kmkoXwBW7o85m871AQP4UQcOFgd6H7brdehv32P7PPhTmBoBZz3GVpLFT6DvjIILiP7o
 6Ac7QupU6w7V++CBaqK9NlgEwliFbuw8d+KIBuJJhEcyXp8Ha09/6dx7uvTL+0rCVh0Q OQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 38f2d4sy5v-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 11 May 2021 12:57:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 18:57:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 18:57:18 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E367711D7;
 Tue, 11 May 2021 17:57:18 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 3/5] ASoC: cs35l34: Add missing regmap use_single config
Date: Tue, 11 May 2021 18:57:16 +0100
Message-ID: <20210511175718.15416-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210511175718.15416-1-ckeepax@opensource.cirrus.com>
References: <20210511175718.15416-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: sb7uXxvQ8Cv9V3G8n95KxYx8Pb0jMMFD
X-Proofpoint-ORIG-GUID: sb7uXxvQ8Cv9V3G8n95KxYx8Pb0jMMFD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=791
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

This device requires single register transactions, this will
definely cause problems with the new device ID parsing which uses
regmap_bulk_read but might also show up in the cache sync sometimes.
Add the missing flags to the regmap_config.

Fixes: 8cb9b001635c ("ASoC: cs35l34: Minor error paths fixups")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l34.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 6657cc5db3e87..ed678241c22bc 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -801,6 +801,9 @@ static struct regmap_config cs35l34_regmap = {
 	.readable_reg = cs35l34_readable_register,
 	.precious_reg = cs35l34_precious_register,
 	.cache_type = REGCACHE_RBTREE,
+
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static int cs35l34_handle_of_data(struct i2c_client *i2c_client,
-- 
2.11.0

