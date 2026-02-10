Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B9EA3F14
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:44:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5687F60216;
	Tue, 10 Feb 2026 08:44:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5687F60216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770709475;
	bh=VTeyvXtIr0ei7nbiJ0E5uYCjbmgKy8bz3CVeqNS0HRI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HwItDtFdlqDciKUL2K3++BCiyP7kA2JvKWKqj/I8Vf2ivdENKBl0pCVAUM+weiqOu
	 L3uVlcvgcJrmxwKkP6pAwTGzGJMu8s24gnk1l4eBUqBQJnhJ8VGAx6j8BNnNbj/kHN
	 RPKc9qgWeTtAHQh2R6AABeztvUkrRvOt1PZONiX0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D7D6F805F2; Tue, 10 Feb 2026 08:44:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A452DF805EE;
	Tue, 10 Feb 2026 08:44:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31C00F801F7; Tue, 10 Feb 2026 08:43:58 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 730E0F80087
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2026 08:43:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 730E0F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=YCDz49D9
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61A7hdKR33295320,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770709419; bh=qIGkj9YdG7HxXAYAUuLKy1zy3WCVSP+8nAg6IGn9sTc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=YCDz49D9OAbL44j6VQfGn5FjcyO64wsZZNJ5kFM30nBRukUfdQLcEONIPJIQCyEi8
	 PJyL1zscc3I860YpSoNm4PWtbCP21JUjW/JpGUWAR8bhvwEX3hZ17VEFWjjU1Swnxy
	 /8JmehQhGhgvUz6sVcTlAX6ksXD6om4CCE9dH0rG75M80IfvBZofAyW2UKdrrWyb9q
	 O0WhaIb7yvc0ivrsWWSOGha2oMC3psTZ6RyJAFspzKlG0mCWsqRZ/EI6Zz43VlvWgY
	 cux96OsVCSgRx4jgD+NdA3KpJN6qgy8lJtETvrqSdhLGHSIiqSBY6FIIC7cxqgsLj1
	 Yyp9pyvEqSvjQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61A7hdKR33295320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 15:43:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Feb 2026 15:43:38 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Feb 2026 15:43:38 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 10 Feb 2026 15:43:38 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt721-sdca: Fix issue of fail to detect OMTP jack type
Date: Tue, 10 Feb 2026 15:43:35 +0800
Message-ID: <20260210074335.2337830-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: GBLTV63L63B2CCSMZIV2BGZH47CVI22E
X-Message-ID-Hash: GBLTV63L63B2CCSMZIV2BGZH47CVI22E
X-MailFrom: jack.yu@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GBLTV63L63B2CCSMZIV2BGZH47CVI22E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Add related HP-JD settings to fix issue of fail to detect
OMTP jack type.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt721-sdca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
index 8233532a1752..35960c225224 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -245,12 +245,12 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
 	regmap_write(rt721->mbq_regmap, 0x5b10007, 0x2000);
 	regmap_write(rt721->mbq_regmap, 0x5B10017, 0x1b0f);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_CBJ_CTRL,
-		RT721_CBJ_A0_GAT_CTRL1, 0x2a02);
+		RT721_CBJ_A0_GAT_CTRL1, 0x2205);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
 		RT721_HP_AMP_2CH_CAL4, 0xa105);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
 		RT721_UAJ_TOP_TCON14, 0x3b33);
-	regmap_write(rt721->mbq_regmap, 0x310400, 0x3023);
+	regmap_write(rt721->mbq_regmap, 0x310400, 0x3043);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
 		RT721_UAJ_TOP_TCON14, 0x3f33);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
-- 
2.52.0

