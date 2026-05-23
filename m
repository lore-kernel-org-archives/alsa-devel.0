Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076E4CD5BB1
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:15:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD6A06024C;
	Tue, 26 May 2026 17:14:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD6A06024C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808500;
	bh=g+UK54mMBO4mlRs3S0xxyAG4ML4cHi4P07alIUzComY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WptbmCOuqL4y7G0J0jkMFWdEQeqhENH11/OzHAIQfMe6/DSvDc1ZNBNX54zb6Cerb
	 lMcTE/EIuX6W2PSQEZssDbE4Y9tmzZVhI8y2fwuNUGHkG3iRGdAfU+O+Z828z37Ox7
	 Zt9dctNEbdocbsdYe7tsFFaRIJw009tlFVHnat+s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A08DF80639; Tue, 26 May 2026 17:14:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D937F80631;
	Tue, 26 May 2026 17:14:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9617F80557; Mon, 25 May 2026 14:25:16 +0200 (CEST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DA1C5F800C1
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 14:25:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA1C5F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NmdIKdPp
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a40cfab24dso5437273e87.2
        for <alsa-devel@alsa-project.org>;
 Mon, 25 May 2026 05:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779711913; cv=none;
        d=google.com; s=arc-20240605;
        b=Zzs/a1lLB7ALeFJ1LVn42mXfNO76EsFa7l4YF5oAnH7aeX+od3U1brt8EbNmASkkfZ
         ool+EGtkkgBAT/R6Wy0kqazW0tY2mUE961VydTDd8VJ10dMO/u2sCQO309lvvT4MNSXn
         Vca/28ify5tM5TOjAPGKnDYKvOCHeCNbDpE/9f4MdSxiecGY5MDVEjEM15JBkOAa/Jxh
         0vvoPvi6khq/45GtBkYumAIBeu1tmcuNfyes/A0iY7j4HJLIo3NiwGecA6eitMA53q9I
         H45adCub+Kj7HiP+UXl9PVAS9qDSnOWjvvqqWLn1ecsjaqPINO0ZKtcIA4PzIEufD5y3
         dkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TtA0o2Pj9atAieUJqcNiy1x2d2VI1ZEIoWHWq6E7mks=;
        fh=Btle51mnLSfaGDR07ah2M8TmA6Z4lBGNy6VW7hmPEQM=;
        b=dZzu1eiZhQiV2sOaghduhCqIAUO5U70ntG8rWYwTExxccrGJwXg1KP9q9DBoEvPL/V
         Pb0tpzLZJmQ3EV7FMJQRhoHsJLEP6QXoXL0dWTnKyz8YrhuAyTRAtzC+f1S/DmZJtq+p
         SF63xzcs6LGBcIoMCTvfiTrkS+/Jit3Yz6rwtJS6xf5QU5IXqS6P/gKxerVfWf+Zffd/
         30F4okVnOpTjFat5PHs097UZg1H1Ix6sZzizmbnC3yKJ0AQUnQ/wLO6V04rUs2uwYkCE
         ejwZtkZ9/fCZ33OQbSZGRjxSWW5igRaIVsGlhYKLakgkQH6M5ZVCuyer3m6Jx++V8drd
         PQRQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779711913; x=1780316713;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TtA0o2Pj9atAieUJqcNiy1x2d2VI1ZEIoWHWq6E7mks=;
        b=NmdIKdPpS+Z/OBOV5zIHAbEfh12SsAJqHAcIuDWIYz4lB9y9KSagzIaTtOa4dGNe2b
         AWh+fdk5kCcEzJGkGOMqxYII+/hy7TjvhahGus4axpKD8gXOtqnJ8jMqZTfjna/+9PBH
         8rLL8d/3tl1gUSTUlCvf2fILlkXWwmbkPkXZEiUVrB7Q5rfib85FCz6knCXj4RTe2Ud5
         5DnLgaH7t6eQyAIJerRklDoFQNvXnLFALWM0VVlYOITU9TxDvCqee1u2mTIj9quyxC6l
         b5CgxECHVJGLpm0P+XGM2mW0LfpVhmtPu3xDDmOd26CwiAZ6Nccog9eDmWo9ryuuDxPX
         tqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711913; x=1780316713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtA0o2Pj9atAieUJqcNiy1x2d2VI1ZEIoWHWq6E7mks=;
        b=pmBPVbT8zxIDcXqkPHue6759rdfS5n5Rsc0GPRUyDGaRbLutbgNIB4Cb+++NkoWk/V
         14iocjePMxdS0ZDmRFm2NZ2uabjkY6PfOFRKGch+SuO9+WScFzLy6e9lVXdGWXBjl9aY
         vLeXSpDk+QLSsu0JUzuzat2IY+luDCcfw2zjIYxLHfzpV/9zoQV3ayZ0tv1hdTNlZKVp
         36hJS42mQYYBYUW3xRhX2odAIBaVanJVzO7fQuy+VeoozwaOAqD71+D+peVp6WdBlLOR
         HvrmE2MwXxlV9aqaqAvPaTL6uUBTrdNGrdr5odJ/Qhp9Y8MbDyuKxZAVqBtIvR8pkhVk
         doYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8h0MiKZOh5me+0IbcJG/Ei9zETK+MusH4jkTPoRUvTVCmnwNcv06uEOuhRRq4t3igJz9vPqb8vBTr8@alsa-project.org
X-Gm-Message-State: AOJu0Yx01li2fmKAfjRoNrZ4MGzR/yRP7N01SuGEWZdv3W9rKSGOAoPA
	o/iwNCd34XlVyZkI+QHqpFZM+S9DdKJndG3YP9iiC5XGIQHwkBgj/U+K2038nSHOIUQPoe1EINE
	Z4qCf7CFiQ76HVVj6ydoIHEArNdr82KOxuCq0XKY=
X-Gm-Gg: Acq92OGEkChMw+x5G8SkSa1Esx1gZ5Myol5pY4ewsKw2OVCx5uPCtJ1qME0GtmI4S67
	KlR4RrqPdT8f+aMGWt/PE0sf29pTG0tAYVYujvQ1m6gME8iTa+hd8bqpMVyzcbWfWgXoARXcmp6
	bmt3fWuATHMWPCgE5ufZQQof+PU2TVPLvIPtkJPxLQGI4TNUhGz+Cdd1b+imMeV45FbaV9VcoMq
	THIisG7VJsLOOB02sT691cr+X/ulMAeYbteBV0Tg4tItsqyjZ0t1pKxGVr+Yoh7PWV/ik3bJEx8
	Y2paeHGNWbBzptkEP1jmUu9M48Usr3dyzp+UveT9uKi5VanzgC/wwwxYE1P5pg1wGIHSB9bx09P
	BRH/C7A==
X-Received: by 2002:a17:907:3e1b:b0:bcc:17b2:6e8 with SMTP id
 a640c23a62f3a-bdd25135f3dmr616284366b.2.1779570036333; Sat, 23 May 2026
 14:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260523163652.18499-1-jmiguel.ghp@gmail.com>
 <ahIU9X2DizdyQVR8@geday>
In-Reply-To: <ahIU9X2DizdyQVR8@geday>
From: =?UTF-8?B?Sm/Do28gTWlndWVs?= <jmiguel.ghp@gmail.com>
Date: Sat, 23 May 2026 22:00:24 +0100
X-Gm-Features: AVHnY4KOU1B19gab_-xTnY_W-3D8-WxqnXAWBFeO7p4BwAZsf3KW7EFhM1aBSsc
Message-ID: 
 <CAPQWOKrmKn+nwu+AwmS5UDf0yoBPizN=sx2ho1qYyzVF5bvudg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Enable internal mic on MSI Bravo 17 C7VF
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Vijendar.Mukunda@amd.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
 =?UTF-8?B?Sm/Do28gTWlndWVs?= <joaomiguel.sapientia@gmail.com>
X-MailFrom: jmiguel.ghp@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZXOLFERNIE26LXRGSNI6U2HFKC3MEW3V
X-Message-ID-Hash: ZXOLFERNIE26LXRGSNI6U2HFKC3MEW3V
X-Mailman-Approved-At: Tue, 26 May 2026 15:14:01 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZXOLFERNIE26LXRGSNI6U2HFKC3MEW3V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgR2VyYWxkbywNCg0KTWlndWVsIGlzIGluZGVlZCBteSBzdXJuYW1lLg0KDQpJIHdpbGwgZm9s
bG93IHVwIHdpdGggdGhlIHJlcXVpcmVkIHRhZywgdGhhbmtzIQ0KDQpUaGFuayB5b3UsDQpKb8Oj
byBNaWd1ZWwNCg0KT24gU2F0IDIzIE1heSAyMDI2IGF0IDIxOjU4LCBHZXJhbGRvIE5hc2NpbWVu
dG8gPGdlcmFsZG9nYWJyaWVsQGdtYWlsLmNvbT4NCndyb3RlOg0KDQo+IEhpIEpvw6NvIE1pZ3Vl
bCwNCj4NCj4gT24gU2F0LCBNYXkgMjMsIDIwMjYgYXQgMDU6MzY6NTJQTSArMDEwMCwgSm/Do28g
TWlndWVsIHdyb3RlOg0KPiA+IEZyb206IEpvw6NvIE1pZ3VlbCA8am9hb21pZ3VlbC5zYXBpZW50
aWFAZ21haWwuY29tPg0KPiA+DQo+ID4gdGhlIGJvYXJkJ3MgaW50ZXJuYWwgRE1JQyBpcyBvbiB0
aGUgQUNQNnggYW5kIGlzbid0IGRldGVjdGVkIHdpdGhvdXQgYQ0KPiBETUkgcXVpcmsgZW50cnk7
IHRoaXMgYWRkcyBpdC4NCj4gPiAtLS0NCj4gPiAgc291bmQvc29jL2FtZC95Yy9hY3A2eC1tYWNo
LmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+DQo+IFdoaWxlIHRoZSBwYXRjaCBpdHNlbGYgbG9va3MgT0ssIHlvdSdyZSBtaXNzaW5nIHRo
ZSByZXF1aXJlZA0KPiBTaWduZWQtb2ZmLWJ5IHRhZywgd2hpY2ggc2hvdWxkIGNvbnRhaW4geW91
ciBsZWdhbCBuYW1lIHdpdGggc3VybmFtZQ0KPiAoSSdtIGFzc3VtaW5nIE1pZ3VlbCBpcyBub3Qg
eW91ciBzdXJuYW1lLCBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZykuDQo+DQo+IEFsc28sIHBsZWFz
ZSB3cmFwIHRoZSBjb21taXQgbWVzc2FnZSBhdCA3MiBjaGFyYWN0ZXJzLiBUaGUgd2F5IGl0IGlz
DQo+IG5vdyBtYWtlcyBhIHZlcnkgbG9uZyBsaW5lIGhhcmQgdG8gcmVhZCBpbiBzdGFuZGFyZCB0
ZXJtaW5hbHMuDQo+DQo+IFRoYW5rIHlvdSwNCj4gR2VyYWxkbyBOYXNjaW1lbnRvDQo+DQo+ID4g
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9hbWQveWMvYWNwNngtbWFjaC5jDQo+IGIvc291bmQvc29j
L2FtZC95Yy9hY3A2eC1tYWNoLmMNCj4gPiBpbmRleCA3YTYzN2Q2YjUuLmE5M2E3ZmQ0OCAxMDA2
NDQNCj4gPiAtLS0gYS9zb3VuZC9zb2MvYW1kL3ljL2FjcDZ4LW1hY2guYw0KPiA+ICsrKyBiL3Nv
dW5kL3NvYy9hbWQveWMvYWNwNngtbWFjaC5jDQo+ID4gQEAgLTc5NCw2ICs3OTQsMTMgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkDQo+IHljX2FjcF9xdWlya190YWJsZVtdID0g
ew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFNRSwg
Ik03NjAxUk0iKSwNCj4gPiAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICB9LA0KPiA+ICsgICAg
IHsNCj4gPiArICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9ICZhY3A2eF9jYXJkLA0KPiA+ICsg
ICAgICAgICAgICAgLm1hdGNoZXMgPSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIERNSV9N
QVRDSChETUlfQk9BUkRfVkVORE9SLCAiTWljcm8tU3Rhcg0KPiBJbnRlcm5hdGlvbmFsIENvLiwg
THRkLiIpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0goRE1JX0JPQVJEX05B
TUUsICJNUy0xN0xOIiksDQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4gKyAgICAgfSwNCj4gPiAg
ICAgICB7fQ0KPiA+ICB9Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjU0LjANCj4gPg0KPiA+DQo+DQo=
