Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E0C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 13:18:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1986121E
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 13:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1986121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 188AD174F;
	Mon, 10 May 2021 15:18:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 188AD174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620652737;
	bh=5bNt1GUuKaf3QMML9d3bY+V+o5IhvKV/3K0l7XL8GwA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OH0O5rAf19LlmLhobdN0FxxnZQEw4AfdyQg6rTBwM6XM55C6I7IuVePO/Jl+Alp9o
	 PhInCgeWpUg47Jx7vOJAAeIPcGC9tXEvS6I+4bKndRq+Q0rTpTA+HImIXuLAWtg9k5
	 kJRRxgO+2G1R046md6e/o2gqbFaM32ZROLe9+gDU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDCF1F804E7;
	Mon, 10 May 2021 15:14:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0FFAF804D8; Mon, 10 May 2021 15:14:23 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C20FBF8026F
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 15:14:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C20FBF8026F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="eh9e0Tt2"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14ADD5cj017163; Mon, 10 May 2021 08:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=9ApaxVdIsLOhMV/cbqW4Miy64EVxRdnn/+s8uSdnpBA=;
 b=eh9e0Tt2fE5BK4lRZ8iuWoD50R+l8k5vfPh+OrsEcP4Vkmkyf4rzrzHSaW10EueTTxu6
 7f4UVW5W3FdCFCRr7ehriDeCvCswREVMsbUlENGnUKumMP/ajq1E5MsvXlKQVKvgUEbj
 tzvCg8kMOVHTEy0wVUQGDeWeU70gOE9C7KBQH7S9DfGTyCpcZAxd8TkGHiMYeRt3FokB
 mJToNBJ8f6Ftdw7Ys2qSD8ZDF1GtkQVeZgB8MRvsk0UJL0tt4IjtjIMyQxgRxHc3iyGG
 EqYnbNHx65RhDmXHxsJ1L1jIouSZxnY6qxLPLgER1485Ojp/BWXVqTcSJH+d6NrLXv44 bw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 38f4x181h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 10 May 2021 08:13:59 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 14:13:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 10 May 2021 14:13:57 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BD16611D9;
 Mon, 10 May 2021 13:13:57 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 03/10] ASoC: cs35l33: Minor error paths fixups
Date: Mon, 10 May 2021 14:13:50 +0100
Message-ID: <20210510131357.17170-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510131357.17170-1-ckeepax@opensource.cirrus.com>
References: <20210510131357.17170-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: fs_H-RSG48UtUjE8nlafZYwxWYyTa5j2
X-Proofpoint-ORIG-GUID: fs_H-RSG48UtUjE8nlafZYwxWYyTa5j2
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
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
 sound/soc/codecs/cs35l33.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 7ad7b733af9b6..6f6b3c0c88b78 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -34,6 +34,7 @@
 #include <linux/of_irq.h>
 
 #include "cs35l33.h"
+#include "cirrus_legacy.h"
 
 #define CS35L33_BOOT_DELAY	50
 
@@ -1190,12 +1191,12 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 	regcache_cache_only(cs35l33->regmap, false);
 
 	/* initialize codec */
-	ret = regmap_read(cs35l33->regmap, CS35L33_DEVID_AB, &reg);
-	devid = (reg & 0xFF) << 12;
-	ret = regmap_read(cs35l33->regmap, CS35L33_DEVID_CD, &reg);
-	devid |= (reg & 0xFF) << 4;
-	ret = regmap_read(cs35l33->regmap, CS35L33_DEVID_E, &reg);
-	devid |= (reg & 0xF0) >> 4;
+	devid = cirrus_read_device_id(cs35l33->regmap, CS35L33_DEVID_AB);
+	if (devid < 0) {
+		ret = devid;
+		dev_err(&i2c_client->dev, "Failed to read device ID: %d\n", ret);
+		goto err_enable;
+	}
 
 	if (devid != CS35L33_CHIP_ID) {
 		dev_err(&i2c_client->dev,
@@ -1242,6 +1243,8 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 	return 0;
 
 err_enable:
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
+
 	regulator_bulk_disable(cs35l33->num_core_supplies,
 			       cs35l33->core_supplies);
 
-- 
2.11.0

