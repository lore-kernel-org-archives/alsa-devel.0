Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5248ED3517C
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:12:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A189D601F6;
	Wed,  1 Apr 2026 15:11:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A189D601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775049123;
	bh=dewN2eS1A9uOVvzjIcz87mEF8jxBFJB4J53futaxflY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YGoZ26a5Ugl02727PKNyQZLthyVk5SsWuF7goa8UsUzLzSQMv+fDcH1HK169WmlyJ
	 77rRKJ8pNco+St+QBRVu7CW5u7T6KM0SMFirXm0ZbOms0DekPGO73SzXvhdJPxoZKX
	 VmiAnE8XJaIqBoMHhOJM4gOY9ESWb49HWrmSax+8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE71BF805E5; Wed,  1 Apr 2026 15:11:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5624BF805EA;
	Wed,  1 Apr 2026 15:11:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26816F80527; Wed,  1 Apr 2026 15:11:23 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 62FC7F80171
	for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2026 15:11:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62FC7F80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=Q/DPBpBL
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 631DBGUI01118014,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775049076; bh=dewN2eS1A9uOVvzjIcz87mEF8jxBFJB4J53futaxflY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Q/DPBpBLeSev/m2F2/n+Sm3/v8M+TE8ens+Nzugr+ki2aUtx+2X/8OZPO2TQJ8w5f
	 iYjMvZAFtTLIkj9hgWj3mI4t7GokGtGGxAZmePpjtba9NUAOcA7957v7LbZP4PwYsC
	 twpXPncDwvB4+416Ka4WLyOOyPh1P7EmSoRYiEJAzz524IRGkzjwkPmfoLN5nt8Rm+
	 /CFyTb2noocpeywdh2Qz1z36/2TBfvJsbyNpWKs14pYHc2H286BLKi9dcBmEMbwDH6
	 +d02mlUtx+7pOEUhLevMvQ8YpMpQDkU944J60Uq89erhrzSz6/60NgUX/TuxvyYzC+
	 Vi3skIrv3Q08Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 631DBGUI01118014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 21:11:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Apr 2026 21:11:14 +0800
Received: from RTKEXHMBS05.realtek.com.tw ([fe80::5e14:1ddb:ee82:82d6]) by
 RTKEXHMBS05.realtek.com.tw ([fe80::5e14:1ddb:ee82:82d6%4]) with mapi id
 15.02.1748.010; Wed, 1 Apr 2026 21:11:14 +0800
From: =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>
To: Jack Yu <jack.yu@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?=
	<derek.fang@realtek.com>
Subject: RE: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Thread-Topic: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Thread-Index: AQHcwbpLZrZScQAXPkCDSh+BbTeGebXKKxpXgAABgzY=
Date: Wed, 1 Apr 2026 13:11:14 +0000
Message-ID: <72d466aade174c82ba5eabe898906231@realtek.com>
References: 
 <20260401093107.632673-1-jack.yu@realtek.com>,<28496ff7e8274da0a9b2471de20cda5e@realtek.com>
In-Reply-To: <28496ff7e8274da0a9b2471de20cda5e@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.16.3.62]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-ID-Hash: REKVTXZH4POREOBFOQAUYEZAGEJ73WQW
X-Message-ID-Hash: REKVTXZH4POREOBFOQAUYEZAGEJ73WQW
X-MailFrom: shumingf@realtek.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/REKVTXZH4POREOBFOQAUYEZAGEJ73WQW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

PiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3J0MTMyMC1zZHcuaCBiL3NvdW5kL3Nv
Yy9jb2RlY3MvcnQxMzIwLXNkdy5oDQo+ID4gaW5kZXggNWE5ZjQ5NmRkODQ4Li40YTFkM2ZjNGM4
ZWUgMTAwNjQ0DQo+ID4gLS0tIGEvc291bmQvc29jL2NvZGVjcy9ydDEzMjAtc2R3LmgNCj4gPiAr
KysgYi9zb3VuZC9zb2MvY29kZWNzL3J0MTMyMC1zZHcuaA0KPiA+IEBAIC0xNTksNiArMTU5LDcg
QEAgc3RydWN0IHJ0MTMyMF9zZHdfcHJpdiB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBib29sIGh3
X2luaXQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBib29sIGZpcnN0X2h3X2luaXQ7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoCBpbnQgdmVyc2lvbl9pZDsNCj4gPiArwqDCoMKgwqDCoMKgIGludCBicm93
bl9vdXQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgZGV2X2lkOw0KDQoNCj4g
Q291bGQgeW91IHNldCBicm93bl9vdXQgdG8gMSBieSBkZWZhdWx0Pw0KPiBUaGUgYmxpbmQgd3Jp
dGUgZW5hYmxlcyBicm93bi1vdXQgYnkgZGVmYXVsdC4NCg0KU29ycnksIEkgbWlzdW5kZXJzdG9v
ZC4NCkxHVE0uDQoNClJldmlld2VkLWJ5OiBTaHVtaW5nIEZhbiA8c2h1bWluZ2ZAcmVhbHRlay5j
b20+DQogICAgICA=
