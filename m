Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19422CC6B01
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2026 04:39:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B538E601F6;
	Thu,  2 Apr 2026 06:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B538E601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775104737;
	bh=H4Qhq5k4SRyG1Kva9xB8M7F8ZLLFiMHGN7XUQrB4TV4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hunmzoddsExgi4IDGNklDn/UoF+bLTtLt92rSxubn0SNbq9moRB193f4YNTLLj0V5
	 DgpnBOs/4GG0bzDGGZ+WtrgzPR69g3FASWlpGbgKCsQHoBbkSrCGGyc+5EzNkYXww1
	 ykbB0R7pgituoFv/d/ZKo7FBsC7dUzlBenDEQoCw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD084F805F6; Thu,  2 Apr 2026 06:38:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BBAAF805E6;
	Thu,  2 Apr 2026 06:38:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73E21F80496; Thu,  2 Apr 2026 06:38:12 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B3E93F8015B
	for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2026 06:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3E93F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=N/DPMfHm
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6324brgJ72432947,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775104673; bh=H4Qhq5k4SRyG1Kva9xB8M7F8ZLLFiMHGN7XUQrB4TV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=N/DPMfHmvZegb/Q9geF3qgIY5KfPiJLmgZs1msiGxarsjagYYwxGb69UjRRtpVcEO
	 NtN8CIU8Z1d112z38yfQl/NPGZAzllWTwd0QZaXKu7bazM9gR5zuJjRuAmf5es/FMZ
	 qUS+DWlCJHoOeSkE4tyM7xFbf6CYX4nlAz7DSdipVzxxl2SPzt1aLuCW4X4Hq1oGZy
	 X5To22w4zPdckULjIcelm0it76IUU5ROkZ84A3Ubp2nfHXkQOPjrgVf9TojOPZCDwL
	 JwVswthAt7Zxb0IYfYOmNs35z9V/AuGyiAlK1kTFA3/hXCYAxAp2MF4yaqM6DZMJU2
	 qS4MSjOrzAT6g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6324brgJ72432947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 12:37:53 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 12:37:54 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 12:37:53 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([fe80::f5c0:6526:d42a:7b9a]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::f5c0:6526:d42a:7b9a%6]) with mapi id
 15.02.1748.010; Thu, 2 Apr 2026 12:37:53 +0800
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
Subject: RE: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Thread-Topic: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Thread-Index: AQHcwbpPd3tYtPylQUOJUGP7gF5eEbXJq9OAgAD/iyA=
Date: Thu, 2 Apr 2026 04:37:53 +0000
Message-ID: <9aff5474398c4ac79f18f356512b5181@realtek.com>
References: <20260401093107.632673-1-jack.yu@realtek.com>
 <e5623b92-fe3a-4c3d-a93f-a9acb1fd8181@sirena.org.uk>
In-Reply-To: <e5623b92-fe3a-4c3d-a93f-a9acb1fd8181@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-ID-Hash: VORYZDDKUHRG55X3BYOYLJ2IJYOMSUC3
X-Message-ID-Hash: VORYZDDKUHRG55X3BYOYLJ2IJYOMSUC3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VORYZDDKUHRG55X3BYOYLJ2IJYOMSUC3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxLCAyMDI2IDk6MjMgUE0N
Cj4gVG86IEphY2sgWXUgPGphY2sueXVAcmVhbHRlay5jb20+DQo+IENjOiBsZ2lyZHdvb2RAZ21h
aWwuY29tOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGxhcnNAbWV0YWZvby5kZTsNCj4g
RmxvdmUoSHNpbkZ1KSA8ZmxvdmVAcmVhbHRlay5jb20+OyBPZGVyIENoaW91IDxvZGVyX2NoaW91
QHJlYWx0ZWsuY29tPjsNCj4gU2h1bWluZyBbrVOu0bvKXSA8c2h1bWluZ2ZAcmVhbHRlay5jb20+
OyBEZXJlayBbpOi8d7hxXQ0KPiA8ZGVyZWsuZmFuZ0ByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gQVNvQzogcnQxMzIwLXNkdzoga2NvbnRyb2wgZm9yIGJyb3duLW91dCBmZWF0
dXJlIHN3aXRjaA0KPiANCj4gT24gV2VkLCBBcHIgMDEsIDIwMjYgYXQgMDU6MzE6MDdQTSArMDgw
MCwgamFjay55dUByZWFsdGVrLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBKYWNrIFl1IDxqYWNrLnl1
QHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gQ3JlYXRlIGEga2NvbnRyb2wgdG8gZW5hYmxlIG9yIGRp
c2FibGUgYnJvd24tb3V0IGR5bmFtaWNhbGx5Lg0KPiANCj4gPiArc3RhdGljIGNvbnN0IGNoYXIg
KiBjb25zdCBydDEzMjBfYnJvd25fb3V0X21vZGVbXSA9IHsNCj4gPiArCSJPbiIsDQo+ID4gKwki
T2ZmIiwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBTT0NfRU5VTV9TSU5HTEVfREVDTChy
dDEzMjBfYnJvd25fb3V0X2VudW0sIDAsIDAsDQo+ID4gKwlydDEzMjBfYnJvd25fb3V0X21vZGUp
Ow0KPiA+ICsNCj4gDQo+IE9uL29mZiBzd2l0Y2hlcyBzaG91bGQgYmUgYSBTd2l0Y2ggY29udHJv
bCwgbm90IGFuIGVudW0uDQoNCk1heWJlIHRoZSBuYW1lIG9mIGtjb250cm9sIGxlYWRzIHRvIG1p
c3VuZGVyc3RhbmQsIGl0J3MganVzdCBhbiBlZmZlY3Qgc2V0dGluZyBmb3IgYW1wbGlmaWVyLg0K
SSdsbCB1cGRhdGUgdGhpcyBhbmQgdXNlIGFub3RoZXIgY29udHJvbCB0eXBlIGJ1dCBub3QgZW51
bS4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgcnQxMzIwX2Jyb3duX291dF9wdXQoc3RydWN0IHNuZF9r
Y29udHJvbCAqa2NvbnRyb2wsDQo+ID4gKwkJCQkgc3RydWN0IHNuZF9jdGxfZWxlbV92YWx1ZSAq
dWNvbnRyb2wpIHsNCj4gPiArCXN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50ID0g
c25kX2tjb250cm9sX2NoaXAoa2NvbnRyb2wpOw0KPiA+ICsJc3RydWN0IHJ0MTMyMF9zZHdfcHJp
diAqcnQxMzIwID0NCj4gc25kX3NvY19jb21wb25lbnRfZ2V0X2RydmRhdGEoY29tcG9uZW50KTsN
Cj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZydDEzMjAtPnNkd19zbGF2ZS0+ZGV2Ow0KPiA+
ICsJaW50IHJldCwgdG1wOw0KPiA+ICsNCj4gPiArCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lKGNv
bXBvbmVudC0+ZGV2KTsNCj4gPiArCWlmIChyZXQgPCAwICYmIHJldCAhPSAtRUFDQ0VTKQ0KPiA+
ICsJCXJldHVybiByZXQ7DQo+IA0KPiBPdGhlciBjb250cm9scyBpbiB0aGlzIGRyaXZlciBpZ25v
cmUgd3JpdGVzIGJlZm9yZSBod19pbml0IGlzIHNldCwgc2hvdWxkIHRoaXMNCj4gb25lPw0KV2ls
bCBmaXggaXQuDQo=
