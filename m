Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC8ACA5FC7
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:17:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A57960264;
	Wed, 30 Sep 2026 12:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A57960264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790763456;
	bh=ayoZQ9vKopUSPZHXEcJFT7+h2LDq3OO6vZ1N2Ejago4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AFivAb6DpRPM6mi4cY2OefHoBusHtKy+TUUSTWwDfjeS768u9VKk3ge+36V7FZ4yy
	 n1axwwBDGWQ1CjLxtYWHXuZ1lpDexBE/KSaROKudom+qpyFhxbTkkYnTEWtpu2i70f
	 7AW+wyT2s1VgKVuZ1IRgCcTGft4JVXbvncqK6o7U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2C09F805F6; Wed, 30 Sep 2026 12:17:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44E9EF80602;
	Wed, 30 Sep 2026 12:17:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A63ACF80542; Wed, 30 Sep 2026 12:16:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790763410;
	b=VRVE66BdBlqccolAs6fSCrpUxHsEp0MJ5Yus8mmwuTbld91OI18sHV7HyOr2fJPCqNNT
	 hpwUXGlyvSyurSUviJ4SDiwZvKyjm8yCetOynoCa1BDrMaDEpNyfmY1oe/QD6cwRE5Ctz
	 H8pF+YWLdXLoO3W/bK9XGYgspdxqK2xVZhOlLwShmobDsn4WjZ7jTDKWHQmFerdP2LOsT
	 m+9XL8dYBXyUP4zPEnslKPitiwhF0M0XlqydF2mkofQFMP/vCrGU5K3+devhJXsHBQfPI
	 XkHtgqRKT9fW2DwJ5CrcZs31X59U7vThEXh2AxK0P+QlXI6L5RISXp7AVGvYw8zCpIQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790763410;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ayoZQ9vKopUSPZHXEcJFT7+h2LDq3OO6vZ1N2Ejago4=;
	b=KZt/V6X1iV5nC9X/N5U28y8ZSBM3lIq3hhcd3BcPrvb6g0QUKDX8yhivMSh2/hCIqXX7
	 NSmX8SybQHaKJDAqy3PvB4bENQS2UoSGhBG5k/UCcZAMla7/GKk7wPoZL+MS8WONG8wrm
	 BfQ8UihnfW8Ma81d4VEFa3qJITS2tGJLfFrnb8Fapo9qOAMo/Xnik849rj6opYKZw2NSH
	 GA4eW8a/7S/sgOR8jgb3eGXEjhBE13vz9eoHs9/fa8i59FrIFV/YRIS+lv5O65bkEPbX4
	 AzMVgYpiOuBY0gZKlmtoq176L1mIn8yQ6LR6bD7QW8GX1+q0sOCQyiESeulteuDnmYA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=hhhIu4ZI;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E8277F80496
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2026 12:16:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8277F80496
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=hhhIu4ZI
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68UAGdTjA2022919,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790763399; bh=ayoZQ9vKopUSPZHXEcJFT7+h2LDq3OO6vZ1N2Ejago4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hhhIu4ZIipTkMMenQuxhDi064VcAXbPu1W/mdzDB8ZXfKVv69+Pp1+rwpIQv9r5jg
	 xs31ZF6noFfhZ9mgFk5LRSzCRXOn3VN8jLDSwyJkb/iKbrN763kBL6r2lU1PVaby5u
	 EW2oDDA4R2dLLABgXtUNXtqJtu4Dulm80K6vWtI/HFGoBng+KehU2KKYT9V0S/QYRz
	 bzuFKVJ9y6PSAzVKlscKpse2OlK9rTgcojgyNmHhOLbPlOAnE26DqLo1DGx6vcexOI
	 evuOQYyFd47e+LZT7o3ZzseO5Jk/XUvFUyDNbUdO5PAOEmjGggPITeVOOLNwTAfBJw
	 dgUcJ4VGTWYXg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68UAGdTjA2022919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Sep 2026 18:16:39 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 18:16:39 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::bb07:3e09:fb44:8906%6]) with mapi id
 15.02.2562.049; Wed, 30 Sep 2026 18:16:39 +0800
From: Jack Yu <jack.yu@realtek.com>
To: Mark Brown <broonie@kernel.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"Flove(HsinFu)" <flove@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
	=?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>,
	=?big5?B?RGVyZWsgW6TovHe4cV0=?= <derek.fang@realtek.com>
Subject: RE: [PATCH] ASoC: rt721-sdca: Adjust blindwrite flow to fix type
 detection issue
Thread-Topic: [PATCH] ASoC: rt721-sdca: Adjust blindwrite flow to fix type
 detection issue
Thread-Index: AQHdUAQbR9fx6g1+uEO4FHmu2Or+87blTuAAgAEUh1A=
Date: Wed, 30 Sep 2026 10:16:39 +0000
Message-ID: <38bf7b59ef7f437581d8c18473724642@realtek.com>
References: <20260929111709.398548-1-jack.yu@realtek.com>
 <caf34e12-fcea-4814-abac-26674988bc0e@sirena.org.uk>
In-Reply-To: <caf34e12-fcea-4814-abac-26674988bc0e@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-ID-Hash: 6VUTG7RV5XFTCMZL5YS2PDT6WEQRMEBL
X-Message-ID-Hash: 6VUTG7RV5XFTCMZL5YS2PDT6WEQRMEBL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6VUTG7RV5XFTCMZL5YS2PDT6WEQRMEBL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMzAsIDIwMjYgMTo0
NyBBTQ0KPiBUbzogSmFjayBZdSA8amFjay55dUByZWFsdGVrLmNvbT4NCj4gQ2M6IGxnaXJkd29v
ZEBnbWFpbC5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGFyc0BtZXRhZm9vLmRl
Ow0KPiBGbG92ZShIc2luRnUpIDxmbG92ZUByZWFsdGVrLmNvbT47IE9kZXIgQ2hpb3UgPG9kZXJf
Y2hpb3VAcmVhbHRlay5jb20+Ow0KPiBTaHVtaW5nIFutU67Ru8pdIDxzaHVtaW5nZkByZWFsdGVr
LmNvbT47IERlcmVrIFuk6Lx3uHFdDQo+IDxkZXJlay5mYW5nQHJlYWx0ZWsuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBBU29DOiBydDcyMS1zZGNhOiBBZGp1c3QgYmxpbmR3cml0ZSBmbG93
IHRvIGZpeCB0eXBlDQo+IGRldGVjdGlvbiBpc3N1ZQ0KPiANCj4gT24gVHVlLCBTZXAgMjksIDIw
MjYgYXQgMDc6MTc6MDlQTSArMDgwMCwgamFjay55dUByZWFsdGVrLmNvbSB3cm90ZToNCj4gPiBG
cm9tOiBKYWNrIFl1IDxqYWNrLnl1QHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gT3JpZ2luYWwgYmxp
bmR3cml0ZSBmbG93IGZhaWwgdG8gc3VwcG9ydCBub2tpYSB0eXBlIGRldGVjdGlvbiwgYnV0DQo+
ID4gaXQncyB3b3JrcyBub3JtYWxseSBpbiBpcGhvbmUgdHlwZSBkZXRlY3Rpb24uDQo+ID4gV2Ug
YWRqdXN0IHRoZSByZWdpc3RlciBzZXR0aW5ncyB0byBzdXBwb3J0IGJvdGggdHlwZSBkZXRlY3Rp
b24uDQo+IA0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ19kZWZhdWx0IHJ0NzIxX3NkY2Ff
bWJxX2RlZmF1bHRzW10gPSB7DQo+ID4gKwl7IDB4MDkwMDAwNiwgMHhlMDAwIH0sDQo+ID4gIAl7
IDB4MDkwMDAwNywgMHhjMDA0IH0sDQo+ID4gKwl7IDB4MDkxMDAwMCwgMHgwMGExIH0sDQo+ID4g
Kwl7IDB4MDkxMDAwMSwgMHgxMjU2IH0sDQo+ID4gKwl7IDB4MDkxMDAwMiwgMHgwMDAwIH0sDQo+
ID4gKwl7IDB4MDkxMDAwMywgMHgwMDAwIH0sDQo+ID4gKwl7IDB4MGMwMDAwNSwgMHhmMTQwIH0s
DQo+IA0KPiBJcyB0aGF0IHJlZ2lzdGVyIHZvbGF0aWxlPw0KT25seSAweDBjMDAwMDUgaXMgdGhl
IHZvbGF0aWxlIHJlZ2lzdGVyLCBJJ2xsIG1vZGlmeSB0aGlzIGluIHYyIHBhdGNoLg0KDQo+IA0K
PiA+ICBzdGF0aWMgdm9pZCBydDcyMV9zZGNhX2phY2tfZGV0ZWN0X2hhbmRsZXIoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQ0KPiA+IHsNCj4gDQo+ID4gKwkJaWYgKChydDcyMS0+c2NwX3NkY2Ff
c3RhdDEgJiBTRFdfU0NQX1NEQ0FfSU5UX1NEQ0FfMCkgJiYNCj4gPiArCQkJIShydDcyMS0+c2Nw
X3NkY2Ffc3RhdDIgJiBTRFdfU0NQX1NEQ0FfSU5UX1NEQ0FfOCkgJiYNCj4gPiArCQkJcmVhbF9K
RCA9PSAweDEgJiYgcnQ3MjEtPmludF9jbnQgPT0gMCAmJg0KPiA+ICsJCQkhcnQ3MjEtPmltcF9z
ZW5zaW5nX2RvbmUgJiYgcnQ3MjEtPmphY2tfdHlwZSAhPSAwKSB7DQo+ID4gKwkJCWRldl9pbmZv
KCZydDcyMS0+c2xhdmUtPmRldiwNCj4gPiArCQkJCSIlczogcmVzdW1lIHdpdGggamFjayBwcmVz
ZW50LCByZXVzZSBqYWNrX3R5cGU9JWRcbiIsDQo+ID4gKwkJCQlfX2Z1bmNfXywgcnQ3MjEtPmph
Y2tfdHlwZSk7DQo+IA0KPiBEb2VzIHRoaXMgZG8gdGhlIHJpZ2h0IHRoaW5nIGlmIHRoZSB0aGlu
ZyBwbHVnZ2VkIGludG8gdGhlIGphY2sgY2hhbmdlcyBvdmVyDQo+IHN1c3BlbmQgKGVnLCBjbG9z
ZSB0aGVpciBsYXB0b3AsIHVucGx1ZyB0aGVpciBoZWFkc2V0LCBnbyBob21lLCBwbHVnIGluIHRo
ZWlyDQo+IGhlYWRwaG9uZXMsIG9wZW4gdGhlaXIgbGFwdG9wKT8NCj4gDQpUaGFua3MgZm9yIHBv
aW50aW5nIG91dCwgSSdsbCBhZGRyZXNzIHRoaXMgaXNzdWUgaW4gdjIgcGF0Y2guDQo+ID4gKwkJ
aWYgKChydDcyMS0+c2NwX3NkY2Ffc3RhdDEgJiBTRFdfU0NQX1NEQ0FfSU5UX1NEQ0FfMCkgJiYN
Cj4gPiArCQkJIShydDcyMS0+c2NwX3NkY2Ffc3RhdDIgJiBTRFdfU0NQX1NEQ0FfSU5UX1NEQ0Ff
OCkgJiYNCj4gPiArCQkJcnQ3MjEtPmludF9jbnQgPT0gMCAmJiByZWFsX0pEID09IDB4MSAmJg0K
PiA+ICsJCQkhcnQ3MjEtPmltcF9zZW5zaW5nX2RvbmUpIHsNCj4gPiArCQkJZGV2X2luZm8oJnJ0
NzIxLT5zbGF2ZS0+ZGV2LA0KPiA+ICsJCQkJIiVzOiBCUkFOQ0ggaW1wZWRhbmNlX3NlbnNpbmcg
KFNEQ0FfMCBzZXQsIGZyZXNoDQo+IHBhc3MpXG4iLA0KPiA+ICsJCQkJX19mdW5jX18pOw0KPiA+
ICsJCQlydDcyMS0+aW1wX3NlbnNpbmdfZG9uZSA9IHRydWU7DQo+ID4gKwkJCXJ0NzIxX2ltcGVk
YW5jZV9zZW5zaW5nKHJ0NzIxKTsNCj4gPiArCQkJcnQ3MjEtPmltcF9zZW5zaW5nX29uZ29pbmcg
PSBmYWxzZTsNCj4gPiArCQkJcmV0dXJuOw0KPiANCj4gRG9lcyBydDcyMV9zZGNhX2J0bl9jaGVj
a19oYW5kbGVyKCkgYWxzbyBuZWVkIHVwZGF0ZXMgdG8gcmVzZXQgYWxsIHRoZSBzdGF0ZQ0KPiBv
biByZW1vdmFsPw0KV2lsbCBmaXggaW4gdjIgcGF0Y2guDQo=
