Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE292CA5FF1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:02:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E44D9602AB;
	Wed,  7 Oct 2026 09:02:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E44D9602AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791356541;
	bh=25YIAaZMlzyJg50poY2u47Sdly0tZsji1ZkA3G4MLKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Oe6AfOVUt7x4p//G/Y33Ubd2jVra3sBz+O0wcTJyre8GpQM58/ijD8/u1L/qklXXQ
	 l/hE7H3w7IFn+teLuIcnp7k9Z7o6ugtxp2esPcMug42Uf/JIDx9SfuH2Cy+Sb082j2
	 TUphJqAGPnQJ+IZyJshkgI2bZr9B8HK+gZ60tXGU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3AD83F806A9; Wed,  7 Oct 2026 08:59:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CF966F80C18;
	Wed,  7 Oct 2026 08:59:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5EB5F80423; Tue,  6 Oct 2026 20:23:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791311031;
	b=a4JgaQLEEc+Bz+1AnjoY97P7JGmFyFt+OMs7coRmbDEk56DSNa00Aspl/zQInk768vTo
	 4AOxWq+KHaegbiueRTg8YjPdEMGZw8Yo1saeliMiNduIEID+cvYk98UOP+bDbYWFM0XHs
	 0QMt2M/CCe/vdgxX6ifmLriV5sBpMRRt/OW+Vb+Wuk+O32UpPqrCKANEM9hxqhoVx/G3n
	 r5n4DAxmuWFqJwyUMRinkTRNqflne2XHvSqym1vms2sOOLH8bAPdZ9RRteirF9UaWtk5a
	 qt17XEoXb/gpJhTmiWy8IT6icBfoGnRNkmHA8Mj+knunOI8b+rFQLNZb6ULvJlco8NQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791311031;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=PdRiZVEl9PCrFlJnezHMMaimBoHTjXXcxF9gSl3bjKo=;
	b=Edg413cJO9D85MR5ZmytHob4l3VL6foD0HG56d3OwPr16u6uEccvtY3UijXrBpGoLMUF
	 eDqkEROkh2gZ0IwOQtIIiM4fSNVJZXALwloZ+Dc8XyIkzpnJGC7WvacaVlRfrQhwwVV5n
	 ojaQP0KAArR/1uvkJPOGdHvIhaQDkbxhJjCVq5/jARoNbsSu1Lh08E+2XoyeJX/OHIFl7
	 fKKwpT+qw8xQ5i+2m40pFTESBC8IH7+npD/FKXhSYNRmONqEQvzzvQkbnLNskSGutno7q
	 rY9IhsoqZ8kuKBFkwqZ1B52bA7EjQFRL4kMpafo4P6y33cQes8AbY3MzY4JKjwe6pbg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bSyMJJkl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 751B6F80212
	for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2026 20:23:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 751B6F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bSyMJJkl
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-49e09a20082so561914fac.2
        for <alsa-devel@alsa-project.org>;
 Tue, 06 Oct 2026 11:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791311027; cv=none;
        d=google.com; s=arc-20260327;
        b=nROPiSiLl6agHLzPubDDkvhllw1/Vk8C176TZjxJs7H3mncXWyORiNgfZye/aRIaMQ
         cIR3Cax6tcUHEGteRLH36yk8Et2QeZ3b9becvc0/FEGUDyKzgrUXGHE3+KfjKeKJg+Py
         sppUVDacxA/mZGQoB0dcx0sLLj4hehpDEXLNwUKy+hSln9UYpgz90Pvp3jcyxJ78/oc9
         Pn9vsO/xRnl4S8oTiVIUYKVCCGgoAc3x0UxAHezUtAMTl6LUC0q705oXYW7m0f1ixgGE
         8hLS4YhJM36cNPMWQ52gI9jt3kRvZ982WekaM8RzcorArvhW7uNoz4rRMd4lVQmXnhLI
         KSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KMqRILlr5O0RgSroSYI2lTSVgkwpvddU+VlJFbwPfaQ=;
        fh=0YfJqFR5pfNOpTMVfT0Ad9qoeFU4xrhz1jeUhfXC4vk=;
        b=ZEd5pzXshY+1zo6GzADGJ/wOKxETu3ALufBeRWXXjlaCQHIE4MCfUueKCcoAhoOU2S
         6dDC63mlEJbq8Opjkc0ELHaZgLg83gsAbld6TqiJSWcyHYCpoQu2w5iYbm7FhxEePB3y
         ogodGKAi+d63UWITLNHcjQvYImi7mPjQT8nKGqsBvMjUtaUwJ0C60MwrdzDnQJSMWiCE
         ed/hfbEFJXuPKHQFsD+55zd9Rd0/jUg7PvAaaLs0rvD1iXVdgo4/60DUZM3eoaRrOarc
         YB3f3XRuIKIms1jw3R4Lj7NcWPFfxReMsiQ9ymtFYIBB0i/EMuICSiQJQoQnip/xuylC
         zYuQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791311027; x=1791915827;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMqRILlr5O0RgSroSYI2lTSVgkwpvddU+VlJFbwPfaQ=;
        b=bSyMJJklcCe9LvEOYW4Mhtb6hOspSpDBpvVmYDODqXUe3vV5m9PDXGbfeRTwoguD9E
         sR0kAoCnrYGhWTEcBnHalx6HRBnu+DAZtgTtKuDgB4yT80f175QmVpiKvdprK4YhWZMB
         8JX5F9xDSUtNFisZ3hHpzwEnF1GGPBkH6obqe/Vbtx98i5hVd178GomYKIdWDqfAMq6G
         VOaip/BxuLXzQoCppJ/SwChTp0iDJutyq15ga1L8xn2YKURHlCa8nqykBvljirYmVflI
         k6muA1IMJKKtCvRTOVgGL66nPGMXKb9jcb0mLpTHzrswW/rvQ9r+p6mwWBk5a8GprT8C
         AY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791311027; x=1791915827;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KMqRILlr5O0RgSroSYI2lTSVgkwpvddU+VlJFbwPfaQ=;
        b=1O2mNu9QuCJ5Gnab1z/aYZdkCmwLBZty7ujDF8h3kLnjbq2KYSe0NQuqdlxtK8krq5
         Db87wWmz6bG8DI9GgdEVb+pctRgc1PPokthwCC/uxgKyKamjf/R6aGRd9vczHpErf4rf
         QIZPuUdXuNTDjwaNvdrRdDh2ycxrTtRcZkY3x3keBnIEaic5Rskq//RMxAXJf/Dq4mds
         WhPVvNQgDadFQ7I1UeCrEqZnuxRICYn6hdeIhxKS/ZYJlxD5T9pc3Ehtu7HSyvb2TqKb
         CJA/dAmrs4pjsAy9kg5uBlq02jfdLRprKNIFitDKNu7GvexiRfh4nfbpIs0UwtC2tOCl
         oBqQ==
X-Gm-Message-State: AFuF++kfOCSKNEOP8d0bD/K1DJQ5QikxGNYffQqujZy41b8l4UfBj88S
	57W8PAtL5ZG5ZU2/+J0VbvK9jWjcCUUQrkBJhdyk43dLuy3rfjfYnlHk/FpB8IIQkDLyASqNKPu
	ch/pvbZSkXjOD6CrJXqT4kMbeMMKsFIs=
X-Gm-Gg: AYBFou15Ap7rYCiGK/0mJWUOADoilr4VK5iu6KwhIngOPgYmz2GnKA9h0Vd6YwEV4x9
	snW4LmieD9/5MqdB0QJccB6yM02OGrgz1TRuW7BsWoSsbo1YZNeT3AK9peumiPEXxEcuXXf4HMK
	m0yRaQtd6FQoDlniWGtMw+zkBG9FLrDHZpG4l0V6/0bHa4z9hmbxu9xlFJj/bacBhfXAvG4FNqv
	gqHR5eESDLMvMFgNWS25Rh4hkvpkTgyq+bpr0zI6YvV2gWCRs/8pjSFzLSvd6K/i3ZYz7YSUN06
	ukA7o8WSVj9SP6yGktfP+QX5HzGdoxyj1bVJY7cK7mrHxLGFIjGA0vw6HtHUV4qGcMa0oea5+Tv
	o9WDcY7fsdKZJQ44AvCI8viRjLybw
X-Received: by 2002:a05:6870:d250:b0:448:8bdd:8358 with SMTP id
 586e51a60fabf-4a240495d71mr2304962fac.15.1791311027054; Tue, 06 Oct 2026
 11:23:47 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAE+cq4DqF8DsgzLh89FvED78p53=eUZ1pUq+ePV-tGBodBt=vQ@mail.gmail.com>
 <BN9PR12MB535638FADC423230FD4B222EFC952@BN9PR12MB5356.namprd12.prod.outlook.com>
In-Reply-To: 
 <BN9PR12MB535638FADC423230FD4B222EFC952@BN9PR12MB5356.namprd12.prod.outlook.com>
From: Beau Lynn-Miller <beaulm@gmail.com>
Date: Tue, 6 Oct 2026 13:23:10 -0500
X-Gm-Features: AclHuK8v34Co_MdczWj0Oq9BUuww1qXUZptj8_lyK_JYc3_1SONxg6naXXS-QGY
Message-ID: 
 <CAE+cq4AdKnLNUBrzAjBaVfdgv7V2Kd+WsBp48LgsbuJUMYp76Q@mail.gmail.com>
Subject: Re: [BUG] ALSA: amd: ps: acp63 DMIC capture freezes/rails after
 prolonged s2idle suspend on AMD Phoenix
To: "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
X-MailFrom: beaulm@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 6AXFWNATQGECNF37RGOQZJJ4D6EJMHSA
X-Message-ID-Hash: 6AXFWNATQGECNF37RGOQZJJ4D6EJMHSA
X-Mailman-Approved-At: Wed, 07 Oct 2026 06:58:32 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6AXFWNATQGECNF37RGOQZJJ4D6EJMHSA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgU3llZCwNCg0KSSB3YXMgcHJlcGFyaW5nIHRvIGZpbGUgYSBuZXcgdGlja2V0LCBidXQgZm91
bmQgYW4gZXhpc3Rpbmcgb3BlbiB0aWNrZXQNCnRyYWNraW5nIHRoaXMgZXhhY3QgaXNzdWUgb24g
dGhlIFRoaW5rUGFkIFBob2VuaXggcGxhdGZvcm06IEJ1ZyAyMjE3MzEgKA0KaHR0cHM6Ly9idWd6
aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjE3MzEpLg0KDQpJdCBhcHBlYXJzIGl0
IHdhcyBvcmlnaW5hbGx5IG1pc2NhdGVnb3JpemVkIHVuZGVyIFNvdW5kKE9TUykgaW5zdGVhZCBv
Zg0KU291bmQoQUxTQSksIHdoaWNoIG1heSBiZSB3aHkgaXQgd2Fzbid0IG9uIHlvdXIgcmFkYXIu
IEkgaGF2ZSBhZGRlZCBteSB0ZXN0DQpkYXRhIGFuZCBUaGlua1BhZCBUMTYgR2VuIDIgZmluZGlu
Z3MgYXMgYSBjb21tZW50IHRvIHRoYXQgdGlja2V0IHNvDQpldmVyeXRoaW5nIHJlbWFpbnMgdW5p
ZmllZC4NCg0KVGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcyENCg0KT24gVHVlLCBPY3QgNiwg
MjAyNiBhdCAxMjo1MeKAr0FNIFNhYmEgS2FyZWVtLCBTeWVkIDxTeWVkLlNhYmFLYXJlZW1AYW1k
LmNvbT4NCndyb3RlOg0KDQo+IEFNRCBHZW5lcmFsDQo+DQo+IEhpIGJlYXUsDQo+IFdlIGFyZSBs
b29raW5nIGludG8gdGhpcyBpc3N1ZSwgbWVhbndoaWxlIGNvdWxkIHlvdSBwbGVhc2UgY3JlYXRl
IGFuZA0KPiBzaGFyZSBCdWd6aWxsYSB0aWNrZXQgZm9yIHRoZSBtZW50aW9uZWQgaXNzdWUsIGl0
IHdpbGwgYmUgZWFzeSBmb3IgdHJhY2tpbmcuDQo+DQo+IFRoYW5rcywNCj4gU3llZCBTYWJhIEth
cmVlbS4NCj4NCj4gKkZyb206KiBCZWF1IEx5bm4tTWlsbGVyIDxiZWF1bG1AZ21haWwuY29tPg0K
PiAqU2VudDoqIFRodXJzZGF5LCBPY3RvYmVyIDEsIDIwMjYgMTE6NTYgUE0NCj4gKlRvOiogYWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnDQo+ICpDYzoqIE11a3VuZGEsIFZpamVuZGFyIDxWaWpl
bmRhci5NdWt1bmRhQGFtZC5jb20+OyBTYWJhIEthcmVlbSwgU3llZCA8DQo+IFN5ZWQuU2FiYUth
cmVlbUBhbWQuY29tPg0KPiAqU3ViamVjdDoqIFtCVUddIEFMU0E6IGFtZDogcHM6IGFjcDYzIERN
SUMgY2FwdHVyZSBmcmVlemVzL3JhaWxzIGFmdGVyDQo+IHByb2xvbmdlZCBzMmlkbGUgc3VzcGVu
ZCBvbiBBTUQgUGhvZW5peA0KPg0KPg0KPg0KPiBZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZy
b20gYmVhdWxtQGdtYWlsLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMNCj4gaW1wb3J0YW50IDxodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24+DQo+DQo+IFNVTU1BUlkN
Cj4gT24gYSBMZW5vdm8gVGhpbmtQYWQgVDE2IEdlbiAyIEFNRCAoQU1EIFBob2VuaXggLyBBQ1A2
LjMpLCB0aGUgaW50ZXJuYWwNCj4gZGlnaXRhbCBtaWNyb3Bob25lIGFycmF5IChETUlDKSBjb25z
aXN0ZW50bHkgZmFpbHMgdXBvbiByZXN1bWluZyBmcm9tDQo+IGV4dGVuZGVkIHMyaWRsZSBzdXNw
ZW5kIChvdmVybmlnaHQgb3IgPjIuNSBob3VycykuIENhcHR1cmUgc3RhcnRzIGFuZA0KPiBjbG9j
a3Mgd2l0aG91dCBrZXJuZWwgZXJyb3JzLCBidXQgcmV0dXJucyBhIGNvbnN0YW50IGZyb3plbiB2
YWx1ZSAoemVybw0KPiBBQy1STVMgLyByYWlsZWQpIGluc3RlYWQgb2YgYW4gYWNvdXN0aWMgc2ln
bmFsLg0KPg0KPiBTaG9ydCBkYXl0aW1lIHN1c3BlbmRzICh1bmRlciAx4oCTMiBob3VycykgYW5k
IHJhcGlkIFJUQyB3YWtlIGN5Y2xlcyBkbyBOT1QNCj4gdHJpZ2dlciB0aGUgaXNzdWUuIE9uY2Ug
dHJpZ2dlcmVkLCB0aGUgaGFyZHdhcmUgc3RhdGUgbGF0Y2hlczogbmVpdGhlcg0KPiB1bmxvYWRp
bmcvcmVsb2FkaW5nIHRoZSBkcml2ZXIgbW9kdWxlcyBub3IgdW5iaW5kaW5nL3Jlc2Nhbm5pbmcg
dGhlIFBDSQ0KPiBlbmRwb2ludCB2aWEgc3lzZnMgcmVzdG9yZXMgY2FwdHVyZS4gT25seSBhIGNv
bXBsZXRlIHN5c3RlbSByZWJvb3QgY2xlYXJzDQo+IHRoZSBsYXRjaC4NCj4NCj4gSEFSRFdBUkUg
JiBFTlZJUk9OTUVOVA0KPiAtIE1hY2hpbmU6IExlbm92byBUaGlua1BhZCBUMTYgR2VuIDIgQU1E
ICgyMUs3Q1RPMVdXKQ0KPiAtIEFQVTogQU1EIFJ5emVuIDcgUFJPIDc4NDBVIHcvIFJhZGVvbiA3
ODBNIEdyYXBoaWNzIChQaG9lbml4LCBBQ1AgNi4zKQ0KPiAtIEJJT1M6IFIyRkVUNjlXICgxLjQ5
KSwgRUMgUjJGSFQ0OVcNCj4gLSBBdWRpbyBEZXY6IFBDSSAwMDAwOjY0OjAwLjUgWzEwMjI6MTVl
Ml0gTXVsdGltZWRpYSBjb250cm9sbGVyIChyZXYgNjMpDQo+IC0gQUxTQSBDYXJkOiBjYXJkIDI6
IGFjcDYzIFthY3A2M10sIGRldmljZSAwOiBETUlDIGNhcHR1cmUgZG1pYy1oaWZpLTAgW10NCj4g
LSBEcml2ZXJzOiBzbmRfcGNpX3BzLCBzbmRfcHNfcGRtX2RtYSwgc25kX3NvY19wc19tYWNoLCBz
bmRfc29jX2RtaWMNCj4gLSBLZXJuZWxzOiBsaW51eC1pbWFnZS02LjguMC0xMzYsIDYuOC4wLTEz
OSwgNy4wLjAtMzEsIDcuMC4wLTM0LWdlbmVyaWMNCj4gLSBEaXN0cm86IExpbnV4IE1pbnQgMjIu
MyAoVWJ1bnR1IDI0LjA0IG5vYmxlIGJhc2UpLCBQaXBlV2lyZSAxLjAuNSAvIEFMU0ENCj4gMS4y
LjExDQo+DQo+IFRSSUdHRVIgUEFUVEVSTiAmIFRJTUVMSU5FDQo+IENvbnRpbnVvdXMgMzAtbWlu
dXRlIGJhY2tncm91bmQgbG9nZ2luZyAocmVjb3JkaW5nIDJzIHNhbXBsZXMgdmlhDQo+IHB3LXJl
Y29yZC9hcmVjb3JkKSByZXZlYWxlZDoNCj4gMS4gU2hvcnQgc3VzcGVuZHMgc3Vydml2ZSBjbGVh
bmx5Og0KPiAgICAtIDEyIGF1dG9tYXRlZCBjeWNsZXMgb2YgMjBzIHMyaWRsZSBzbGVlcDogMCBm
YWlsdXJlcy4NCj4gICAgLSA4IGRheXRpbWUgc3VzcGVuZHMgYWNyb3NzIDQgZGF5cyBvZiB1cHRp
bWUgb24gNy4wLjAtMzE6IGFsbCBub3JtYWwNCj4gYWNvdXN0aWMgcmVhZGluZ3MuDQo+ICAgIC0g
MjEgZGF5dGltZSBzdXNwZW5kcyBhY3Jvc3MgMyBkYXlzIG9uIDcuMC4wLTM0OiBhbGwgbm9ybWFs
IGFjb3VzdGljDQo+IHJlYWRpbmdzLg0KPiAyLiBQcm9sb25nZWQgczJpZGxlIHN1c3BlbmRzIHJl
cHJvZHVjaWJseSBsYXRjaCB0aGUgZmFpbHVyZSB1cG9uIHJlc3VtZToNCj4gICAgLSBPbiA2Ljgu
MC0xMzk6IFJhaWxlZCBpbW1lZGlhdGVseSB1cG9uIHdha2luZyBmcm9tIGFuIDhoIDQ3bSBvdmVy
bmlnaHQNCj4gc2xlZXAuDQo+ICAgIC0gT24gNy4wLjAtMzE6IFJhaWxlZCBpbW1lZGlhdGVseSB1
cG9uIHdha2luZyBmcm9tIGEgMTZoIDEybSB3ZWVrZW5kDQo+IHNsZWVwLg0KPiAgICAtIE9uIDcu
MC4wLTMxOiBSYWlsZWQgYWdhaW4gdXBvbiB3YWtpbmcgZnJvbSBhIDJoIDQybSBldmVuaW5nIHNs
ZWVwLg0KPg0KPiBPQlNFUlZFRCBGQUlMVVJFIFNJR05BVFVSRVMNCj4gQ2FwdHVyZSBzdGFydHMg
YW5kIERNQSBhZHZhbmNlcyBhdCA0OCBrSHogUzMyX0xFIHdpdGhvdXQgZXJyb3IsIGJ1dCBhdWRp
bw0KPiBkYXRhIGlzIGZyb3plbjoNCj4gLSBVbmRlciBrZXJuZWwgNi44OiBFdmVyeSBzYW1wbGUg
aXMgcGlubmVkIHRvIG5lZ2F0aXZlIGZ1bGwtc2NhbGUNCj4gKDB4ODAwMDAwMDAgLyBJTlQzMl9N
SU4pOiB1bmlxPTEsIGZ1bGwtc2NhbGU9MTAwLjAlLCBEQz0tMS4wMDAwLA0KPiBBQy1STVM9MC4w
MDAwMA0KPiAtIFVuZGVyIGtlcm5lbCA3LjA6IEV2ZXJ5IHNhbXBsZSBpcyBwaW5uZWQgdG8gYSBz
dGF0aWMgY29uc3RhbnQgdmFsdWUNCj4gKC0wLjgzMzcgLyAweDk1NDk1MTgzKTogdW5pcT0xLCBm
dWxsLXNjYWxlPTAuMCUsIERDPS0wLjgzMzcsIEFDLVJNUz0wLjAwMDAwDQo+DQo+IFNURVBTIFRP
IFJFUFJPRFVDRQ0KPiAxLiBFbnN1cmUgaW50ZXJuYWwgbWljIGlzIHdvcmtpbmcgbm9ybWFsbHkg
KHJlY29yZCBzYW1wbGUgdmlhIGFyZWNvcmQgb3INCj4gcHctcmVjb3JkKS4NCj4gMi4gUHV0IG1h
Y2hpbmUgaW50byBzMmlkbGUgc3VzcGVuZCBmb3IgPjPigJM4IGhvdXJzIChlLmcuIG92ZXJuaWdo
dCBzbGVlcCkuDQo+IDMuIFdha2UgbWFjaGluZSBhbmQgcmVjb3JkIGZyb20gdGhlIEFDUDYzIERN
SUM6DQo+ICAgIGFyZWNvcmQgLUQgaHc6Q0FSRD1hY3A2MyxERVY9MCAtZiBTMzJfTEUgLWMgMiAt
ciA0ODAwMCAtZCAzDQo+IC90bXAvdGVzdC53YXYNCj4gNC4gSW5zcGVjdCBzYW1wbGVzIGluIC90
bXAvdGVzdC53YXYuDQo+DQo+IEVYUEVDVEVEDQo+IE5vcm1hbCBhbWJpZW50IGF1ZGlvIHdpdGgg
dGhvdXNhbmRzIG9mIGRpc3RpbmN0IHNhbXBsZSB2YWx1ZXMgYW5kIEFDLVJNUyA+DQo+IDAuDQo+
DQo+IEFDVFVBTA0KPiBFdmVyeSBzaW5nbGUgc2FtcGxlIGluIHRoZSBidWZmZXIgY29udGFpbnMg
dGhlIGlkZW50aWNhbCAzMi1iaXQgaW50ZWdlcg0KPiB2YWx1ZS4gQUMtUk1TIGlzIDAuMDAwMDAu
IGRtZXNnIHNob3dzIHplcm8gZXJyb3JzIG9yIHdhcm5pbmdzIGZyb20NCj4gc25kX3BjaV9wcyBv
ciBzbmRfcHNfcGRtX2RtYS4NCj4NCj4gRkFJTEVEIFJFQ09WRVJZIEFUVEVNUFRTIChXSElMRSBJ
TiBSQUlMRUQgU1RBVEUpDQo+IDEuIE1vZHVsZSByZWxvYWQ6IFN0b3BwaW5nIFBpcGVXaXJlLCBy
dW5uaW5nIGBtb2Rwcm9iZSAtciBzbmRfc29jX3BzX21hY2gNCj4gc25kX3BzX3BkbV9kbWEgc25k
X3NvY19kbWljIHNuZF9wY2lfcHNgLCBhbmQgcmVsb2FkaW5nIGRvZXMgTk9UIHJlc3RvcmUNCj4g
c2lnbmFsLiBDYXB0dXJlZCBkYXRhIHJlbWFpbnMgY29uc3RhbnQuDQo+IDIuIFBDSSBmdW5jdGlv
biB1bmJpbmQvcmVzY2FuOiBTdG9wcGluZyBhdWRpbywgaXNzdWluZyBgZWNobyAxID4NCj4gL3N5
cy9idXMvcGNpL2RldmljZXMvMDAwMDo2NDowMC41L3JlbW92ZWAsIHNsZWVwaW5nLCBhbmQgaXNz
dWluZyBgZWNobyAxID4NCj4gL3N5cy9idXMvcGNpL3Jlc2NhbmAgcmUtcHJvYmVzIGNsZWFubHks
IGJ1dCBjYXB0dXJlIHJlbWFpbnMgZnJvemVuLg0KPiAzLiBIYXJkd2FyZSBQb3dlci1DeWNsZTog
QSBmdWxsIHBsYXRmb3JtIHJlYm9vdCBvciBwb3dlci1kb3duIGNsZWFycyB0aGUNCj4gbGF0Y2gg
YW5kIHJlc3RvcmVzIDEwMCUgbm9ybWFsIG9wZXJhdGlvbi4NCj4NCj4gUk9PVCBDQVVTRSBBTkFM
WVNJUw0KPiBCZWNhdXNlIHRoZSBBQ1A2MyBhdWRpbyBjb3Byb2Nlc3NvciBpcyBpbnRlZ3JhdGVk
IG9uIHRoZSBBUFUgc2lsaWNvbiwNCj4gdW5iaW5kaW5nIHRoZSBMaW51eCBQQ0kgZW5kcG9pbnQg
ZG9lcyBub3QgY3ljbGUgc2lsaWNvbiBwb3dlciBvciBwZXJmb3JtIGENCj4gRnVuY3Rpb24tTGV2
ZWwgUmVzZXQgKEZMUikuIER1cmluZyBkZWVwIFNvQyBwb3dlciBzdGF0ZXMgKHMwaXggLyBNb2Rl
cm4NCj4gU3RhbmRieSkgYWNyb3NzIGV4dGVuZGVkIGlkbGUgcGVyaW9kcywgdGhlIGhhcmR3YXJl
IFBETSBjbG9jayBnZW5lcmF0b3Igb3INCj4gRklGTyBzdGF0ZSBtYWNoaW5lIGRyb3BzIG91dCBv
ciBkZXN5bmNocm9uaXplcywgYW5kIHRoZSBkcml2ZXIncyByZXN1bWUNCj4gc2VxdWVuY2UgZmFp
bHMgdG8gcmUtY2xvY2svcmUtYXJtIHRoZSBBQ1AgaGFyZHdhcmUgcmVnaXN0ZXJzLg0KPg0KPiBX
T1JLQVJPVU5EDQo+IENvbmZpZ3VyZSBzeXN0ZW1kIGZvciBgc3VzcGVuZC10aGVuLWhpYmVybmF0
ZWAgKHNsZWVwaW5nIGluIHMyaWRsZSBmb3IgdXANCj4gdG8gMiBob3VycywgdGhlbiB0cmFuc2l0
aW9uaW5nIHRvIFM0IGhpYmVybmF0aW9uIGZvciBsb25nIHNsZWVwcykuIFM0DQo+IGhpYmVybmF0
aW9uIHBvd2VyLWN5Y2xlcyB0aGUgcGxhdGZvcm0gb24gd2FrZSwgY2xlYW5seSByZWluaXRpYWxp
emluZyB0aGUNCj4gQUNQIGNvcHJvY2Vzc29yIHdoaWxlIHByZXNlcnZpbmcgb3BlbiBkZXNrdG9w
IHNlc3Npb25zLg0KPg0K
