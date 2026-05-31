Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ABECD6E4C
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:11:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CE6960224;
	Mon,  1 Jun 2026 10:11:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CE6960224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780301506;
	bh=Nn6D0YUhFmInbLYrv7zu3TVusy1pv3rFJTR1yQrr/eo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uGxhdcGCLXMFwP1S3sfK01D87e6Lm6r+OHDsMXMTXHkA9V1e0JYU9B40AB1nouIXZ
	 Hh7nX/Ll9E3kojI+w01Tv24BeOoTpqGv9SrcSsTpGxBF8okZOKxeddVpvjAApytJjy
	 Mj8sjJxj59UWNHEI7zQ6m3Z80B0zsB4+KKEn+fF0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C8334F80611; Mon,  1 Jun 2026 10:11:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 852A3F80618;
	Mon,  1 Jun 2026 10:11:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 544D0F805B0; Sun, 31 May 2026 04:52:20 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 84B5CF80075
	for <alsa-devel@alsa-project.org>; Sun, 31 May 2026 04:52:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84B5CF80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oeWwpHyT
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-5174a3a025aso3321431cf.3
        for <alsa-devel@alsa-project.org>;
 Sat, 30 May 2026 19:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780195936; cv=none;
        d=google.com; s=arc-20240605;
        b=XMG8yZ9bpd7+Y5TO4h3RqDq89QrXQ8GE7lbGNCSlW9lAss7VOs0P4s1ppIYAymIbn7
         YD+wrMBvwuNoRLo0e9R+Mcb8/6O2tDNoZHD4l8pheweeiNUCEDd+9rTgSyYGyefMpBF8
         MpDUAULYawJrNrfnfCzRMru92fNjwbtRIVrcbPGD7YS8k9ANWJ52ULl+/tfxM8IrsPwh
         /pW/Ve2zDGRc2MEqsTfxHTsiqvlvD+1A0j4CVkLgpxkCLZr9XAEk06JtjgEutFOpG5On
         vvVocLFcurm2UeY5Lw2nHpJ3NGn88qH7VtEKjtf/GYE0+zZmqwAxA1Q8ry/NZHd2QHMB
         RXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vInd+1FIA3N9r7rLqdc6axovCs49LiIbWObxyFESfyE=;
        fh=tgiQ08B9kXMIqv5vLNfGzTgTczcItztreWw0nO39nqs=;
        b=jQBd60P2+dNY8w9Skm/osCn6y2N2o6m3af4ok+484QplYikxcNfS+Stpwa4IEgU9D3
         TOherDFwf3CgJLDSw1Y2vnrOnRUEOr7anTHC8jwHNz2kolPyazKfyB94GKp1BvAnH24g
         XrsLw064bERF+KImbZj4jZIdrG6NZ+FqI6Wum8/5bye996U0QxY6qUUaRnmINTfABgkO
         dJhE/C0koxD/w/zfBnXbgJMMQZ/1SBKPgcvEilednPCBWq2xOeXqm1j90duesv7Q6W0A
         pru0ttlEbH6QzVbloALTHKxwrW0Zl4rGF02Xe6fPT6kde344cagpSuXLWFJDOMxrdUrV
         0DtA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780195936; x=1780800736;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vInd+1FIA3N9r7rLqdc6axovCs49LiIbWObxyFESfyE=;
        b=oeWwpHyTpfYOwRUHiO5morhT3jD1aAc0Ymkrft4cmvfwncdHsqbwIvFt/F+YVpaxKW
         rq95Qb+AJW/DzMxUPa/4qcliIoZb6swlMvnSvgUH3ZpCLEX6ntDJ9JORZMvYRAkFlqBo
         SMidyLmMbrUFhxnIzsVq37TY+9kRe4YJiRMcNCVa48LHeD1REKz6vVALEAcIbCcZcKfV
         56CaAoJQ/tq9N/I3j4roQJY4JsVkPHaV0tk3fV0+N7N2iYsXsd3VVmqHwNwxoWhEPkjY
         8+FxYKr6b0+ZVGv7uKk7wyap0hMGEH7yVeovZROieFhHH7LU4DkTOJhA+1RdzM7P3E5F
         opXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780195936; x=1780800736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vInd+1FIA3N9r7rLqdc6axovCs49LiIbWObxyFESfyE=;
        b=VvIqG4EkNkPGhLfKRpTcy2nSQpurGOcMTgWtZist7PwED8CgqESrcnZg9KeqQsTKVT
         QvI70Un2Z8wC6Mwu+KZS7WwFDy7sl9WOkzuFMdh/CtpS3EHZMErtfdvoMhfoIimnSYSP
         cErh1UbtQCBKObSI/ZTTUfN5XoI+m19OrTlEdXBLySSOAWLJbmB6d6Z/ux4hSuM6r8ez
         4mr7AxKNgKrgXg8meXpWAqPuHVjo77qbwNFIMd/SUY33a5czMZqsTChJfwo57Sqt20uN
         YoCn2/ePBr2Y6qGYU5EldusC4wLyZTnYtxy5P1cC51c+ZKfqpnRPX1uQocqMMOqR00ns
         WPxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/83FFs4MWX6lvuOq5JNjTB6MmGcBcpoUc36AW1LVgkJhfrcdQVM0V+m/3JzmcaHV7r8umxt316DvzG@alsa-project.org
X-Gm-Message-State: AOJu0Yxph5eRh0DUd2ePSIRCxcTRpBPbWfZMZtawVqtlEjI+nv6RfyNu
	Ko4GB2PnICRgfl1xGE6/uNlQ9gvPZAp4MMJOT8/Q9ZJ79zWBcF8BHnK6H6ryIe9dBk67+BfwFhC
	ZhNM6A8X4jdJ461kP1c0J2AXhFlxB+QI=
X-Gm-Gg: Acq92OE3Plyx/5ZH/TeSlyDLzQ4O1Kv1ZyLbs9nCPiKWGNViJhNnZ1KeKDdbB2AaaF2
	vLezJ2T/QsC/jWa6mgcED3Hiuu5D54xgKXTLcxX/5NVMTWZHgADsiJqCvuujwimLAMTnKo5lnFz
	E0FEYz2EefuzC5cMtA7Nq2xXdywGTUnL4sIN7zNWuhzgDwAccvy9Yb3TX/IDpY1rEguinsLAY0V
	I/Bbxf/MY6DWFpLEt0phtdVFVjAPTqAND//SBVx7rRcfFC2oRtGuHXyZezJHPaLbamukVoTx0E2
	V6GwlEDaleXDmCQrlbvJeJ9zstI=
X-Received: by 2002:a05:622a:d0e:b0:510:138e:b83c with SMTP id
 d75a77b69052e-5173a817a21mr63047151cf.33.1780195935657; Sat, 30 May 2026
 19:52:15 -0700 (PDT)
MIME-Version: 1.0
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
 <87y0h2r3g6.wl-tiwai@suse.de>
In-Reply-To: <87y0h2r3g6.wl-tiwai@suse.de>
From: =?UTF-8?B?5ZGoT2NlYW4=?= <zhouoceanhy@gmail.com>
Date: Sun, 31 May 2026 10:52:03 +0800
X-Gm-Features: AVHnY4JQpta9oPzbOlsAHd7Gakpa-13UbWhtgAXcYZBP2pdVS982cFBJNOo_nEY
Message-ID: 
 <CACYx1SrnTfg6GKK2S1Vb13f9OWOq1x=VUDA=AFWs1CALsC_B2g@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
X-MailFrom: zhouoceanhy@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: YTGNGJH43ZRE5XXVURJYPVQXQBKQUUN4
X-Message-ID-Hash: YTGNGJH43ZRE5XXVURJYPVQXQBKQUUN4
X-Mailman-Approved-At: Mon, 01 Jun 2026 08:11:02 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YTGNGJH43ZRE5XXVURJYPVQXQBKQUUN4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgVGFrYXNoaSwNCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJlcGx5IGFuZCBwcm9mZXNzaW9u
YWwgZ3VpZGFuY2UhDQoNCkhlcmUgaXMgdGhlIG9yaWdpbmFsIHRvcG9sb2d5IG9mIENvbmV4YW50
IENYMjA2MzIgKFNTSUQgMjAxNDo4MDA0KSBvbiBGRVZNDQpGQTg4MCBQUk86DQoNCi0gTm9kZSAw
eDE0IFtBdWRpbyBJbnB1dF0gKEFuYWxvZyBDYXB0dXJlKQ0KICBDb25uZWN0aW9uOiA0DQogICAg
IDB4MWEgMHgxYiAweDFkIDB4MWUqICAgKE5vdGU6IDB4MWUgaXMgc2VsZWN0ZWQgYnkgZGVmYXVs
dCkNCg0KLSBOb2RlIDB4MWUgW1BpbiBDb21wbGV4XSAoSW50ZXJuYWwgTWljKQ0KICBQaW4gRGVm
YXVsdCAweDk1YTYwMTIwOiBbRml4ZWRdIE1pYyBhdCBJbnQgVG9wDQogIENvbm5lY3Rpb246IE5v
bmUgKEl0J3MgYSBkaWdpdGFsL2ZpeGVkIG1pYyBwaW4pDQoNCi0gTm9kZSAweDFhIFtQaW4gQ29t
cGxleF0gKEZyb250IE1pYyk6IFBpbiBEZWZhdWx0IDB4MDJhMTEwM2UNCi0gTm9kZSAweDFiIFtQ
aW4gQ29tcGxleF0gKFJlYXIgTWljKTogUGluIERlZmF1bHQgMHgwMWExMzAzMA0KDQpSZWdhcmRp
bmcgdGhlIGtlcm5lbCBjcmFzaCwgSSBlbmNvdW50ZXJlZCBhIGtlcm5lbCBPb3BzIGluDQp0cnlf
YXNzaWduX2RhY3MoKSBkdXJpbmcgdGhlIGF1dG8tY29uZmlnIHN0YWdlIG9uIHRoZSBuZXdlciA3
LjAuMTAtY2FjaHlvcw0Ka2VybmVsLiBJIHN1c3BlY3QgaXQgbWlnaHQgYmUgdHJpZ2dlcmVkIHdo
ZW4gbG9hZGluZyBteSBvdXQtb2YtdHJlZSBjdXN0b20NCkRLTVMgbW9kdWxlLCBvciBkdWUgdG8g
Y2hhbmdlcyBpbiBob3cgdHJ5X2Fzc2lnbl9kYWNzKCkgaW50ZXJhY3RzIHdpdGggdGhpcw0Kc3Bl
Y2lmaWMgdG9wb2xvZ3kgb24gdGhlIG5ldyBrZXJuZWwuIChGb3J0dW5hdGVseSwgdGhlIHN5c3Rl
bSB3b3Jrcw0KcGVyZmVjdGx5IGZpbmUgb24gdGhlIDYuMTgtbHRzIGtlcm5lbCB3aXRoIG15IGN1
c3RvbSBtb2R1bGUpLg0KDQpJbiB0aGUgb2xkZXIga2VybmVsIChsaWtlIDYuMTgpLCB0aGUgYXV0
by1wYXJzZXIgZGlkbid0IGNyYXNoIGJ1dCB3b3VsZA0KaW5jb3JyZWN0bHkgcm91dGUgTm9kZSAw
eDE0IGF3YXkgZnJvbSBOb2RlIDB4MWUgYWZ0ZXIgcHJvYmluZywgZGlzYWJsaW5nDQp0aGUgaW50
ZXJuYWwgbWljcm9waG9uZS4gVGhhdCB3YXMgd2h5IG15IHByZXZpb3VzIHBhdGNoIGZvcmNlZCBp
bmRleCAweDAzDQpvbiBOb2RlIDB4MTQgaW4gSERBX0ZJWFVQX0FDVF9JTklULg0KDQpTaW5jZSB5
b3UgbWVudGlvbmVkIGNvcnJlY3RpbmcgdGhlIHJvdXRlcyBiZWZvcmUgcGFyc2luZywgc2hvdWxk
IHdlDQpvdmVycmlkZSB0aGUgY29ubmVjdGlvbiBsaXN0IG9mIE5vZGUgMHgxNCB0byByZXN0cmlj
dCBpdCBkdXJpbmcNCkhEQV9GSVhVUF9BQ1RfUFJFX1BST0JFLCBvciBvdmVycmlkZSB0aGUgcGlu
IGRlZmF1bHQgY29uZmlndXJhdGlvbiB2aWENCkhEQV9GSVhVUF9QSU5TIHRvIGZpeCB0aGlzIHBy
b3Blcmx5Pw0KDQpJIHdvdWxkIHJlYWxseSBhcHByZWNpYXRlIHlvdXIgYWR2aWNlIG9uIGhvdyB3
ZSBzaG91bGQgY29uc3RydWN0IHRoZSBmaXh1cA0KZ3JhY2VmdWxseSENCg0KVGhhbmtzIGFnYWlu
LA0KDQpPY2Vhbg0KDQpUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+IOS6jjIwMjblubQ15pyI
Mjnml6XlkajkupQgMTc6MDXlhpnpgZPvvJoNCg0KPiBPbiBGcmksIDI5IE1heSAyMDI2IDA2OjEx
OjQ3ICswMjAwLA0KPiBvY2VhbiB3cm90ZToNCj4gPg0KPiA+IEZyb206IE9jZWFuIFpob3UgPDUx
OTgzMjE1K29jZWFuLXN1ZG9AdXNlcnMubm9yZXBseS5naXRodWIuY29tPg0KPiA+DQo+ID4gRkVW
TSBGQTg4MCBQUk8gbWluaSBQQyB1c2VzIENvbmV4YW50IENYMjA2MzIgY29kZWMuIFRoZSBpbnRl
cm5hbA0KPiA+IG1pY3JvcGhvbmUgaXMgY29ubmVjdGVkIHRvIHBpbiAweDFlLiBJbiBvcmRlciB0
byBtYWtlIGl0IHdvcmssDQo+ID4gd2UgbmVlZCB0byBmb3JjZSBBREMgMHgxNCBjb25uZWN0aW9u
IHRvIDB4MWUgKGNvbm5lY3Rpb24gaW5kZXggMykuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMg
YSBuZXcgcXVpcmsgQ1hUX0ZJWFVQX0NYMjA2MzJfSU5UTUlDIHRvIGZvcmNlDQo+ID4gdGhlIGNv
bm5lY3Rpb24gc2VsZWN0aW9uIG9uIGluaXRpYWxpemF0aW9uLCBhbmQgYXBwbGllcyBpdA0KPiA+
IGZvciB0aGUgU1NJRCAyMDE0OjgwMDQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBPY2VhbiBa
aG91IDw1MTk4MzIxNStvY2Vhbi1zdWRvQHVzZXJzLm5vcmVwbHkuZ2l0aHViLmNvbT4NCj4NCj4g
SWYgYSBoYXJkLXdpcmUgaXMgbmVlZGVkLCB1c3VhbGx5IHdlIGNvcnJlY3QgdGhlIHJvdXRlcyBi
ZWZvcmUNCj4gcGFyc2luZyAoZS5nLiBjb3JyZWN0aW5nIHRoZSBjb25uZWN0aW9uIGxpc3QpLCBz
byB0aGF0IHRoZSBwYXJzZXINCj4gd291bGQgd2lyZSB2aWEgdGhlIGV4cGVjdGVkIHJvdXRlLg0K
Pg0KPiBIb3cgZG9lcyB0aGUgb3JpZ2luYWwgdG9wb2xvZ3kgbG9vayBsaWtlIGFuZCBob3cgaXQg
c2hvdWxkIGJlIGNoYW5nZWQ/DQo+DQo+DQo+IHRoYW5rcywNCj4NCj4gVGFrYXNoaQ0KPg0KPiA+
IC0tLQ0KPiA+ICBzb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMgfCAyMiArKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jDQo+IGIvc291
bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jDQo+ID4gaW5kZXggMmQ0MDk0YmU4M2FiLi41ZTIy
NzkyNjcxMDQgMTAwNjQ0DQo+ID4gLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5j
DQo+ID4gKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jDQo+ID4gQEAgLTMwMCw2
ICszMDAsNyBAQCBlbnVtIHsNCj4gPiAgICAgICBDWFRfUElOQ0ZHX1NXU19KUzIwMUQsDQo+ID4g
ICAgICAgQ1hUX1BJTkNGR19UT1BfU1BFQUtFUiwNCj4gPiAgICAgICBDWFRfRklYVVBfSFBfQV9V
LA0KPiA+ICsgICAgIENYVF9GSVhVUF9DWDIwNjMyX0lOVE1JQywNCj4gPiAgfTsNCj4gPg0KPiA+
ICAvKiBmb3IgaGRhX2ZpeHVwX3RoaW5rcGFkX2FjcGkoKSAqLw0KPiA+IEBAIC0zNDMsNiArMzQ0
LDE1IEBAIHN0YXRpYyB2b2lkIGN4dDUwNjZfaW5jcmVhc2VfbWljX2Jvb3N0KHN0cnVjdA0KPiBo
ZGFfY29kZWMgKmNvZGVjLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDAg
PDwgQUNfQU1QQ0FQX01VVEVfU0hJRlQpKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lk
IGN4dF9maXh1cF9jeDIwNjMyX2ludG1pYyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBoZGFfZml4dXAg
KmZpeCwgaW50DQo+IGFjdGlvbikNCj4gPiArew0KPiA+ICsgICAgIGlmIChhY3Rpb24gIT0gSERB
X0ZJWFVQX0FDVF9JTklUKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiAr
ICAgICAvKiBGb3JjZSBBREMgMHgxNCB0byBpbnRlcm5hbCBtaWMgcGluIDB4MWUgKGNvbm4gaW5k
ZXggMykuICovDQo+ID4gKyAgICAgc25kX2hkYV9jb2RlY193cml0ZShjb2RlYywgMHgxNCwgMCwg
QUNfVkVSQl9TRVRfQ09OTkVDVF9TRUwsIDB4MDMpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0
aWMgdm9pZCBjeHRfdXBkYXRlX2hlYWRzZXRfbW9kZShzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykN
Cj4gPiAgew0KPiA+ICAgICAgIC8qIFRoZSB2ZXJicyB1c2VkIGluIHRoaXMgZnVuY3Rpb24gd2Vy
ZSB0ZXN0ZWQgb24gYSBDb25leGFudA0KPiBDWDIwNzUxLzIgY29kZWMuICovDQo+ID4gQEAgLTEw
MzUsNiArMTA0NSwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBjeHRfZml4dXBz
W10gPSB7DQo+ID4gICAgICAgICAgICAgICAudHlwZSA9IEhEQV9GSVhVUF9GVU5DLA0KPiA+ICAg
ICAgICAgICAgICAgLnYuZnVuYyA9IGN4dF9maXh1cF9ocF9hX3UsDQo+ID4gICAgICAgfSwNCj4g
PiArICAgICBbQ1hUX0ZJWFVQX0NYMjA2MzJfSU5UTUlDXSA9IHsNCj4gPiArICAgICAgICAgICAg
IC50eXBlID0gSERBX0ZJWFVQX0ZVTkMsDQo+ID4gKyAgICAgICAgICAgICAudi5mdW5jID0gY3h0
X2ZpeHVwX2N4MjA2MzJfaW50bWljLA0KPiA+ICsgICAgIH0sDQo+ID4gIH07DQo+ID4NCj4gPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfcXVpcmsgY3h0NTA0NV9maXh1cHNbXSA9IHsNCj4gPiBA
QCAtMTE0MCw2ICsxMTU0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfcXVpcmsgY3h0NTA2
Nl9maXh1cHNbXSA9IHsNCj4gPiAgICAgICBTTkRfUENJX1FVSVJLKDB4MWMwNiwgMHgyMDExLCAi
TGVtb3RlIEExMDA0IiwNCj4gQ1hUX1BJTkNGR19MRU1PVEVfQTEwMDQpLA0KPiA+ICAgICAgIFNO
RF9QQ0lfUVVJUksoMHgxYzA2LCAweDIwMTIsICJMZW1vdGUgQTEyMDUiLA0KPiBDWFRfUElOQ0ZH
X0xFTU9URV9BMTIwNSksDQo+ID4gICAgICAgU05EX1BDSV9RVUlSSygweDFkMDUsIDB4MzAxMiwg
Ik1FQ0hSRVZPIFd1amllIDE1WCBQcm8iLA0KPiBDWFRfRklYVVBfSEVBRFNFVF9NSUMpLA0KPiA+
ICsgICAgIFNORF9QQ0lfUVVJUksoMHgyMDE0LCAweDgwMDQsICJGRVZNIEZBODgwIFBSTyIsDQo+
IENYVF9GSVhVUF9DWDIwNjMyX0lOVE1JQyksDQo+ID4gICAgICAgSERBX0NPREVDX1FVSVJLKDB4
Mjc4MiwgMHgxMmMzLCAiU2lyaXVzIEdlbjEiLA0KPiBDWFRfUElOQ0ZHX1RPUF9TUEVBS0VSKSwN
Cj4gPiAgICAgICBIREFfQ09ERUNfUVVJUksoMHgyNzgyLCAweDEyYzUsICJTaXJpdXMgR2VuMiIs
DQo+IENYVF9QSU5DRkdfVE9QX1NQRUFLRVIpLA0KPiA+ICAgICAgIHt9DQo+ID4gQEAgLTExNjUs
NiArMTE4MCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX21vZGVsX2ZpeHVwDQo+IGN4dDUw
NjZfZml4dXBfbW9kZWxzW10gPSB7DQo+ID4gICAgICAgeyAuaWQgPSBDWFRfUElOQ0ZHX1RPUF9T
UEVBS0VSLCAubmFtZSA9ICJzaXJpdXMtdG9wLXNwZWFrZXIiIH0sDQo+ID4gICAgICAgeyAuaWQg
PSBDWFRfRklYVVBfSFBfQV9VLCAubmFtZSA9ICJIUC1VLXN1cHBvcnQiIH0sDQo+ID4gKyAgICAg
eyAuaWQgPSBDWFRfRklYVVBfQ1gyMDYzMl9JTlRNSUMsIC5uYW1lID0gImN4MjA2MzItaW50bWlj
IiB9LA0KPiA+ICAgICAgIHt9DQo+ID4gIH07DQo+ID4NCj4NCg==
