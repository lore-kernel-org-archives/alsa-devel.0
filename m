Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608EC606A323
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Xgt+Gxhi;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=pIOf1/+Z
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A59D601DE;
	Mon,  9 Nov 2026 09:58:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A59D601DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794214699;
	bh=tYiEsvuAudo/hUd178dO9DpXF1IHbcbVZFhF8+sq4A4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Xgt+Gxhix3LGKUTpzCXHNerIwPEgDNaL9E7ZUKb3RDrLw7jc8tc7ptMaXQkFU3R4y
	 sIpr2dfs0Jwvl66ZXADzU0kDTzC+mmSG8FsoJD76+eZA06Ok+r6txldcPzLVnBUxwM
	 DsqAZMNeo6qEI86ZXmJV96pmjgf+ndcciySwTfYw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 658B6F805F2; Mon,  9 Nov 2026 09:57:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 616C8F805EF;
	Mon,  9 Nov 2026 09:57:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1ACF4F805C7; Mon,  9 Nov 2026 09:57:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794214653;
	b=NKhKQcq0WrDLqFDd3q30y2EaXnyjG75Qh4Jqvy5Fp3W7PzCZumUFxMAskCywzx+ra0Cq
	 6dbIUeG82R8QT74Zd7+YKbXzuLiYTyn8KCggZFpmm260sPDXHCfurc3mrBk0Kexmmx4Oc
	 ttPkzidQsAwanOFf0QNgQ+py2vkTeFcAn6dmibVdGRmWhZQUCjt1smh64dFLLe6dahnRU
	 n3gdyhF+TB5jwJXjLd/OxUEVmf8i34lsNWaqQhu6kW0ZjSfCAJTkV5rdAlfoWBB3zpK/z
	 PqFn1KEAkzWJMe9W1mOv9YHg9exdo3R7KIcoGSTH87j89KbQQiueq0DxVypzgstckAQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794214653;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tYiEsvuAudo/hUd178dO9DpXF1IHbcbVZFhF8+sq4A4=;
	b=qI6IIFczjypO60yMmk6rqbMh/xiQB3Di0fXkfvAt0pHYyglZEQpzKZvsDcSWYhnASrnH
	 PWVqfeB2vEQzEmim2xGoQGv2qEEnR5B6RnT3HgQnVQOF3e7T92nyaWhBZ2yhFs++MbHd8
	 IiNbP/6hsforTcV6hx42/zTF804jTiako5DA89hglE/fwgRzmYirb/ljCUXihUcjwylE5
	 8MIsYoK8hX1d9D0SdzpkGY0rPwHRJJntDCq+6vo0uoIMnsYNNoRqkXVK25OxEQsApSoxQ
	 IAak9q7jqNGEQERydPY8ZQQXnLYerb8Gq5PEqUCR9BDWOjbjrfd7gbZXRP1BII9kfFQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b="pIOf1/+Z";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E5C2F800C1
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 09:57:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E5C2F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=pIOf1/+Z
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A98vJtQ5076816,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794214640; bh=tYiEsvuAudo/hUd178dO9DpXF1IHbcbVZFhF8+sq4A4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pIOf1/+ZR/ScOINhMjOUURaYBguHZmVnX3CpnD8i/66APsNT7LGrACOeUSl2mN+i2
	 PXajFBvS28a7N1VbDfyYkirzYmQDN9UvVtvaMvxqgzaIj6SM7u21XXjunU7iFTrTcx
	 ReV19q5OrMU2U3xjcrYjM0zIDNKiBpwMZiWOC5f5GRGSpWUOSNqw8lOB3PPPx+6IJ4
	 JdSLe1bxrIvIe9dO7vSzCqDW9A7vrj9IkWA4xXMBGpugZaNsE60qSk6Lq4GZZqSAsc
	 W0XlXq0CYY+ucZ7+987I3hDlTcWmHZOQ91aCLafv09nk0UtT2PaI5iYbQTfULBI10B
	 tNl2Fjk5cBWgw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A98vJtQ5076816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 16:57:19 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 16:57:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 16:57:19 +0800
Received: from RTKEXHMBS05.realtek.com.tw ([fe80::59f9:8723:adda:65e3]) by
 RTKEXHMBS05.realtek.com.tw ([fe80::59f9:8723:adda:65e3%4]) with mapi id
 15.02.2562.056; Mon, 9 Nov 2026 16:57:19 +0800
From: Jack Yu <jack.yu@realtek.com>
To: Mark Brown <broonie@kernel.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"Flove(HsinFu)" <flove@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
	=?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
	=?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Subject: RE: [PATCH v2] ASoC: rt1320-sdw: Update the driver to support
 rt1321_va2
Thread-Topic: [PATCH v2] ASoC: rt1320-sdw: Update the driver to support
 rt1321_va2
Thread-Index: AQHdbPXfIlZejONzrU6pdP7dH1+OhbciUcKAgAMjgEA=
Date: Mon, 9 Nov 2026 08:57:19 +0000
Message-ID: <aeb55904d396401c98dabac8554d8881@realtek.com>
References: <20261105071831.1039515-1-jack.yu@realtek.com>
 <179407057372.3424803.728673534467493662.b4-review@b4>
In-Reply-To: <179407057372.3424803.728673534467493662.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID-Hash: 4ZTUCH7LWHAXEUNFROD7WJSCBUEWE46L
X-Message-ID-Hash: 4ZTUCH7LWHAXEUNFROD7WJSCBUEWE46L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4ZTUCH7LWHAXEUNFROD7WJSCBUEWE46L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBOb3ZlbWJlciA4LCAyMDI2IDEyOjU2IEFN
DQo+IFRvOiBKYWNrIFl1IDxqYWNrLnl1QHJlYWx0ZWsuY29tPg0KPiBDYzogYnJvb25pZUBrZXJu
ZWwub3JnOyBsZ2lyZHdvb2RAZ21haWwuY29tOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7
DQo+IGxhcnNAbWV0YWZvby5kZTsgRmxvdmUoSHNpbkZ1KSA8ZmxvdmVAcmVhbHRlay5jb20+OyBP
ZGVyIENoaW91DQo+IDxvZGVyX2NoaW91QHJlYWx0ZWsuY29tPjsgU2h1bWluZyBb6IyD5pu46YqY
XSA8c2h1bWluZ2ZAcmVhbHRlay5jb20+Ow0KPiBEZXJlayBb5pa55b63576pXSA8ZGVyZWsuZmFu
Z0ByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gQVNvQzogcnQxMzIwLXNk
dzogVXBkYXRlIHRoZSBkcml2ZXIgdG8gc3VwcG9ydA0KPiBydDEzMjFfdmEyDQo+IA0KPiANCj4g
RXh0ZXJuYWwgbWFpbCA6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90DQo+IHJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+ID4gUlQxMzIxIFZBMiBuZWVkcyBhIGRpZmZlcmVu
dCBmbG93IGZyb20gVkEwL1ZBMToNCj4gDQo+ID4gQEAgLTEyOTEsNiArMTMwNywxMiBAQCBzdGF0
aWMgaW50IHJ0MTMyMF9jaGVja19md19yZWFkeShzdHJ1Y3QNCj4gcnQxMzIwX3Nkd19wcml2ICpy
dDEzMjApDQo+ID4gICAgICAgICAgICAgICByZWdtYXBfcmVhZChydDEzMjAtPnJlZ21hcCwgY21k
X2FkZHIsICZ0bXApOw0KPiA+ICAgICAgICAgICAgICAgaWYgKHRtcCA9PSAwKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgIGVsc2UgaWYgKHRtcCAh
PSAweDEgJiYgdG1wICE9IDB4MiAmJiB0bXAgIT0gMHgzICYmIGlzX3ZhMikNCj4gew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBkZXZfd2FybihkZXYsICIlcyBhYm5vcm1hbCB2YWwsIHRtcDol
eCIsDQo+IF9fZnVuY19fLCB0bXApOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBmb3IgKGkg
PSAwOyBpIDwgODsgaSsrKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ21h
cF93cml0ZShydDEzMjAtPnJlZ21hcCwNCj4gUlQxMzIxX0ZXX1BBUkFNX0FERFIgKyBpLCAweDAw
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IA0KPiBUaGlzIHdpbGwgYnJl
YWsgb3V0IG9mIHRoZSByZXRyeSBsb29wIG9uIGVycm9yIHdoaWNoIGxvb2tzIGxpa2UgYSBzdWNj
ZXNzLg0KDQpJdCdzIG5vdCBhbiBlcnJvciBwYXRoLiAweDNmYzJkMzAxIGlzIHRoZSBoYW5kc2hh
a2UgYmV0d2VlbiB0aGUgZHJpdmVyDQphbmQgdGhlIEZXLCBhbmQgdGhlIEZXIG9ubHkgZXZlciB3
cml0ZXMgMHgwfjB4MyB0byBpdC4gT24gVkEyIGEgc3B1cmlvdXMNCnZhbHVlIGNhbiBzaG93IHVw
IHRoZXJlLCBhbmQgdGhlIEZXIHRlYW0ncyByZWNvbW1lbmRhdGlvbiBpcyB0byBjbGVhcg0KdGhl
IGNvbW1hbmQgYXJlYSwgd2hpY2ggYnJpbmdzIHRoZSBoYW5kc2hha2UgYmFjayB0byBpZGxlIHNv
IHRoZSBmbG93DQpjYW4gY2Fycnkgb24uIEluIHYzIGl0IHJldHVybnMgMCBleHBsaWNpdGx5LCBp
bnN0ZWFkIG9mIGJyZWFraW5nIG91dCBvZiB0aGUgbG9vcC4NCg0KPiANCj4gPiArX3Jlc3RvcmVf
Og0KPiA+ICsgICAgIGlmIChpc192YTIpIHsNCj4gPiArICAgICAgICAgICAgIHJlZ21hcF91cGRh
dGVfYml0cyhydDEzMjAtPnJlZ21hcCwgMHhjMDQ0LCAweGUwLCAweGUwKTsNCj4gPiArICAgICAg
ICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhydDEzMjAtPnJlZ21hcCwgMHhjMDQ3LCAweDgwLCAw
eDgwKTsNCj4gPiArICAgICAgICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhydDEzMjAtPnJlZ21h
cCwgMHhkNTNiLCAweDQwLCAweDQwKTsNCj4gPiArICAgICAgICAgICAgIHJlZ21hcF93cml0ZShy
dDEzMjAtPnJlZ21hcCwgMHhjNTcwLCAweDA4KTsNCj4gPiArICAgICAgICAgICAgIHJlZ21hcF93
cml0ZShydDEzMjAtPnJlZ21hcCwgMHhjNWZiLCByZWdfYzVmYik7DQo+ID4gKyAgICAgICAgICAg
ICByZWdtYXBfd3JpdGUocnQxMzIwLT5yZWdtYXAsIDB4YzVjNCwgMHgxMCk7DQo+IA0KPiBydDEz
MjBfY2FsaWJyYXRlKCkgc2F2ZXMgYW5kIHJlc3RvcmVzIDB4YzU3MC4NCg0KRml4ZWQsIHJ0MTMy
MF9zZXRfYWR2YW5jZW1vZGUoKSBub3cgc2F2ZXMgYW5kIHJlc3RvcmVzIDB4YzU3MCBhcyB3ZWxs
Lg0KDQo+IA0KPiA+IEBAIC0yMDg4LDYgKzIxODEsNyBAQCBzdGF0aWMgaW50IHJ0MTMyMF9yYWVf
bG9hZChzdHJ1Y3QgcnQxMzIwX3Nkd19wcml2DQo+ICpydDEzMjApDQo+ID4gICAgICAgICAgICAg
ICByZWdtYXBfdXBkYXRlX2JpdHMocnQxMzIwLT5yZWdtYXAsIDB4MjAwMDMwMWMsIDB4MDEsDQo+
IDB4MDEpOw0KPiA+ICAgICAgICAgICAgICAgLyogUGhhc2Ugc3luYyBlbmFibGUgKi8NCj4gPiAg
ICAgICAgICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhydDEzMjAtPnJlZ21hcCwgMHhjMDQ3LCAw
eDgwLA0KPiAweDgwKTsNCj4gPiArICAgICAgICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhydDEz
MjAtPnJlZ21hcCwgMHhkNTNiLCAweDQwLCAweDQwKTsNCj4gDQo+IFRoaXMgaXMgYWxzbyB1cGRh
dGluZyB0aGUgaGFuZGxpbmcgZm9yIFZBMCBhbmQgVkExLg0KDQpGaXhlZCwgdGhlIDB4ZDUzYiB1
cGRhdGUgaXMgbGltaXRlZCB0byBWQTIgbm93Lg0KPiANCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBy
dDEzMjBfY29tcGFuaW9uX21vZGVfcGF0Y2goc3RydWN0IHJ0MTMyMF9zZHdfcHJpdg0KPiAqcnQx
MzIwLA0KPiA+ICsgICAgIGJvb2wgcGF0Y2hfdmVyKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0
IGRldmljZSAqZGV2ID0gJnJ0MTMyMC0+c2R3X3NsYXZlLT5kZXY7DQo+ID4gKyAgICAgYm9vbCBj
b21wX21vZGVfZW4gPSBmYWxzZTsNCj4gPiArICAgICB1bnNpZ25lZCBpbnQgdmFsOw0KPiA+ICsN
Cj4gPiArICAgICBpZiAocGF0Y2hfdmVyKSB7DQo+IA0KPiBUaGlzIGNvdWxkIGp1c3QgYmUgYSBy
ZXR1cm4gaWYgIXBhdGNoX3Zlci4NCg0KRG9uZS4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIGlmIChoZHJfc2l6ZSAmJiBwdHJfaW1nLT5hZGRyID09IDB4M2ZjMmEzMDApIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZGJnKGRldiwgIiVzLCBBRlgxDQo+IGhk
clsweDIwXT0weCUwOHggKCUqcGgpXG4iLCBfX2Z1bmNfXywNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdldF91bmFsaWduZWRfbGUzMihmd19kYXRhDQo+ICsNCj4g
PiArIDB4MjApLCA0LCBmd19kYXRhICsgMHgyMCk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJ0MTMyMC0+bF9hZHZfZ2FpbiA9IGZ3X2RhdGFbMHgyMF0gfA0KPiAo
ZndfZGF0YVsweDIxXSA8PCA4KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
dDEzMjAtPnJfYWR2X2dhaW4gPSBmd19kYXRhWzB4MjJdIHwNCj4gPiArIChmd19kYXRhWzB4MjNd
IDw8IDgpOw0KPiANCj4gVGhlcmUgYXJlIHZhcmlvdXMgUlQxMzIwX0FGWF9IRFJfIG1hY3JvcyBh
ZGRlZCBidXQgbm90IHVzZWQuLi4NCg0KVGhleSdyZSB1c2VkIG5vdy4NCg0KPiANCj4gPiBAQCAt
MjU5MCw2ICsyNzMzLDEyIEBAIHN0YXRpYyBpbnQgcnQxMzIwX3BkZTIzX2V2ZW50KHN0cnVjdA0K
PiBzbmRfc29jX2RhcG1fd2lkZ2V0ICp3LA0KPiA+ICAgICAgIHVuc2lnbmVkIGNoYXIgcHMwID0g
MHgwLCBwczMgPSAweDM7DQo+ID4NCj4gPiAgICAgICBzd2l0Y2ggKGV2ZW50KSB7DQo+ID4gKyAg
ICAgY2FzZSBTTkRfU09DX0RBUE1fUFJFX1BNVToNCj4gPiArICAgICAgICAgICAgIGlmIChydDEz
MjAtPmRldl9pZCA9PSBSVDEzMjFfREVWX0lEICYmDQo+IHJ0MTMyMC0+dmVyc2lvbl9pZCA9PSBS
VDEzMjFfVkEyKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJlZ21hcF93cml0ZShydDEz
MjAtPnJlZ21hcCwgMHhjMDRjLCAweGUyKTsNCj4gDQo+IHJ0MTMyMF9jb21wYW5pb25fbW9kZV9w
YXRjaCgpIHdyaXRlcyAweDU0IHdoZW4gY29tcGFuaW9uIG1vZGUgaXMNCj4gZW5hYmxlZC4NCj4g
DQpUaGUgY29tcGFuaW9uIG1vZGUgc3RhdGUgaXMga2VwdCBub3csIGFuZCB0aGUgUERFMjMgUFJF
X1BNVQ0KaGFuZGxlciB3cml0ZXMgdGhlIHZhbHVlIG1hdGNoaW5nIHRoZSBtb2RlLg0KDQoNCj4g
PiBAQCAtMjk2Miw3ICszMTExLDcgQEAgc3RhdGljIGludCBydDEzMjBfcjBfbG9hZF9tb2RlX3B1
dChzdHJ1Y3QNCj4gc25kX2tjb250cm9sICprY29udHJvbCwNCj4gPiAgICAgICAgICAgICAgIHVj
b250cm9sLT52YWx1ZS5pbnRlZ2VyLnZhbHVlWzFdID09IDApDQo+ID4gICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+IC0gICAgIHJldCA9IHBtX3J1bnRpbWVfcmVzdW1lKGNv
bXBvbmVudC0+ZGV2KTsNCj4gPiArICAgICByZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0
KGNvbXBvbmVudC0+ZGV2KTsNCj4gPiAgICAgICBpZiAocmV0IDwgMCAmJiByZXQgIT0gLUVBQ0NF
UykNCj4gPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiBXaXRoIHBtX3J1bnRpbWVf
cmVzdW1lX2FuZF9nZXQoKSB3ZSBjYW4ndCBhY2NlcHQgLUVBQ0NFUyBzaW5jZSB0aGUNCj4gcnVu
dGltZSBQTSByZWZlcmVuY2UgaXMgZHJvcHBlZC4gIFNhbWUgaW4gYSBjb3VwbGUgb2Ygb3RoZXIg
Y2FzZXMuDQo+IA0KRml4ZWQuDQoNCj4gLS0NCj4gTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwu
b3JnPg0K
