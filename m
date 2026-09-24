Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6929CC98304
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:43:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2CA2601C4;
	Thu, 24 Sep 2026 03:42:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2CA2601C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790214180;
	bh=hhi4GWSXUavabY78/XYNmgpvRTFO6W8rtoO3SSP3pKE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hYoXqGxKsSYoTNTMBBAENiaNtIN6bzgmBovSjLUR63MvcKvuQ/RKdFZQafmX8222f
	 raeJTdkrEXjH9O7rcQYp12vpoymdzlpw6vT2QxYatMunPWGN44eaOz4pLJTDhIHQMs
	 k880BNLozDdRBYUsyaVVHOAYf8AaoOQ1Wmj1Tg/I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 744D3F805FA; Thu, 24 Sep 2026 03:42:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E238F805EE;
	Thu, 24 Sep 2026 03:42:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D66CF8049C; Thu, 24 Sep 2026 03:42:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790214138;
	b=DctS4WRPqehYDCQ2Pl1pCxk6jM7hb7hCOZMM0AxykAtdh9ZfBeTvbJBHkibd7AmrQCFL
	 dFrRMBrNFWSxxtycZE561aYn5xBkU6hSAeZcHCIVrN00AzIGD771OD2G+Z5DyH6ukRhWc
	 iWzWd0FBI2E8SSYZpoFgNH7ZkiDE21BgLilsL4Se8FxAd5/bbwMa/v3Bilg9mq/nI+sfH
	 ZrTNE2gQHC9nN1uLh9bqZi0aiJqVwDaQ7Hsdxb+bJYktM8Z+8GASlaDy3T1fq9jiMIhVP
	 ay6qP1iAA2yASU5YdU4AfG490g4pxmY6+622WGcjxJebCFvmAf6F8ApMtn6tMZ2V9aQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790214138;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hhi4GWSXUavabY78/XYNmgpvRTFO6W8rtoO3SSP3pKE=;
	b=hgJzjJ5wvORLh42PphkFtci1QkcOBPxAiqiJsdkUSxxN6I/DXY5nh551ZI7Ph3CAuTXj
	 AbUb4+ivxixJ6B+qsC+/mgbhBbkoO7WB+F4wVgMctaT7d8DfUnm9isf79rtrgmcc7e0Zq
	 ypH/+0fIsjLsKsXP8QVhVTs3brlU1/KaAXz6nUXeEnyYQKFAdgrq4a3PTL4/Mcin/cZE9
	 NvJcDB9EwaNE3sY+bMD6ysLjYR1oox1GK27SypfvgXsuN6M+e0Ythaz01SAdcMYX+45Nj
	 cKWRcFiaVfHfoSVdj0lFbtKK8RW/R5omBZCGkRJP+yL4aYrcTZhNYQqdS2P/OBb9e7Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=aZ7fjGmG;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 28681F8027B
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 03:42:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28681F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=aZ7fjGmG
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68O1g54w9792039,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790214125; bh=hhi4GWSXUavabY78/XYNmgpvRTFO6W8rtoO3SSP3pKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aZ7fjGmGqZ2Z2lO0BPyoubS+yLhcVAoAVMrRzzxOvSoAB27aXdJ5yomvQZbn0WI+e
	 qD16U7s671rGMPvU4P7HViQa+H5wcK0BkqYDva7BLQyX7flSBzZwwuv1BjjQCjQ/lN
	 THQS5aOFe0mLFa6oxOUtgBtkljBQqpzoDXt3YA5pV5BNzRaiAAJvWpvz9ol4MrRZ/O
	 QyWSyD2JgTm35y2tlVzB4646x+L6T194iaYpJMAzO8nom+SlXhcvSDD0Ny7T0MXyUU
	 OYCLG+9MKVV4gYRlfx6QBPNDWyxM199EKdTrSJfQIYmexnBLAI/MjfGS5s4lpe0vEr
	 0/pkafq64nWew==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68O1g54w9792039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Sep 2026 09:42:05 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 24 Sep 2026 09:42:05 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 24 Sep 2026 09:42:05 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::bb07:3e09:fb44:8906%6]) with mapi id
 15.02.2562.049; Thu, 24 Sep 2026 09:42:05 +0800
From: Jack Yu <jack.yu@realtek.com>
To: Mark Brown <broonie@kernel.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"Flove(HsinFu)" <flove@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
	=?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>,
	=?big5?B?RGVyZWsgW6TovHe4cV0=?= <derek.fang@realtek.com>
Subject: RE: [PATCH] ASoC: rt1320: make SRAM registers readable to stop being
 cached
Thread-Topic: [PATCH] ASoC: rt1320: make SRAM registers readable to stop being
 cached
Thread-Index: AQHdSZrZw2ex64qVH0iyZYRbG7wZtrbYOOKAgAQ5leA=
Date: Thu, 24 Sep 2026 01:42:05 +0000
Message-ID: <30dee5ebf4bc4594be6655f3f1587dd7@realtek.com>
References: <20260921072847.2929865-1-jack.yu@realtek.com>
 <arD0nQ4nTCuI2w0f@sirena.co.uk>
In-Reply-To: <arD0nQ4nTCuI2w0f@sirena.co.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-ID-Hash: MRL3XPMQMWD43262X4A2JN6SADPGWIUA
X-Message-ID-Hash: MRL3XPMQMWD43262X4A2JN6SADPGWIUA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MRL3XPMQMWD43262X4A2JN6SADPGWIUA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjYgNToxMSBQ
TQ0KPiBUbzogSmFjayBZdSA8amFjay55dUByZWFsdGVrLmNvbT4NCj4gQ2M6IGxnaXJkd29vZEBn
bWFpbC5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGFyc0BtZXRhZm9vLmRlOw0K
PiBGbG92ZShIc2luRnUpIDxmbG92ZUByZWFsdGVrLmNvbT47IE9kZXIgQ2hpb3UgPG9kZXJfY2hp
b3VAcmVhbHRlay5jb20+Ow0KPiBTaHVtaW5nIFutU67Ru8pdIDxzaHVtaW5nZkByZWFsdGVrLmNv
bT47IERlcmVrIFuk6Lx3uHFdDQo+IDxkZXJlay5mYW5nQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBBU29DOiBydDEzMjA6IG1ha2UgU1JBTSByZWdpc3RlcnMgcmVhZGFibGUg
dG8gc3RvcCBiZWluZw0KPiBjYWNoZWQNCj4gDQo+IE9uIE1vbiwgU2VwIDIxLCAyMDI2IGF0IDAz
OjI4OjQ3UE0gKzA4MDAsIGphY2sueXVAcmVhbHRlay5jb20gd3JvdGU6DQo+ID4gRnJvbTogSmFj
ayBZdSA8amFjay55dUByZWFsdGVrLmNvbT4NCj4gPg0KPiA+IHJ0MTMyMF92b2xhdGlsZV9yZWdp
c3RlcigpIGxpc3RzIHRoZSBTUkFNIHJhbmdlcyAweDEwMDAwMDAwLTB4MTAwMDhmZmYNCj4gPiBh
bmQgMHgxMDAwYzAwMC0weDEwMDBkZmZmIGFzIHZvbGF0aWxlLCBzbyB0aGV5IHNob3VsZCBuZXZl
ciBiZSBjYWNoZWQuDQo+ID4gQnV0IHJlZ21hcCBvbmx5IGhvbm9ycyB0aGUgdm9sYXRpbGUgZmxh
ZyBmb3IgYSByZWFkYWJsZSByZWdpc3RlciwgYW5kDQo+ID4gdGhlc2UgcmFuZ2VzIHdlcmUgbWlz
c2luZyBmcm9tIHJ0MTMyMF9yZWFkYWJsZV9yZWdpc3RlcigpLg0KPiA+IFRoZXkgd2VyZSB0aGVy
ZWZvcmUgY2FjaGVkIGF0IHByb2JlIGFuZCByZXBsYXllZCBvdmVyIFNvdW5kV2lyZSBvbg0KPiA+
IGV2ZXJ5IHJ1bnRpbWUgcmVzdW1lLCBkZWxheWluZyB0aGUgZmlyc3QgUENNIG9wZW4gYWZ0ZXIg
YXV0b3N1c3BlbmQgYnkNCj4gPiBhYm91dCBhIHNlY29uZC4NCj4gPg0KPiA+IEFkZCB0aGUgdHdv
IHJhbmdlcyB0byBydDEzMjBfcmVhZGFibGVfcmVnaXN0ZXIoKSBzbyB0aGUgdm9sYXRpbGUgZmxh
Zw0KPiA+IHRha2VzIGVmZmVjdCBhbmQgdGhlIFNSQU0gaXMgbm8gbG9uZ2VyIGNhY2hlZCBvciBy
ZXBsYXllZC4NCj4gPiBUaGUgcmVtb3ZlZCBsaW5lcyBhcmUgYWxyZWFkeSBjb3ZlcmVkIGJ5IHRo
ZSAgbmV3DQo+ID4gMHgxMDAwYzAwMC0weDEwMDBkZmZmIHJhbmdlLCBzbyBubyByZWdpc3RlciBs
b3NlcyByZWFkYWJpbGl0eS4NCj4gDQo+IFRoZSBSQUUgbG9hZGVyIHNlZW1zIHRvIGV4cGVjdCB0
aGF0IDB4MTAwMGQwMDAtMHgxMDAwZDdmZiBpcyBjYWNoZWQsIG9yIGF0DQpUaGFua3MgZm9yIHJl
bWluZGluZyB0aGlzLCBJJ2xsIGV4Y2x1ZGUgdGhpcyByYW5nZSAweDEwMDBkMDAwLTB4MTAwMGQ3
ZmYgb3V0IG9mIHRoZSB2b2xhdGlsZSByZWdpc3RlcnMuDQoNCj4gbGVhc3QgaXQncyBmaWRkbGlu
ZyB3aXRoIHRoZSBjYWNoZSBieXBhc3MgZm9yIHRoYXQgcmFuZ2UuDQo=
