Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062FBC7618E
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 10:55:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FEAADF6;
	Fri, 21 Apr 2023 12:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FEAADF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682074556;
	bh=uVVaeU00Ufg+UDsC3+WgFZml4IwS33taTeEHx1rmWxU=;
	h=References:In-Reply-To:From:Date:Subject:To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aUgs8p8+znKqy7kvK45J45HtlpoBgVVQjG6pgSAXrLdT/7NA7W0Lj9SJIFbM4r+hV
	 OwlZJ8BrYRNRs7fw61EP2vBlMPkmB5YqwbRN7sdL2SVD0/ga+Ot96ATyrQbQxO4Cj2
	 eUqJfpd5xhkBc7lSQbr2TAWaN/8rySjE/9QFDg3A=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DB9AF80053;
	Fri, 21 Apr 2023 12:54:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60B0CF8019B; Fri, 21 Apr 2023 12:54:38 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29AFFF80053
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 12:54:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29AFFF80053
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=pOgg2X13
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f18123d9f6so11063685e9.0
        for <alsa-devel@alsa-project.org>;
 Fri, 21 Apr 2023 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682074471; x=1684666471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f9JeLnNrL32s9KT2ojTlOZwCmMHQTQ795O7VEST2wvc=;
        b=pOgg2X13S1HFWEIyOz1dQgN9+6uwDgAp/9DHhDneneLl1OXv0ZWGgaeqMVfOGY2VO0
         f30q8Vq/L3M3YxNHAnHqVeiCwAM3vYSbFgzCuZ66fpPMa7P1ENBe1Eytj9hwNA2qFtv8
         pnkastZ6CBAUaYRee9aBTQzg0GWl9WzNGKJDTOZ4L9p/ta0jJjb8R85ECULWNqunKqV+
         5VK3GulXBkHNEtc51lBTcK7vR7Jo6mvBii17lNIyivQyxcjNjViLy5BrHMMYhwCGiDAP
         Fz6oUegk1YEyFnZls4QJU5TpNzu/kC6T/RfOX81BwQg9T2RNY9oBdDqspKNP4gMZ/QKZ
         xsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682074471; x=1684666471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9JeLnNrL32s9KT2ojTlOZwCmMHQTQ795O7VEST2wvc=;
        b=D+MBOOd9N9nTXqRfQW5aZ/6YRNWxq43lCijDCSoRBjUiEgJ4Jy0yWwEnLPyx8BZ1y8
         I+vbwbqLQaeHz1CF8MUnVzPcxGIVaiieu7Us2pD9wRrz7wmMZSlodmH8AwnW+phJj6Ms
         LsHJhC47OF5fF7sMTXbSWLZH82e7Ew7jaatSoYN9lMGbotUhjTO1s5Bvf4DJrDmtPav1
         VCjqctNMWiZOQWMFHbM/Met5ZJzk+7kjjpX/apZeKygxMpiAwF7pMv1/DDSHCdVfmrfk
         VL83Ue9PAV8NrHK8qH84/bfSwhU+QX3Gu0/U2ZYdMuYSeENue3k8Q7InYaiu9yW9+XRI
         CtLA==
X-Gm-Message-State: AAQBX9eZvxiF+Z7gfqfFK6dYcHAGyIFvkkjwstue6fWHsLqHU8H4lEnU
	AVLoeWX5qiitQ0ygC/YRj66buQB0uJ9wNgfBnlU=
X-Google-Smtp-Source: 
 AKy350b2rAWIhCIIEiXy9IgdMaZ5kIg3DMJGhaLZY8Qv+YdbLmkfRkg4QYxFNkE81Y0YpOnWf8iCDBDKImaLjkrIlY4=
X-Received: by 2002:a1c:7211:0:b0:3f0:ad52:ac16 with SMTP id
 n17-20020a1c7211000000b003f0ad52ac16mr385642wmc.7.1682074470823; Fri, 21 Apr
 2023 03:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <87cz3yf631.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87cz3yf631.wl-kuninori.morimoto.gx@renesas.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 21 Apr 2023 18:54:18 +0800
Message-ID: 
 <CAA+D8ANRZmEwrg79ngyRVSc_P=nUNT8VTJ-Ej8-KoyJO=8EPSw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] ASoC: fsl: cleanup platform
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID-Hash: BYPTQ6QTO6EORCQMFAZKSEHQMEZTOYRY
X-Message-ID-Hash: BYPTQ6QTO6EORCQMFAZKSEHQMEZTOYRY
X-MailFrom: shengjiu.wang@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.8
CC: Mark Brown <broonie@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BYPTQ6QTO6EORCQMFAZKSEHQMEZTOYRY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

T24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgODoxMOKAr0FNIEt1bmlub3JpIE1vcmltb3RvIDwNCmt1
bmlub3JpLm1vcmltb3RvLmd4QHJlbmVzYXMuY29tPiB3cm90ZToNCg0KPg0KPiBIaSBNYXJrDQo+
IENjIFNoZW5naml1DQo+DQo+IFRoZSBkcml2ZXIgd2hpY2ggaXMgdXNpbmcgc29jLWdlbmVyaWMt
ZG1hZW5naW5lLXBjbSBpcyBhIGxpdHRsZSBiaXQNCj4gZGlmZmljdWx0IHRvIG5vdGljZSBhYm91
dCBpdCwgYmVjYXVzZSBpdCBwcmVwYXJlcyBvd24gQ29tcG9uZW50LA0KPiBidXQgc2hhcmVzIHNh
bWUgY29tcG9uZW50LT5kZXYgd2l0aCBDUFUgQ29tcG9uZW50Lg0KPg0KPiBTb21lIGZzbCBkcml2
ZXIgaXMgdXNpbmcgc29jLWdlbmVyaWMtZG1hZW5naW5lLXBjbSBhcyBQbGF0Zm9ybSBDb21wb25l
bnQuDQo+DQo+IFdoZW4gYmluZGluZyBDUFUvQ29kZWMsIGl0IGZpbmRzIHJlbGV2YW50IENvbXBv
bmVudCwgYW5kIGNoZWNrcyB0YXJnZXQNCj4gREFJLiBJZiBpdCBpdCB3YXMgdGFyZ2V0IERBSSwg
QVNvQyBiaW5kcyBpdHMgQ29tcG9uZW50IHRvIENhcmQuDQo+IEluIFBsYXRmb3JtIGNhc2UsIGl0
IGZpbmRzIHJlbGV2YW50IENvbXBvbmVudCBhbmQgYmluZCBpdC4gSXQgZG9lc24ndA0KPiBjaGVj
ayBEQUkuIFRoaXMgbWVhbnMsIHdlIGNhbiBzaGFyZSBDUFUgZGxjIHdpdGggUGxhdGZvcm0gaW4g
dGhpcyBjYXNlLg0KPiBJdCBpcyBtb3JlIHJlYXNvbmFibGUgLyB1bmRlcnN0YW5kYWJsZSAvIGlu
dHVpdGl2ZS4NCj4NCj4gVGhpcyBwYXRjaC1zZXQgc2hhcmUgQ1BVIGRsYyB3aXRoIFBsYXRmb3Jt
LCBhbmQgYWRkcyBzdWNoIGNvbW1lbnQuDQo+DQo+IEJlY2F1c2UgSSBjYW4ndCB0ZXN0IHRoaXMg
cGF0Y2gtc2V0LCB0aHVzIEkgYWRkZWQgW1JGQ10gb24gU3ViamVjdC4NCj4gUGxlYXNlIHRlc3Qg
dGhlc2UuIFRoaXMgcGF0Y2gtc2V0IHJlcXVlc3RzIFRlc3RlZC1ieS4NCj4NCj4gTGluazoNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci84N283b2pqZDA2LndsLWt1bmlub3JpLm1vcmltb3Rv
Lmd4QHJlbmVzYXMuY29tDQo+IExpbms6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTY4
MTkwMDE1OC0xNzQyOC0xLWdpdC1zZW5kLWVtYWlsLXNoZW5naml1LndhbmdAbnhwLmNvbQ0KPg0K
Pg0KQWNrZWQtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1LndhbmdAZ21haWwuY29tPg0KVGVz
dGVkLWJ5OiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53YW5nQGdtYWlsLmNvbT4NCg0KQmVzdCBy
ZWdhcmRzDQpXYW5nIHNoZW5naml1DQoNCkt1bmlub3JpIE1vcmltb3RvICg0KToNCj4gICBBU29D
OiBmc2w6IGlteC1lczgzMjg6IGNsZWFudXAgcGxhdGZvcm0gd2hpY2ggaXMgdXNpbmcgR2VuZXJp
YyBETUENCj4gICBBU29DOiBmc2w6IGlteC1zcGRpZjogY2xlYW51cCBwbGF0Zm9ybSB3aGljaCBp
cyB1c2luZyBHZW5lcmljIERNQQ0KPiAgIEFTb0M6IGZzbDogaW14LWF1ZG1peDogY2xlYW51cCBw
bGF0Zm9ybSB3aGljaCBpcyB1c2luZyBHZW5lcmljIERNQQ0KPiAgIEFTb0M6IGZzbDogaW14LWF1
ZG1peDogcmVtb3ZlIGR1bW15IGRhaV9saW5rLT5wbGF0Zm9ybQ0KPg0KPiAgc291bmQvc29jL2Zz
bC9pbXgtYXVkbWl4LmMgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICBzb3VuZC9zb2Mv
ZnNsL2lteC1lczgzMjguYyB8IDExICsrKysrKystLS0tDQo+ICBzb3VuZC9zb2MvZnNsL2lteC1z
cGRpZi5jICB8IDExICsrKysrKystLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlv
bnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPg0KPiAtLQ0KPiAyLjI1LjENCj4NCj4NCg==
