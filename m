Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFFDCD6E57
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:32:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2F126021D;
	Tue,  2 Jun 2026 15:31:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2F126021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780407124;
	bh=8joeQM2AkePgsOCm82o/HvZQ3q5bIebhCDVagrZ6pko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lnpfc48jEDbFCe6pTAabzrGLyNiiDr1Za+1MvfTFXhU3F1p7CO7aEzVq0VWSaTy4U
	 ydiebCRuxP/sNAV6m6QkBT6cA991HWfXXWcKsHdMcyU3NPej/SeDY6uR4B9prsIQmZ
	 dCFfntalGG468yT/BDR83SQRLA0YPUxQUwP0iiyQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D195BF8061B; Tue,  2 Jun 2026 15:31:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A21A4F80619;
	Tue,  2 Jun 2026 15:31:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75FE5F80553; Tue,  2 Jun 2026 15:16:18 +0200 (CEST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 14B82F8016E
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 15:16:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14B82F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SejWz+Ao
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-68d232e119dso2647041a12.0
        for <alsa-devel@alsa-project.org>;
 Tue, 02 Jun 2026 06:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780406175; cv=none;
        d=google.com; s=arc-20240605;
        b=cxf3BB0T0fHh6etb0pc1jUEMGocrBU7ptXPP9P5gHsAJlu4u6uEqqjpxw7r+lu+hb5
         eQrogxV07dVTvbWkmlzCuwS2DwBS6l0V4pZuz2fA1YJdwCqWSOr/hy8ctiH6Qj9e8Uwt
         DyDg0PZ4N5GosOgN1voey3mqmQNygAqhjFRz21x7DB6OmQVSRpe8BwDGv7CNHsaUowmk
         d6mO5jnmwSVOoWmPq8xeG5Rn2dl0in6CAYTCnGAjpgs3r78IjTM2WOnSUXGl77UPpyxX
         xNxHwfRBj04TAFTziEWHA0ESoKTSn6ln0lcUmGREVMyMdNlVg1ghqL/gzCcmGLTSvxDH
         rriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z+WcATizKkIHyy2CsTLuluju7i/O1NJPAMbc4POQX2s=;
        fh=ox6fBu44l5hPG5URFTSNVGjsvbOFzR06ylXFPmzDMH0=;
        b=MBJkm2VFtjbUsp7l0aVSsgSsYK9WOoOwZAMoukO7gHpCAflLQlsCBjsRTkg8Su9zrj
         WrR0maH6DYf7SnybgnSIPauX4z08cM6L2dAUTXISucOmSkNMc1Lusa25mhV5k99z7sOq
         pcUmK5sd+MmBfFPPPT+9FQ5O+bZEAk0UBwGy01PxlBnGuF06e8laz8KKJw981hqtfKNY
         kFYxORYD8nDtsBNRdOrxt/Je8mscVM0QN3gaAiFXxgF9TJ3yQ33JjI+mxormVO9EBGIt
         NMscas9gNl86hdXkZxTPv2sWHcNYahX4KYf3DWcvaGOvbFRijQtkLMbBdL2mTj48voxN
         zZqA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780406175; x=1781010975;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+WcATizKkIHyy2CsTLuluju7i/O1NJPAMbc4POQX2s=;
        b=SejWz+AoGK1ng44wwPRjyeWKCKZwGDBmW7k59Jo9eYzN6dXyyvw6y1tiqVZMRgIeol
         Wa5KZH1UYXWi3dKxLxpYuqfBmInUqWiQaeXLDX8zDjlMbV/4ruBExi0dMtFzJtHwrNfT
         yyZqig9V+iMcvGKEsv2hu6XZrLuwCwSJQur2jQxeOdOldoaEnLtPgZ+GLtLAeU6/+g/4
         fQCGIz3jSvxdFpug8MEUkImuNTIIVjDcWMEq4WEF2SICCklJ9wqPm7MW9I7kVevgmAx2
         SlnoR2owrtVuNHxfYiJFWtVVTo63dcc/7c9RC5icGx/+U+f45Y0uyWBocku8/ZwLvoWH
         K9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780406175; x=1781010975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+WcATizKkIHyy2CsTLuluju7i/O1NJPAMbc4POQX2s=;
        b=E6MfFTDUocMuaj9cxTF8UcN18aFFoUqhRREe3uduLGaeHp71ItHncyfbQnbrob7BW1
         vaW7b9Dr+Ckgs5nQEb8c8d10X7ZNvsqBX6Pq13a9fcseiGAjCRgtqBsc/Meu8gESSjiw
         EhX7JAVERUp6Jn/2SW7i09MtJw5ebE6NP6YUKepEnIEtLiJuhUZTTpYYWE0iLUjzgRe8
         hVY5sFFfm7gNDwS6n1D6gPpyrdpVe9IwZibOYgPSCg2Fn/nTjwjOn9TVQshVjvMQpgsj
         UxqobRDfOWnHXcA/b/mII8VuaKxM2B4nfW04EH45Lbt+Toq1HD4jpN1ibHQASIvdA/jg
         rq/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eeNfVFNmN9oZuAOzzxfRqVCJy7UItarV3PiA4S0t8w5o8JVl5RTMZMgV6LQhedsOwoHUihCMq2vAh@alsa-project.org
X-Gm-Message-State: AOJu0Ywnc2XCllPvQgAboA+ok8iOZxNSr4rAekX9Rv42x4Yr3YaFTfRc
	S1+DHQN7fxVZY+3bEqjyrJnLkf4utydTgyTA6C5PDuKH0iKjOft2aHmr5MK3fhUMXAfKD6Z3eR+
	91GU1CGGhlAiARDP4Y39fnLxxISkrV0I=
X-Gm-Gg: Acq92OHR/F1TCd06Xvf6VLLUhQ0aRTq2ud5S+RgOiFEBlNxGTG53uvcT+huBaHBN/pd
	qU6JXzrWoPs+z/wX4Su9CgVMK8aPDQqQQ8cuXE7x1UsCD+La5xEwJgithngZ35AgJagRgwF6Ejh
	yPAdLTDX+97k9JUhSUwyJlNujnrbRW370jDfvJV8u98vxXrdhqKKXjW3fv6cwr9yJprpgmE/AO+
	4488kUHjSH92pEzDACjUsqjkj9M7/C/PLZkCVfZxrrIi6FJGV5D3fxihGM/qXYoruHrLhtFZu9r
	kiBiTkz7tJy7QWQAE4ff9x4pSYd2fykd5CEf2BXDgT4DV4XEhbXV
X-Received: by 2002:a05:6402:358e:b0:68d:296d:9a34 with SMTP id
 4fb4d7f45d1cf-68d296d9dbbmr5429858a12.18.1780406174856; Tue, 02 Jun 2026
 06:16:14 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAFGAnONFP+=y3p2VQ_ciZzX_d=wjKP0jZf-JfVK1p1_EAz2ZXA@mail.gmail.com>
 <87a4tdyxx4.wl-tiwai@suse.de>
In-Reply-To: <87a4tdyxx4.wl-tiwai@suse.de>
From: Cliff Brady <brady725@gmail.com>
Date: Tue, 2 Jun 2026 08:16:02 -0500
X-Gm-Features: AVHnY4L9bCLhDCxRu_syElxeQlcX3vyN-iqg9MacKdhjeO49v9kfq5b5akILlio
Message-ID: 
 <CAFGAnONaqn20TDJ-4PnbpXe9UGaB3ZGYMkabrPozN+mhgrc6BA@mail.gmail.com>
Subject: Re: Creative X-Fi hw20k2 (SB0880) that appeared in kernel 6.12.85
To: Takashi Iwai <tiwai@suse.de>
Cc: linux@hohmatik.de, alsa-devel@alsa-project.org
X-MailFrom: brady725@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: AAUCC3DWRBFKMXOEKQHXE23VXIASRBXB
X-Message-ID-Hash: AAUCC3DWRBFKMXOEKQHXE23VXIASRBXB
X-Mailman-Approved-At: Tue, 02 Jun 2026 13:31:12 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AAUCC3DWRBFKMXOEKQHXE23VXIASRBXB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgVGFrYXNoaSwNCg0KVGhhbmsgeW91IGZvciB0aGUgcG9pbnRlciB0byA3LjAueC4gSSByZXZp
ZXdlZCB0aGUgcmVjZW50IGN0eGZpIGNvbW1pdHMgaW4NCmxpbnV4LTcuMC55IGFuZCBiZWxpZXZl
IGNvbW1pdCBlOTQxOGRhNTBkOWUgKCJBTFNBOiBjdHhmaTogTGltaXQgUFRQIHRvIGENCnNpbmds
ZSBwYWdlIikgaXMgdGhlIGZpeCBmb3IgbXkgaXNzdWUuIEhlcmUgaXMgd2h5IEkgYmVsaWV2ZSB0
aGlzIG1hdGNoZXMNCm15IHN5bXB0b21zOg0KDQoxLiBNeSBzeXN0ZW0gaXMgQU1ENjQsIHdoaWNo
IGlzIGV4YWN0bHkgdGhlIGFyY2hpdGVjdHVyZSB3aGVyZSB0aGUgcGFnZQ0KZmF1bHQgb2NjdXJz
IOKAlCBhIHNpbmdsZSBQVFAgcGFnZSBjb3ZlcnMgNTEyIFBURXMgKDJNQikgb24gQU1ENjQsIGFu
ZA0KYWdncmVnYXRlIG1tYXAgYWxsb2NhdGlvbnMgZnJvbSBQdWxzZUF1ZGlvIGV4Y2VlZCB0aGlz
IGxpbWl0Lg0KDQoyLiBhcGxheSAtbCBzaG93cyAyNTYgc3ViZGV2aWNlcyBvbiBteSBYLUZpIChj
YXJkIDAsIGRldmljZSAwLCBTdWJkZXZpY2VzOg0KMjU1LzI1NiksIGNvbmZpcm1pbmcgdGhhdCBj
b21taXQgMzkxZTY5MTQzZDBhICgiQnVtcCBwbGF5YmFjayBzdWJzdHJlYW1zIHRvDQoyNTYiKSBp
cyBhY3RpdmUgYW5kIENUX1BUUF9OVU0gd2FzIHNldCB0byA0IG9uIG15IHN5c3RlbS4NCg0KMy4g
UHVsc2VBdWRpbyBvcGVucyB0aGUgZGV2aWNlIGluIG1tYXArdGltZXIgbW9kZSAoZGV2aWNlLmFj
Y2Vzc19tb2RlID0NCiJtbWFwK3RpbWVyIikuIFdoZW4gaXQgZG9lcyBzbywgYXRjX3BjbV9wbGF5
YmFja19wcmVwYXJlKCkgLT4gY3Rfdm1fbWFwKCkNCmlzIGNhbGxlZCwgd2hpY2ggYWNjZXNzZXMg
YmV5b25kIHZtLT5wdHBbMF0uYXJlYSB3aGVuIGFsbG9jYXRpb25zIGV4Y2VlZA0KNTEyIFBURXMu
IFRoaXMgcHJvZHVjZXMgbm8gb29wcyB2aXNpYmxlIHRvIHVzZXJzcGFjZSDigJQgUEEgc2lsZW50
bHkgZ2V0cyBhDQpiYWQgbWFwcGluZyBhbmQgYXVkaW8gdHJhbnNmZXJzIGdvIG5vd2hlcmUuDQoN
CjQuIERpcmVjdCBBTFNBIGFjY2VzcyB2aWEgc3BlYWtlci10ZXN0ICh3aGljaCB1c2VzIHJlYWQv
d3JpdGUgbW9kZSwgbm90DQptbWFwKSB3b3JrcyBjb3JyZWN0bHkgb24gYWxsIDggYW5hbG9nIGNo
YW5uZWxzLCBjb25maXJtaW5nIHRoZSBoYXJkd2FyZSBhbmQNCmRyaXZlciBhcmUgb3RoZXJ3aXNl
IGZ1bmN0aW9uYWwuDQoNCjUuIEZvcmNpbmcgUHVsc2VBdWRpbyB0byBjbG9zZSBhbmQgcmVvcGVu
IHRoZSBQQ00gZGV2aWNlIHZpYSBwYWN0bA0Kc3VzcGVuZC1zaW5rIC8gcmVzdW1lLXNpbmsgcmVs
aWFibHkgcmVzdG9yZXMgYXVkaW8gZWFjaCB0aW1lLCBjb25zaXN0ZW50DQp3aXRoIHRoZSBhbGxv
Y2F0aW9uIHN0YXJ0aW5nIGZyZXNoIHdpdGhpbiB0aGUgc2luZ2xlLXBhZ2UgYm91bmRhcnkgb24g
YQ0KY2xlYW4gb3Blbi4NCg0KSSBhbHNvIG5vdGUgY29tbWl0IDk1YjFlZTg0NDJjYSAoIkFMU0E6
IGN0eGZpOiBBZGQgZmFsbGJhY2sgdG8gZGVmYXVsdCBSU1INCmZvciBTL1BESUYiLCBNYXkgNykg
aXMgYWxzbyBwcmVzZW50IGluIDcuMC55Lg0KDQpNeSB0ZXN0aW5nIGVudmlyb25tZW50IGlzIEhv
bWUgQXNzaXN0YW50IE9TIG9uIGRlZGljYXRlZCB4ODYtNjQgaGFyZHdhcmUsDQp3aGljaCBsaW1p
dHMgbXkgYWJpbGl0eSB0byB0ZXN0IGFyYml0cmFyeSBrZXJuZWwgYnVpbGRzIHdpdGhvdXQgc2ln
bmlmaWNhbnQNCmRpc3J1cHRpb24uIEkgY2FuIHRlc3Qgb25jZSB0aGUgZml4IGlzIGJhY2twb3J0
ZWQgdG8gNi4xMi54IHN0YWJsZSBhbmQNCnBpY2tlZCB1cCBieSBhIEhvbWUgQXNzaXN0YW50IE9T
IHJlbGVhc2UuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBpcw0KYW55IGFkZGl0aW9uYWwg
ZGlhZ25vc3RpYyBpbmZvcm1hdGlvbiBJIGNhbiBwcm92aWRlIGZyb20gdGhlIHJ1bm5pbmcgc3lz
dGVtDQppbiB0aGUgbWVhbnRpbWUuDQoNCkJlc3QgcmVnYXJkcywNCg0KQ2xpZmYNCg0KT24gVHVl
LCBKdW4gMiwgMjAyNiBhdCA2OjM44oCvQU0gVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiB3
cm90ZToNCg0KPiBPbiBUdWUsIDAyIEp1biAyMDI2IDEzOjMyOjQyICswMjAwLA0KPiBDbGlmZiBC
cmFkeSB3cm90ZToNCj4gPg0KPiA+DQo+ID4gSGkgVGFrYXNoaSwNCj4gPg0KPiA+IEknbSB3cml0
aW5nIHRvIHJlcG9ydCBhIHJlZ3Jlc3Npb24gb24gdGhlIENyZWF0aXZlIFgtRmkgaHcyMGsyIChT
QjA4ODApDQo+IHRoYXQNCj4gPiBhcHBlYXJlZCBpbiBrZXJuZWwgNi4xMi44NSwgYW5kIHdoaWNo
IEkgYmVsaWV2ZSBpcyByZWxhdGVkIHRvIGNvbW1pdA0KPiA+IGIwNDVhYjNkZmY5NyAoIkFMU0E6
IGN0eGZpOiBGaXggbWlzc2luZyBTUERJRkkxIGluZGV4IGhhbmRsaW5nIikuDQo+ID4NCj4gPiBI
YXJkd2FyZToNCj4gPiAgIENhcmQ6IENyZWF0aXZlIFgtRmkgMjBLMiwgbW9kZWwgU0IwODgwIChQ
Q0kgSUQgMTEwMjowMDBiKQ0KPiA+ICAgRHJpdmVyOiBzbmRfY3R4ZmkNCj4gPiAgIEtlcm5lbDog
Ni4xMi44NSAoSG9tZSBBc3Npc3RhbnQgT1MgMTcuMywgZ2VuZXJpYyB4ODYtNjQpDQo+ID4NCj4g
PiBTeW1wdG9tOg0KPiA+IEFmdGVyIHVwZ3JhZGluZyBmcm9tIEhBT1MgMTcuMiAoa2VybmVsIDYu
MTIuNzcpIHRvIEhBT1MgMTcuMyAoa2VybmVsDQo+IDYuMTIuODUpLA0KPiA+IHRoZSBYLUZpIGFu
YWxvZyBvdXRwdXRzIHByb2R1Y2Ugbm8gYXVkaW8gd2hlbiBhY2Nlc3NlZCB2aWEgUHVsc2VBdWRp
by4NCj4gSEFPUw0KPiA+IDE3LjEgKGtlcm5lbCA2LjEyLjY3KSBYLUZpIGFuYWxvZyBvdXRwdXRz
IGFsc28gIHN1Y2Nlc3NmdWxseSBwcm9kdWNlZA0KPiBhdWRpbw0KPiA+IHdoZW4gYWNjZXNzZWQg
dmlhIFB1bHNlQXVkaW8gIFRoZSBQQSBzaW5rIHJlcG9ydHMgUlVOTklORyBhbmQgYWxsIEFMU0EN
Cj4gbWl4ZXINCj4gPiBjb250cm9scyBhcmUgYXQgZnVsbCB2b2x1bWUgYW5kIHVubXV0ZWQsIGJ1
dCBubyBhdWRpbyBpcyBoZWFyZCBmcm9tIGFueQ0KPiBhbmFsb2cNCj4gPiBvdXRwdXQgY2hhbm5l
bCAoZnJvbnQsIHJlYXIsIHNpZGUsIGNlbnRlci9MRkUpLg0KPiA+DQo+ID4gRGlhZ25vc2lzOg0K
PiA+IFBBIG9wZW5zIHRoZSBkZXZpY2Ugd2l0aCBkZXZpY2UuYWNjZXNzX21vZGUgPSAibW1hcCt0
aW1lciIuIERpcmVjdCBBTFNBDQo+IGFjY2Vzcw0KPiA+IHZpYSBzcGVha2VyLXRlc3QgYnlwYXNz
aW5nIFBBIHByb2R1Y2VzIGF1ZGlvIGNvcnJlY3RseSBvbiBhbGwgY2hhbm5lbHMuDQo+ID4gRm9y
Y2luZyBQQSB0byBjbG9zZSBhbmQgcmVvcGVuIHRoZSBQQ00gZGV2aWNlIHZpYSBwYWN0bCBzdXNw
ZW5kLXNpbmsgLw0KPiA+IHJlc3VtZS1zaW5rIHJlc3RvcmVzIGF1ZGlvLCBzdWdnZXN0aW5nIHRo
ZSBtbWFwIGJ1ZmZlciBoYW5kc2hha2UgYmV0d2Vlbg0KPiBQQQ0KPiA+IGFuZCB0aGUgY3R4Zmkg
ZHJpdmVyIGlzIGZhaWxpbmcgc2lsZW50bHkgb24gZGV2aWNlIG9wZW4uDQo+ID4NCj4gPiBUaGUg
aXNzdWUgaXMgcmVwcm9kdWNpYmxlIGV2ZXJ5IHRpbWUgUEEgb3BlbnMgdGhlIGRldmljZSBmcmVz
aCAoZS5nLg0KPiBhZnRlciBwYQ0KPiA+IHJlc3RhcnQgb3Igc2luayByZXN1bWUgZnJvbSBzdXNw
ZW5kZWQgc3RhdGUgZm9sbG93aW5nIGlkbGUgdGltZW91dCkuIFRoZQ0KPiA+IHN1c3BlbmQvcmVz
dW1lIHdvcmthcm91bmQgcmVsaWFibHkgcmVzdG9yZXMgYXVkaW8gZWFjaCB0aW1lLg0KPiA+DQo+
ID4gSHlwb3RoZXNpczoNCj4gPiBUaGUgb3V0LW9mLWJvdW5kcyBhcnJheSBhY2Nlc3MgZml4ZWQg
YnkgY29tbWl0IGIwNDVhYjNkZmY5NyBpbg0KPiA+IGRhaW9fZGV2aWNlX2luZGV4KCkgZm9yIGh3
MjBrMiBtYXkgaGF2ZSBiZWVuIGluYWR2ZXJ0ZW50bHkgbWFza2luZyBhDQo+ID4gcHJlLWV4aXN0
aW5nIGRlZmljaWVuY3kgaW4gdGhlIGN0eGZpIG1tYXAgaW1wbGVtZW50YXRpb24uIFdpdGggdGhl
IGZpeCBpbg0KPiA+IHBsYWNlLCBtbWFwK3RpbWVyIG1vZGUgaXMgbmVnb3RpYXRlZCBzdWNjZXNz
ZnVsbHkgYXQgdGhlIFBBL2tlcm5lbA0KPiBpbnRlcmZhY2UNCj4gPiBidXQgYXVkaW8gdHJhbnNm
ZXJzIHNpbGVudGx5IGZhaWwuIEEgcG9zc2libGUgZml4IHdvdWxkIGJlIHRvIHNldA0KPiA+IFNO
RFJWX1BDTV9JTkZPX05PX01NQVAgaW4gdGhlIGh3MjBrMiBQQ00gY2FwYWJpbGl0aWVzLCBmb3Jj
aW5nIFBBIHRvDQo+IGZhbGwgYmFjaw0KPiA+IHRvIHJlYWQvd3JpdGUgbW9kZSB3aGljaCB3b3Jr
cyBjb3JyZWN0bHkuDQo+ID4NCj4gPiBLZXJuZWwgd2FzIHdvcmtpbmc6IDYuMTIuNzcNCj4gPiBL
ZXJuZWwgcmVncmVzc2lvbiBpbnRyb2R1Y2VkOiA2LjEyLjg1DQo+ID4NCj4gPiBJIGFtIGhhcHB5
IHRvIHRlc3QgYW55IHBhdGNoIG9yIHByb3ZpZGUgZnVydGhlciBkaWFnbm9zdGljcy4NCj4NCj4g
Q291bGQgeW91IGNoZWNrIHRoZSBsYXRlc3QgNy4wLngga2VybmVsPyAgVGhlcmUgYXJlIGEgZmV3
IG1vcmUgZml4ZXMNCj4gZm9yIGN0eGZpIHJlY2VudGx5Lg0KPg0KPg0KPiBUYWthc2hpDQo+DQo=
