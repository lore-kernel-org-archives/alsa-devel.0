Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7879C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 05:18:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E816600D4
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 05:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E816600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C84401677;
	Thu,  9 Sep 2021 07:17:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C84401677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631164699;
	bh=k8w7hlrz+JFJuTOwnHpYbP6F7wZniEU2NBER734ufZ4=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jpRwezYgUgZbUOsmtTffj3XupINgcZYXOCfHl3/WoXEiR+su1Ugz2s54k606jjj5x
	 TZjfFKyNzJLDV19VQUmg7WzoNYtjEzXfMg7nRv89YmROIIhJjCeUD2QDxjerAF6Fmm
	 KxwW05VtrfCc4nfKSeFFXBE8TgHjEpRS7suaoyrM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 435EAF800FC;
	Thu,  9 Sep 2021 07:17:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B38D1F80224; Thu,  9 Sep 2021 07:17:26 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76AFFF800FC
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 07:17:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76AFFF800FC
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1895HBehC004772,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (mapi.realtek.com[172.21.6.25])
 by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1895HBehC004772
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 9 Sep 2021 13:17:11 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 9 Sep 2021 13:17:11 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 9 Sep 2021 13:17:10 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::ddc7:f5b1:d3ae:8354]) by
 RTEXMBS01.realtek.com.tw ([fe80::ddc7:f5b1:d3ae:8354%5]) with mapi id
 15.01.2106.013; Thu, 9 Sep 2021 13:17:10 +0800
From: Jack Yu <jack.yu@realtek.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>
Subject: RE: [PATCH] ASoC: rt1011: add i2s reference control for rt1011
Thread-Topic: [PATCH] ASoC: rt1011: add i2s reference control for rt1011
Thread-Index: AQHXowertNFJ8/ODj0GUsGW05g6DBauYJBOAgAFDX0CAAFcdAIABQysg//+G2wCAAKUYEA==
Date: Thu, 9 Sep 2021 05:17:10 +0000
Message-ID: <6467ba5315304b188cb1e73c88e74c0a@realtek.com>
References: <20210906101208.11585-1-jack.yu@realtek.com>
 <3062f5e5-d2d7-8150-ef89-989af3b4b1d6@linux.intel.com>
 <05e92a24b1c34daeb64e5b222a3ae337@realtek.com>
 <9f76a420-44c6-ad6d-4442-275ba4459b40@linux.intel.com>
 <a9d9074e52c941e8bddc34f4d364a1ae@realtek.com>
 <31627a4f-cfa3-39ab-7e6e-2578c99fc742@linux.intel.com>
In-Reply-To: <31627a4f-cfa3-39ab-7e6e-2578c99fc742@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.167]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzkvOSDkuIrljYggMDM6MDY6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?utf-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>,
 =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBpZXJyZS1Mb3VpcyBCb3Nz
YXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBTZXB0ZW1iZXIgOSwgMjAyMSAxMToyNiBBTQ0KPiBUbzogSmFjayBZdSA8amFjay55dUBy
ZWFsdGVrLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gbGdpcmR3b29kQGdtYWlsLmNvbQ0K
PiBDYzogT2RlciBDaGlvdSA8b2Rlcl9jaGlvdUByZWFsdGVrLmNvbT47IGFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZzsNCj4gbGFyc0BtZXRhZm9vLmRlOyBrZW50X2NoZW5AcmVhbHRlay5jb20g
W+mZs+W7uuWuj10NCj4gPGtlbnRfY2hlbkByZWFsdGVrLmNvbT47IERlcmVrIFvmlrnlvrfnvqld
IDxkZXJlay5mYW5nQHJlYWx0ZWsuY29tPjsNCj4gU2h1bWluZyBb6IyD5pu46YqYXSA8c2h1bWlu
Z2ZAcmVhbHRlay5jb20+OyBGbG92ZShIc2luRnUpDQo+IDxmbG92ZUByZWFsdGVrLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gQVNvQzogcnQxMDExOiBhZGQgaTJzIHJlZmVyZW5jZSBjb250
cm9sIGZvciBydDEwMTENCj4gDQo+ID4+Pj4+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHJ0
MTAxMV9pMnNfcmVmW10gPSB7DQo+ID4+Pj4+ICsJIk5vbmUiLCAiTGVmdCBDaGFubmVsIiwgIlJp
Z2h0IENoYW5uZWwiDQo+ID4+Pj4+ICt9Ow0KPiA+Pj4+DQo+ID4+Pj4+ICtlbnVtIHsNCj4gPj4+
Pj4gKwlSVDEwMTFfSTJTX1JFRl9OT05FLA0KPiA+Pj4+PiArCVJUMTAxMV9JMlNfUkVGX0xFRlRf
Q0gsDQo+ID4+Pj4+ICsJUlQxMDExX0kyU19SRUZfUklHSFRfQ0gsDQo+ID4+Pj4+ICt9Ow0KPiA+
Pj4+DQo+ID4+Pj4gaXMgaXQgcG9zc2libGUgdG8gZ2V0IExlZnQtUmlnaHQtbWl4IChtaXhlZCBv
biBydDEwMTEpIGFuZA0KPiA+Pj4+IExlZnQtUmlnaHQgKHR3byBjaGFubmVscywgd2l0aCB0aGUg
YXBwbGljYXRpb24gc2VsZWN0aW5nIHdoYXQgdGhleSB3YW50KT8NCj4gPj4+DQo+ID4+PiBJdCdz
IGEgbW9ubyBhbXAsIHNvIHRoZXJlJ3Mgbm8gTGVmdC1SaWdodC1taXggc2V0dGluZy4NCj4gPj4+
IEFuZCBmb3IgdGhlIGNob2ljZSBvZiBMZWZ0LVJpZ2h0IGNoYW5uZWwsIGl0J3MgYWxyZWFkeSBh
dmFpbGFibGUNCj4gPj4+IHdpdGggdGhpcw0KPiA+PiBwYXRjaC4NCj4gPj4NCj4gPj4gU28gaXQn
cyBqdXN0IHRvIHBsYWNlIGEgbW9ubyByZWZlcmVuY2UgaW4gZWl0aGVyIGxlZnQgb3IgcmlnaHQN
Cj4gPj4gY2hhbm5lbCBvZiB0aGUgSTJTIGxpbms/IFdoeSBub3QgZHVhbC1tb25vIGFzIHdlbGwg
dGhlbj8NCj4gPg0KPiA+IFRoZSBwYXRjaCBpcyBhIHNwZWNpZmljIGNvbnRyb2wgZm9yIHR3byBh
bXBzIHRvIHNlbmQgQUVDIGRhdGEgb24gc2luZ2xlIEkyUw0KPiBkYXRhIGlucHV0IHBpbiBieSBz
dGFuZGFyZCBJMlMgcHJvdG9jb2wuDQo+IA0KPiBUaGF0J3MgcmVhbGx5IHVzZWZ1bCBpbmZvcm1h
dGlvbiBhbmQgd29ydGh5IG9mIGEgY29tbWVudC4NCj4gDQo+IFdoYXQgeW91IGFyZSBkb2luZyBo
ZXJlIGlzIHNpbWlsYXIgdG8gc2VsZWN0aW5nIHRoZSBzbG90IGZvciBlYWNoIGFtcCB3aXRoDQo+
IHNldF90ZG1fc2xvdCgpLCBidXQgbGVhdmluZyB0aGUgY2hvaWNlIHRvIHVzZXJzcGFjZSwgaXNu
J3QgaXQ/DQo+IA0KWWVzLg0KDQo+ID4gSWYgdGhlcmUgYXJlIHR3byBJMlMgaW5wdXQgZnJvbSBT
b0MsIHdlIGNhbiBhZGQgZHVhbC1tb25vIG1vZGUgZm9yIGl0LCBidXQNCj4gc28gZmFyIHRoZXJl
IGlzIG5vIHJlcXVpcmVtZW50IHJlZ2FyZGluZyB0byB0aGlzIG1vZGUuDQo+IA0KPiBvay4NCj4g
DQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5n
IHRoaXMgZS1tYWlsLg0K
