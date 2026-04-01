Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C2DD3517D
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:03:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDA75601F6;
	Wed,  1 Apr 2026 15:03:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDA75601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775048595;
	bh=1vdYpAhH6pgwj4zvSGuGxfcrPA63DWWu5ig3UOs0hW0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dcWn8sOMbWLZRStFSl8svgEKVZFEfVdqeca+F6uqszLKRG4wNCSC6HJNCFn4M+FM0
	 Kk97sAav9HpjmDs7ccOmZPRReaJGXm9YWJCM6MIHuyHNzQ1QFLjxf8ZucXiHS3rtPe
	 /rCtQAATZ7NKyMrU7nzuO/8jm/qv1YhGAk6TbapE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E3C2F805F1; Wed,  1 Apr 2026 15:02:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 15686F805F2;
	Wed,  1 Apr 2026 15:02:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A83FCF80527; Wed,  1 Apr 2026 15:02:32 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C1A93F80171
	for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2026 15:02:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1A93F80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=bc8/DKeu
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 631D2IJ501109535,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775048538; bh=NOhoU0xMIEE6bx6WTYH0w7HxGFA1PGgWUUMmqCjHp6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version;
	b=bc8/DKeu/J4/czDxesiwRQul6pvSFDE0ATKFxnnKBAjKgzyW9Eb306dljtQ/RMxIe
	 y62hoA0tcd6dcn4QmIXRjIUlKaMP7uKmc5K9QHHtDZ/vHDDYNOs2e7dtOBPZP9r86p
	 l+QdzkcE3OezUzuRpJGRjA4xZeGw7OcsI5+bq2FIMa6imrlBv7UrEDRpOt+VFMqI+J
	 +FWcZrbbpjGB1aGwYaCgBcss5OtjF0BoK3TWwO7/U6cA3sgsAmfaKrwuH9pVNsEvWr
	 t10dAb9tJ18oV1v7ZypWhKtsMcHGkyZASXJlMt07rLdcP+cMojJJX6xKPQlwh9Ggvm
	 IVSpIBqDnCGWA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 631D2IJ501109535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 21:02:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Apr 2026 21:02:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Apr 2026 21:02:17 +0800
Received: from RTKEXHMBS05.realtek.com.tw ([fe80::5e14:1ddb:ee82:82d6]) by
 RTKEXHMBS05.realtek.com.tw ([fe80::5e14:1ddb:ee82:82d6%4]) with mapi id
 15.02.1748.010; Wed, 1 Apr 2026 21:02:17 +0800
From: =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>
To: Jack Yu <jack.yu@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        =?big5?B?RGVyZWsgW6TovHe4cV0=?=
	<derek.fang@realtek.com>
Subject: RE: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Thread-Topic: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Thread-Index: AQHcwbpLZrZScQAXPkCDSh+BbTeGebXKKxpX
Date: Wed, 1 Apr 2026 13:02:17 +0000
Message-ID: <28496ff7e8274da0a9b2471de20cda5e@realtek.com>
References: <20260401093107.632673-1-jack.yu@realtek.com>
In-Reply-To: <20260401093107.632673-1-jack.yu@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.16.3.61]
MIME-Version: 1.0
Message-ID-Hash: 7FKAYC6O2QB3EXD4WIZMFE5ZZSH7R2KP
X-Message-ID-Hash: 7FKAYC6O2QB3EXD4WIZMFE5ZZSH7R2KP
X-MailFrom: shumingf@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="big5"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7FKAYC6O2QB3EXD4WIZMFE5ZZSH7R2KP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

K3N0YXRpYyBpbnQgcnQxMzIwX2Jyb3duX291dF9wdXQoc3RydWN0IHNuZF9rY29udHJvbCAqa2Nv
bnRyb2wsDQoNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzbmRfY3Rs
X2VsZW1fdmFsdWUgKnVjb250cm9sKQ0KK3sNCisgICAgICAgc3RydWN0IHNuZF9zb2NfY29tcG9u
ZW50ICpjb21wb25lbnQgPSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJvbCk7DQorICAgICAgIHN0
cnVjdCBydDEzMjBfc2R3X3ByaXYgKnJ0MTMyMCA9IHNuZF9zb2NfY29tcG9uZW50X2dldF9kcnZk
YXRhKGNvbXBvbmVudCk7DQorICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZydDEzMjAtPnNk
d19zbGF2ZS0+ZGV2Ow0KKyAgICAgICBpbnQgcmV0LCB0bXA7DQorDQorICAgICAgIHJldCA9IHBt
X3J1bnRpbWVfcmVzdW1lKGNvbXBvbmVudC0+ZGV2KTsNCisgICAgICAgaWYgKHJldCA8IDAgJiYg
cmV0ICE9IC1FQUNDRVMpDQorICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCisNCisgICAgICAg
cnQxMzIwLT5icm93bl9vdXQgPSB1Y29udHJvbC0+dmFsdWUuaW50ZWdlci52YWx1ZVswXTsNCisg
ICAgICAgcmVnY2FjaGVfY2FjaGVfYnlwYXNzKHJ0MTMyMC0+cmVnbWFwLCB0cnVlKTsNCisNCisg
ICAgICAgaWYgKHJ0MTMyMC0+YnJvd25fb3V0ID09IDEpDQorICAgICAgICAgICAgICAgcmVnbWFw
X3dyaXRlKHJ0MTMyMC0+cmVnbWFwLCAweGRiMDMsIDB4MDApOw0KKyAgICAgICBlbHNlDQorICAg
ICAgICAgICAgICAgcmVnbWFwX3dyaXRlKHJ0MTMyMC0+cmVnbWFwLCAweGRiMDMsIDB4ZjApOw0K
Kw0KKyAgICAgICByZWdjYWNoZV9jYWNoZV9ieXBhc3MocnQxMzIwLT5yZWdtYXAsIGZhbHNlKTsN
CisNCisgICAgICAgcmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBpbnQgcnQxMzIwX2Jyb3duX291
dF9nZXQoc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHNuZF9jdGxfZWxlbV92YWx1ZSAqdWNvbnRyb2wpDQor
ew0KKyAgICAgICBzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNvbXBvbmVudCA9IHNuZF9rY29u
dHJvbF9jaGlwKGtjb250cm9sKTsNCisgICAgICAgc3RydWN0IHJ0MTMyMF9zZHdfcHJpdiAqcnQx
MzIwID0gc25kX3NvY19jb21wb25lbnRfZ2V0X2RydmRhdGEoY29tcG9uZW50KTsNCisNCisgICAg
ICAgdWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFsdWVbMF0gPSBydDEzMjAtPmJyb3duX291dDsN
CisNCisgICAgICAgcmV0dXJuIDA7DQorfQ0KKw0KIHN0YXRpYyBpbnQgcnQxMzIwX3IwX3RlbXBl
cmF0dXJlX2dldChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNuZF9jdGxfZWxlbV92YWx1ZSAqdWNvbnRy
b2wpDQogew0KQEAgLTI1NDUsNiArMjU5MCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tj
b250cm9sX25ldyBydDEzMjBfc25kX2NvbnRyb2xzW10gPSB7DQogICAgICAgICAgICAgICAgIHJ0
MTMyMF9yMF90ZW1wZXJhdHVyZV9nZXQsIHJ0MTMyMF9yMF90ZW1wZXJhdHVyZV9wdXQpLA0KICAg
ICAgICAgU09DX1NJTkdMRV9FWFQoIlJBRSBVcGRhdGUiLCBTTkRfU09DX05PUE0sIDAsIDEsIDAs
DQogICAgICAgICAgICAgICAgIHJ0MTMyMF9yYWVfdXBkYXRlX2dldCwgcnQxMzIwX3JhZV91cGRh
dGVfcHV0KSwNCisgICAgICAgU09DX0VOVU1fRVhUKCJCcm93biBPdXQgU3dpdGNoIiwgcnQxMzIw
X2Jyb3duX291dF9lbnVtLA0KKyAgICAgICAgICAgICAgIHJ0MTMyMF9icm93bl9vdXRfZ2V0LCBy
dDEzMjBfYnJvd25fb3V0X3B1dCksDQogfTsNCg0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tj
b250cm9sX25ldyBydDEzMjBfc3BrX2xfZGFjID0NCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29k
ZWNzL3J0MTMyMC1zZHcuaCBiL3NvdW5kL3NvYy9jb2RlY3MvcnQxMzIwLXNkdy5oDQppbmRleCA1
YTlmNDk2ZGQ4NDguLjRhMWQzZmM0YzhlZSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mv
cnQxMzIwLXNkdy5oDQorKysgYi9zb3VuZC9zb2MvY29kZWNzL3J0MTMyMC1zZHcuaA0KQEAgLTE1
OSw2ICsxNTksNyBAQCBzdHJ1Y3QgcnQxMzIwX3Nkd19wcml2IHsNCiAgICAgICAgIGJvb2wgaHdf
aW5pdDsNCiAgICAgICAgIGJvb2wgZmlyc3RfaHdfaW5pdDsNCiAgICAgICAgIGludCB2ZXJzaW9u
X2lkOw0KKyAgICAgICBpbnQgYnJvd25fb3V0Ow0KICAgICAgICAgdW5zaWduZWQgaW50IGRldl9p
ZDsNCg0KQ291bGQgeW91IHNldCBicm93bl9vdXQgdG8gMSBieSBkZWZhdWx0Pw0KVGhlIGJsaW5k
IHdyaXRlIGVuYWJsZXMgYnJvd24tb3V0IGJ5IGRlZmF1bHQuDQoNCg0K
