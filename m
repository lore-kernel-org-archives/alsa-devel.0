Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48A1CC6B03
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:48:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBAA160209;
	Thu,  2 Apr 2026 07:48:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBAA160209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775108913;
	bh=8PuhwOqMMagenFtd5XHhaoZ6Mk5hDehRKspJ0X2MWiM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VS+tJyXdHY/8GiE7B0QrNTAlG7xSwteMZ5R94DpBo4HwZM4vydumeAIyEjXQaGCGY
	 wN5gdKdb/xgF7x2buaCHyokcDkcSWF6PM48DqdYORTciE5OnjEfFFzCaXg4knkoLxk
	 yHbfNACPM1o32Ju95h0uNOGm0B6tgtM4v9vMqKLQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BCACF8060F; Thu,  2 Apr 2026 07:47:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0A6AF80606;
	Thu,  2 Apr 2026 07:47:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD7D8F805F8; Thu,  2 Apr 2026 07:47:50 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 153FAF805F2
	for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2026 07:47:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 153FAF805F2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=JyZBCm7L
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6325leLW32537966,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775108860; bh=8QjfIwJjYcVvfzM+/nOFyUsknCUw6aVBcmBo/TZI7gA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JyZBCm7Lif5oZCXhXou5sEST6nU1sWkmy4QsMsuuKmxjxZIn9wexmIPNlfF/fS0VE
	 jepz/2n3opc0RJmOuaIyKpXUBd52oSYQ7HmCx8myM6QrROEKn+0I77G/ccOOXJdcWN
	 B/Tce2zqT28luIDqXFyoiu3vVltnTNfVmq07pB6j+P7gBh9cCUzPq3ZKkbrOBG6YPD
	 9MY8K7bHZda5rfb2AqldW/vhy1pI36saJGy1XPjyb63wvOwc4qMxY/uYZJ6sRAzY2V
	 ImSwFLmr6c1gWZnZbH4Rk35R+BuHx45ustT0olJ4wjI74Bht/0BKbuc0H9bn3gZoWj
	 FEZZf1VYb6Y7w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6325leLW32537966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 13:47:40 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 13:47:30 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 2 Apr 2026 13:47:30 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH 2/2] ASoC: rt1320-sdw: Add an approach to get new hardware
 advance gain
Date: Thu, 2 Apr 2026 13:47:16 +0800
Message-ID: <20260402054716.1795350-2-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402054716.1795350-1-jack.yu@realtek.com>
References: <20260402054716.1795350-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: FZ4PBQQEJ7EQD3JYQMVCZN4TB5ETXMDG
X-Message-ID-Hash: FZ4PBQQEJ7EQD3JYQMVCZN4TB5ETXMDG
X-MailFrom: jack.yu@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FZ4PBQQEJ7EQD3JYQMVCZN4TB5ETXMDG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Add an approach to get new hardware advance gain, and if there is
no advance gain with this approach, we can still get advance gain
with original method.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1320-sdw.c | 19 +++++++++++++++++--
 sound/soc/codecs/rt1320-sdw.h | 13 +++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 548454c7069e..6186dc4dcf47 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -1014,15 +1014,30 @@ static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 	struct device *dev = &rt1320->sdw_slave->dev;
 	struct rt1320_datafixpoint r0_data[2];
 	unsigned short l_advancegain, r_advancegain;
+	FwPara_Get_HwSwGain audDriverDataHwSwGain;
+	unsigned int HwAdvGain;
 	int ret;
 
+	 /* Get new hardware advance gain by ID 1300 */
+	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 1300,
+		&audDriverDataHwSwGain, sizeof(audDriverDataHwSwGain));
+	HwAdvGain = audDriverDataHwSwGain.HwAdvGain;
+	dev_dbg(dev, "%s, HwAdvGain=%d\n", __func__, HwAdvGain);
+	dev_dbg(dev, "%s, HwBasGain=%d\n", __func__, audDriverDataHwSwGain.HwBasGain);
+	dev_dbg(dev, "%s, SwAdvGain=%d\n", __func__, audDriverDataHwSwGain.SwAdvGain);
+	dev_dbg(dev, "%s, SwBasGain=%d\n", __func__, audDriverDataHwSwGain.SwBasGain);
 
 	/* Get advance gain/r0 */
 	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 6, &r0_data[0], sizeof(struct rt1320_datafixpoint));
 	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 7, &r0_data[1], sizeof(struct rt1320_datafixpoint));
-	l_advancegain = r0_data[0].advancegain;
-	r_advancegain = r0_data[1].advancegain;
 
+	if (HwAdvGain != 0) {
+		l_advancegain = HwAdvGain & 0xffff;
+		r_advancegain = (HwAdvGain >> 16) & 0xffff;
+	} else {
+		l_advancegain = r0_data[0].advancegain;
+		r_advancegain = r0_data[1].advancegain;
+	}
 	dev_dbg(dev, "%s, LR advanceGain=0x%x 0x%x\n", __func__, l_advancegain, r_advancegain);
 
 	/* set R0 and enable protection by SetParameter id 6, 7 */
diff --git a/sound/soc/codecs/rt1320-sdw.h b/sound/soc/codecs/rt1320-sdw.h
index 4a1d3fc4c8ee..a7b573883dd0 100644
--- a/sound/soc/codecs/rt1320-sdw.h
+++ b/sound/soc/codecs/rt1320-sdw.h
@@ -121,6 +121,19 @@ struct rt1320_datafixpoint {
 	int invrs;
 };
 
+typedef struct FwPara_HwSwGain {
+	unsigned int SwAdvGain;
+	unsigned int SwBasGain;
+	unsigned int HwAdvGain;
+	unsigned int HwBasGain;
+	unsigned int reserve0;
+	unsigned int reserve1;
+	unsigned int reserve2;
+	unsigned int reserve3;
+	unsigned int reserve4;
+	unsigned int reserve5;
+} __attribute__((packed)) FwPara_Get_HwSwGain;
+
 struct rt1320_paramcmd {
 	unsigned char moudleid;
 	unsigned char commandtype;
-- 
2.53.0

