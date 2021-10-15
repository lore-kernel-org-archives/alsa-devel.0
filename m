Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED2C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 13:38:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAC661151
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 13:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EAC661151
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9011916F7;
	Fri, 15 Oct 2021 15:37:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9011916F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634305113;
	bh=gcinP34PTVt3HnQs5KE5tr7QuQS3sGJqUMZ4s+jkLuU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OxGx5r5pqCj6GmL50vd1aqW/jScGSwrgio0NOZWWWR4oz+5IaJOnAX586Rq+cXk9i
	 rKUXVEmKAX9U50ADbTNUQCy0oEWJ1yKcLPWxlhUeSsXfCwRRPGuk33MHVOPWQ7f+3y
	 P2SWBcVIG+OJJec9ky4/uhHMSHJ4SLDKSR83ITlE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A1C1F804E5;
	Fri, 15 Oct 2021 15:36:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D47DF80506; Fri, 15 Oct 2021 15:36:43 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68DCBF804E4
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 15:36:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68DCBF804E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="k0obp/Tq"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t1023483; 
 Fri, 15 Oct 2021 08:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=l/+RJ9FDEJzZTolUJu3mZT8zz3TFCqtHXqHMWM5hWn4=;
 b=k0obp/Tq/+Ax4lMJ6ChTaEwYAw08PyWK6aiUo0FcP7QZ2ZHsGlZ65xUtGUqn1799xr88
 ve/qaSUw4kR9Y0E0/TSjzdrOvUJUmiP3dM5McCsNAbHDmswsYsZDR0P3lyFWUSBdjr7x
 Qgoi+eE3H8AnMHM8KN7SZlALvblYSYItt4P5OP++dXJVqzwPQ1wUNvthGPI6rbb8WSbQ
 EixXuzlfdP+1wM791lDwY3p1zwIpfz+H3LWgQXfoy4gsTKWtq3r8AiJpl94M60N7Uq5G
 KGSLxk+9t4pKIT6ZtwB51s6d+U5OgZMues73W+BC1EDkzL/6A565XBRoW8kXtzoDaFC0 tQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 15 Oct 2021 08:36:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.65.254])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AE71746D;
 Fri, 15 Oct 2021 13:36:23 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 07/16] ASoC: cs42l42: Correct power-up sequence to match
 datasheet
Date: Fri, 15 Oct 2021 14:36:10 +0100
Message-ID: <20211015133619.4698-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 66iAUKjlTzJqnu9hdaA-sH5t7G3c3Eak
X-Proofpoint-GUID: 66iAUKjlTzJqnu9hdaA-sH5t7G3c3Eak
X-Proofpoint-Spam-Reason: safe
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

The power-up sequence mandated in the datasheet is:

- VP must turn on first
- VA, VCP, VL, in any order
- VD_FILT after VL
- RESET must be asserted while VP turns on

- VD_FILT must turn off before VL
- VP must turn off last

This patch fixes the order the regulators are enabled and holds RESET
asserted around the power-up. The datasheet power-down order is the reverse
of the power-up order so this is automatically covered by listing the bulk
regulators in power-up order.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 22 ++++++++++++----------
 sound/soc/codecs/cs42l42.h |  4 ++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 629a0783e693..420e16563c45 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2025,22 +2025,23 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies),
-				    cs42l42->supplies);
-	if (ret != 0) {
-		dev_err(&i2c_client->dev,
-			"Failed to enable supplies: %d\n", ret);
-		return ret;
-	}
-
-	/* Reset the Device */
+	/* Hold device in reset while it powers up */
 	cs42l42->reset_gpio = devm_gpiod_get(&i2c_client->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs42l42->reset_gpio)) {
 		ret = PTR_ERR(cs42l42->reset_gpio);
 		dev_err(&i2c_client->dev, "Failed to request reset gpio: %d\n", ret);
-		goto err_disable;
+		return ret;
 	}
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies),
+				    cs42l42->supplies);
+	if (ret != 0) {
+		dev_err(&i2c_client->dev,
+			"Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	/* Release reset and wait for boot */
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
@@ -2116,6 +2117,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	return 0;
 
 err_disable:
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
 				cs42l42->supplies);
 	return ret;
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 0704c902475f..2343213d0cdb 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -822,11 +822,11 @@
 #define CS42L42_PLL_LOCK_TIMEOUT_US	1250
 
 static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
-	"VA",
 	"VP",
+	"VA",
 	"VCP",
-	"VD_FILT",
 	"VL",
+	"VD_FILT",
 };
 
 struct  cs42l42_private {
-- 
2.11.0

