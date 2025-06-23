Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D43C77B7F
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:26:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 627D2602BF;
	Fri, 27 Jun 2025 15:25:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 627D2602BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1751030763;
	bh=P3kETJ8LidkPZ//hW+gPV08IjIWLb5wulVSUE8kb97w=;
	h=From:To:Cc:Subject:Date:References:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZmyIXSDfDktP9khlDlXgOma1J0bzNf6rBhxSwHKWqO0MoC0dIewvFs6aAVcoNCPRi
	 4Rc4PDYC3m0y/TdpE9YwtpiT8DeJ72onVdfM086h7agAFmxTGWuezs+IkdzrTI9wYy
	 Q/KQhmO38VWbWhWytOJFJpLc/rIC8SMHhmus8Q7U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17B32F806CA; Fri, 27 Jun 2025 15:23:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BB751F806C8;
	Fri, 27 Jun 2025 15:23:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8035F80424; Mon, 23 Jun 2025 09:03:52 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21CF1F8013D
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2025 09:03:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21CF1F8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256
 header.s=mail20170921 header.b=D2+xuEaO
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250623070344epoutp01d151b0204c749de5917f1443c8119dec~LmgRyJNHo3159931599epoutp01M
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2025 07:03:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250623070344epoutp01d151b0204c749de5917f1443c8119dec~LmgRyJNHo3159931599epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750662224;
	bh=YTLfCfcDzwFqFf1VO++bPGO86I60DjAXQ5KSiJJ+9JQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=D2+xuEaOBg6NSOKaaIk/HyluydzNPAzVLDZjHgwcW+pwbdfC1/U/ELio0xiIDlMk6
	 W+VwwNkg4HXgLIzefoO2scSgdTXVQPXbakzNZLNSz57/f0/Y+sTk7PeMvCqBSGah6N
	 Vgc/Z9tNcwaSlh4hM1OxVYbcCP6hhHXrZa4Cy810=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250623070343epcas2p2a6da5d633764311650e541a9c297a3e6~LmgRfQtKt0483104831epcas2p25;
	Mon, 23 Jun 2025 07:03:43 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.36.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bQfFB5Jlvz3hhTM; Mon, 23 Jun
	2025 07:03:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250623070342epcas2p40b58c1bf858f69021e917deddc76015d~LmgP5NGdG0481904819epcas2p4h;
	Mon, 23 Jun 2025 07:03:42 +0000 (GMT)
Received: from KORCO117793 (unknown [12.36.188.221]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250623070341epsmtip2595ecbbd0cb912e76fe85f5f7c924f4a~LmgP1hbE20757107571epsmtip20;
	Mon, 23 Jun 2025 07:03:41 +0000 (GMT)
From: =?ks_c_5601-1987?B?wMy9wrrz?= <seungbin.lee@samsung.com>
To: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <perex@perex.cz>, <tiwai@suse.de>
Cc: <pilsun.jang@samsung.com>, <s47.kang@samsung.com>,
	<donghee.moon@samsung.com>
Subject: [PATCH] ASoC: soc-compress: Fix race condition in soc_compr_open_fe
Date: Mon, 23 Jun 2025 16:03:41 +0900
Message-ID: <009401dbe40c$f3df4dc0$db9de940$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdvkDPOwqDp8ee4vSw2zWHcjHl49Kg==
Content-Language: ko
X-CMS-MailID: 20250623070342epcas2p40b58c1bf858f69021e917deddc76015d
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250623070342epcas2p40b58c1bf858f69021e917deddc76015d
References: 
 <CGME20250623070342epcas2p40b58c1bf858f69021e917deddc76015d@epcas2p4.samsung.com>
X-MailFrom: seungbin.lee@samsung.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: NER5DWOIQA4K4PU2ZAOMBG3CWZQ7POAR
X-Message-ID-Hash: NER5DWOIQA4K4PU2ZAOMBG3CWZQ7POAR
X-Mailman-Approved-At: Fri, 27 Jun 2025 13:23:47 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NER5DWOIQA4K4PU2ZAOMBG3CWZQ7POAR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Seungbin Lee <seungbin.lee@samsung.com>
Date: Wed, 18 Jun 2025 13:33:02 +0900
Subject: [PATCH] ASoC: soc-compress: Fix race condition in soc_compr_open_fe

If the soc_compr_trigger_fe function is called during snd_soc_dpcm_runtime_update execution,
the FE's DPCM runtime update variable may be changed.
Then the BE list connected to the FE flies away, and the BE cannot be closed.

This needs to be protected by the snd_soc_dpcm_mutex_lock.

Change-Id: Ibfd1712e6baf41a30afa357a91ada83d205f968b
Signed-off-by: Seungbin Lee <seungbin.lee@samsung.com>
---
 sound/soc/soc-compress.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index fc8db54352541..1a2a3fe6a2340 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -286,6 +286,8 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 
 	snd_soc_card_mutex_lock(fe->card);
 
+	snd_soc_dpcm_mutex_lock(fe);
+
 	ret = snd_soc_dai_compr_trigger(cpu_dai, cstream, cmd);
 	if (ret < 0)
 		goto out;
@@ -315,6 +317,8 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 
 out:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	snd_soc_dpcm_mutex_unlock(fe);
+
 	snd_soc_card_mutex_unlock(fe->card);
 	return ret;
 }
-- 
2.34.1

