Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3627C5B572
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:31:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B482C6026A;
	Tue, 18 Aug 2026 04:31:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B482C6026A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787020286;
	bh=kpFikTJmExSUnqL2LqSE9PnF1UCQNYGBN8yr9vWOA98=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=gJtQwOTavXb2XjmyjVP8+tvlXUgF2PTfILqEXAWP51Gm2SGhRGth6TAH6nFrz3W+E
	 BKc6Ij58PCbhnHLKUw+HtreIafNh471+lt9nKVWLnu/2DF+JqY8kH8TJYCpDSY/ph0
	 QplUqDs2h5gDHenoecrsbPql6VV85RbHio1ep5oQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1199CF805FD; Tue, 18 Aug 2026 04:30:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68461F80600;
	Tue, 18 Aug 2026 04:30:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D3DEF8055C; Tue, 18 Aug 2026 04:30:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787020239;
	b=hzTzveO4Vjw4NNaJS4wM/cPJG9jYzzUqFQ8OUhhQPi3IGBCMFaJHxvX6TyLNN897h2Of
	 F6XvN4fsMCzE8HXInMzH7PcKs5S4DcLxhujTuYy0Hq8DJIXmGkCFT3w5ex8cDk9l2Cev0
	 6rC62FM8qhOFVFs9MTugAKY0TDGHBlTQGOzD+L0xFTuTnkRbj4DQKHg2zS2WJ8jB6eH31
	 EZvVu5kdMGYB0dInbXzay+9YvQA8vFtGymRL4MPVZw7bFSipmnrNprqvAODPSeN0DOSJx
	 nxUbuHZbe235yituPyKq0fnznh3KctOyU+Qu8Kj7gmxXj5CJtx0yI2wz0lsG8pxMAYA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787020239;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kpFikTJmExSUnqL2LqSE9PnF1UCQNYGBN8yr9vWOA98=;
	b=Y/epiBVusL9DK3tXfW/0Dix3cBIqJo+2HbyiIxPQPCr5zBK7V0xnpY08oco+dsdqJA02
	 MM/+/+ln5ZqunecEwlZZCiUBzIPA8RWLpTVD8Nvj48CtD9a7pYKHNEdBJJTHhTnjrmYPd
	 Xg+tVdx/yAGmbS/YGU8VUOOavqXW36gZhW6/o43TkmID/xEElWoyGYcOb+zf/lTLyl7Po
	 lcjbWxCOhJCp+5y6xzHMZIPf0Fl3aIoxB3rfPr7zgrl78yQGTwdSqVrEGhqQ7NR/YccuS
	 dJ5p53ooCAIn6lZDq5FEkWGycaEYypu4zjqaIeGcoZzOP3XycwmAZIMn84nyeDUf4QQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=GrcSfp3H;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C0411F801F7
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2026 04:30:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0411F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=GrcSfp3H
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67I2UOXm8429551,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1787020225; bh=ECVnyGnrTvg4xG0kPbTxCPFlmouBIOAByXGkcDXLvEU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=GrcSfp3HNOlyzkZFjZs2os5nUpQjSJQ+SvOqvG2B/Hl5Xeeflanu4X3EeMA66MmFz
	 +ov44JLJPtQ8ik/UC2zXXPFZwxOhftvtkjsbCgXfJ9+x0KzAHStevf+CgFhtQTjDDP
	 KwM58xZNZ48QkeRhDaZqRETM2RnkHMOk5jyiO+3HFY9jz7dA6XfnIl9aZkka21xzEh
	 fg1aMzKlHJ6OgdEI/1p4HuIEmX1mSRK/lpD29TDH5XIh+DB27fhXpiWHCHck5NubWr
	 6sBkL9d4v3dhOj4rm4G8KppbxYkMFuCSGetyEa0jwLSBznMHcez3bWrEdGbGXLrIS/
	 cA/TdV0TDelhA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67I2UOXm8429551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 10:30:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 18 Aug 2026 10:30:24 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Tue, 18 Aug 2026 10:30:23 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	<Trevor.Wu@mediatek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: sdw_utils: fix double put_device() on aggregated amps
Date: Tue, 18 Aug 2026 10:30:18 +0800
Message-ID: <20260818023018.2564212-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: UTGXKSI23TXYDPYIJCT2CMHLPSKQTLG4
X-Message-ID-Hash: UTGXKSI23TXYDPYIJCT2CMHLPSKQTLG4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UTGXKSI23TXYDPYIJCT2CMHLPSKQTLG4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

In aggregation mode with two identical amplifiers,
a stress test that repeatedly triggers card unbind/rebind
can hit a NULL pointer dereference during the exit path.
ctx->amp_dev1 / ctx->amp_dev2 are single shared resources,
so the release must be safe against being called more than once.
Clear each pointer after put_device() so a second invocation
becomes a no-op, this could address NULL pointer dereference issue.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/sdw_utils/soc_sdw_rt_amp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sdw_utils/soc_sdw_rt_amp.c b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
index 4e9b08cb653d..81d2cbac0ea3 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_amp.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
@@ -252,11 +252,13 @@ int asoc_sdw_rt_amp_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai
 	if (ctx->amp_dev1) {
 		device_remove_software_node(ctx->amp_dev1);
 		put_device(ctx->amp_dev1);
+		ctx->amp_dev1 = NULL;
 	}
 
 	if (ctx->amp_dev2) {
 		device_remove_software_node(ctx->amp_dev2);
 		put_device(ctx->amp_dev2);
+		ctx->amp_dev2 = NULL;
 	}
 
 	return 0;
-- 
2.54.0

