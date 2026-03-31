Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F1CFF60C6
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:14:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2D6E601F8;
	Tue, 31 Mar 2026 08:14:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2D6E601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774937672;
	bh=ZPMVZ2BzpqNZY1IT8fkbqh5sFnf333GWng4ztJcXZmU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KGF2otSORAl97R2JW5d30R2l8psQbc42vIuLZ2+XW/0fFmVfgHIPWHuA0H8DmMbBM
	 pfd8ewTFH5iPBE6UbOarAmnaFtP2nuff+Qe1N3aa0v5fN+bzTlrNBBIyStpVados9N
	 DjGNTgoClnIi3Fq75PzCjDyF15LurjuD48d9v1OI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A98BF805E5; Tue, 31 Mar 2026 08:13:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D2F2F805ED;
	Tue, 31 Mar 2026 08:13:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 224FCF80549; Tue, 31 Mar 2026 08:13:50 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 533BBF80020
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 08:13:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 533BBF80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=cfUtLPlu
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62V6DfEhA2658028,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774937621; bh=ZPMVZ2BzpqNZY1IT8fkbqh5sFnf333GWng4ztJcXZmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cfUtLPlufo/UO+hW6P79cAqPZQcV5OK9LyckRglcyovaWnJZEZQEkG3PStJqeCHgn
	 3aG4ZphWMosejTEfwjRgpEkCnqJSJv9fnx/eVb+ifU43IjLMiZHA5MZF1gXvPRoK3j
	 KM+igcmNNVQZbeojzt9joZ6QpfQyHX6SFYTLa+cyGZFWpsrkFO4UMtsmZt9Lq+WDWz
	 tUHtmMIpnsWCL4VB37Vf1q9Mo+nqfcsN13MsuUf1PMrwfCNNC3oAbzrjw4RqLXhC2I
	 Ov/QO+L13hcAHAiOl3GOd+2WjE+rwa2YyDVsTs9YmWImnzpNCcoG/P+AxPdUxfnKSK
	 AMF7SwF8PLfrA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62V6DfEhA2658028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 14:13:41 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 31 Mar 2026 14:13:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 31 Mar 2026 14:13:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Tue, 31 Mar 2026 14:13:26 +0800
From: =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>
To: Jack Yu <jack.yu@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        =?big5?B?RGVyZWsgW6TovHe4cV0=?=
	<derek.fang@realtek.com>,
        Jack Yu <jack.yu@realtek.com>
Subject: RE: [PATCH] ASoC: rt1320-sdw: remove brown out settings in
 blind_write
Thread-Topic: [PATCH] ASoC: rt1320-sdw: remove brown out settings in
 blind_write
Thread-Index: AQHcwLiHIBlYCw8M5keuR/3AM85Pp7XIJYAQ
Date: Tue, 31 Mar 2026 06:13:26 +0000
Message-ID: <0988744b1e204b9592adac69569fc4a4@realtek.com>
References: <20260331024329.3833572-1-jack.yu@realtek.com>
In-Reply-To: <20260331024329.3833572-1-jack.yu@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-ID-Hash: HU4JKSOU4GADDVRUV4JJBDKD2FBXKETL
X-Message-ID-Hash: HU4JKSOU4GADDVRUV4JJBDKD2FBXKETL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HU4JKSOU4GADDVRUV4JJBDKD2FBXKETL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

PiBSZW1vdmUgYnJvd24gb3V0IHNldHRpbmdzIGFzIHRoZXNlIHNldHRpbmdzIGFyZSBmb3IgY3Vz
dG9taXplZCBjYXNlcywgbm90IGZvcg0KPiBnZW5lcmFsIGNhc2VzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSmFjayBZdSA8amFjay55dUByZWFsdGVrLmNvbT4NCj4gLS0tDQo+ICBzb3VuZC9zb2Mv
Y29kZWNzL3J0MTMyMC1zZHcuYyB8IDYgLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3J0MTMyMC1zZHcu
YyBiL3NvdW5kL3NvYy9jb2RlY3MvcnQxMzIwLXNkdy5jDQo+IGluZGV4IDhiYjdlODQ5N2M3Mi4u
MzU3OTdhMTNjYzdlIDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL3J0MTMyMC1zZHcu
Yw0KPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3J0MTMyMC1zZHcuYw0KPiBAQCAtMTY5LDEyICsx
NjksNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ19zZXF1ZW5jZQ0KPiBydDEzMjBfdmNfYmxp
bmRfd3JpdGVbXSA9IHsNCj4gIAl7IDB4ZDQ4NywgMHgzYiB9LA0KPiAgCXsgMHhkNDg2LCAweGMz
IH0sDQo+ICAJeyAweGM1OTgsIDB4MDQgfSwNCj4gLQl7IDB4ZGIwMywgMHhmMCB9LA0KPiAtCXsg
MHhkYjA5LCAweDAwIH0sDQo+IC0JeyAweGRiMDgsIDB4N2EgfSwNCj4gLQl7IDB4ZGIxOSwgMHgw
MiB9LA0KPiAtCXsgMHhkYjA3LCAweDVhIH0sDQo+IC0JeyAweGRiMDUsIDB4NDUgfSwNCj4gIAl7
IDB4ZDUwMCwgMHgwMCB9LA0KPiAgCXsgMHhkNTAwLCAweDE3IH0sDQo+ICAJeyAweGQ2MDAsIDB4
MDEgfSwNCg0KUGxlYXNlIGhvbGQgb2ZmIG9uIG1lcmdpbmcgdGhpcyBwYXRjaCwgYXMgd2UgbmVl
ZCB0byBkaXNjdXNzIGl0IGludGVybmFsbHkuDQoNCg==
