Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC983D35159
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:35:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BD14601F4;
	Wed,  1 Apr 2026 10:34:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BD14601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775032508;
	bh=GXar2YTBLQkgVQdPJeNkvQro765mVvccLvDmD8VUOMw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YJIi6SLQdZ79eKAC7SN7nZNjqZEsxZLI47f3zcTx4AC53g1k35k0TaDyObFICv4NA
	 kom/2OhqYk5NGyW6iZmnjov62MRFk42CV8qFrKRKOoZ8z16ckT/yoLgvP1yHGntcqT
	 1+VOnePXU886+jNj/7xd7CYLhWASKwnctfrubhuw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A66AEF805EE; Wed,  1 Apr 2026 10:34:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2290AF805EA;
	Wed,  1 Apr 2026 10:34:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77457F80527; Wed,  1 Apr 2026 10:34:25 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BBEF8F8047D
	for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2026 10:34:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBEF8F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=LrvEvMno
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6318YEqB4757657,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775032454; bh=GXar2YTBLQkgVQdPJeNkvQro765mVvccLvDmD8VUOMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LrvEvMnoWox6sp5anH5D+EywvrQY1q38mp0sl+Vuog9KQYeCsnO7koTcqyOz2PoiV
	 99K8WpgPaS9Z+YjoJR5DDvvRdSyuexyeo8p5umM8PS1Px1JMpXoe+urjMc6qWsQYgi
	 4F362hAQoW1jkjPXQpga/LPZU0tA6m+qnk8V3v338fry1X9tChH1x+ES+yozVW1CX4
	 FdlNh5+M6IFCy+kLeXi7ybUfCzroi3pp32UuyblS4KxpkvULF9qxV8HkdAuPSCgBQA
	 ZmnU9bHYArG5cnp0ZGDdljNJIzO+zuoNqjoTKQ21NJklX+nSlXmVzYbreFAiJfsnsW
	 G1fF4BuTQMFwg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6318YEqB4757657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 16:34:14 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Apr 2026 16:34:14 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([fe80::93f4:c10e:a4b4:7ced]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::93f4:c10e:a4b4:7ced%6]) with mapi id
 15.02.1748.010; Wed, 1 Apr 2026 16:34:14 +0800
From: Jack Yu <jack.yu@realtek.com>
To: =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        =?big5?B?RGVyZWsgW6TovHe4cV0=?=
	<derek.fang@realtek.com>
Subject: RE: [PATCH] ASoC: rt1320-sdw: remove brown out settings in
 blind_write
Thread-Topic: [PATCH] ASoC: rt1320-sdw: remove brown out settings in
 blind_write
Thread-Index: AQHcwLgvVqLZqUIea0+myGzxIWktSrXHo2sAgAI/YHA=
Date: Wed, 1 Apr 2026 08:34:14 +0000
Message-ID: <e46265bf85754c6d89f8a8fdd5283ecc@realtek.com>
References: <20260331024329.3833572-1-jack.yu@realtek.com>
 <0988744b1e204b9592adac69569fc4a4@realtek.com>
In-Reply-To: <0988744b1e204b9592adac69569fc4a4@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-ID-Hash: IWXOJVOLPLXONWB2QLKXVW6LIRJPY2D2
X-Message-ID-Hash: IWXOJVOLPLXONWB2QLKXVW6LIRJPY2D2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IWXOJVOLPLXONWB2QLKXVW6LIRJPY2D2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgTWFyaywNCg0KUGxlYXNlIGRyb3AgdGhpcyBwYXRjaCwgSSdsbCBzZW5kIGFuIHVwZGF0ZSBw
YXRjaCBsYXRlci4NClRoYW5rcy4NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFNodW1pbmcgW61TrtG7yl0gPHNodW1pbmdmQHJlYWx0ZWsuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBNYXJjaCAzMSwgMjAyNiAyOjEzIFBNDQo+IFRvOiBKYWNrIFl1IDxqYWNrLnl1QHJl
YWx0ZWsuY29tPjsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBsZ2lyZHdvb2RAZ21haWwuY29tDQo+
IENjOiBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGxhcnNAbWV0YWZvby5kZTsgRmxvdmUo
SHNpbkZ1KQ0KPiA8ZmxvdmVAcmVhbHRlay5jb20+OyBPZGVyIENoaW91IDxvZGVyX2NoaW91QHJl
YWx0ZWsuY29tPjsgRGVyZWsgW6TovHe4cV0NCj4gPGRlcmVrLmZhbmdAcmVhbHRlay5jb20+OyBK
YWNrIFl1IDxqYWNrLnl1QHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBBU29D
OiBydDEzMjAtc2R3OiByZW1vdmUgYnJvd24gb3V0IHNldHRpbmdzIGluDQo+IGJsaW5kX3dyaXRl
DQo+IA0KPiA+IFJlbW92ZSBicm93biBvdXQgc2V0dGluZ3MgYXMgdGhlc2Ugc2V0dGluZ3MgYXJl
IGZvciBjdXN0b21pemVkIGNhc2VzLA0KPiA+IG5vdCBmb3IgZ2VuZXJhbCBjYXNlcy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphY2sgWXUgPGphY2sueXVAcmVhbHRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIHNvdW5kL3NvYy9jb2RlY3MvcnQxMzIwLXNkdy5jIHwgNiAtLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc291bmQv
c29jL2NvZGVjcy9ydDEzMjAtc2R3LmMNCj4gPiBiL3NvdW5kL3NvYy9jb2RlY3MvcnQxMzIwLXNk
dy5jIGluZGV4IDhiYjdlODQ5N2M3Mi4uMzU3OTdhMTNjYzdlDQo+ID4gMTAwNjQ0DQo+ID4gLS0t
IGEvc291bmQvc29jL2NvZGVjcy9ydDEzMjAtc2R3LmMNCj4gPiArKysgYi9zb3VuZC9zb2MvY29k
ZWNzL3J0MTMyMC1zZHcuYw0KPiA+IEBAIC0xNjksMTIgKzE2OSw2IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgcmVnX3NlcXVlbmNlDQo+ID4gcnQxMzIwX3ZjX2JsaW5kX3dyaXRlW10gPSB7DQo+ID4g
IAl7IDB4ZDQ4NywgMHgzYiB9LA0KPiA+ICAJeyAweGQ0ODYsIDB4YzMgfSwNCj4gPiAgCXsgMHhj
NTk4LCAweDA0IH0sDQo+ID4gLQl7IDB4ZGIwMywgMHhmMCB9LA0KPiA+IC0JeyAweGRiMDksIDB4
MDAgfSwNCj4gPiAtCXsgMHhkYjA4LCAweDdhIH0sDQo+ID4gLQl7IDB4ZGIxOSwgMHgwMiB9LA0K
PiA+IC0JeyAweGRiMDcsIDB4NWEgfSwNCj4gPiAtCXsgMHhkYjA1LCAweDQ1IH0sDQo+ID4gIAl7
IDB4ZDUwMCwgMHgwMCB9LA0KPiA+ICAJeyAweGQ1MDAsIDB4MTcgfSwNCj4gPiAgCXsgMHhkNjAw
LCAweDAxIH0sDQo+IA0KPiBQbGVhc2UgaG9sZCBvZmYgb24gbWVyZ2luZyB0aGlzIHBhdGNoLCBh
cyB3ZSBuZWVkIHRvIGRpc2N1c3MgaXQgaW50ZXJuYWxseS4NCg0K
