Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A50C4345F
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:30:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19C8E14DE;
	Mon, 15 Apr 2024 11:30:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19C8E14DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713173452;
	bh=DtmJZ84p6y3rURGDJp/hAiJA4qzixaMZdEFaLjGV5FA=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=D5yOWHVJaOjVyMu0+LK3OlOdFNhx6AMbFcTVF48q5dzwdl1kLLplPinRLgwGaSq6u
	 JwZbReiKk0mtF3QAGGvc7jvsqZYYFzz/2cetFdy/Gnbp5fafQha9OL81n12UHQiFhz
	 K8EljI58Ag6OA8J5n5iDzG55MuZB50I6cBw1A0pY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5F48F8057D; Mon, 15 Apr 2024 11:30:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50B5BF80587;
	Mon, 15 Apr 2024 11:30:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0DB2DF8025A; Mon, 15 Apr 2024 11:28:20 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 18FF8F801C0
	for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2024 11:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18FF8F801C0
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43F9RoVhA825187,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43F9RoVhA825187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 17:27:55 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 17:27:51 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 17:27:50 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975]) by
 RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975%5]) with mapi id
 15.01.2507.035; Mon, 15 Apr 2024 17:27:50 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
Subject: RE: Thinkpad with ALC1318 has a chance of damaging the IC
Thread-Topic: Thinkpad with ALC1318 has a chance of damaging the IC
Thread-Index: AdqLKCI9ErPUavK7TEaXgj62PwNxmgD7qaAA
Date: Mon, 15 Apr 2024 09:27:50 +0000
Message-ID: <c646c8ef954d41e6b8fa78b202fd306d@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.102.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID-Hash: CD44EUWXTYI5FQ6JE6PLCKSSJICX33OX
X-Message-ID-Hash: CD44EUWXTYI5FQ6JE6PLCKSSJICX33OX
X-MailFrom: kailang@realtek.com
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,

Please don't apply this patch.
They want to add stream open to enable GPIO3 functions.

BR,
Kailang

> -----Original Message-----
> From: Kailang
> Sent: Wednesday, April 10, 2024 5:23 PM
> To: Takashi Iwai (tiwai@suse.de) <tiwai@suse.de>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Thinkpad with ALC1318 has a chance of damaging the IC
>=20
> Hi Takashi,
>=20
> Thinkpad with ALC1318 has a chance of damaging the IC at S4 resume.
>=20
> BR,
> Kailang
