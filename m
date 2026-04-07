Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90C4EDB7CC
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:09:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52EDF601F2;
	Tue,  7 Apr 2026 11:09:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52EDF601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775552969;
	bh=MQVQYmXZSlSl5NIa7D1txwfGVs6bykKbJsmim6HVolM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LRFLdGZyqSDXjDh2DI1sacxtaQzne2vsBnqPBAA4Yn7CNhVglzrIBhcGurW7zPIgr
	 XHtxiAfzQlfMNfX4JIpsHAkluDCysK/25ioGSXy7cK6i6qVdP5Y9vFtpaOHvHDZLjZ
	 jHwb9pXFJVfNbwV5IJBpSFwyA6AT2TwztC8T6Tuo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EE8FF805F0; Tue,  7 Apr 2026 11:08:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EEEAF805F2;
	Tue,  7 Apr 2026 11:08:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CC5DF80548; Tue,  7 Apr 2026 11:08:46 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 586DDF8001F
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 11:08:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 586DDF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=Robm9JvX
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63798XE40778426,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775552913; bh=MQVQYmXZSlSl5NIa7D1txwfGVs6bykKbJsmim6HVolM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Robm9JvXoGFlzvB/cjBUvD56DNJzohbG/CZxub6dcX8CWxo5qT0/zBJWRgug4S9HL
	 fPse8fA465+Qd6arqXm6RM3g9eVz221FlJUvbo7VuvHii5g1Tn8p5m3mOQWaR3BELk
	 4yXP/wVN8l+dA5Rlrl14806l/8+5p7j3msLDq6ES1KMxm4USR/3kueAIdJ0e47MnUp
	 9kUXj2OoshivBqy2pqmxLYKk/Jy4aP5ZYqPdNSOQngaq1eGHvdHV1US5eDgZvSdr5K
	 /Tx5vzB04RDs6ow5NzuLZdIYv4epkhGzgLdjj+OeIl0JUB3urNnhSkpxZ40lu5L+6N
	 tWC+WGGlwm+gg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63798XE40778426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 17:08:33 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 7 Apr 2026 17:08:33 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 7 Apr 2026 17:08:33 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([fe80::f5c0:6526:d42a:7b9a]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::f5c0:6526:d42a:7b9a%6]) with mapi id
 15.02.1748.010; Tue, 7 Apr 2026 17:08:33 +0800
From: Jack Yu <jack.yu@realtek.com>
To: Mark Brown <broonie@kernel.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>,
        =?big5?B?RGVyZWsgW6TovHe4cV0=?= <derek.fang@realtek.com>
Subject: RE: [PATCH 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Thread-Topic: [PATCH 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Thread-Index: AQHcwmQuGYaaDuX0zUW9Z6I/716fzrXLIckAgAeviXA=
Date: Tue, 7 Apr 2026 09:08:33 +0000
Message-ID: <b58acdb490524d22a229914a7b63f03a@realtek.com>
References: <20260402054716.1795350-1-jack.yu@realtek.com>
 <55886bf3-5837-4f37-b60d-333fdc5f5f70@sirena.org.uk>
In-Reply-To: <55886bf3-5837-4f37-b60d-333fdc5f5f70@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-ID-Hash: WEH4OUY3V5SKO5JDXMRUZS6AQ7P3FRYB
X-Message-ID-Hash: WEH4OUY3V5SKO5JDXMRUZS6AQ7P3FRYB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WEH4OUY3V5SKO5JDXMRUZS6AQ7P3FRYB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmll
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyLCAyMDI2IDc6NDYgUE0NCj4g
VG86IEphY2sgWXUgPGphY2sueXVAcmVhbHRlay5jb20+DQo+IENjOiBsZ2lyZHdvb2RAZ21haWwu
Y29tOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGxhcnNAbWV0YWZvby5kZTsNCj4gRmxv
dmUoSHNpbkZ1KSA8ZmxvdmVAcmVhbHRlay5jb20+OyBPZGVyIENoaW91IDxvZGVyX2NoaW91QHJl
YWx0ZWsuY29tPjsNCj4gU2h1bWluZyBbrVOu0bvKXSA8c2h1bWluZ2ZAcmVhbHRlay5jb20+OyBE
ZXJlayBbpOi8d7hxXQ0KPiA8ZGVyZWsuZmFuZ0ByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzJdIEFTb0M6IHJ0MTMyMC1zZHc6IGtjb250cm9sIGZvciBicm93bi1vdXQgZmVh
dHVyZQ0KPiB1cGRhdGUNCj4gDQo+IE9uIFRodSwgQXByIDAyLCAyMDI2IGF0IDAxOjQ3OjE1UE0g
KzA4MDAsIGphY2sueXVAcmVhbHRlay5jb20gd3JvdGU6DQo+IA0KPiA+ICsJU09DX1NJTkdMRV9F
WFQoIkJyb3duIE91dCBVcGRhdGUiLCBTTkRfU09DX05PUE0sIDAsIDEsIDAsDQo+ID4gKwkJcnQx
MzIwX2Jyb3duX291dF9nZXQsIHJ0MTMyMF9icm93bl9vdXRfcHV0KSwNCj4gDQo+IExpa2UgSSBz
YXkgdGhpcyBzaG91bGQgYmUgYSBTd2l0Y2ggLSBpdCdzIGFuIG9uL29mZiBjb250cm9sLCBldmVu
IGlmIGl0J3MgZm9yIGFuDQo+IGFsZ29yaXRobS4NCg0KRG8geW91IG1lYW4gSSBzaG91bGQgdXNl
ICJCcm93biBPdXQgU3dpdGNoIiBpbnN0ZWFkIG9mICJCcm93biBPdXQgVXBkYXRlIj8NCkFuZCBz
dGlsbCB1c2UgU09DX1NJTkdMRV9FWFQgZm9yIGRlY2xhcmF0aW9uLCBsaWtlIGJlbG93DQogU09D
X1NJTkdMRV9FWFQoIkJyb3duIE91dCBTd2l0Y2giLCBTTkRfU09DX05PUE0sIDAsIDEsIDAsDQoJ
CSBydDEzMjBfYnJvd25fb3V0X2dldCwgcnQxMzIwX2Jyb3duX291dF9wdXQpDQo=
