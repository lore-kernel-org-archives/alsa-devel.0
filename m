Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E53EFD5F61
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 05:38:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FF556020D;
	Wed,  8 Apr 2026 07:38:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FF556020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775626708;
	bh=s0obgo5RKCTXESl5hx9QS2eBwYcvO713zN41mY/EAyM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MhDUMXTujfoprjJWyNUNjICWJFCdlHsOp4+TMDvrbMLcZJLf29B2bNPPA3/ATTcx8
	 wEJ+W2z3bAP6K/4eLHmiVykHAInaJCCIw07opYitNXBQbxO0bfQgz0TvgydOt7KsJ0
	 QWYLdUJw/baRzVL7q0LYVdaSUSCDFDugcWbGxyn0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D979CF8060C; Wed,  8 Apr 2026 07:37:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 13B1DF80610;
	Wed,  8 Apr 2026 07:37:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 094F9F8024C; Wed,  8 Apr 2026 07:37:31 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E4D7F802BE
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 07:37:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E4D7F802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=c0okhBOr
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6385bK4o92591681,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775626640; bh=rmIb2eVt3+cOCjjB2/0GhXbjCal9Sd0vCvk4qomVFl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=c0okhBOruXpdMMmzoaKEYmhDfI3MsSgYNcuDgObCtu43uQSBIa61F9f5pt60HdjCn
	 sfzWahDhpoJ7XEBroVV0fAovH4skFJS6J/ALmF5Vu+cBhp9AohW9IwOm8xmVZBmocI
	 SO4jc+un46t/3gOH8Q4oadAuVADdMxodqYo4cD3HPZ7HDNrNwLbUrGtw4a2Q0Sber0
	 2sNGG/oUNYQ2TDHy+5xbY2OHJl+RGmFBZbTtdee5hENaia5EoIOtBzxE80IFsPplmR
	 ZkGkVP1NplbFeZRTrTyRflkljfFocH0MwbmsSVthXpp3z26Ahc0yFSclvk79k6qYAq
	 ThseG9RszLHDw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6385bK4o92591681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 13:37:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 8 Apr 2026 13:37:20 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 8 Apr 2026 13:37:20 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v3 2/2] ASoC: rt1320-sdw: Add an approach to get new hardware
 advance gain
Date: Wed, 8 Apr 2026 13:37:16 +0800
Message-ID: <20260408053716.3757937-2-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408053716.3757937-1-jack.yu@realtek.com>
References: <20260408053716.3757937-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: TL5YMUPWT5GNGTYKMTF5Y4HNOZOHIVRU
X-Message-ID-Hash: TL5YMUPWT5GNGTYKMTF5Y4HNOZOHIVRU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TL5YMUPWT5GNGTYKMTF5Y4HNOZOHIVRU/>
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
index 84e8768f7881..b5b72fb87de2 100644
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

