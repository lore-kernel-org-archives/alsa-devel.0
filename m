Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54605E98FA0
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2026 06:43:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89B96601F4;
	Fri, 10 Apr 2026 08:43:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89B96601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775803404;
	bh=bObBEm/CB/IOIDjb2moXOltJ1Lfo+oZEGkzEQkGbuu4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hhtwO1I1o4SVzLAPYKbLNR93gIQoWbbOJYS7HiP4wOOtonMelRtoyne2uLldE2L/e
	 Kz4+jWfMWcScXx2G/ZBRxXw0dsunQ8IFetYwWv3yA1a3lsWoh7EtirlJJuSZqcHRN6
	 Z8QZPACr0Nj8K4ut5AyUR27zEahr/hssOpZr/Iz0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21F2FF805EF; Fri, 10 Apr 2026 08:42:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EC46F805F1;
	Fri, 10 Apr 2026 08:42:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A3C2F8052D; Fri, 10 Apr 2026 08:42:39 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6A029F8027B
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2026 08:42:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A029F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=ZfFQvk03
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63A6gREY12539065,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775803347; bh=DbiSHW+74T/a8Jo8KVtdixF7OPlnxlGIL6uYDd2AJ0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZfFQvk03N7f/ogkV0r5+96uTKsXgvzbgmRiYYzM8NlrShUuAnjVtjAd1zoMGAG4/t
	 awFbS/WzyBhd3VD1yjbcugRv2DwnWYQapPMbaNgvW6SCxDqJcjst2KRcMSH0z3gPVa
	 /1ZMUVul/QDWJbnvPhIE4xGpeD+l1ec2WGRqPibDMFSqSyMJ1KiRRTrKTRK6zHv8KJ
	 omJfZ5L/2PdLHJBTVdjicMP9md3+HfZ4x2uugJ0HR10nKSEUx8eGwbtXE9KxaYWXnL
	 LDKhzvptyrA8mr7Idk0x41PxYulQBrxwZ0opq8J4RV7t/lkknlVCVdPRM8nO+HKUNA
	 Xa36AluXCgY/g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63A6gREY12539065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 14:42:27 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 10 Apr 2026 14:42:27 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 10 Apr 2026 14:42:27 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v5] ASoC: rt1320-sdw: Add an approach to get new hardware
 advance gain
Date: Fri, 10 Apr 2026 14:42:25 +0800
Message-ID: <20260410064225.662656-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: GCIZ4OJAEVERBURIJK42VQKV3T2GYQ27
X-Message-ID-Hash: GCIZ4OJAEVERBURIJK42VQKV3T2GYQ27
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GCIZ4OJAEVERBURIJK42VQKV3T2GYQ27/>
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
 sound/soc/codecs/rt1320-sdw.c | 25 +++++++++++++++++++++++--
 sound/soc/codecs/rt1320-sdw.h | 13 +++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 168d2f391723..b0aeeab26bd9 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -1013,13 +1013,34 @@ static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 	struct device *dev = &rt1320->sdw_slave->dev;
 	struct rt1320_datafixpoint r0_data[2];
 	unsigned short l_advancegain, r_advancegain;
+	FwPara_Get_HwSwGain audDriverDataHwSwGain = {0};
+	unsigned int HwAdvGain = 0;
 	int ret;
 
+	 /* Get new hardware advance gain by ID 1300 */
+	ret = rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 1300,
+		&audDriverDataHwSwGain, sizeof(audDriverDataHwSwGain));
+	if (ret == 0) {
+		HwAdvGain = audDriverDataHwSwGain.HwAdvGain;
+		dev_dbg(dev, "%s, HwAdvGain=%d\n", __func__, HwAdvGain);
+		dev_dbg(dev, "%s, HwBasGain=%d\n", __func__, audDriverDataHwSwGain.HwBasGain);
+		dev_dbg(dev, "%s, SwAdvGain=%d\n", __func__, audDriverDataHwSwGain.SwAdvGain);
+		dev_dbg(dev, "%s, SwBasGain=%d\n", __func__, audDriverDataHwSwGain.SwBasGain);
+	} else {
+		dev_dbg(dev, "%s: param 1300 not supported, ret=%d\n", __func__, ret);
+	}
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

