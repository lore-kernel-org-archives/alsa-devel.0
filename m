Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E271F013D5
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:38:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C385601E3;
	Mon, 16 Mar 2026 09:38:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C385601E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773650293;
	bh=s7d/3qOwZn/BpScSVCtWRBUZXUnY1tJkkTgLNMlTLTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qPcOTyap6UeIqAzgmW53rCfimhOzZCUGIQLGFLPhy2vXtAbo7K/hhEu1eUQnVzhz7
	 BihK5On2ILVlzXiXG+VaS7TQuJlQqCT2OWsoAsbCjVYnsI9nobTrVd1yTrKju4HDlD
	 wKQ7WgQpBoPL/DTGC8+7HihqxY1Be36pD2B3BaO4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FE80F805F3; Mon, 16 Mar 2026 09:37:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B5630F805F5;
	Mon, 16 Mar 2026 09:37:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8407BF8058C; Sun, 15 Mar 2026 14:41:06 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EE25DF80424
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2026 14:41:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE25DF80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=UdpEvtht
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so606740266b.3
        for <alsa-devel@alsa-project.org>;
 Sun, 15 Mar 2026 06:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773582060; cv=none;
        d=google.com; s=arc-20240605;
        b=POP4bxZADkfNcMWiR7YDZHs17sZiz3JqdTpSHk6JeTxgVP8lSi+7JcD6p0ZlNufULu
         KXsuFL1PeEvSj2TaTwgmhxm22FH1F/10UKhIw0PHQRAL+YPxktcakGXEmIS/53FMlOnj
         ZoMTq/+W7JyI+kOJw/5uyEmUdH5P5teixh5dUGbNI6lWewH3J7iysZxh+tfWa2PFOOFP
         aKfAn/6futeNkkbD/YHasiOcHK/6wy5BieKCcqbeI3f7zp9CsQ6yUvt0E0RcSDnA4wiP
         7vYH4Lz1RIdV1lFyHvPLaKDnQ66u0LEIgHApwvldMkPPjIp9W/zwYFENYwwQR03e3arI
         xXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=69QJhNwkLLtcSXhp4G8Q8EPQju14b09GYbdvbr6KC2w=;
        fh=nns2Cbo2ICElywLc2cAytnqybMltj8nvhrzrSojBFBA=;
        b=DprQJtV3uyQFGXg/GVPQkbINmOsdYeaH2KzB0jRmN2LmZB10WoNc1+WX89s1sKEz5i
         2+4O08jghAWcZGRRyaOs4UgLdhkib9LFzS+S6IpvFGY9GsKIRRC668V5DD3tQQs9k1VU
         27E96676QsSnbNvHT81GlLdJFMhugM0hECHG9+I6qOmOhVHQzvur3r0W4xccnXr8O0ev
         yX2Mr5aSx6dC+XdQkxPjYnlHVCi7NLb+d4M5Jz8vLWvK/XXHWWXSxYvWklFCgHUMOYX+
         oecAdSm1S6AESdKkbgN9IqDNLOeUa+ApSUO25owlNSivtxC2vnJtHV3hL1Y/1wEF4UA5
         LeDA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773582060; x=1774186860;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=69QJhNwkLLtcSXhp4G8Q8EPQju14b09GYbdvbr6KC2w=;
        b=UdpEvthtn5Q0rdNeJLNI8voFDTfn0HGCsxFQzryKqREYuIbPvE7plufBRpl07SzJxD
         QvYzlPY5/HvPnUwSwJx+lTDiEL9aSMXDCkFhmcit2nZh0KVPC7hgcue5lUPczrH9PA8l
         uIoE01n3giwu6ZzJ+gLY1olHPBeqLdvresYNpswlHiSWlzzNaSQzvL10fX+JzxuUllbY
         SZE1aEPZ9YbazT+grgBriCIN1TVGAntBsjZqNYK9xLMcO5pMgV+WuJfkedSboUjcb4Qj
         iG1wsMun6bkm8qxUJ4RV+Eb1ctbYgAod8cLTJQ8L1nS49zRUWTlg2AEruPu8xl0OQDgG
         YncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773582060; x=1774186860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69QJhNwkLLtcSXhp4G8Q8EPQju14b09GYbdvbr6KC2w=;
        b=rD+075iDHMc+8PPo4o+xDEmIrB9fdGMDDbpns9zmZ1/w4FRcLMLdrw2cQ++aITKRgf
         iOyHeZr9Cvzelvmb6P2Dq53gk6lPctC4jD/oZ9QSzhdING58igI11M639r1/HsICDG8R
         sausHt7G6o/USH4/PdICwYb7XmKlJKUHZrRk17fs3LbH2A5xmqIzZSrW1BPtxX5F7xGN
         oMzm2w2yF4+PSxRkmvC7FiNeSBXiXLmHJQpzD4eF45LhkR1xQs3sTtnFov+siQZgahkM
         ZX0HFQe6AtGrv2ETNRop23UZ0fxyAfiWjiQgc1eCLwoFnn4nqQAypyCNLkFMkzUl/XuJ
         CTEA==
X-Gm-Message-State: AOJu0YxSiYfihf6tiZzlyjf0sPR2OUYbDGfP3onUKN2HuSvmv+b8MiIA
	eDaB+16giZmSBwZPuxVu6ki6Hpv6F16UQKmTF+xpSseapMd05zK+fT0kXqmYA4PhnKK/Ed0e4q9
	VhE3tZVrq8P4yw3+pte4MNqQFX0ABny4=
X-Gm-Gg: ATEYQzywFePayw1LZX7jN4SmVvE9bAqYLASF1pPRRV74Xexjz96+Lvneqr8Y8D1aMjf
	ZdOsow+Pk4htCYWxXGZNIlQqIlGENo/Le4vrluR54Jd9YvD0Et6CcG2IGLqXYqXMLl7/IK21CfF
	5qBRyDZDQrYXnkWOpdOzaMosqZrP8HFU95dIthPbf9fJ0MspSIvrmP113BFbAYmV3252oJEZijm
	Qi/kXeUWU2kwuBoTxNrPnqpsr51H8JA/Oo2G4uPQ0ADFquyAcgT09/Ca/FmUZUqikvryr+bfBW8
	ec/ksWk6sN8O/yo2QK58vSHt7pgM0Nt+y9ItfqI=
X-Received: by 2002:a17:906:99c5:b0:b83:95c8:15d0 with SMTP id
 a640c23a62f3a-b97653cd808mr559129466b.52.1773582059511; Sun, 15 Mar 2026
 06:40:59 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CACB9z7kjs8rhLstEc8fV29BCTb5dd881JwGozoKdO5cwCb=YwQ@mail.gmail.com>
 <fb2632ab-6afd-43c2-9c2e-6a160400fee0@cachyos.org>
In-Reply-To: <fb2632ab-6afd-43c2-9c2e-6a160400fee0@cachyos.org>
From: Andrzej Hankus <andrzejh07@gmail.com>
Date: Sun, 15 Mar 2026 14:40:48 +0100
X-Gm-Features: AaiRm51wQTh3qUZu-ydc6O6d38QVdC4djdbRGWfJDP0l5TCqoGzcQYQLwwFLaIU
Message-ID: 
 <CACB9z7=c_b47BpZBr_g=Z+xrVNbJt5MH6L+EVx2Mjf+R29bdvg@mail.gmail.com>
Subject: Re: ALSA Bug Report: TAS2781 speaker amps not working on ASUS ROG
 Strix SCAR 16 G635LX (2025)
To: Eric Naim <dnaim@cachyos.org>
Cc: alsa-devel@alsa-project.org
X-MailFrom: andrzejh07@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: OP2ZWXMWYJLDQO4K7H33YPGZPV5W6ZQG
X-Message-ID-Hash: OP2ZWXMWYJLDQO4K7H33YPGZPV5W6ZQG
X-Mailman-Approved-At: Mon, 16 Mar 2026 08:37:30 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OP2ZWXMWYJLDQO4K7H33YPGZPV5W6ZQG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8gRXJpYyENCg0KVGhhdCBoZWxwZWQuIFRoYW5rIHlvdSB2ZXJ5IG11Y2gNCg0KQ2hlZXJz
LA0KQW5kcnplag0KDQpPbiBGcmksIE1hciA2LCAyMDI2IGF0IDY6MzTigK9QTSBFcmljIE5haW0g
PGRuYWltQGNhY2h5b3Mub3JnPiB3cm90ZToNCg0KPiBIaSBBbmRyemVqLA0KPg0KPiBPbiAzLzEv
MjYgNTo0MyBQTSwgQW5kcnplaiBIYW5rdXMgd3JvdGU6DQo+ID4gSUhlbGxvLA0KPiA+IEkgd291
bGQgbGlrZSB0byByZXBvcnQgdGhlIGZvbGxvd2luZyBidWcuDQo+ID4NCj4gPiAjIyBTdW1tYXJ5
DQo+ID4NCj4gPiBJbnRlcm5hbCBzcGVha2VycyBwcm9kdWNlIG9ubHkgdGhpbiwgaGlnaC1waXRj
aGVkIGF1ZGlvICh0d2VldGVycyBvbmx5KQ0KPiBvbg0KPiA+IHRoZSBBU1VTIFJPRyBTdHJpeCBT
Q0FSIDE2IEc2MzVMWCAoMjAyNSBtb2RlbCkuIFRoZSBUQVMyNzgxIHdvb2Zlcg0KPiA+IGFtcGxp
ZmllcnMgYXJlIG5ldmVyIGluaXRpYWxpemVkIGJlY2F1c2UgdGhlIEhEQSBjb21wb25lbnQgYmlu
ZGluZw0KPiBiZXR3ZWVuDQo+ID4gdGhlIEFMQzI4NSBjb2RlYyBmaXh1cCBhbmQgdGhlIFRBUzI3
ODEgSTJDIHNpZGUtY29kZWMgZHJpdmVyIGZhaWxzDQo+IHNpbGVudGx5Lg0KPiA+DQo+ID4gIyMg
SGFyZHdhcmUNCj4gPg0KPiA+IC0gKipMYXB0b3A6KiogQVNVUyBST0cgU3RyaXggU0NBUiAxNiBH
NjM1TFggKDIwMjUpDQo+ID4gLSAqKlBsYXRmb3JtOioqIEludGVsIE1ldGVvciBMYWtlICg4MDAg
U2VyaWVzIEFDRSkNCj4gPiAtICoqQXVkaW8gQ29kZWM6KiogUmVhbHRlayBBTEMyODUNCj4gPiAt
ICoqUENJIFNTSUQ6KiogYDEwNDM6M2VmMGANCj4gPiAtICoqQW1wbGlmaWVyczoqKiBUZXhhcyBJ
bnN0cnVtZW50cyBUQVMyNzgxIMOXIDMgKEFDUEkgZGV2aWNlDQo+IGBUWE5XMjc4MTowMGApDQo+
ID4gLSAqKlNwZWFrZXIgbGF5b3V0OioqIDIgdHdlZXRlcnMgKEFMQzI4NSBkaXJlY3QpICsgMiB3
b29mZXJzIChUQVMyNzgxDQo+IHNtYXJ0DQo+ID4gYW1wcykNCj4gPg0KPiA+ICMjIFNvZnR3YXJl
DQo+ID4NCj4gPiAtICoqRGlzdHJvOioqIENhY2h5T1MNCj4gPiAtICoqS2VybmVsOioqIDYuMTku
NS0zLWNhY2h5b3MNCj4gPiAtICoqQXVkaW8gc2VydmVyOioqIFBpcGVXaXJlDQo+ID4NCj4gPiAj
IyBQcm9ibGVtIERlc2NyaXB0aW9uDQo+ID4NCj4gPiBUaGUga2VybmVsIGFwcGxpZXMgZml4dXAg
YDB4MTE5YCBmb3IgUENJIFNTSUQgYDEwNDM6M2VmMGAsIHdoaWNoIG1hcHMgdG8NCj4gPiBgQUxD
Mjg3X0ZJWFVQX1RBUzI3ODFfSTJDYC4gVGhlIGBzZXJpYWwtbXVsdGktaW5zdGFudGlhdGVgIGRy
aXZlcg0KPiA+IHN1Y2Nlc3NmdWxseSBjcmVhdGVzIDMgSTJDIHN1Yi1kZXZpY2VzIGZvciBgVFhO
VzI3ODE6MDBgLiBIb3dldmVyLCB0aGUNCj4gPiBUQVMyNzgxIEhEQSBJMkMgc2lkZS1jb2RlYyBk
cml2ZXIgKGBzbmRfaGRhX3Njb2RlY190YXMyNzgxX2kyY2ApIG5ldmVyDQo+ID4gYmluZHMgdG8g
YW55IG9mIHRoZSAzIEkyQyBkZXZpY2VzLiBUaGUgY29tcG9uZW50IG1hdGNoaW5nIGJldHdlZW4g
dGhlIEhEQQ0KPiA+IGNvZGVjIGFuZCB0aGUgc2lkZS1jb2RlYyBhcHBlYXJzIHRvIGZhaWwuDQo+
ID4NCj4gPiAjIyMgU3VzcGVjdGVkIFJvb3QgQ2F1c2UNCj4gPg0KPiA+IFRoZSBmaXh1cCBgQUxD
Mjg3X0ZJWFVQX1RBUzI3ODFfSTJDYCBjaGFpbnMgdG8gYHRhczI3ODFfZml4dXBfdGlhc19pMmNg
LA0KPiA+IHdoaWNoIHNldHMgdXAgSERBIGNvbXBvbmVudCBtYXRjaGluZyBmb3IgQUNQSSBJRCBg
VElBUzI3ODFgLiBIb3dldmVyLA0KPiB0aGlzDQo+ID4gbGFwdG9wIHVzZXMgdGhlIG9mZmljaWFs
IEFDUEkgSUQgYFRYTlcyNzgxYC4gVGhlIGZpeHVwIHNob3VsZCBpbnN0ZWFkIHVzZQ0KPiA+IGB0
YXMyNzgxX2ZpeHVwX3R4bndfaTJjYCB0byBtYXRjaCB0aGUgY29ycmVjdCBBQ1BJIElELg0KPiA+
DQo+ID4gIyMjIFByb3Bvc2VkIEZpeA0KPiA+DQo+ID4gVGhlIHF1aXJrIGVudHJ5IGZvciBTU0lE
IGAxMDQzOjNlZjBgIHNob3VsZCBwb2ludCB0byBhIGZpeHVwIHRoYXQgY2FsbHMNCj4gPiBgdGFz
Mjc4MV9maXh1cF90eG53X2kyY2AgaW5zdGVhZCBvZiBgdGFzMjc4MV9maXh1cF90aWFzX2kyY2As
IG9yDQo+ID4gYWx0ZXJuYXRpdmVseSBhIG5ldyBgQUxDMjg1X0ZJWFVQX0FTVVNfVEFTMjc4MV9U
WE5XX0kyQ2AgZml4dXAgc2hvdWxkIGJlDQo+ID4gY3JlYXRlZC4NCj4gPg0KPiA+IE90aGVyIG5l
YXJieSBBU1VTIFNTSUQgZW50cmllcyB0aGF0IHVzZSBgVFhOVzI3ODFgIGRldmljZXMgKGUuZy4s
DQo+ID4gYDEwNDM6M2VlMGAsIGAxMDQzOjNmMDBgLCBgMTA0MzozZjEwYCwgYDEwNDM6M2YyMGAs
IGAxMDQzOjNmMzBgKSBtYXkgaGF2ZQ0KPiA+IHRoZSBzYW1lIGlzc3VlLg0KPiA+DQo+ID4gIyMg
RGlhZ25vc3RpYyBFdmlkZW5jZQ0KPiA+DQo+ID4gIyMjIGRtZXNnIChyZWxldmFudCBsaW5lcykN
Cj4gPg0KPiA+IGBgYA0KPiA+IFsgICAxMy4yMDk2NjddIFNlcmlhbCBidXMgbXVsdGkgaW5zdGFu
dGlhdGUgcHNldWRvIGRldmljZSBkcml2ZXINCj4gPiBUWE5XMjc4MTowMDogZXJyb3IgLUVOWElP
OiBJUlEgaW5kZXggMCBub3QgZm91bmQNCj4gPiBbICAgMTMuMjA5NzU5XSBTZXJpYWwgYnVzIG11
bHRpIGluc3RhbnRpYXRlIHBzZXVkbyBkZXZpY2UgZHJpdmVyDQo+ID4gVFhOVzI3ODE6MDA6IGVy
cm9yIC1FTlhJTzogSVJRIGluZGV4IDAgbm90IGZvdW5kDQo+ID4gWyAgIDEzLjIwOTgxMF0gU2Vy
aWFsIGJ1cyBtdWx0aSBpbnN0YW50aWF0ZSBwc2V1ZG8gZGV2aWNlIGRyaXZlcg0KPiA+IFRYTlcy
NzgxOjAwOiBlcnJvciAtRU5YSU86IElSUSBpbmRleCAwIG5vdCBmb3VuZA0KPiA+IFsgICAxMy4y
MDk4MjddIFNlcmlhbCBidXMgbXVsdGkgaW5zdGFudGlhdGUgcHNldWRvIGRldmljZSBkcml2ZXIN
Cj4gPiBUWE5XMjc4MTowMDogSW5zdGFudGlhdGVkIDMgSTJDIGRldmljZXMuDQo+ID4gWyAgIDEz
LjY3MzQ2N10gc25kX2hkYV9jb2RlY19hbGMyNjkgaGRhdWRpb0MxRDA6IEFMQzI4NTogcGlja2Vk
IGZpeHVwDQo+IGZvcg0KPiA+IFBDSSBTU0lEIDEwNDM6M2VmMA0KPiA+IFsgICAxMy42NzM5NzRd
IHNuZF9oZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9DMUQwOiBhdXRvY29uZmlnIGZvciBBTEMyODU6
DQo+ID4gbGluZV9vdXRzPTIgKDB4MTQvMHgxNy8weDAvMHgwLzB4MCkgdHlwZTpzcGVha2VyDQo+
ID4gWyAzNTk5LjM4NTU0N10gdGFzMjc4MS1oZGEgaTJjLVRYTlcyNzgxOjAwLXRhczI3ODEtaGRh
LjA6DQo+ID4gdGFzZGV2aWNlX3BybWdfbG9hZDogRmlybXdhcmUgaXMgTlVMTA0KPiA+IGBgYA0K
PiA+DQo+ID4gTm90ZTogVGhlIGZpeHVwIG5hbWUgYWZ0ZXIgInBpY2tlZCBmaXh1cCIgaXMgYmxh
bmssIGJ1dCBmaXh1cCBJRCBgMHgxMTlgDQo+IElTDQo+ID4gYXBwbGllZCAoY29uZmlybWVkIHZp
YSBoZXhkdW1wIG9mIHRoZSBjb21waWxlZCBxdWlyayB0YWJsZSBpbiB0aGUga2VybmVsDQo+ID4g
bW9kdWxlKS4NCj4gPg0KPiA+ICMjIyBJMkMgZGV2aWNlcyBwcmVzZW50IGJ1dCB1bmJvdW5kDQo+
ID4NCj4gPiBgYGANCj4gPiAkIGxzIC9zeXMvYnVzL2kyYy9kZXZpY2VzLyB8IGdyZXAgVFhOVw0K
PiA+IGkyYy1UWE5XMjc4MTowMC10YXMyNzgxLWhkYS4wDQo+ID4gaTJjLVRYTlcyNzgxOjAwLXRh
czI3ODEtaGRhLjENCj4gPiBpMmMtVFhOVzI3ODE6MDAtdGFzMjc4MS1oZGEuMg0KPiA+DQo+ID4g
JCBscyAvc3lzL2J1cy9pMmMvZGV2aWNlcy9pMmMtVFhOVzI3ODE6MDAtdGFzMjc4MS1oZGEuMC9k
cml2ZXINCj4gPiBsczogY2Fubm90IGFjY2VzczogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0K
PiA+IChubyBkcml2ZXIgYm91bmQgdG8gYW55IG9mIHRoZSAzIGRldmljZXMpDQo+ID4gYGBgDQo+
ID4NCj4gPiAjIyMgRmlybXdhcmUgZmlsZXMgZXhpc3QNCj4gPg0KPiA+IGBgYA0KPiA+ICQgbHMg
L3Vzci9saWIvZmlybXdhcmUvVEFTMlhYWDNFRjAqDQo+ID4gL3Vzci9saWIvZmlybXdhcmUvVEFT
MlhYWDNFRjAwLmJpbi56c3QgLT4NCj4gPiB0aS9hdWRpby90YXMyNzgxL1RBUzJYWFgzRUYwMC5i
aW4uenN0DQo+ID4gL3Vzci9saWIvZmlybXdhcmUvVEFTMlhYWDNFRjAxLmJpbi56c3QgLT4NCj4g
PiB0aS9hdWRpby90YXMyNzgxL1RBUzJYWFgzRUYwMS5iaW4uenN0DQo+ID4gYGBgDQo+ID4NCj4g
PiAjIyMgVEFTMjc4MSBJMkMgZHJpdmVyIHN1cHBvcnRzIFRYTlcyNzgxDQo+ID4NCj4gPiBgYGAN
Cj4gPiAkIHN0cmluZ3Mgc25kLWhkYS1zY29kZWMtdGFzMjc4MS1pMmMua28gfCBncmVwIFRYTlcN
Cj4gPiBUWE5XMjc4MQ0KPiA+IGFsaWFzPWFjcGkqOlRYTlcyNzgxOioNCj4gPiBgYGANCj4gPg0K
PiA+ICMjIyBDb2RlYyBpbmZvDQo+ID4NCj4gPiBgYGANCj4gPiAkIGNhdCAvcHJvYy9hc291bmQv
Y2FyZDEvY29kZWMjMCB8IGhlYWQgLTYNCj4gPiBDb2RlYzogUmVhbHRlayBBTEMyODUNCj4gPiBB
ZGRyZXNzOiAwDQo+ID4gQUZHIEZ1bmN0aW9uIElkOiAweDEgKHVuc29sIDEpDQo+ID4gVmVuZG9y
IElkOiAweDEwZWMwMjg1DQo+ID4gU3Vic3lzdGVtIElkOiAweDEwNDMzZWYwDQo+ID4gUmV2aXNp
b24gSWQ6IDB4MTAwMDAyDQo+ID4gYGBgDQo+ID4NCj4gPiAjIyMgUmVsZXZhbnQgbG9hZGVkIG1v
ZHVsZXMNCj4gPg0KPiA+IGBgYA0KPiA+IHNuZF9oZGFfY29kZWNfYWxjMjY5DQo+ID4gc25kX2hk
YV9zY29kZWNfdGFzMjc4MV9pMmMNCj4gPiBzbmRfaGRhX3Njb2RlY190YXMyNzgxX3NwaQ0KPiA+
IHNuZF9oZGFfc2NvZGVjX3RhczI3ODENCj4gPiBzbmRfaGRhX3Njb2RlY19jb21wb25lbnQNCj4g
PiBzbmRfc29jX3RhczI3ODFfaTJjDQo+ID4gc25kX3NvY190YXMyNzgxX2Ztd2xpYg0KPiA+IHNu
ZF9zb2NfdGFzMjc4MV9jb21saWJfaTJjDQo+ID4gc25kX3NvY190YXMyNzgxX2NvbWxpYg0KPiA+
IGBgYA0KPiA+DQo+ID4gIyMgV2hhdCBoYXMgYmVlbiBydWxlZCBvdXQNCj4gPg0KPiA+IC0gUGlw
ZVdpcmUgaXMgd29ya2luZyBjb3JyZWN0bHkNCj4gPiAtIEFsbCBBTFNBIG1peGVyIGNoYW5uZWxz
IGFyZSB1bm11dGVkIGFuZCBhdCBmdWxsIHZvbHVtZQ0KPiA+IC0gQmFzcyBTcGVha2VyIHN3aXRj
aCBpcyBvbg0KPiA+IC0gVEFTMjc4MSBkcml2ZXIgbW9kdWxlcyBhcmUgbG9hZGVkDQo+ID4gLSBG
aXJtd2FyZSBmaWxlcyBmb3IgdGhpcyBTU0lEIGV4aXN0IGluIGxpbnV4LWZpcm13YXJlDQo+ID4g
LSBUaGlzIGlzIG5vdCBhIHVzZXJzcGFjZSBjb25maWd1cmF0aW9uIGlzc3VlDQo+ID4NCj4gPiAj
IyBTdGVwcyB0byBSZXByb2R1Y2UNCj4gPg0KPiA+IDEuIEluc3RhbGwgYW55IExpbnV4IGRpc3Ry
aWJ1dGlvbiBvbiBBU1VTIFJPRyBTdHJpeCBTQ0FSIDE2IEc2MzVMWCAoMjAyNSkNCj4gPiAyLiBC
b290IHdpdGgga2VybmVsIDYuMTkueA0KPiA+IDMuIE9ic2VydmUgb25seSB0d2VldGVyIG91dHB1
dCwgbm8gYmFzcy93b29mZXIgYXVkaW8NCj4gPiA0LiBDaGVjayBkbWVzZyBmb3IgYmxhbmsgZml4
dXAgbmFtZSBhbmQgIkZpcm13YXJlIGlzIE5VTEwiDQo+ID4gNS4gVmVyaWZ5IG5vIGRyaXZlciBp
cyBib3VuZCB0byB0aGUgVEFTMjc4MSBJMkMgZGV2aWNlcw0KPiA+DQo+ID4gIyMgQWRkaXRpb25h
bCBOb3Rlcw0KPiA+DQo+ID4gVGhlIGAtRU5YSU86IElSUSBpbmRleCAwIG5vdCBmb3VuZGAgZXJy
b3JzIGR1cmluZyBUWE5XMjc4MSBpbml0aWFsaXphdGlvbg0KPiA+ICgzIG9jY3VycmVuY2VzIGZv
ciAzIGRldmljZXMpIG1heSBiZSBhIHNlcGFyYXRlIEFDUEkgdGFibGUgaXNzdWUgYnV0IGRvDQo+
IG5vdA0KPiA+IHByZXZlbnQgZGV2aWNlIGluc3RhbnRpYXRpb24uDQo+ID4NCj4gPiBUaGUgIkZp
cm13YXJlIGlzIE5VTEwiIG1lc3NhZ2UgYXQgdGltZXN0YW1wIDM1OTlzICg2MCBtaW51dGVzIGFm
dGVyIGJvb3QpDQo+ID4gaW5kaWNhdGVzIGEgbGF0ZSBwbGF5YmFjayBhdHRlbXB0IHJlYWNoZWQg
dGhlIFRBUzI3ODEgY29kZSBwYXRoIGRlc3BpdGUNCj4gdGhlDQo+ID4gZHJpdmVyIG5ldmVyIGhh
dmluZyBwcm9wZXJseSBwcm9iZWQuDQo+DQo+IEkgbm90aWNlZCB0aGUgQUxDMjg3X0ZJWFVQX1RY
TlcyNzgxX0kyQyBxdWlyayBleGlzdHMgYW5kIGJ1aWx0IGEga2VybmVsDQo+IHdpdGggdGhlIG1v
ZGlmaWNhdGlvbnMuIENhbiB5b3UgcGxlYXNlIHRyeSBpdD8NCj4NCj4gTGluazogaHR0cHM6Ly9z
aGFyZS5jYWNoeW9zLm9yZy94ODZfNjRfdjMvYXN1cy8NCj4NCj4gLS0NCj4gUmVnYXJkcywNCj4g
ICBFcmljDQo+DQo=
