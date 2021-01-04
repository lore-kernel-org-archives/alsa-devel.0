Return-Path: <SRS0=I7Cd=GH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E40C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 03:02:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A3320E65
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 03:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A3320E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 092181667;
	Mon,  4 Jan 2021 04:01:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 092181667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609729360;
	bh=wtlzDuArZ8PSsynNoGEKm8HOIWyEp9HR+uplBLfFMbo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n8MTNKjzXp6fD9qJdWVTJwTGIXJn8ozBkZdUqftdp2FMvkrjQRPMAsJ+fd5IB+3qv
	 xeXVGeoVSeukT0lLWShVAq3qLaCkf9Hy9BibK5xvmxUS+7a1+d713FWf4QoYXoKzHc
	 6aqrs0MhkGhm6jey1yZH2nb2XTAcIa5tqqliDYXI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C9B1F80165;
	Mon,  4 Jan 2021 04:01:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A375AF80166; Mon,  4 Jan 2021 04:01:46 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CBABF8012B
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2021 04:01:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CBABF8012B
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10431QC40029574,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10431QC40029574
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 4 Jan 2021 11:01:26 +0800
Received: from localhost.localdomain (172.22.102.1) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 4 Jan 2021 11:01:26 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt1015: modify calibration sequence for better
 performance
Date: Mon, 4 Jan 2021 11:01:18 +0800
Message-ID: <20210104030118.22918-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, Jack Yu <jack.yu@realtek.com>,
 alsa-devel@alsa-project.org, lars@metafoo.de, kent_chen@realtek.com,
 kenny_chen@realtek.com, derek.fang@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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

From: Jack Yu <jack.yu@realtek.com>

New calibration sequence to fix power issue in idle state.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1015.c | 40 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 32e6bcf763d1..5fdf7bbfd375 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -497,40 +497,20 @@ static void rt1015_calibrate(struct rt1015_priv *rt1015)
 	snd_soc_dapm_mutex_lock(&component->dapm);
 	regcache_cache_bypass(regmap, true);
 
-	regmap_write(regmap, RT1015_PWR9, 0xAA60);
-	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x0089);
-	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x008A);
-	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x008C);
-	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x008D);
-	regmap_write(regmap, RT1015_PWR4, 0x80B2);
-	regmap_write(regmap, RT1015_CLASSD_SEQ, 0x5797);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL8, 0x2100);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL9, 0x0100);
-	regmap_write(regmap, RT1015_PWR5, 0x2175);
-	regmap_write(regmap, RT1015_MIXER1, 0x005D);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL1, 0x00A1);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL2, 0x12F7);
-	regmap_write(regmap, RT1015_DC_CALIB_CLSD1, 0x1205);
-	msleep(200);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL8, 0x2000);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL9, 0x0180);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL1, 0x00A1);
-	regmap_write(regmap, RT1015_DC_CALIB_CLSD1, 0x0A05);
-	msleep(200);
+	regmap_write(regmap, RT1015_CLK_DET, 0x0000);
 	regmap_write(regmap, RT1015_PWR4, 0x00B2);
+	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x0009);
+	msleep(100);
+	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x000A);
+	msleep(100);
+	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x000C);
+	msleep(100);
 	regmap_write(regmap, RT1015_CLSD_INTERNAL8, 0x2028);
 	regmap_write(regmap, RT1015_CLSD_INTERNAL9, 0x0140);
-	regmap_write(regmap, RT1015_PWR5, 0x0175);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL1, 0x1721);
-	regmap_write(regmap, RT1015_CLASSD_SEQ, 0x570E);
-	regmap_write(regmap, RT1015_MIXER1, 0x203D);
-	regmap_write(regmap, RT1015_DC_CALIB_CLSD1, 0x5A01);
-	regmap_write(regmap, RT1015_CLSD_INTERNAL2, 0x12FF);
-	regmap_write(regmap, RT1015_GAT_BOOST, 0x0eFE);
-	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x008E);
-	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x0088);
+	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x000D);
+	msleep(300);
+	regmap_write(regmap, RT1015_PWR_STATE_CTRL, 0x0008);
 	regmap_write(regmap, RT1015_SYS_RST1, 0x05F5);
-	regmap_write(regmap, RT1015_SYS_RST2, 0x0b9a);
 
 	regcache_cache_bypass(regmap, false);
 	regcache_mark_dirty(regmap);
-- 
2.29.0

