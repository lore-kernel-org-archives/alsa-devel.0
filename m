Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5932AE98FB3
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:02:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E4CE60201;
	Thu,  9 Apr 2026 08:01:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E4CE60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775714525;
	bh=ItZDv+HXpWto5uDqB6Fw/P41oIPgLzpLyzELezUdasc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W/xBd/5u/QHvfV2TA1eWRGIXNRr1Ade6PfvaGvMOBwX0qNreWdJDsVYFe3Ka+NvWB
	 cyRLpHHQbL5jHACo6pEJHVxb8HZb/74opUudojOGx/jLR8RUKSFdI9m4r5GqYKEy7F
	 KKEB9wANyHMu6aa3LvgsNz4JncndjY6BwOp8GIhU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92DD8F805F1; Thu,  9 Apr 2026 08:01:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4237F805F4;
	Thu,  9 Apr 2026 08:01:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A8D0F8057E; Thu,  9 Apr 2026 08:01:19 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C91DCF8012B
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 08:01:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C91DCF8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=h4mHZv0H
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 639616pzC498179,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775714466; bh=On+JKe7w88Z9eWaVH8RIfaosNEmPvPYSFo6M1VM+bds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=h4mHZv0HHWYYGQ9ADR7AQWGPEgCQBGUHzijTw75M/LP+YjQczpPC9tMtcQQ8HK8vH
	 zIBeytzlE4JtoFP+4aDAYUFQQqWlPS6eQySblnXR1HOc06TmNf1k+AgnShtG9no9z1
	 ikRgmcbIYCJEv2ReRkrrKndi1QeSEKAgiEGDN8EnywG+jyvTLrRZtdXQgtmpQlYKJl
	 JY1gLgP3ToeBIzyR2kL4yd515lY+Tn5n60YHAbJI9GmiDsDDRLgRLAPgOnsOb/V+rn
	 RoduHtzexbeIhVFC0me3ubn96fH2TDpCZwyP4P/mveMFdiLDfU0F0iX6XZackmsMSL
	 OtvC7dFXtPiEA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 639616pzC498179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 14:01:06 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 9 Apr 2026 14:01:06 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 9 Apr 2026 14:01:06 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v4 2/2] ASoC: rt1320-sdw: Add an approach to get new hardware
 advance gain
Date: Thu, 9 Apr 2026 14:01:02 +0800
Message-ID: <20260409060102.4177554-2-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409060102.4177554-1-jack.yu@realtek.com>
References: <20260409060102.4177554-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: 3JY7E2TRMQXFKJWJU2DVPGAIBDZ655O6
X-Message-ID-Hash: 3JY7E2TRMQXFKJWJU2DVPGAIBDZ655O6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3JY7E2TRMQXFKJWJU2DVPGAIBDZ655O6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Add an approach to get new hardware advance gain,
and if there is no advance gain with this approach,
we can still get advance gain with original method.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1320-sdw.c | 21 +++++++++++++++++++--
 sound/soc/codecs/rt1320-sdw.h | 13 +++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 168d2f391723..68e53f6885fb 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -1013,13 +1013,30 @@ static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
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
+
 	/* Get advance gain/r0 */
 	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 6, &r0_data[0], sizeof(struct rt1320_datafixpoint));
 	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 7, &r0_data[1], sizeof(struct rt1320_datafixpoint));
-	l_advancegain = r0_data[0].advancegain;
-	r_advancegain = r0_data[1].advancegain;
+
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

