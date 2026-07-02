Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DC6C43458
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:43:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1F4E6021D;
	Thu,  2 Jul 2026 18:43:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1F4E6021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783010610;
	bh=VkioYQEdqFKNfuETx0d3YX3oNGKjVjBYEv66axzWhgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=on5BOxFRo82Kx7BeRdSCCP1ZMvh6YgEQCIZJYoMkqy0jRgTj4+tNxfuvfDIOiv/mk
	 xyJnZMOFMhKYH8L3WAbwwLw1F8ald00Skp0Snbjx1tAezo6UlThT9MXlq5rifj0LVw
	 qriq0DY3WTmuv7C5Q7bHO7f4y1LIxgyzWxU9n0Zo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4786F80639; Thu,  2 Jul 2026 18:42:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58BF0F80633;
	Thu,  2 Jul 2026 18:42:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E501F805CB; Thu,  2 Jul 2026 09:41:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782978104;
	b=AxSRko98KRn9jZuLyV/39FZfOj96nYBslu232E7zwD6ilH3LS1fElkWre0a2Pn7HYqnC
	 NUb0vaTRTJubPnLZ7LxfzJVhFMMBRe2A8wVqfUwZX5zstXQ6Vj/KjHrt4YTKR7ia0yxvL
	 /vgrQsg9HRga+HpoAO404T9+XnaLeFpiTn6pJSKF5U1123cUkhavQDgVRtGZFOHgF4lht
	 S+ctPBg0ZVXG79fgxQG4FWyLDaKETLRaeahmUxRcyTHkO5d1wmaL92SIlZmMjJg5xkx/t
	 b+zVJqEJf67rHhLy0M4mfS1saIMarpqM1TWcrIRLHdMWN2l5VwDnGSvR2NAd5QzKoQQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782978104;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=ItsTa4pP7gnz9NwZDzHFJZ1Kc1NjvJOAzHB+wRiC5hc=;
	b=bYb0FtPhK4K6UZGgDGZ57n3nwKlJgwpj+jnya966usVRaArRt+hsXRcxVVDLA9ItwuZ1
	 uxNAfp8etKh/OzyhI+hNf0sIcubl5/0rwAExG35XxuxTAOV5kJSHBtiCIVyfk6p3L5z2p
	 cJh2hWrQF+tBLQ6zIVr6MSImv1p4VixG/epv1LSMAq9ERLpBmFLpXPg2e6cVtfOU/2HvI
	 rLRtz0IuMg+YeFmusNsQEyl1mVvuKKJjExvGEtzkiTNHj4eKQEilRTQWt4aJTT6p2WkXn
	 n/cVLOORsRq7optVBb73ZCWoofQ3oICO0OjLssPoR/kSoc8Gq5QEYSZ/5kiVaDsjQVg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ykj+kKNz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2EBAF805C4
	for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2026 09:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2EBAF805C4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ykj+kKNz
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2ca11143dbbso10674645ad.2
        for <alsa-devel@alsa-project.org>;
 Thu, 02 Jul 2026 00:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782978101; cv=none;
        d=google.com; s=arc-20260327;
        b=kNfr5dNno+KpX5FXPgaZy8/mLSJvt5oZ+7h72Rqzvlix45JFGsigsSY/o5D537dEc0
         DPpi2dVUx0OVtuthSX9veLq4kFx35d/VQtLvfSiDefiBU/kseTXya3Yjr8GGnaNaQcpH
         q14bmArcqBiDKkOuyVrfiwCWVD8fSt+iPvlhKrTt8/V7XgM2OJchDzRBbebWxP+VpWDa
         SIXyT8edPclvfNHxsByn0WLrhAnMFjIVv5Q2bcuaRnlI7DKe3qEXveDn1VruzjbRrVkP
         vvlH3STMyLw7bbrkMCezZ5wgH0ckoqEQxQx9895WUmWS7pR0PH5a2KRzj9p/e5ZhC8/W
         zZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DOPv6otUDetdBB3tBxsuVDflGjqf8xNHh28pQF6jfF4=;
        fh=KEvBLgCq0tGg6sx/9J3NuBznJR0PWpLX1kWgi6whgIo=;
        b=a472yrATCkddmWe5LGftJl63jV8r2Z1swbcxZxi+kvCbGIxhEXkHQksWfpJeZ1WmY1
         YpckEMVLehXDNHnHjyIFBZf3YyhqfTV4gYwiIt7FOvvOc8NghTelOeZcNyIUybzSNrAQ
         XVavjZJ2cAUVh2f8pctGEUn9+hVGPrVW7VEnnkZykqRGUVQCzr6yDBbw3RjCBARTJx7a
         Svp0sEyonYsFJZoQt/46EEp1VpAFM8ezSKM+Jgou4efCIdL5VGSTU4hdfCEJzThHedeY
         y2y4eaceKEzkIiBTULWMgTuHALDh8DVb8Ppba7hkrQ6mu2n/uJtOL0d+H8gMU20lySqQ
         1Adg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782978101; x=1783582901;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DOPv6otUDetdBB3tBxsuVDflGjqf8xNHh28pQF6jfF4=;
        b=Ykj+kKNzcYyqtfxnMM9ihjI9QGTV0/0sDCCVIOFrsHmHHPkc+woe8Cg0v5romtWmQI
         q86WqENvo9E5scfEuSra+hpISBuVQvCbnRFMMwuxQ0xCBhlWkfXto800S1/oOXdlhifo
         u+TfMgCuQ0jj2TC6aCohUqjadS45aBjLLoWi1fQBPs+AzLV4iuRwiLGPt8XLBYAFZZsB
         ZzzVNLAvaf0WnRn8AcyIONKSLcfbsqPWtAD7kNF98BOTMPRDb81603uoKzyuMxMsf+Fb
         z7NLf+UXz7gM9SWWJv5cUss4ZtI8gd1QjuUBncp3rto4viHLatwmS8vP0A2UT9n9nrcO
         5ArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978101; x=1783582901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOPv6otUDetdBB3tBxsuVDflGjqf8xNHh28pQF6jfF4=;
        b=sIUy+3T2lsH0Zg4jcuqnkcdl6nMK5EL7jGt3BJv6SGXEplzRRU8187EGxBc6XgiOp3
         cF2Kg1XEYF2l14YtjL9VhZNIKU+ID+ibRAoW19fugqhNItam43tyem25t3bGyEUiRQpL
         waBvUuKytN0HWfFt1hXZt5myg2Icup464bjTtlQCcDenZMPY7ar25dGD1A6+VvXOfeM6
         uZoc/+XdRWWlElqISWH9MYskiphB6a5lV09s/LOh2NbzXjw9Je3J9eYxbgZLjHYK7hLm
         R/e4siTCCqKt15LYMp434q+ZryjrTtafEDhYFlLQEG0zd/+1cxnRBZKao/FVpGVBDQ8K
         QYjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBnfeiTad0EJs+9beGGWbfZyWEd5Db/TjZsoO+NtX8qwKSyCjEdShVwFEKvtSWrXNUuAKnlGqSJzV3@alsa-project.org
X-Gm-Message-State: AOJu0Yy89AtR07apPS9hojR2yqNvnXP+zOpQ5y+x3FssXD38TJwzhDWx
	6QUZxabLpDYqoQcb+RarPYz0jjzteM1ABdT1eqromjaqI9oQKJhOWPh/EeGoQfkoK/YcXnJMtPF
	7qMvC5k7JYUr6BcxH8HbjBcgd410kiZQ=
X-Gm-Gg: AfdE7cm8jW2z/U97BSmvVcJb6Yxl3lBQotSsxLdkIdY6gHyIXrtrbLpSKG6Z1hWrQy9
	cCOp3VhHJa8QEi9s8g0GCGS4PK4a30A1ZJ2LSHQXBY72T2vPUpij2idLQ5V0aXu+9TGHKexs3WC
	fkGPpfvcbSpEp389fDbkWhSq11ZGSzpRrZh9wg9TJvTVJMIQI8WVJeSRVTA8pEOApBE4Q3SfK4o
	K+2JM72yZ5ZWjVn62Iy4WzDwmliJZJqapeoIxjQqghca04Qu01VZbmGVBvY9SLcbSA73qvOY+gn
	/tJwXvRGb2GAby48FGHEb5v9
X-Received: by 2002:a17:902:ffcb:b0:2c6:9f6a:9f6f with SMTP id
 d9443c01a7336-2ca7e8c4b2bmr51138525ad.28.1782978100387; Thu, 02 Jul 2026
 00:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260626134709.27883-1-nevergfx1@gmail.com>
 <87cxx5alw1.wl-tiwai@suse.de>
In-Reply-To: <87cxx5alw1.wl-tiwai@suse.de>
From: Omer Cohen <nevergfx1@gmail.com>
Date: Thu, 2 Jul 2026 10:41:29 +0300
X-Gm-Features: AVVi8CfxH7lmMWBccOqIo2yL_2eIk7G023_6NP50SzVuK7Yxzp_-7N7WFnAoW5s
Message-ID: 
 <CAN8_ozgL3V8YAj+gsb31t3tLqWCTaVwvQROcMiNtVWWzSYqOQw@mail.gmail.com>
Subject: Re: [PATCH 0/6] ALSA: sound/core: fix multiple data races and bugs
To: Takashi Iwai <tiwai@suse.de>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, security@kernel.org
X-MailFrom: nevergfx1@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: F25LZOAPKYIWI3HLPLRDKSPCSFSKYM72
X-Message-ID-Hash: F25LZOAPKYIWI3HLPLRDKSPCSFSKYM72
X-Mailman-Approved-At: Thu, 02 Jul 2026 16:42:42 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F25LZOAPKYIWI3HLPLRDKSPCSFSKYM72/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgVGFrYXNoaSwNCg0KR290IGl0LiBJJ2xsIHJlc3VibWl0IHRvIGxpbnV4LXNvdW5kIGFuZCBj
aGVjayB0aGUgbGF0ZXN0IHRyZWUuDQoNClRoYW5rcyENCg0KT24gVGh1LCAyIEp1bCAyMDI2IGF0
IDEwOjMwIFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4gd3JvdGU6DQoNCj4gT24gRnJpLCAy
NiBKdW4gMjAyNiAxNTo0NzowMyArMDIwMCwNCj4gT21lciBDb2hlbiB3cm90ZToNCj4gPg0KPiA+
IFRvOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+LCBNYXJrIEJyb3duIDxicm9vbmllQGtl
cm5lbC5vcmc+DQo+ID4gQ2M6IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZw0KPiA+IENjOiBz
ZWN1cml0eUBrZXJuZWwub3JnDQo+ID4NCj4gPiBIaSBUYWthc2hpLCBNYXJrLA0KPiA+DQo+ID4g
VGhpcyBpcyBteSBmaXJzdCBwYXRjaCBzZXJpZXMgdG8gdGhlIExpbnV4IGtlcm5lbC4gIEkgYW0g
Q0NpbmcgdGhlDQo+ID4gc2VjdXJpdHkgdGVhbSBhcyByZWNvbW1lbmRlZCBieSB0aGUgZG9jcyBm
b3IgaW5pdGlhbCByZXBvcnRzLg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgZml4ZXMgNiBidWdzIGZv
dW5kIHZpYSBjb2RlIHJldmlldyBhbmQgS0NTQU4gZHluYW1pYw0KPiA+IGFuYWx5c2lzIGluIHRo
ZSBBTFNBIHNvdW5kL2NvcmUgc3Vic3lzdGVtLiAgQWxsIHBhdGNoZXMgYXJlIGFnYWluc3QNCj4g
PiBjdXJyZW50IEhFQUQgKDRlZGNkZWZkNDA4MykuDQo+ID4NCj4gPiBQYXRjaCAxIGlzIGNvbmZp
cm1lZCB3aXRoIEtDU0FOLiAgVGhlIHJlbWFpbmluZyBwYXRjaGVzIGFkZHJlc3MgYnVncw0KPiA+
IGZvdW5kIGR1cmluZyBhbmFseXNpcyBvZiB0aGUgc2FtZSBjb2RlIHBhdGhzLg0KPiA+DQo+ID4g
VGhpcyB3b3JrIHdhcyBBSS1hc3Npc3RlZC4gIFBlciB0aGUga2VybmVsIGRvY3VtZW50YXRpb24g
b24gcmVwb3J0aW5nDQo+ID4gc2VjdXJpdHkgYnVncywgaXQgaXMgc2VudCB0byB0aGUgcHVibGlj
IG1haWxpbmcgbGlzdC4gIEFsbA0KPiA+IHJlcHJvZHVjZXJzIGhhdmUgYmVlbiB0ZXN0ZWQgb24g
YXJtNjQgUUVNVS4NCj4NCj4gTWF5YmUgbXkgcHJldmlvdXMgbWFpbCBkaWRuJ3QgcmVhY2ggeW91
IHByb3Blcmx5LCBzbyBJIGFzayBoZXJlIGFnYWluDQo+ICh3aXRoIGtlZXBpbmcgQ2MgYXQgdGhp
cyB0aW1lKToNCj4gY291bGQgeW91IHJlc3VibWl0IHRvIGxpbnV4LXNvdW5kQHZnZXIua2VybmVs
Lm9yZyBNTCwgQ2MgdG8NCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgaW5zdGVhZD8g
IFNpbmNlIHNvbWUgdGltZSBhZ28sDQo+IGFsc2EtZGV2ZWwgTUwgaXMgb25seSBmb3IgdXNlci1z
cGFjZSBzdHVmZiwgYW5kIHRoZSBrZXJuZWwgcGF0Y2hlcw0KPiBzaG91bGQgZ28gdG8gbGludXgt
c291bmQgTUwuDQo+DQo+IEFsc28sIHBsZWFzZSBkb3VibGUtY2hlY2sgdGhhdCB0aGUgaXNzdWUg
aXMgc3RpbGwgcmVwcm9kdWNpYmxlIHdpdGgNCj4gdGhlIGxhdGVzdCBMaW51cyB0cmVlIGJlZm9y
ZWhhbmQsIHRvby4NCj4NCj4NCj4gdGhhbmtzLA0KPg0KPiBUYWthc2hpDQo+DQo+ID4NCj4gPiBT
dW1tYXJ5Og0KPiA+DQo+ID4gICBbMS82XSBBTFNBOiBjb21wcmVzczogcmVtb3ZlIGlsbGVnYWwg
c3RhdGUgbXV0YXRpb24gaW4gcG9sbCgpDQo+ID4gICAgIHNuZF9jb21wcl9wb2xsKCkgd3JpdGVz
IHJ1bnRpbWUtPnN0YXRlID0gU0VUVVAgd2hlbiBpdCBzZWVzDQo+ID4gICAgIERSQUlOSU5HLiAg
VGhpcyByYWNlcyB3aXRoIHNuZF9jb21wcmVzc193YWl0X2Zvcl9kcmFpbigpIHdoaWNoDQo+ID4g
ICAgIHJlYWRzIHJ1bnRpbWUtPnN0YXRlIGNvbmN1cnJlbnRseS4gIEtDU0FOIGNvbmZpcm1zOg0K
PiA+DQo+ID4gICAgICAgQlVHOiBLQ1NBTjogZGF0YS1yYWNlIGluIHNuZF9jb21wcl9wb2xsIC8N
Cj4gc25kX2NvbXByZXNzX3dhaXRfZm9yX2RyYWluDQo+ID4NCj4gPiAgICAgICB3cml0ZSB0byAw
eGZmZmYwMDAwYzc1YzgyMDAgb2YgNCBieXRlcyBieSB0YXNrIDI4MiBvbiBjcHUgMzoNCj4gPiAg
ICAgICAgc25kX2NvbXByX3BvbGwrMHgyOWMvMHgyYzgNCj4gPiAgICAgICAgZG9fc3lzX3BvbGwr
MHgyYjAvMHg2MjgNCj4gPg0KPiA+ICAgICAgIHJlYWQgdG8gMHhmZmZmMDAwMGM3NWM4MjAwIG9m
IDQgYnl0ZXMgYnkgdGFzayAyNzkgb24gY3B1IDE6DQo+ID4gICAgICAgIHNuZF9jb21wcmVzc193
YWl0X2Zvcl9kcmFpbisweGE0LzB4MjcwDQo+ID4gICAgICAgIHNuZF9jb21wcl9pb2N0bCsweDFi
YTAvMHgxYmM4DQo+ID4NCj4gPiAgICAgICB2YWx1ZSBjaGFuZ2VkOiAweDAwMDAwMDA1IC0+IDB4
MDAwMDAwMDENCj4gPg0KPiA+ICAgICBwb2xsKCkgaXMgYSBxdWVyeSBvcGVyYXRpb24gYW5kIG11
c3Qgbm90IG11dGF0ZSBzdGF0ZS4gIFRoZQ0KPiA+ICAgICBEUkFJTklORy0+U0VUVVAgdHJhbnNp
dGlvbiBpcyBhbHJlYWR5IGhhbmRsZWQgYnkgZHJpdmVycyB2aWENCj4gPiAgICAgc25kX2NvbXBy
X2RyYWluX25vdGlmeSgpLg0KPiA+DQo+ID4gICBbMi82XSBBTFNBOiBjb21wcmVzczogZml4IGJ1
ZmZlciBsZWFrIG9uIHNldF9wYXJhbXMgZHJpdmVyIGZhaWx1cmUNCj4gPiAgICAgSWYgb3BzLT5z
ZXRfcGFyYW1zKCkgZmFpbHMgYWZ0ZXIgYnVmZmVyIGFsbG9jYXRpb24sIHRoZSBidWZmZXINCj4g
PiAgICAgbGVha3Mgb24gcmV0cnkgYmVjYXVzZSBydW50aW1lLT5idWZmZXIgd2FzIGFscmVhZHkg
b3ZlcndyaXR0ZW4uDQo+ID4NCj4gPiAgIFszLzZdIEFMU0E6IHRpbWVyOiBmaXggbG9ja2xlc3Mg
dHUtPnRyZWFkIHJlYWQgaW4gcmVhZCgpDQo+ID4gICAgIHNuZF90aW1lcl91c2VyX3JlYWQoKSBy
ZWFkcyB0dS0+dHJlYWQgd2l0aG91dCBpb2N0bF9sb2NrIHRvDQo+ID4gICAgIGRldGVybWluZSBl
bnRyeSBzaXplLCB0aGVuIHJlLXJlYWRzIGl0IHVuZGVyIGxvY2sgZm9yIHRoZSBjb3B5DQo+ID4g
ICAgIGZvcm1hdC4gIEEgY29uY3VycmVudCBUUkVBRCBpb2N0bCBjYW4gY2hhbmdlIHRoZSBmb3Jt
YXQgYmV0d2Vlbg0KPiA+ICAgICByZWFkcywgY2F1c2luZyBhIHNpemUvZm9ybWF0IG1pc21hdGNo
Lg0KPiA+DQo+ID4gICBbNC82XSBBTFNBOiB0aW1lcjogY29weSBxdWV1ZSBlbnRyaWVzIHVuZGVy
IGxvY2sgYmVmb3JlIGNvcHlfdG9fdXNlcg0KPiA+ICAgICBBZnRlciBkZXF1ZXVpbmcgdW5kZXIg
cWxvY2ssIHJlYWQoKSBkcm9wcyB0aGUgbG9jayBhbmQgY2FsbHMNCj4gPiAgICAgY29weV90b191
c2VyKCkgZGlyZWN0bHkgZnJvbSB0aGUgcXVldWUgc2xvdC4gIFRpbWVyIGNhbGxiYWNrcw0KPiA+
ICAgICBjYW4gb3ZlcndyaXRlIHRoYXQgc2xvdCB2aWEgcXVldWUgd3JhcGFyb3VuZCBkdXJpbmcg
dGhlIGNvcHkuDQo+ID4gICAgIFNhbWUgYnVnIGNsYXNzIGFzIENWRS0yMDE3LTEwMDAzODAuDQo+
ID4NCj4gPiAgIFs1LzZdIEFMU0E6IHBjbTogdXNlIGxvY2tlZCBzdGF0ZSByZWFkIGluIHNuZF9w
Y21fZHJvcCgpDQo+ID4gICAgIHNuZF9wY21fZHJvcCgpIHJlYWRzIHJ1bnRpbWUtPnN0YXRlIHdp
dGhvdXQgdGhlIHN0cmVhbSBsb2NrLg0KPiA+ICAgICBDb21taXQgN2JjMDJhYjQ0NmQzIGZpeGVk
IHRoaXMgcGF0dGVybiBpbiByZWFkL3dyaXRlIHBhdGhzDQo+ID4gICAgIGJ1dCBtaXNzZWQgZHJv
cCgpLg0KPiA+DQo+ID4gICBbNi82XSBBTFNBOiByYXdtaWRpOiBwcm9wYWdhdGUgcmVzaXplX3J1
bnRpbWVfYnVmZmVyKCkgZXJyb3INCj4gPiAgICAgc25kX3Jhd21pZGlfaW5wdXRfcGFyYW1zKCkg
aWdub3JlcyB0aGUgcmV0dXJuIHZhbHVlIGZyb20NCj4gPiAgICAgcmVzaXplX3J1bnRpbWVfYnVm
ZmVyKCkgYW5kIHVuY29uZGl0aW9uYWxseSByZXR1cm5zIDAuDQo+ID4NCj4gPiBLQ1NBTiByZXBy
b2R1Y2VyIGZvciBwYXRjaCAxOg0KPiA+DQo+ID4gICBUaGUgcmFjZSBpcyB0cmlnZ2VyZWQgYnkg
Y29uY3VycmVudCBwb2xsKCkgYW5kIERSQUlOIGlvY3RsIG9uIGENCj4gPiAgIGNvbXByZXNzIG9m
ZmxvYWQgc3RyZWFtLiAgQSBtaW5pbWFsIHJlcHJvZHVjZXIgdXNlcyBmb3VyIHRocmVhZHM6DQo+
ID4NCj4gPiAgICAgVGhyZWFkIDE6IERSQUlOIGlvY3RsIGxvb3ANCj4gPiAgICAgVGhyZWFkIDI6
IFBBUlRJQUxfRFJBSU4gaW9jdGwgbG9vcA0KPiA+ICAgICBUaHJlYWQgMzogU1RPUCBpb2N0bCBs
b29wIChyYW5kb20gZGVsYXkpDQo+ID4gICAgIFRocmVhZCA0OiBwb2xsKCkgbG9vcA0KPiA+DQo+
ID4gICBUaGUgbWFpbiB0aHJlYWQgcmVwZWF0ZWRseSBzZXRzIHVwIGFuZCBzdGFydHMgdGhlIHN0
cmVhbS4gIFdpdGgNCj4gPiAgIENPTkZJR19LQ1NBTj15IGFuZCBDT05GSUdfS0NTQU5fU1RSSUNU
PXksIHRoZSByYWNlIGlzIGZsYWdnZWQNCj4gPiAgIHdpdGhpbiB+MjAwMCBpdGVyYXRpb25zLg0K
PiA+DQo+ID4gICBBbnkgY29tcHJlc3Mgb2ZmbG9hZCBkcml2ZXIgKGhhcmR3YXJlIG9yIHZpcnR1
YWwpIGV4cG9zZXMgdGhlDQo+ID4gICByYWNlIHNpbmNlIHRoZSBidWcgaXMgaW4gdGhlIGZyYW1l
d29yaywgbm90IGRyaXZlciBjb2RlLg0KPiA+DQo+ID4gICBUZXN0ZWQgb24gYXJtNjQgUUVNVSwg
a2VybmVsIDcuMS4wLXJjNysgKDRlZGNkZWZkNDA4MykuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4g
T21lcg0KPg0K
