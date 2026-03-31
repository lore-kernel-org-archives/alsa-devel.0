Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A641061B2B
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 02:44:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D19046019A;
	Tue, 31 Mar 2026 04:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D19046019A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774925081;
	bh=07kFi1rcUia3PDIS7c7iVAucdxafIj/xaipoTfzXOY4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=M+YQjEskdjk9j5/rT64fyak0eflEyKiwM3Czk2SMHWfuBTCryVwTB6wRmE38GUWIp
	 8mVJk5u5lxqokkOhVjjBj3epLwa/3xVZTjzMfl9nho1m3Mthxm8edSX04IoNG01LGg
	 EM1f3J/Hw/3NomY0ujmD0CEEzQcWWN9J0sjD+VCw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED3E6F805F1; Tue, 31 Mar 2026 04:44:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B8E8F805B6;
	Tue, 31 Mar 2026 04:44:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16131F80549; Tue, 31 Mar 2026 04:43:57 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F160CF804CC
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 04:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F160CF804CC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=gk04rblk
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62V2hgUJ32362665,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774925022; bh=JsyoiUEKMWdwJCns8TeCq6s5EkNF7n5xjNM1oTU7gU8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=gk04rblkzMo43nfwQ+NGFy0DL1bRahWBqHmB3P9FYqzym/OUGzL7F1LRdTkNRXzAc
	 WtLbHDtNo1IIVngz/OTE9Lk/jsYfSLY90K2/55cJG30tH4ukIotqUIWcihmJkRfShL
	 qY9XNkQNaPUOCbVz2bZIvbUh1iuob7uIDn+LscXa6/BxU/h+ZFN08xGiN195oOp+eC
	 gCAC5y+r7liow6MBqtZKCQIAdhpmbwDjdAl3EZtFlYaRrVXvxKh9jTnarasIEgTJuU
	 vkLxQYelMKfAP313jHZk4Hyx/1uQojRLH/5TllFi7Myg62ClpCk/oX0gKqS3HhFV4w
	 eMcZPjOSnxsEQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62V2hgUJ32362665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 10:43:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 31 Mar 2026 10:43:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 31 Mar 2026 10:43:32 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 31 Mar 2026 10:43:32 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt1320-sdw: remove brown out settings in blind_write
Date: Tue, 31 Mar 2026 10:43:29 +0800
Message-ID: <20260331024329.3833572-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: VVH545ESDBCWTDXVVIHN67AGRGR7AQ33
X-Message-ID-Hash: VVH545ESDBCWTDXVVIHN67AGRGR7AQ33
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VVH545ESDBCWTDXVVIHN67AGRGR7AQ33/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Remove brown out settings as these settings are for customized cases,
not for general cases.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1320-sdw.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 8bb7e8497c72..35797a13cc7e 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -169,12 +169,6 @@ static const struct reg_sequence rt1320_vc_blind_write[] = {
 	{ 0xd487, 0x3b },
 	{ 0xd486, 0xc3 },
 	{ 0xc598, 0x04 },
-	{ 0xdb03, 0xf0 },
-	{ 0xdb09, 0x00 },
-	{ 0xdb08, 0x7a },
-	{ 0xdb19, 0x02 },
-	{ 0xdb07, 0x5a },
-	{ 0xdb05, 0x45 },
 	{ 0xd500, 0x00 },
 	{ 0xd500, 0x17 },
 	{ 0xd600, 0x01 },
-- 
2.53.0

