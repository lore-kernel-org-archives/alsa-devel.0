Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1F8C79F82
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:10:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C159601E9;
	Tue,  8 Sep 2026 13:10:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C159601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788865830;
	bh=wB6eH7vtX5RELgHdeidW/dLJguhlXy44t3G22lp6S2M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gaAEpiOErKlzfxxS5NI+x9m9Q/2JGPvb9mT95RSwKy4X6Fiu+b54Q4tnBOL+lnJ24
	 fCVJJikWHcK0F/nNnsea/40/eBM/qchtXJ+lpTWWBVSLMms+QYYgFnRcCrtpgNud0W
	 fI6EvJlsGOjvd52BnoGPtmD743b+oNTQ7szEk5Ng=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9893F805F9; Tue,  8 Sep 2026 13:09:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74298F805F4;
	Tue,  8 Sep 2026 13:09:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B40D7F80518; Tue,  8 Sep 2026 13:09:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788865788;
	b=r4KsRQqKCisib5YDXKaKU5vu0izQlawDXb1szLoMemFljA1fru1quDdd1jrSvcFiipnZ
	 xuA5j+FfICfO+ctSBmpbgimcB1T4Cr1P7ommfggeDbS+7jom/Pznc768E6EhjZ4NnmoaX
	 gm+xSrQ2itGL9aRPxfL0Byh+5QW+9w+oQ7w9n5EMXcEJrgiZy+DSPE/J9AUsyqIWQmF0U
	 HDN7qcdTx+QFoydmmNpPRxj+5DgkR8t1HQBO276r3rHgLqz5lVa0EUV/zeO9CwpHFCU+d
	 ICqB3oR8gm2twXiFxHY2XYTueJXMDIeBwgrUWePsspmqMZdzvt99/SI2UFe0jV8LuCg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788865788;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wB6eH7vtX5RELgHdeidW/dLJguhlXy44t3G22lp6S2M=;
	b=Mb57qx8Se3uqBUk72zbxSrWAnYE0F0aHdBNe3+I99p3zr1D6GOXTqGY6LVtGgs/jyhKp
	 9qOzViZOylCVUXG+INiwzBIpCWVND1PNbeIxAj2hlctKyk7szueTRhfJ1FQljVbFWRuvc
	 BqWgM+ypWv+5yX7GbXNHTHWgNzc4hf9JCm4ywuq8pQk2f5LomrB6BVhYT9s5qiW/SaOPd
	 FclpufMf1RLCvY3egJwXsv4WYt+lsAC4QBmDJe179bQfpNQJV/YFNK8uc29EPL3NrUnPT
	 w+vQgvaMv1mXq8clj6qrxYiKUx3DaGeU3R2grLLYVooGEahTlZ8KYRDXUZlwAdlyyPQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=RYays6rB;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99586F8025A
	for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2026 13:09:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99586F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=RYays6rB
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 688B9ZfC43866591,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788865775; bh=wB6eH7vtX5RELgHdeidW/dLJguhlXy44t3G22lp6S2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RYays6rB++dAw7xy0+Huy+3cTNJ8vPTdXt4MdqMm75iue17dVp1Pz64tT7DMwNHL2
	 1PsDvOk81WLGpEy3axUbR+zS/I8vD2pS8KYxBTIjZPxoZ7nXHaMHmMBX7WeyjlbQ4d
	 DVkClkds0dU5g/LABva77jIJzyL3zPs7p3vHOXaVW4KXjbnLX6WZh0ys4RzhYYAWoT
	 S3gCQahOxla1ENYfoISDBH+I47o01iY4KtKeMAaPTPrH3ZZfAAed1lRV6Uq7PvtH4p
	 DVDrIE2FPQ9T1cxXR/i2Uf3LMCEfTQt/QksVdw7ygrGqx5/vrQtS/JgEX7vjILuwz/
	 MxkxrOD+3ZUUw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 688B9ZfC43866591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Sep 2026 19:09:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 8 Sep 2026 19:09:35 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 8 Sep 2026 19:09:35 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::6d7e:80bb:9fcb:1a5e%6]) with mapi id
 15.02.2562.043; Tue, 8 Sep 2026 19:09:35 +0800
From: Jack Yu <jack.yu@realtek.com>
To: Mark Brown <broonie@kernel.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"Flove(HsinFu)" <flove@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
	=?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>,
	=?big5?B?RGVyZWsgW6TovHe4cV0=?= <derek.fang@realtek.com>,
	"Trevor.Wu@mediatek.com" <Trevor.Wu@mediatek.com>
Subject: RE: [PATCH] ASoC: rt712-sdca: reconfigure PLL2 to fix calibration
 time-out
Thread-Topic: [PATCH] ASoC: rt712-sdca: reconfigure PLL2 to fix calibration
 time-out
Thread-Index: AQHdPpPjPYx1xlY/kkywjF4k6LNwbLbDHUoAgADkgVA=
Date: Tue, 8 Sep 2026 11:09:35 +0000
Message-ID: <9a9d58e0fadc44879ae33b0ba2ed1671@realtek.com>
References: <20260907064114.435697-1-jack.yu@realtek.com>
 <9f563c50-e18f-421a-8325-e70e7d482b51@sirena.org.uk>
In-Reply-To: <9f563c50-e18f-421a-8325-e70e7d482b51@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-ID-Hash: BUMRSAY7D7CPQKUQ2ICUZ7IUPKSTOFUF
X-Message-ID-Hash: BUMRSAY7D7CPQKUQ2ICUZ7IUPKSTOFUF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BUMRSAY7D7CPQKUQ2ICUZ7IUPKSTOFUF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDgsIDIwMjYgNTozMiBB
TQ0KPiBUbzogSmFjayBZdSA8amFjay55dUByZWFsdGVrLmNvbT4NCj4gQ2M6IGxnaXJkd29vZEBn
bWFpbC5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGFyc0BtZXRhZm9vLmRlOw0K
PiBGbG92ZShIc2luRnUpIDxmbG92ZUByZWFsdGVrLmNvbT47IE9kZXIgQ2hpb3UgPG9kZXJfY2hp
b3VAcmVhbHRlay5jb20+Ow0KPiBTaHVtaW5nIFutU67Ru8pdIDxzaHVtaW5nZkByZWFsdGVrLmNv
bT47IERlcmVrIFuk6Lx3uHFdDQo+IDxkZXJlay5mYW5nQHJlYWx0ZWsuY29tPjsgVHJldm9yLld1
QG1lZGlhdGVrLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBU29DOiBydDcxMi1zZGNhOiBy
ZWNvbmZpZ3VyZSBQTEwyIHRvIGZpeCBjYWxpYnJhdGlvbg0KPiB0aW1lLW91dA0KPiANCj4gT24g
TW9uLCBTZXAgMDcsIDIwMjYgYXQgMDI6NDE6MTRQTSArMDgwMCwgamFjay55dUByZWFsdGVrLmNv
bSB3cm90ZToNCj4gPiBGcm9tOiBKYWNrIFl1IDxqYWNrLnl1QHJlYWx0ZWsuY29tPg0KPiA+DQo+
ID4gQWRkIHBsbDIgcmVjb25maWd1cmF0aW9uIHNlcXVlbmNlIGluIG9yZGVyIHRvIGZpeCBjYWxp
YnJhdGlvbiB0aW1lLW91dA0KPiA+IGlzc3VlIGFuZCB0byBzdXBwb3J0IDI0LjU3Nk1IeiBNQ0xL
IG9uIHNwZWNpZmljIHBsYXRmb3Jtcy4NCj4gDQo+ID4gK3N0YXRpYyB2b2lkIHJ0NzEyX3NkY2Ff
Y2xrX3BhdGNoMihzdHJ1Y3QgcnQ3MTJfc2RjYV9wcml2ICpydDcxMikgew0KPiANCj4gDQo+ID4g
KwlyZWdtYXBfd3JpdGUocnQ3MTItPnJlZ21hcCwgUlQ3MTJfU0RXX1NDQUxFX0NMSzAsIDB4MDMp
Ow0KPiA+ICsJcmVnbWFwX3dyaXRlKHJ0NzEyLT5yZWdtYXAsIFJUNzEyX1NEV19TQ0FMRV9DTEsx
LCAweDAzKTsNCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBpdCBjb2xsaWRlcyB3aXRoIHNkd19zbGF2
ZV9zZXRfZnJlcXVlbmN5KCk/DQoNCkFmdGVyIHRlc3RpbmcsIHRoZXNlIHR3byByZWdpc3RlcnMg
Y2FuIGJlIHJlbW92ZWQgZnJvbSB0aGUgcGF0Y2ggYW5kIHRoZSBwYXRjaCBjYW4gc3RpbGwgZml4
IGlzc3VlLg0KSSdsbCB1cGRhdGUgdGhpcyBpbiBWMiBwYXRjaC4NCj4gDQo+ID4gKwlpZiAobG9v
cF9kYyA9PSBjaGtfY250KSB7DQo+ID4gKwkJaWYgKGNsa19iYXNlID09IFJUNzEyX0NMS19GUkVR
XzI0XzU3Nk1IWikgew0KPiA+ICsJCQlydDcxMl9zZGNhX2Nsa19wYXRjaChydDcxMik7DQo+ID4g
KwkJCXJ0NzEyX3NkY2FfY2xrX3BhdGNoMihydDcxMik7DQo+ID4gKwkJfQ0KPiANCj4gUGVyaGFw
cyB0aGUgcGF0Y2hpbmcgc2hvdWxkIGJlIGNoZWNraW5nIHRoYXQgdGhlIHNjYWxpbmcgcmVnaXN0
ZXJzIGFyZSB0aGUgb25lcw0KPiB3cml0dGVuIGFib3ZlIGFuZCBvbmx5IGtpY2tpbmcgaW4gaWYg
dGhhdCdzIHRoZSBjYXNlLCBvciBoYXZlIG1vcmUgY2FzZXMgdGhhdA0KPiB3b3JrIHdpdGggb3Ro
ZXIgc2NhbGluZyBzZXR1cHM/ICBPciByZXN0b3JlIHdoYXRldmVyIHRoZSBjb3JlIHNldCBpZiB0
aGF0J3MNCj4gcG9zc2libGU/DQpJJ2xsIHJlbW92ZSB0aG9zZSB0d28gcmVnaXN0ZXJzIG1lbnRp
b25lZCBhYm92ZSBhbmQgdXBkYXRlIGEgVjIgcGF0Y2guDQo=
