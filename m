Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F98CD343F
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 13:50:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B19160216;
	Fri, 15 May 2026 15:50:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B19160216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778853043;
	bh=ifnh13XLEELsF7Dz7bEQK1VwB//sffYN6yKfk422a8c=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Sq/Gwlj+OIDrzx8q+hwbcqJcWjcAnp84GrWvMUqrQSdcL0PyziShghn7ei6qjci9P
	 EmGkzwYrtDHyFNT+oW5tOF7DZ/IVkpy21gBY840YYN6YGWDaKifTuTEvlLO1CdqRac
	 bUZXHEm0Eo/ncjebYhnLlxRkeKo0uJKuTjiBnSHE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D5D9F805F3; Fri, 15 May 2026 15:50:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CEB0DF805E0;
	Fri, 15 May 2026 15:50:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A550F8049C; Wed, 13 May 2026 18:29:52 +0200 (CEST)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 342A8F80100
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2026 18:29:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 342A8F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rQAQnlzk
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-65890a6ca20so7454727d50.0
        for <alsa-devel@alsa-project.org>;
 Wed, 13 May 2026 09:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689785; cv=none;
        d=google.com; s=arc-20240605;
        b=dNEqsuE9bbycPXt1H6cFwkpUWbvCXelXFQ8g2+2nNTMT5H01VMhnDm9S78gh1Wzn/A
         CK/CDhakAq9Cbl0Hqe+Xbp/DrRZlm8DVswNDcUSkXbnobtFw4sTgLiD2TD80bFj1WM4P
         DGYWcetNvWFf7eK0Y4Cx0RkG2AiZfxZv5proXcvno9ILjIiPgfsNYs5nsqTzmEYQuyc9
         DGYllirA+PwH3vnjrnvSFUx330soh1gGZAGVGzmP8TFRKzZWwhh38JjlXVzPOz+HFikm
         bNfwi4M8iDux090URgWc5Sg/xtEenVgJBTidVzpW6gXeBqHjIx981wGVhyKCtA9F81mb
         qXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=K5DDEtXuGE7ee+SNx61dPE+qWcQIiM2DzVVel3WOnOU=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=GU30RtX0+YaSAVef9Nlh7WfHX+yMJV+vOHntf8noLMt/Wuws5qXGDskF4ttKBUlFvz
         9XNO7FRLNN3k83W3xxtCzRM8f0uAkXVHfKh2JXbEsv+LsKIB9yspJz3XUo8k037/p610
         yeoth8XS7KjfQNusvglADiQFnkha9X4V7SST4r3Wm/qywzoY0+A6NRG9rUiHA0TQknG7
         p1/gX1HeoUZYGRZxGS/5K/54Xxj1EO5TEUGwH16N0TkliQIPeHF2eBJNDUtL0/LVFozY
         6AGM/iP5VLHySuMJTf60fK4m//AISxM8ei/gkZQPNJ3PweU6ZgnL+8Zn12Gr5iLB8sQ0
         +7mw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689785; x=1779294585;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K5DDEtXuGE7ee+SNx61dPE+qWcQIiM2DzVVel3WOnOU=;
        b=rQAQnlzkfb7tR4cuzH4cefTyib68/nwcwg/opF8eiLfFOfkKxoMIYVLrOlCNy8+cmH
         4OLuVWQYpQpxJVnqheEwmbRH9e3zdnW3F6RlJrOEq7Tw1lGVZRNdA2dKzTcCu1MNyLsH
         bHTkBgI68QTQc0QBugrH0gVPelsy5L8W9iFTksCqxulDy1c7dtNMIwOhFw2mktKsSXxT
         gZ0eUKDSLFMewOi8mjpptw1o/pxqkDDTFu+eV9GXtYjoG13WZMzYKqZ5tqHqarAuVztZ
         Y+mI5mGfrF/y8oPri27G3dK6OvhVBd9SPPApRjNK0o6xYW/fBKgEmfNqRZGgymt12qSJ
         Q/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689785; x=1779294585;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5DDEtXuGE7ee+SNx61dPE+qWcQIiM2DzVVel3WOnOU=;
        b=cb5TxKcNJ5D/jYzo1W0ncWVszC/Xm5tVLJz+vnIEn32r4n3wPLkjeQMv/PCkjRZ+K1
         WAiSJA2pDI1YNYhq4+Ni7Cekf8Zs4ky4imnQZ2Tsyb+O9HZY+Kj73uXv7hvI6wgL+GkA
         qvk/a8A4TzGfjtZ9YL0TI3+t7Q4HLAd9LBLiHmWGjneDqnW5YyLCBy67BGP7EAI3rLi1
         PKm/OmBpqcbmBpXHThp9bp/ZX9F9dhxXAyRIcOyHU5mTxZa1Sxtk00Lqw4IFw6lndyWO
         40mhgQYWdzXEyls/25AwCDXirh2gtPWS/4FoXDIXKkk8qRDehAbnVebzWoKubQrdd+Gw
         23oQ==
X-Gm-Message-State: AOJu0Ywaf4eZ6JkJVbbdPAVVpZ9k5xcPWVUusFoQTlW6PRNC84A2A8Qy
	kI9UIll47kOt5uNZTSXviebaHaHz2haxiM4WoNPvfmfGAQvQjVKltnmerW7zsGoSgy0eWBwJWcX
	ST0UdaVZJzxOTm/d9T82gCcBO58cA5F3qRc6cHWs=
X-Gm-Gg: Acq92OHhme8j66dHTEV0n3FUu+6AVhC9SJWxQI3DPBqA69XvVfVsRMcmH8kAM/r+919
	IHpaux0RW7ZTGNTdcT7Bjcoud3lRI8M18yI0wzoH5ppP2dPWCDrs3v44b9r3LzJ/qP4NvT0hu+n
	Ivv0VKHT3Sbj0LlOyQ2kKJO7sxlqby3wDgDb7Js8d6pwBA+6gqYWqTICSb8bpoTkGbWf7CQ7jEt
	LhuRhqjrWS0tBiT5eWR38SvhdpQVIkS1SrwReDAwbBaa64RzAruTHZZNTbSL+g6bsdtkGLAcz4y
	s3MXuvMB
X-Received: by 2002:a05:690e:134a:b0:651:bb21:e7fd with SMTP id
 956f58d0204a3-65df82da822mr3258561d50.42.1778689784947; Wed, 13 May 2026
 09:29:44 -0700 (PDT)
MIME-Version: 1.0
From: Vadym <fwrexan@gmail.com>
Date: Wed, 13 May 2026 19:29:33 +0300
X-Gm-Features: AVHnY4ImD76msvIlg-j8RteiDk4VuYIXkIvj_DZw9Cb5qPt8DaTP07a5DL3Uy6A
Message-ID: 
 <CAO8kHO0eS2AoJvLEE0i_Yt5aorh4zY8t+awQ7c4d-ZSs7Saf7A@mail.gmail.com>
Subject: ALC257 wrong fixup applied for Lenovo LOQ 15APH8 (17aa:3bfa) -
 headset mic not working
To: alsa-devel@alsa-project.org
X-MailFrom: fwrexan@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: XDHKRDMQJJA6ESDHW4DGO3V3XVSXUKAN
X-Message-ID-Hash: XDHKRDMQJJA6ESDHW4DGO3V3XVSXUKAN
X-Mailman-Approved-At: Fri, 15 May 2026 13:50:01 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XDHKRDMQJJA6ESDHW4DGO3V3XVSXUKAN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

U3ViamVjdDogQUxDMjU3IHdyb25nIGZpeHVwIGFwcGxpZWQgZm9yIExlbm92byBMT1EgMTVBUEg4
ICgxN2FhOjNiZmEpIC0NCmhlYWRzZXQgbWljIG5vdCB3b3JraW5nDQoNCj09IEhhcmR3YXJlID09
DQpNYWNoaW5lOiBMZW5vdm8gTE9RIDE1QVBIOCAoODJYVCkNCkNQVTogQU1EIFJ5emVuIDUgNzY0
MEhTDQpBdWRpbyBjb2RlYzogUmVhbHRlayBBTEMyNTcNClBDSSBjb250cm9sbGVyIHN1YnN5c3Rl
bSBJRDogMTdhYTozODcwDQpBTFNBIGluZm86DQpodHRwOi8vYWxzYS1wcm9qZWN0Lm9yZy9kYi8/
Zj0yMjM5OTc4OThjMzdiNmUyNTMxMGVmMGYxMGZmNmI4NTdlNzMyY2IzDQoNCj09IFByb2JsZW0g
PT0NClRoZSBoZWFkc2V0IG1pY3JvcGhvbmUgKDMuNW1tIGNvbWJvIGphY2spIGRvZXMgbm90IHdv
cmsgb24gTGludXguDQpUaGUgaW50ZXJuYWwgbWljcm9waG9uZSB3b3JrcyBjb3JyZWN0bHkuDQoN
Cj09IFJvb3QgY2F1c2UgPT0NClRoZSBrZXJuZWwgYXBwbGllcyB0aGUgd3JvbmcgZml4dXAgZm9y
IHRoaXMgbWFjaGluZToNCg0KICBzbmRfaGRhX2NvZGVjX2FsYzI2OTogQUxDMjU3OiBwaWNrZWQg
Zml4dXAgZm9yIFBDSSBTU0lEIDE3YWE6Mzg3MA0KDQpUaGUgUENJIGNvbnRyb2xsZXIgc3Vic3lz
dGVtIElEIDE3YWE6Mzg3MCBtYXRjaGVzICJMZW5vdm8gWW9nYSA3IDE0QVJCNyINCihBTEMyODdf
RklYVVBfWU9HQTdfMTRBUkI3X0kyQykgd2hpY2ggaXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBt
YWNoaW5lLg0KVGhpcyBmaXh1cCBjb25maWd1cmVzIHRoZSBjb2RlYyBpbmNvcnJlY3RseSBmb3Ig
TE9RIDE1QVBIOC4NCg0KQXMgYSByZXN1bHQsIHBpbiAweDFhICh3aGljaCBjYXJyaWVzIHRoZSBo
ZWFkc2V0IG1pY3JvcGhvbmUgc2lnbmFsIG9uIHRoaXMNCm1hY2hpbmUpIGlzIGluaXRpYWxpemVk
IGFzIFtOL0FdIHdpdGggUGluLWN0bHM6IDB4MDAgVlJFRl9ISVosIG1ha2luZyBpdA0KaW52aXNp
YmxlIHRvIHVzZXJzcGFjZSBhdWRpbyBzZXJ2ZXJzIChQaXBlV2lyZS9XaXJlUGx1bWJlcikuDQoN
Cj09IEV4cGVjdGVkIGJlaGF2aW9yID09DQpQaW4gMHgxYSBzaG91bGQgYmUgZXhwb3NlZCBhcyBh
IG1pY3JvcGhvbmUgaW5wdXQgKExpbmUgSW4gLyBIZWFkc2V0IE1pYykuDQpPbiBVYnVudHUgMjQu
MDQgLyAyNS4xMCB3aXRoIG9sZGVyIGtlcm5lbHMgdGhpcyBwaW4gd2FzIGFjY2Vzc2libGUgYXMN
CiJMaW5lIEluIiBhbmQgdGhlIGhlYWRzZXQgbWljcm9waG9uZSB3b3JrZWQgY29ycmVjdGx5IHdo
ZW4gc2VsZWN0ZWQNCm1hbnVhbGx5Lg0KDQo9PSBDb2RlYyBwaW4gZGV0YWlscyA9PQ0KTm9kZSAw
eDE5IFtQaW4gQ29tcGxleF06IE1pYyBhdCBFeHQgUmlnaHQgKEphY2ssIEJsYWNrLCAxLzgiKQ0K
ICBQaW4tY3RsczogMHgyNCBJTiBWUkVGXzgwDQogIOKGkiBjb3JyZWN0bHkgaW5pdGlhbGl6ZWQs
IGJ1dCBjYXB0dXJlcyBvbmx5IG5vaXNlIChubyBzaWduYWwpDQoNCk5vZGUgMHgxYSBbUGluIENv
bXBsZXhdOiBtYXJrZWQgYXMgW04vQV0gU3BlYWtlciBhdCBFeHQgUmVhcg0KICBQaW4gRGVmYXVs
dCAweDQxMTExMWYwIOKAlCBrZXJuZWwgdHJlYXRzIGFzIE4vQQ0KICBQaW4tY3RsczogMHgwMCBW
UkVGX0hJWiAg4oaQIHNob3VsZCBiZSBhY3RpdmUgaW5wdXQNCiAg4oaSIHRoaXMgcGluIGFjdHVh
bGx5IGNhcnJpZXMgaGVhZHNldCBtaWMgc2lnbmFsIG9uIHRoaXMgaGFyZHdhcmUNCg0KPT0gUmVx
dWVzdGVkIGZpeCA9PQ0KQWRkIGEgcXVpcmsgZm9yIHRoaXMgbWFjaGluZSB3aXRoIHRoZSBjb3Jy
ZWN0IHN1YnN5c3RlbSBJRDoNCg0KICBTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgzYmZhLCAiTGVu
b3ZvIExPUSAxNUFQSDgiLA0KQUxDMjU3X0ZJWFVQX0hFQURTRVRfTUlDKSwNCg0Kb3IgZXF1aXZh
bGVudCBmaXh1cCB0aGF0IGVuYWJsZXMgcGluIDB4MWEgYXMgaGVhZHNldCBtaWNyb3Bob25lIGlu
cHV0DQphbmQgYXBwbGllcyBBTEMyNjlfRklYVVBfSEVBRFNFVF9NT0RFX05PX0hQX01JQyBvciBz
aW1pbGFyLg0KDQo9PSBLZXJuZWwgdmVyc2lvbnMgdGVzdGVkID09DQotIExpbnV4IDcuMC40LTIw
MC5mYzQ0Lng4Nl82NCAoRmVkb3JhIDQ0KSDigJQgYnJva2VuDQotIExpbnV4IDYueCAoS3VidW50
dSAyNi4wNCkg4oCUIGJyb2tlbg0KLSBVYnVudHUgMjQuMDQgLyAyNS4xMCAob2xkZXIga2VybmVs
cykg4oCUIHdvcmtlZA0KDQo9PSBDb250YWN0ID09DQpQbGVhc2UgcmVwbHkgdG8gdGhpcyBidWcg
cmVwb3J0IHdpdGggYW55IGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gbmVlZGVkLg0KDQpXaXRoIHJl
Z2FyZHMNClZhZHltDQo=
