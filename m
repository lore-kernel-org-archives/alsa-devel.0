Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2D4C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 12:59:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6948360C49
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 12:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6948360C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F750827;
	Tue, 26 Oct 2021 14:58:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F750827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635253146;
	bh=Pm7yYyLoc30uqotlDlUsd8eMKeMkTKQEkskhz4ltiQo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CyZnFx7XyzUslJcQolaQ7A4C7ydbJcb9DgsULF9hg/KQnRplRLsW166mGB2fbjrNt
	 eWPKLDu3ntPbjokihwPDlPVES+rzJRTnRTx9J4isI1EAUqK+KxCa/aDoBF1549rdRJ
	 7XTO+p6YUrYFyTRduodFyn3kp+ulwmQPKjMKwUKQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7823F80300;
	Tue, 26 Oct 2021 14:57:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4B83F804AF; Tue, 26 Oct 2021 14:57:38 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADE59F802C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 14:57:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADE59F802C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="ln95HPCd"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q8sshb024219; 
 Tue, 26 Oct 2021 07:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Avm0vPEHL6q//XPJl4mhNkg3T8C3y4I8VQOhAbPGaPA=;
 b=ln95HPCdvrgBczm7vaehdfVPFgHsju83R/4YV7OOZgkDyKxagZCWbIxyB1nC+ThgtnN7
 QT8bOWsRC8paHSKa1X3UWCkBLjAMOIRW9DWr/j6w75aNeSfmq7OQze+e+YyFcGq0k8qi
 prCzKCkrNHdyjHDt1Cd557Q6KtrY9BzaOshs7tw/vDy/58aGZL7/EPJZLtaQ+vR2Sdir
 KMbjutzQJiaDec02Wsk/wvLiqPe44AkhKYXQdojcqXZgaatacc63z1kETN2mEtdDS/zV
 5i+evImNg4yILVfwef5jHOgSY+HmNT9nSzs2AnknhxwEg6boAhBifbdf77WoZSGHdgw6 yg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3bx4fx0rf2-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 26 Oct 2021 07:57:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 26 Oct
 2021 13:57:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Tue, 26 Oct 2021 13:57:25 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.65.32])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 306FD11DC;
 Tue, 26 Oct 2021 12:57:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: cs42l42: Reset and power-down on remove() and
 failed probe()
Date: Tue, 26 Oct 2021 13:57:21 +0100
Message-ID: <20211026125722.10220-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211026125722.10220-1-rf@opensource.cirrus.com>
References: <20211026125722.10220-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UYLigHjqD9wZqrQUjzzZYWgt3JLTSEsv
X-Proofpoint-ORIG-GUID: UYLigHjqD9wZqrQUjzzZYWgt3JLTSEsv
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

Driver remove() should assert RESET and disable the supplies.

probe() fail was disabling supplies but it didn't assert reset or
put the codec into a power-down state.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a8fff274ec63..dc12842ee6e1 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2067,7 +2067,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 		"reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs42l42->reset_gpio)) {
 		ret = PTR_ERR(cs42l42->reset_gpio);
-		goto err_disable;
+		goto err_disable_noreset;
 	}
 
 	if (cs42l42->reset_gpio) {
@@ -2111,7 +2111,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	ret = regmap_read(cs42l42->regmap, CS42L42_REVID, &reg);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
-		goto err_disable;
+		goto err_shutdown;
 	}
 
 	dev_info(&i2c_client->dev,
@@ -2136,7 +2136,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 
 	ret = cs42l42_handle_device_data(&i2c_client->dev, cs42l42);
 	if (ret != 0)
-		goto err_disable;
+		goto err_shutdown;
 
 	/* Setup headset detection */
 	cs42l42_setup_hs_type_detect(cs42l42);
@@ -2148,10 +2148,18 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	ret = devm_snd_soc_register_component(&i2c_client->dev,
 			&soc_component_dev_cs42l42, &cs42l42_dai, 1);
 	if (ret < 0)
-		goto err_disable;
+		goto err_shutdown;
+
 	return 0;
 
+err_shutdown:
+	regmap_write(cs42l42->regmap, CS42L42_CODEC_INT_MASK, 0xff);
+	regmap_write(cs42l42->regmap, CS42L42_TSRS_PLUG_INT_MASK, 0xff);
+	regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
+
 err_disable:
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+err_disable_noreset:
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
 				cs42l42->supplies);
 	return ret;
@@ -2164,6 +2172,14 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	if (i2c_client->irq)
 		devm_free_irq(&i2c_client->dev, i2c_client->irq, cs42l42);
 
+	/*
+	 * The driver might not have control of reset and power supplies,
+	 * so ensure that the chip internals are powered down.
+	 */
+	regmap_write(cs42l42->regmap, CS42L42_CODEC_INT_MASK, 0xff);
+	regmap_write(cs42l42->regmap, CS42L42_TSRS_PLUG_INT_MASK, 0xff);
+	regmap_write(cs42l42->regmap, CS42L42_PWR_CTL1, 0xff);
+
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
 
-- 
2.11.0

