Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16188C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 13:17:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16ACA61288
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 13:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16ACA61288
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E6DF16F6;
	Mon, 10 May 2021 15:16:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E6DF16F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620652640;
	bh=abYkNbhWBX/6Ft2BC5isoCGB408Z/HMlR65KnWXVECc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MiHppHjBbeRLShHSnCyDy+pDVnkj15kRLoDbtgpQ4XReHUmvJqwyqfEnEIqnLLuLM
	 /R9cSmW4HMPS9GlzYuMBhyyhktM3lbsA58/kPpNm0K0TJoic/UvO8VgWGCw5wGJaK7
	 Dmjaaxhjgf+ExFkLbpAQqMEoUB1T0DTPnYYXcDT8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDC32F804AD;
	Mon, 10 May 2021 15:14:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81F8CF804AA; Mon, 10 May 2021 15:14:17 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A90BDF8026B
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 15:14:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A90BDF8026B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="o5I2RIwP"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14ADD5cm017163; Mon, 10 May 2021 08:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=r7eYzA13Ft00iVsiic/B2GqdlgN6ba/ZNQlvRcKiZas=;
 b=o5I2RIwPZyOXmrUROE96PJ7+nncoKffILQuHPaCDyrfHDc/lHoSSUqqP2kOnmbYFFyrg
 +9gZdZwk1Jd7XYFqDI4Bt0OeURkZL51qj96wq/qKO3IHAaukr2iyCXoix1cv56/2sjxc
 iAx+SLOAB5r8FozA0PIq4kv9C9nqOLGzGWz9FH/XExOx52NdvsgVbqfpgzLUU6hIX9tN
 6iZ5tNPKfYlxRXS90mvg9uNY7uAW18iaELY95hu3Av8SwT+zl+ZATsIK3C/yHEdeKme/
 90lSF7Qh/+fnsO2koCgrzofQUuJkwiw5PBrxxNvsJADj1gPHQbXIyQAukjGyblO/kI5W Zg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 38f4x181h2-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 10 May 2021 08:14:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 14:13:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 10 May 2021 14:13:58 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 05E3411D8;
 Mon, 10 May 2021 13:13:58 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 09/10] ASoC: cs43130:  Minor error paths fixups
Date: Mon, 10 May 2021 14:13:56 +0100
Message-ID: <20210510131357.17170-10-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510131357.17170-1-ckeepax@opensource.cirrus.com>
References: <20210510131357.17170-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: E5kQsicilk4R7Pktnw_vUtnZiYph7fya
X-Proofpoint-ORIG-GUID: E5kQsicilk4R7Pktnw_vUtnZiYph7fya
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100092
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

Correct some unchecked re-allocations of ret whilst reading the device
ID and ensure the hardware state is returned to off on the error
paths.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs43130.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 80bc7c10ed757..642338cdc8b65 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -36,6 +36,7 @@
 #include <sound/jack.h>
 
 #include "cs43130.h"
+#include "cirrus_legacy.h"
 
 static const struct reg_default cs43130_reg_defaults[] = {
 	{CS43130_SYS_CLK_CTL_1, 0x06},
@@ -2424,9 +2425,8 @@ static int cs43130_i2c_probe(struct i2c_client *client,
 {
 	struct cs43130_private *cs43130;
 	int ret;
-	unsigned int devid = 0;
 	unsigned int reg;
-	int i;
+	int i, devid;
 
 	cs43130 = devm_kzalloc(&client->dev, sizeof(*cs43130), GFP_KERNEL);
 	if (!cs43130)
@@ -2464,20 +2464,21 @@ static int cs43130_i2c_probe(struct i2c_client *client,
 
 	cs43130->reset_gpio = devm_gpiod_get_optional(&client->dev,
 						      "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(cs43130->reset_gpio))
-		return PTR_ERR(cs43130->reset_gpio);
+	if (IS_ERR(cs43130->reset_gpio)) {
+		ret = PTR_ERR(cs43130->reset_gpio);
+		goto err_supplies;
+	}
 
 	gpiod_set_value_cansleep(cs43130->reset_gpio, 1);
 
 	usleep_range(2000, 2050);
 
-	ret = regmap_read(cs43130->regmap, CS43130_DEVID_AB, &reg);
-
-	devid = (reg & 0xFF) << 12;
-	ret = regmap_read(cs43130->regmap, CS43130_DEVID_CD, &reg);
-	devid |= (reg & 0xFF) << 4;
-	ret = regmap_read(cs43130->regmap, CS43130_DEVID_E, &reg);
-	devid |= (reg & 0xF0) >> 4;
+	devid = cirrus_read_device_id(cs43130->regmap, CS43130_DEVID_AB);
+	if (devid < 0) {
+		ret = devid;
+		dev_err(&client->dev, "Failed to read device ID: %d\n", ret);
+		goto err;
+	}
 
 	switch (devid) {
 	case CS43130_CHIP_ID:
@@ -2517,7 +2518,7 @@ static int cs43130_i2c_probe(struct i2c_client *client,
 					"cs43130", cs43130);
 	if (ret != 0) {
 		dev_err(&client->dev, "Failed to request IRQ: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	cs43130->mclk_int_src = CS43130_MCLK_SRC_RCO;
@@ -2576,7 +2577,13 @@ static int cs43130_i2c_probe(struct i2c_client *client,
 			   CS43130_XSP_3ST_MASK, 0);
 
 	return 0;
+
 err:
+	gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
+err_supplies:
+	regulator_bulk_disable(ARRAY_SIZE(cs43130->supplies),
+			       cs43130->supplies);
+
 	return ret;
 }
 
-- 
2.11.0

