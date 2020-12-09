Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DB7C4361B
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 09:14:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4521423B45
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 09:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4521423B45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49B0516C1;
	Wed,  9 Dec 2020 10:14:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49B0516C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607505290;
	bh=Bpsr6xbbTLOSOCwCndYFPcEpYGyaECH2CiD+OL962bg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CKOTYtnmO0KJiuGoWLm98CYKq3YG59Qs3ORa0zNF8zvUTdTJqELqB1IR1oczqjyr0
	 whE3Xcl+XM1MxvhSEqtbdIGWOAgWlWsVRYQ216T2m3TdwclKEq6aj9UuHQ+XgqlNZP
	 dgndUvUEpJglOSLdw/gHg5JkcLQxDEYdyBBCRw7A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF5AEF801D8;
	Wed,  9 Dec 2020 10:13:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9599DF8020D; Wed,  9 Dec 2020 10:13:57 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F20A7F800E1
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 10:13:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F20A7F800E1
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B99DkUT2012659,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.36])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B99DkUT2012659
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 9 Dec 2020 17:13:46 +0800
Received: from localhost.localdomain (172.22.238.213) by
 RTEXMBS01.realtek.com.tw (172.21.6.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 17:13:46 +0800
From: <derek.fang@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt1015: check the return value of regmap_read during
 i2c probe
Date: Wed, 9 Dec 2020 17:13:08 +0800
Message-ID: <20201209091308.2823-1-derek.fang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.238.213]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMBS01.realtek.com.tw (172.21.6.36)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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

From: Derek Fang <derek.fang@realtek.com>

In some projects, the device ID register is not read correctly.
This patch helps to verify the issue is caused from i2c host or client.

Signed-off-by: Derek Fang <derek.fang@realtek.com>

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index ac4c9f43b338..32e6bcf763d1 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -1207,8 +1207,13 @@ static int rt1015_i2c_probe(struct i2c_client *i2c,
 
 	rt1015->hw_config = (i2c->addr == 0x29) ? RT1015_HW_29 : RT1015_HW_28;
 
-	regmap_read(rt1015->regmap, RT1015_DEVICE_ID, &val);
-	if ((val != RT1015_DEVICE_ID_VAL) && (val != RT1015_DEVICE_ID_VAL2)) {
+	ret = regmap_read(rt1015->regmap, RT1015_DEVICE_ID, &val);
+	if (ret) {
+		dev_err(&i2c->dev,
+			"Failed to read device register: %d\n", ret);
+		return ret;
+	} else if ((val != RT1015_DEVICE_ID_VAL) &&
+			(val != RT1015_DEVICE_ID_VAL2)) {
 		dev_err(&i2c->dev,
 			"Device with ID register %x is not rt1015\n", val);
 		return -ENODEV;
-- 
2.17.1

