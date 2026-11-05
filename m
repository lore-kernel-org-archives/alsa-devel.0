Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E12606A331
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=d4dTyrFo;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=CgWDKyX9
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39B9760171;
	Thu,  5 Nov 2026 08:11:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39B9760171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793862718;
	bh=UNZog9uULP3Yohn1wuGDxbMWfcExy7kssRYQiGp3WDo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=d4dTyrFopxZ1foBtUOO+Tl3/y6hyZdKQnFwEZcALiBB0Op4K0MJ5XOIAxOStVrpx9
	 NRGDyIILcHpcqRvuQGNyFFOeXbaaqgqaVthjyzQMC4tJGdAENdfPDIPypD9Essedog
	 ZKwoCZMPeGx5Ok/2f+1PSren7Gj69eMbE9yrZUmw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67182F80600; Thu,  5 Nov 2026 08:11:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3341F805FA;
	Thu,  5 Nov 2026 08:11:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73886F804FF; Thu,  5 Nov 2026 08:11:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793862669;
	b=IfXk74mfkTcMwEi8nQP1CjgVcRNMJcdvn9LahV/pYbRbO2iSjKfdyrnehES0e2TG4HN1
	 Ki4Hnfvx9laeetOAEoklNA4OPNLeKeRmmiudrklB65OdXNnF/9n4WWjzRcVTIHjgYNA2U
	 o+mFduiDPraf+4aDMduMaDh15EFTm1ee9G14IEpqH10i/rJVuCU/3WHuB6BbEbC87f8fC
	 u3cf0iHwT9U3WfnNGBN0k9p0aWwBLHPSOiwxjGrmheHm0lU9acs4vgSZprMyTgXWxYHii
	 X78UFI/i/wyQnZR9UdrnpaWVmS4Azs2tNsuu0N5wKLLU1JsVsOMmClBxGUBOcVJi2jw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793862669;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UNZog9uULP3Yohn1wuGDxbMWfcExy7kssRYQiGp3WDo=;
	b=UDiVlRDQ4Ip+TP/sl+xKvMPEoKK5uQcKhD9ImGh+1d9ER82+56Yf28FxSb1etD7yUi8q
	 SBwq51kJLxTf7Ij42hStWlAbHT/Lnqg6sFsE9v+QosxHlLcW3xkQt9legYumjGDtaoPnS
	 hhovmZ+pOdPZe2ntnw2qjqGJPcJyjSKU77brwbhJGu+xdlTMbeyF/68UCMVvX7QyDKxnQ
	 AHyTFfiarqf63ri5FNPL6YnMl8FjDrGYXA4qBwgZsSaeiYx2Jg9tNKFolOihdoluDhuww
	 AolVQTqUtr+y/TkgDKLg14NJbgd6guM/wixnwCipU9Iuqxct9+snFZ7Na1WiFnZWZeg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=CgWDKyX9;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D903F802DB
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 08:11:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D903F802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=CgWDKyX9
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A57Av2wA550595,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793862657; bh=UNZog9uULP3Yohn1wuGDxbMWfcExy7kssRYQiGp3WDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CgWDKyX940u8FKHalsJLAboZqBQrAZ8k8mbSCI1A766b9VPI085Jhy93MZvemlaTP
	 B49WpKArVGBh4gQFMe4IRUUE8YPKWmkSxnFuem6ZE51jYcb7zWZU90Be6A1SltXjwB
	 hwfgEF+qo/zN1YuuGTAbap5v7WYg3O0C+Soes+P/QmBBih7/t1bQx9l/kcjZn7Uo/g
	 ahOAC594dqECypVlT377NwS50P6n1Bdl22+w2gu42eglsa5Rl8SbzBWbyQzogOCTCF
	 +Ck1O7iCHPVz+s16CUqmI/QEkQcvMGRlXE/nTnA0+8icPQHq4QVgaBExNt4ohWC4iA
	 biORQmW/ciYiQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A57Av2wA550595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Nov 2026 15:10:57 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 15:10:58 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 15:10:58 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([fe80::60ba:b031:beb5:d1d6]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::60ba:b031:beb5:d1d6%6]) with mapi id
 15.02.2562.056; Thu, 5 Nov 2026 15:10:58 +0800
From: Jack Yu <jack.yu@realtek.com>
To: Mark Brown <broonie@kernel.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"Flove(HsinFu)" <flove@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
	=?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
	=?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Subject: RE: [PATCH] ASoC: rt1320-sdw: Update the driver to support rt1321_va2
Thread-Topic: [PATCH] ASoC: rt1320-sdw: Update the driver to support
 rt1321_va2
Thread-Index: AQHdbAepgw5ouBeh7Ua9/IFW71kcKLcdT5oAgAHAgkA=
Date: Thu, 5 Nov 2026 07:10:57 +0000
Message-ID: <51400a0b6bf64c28b233de539a0e2849@realtek.com>
References: <20261104025321.822219-1-jack.yu@realtek.com>
 <179379483277.2456854.13813848595708930532.b4-review@b4>
In-Reply-To: <179379483277.2456854.13813848595708930532.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: D42HVO23OFT6WKO44ET46KKZ7TRXO76T
X-Message-ID-Hash: D42HVO23OFT6WKO44ET46KKZ7TRXO76T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D42HVO23OFT6WKO44ET46KKZ7TRXO76T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA0LCAyMDI2IDg6MjEg
UE0NCj4gVG86IEphY2sgWXUgPGphY2sueXVAcmVhbHRlay5jb20+DQo+IENjOiBicm9vbmllQGtl
cm5lbC5vcmc7IGxnaXJkd29vZEBnbWFpbC5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZzsNCj4gbGFyc0BtZXRhZm9vLmRlOyBGbG92ZShIc2luRnUpIDxmbG92ZUByZWFsdGVrLmNvbT47
IE9kZXIgQ2hpb3UNCj4gPG9kZXJfY2hpb3VAcmVhbHRlay5jb20+OyBTaHVtaW5nIFvojIPmm7jp
iphdIDxzaHVtaW5nZkByZWFsdGVrLmNvbT47DQo+IERlcmVrIFvmlrnlvrfnvqldIDxkZXJlay5m
YW5nQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBU29DOiBydDEzMjAtc2R3
OiBVcGRhdGUgdGhlIGRyaXZlciB0byBzdXBwb3J0DQo+IHJ0MTMyMV92YTINCj4gDQo+IA0KPiBF
eHRlcm5hbCBtYWlsIDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSB0aGUgb3Jn
YW5pemF0aW9uLiBEbyBub3QNCj4gcmVwbHksIGNsaWNrIGxpbmtzLCBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kDQo+IGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gPiBSVDEzMjEgVkEyIG5lZWRzIGEgZGlmZmVyZW50
IGZsb3cgZnJvbSBWQTAvVkExOg0KPiA+DQo+ID4gLSBMb2FkIHRoZSBWQTIgTUNVIHBhdGNoIGNv
ZGUuDQo+ID4gLSBVcGRhdGUgdGhlIFZBMiBpbml0IHNldHRpbmdzIGFuZCBhZGQgdGhlIGNvbXBh
bmlvbiBtb2RlIHNldHRpbmdzLg0KPiA+IC0gQmVmb3JlIFIwIGNhbGlicmF0aW9uIGFuZCBSMCBs
b2FkLCBzd2l0Y2ggdG8gVFYgbW9kZSBhbmQgZGlzYWJsZQ0KPiA+ICAgcGhhc2Ugc3luYy9zaWxl
bmNlIGRldGVjdGlvbiBzbyB0aGUgRFNQIEZXIHNlcnZlcyBHRVQvU0VUX1BBUkFNLg0KPiA+IC0g
VGFrZSB0aGUgVkEyIGFkdmFuY2UgZ2FpbiBmcm9tIHRoZSBBRlgxIGhlYWRlciBvZiB0aGUgRFNQ
IEZXLg0KPiA+IC0gRXh0ZW5kIHRoZSByZWFkYWJsZS92b2xhdGlsZSByYW5nZSBvZiB0aGUgRFNQ
IHN0YXR1cyByZWdpc3RlcnMuDQo+ID4gLSBJbmNyZWFzZSB0aGUgQlJBIHNlY3Rpb25zIHRvIDE2
IGZvciB0aGUgMTQtc2VjdGlvbiBEU1AgRlcgcGFja2FnZS4NCj4gPiAtIEhvbGQgYSBydW50aW1l
IFBNIHJlZmVyZW5jZSBpbiB0aGUga2NvbnRyb2wgcHV0IGhhbmRsZXJzIHRvIGF2b2lkDQo+ID4g
ICBydW50aW1lIHN1c3BlbmQgaW4gdGhlIG1pZGRsZSBvZiBhIGxvbmcgRFNQIGFjY2Vzcy4NCj4g
Pg0KPiA+IFRoZSBWQTIgTUNVIHBhdGNoIGNvZGUgaXMgc3VibWl0dGVkIHRvIGxpbnV4LWZpcm13
YXJlIHNlcGFyYXRlbHkuDQo+IA0KPiA+IEBAIC0xMjkxLDYgKzEzMDUsMTIgQEAgc3RhdGljIGlu
dCBydDEzMjBfY2hlY2tfZndfcmVhZHkoc3RydWN0DQo+IHJ0MTMyMF9zZHdfcHJpdiAqcnQxMzIw
KQ0KPiA+ICAgICAgICAgICAgICAgcmVnbWFwX3JlYWQocnQxMzIwLT5yZWdtYXAsIGNtZF9hZGRy
LCAmdG1wKTsNCj4gPiAgICAgICAgICAgICAgIGlmICh0bXAgPT0gMCkNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAgICBlbHNlIGlmICh0bXAgIT0gMHgx
ICYmIHRtcCAhPSAweDIgJiYgdG1wICE9IDB4Mykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBkZXZfd2FybihkZXYsICIlcyBhYm5vcm1hbCB2YWwsIHRtcDoleCIsDQo+IF9fZnVuY19fLCB0
bXApOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgODsgaSsrKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ21hcF93cml0ZShydDEzMjAtPnJl
Z21hcCwNCj4gUlQxMzIxX0ZXX1BBUkFNX0FERFIgKyBpLCAweDAwKTsNCj4gDQo+IFRoaXMgYWZm
ZWN0cyBhbGwgdGhlIHBhcnRzLCBhcmUgeW91IHN1cmUgaXQncyByaWdodCBmb3IgUlQxMzIwPw0K
SSdsbCBhZGQgYSBmbGFnIHRvIGRpZmZlcmVudGlhdGUgaXQgYW5kIG1ha2UgaXQgdmEyIG9ubHku
DQoNCj4gDQo+ID4gKyAgICAgaWYgKGlzX3ZhMikgew0KPiA+ICsgICAgICAgICAgICAgcmVnbWFw
X3JlYWQocnQxMzIwLT5yZWdtYXAsIDB4YzVmYiwgJnJlZ19jNWZiKTsNCj4gPiArICAgICAgICAg
ICAgIHJlZ21hcF93cml0ZShydDEzMjAtPnJlZ21hcCwgMHhjNWZiLCAweDAwKTsNCj4gPiArICAg
ICAgICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhydDEzMjAtPnJlZ21hcCwgMHhjMDQ3LCAweDgw
LCAweDAwKTsNCj4gPiArICAgICAgICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhydDEzMjAtPnJl
Z21hcCwgMHhjMDQ0LCAweGUwLCAweDAwKTsNCj4gPiArICAgICAgICAgICAgIGZvciAoaSA9IDA7
IGkgPCAyMDA7IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZWdtYXBfcmVhZChy
dDEzMjAtPnJlZ21hcCwNCj4gUlQxMzIwX1BPV0VSX1NUQVRFLCAmcmVnX2M1NjApOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBpZiAocmVnX2M1NjAgPT0gUlQxMzIwX0tfUjBfU1RBVEUpDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwMCwgMTUwMDApOw0KPiA+ICsgICAgICAgICAgICAg
fQ0KPiA+ICsgICAgICAgICAgICAgZGV2X2RiZyhkZXYsICIlcywgUlQxMzIwX1BPV0VSX1NUQVRF
PTB4JXgsIGk9JWRcbiIsDQo+IF9fZnVuY19fLA0KPiANCj4gUGVyaGFwcyBydDEzMjBfY2hlY2tf
cG93ZXJfc3RhdGVfcmVhZHkoKSBjb3VsZCB0YWtlIHNvbWUgcGFyYW1ldGVycz8NCkknbGwgZml4
IGl0IGluIHYyIHBhdGNoLg0KDQo+IA0KPiA+IEBAIC0xNjYwLDYgKzE3MDksMzAgQEAgc3RhdGlj
IHZvaWQgcnQxMzIwX2NhbGlicmF0ZShzdHJ1Y3QNCj4gcnQxMzIwX3Nkd19wcml2ICpydDEzMjAp
DQo+ID4gICAgICAgICAgICAgICBnb3RvIF9maW5pc2hfOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+
ICsgICAgIGlmIChpc192YTIpIHsNCj4gPiArICAgICAgICAgICAgIC8qIFN3aXRjaCB0byBUViBt
b2RlICovDQo+ID4gKyAgICAgICAgICAgICByZWdtYXBfd3JpdGUocnQxMzIwLT5yZWdtYXAsIDB4
YzVmYiwgMHgwMCk7DQo+ID4gKyAgICAgICAgICAgICByZWdtYXBfd3JpdGUocnQxMzIwLT5yZWdt
YXAsIDB4Y2QwMCwgMHhjNSk7DQo+ID4gKyAgICAgICAgICAgICAvKiBkaXNhYmxlIHBoYXNlIHN5
bmMgKi8NCj4gPiArICAgICAgICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhydDEzMjAtPnJlZ21h
cCwgMHhjMDQ3LCAweDgwLCAweDAwKTsNCj4gPiArICAgICAgICAgICAgIC8qIHRocm91Z2ggU1JD
ICovDQo+ID4gKyAgICAgICAgICAgICByZWdtYXBfd3JpdGUocnQxMzIwLT5yZWdtYXAsIDB4YzVj
NCwgMHgxMik7DQo+ID4gKyAgICAgICAgICAgICByZWdtYXBfd3JpdGUocnQxMzIwLT5yZWdtYXAs
IDB4YzU3MCwgMHgwYik7DQo+IA0KPiBEbyB3ZSBuZWVkIHRvIGNsZWFuIHVwIGluIHRoZSBlcnJv
ciBoYW5kbGluZyBwYXRoIGhlcmU/DQpJJ2xsIGZpeCBpdCBpbiB2MiBwYXRjaC4NCj4gDQo+IC0t
DQo+IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCg==
