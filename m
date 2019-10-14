Return-Path: <SRS0=QzCZ=YH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80A7C4CECE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 01:48:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268D0207FF
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 01:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P/MwoWJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268D0207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50AD51665;
	Mon, 14 Oct 2019 03:47:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50AD51665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571017689;
	bh=WOQaf+JfoOQPlmyAa/GGHc6T95TuzCIFYSbFjJMHcsw=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/MwoWJuEvTqrWIml4Uc+1ZkmkPp2c/UAMp5Kzy4HU0d5VPG6V0/vPwXjmhK67v/E
	 EdjE/ItOPYWQV7fqR/9hylEEwwtSAftTd/Zs2piEJjqW1LCVkH2Dbo0A+ooQtEck4Z
	 b019byRj9/OBNcKen7RRh3l9O1MQBGsMs38xNgP8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B62DF805AE;
	Mon, 14 Oct 2019 03:46:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13621F8036C; Mon, 14 Oct 2019 03:46:18 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 255DBF80362
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 03:46:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 255DBF80362
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9E1k4Ff026809,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
 by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9E1k4Ff026809
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2019 09:46:05 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 14 Oct 2019 09:46:04 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 14 Oct 2019 09:46:04 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::6d88:58e2:6d4b:ff7c]) by
 RTEXMB01.realtek.com.tw ([fe80::6d88:58e2:6d4b:ff7c%13]) with mapi id
 15.01.1779.005; Mon, 14 Oct 2019 09:46:04 +0800
From: =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>
To: Mark Brown <broonie@kernel.org>
Thread-Topic: [PATCH] ASoC: rt1011: export r0 and temperature config
Thread-Index: AdV9u26p1DMGwkqZTrmPc4068Rp6yQBd1tCAAL9J7sA=
Date: Mon, 14 Oct 2019 01:46:04 +0000
Message-ID: <408b28994a044dfd91b832e4cef1cadb@realtek.com>
References: <8f933cee57fc4420875e1e2ba14f1937@realtek.com>
 <20191010142019.GC4741@sirena.org.uk>
In-Reply-To: <20191010142019.GC4741@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.105]
MIME-Version: 1.0
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "cychiang@google.com" <cychiang@google.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt1011: export r0 and temperature
	config
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

PiBPbiBUdWUsIE9jdCAwOCwgMjAxOSBhdCAwOTozMzoyNEFNICswMDAwLCBTaHVtaW5nIFvojIPm
m7jpiphdIHdyb3RlOg0KPiA+IEluIGNocm9tZWJvb2sgY2FzZSwgdGhlIG1hY2hpbmUgZHJpdmVy
IHdpbGwgZ2V0IHRoZQ0KPiA+IHIwIGNhbGlicmF0aW9uIGRhdGEgYW5kIHRlbXBlcmF0dXJlIGZy
b20gVlBELg0KPiA+IFRoZXJlZm9yZSwgdGhlIGNvZGVjIGV4cG9ydHMgcjAgYW5kIHRlbXBlcmF0
dXJlIGNvbmZpZyBBUEkgZm9yIGl0Lg0KPiANCj4gVGhpcyBkb2Vzbid0IHNlZW0gdG8gYXBwbHkg
YWdhaW5zdCBjdXJyZW50IGNvZGUsIHBsZWFzZSBjaGVjayBhbmQgcmVzZW5kLg0KDQpUaGFua3Mg
TWFyay4gSSB3aWxsIGNoZWNrIHdpdGggR29vZ2xlIHdoZXRoZXIgc3RpbGwgdXNpbmcgdGhpcyBt
ZXRob2QuIElmIHNvLCBJIHdpbGwgcmVzZW5kIHRoZSBwYXRjaC4NCg0KPiAtLS0tLS1QbGVhc2Ug
Y29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
