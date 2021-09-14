Return-Path: <SRS0=quTn=OE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ABEC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 14:14:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF58161029
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 14:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF58161029
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B3B0176C;
	Tue, 14 Sep 2021 16:14:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B3B0176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631628892;
	bh=Jy25jLjteyw8vW4I+Gfq5EubkEm3Oi11+vQmJTEbCiI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kmWonKHcGLOoyu5DP31DYvJnnatzFVqTc53jNmMEooy9AtbBuu0k0JGC3lKo/e6nt
	 jjn+0P71RLRmbxhHyrSkYmhhtxCHIMonx7DObQOHodw0bUyXbl4C2c3ms1DrcINksu
	 Oq8+fuhRUeBUk2QDv9YEhMddGKejTEi/Rwve3VL0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC6E8F80132;
	Tue, 14 Sep 2021 16:14:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32371F8027B; Tue, 14 Sep 2021 16:14:00 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0162DF80132
 for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2021 16:13:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0162DF80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="WLNuwVsN"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E6ehYh028588; 
 Tue, 14 Sep 2021 09:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=YcX98F1rZGjmyBvmbgG9i00ka4soA4Avcwt9pAfJ7jA=;
 b=WLNuwVsNq4OV6TL9vH8FW5FlxfyEWneqA8z/rz/6FWuRgXDyCRraVWfSiuSOO35IaXyW
 qBeAi4JgWGqNAV2OfeJ9s6Dntnj0q7lUuYjff4Yb3rCpioC5DYIFKk8kPV9KMBibCCWn
 ne+RElDYqcNf6Yfah1blvXpotc5iTcuh1z6VPqqf/CJK3AZmJHltzrmBkQdsqzV30q4T
 SOEmyGXI6+xw0NXD1LOqHnWYToO1rL6mk3+P4z75QdrTBdAq6xowjLWmB18ZdL1RLiHv
 xJlo7+uETTCv/23M09rbbZY7qFBIGuBf3JmJzjeeZUhGN+pcWS/wZY060wVAUyiefr5x JQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3s3s3-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 14 Sep 2021 09:13:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 14 Sep
 2021 15:13:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Tue, 14 Sep 2021 15:13:49 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ABE8911C6;
 Tue, 14 Sep 2021 14:13:49 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 4/6] ASoC: cs35l41: Don't overwrite returned error code
Date: Tue, 14 Sep 2021 15:13:47 +0100
Message-ID: <20210914141349.30218-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210914141349.30218-1-ckeepax@opensource.cirrus.com>
References: <20210914141349.30218-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: VPEVx3JkgfkIYCFSOcrbr2XiKUTctyqv
X-Proofpoint-ORIG-GUID: VPEVx3JkgfkIYCFSOcrbr2XiKUTctyqv
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 james.schulman@cirrus.com, lgirdwood@gmail.com, david.rhodes@cirrus.com
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

In multiple places the driver overwrites the error code returned with
a static error code, this is not helpful for debugging. Update to pass
the error codes straight through.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index ce652a454dfc8..0d7073bb313ab 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -317,7 +317,6 @@ static int cs35l41_otp_unpack(void *data)
 	ret = regmap_read(cs35l41->regmap, CS35L41_OTPID, &otp_id_reg);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Read OTP ID failed\n");
-		ret = -EINVAL;
 		goto err_otp_unpack;
 	}
 
@@ -337,7 +336,6 @@ static int cs35l41_otp_unpack(void *data)
 						CS35L41_OTP_SIZE_WORDS);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Read OTP Mem failed\n");
-		ret = -EINVAL;
 		goto err_otp_unpack;
 	}
 
@@ -352,13 +350,11 @@ static int cs35l41_otp_unpack(void *data)
 	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x00000055);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Write Unlock key failed 1/2\n");
-		ret = -EINVAL;
 		goto err_otp_unpack;
 	}
 	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x000000AA);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Write Unlock key failed 2/2\n");
-		ret = -EINVAL;
 		goto err_otp_unpack;
 	}
 
@@ -398,7 +394,6 @@ static int cs35l41_otp_unpack(void *data)
 						otp_val << otp_map[i].shift);
 			if (ret < 0) {
 				dev_err(cs35l41->dev, "Write OTP val failed\n");
-				ret = -EINVAL;
 				goto err_otp_unpack;
 			}
 		}
@@ -407,13 +402,11 @@ static int cs35l41_otp_unpack(void *data)
 	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x000000CC);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Write Lock key failed 1/2\n");
-		ret = -EINVAL;
 		goto err_otp_unpack;
 	}
 	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x00000033);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Write Lock key failed 2/2\n");
-		ret = -EINVAL;
 		goto err_otp_unpack;
 	}
 	ret = 0;
@@ -1413,7 +1406,6 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 	/* CS35L41 needs INT for PDN_DONE */
 	if (ret != 0) {
 		dev_err(cs35l41->dev, "Failed to request IRQ: %d\n", ret);
-		ret = -ENODEV;
 		goto err;
 	}
 
-- 
2.11.0

