Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C3BC54F51
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:58:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B25D60227;
	Wed, 29 Jul 2026 10:58:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B25D60227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785315515;
	bh=bEqcDQPLue0VwvPPT2I9GhpkWaKVfU99ZVyc6BU0PRc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=f+hfhSeHyNf5SRYQyIMIa6qI7/o0Pk7kdDz5agVDDa7O1erHvP6sblzxV1bfwA1v3
	 21dzjUbvehRkM+2zCZJMVAs0qjCM4BDdNBoJR6VvDeP3bF5RuaGi+YWxthNyT6Wk6X
	 jDpa8GTi+z5+X/22btr8c9wpWdSShyartmXeAtvI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84329F80651; Wed, 29 Jul 2026 10:57:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BDC67F8063E;
	Wed, 29 Jul 2026 10:57:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9069F80526; Tue, 28 Jul 2026 14:58:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785243488;
	b=Hr6/BLPvCHGAQwpY/kZAOIUamBjZvF4KPX2mSHERT0HRHQORbMaV4iEFWZrTh33qIrFA
	 TuCKkPo6go1WreEfJoHYoau+qWcp4Y/J2ZO53RtHhLOtW6DSU96d49exqA/sGSV7XPa8q
	 9s2fOT85IuTHhnu/zBSGonUEUjTrA4/3w2U3S5tCppyafJdLzX+Z3SKU20eHjrjLcMv/T
	 e3mQ/9B+IXAQiY/JUMoUOX5TiQ+2ALaGQaFz+wpHdsIMZzKHg+wxmr+qFTJT1nz2epj+L
	 g+MeugdM12Rr8V0DkNkpWed11VMV9wYM8M0k7oXXigFMU4nMfwi2s/075MvZ8ZXwG+g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785243488;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=mAwfeFMeqwhro9aob6Mxz7Y2dOnnuK76GkzMGyhyMGw=;
	b=ngKieTr+w82nvePxwSqcKS5ME7V0L0+mMvweFDI+ixhxe5nxUTFmRXv1Qoe/4sBSMJLu
	 IX/AVsRuV/De/oP5DUWEbJSIf6gT9EbiVyvCDHlRO8CmbqyUE9YR4GMJH8U2LRycISyJb
	 KW0r3vRt2aAty5KtNzpbby0wbo2v0D9dJ9hAeWvwTs+41CfVNOlcW6ugXSXnW0tGgxU24
	 G5Br2MQS/mbQBwKHeSr0SL0cT6jB8G5JAZSPesFQAuNhwxr2sUiTxxYGm1Vh7Tn+sY50j
	 iLyuphceCinDr3KkcP7NtO9Fwy32mHstflNPV6PL2IEstCvvVvaQ6jpaJ84PnnG4d3Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HyMuE3dU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 583C4F8025A
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2026 14:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 583C4F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HyMuE3dU
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4a40bcc8d69so2388488b6e.3
        for <alsa-devel@alsa-project.org>;
 Tue, 28 Jul 2026 05:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785243485; cv=none;
        d=google.com; s=arc-20260327;
        b=P9uw2XVAmwthFuGkQ5i7HqjMCG1AuKtzUjmCjPZIx5yU5fGCXwJPOIUVv3Zh4rdNcz
         9MK9gR2stli56/d1/Jlzl23lCHZ/VhuwCUgl18kQfC2N6e4TXqW4g4pFcWQITbFlLRQx
         CrlwrYKM5xcuOzMJQ/+tHo4xk9zo5QsBYBCEOEWfHvnIUozj0tyV+sT8Yowk4Aq/5iBT
         2dwkCstjChGVed5NiZPov3HakQgzx7bOLaMdh3dlfv0HWsiqDmNE6m8jmHSUau7EWnRm
         5+J1vx2pIXS8GXLm0WrqrTFAlED8uCV8fK22y+GQsO+93H1bfnmtU44URDECKBfNvbxx
         cRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VOrrI/CzTY/BEPpefUKt6eqqEy/q4DYzQJ6tu0MePDg=;
        fh=UuIrXmmJ/DAfqp6xENjJ/+0cbdFrWYnUdyvKDQVU10o=;
        b=i2aE9V7ybPs7bAH53wsCU2F8oynNAM+0XsQa8zaPtmC0J5spmcgqZ7X/+qDpNqM7yX
         kennY0YhgLxZuIgJKT2xvbm/CMY94AxZkPYlR3gVJnMwbnfJ3WtqcWiawZGBF9hog5qJ
         wMSEzgBLf904SRHY81znYX/ZZekrP21gTNVkmjdcjdo6+GEwGBy5POqI7FTd4vgmYyeG
         N7OEm9H29PFMjJy5h/geDTlNAkwoorRsBHFVYbNVSUxFykxDy+scwQZ9ZPy0Uhvcj1dy
         jSNl6PEp5HdVeiEJsT435w11gUP5UNcN0maWnLeckFl6KwF7E9/g8cfm6ItS9ARsqSU6
         sMDg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785243485; x=1785848285;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOrrI/CzTY/BEPpefUKt6eqqEy/q4DYzQJ6tu0MePDg=;
        b=HyMuE3dUJxIKh8iDFPgxJD5esjuDUskHcehPM+HbNtqAE0MxyiJZHAIHksZvQTv/F8
         vuJPb8y9CX3FN4lv1zldMHSiGsUF+EntOky7bjo/RZZn/NylgeTZX/AD4bBc52yNu3mV
         9FHQEOkPVsem40AkAzmYZYppMmu9lkmflac9ab02RJDnxMoYJO5+3xUFcALiAzoXCqa+
         /8MjRWf6QSj3YOqIn87hfGQY0MJt2qP6P2z5XvbNs8na9tpEUZ7uBtHjmMvLhQ1Vt5An
         gFn+Jtzr6j3k83XIr0xBzYcDd/pLvg2ryHeHqpEACgg2aUqlV1BJnUPP1BOp3O7RtmGl
         MpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243485; x=1785848285;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VOrrI/CzTY/BEPpefUKt6eqqEy/q4DYzQJ6tu0MePDg=;
        b=NcsztptKbGUenD3dHeMKl0WbDY/KfS2nS0uO+Ua/YpNvnI0NG6PFJHymKkI2xkEo54
         M4WOat/CEbs9Ahf02p+pW8iv/eA6dIqYE6TGT2NCXF1KowbMEmA8sNrbCckXAx92EbZN
         E+I9dD4PEi6MOjFwNV8zOue0ipKR7sYD5th9ycb6ekXd0J8g9E+B8hhk08febtEsBWrK
         ajjVIP9TSospI2S0g1HIi2akbx/0bMQZA/vGE/51YDqD10D84U/iJqr0NCffHW96Vp2d
         aw0E6HyQ9xO40dGz1wecBCFUwCulARNEtx9QJzkl4pEZhG+hf/pvBljjkaEFY9kQE2KS
         C8mg==
X-Gm-Message-State: AOJu0YyAFVS2Ty5K+1IvU8l1gSmvYVL9JC7Y8qPyGVROd/dzfarFS5Wy
	XXSBIt1pErBLvzSlnzzn5+87/CnGgpuwuLbscYmfmGNP45scuik0pNFFQhx3FqBkezBkYFPITdk
	Bj5Bg2VZQvi0X7/LAg9K2lAjipPZosuHRkBpQ1kHhsg==
X-Gm-Gg: AR+sD13yjF3z9+Ysb3AzbaluKRBZ0I6PHH+6YiRDxTsm7jRiedPWRxfF83mTQ+RoytR
	haY/kWPm6yScD760d+/4WKIxxMJryt84pzUdMaKuppGD//iIOU7K3uXqSGcy7+kty3s5ZJ+luQ4
	HXwyeh6jsN69T8kvLYs7r8j1hlFKA0EhnpltyXAuJrje4YQC+06ZyobzrOVYsM/sw6NPISMgIc5
	9wJcjtj3VL9h7Ad7n5TV419UHCjTIzcFR9Bg5Op5iStecxljoxFZiiwXhi4o7yjqkodlFhlymOm
	OXPFn3uV6eTOD5u7MBRmf2jmI/3nBYk=
X-Received: by 2002:a05:6808:3010:b0:49b:c387:36b6 with SMTP id
 5614622812f47-4ad5b9d8938mr1135622b6e.13.1785243485083; Tue, 28 Jul 2026
 05:58:05 -0700 (PDT)
MIME-Version: 1.0
From: Aditya Sharma <aditya122sharma@gmail.com>
Date: Tue, 28 Jul 2026 18:27:28 +0530
X-Gm-Features: AUfX_mweEZZ324SyGOa9V5k4Jikz9c4eZEIo7y7MIZYdeNJzC9xBTd37T8rTu4M
Message-ID: 
 <CAEF4ZLNsnnATjgGAFYim3t-0qn=LHx=LeEid-jQULEDvN4aQYg@mail.gmail.com>
Subject: [BUG] ALC285 + CS35L56 (ASUS ROG Zephyrus G14 2025, GA403WR, SSID
 1043:1024), no speaker output despite correct routing, gain, and DSP state
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, rf@opensource.cirrus.com
X-MailFrom: aditya122sharma@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4AFF7BGG4J4CMUZPCUUUS3RNVVOFQBR3
X-Message-ID-Hash: 4AFF7BGG4J4CMUZPCUUUS3RNVVOFQBR3
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:57:31 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4AFF7BGG4J4CMUZPCUUUS3RNVVOFQBR3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNCkknbSBzZWVpbmcgY29tcGxldGUgc2lsZW5jZSBmcm9tIHRoZSBidWlsdC1pbiBzcGVh
a2VycyBvbiBhbiBBU1VTIFJPRw0KWmVwaHlydXMgRzE0IDIwMjUgKEdBNDAzV1IpLCBkZXNwaXRl
IGV2ZXJ5IGxheWVyIG9mIHRoZSBhdWRpbyBzaWduYWwgY2hhaW4NCmNoZWNraW5nIG91dCBjb3Jy
ZWN0IG9uIGluc3BlY3Rpb24uIEhlYWRwaG9uZXMgd29yayBwZXJmZWN0bHkuIFRoZSBzYW1lDQpw
aHlzaWNhbCBoYXJkd2FyZSBwcm9kdWNlcyBub3JtYWwgc3BlYWtlciBvdXRwdXQgdW5kZXIgV2lu
ZG93cyAoZHVhbC1ib290KSwNCndoaWNoIHJ1bGVzIG91dCBhIGhhcmR3YXJlIGZhdWx0Lg0KDQoq
SGFyZHdhcmU6Kg0KDQogICAtIEFTVVMgUk9HIFplcGh5cnVzIEcxNCAyMDI1LCBHQTQwM1dSX0dB
NDAzV1IsIEJJT1MgR0E0MDNXUi4zMDkNCiAgIC0gUmVhbHRlayBBTEMyODUgY29kZWMsIFBDSSBT
U0lEIDEwNDM6MTAyNA0KICAgLSAyeCBDaXJydXMgTG9naWMgQ1MzNUw1NiBhbXBsaWZpZXJzIChp
MmMtQ1NDMzU1NjowMC1jczM1bDU2LWhkYS4wLy4xKQ0KDQoqS2VybmVsOiogNy4xLjUtMS1jYWNo
eW9zIChDYWNoeU9TLCBiYXNlZCBvbiBzdGFibGUgdjcuMS41KQ0KDQoqV2hhdCBJJ3ZlIHZlcmlm
aWVkLCBpbiBvcmRlciwgYWxsIGNvbmZpcm1lZCBjb3JyZWN0OioNCg0KICAgMS4gKktlcm5lbCBx
dWlyayBhcHBsaWVzIGNvcnJlY3RseS4qIEFMQzI4NV9GSVhVUF9BU1VTX0dBNDAzVV9IRUFEU0VU
X01JQw0KICAgaXMgcHJlc2VudCBpbiB0aGUgZml4dXAgdGFibGUgZm9yIFNTSUQgMTA0MzoxMDI0
IGFuZCBpdHMgY2hhaW5lZA0KICAgYWxjMjg1X2ZpeHVwX3NwZWFrZXIyX3RvX2RhYzEgZXhlY3V0
ZXMg4oCUIGNvbmZpcm1lZCB2aWENCiAgIC9wcm9jL2Fzb3VuZC9jYXJkMi9jb2RlYyMwLCBOb2Rl
IDB4MTcgY29ubmVjdGlvbiBsaXN0IHNob3dzIDB4MDIqDQogICBzZWxlY3RlZCAodGhlIGV4cGVj
dGVkIERBQzEgb3ZlcnJpZGUpLCBtYXRjaGluZyB3aGF0IHRoZSBmaXh1cCBmdW5jdGlvbg0KICAg
c2V0cy4gKE5vdGU6IHRoZSAicGlja2VkIGZpeHVwIFtibGFua10gZm9yIFBDSSBTU0lEIiBkbWVz
ZyBsaW5lIGlzDQogICBtaXNsZWFkaW5nIOKAlCB0aGUgZml4dXAgbmFtZSBpcyBvbmx5IHBvcHVs
YXRlZCB3aXRoDQogICBDT05GSUdfU05EX0RFQlVHX1ZFUkJPU0UsIHdoaWNoIGlzIG9mZiBieSBk
ZWZhdWx0OyB0aGUgZml4dXAgSUQgaXRzZWxmDQogICBpcyBzdGlsbCBhcHBsaWVkIHJlZ2FyZGxl
c3MuKQ0KICAgMi4gKkVBUEQgY29ycmVjdGx5IGFzc2VydGVkKiBvbiBib3RoIHNwZWFrZXIgcGlu
cyAoMHgxNCwgMHgxYikg4oCUDQogICBjb25maXJtZWQgdmlhIGhkYS12ZXJiIC4uLiBHRVRfRUFQ
RF9CVExFTkFCTEUgcmV0dXJuaW5nIDB4Mi4NCiAgIDMuICpObyBhbXAgZmF1bHRzIGxvZ2dlZCog
4oCUIGRtZXNnIHwgZ3JlcCBjczM1bDU2IHNob3dzIGNsZWFuIGZpcm13YXJlDQogICBsb2FkLCBu
byBmYXVsdC9lcnJvci9wcm90ZWN0L3RoZXJtYWwgbWVzc2FnZXMuDQogICA0LiAqQ1MzNUw1NiBE
U1AgZmlybXdhcmUgZnVsbHkgb3BlcmF0aW9uYWwgb24gYm90aCBhbXBzKiDigJQgdmlhIGRlYnVn
ZnMgKA0KICAgL3N5cy9rZXJuZWwvZGVidWcvc291bmQvaTJjLUNTQzM1NTY6MDAtY3MzNWw1Ni1o
ZGEuezAsMX0vRFNQMS8pOiBib290ZWQ9WSwNCiAgIHJ1bm5pbmc9WSwgaGliZXJuYXRpbmc9Tiwg
ZndfaWQ9MHgwMDFhMDBkNiwgZndfdmVyc2lvbj0weDAwMDMwYjEwLg0KICAgNS4gKkhhcmR3YXJl
LXN0cmFwcGVkIHNwZWFrZXIgSUQgY29ycmVjdGx5IGRldGVjdGVkKiBhcyBzcGtpZDAgKHJlYWQN
CiAgIGZyb20gb25jaGlwIEdQSU8gc3RyYXBzIHBlciBjczM1bDU2X3JlYWRfb25jaGlwX3Nwa2lk
KCkpLCBhbmQgdGhlDQogICBtYXRjaGluZyB0dW5pbmcgZmlsZXMgKGNzMzVsNTYtYjAtZHNwMS1t
aXNjLTEwNDMxMDI0LXNwa2lkMCopIGxvYWQNCiAgIHdpdGhvdXQgZXJyb3IuDQogICA2LiAqUENN
IHN0cmVhbSBhY3RpdmVseSBydW5uaW5nKiDigJQgL3Byb2MvYXNvdW5kL2NhcmQyL3BjbTBwL3N1
YjAvc3RhdHVzDQogICBzaG93cyBzdGF0ZTogUlVOTklORyB3aXRoIG1vdmluZyBod19wdHIvYXBw
bF9wdHIgZHVyaW5nIHNwZWFrZXItdGVzdC4NCiAgIDcuICpEQUMtbGV2ZWwgZ2FpbiByZWdpc3Rl
ciBjb25maXJtZWQgYXQgZnVsbCBzY2FsZSog4oCUIE5vZGUgMHgwMg0KICAgKFNwZWFrZXIgUGxh
eWJhY2sgVm9sdW1lKTogQW1wLU91dCB2YWxzOiBbMHg1NyAweDU3XSAobWF4LCAwZEIpLCBhZnRl
cg0KICAgc2V0dGluZyB2aWEgYW1peGVyLiBBTFNBLWxldmVsIFNwZWFrZXIsIE1hc3RlciwgQmFz
cyBTcGVha2VyIG1peGVyDQogICBjb250cm9scyBhbGwgdW5tdXRlZCBhdCAxMDAlLiBBTVAxL0FN
UDIgU3BlYWtlciBEU1Atc2lkZSBnYWluIGNvbnRyb2xzDQogICBhbHNvIGNvbmZpcm1lZCBhdCA4
NSUgKC00Ljc1ZEIpLCBub24temVyby4NCg0KRGVzcGl0ZSBhbGwgb2YgdGhlIGFib3ZlLCBubyBh
dWRpYmxlIG91dHB1dCB3aGF0c29ldmVyIGZyb20gdGhlIGludGVybmFsDQpzcGVha2Vycy4gSGVh
ZHBob25lcyAoTm9kZSAweDIxKSB3b3JrIG5vcm1hbGx5IGF0IGFsbCB2b2x1bWUgbGV2ZWxzLg0K
DQpGdWxsIGFsc2EtaW5mby5zaCBkdW1wIChjb2RlYyBwcm9jIGR1bXAsIGFtaXhlciBzdGF0ZSwg
ZG1lc2csIGFsc2FjdGwNCnN0YXRlKSBpcyBoZXJlOg0KaHR0cHM6Ly9hbHNhLXByb2plY3Qub3Jn
L2RiLz9mPWNjNmMwODExNmQ5YTljNDY2MDM5Njc5ZDIxNDJkMGRmMWMxMmZhNzcNCg0KR2l2ZW4g
dGhhdCByb3V0aW5nLCBFQVBELCBEU1Agc3RhdGUsIGhhcmR3YXJlIElELCBhbmQgZ2FpbiBhbGwg
Y2hlY2sgb3V0DQpjb3JyZWN0IGF0IGV2ZXJ5IGxheWVyIEkgY2FuIGluc3BlY3QgZnJvbSB1c2Vy
c3BhY2UsIGJ1dCBXaW5kb3dzIHByb2R1Y2VzDQpjb3JyZWN0IG91dHB1dCBvbiB0aGUgc2FtZSBo
YXJkd2FyZSwgSSBzdXNwZWN0IHRoZXJlJ3MgYW4gaW5pdGlhbGl6YXRpb24NCnN0ZXAgb3IgcmVn
aXN0ZXIgc2VxdWVuY2UgdGhlIExpbnV4IGRyaXZlciBpc24ndCByZXBsaWNhdGluZyB0aGF0IFdp
bmRvd3MnDQpDaXJydXMgZHJpdmVyIHBlcmZvcm1zIOKAlCBwb3NzaWJseSBzb21ldGhpbmcgbm90
IGV4cG9zZWQgdmlhIHRoZSBzdGFuZGFyZA0KQUxTQSBjb250cm9scyAoYW4gYWRkaXRpb25hbCBj
YWxpYnJhdGlvbi9pbml0IHN0ZXAsIGEgbWlzc2VkIEkyQyB3cml0ZQ0Kc2VxdWVuY2UsIG9yIHNv
bWV0aGluZyBzcGVjaWZpYyB0byB0aGlzIGJvYXJkJ3MgaW1wbGVtZW50YXRpb24gb2YgdGhlDQp0
d28tYW1wIERBQzEtc2hhcmVkIGNvbmZpZ3VyYXRpb24pLg0KDQpIYXBweSB0byB0ZXN0IHBhdGNo
ZXMsIHB1bGwgYWRkaXRpb25hbCBkZWJ1Z2ZzL3JlZ21hcCBkdW1wcywgb3IgY29tcGFyZQ0KYWdh
aW5zdCBhIFdpbmRvd3Mtc2lkZSBkcml2ZXIgdHJhY2UgaWYgdGhhdCB3b3VsZCBoZWxwIG5hcnJv
dyB0aGlzIGRvd24uDQoNClRoYW5rcywNCkFkaXR5YSA6XQ0K
