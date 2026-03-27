Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110B510F284C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:06:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBC4E601F2;
	Fri, 27 Mar 2026 17:06:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBC4E601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774627609;
	bh=Q1SXMtCjU3iBl5tv70DL7BY1NnM6cZpDZtmE+SIaxdo=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=alVkW2RWBieoXp9I0Mrnsh7Bdef69435p/BzV0XerGrYXHCxzUqY5NvzTpygW7a6a
	 mW0yia5BWZnuDFKHvarAK4NPhjKx//a/BCscGpl/RM/aGLjhIN8pXoe2eNCuTXSeoA
	 p064A4EuzjmBOHyR96lOgQtMX0yX2JOkkAxqdTUI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E42F2F8062E; Fri, 27 Mar 2026 17:06:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2E37F8062F;
	Fri, 27 Mar 2026 17:06:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA137F804F3; Fri, 27 Mar 2026 05:09:52 +0100 (CET)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 748A3F8025A
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 05:09:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 748A3F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LjVkc4cT
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-38b50c79f2fso16625331fa.3
        for <alsa-devel@alsa-project.org>;
 Thu, 26 Mar 2026 21:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774584588; cv=none;
        d=google.com; s=arc-20240605;
        b=BYCSoPBSBldC3EWwEQQkNFs6XUCy9oqihdNW7iY/gyHhkE9ZQmfPbuXKLMp7PRE1WM
         7UJg8vpRk1TigmvXDIQkWdjFwtxqBC0UJW/NJZsxhdUb2tO9Q7VbsXCPNQV1JuVPb7bX
         3J7WIb+7YqbwZUacL7QM/QwESp+faToDze+YMO0+GRXeQWMVcMm3vK/zOUrCP+Yymw22
         QFVYPozt6wb+9+tIj7BJ6KEFcbUw1KBqHagtz68f7VBJrqXYeZTbzOMFjJswij4ANOxH
         NRJ8FXJ3Y17lvc0NEQ/agwAzPEa6HDyluJ0PZdG3bde6yK30EaymYeNRLbdhq2N9osoV
         fBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=l1isUYv0WR6LcB9pWPFzs/qaHOBmlR5AZJJf4/MfWZM=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=bX8AT6gdYtd+AmLWPcPY1N3vWRcTcSBUSV+rfk4+9NCLmSW8ScZAJCNfaidJd+wiam
         KYjlRSjfhFqpnLfYcPX1BxkzKX4/b+MpN/QWDcCfW4Xx8RclcEWUfjp/L1Do5JB7gSHO
         utnpIrq5IxXd9WkNsHevMI8tdrHgFVvK0zeAiEEP0W0CRYfpG2+JUKtogzoqhHV5angK
         AC1DNEGWQXDhBx1Rqxiv+9Ap/LNryfHh47dNH7X0MZZQSILL2eC8cPnReRSKZeH5onEr
         +P+418kZE08fkw4AdQ15d8nfCVyuT2aC4cCpF57Zvpu5VQKRG3zXujYSMU42DLW+knmQ
         pQ+w==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774584588; x=1775189388;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l1isUYv0WR6LcB9pWPFzs/qaHOBmlR5AZJJf4/MfWZM=;
        b=LjVkc4cTz38gQR7S5jTlSS4rk3CYsRPf/Q7mo5O/dcHKFPQYpjfexJcddJrVDa8DZB
         GH1VOMJyThfY3u2KRb6UHAj0q6LyvYm1ztY4uzFddKyBmYeNbNoH6N7A0DHDmoWCyWFt
         PvkiWcpvKs9d9GaB4Bas8kQg2axP/Uk52o9GxP9CXB9LOGFbeJrf5bf+aTQ1SpP73u2D
         fUcMPs8QIR7jf95OVKfZd6H8GV/EGMlmR95AOv+R9q+JphjlhtwE86pFAAPgfSQt/0HR
         Ldm+8Fmnd0dVI/0m+d8vFyeg73UZZ0DRKhR37BLkrFK9R+MB7yF+rdAwMkl4sm+2iLdZ
         DlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774584588; x=1775189388;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1isUYv0WR6LcB9pWPFzs/qaHOBmlR5AZJJf4/MfWZM=;
        b=sLnyCd9QgVeEqECdAMl5jkg8I4hzfGl2TUY53a05RYYk75e+RUR1y9rTAB4oFUIKn9
         5qDUp+YN/AHvAAXy74/eF/DL4w+rVYevfXaHE/7J0Cw9x2G3fKk4Ml+/DOJ28R/cSBEY
         S/1QYCXzP3/RaZnHHlhbWZohws5I4UoSLCA5K7d92mvbkSn1m6arlrOWROmA+wEzCzge
         mQV5OjuhKXRaBlkFbbQd2DXscObdgIyGpuQLy0xoxyG6fZj0TiUmRpFY+haugmuih/Nf
         2PxanA86NPzapYKBblA8aKF3BqsMEpy3wWf1xGkgwoIRO46fF7Mmu0YWWnbKO4uKUGcH
         cXRg==
X-Gm-Message-State: AOJu0YxrRBdk/vC2XOJQbGL7IBgVocNkc5Qal7PY3Opdgo+RID+9efwL
	uPP7a/+4yrsDj9ViVm7Iwqf+fixuhaHNt0RF/CqQqGVe4bAVWe9x4lVF+izndtvju+YG5VWEACe
	QFy/TlJmVn1MqoLnfaNlh0BUAYVekIxuHye/wFjg=
X-Gm-Gg: ATEYQzx0TY3taMsfQDpsKgJe615h7p8vwDRXL1L8/ai4sYDwKAAGYYZ1TEeaZVnAQ9O
	3jSNHIyHIsBTdqR2QjH25AoA53YSWYKSoz0x6bUircY/J9wW7mwFZyQv6RvgHnMKXn6p45Po8OC
	DR5M290hINuV4S6hGhXiWHBLnwQbRjZdh0Osn1IWTo41t0QpLbKnXzj1Oy6stQwiqyXVh6Ltxnx
	r3BDJCq6uWXnwrs7uhlTP2YqhOVk22MY36PelXDj8MAixdZMHTsvRvojXwwlauo72vH1lvvGERZ
	G2+dx1FCaw==
X-Received: by 2002:a05:651c:2129:b0:38c:6bf6:5b8c with SMTP id
 38308e7fff4ca-38c72c52112mr3093061fa.0.1774584587596; Thu, 26 Mar 2026
 21:09:47 -0700 (PDT)
MIME-Version: 1.0
From: Kumar S <nishantsingh2jan1998@gmail.com>
Date: Fri, 27 Mar 2026 09:39:33 +0530
X-Gm-Features: AQROBzDXLt2PikrIkkQZK-WvCNx63-xBCmZhTkiZkzkU6LmfSR9Z2yyLyXOym4g
Message-ID: 
 <CAPPx52zwF0DEVn6KqnXCf=3Pgd3+-AGDJ=AYkCB4yTFk-A3OUQ@mail.gmail.com>
Subject: [PATCH] aplay: use snprintf instead of sprintf in device_list()
To: alsa-devel@alsa-project.org
X-MailFrom: nishantsingh2jan1998@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: X2HECVC5GKQIJWVZV7BTXCXECFVC226C
X-Message-ID-Hash: X2HECVC5GKQIJWVZV7BTXCXECFVC226C
X-Mailman-Approved-At: Fri, 27 Mar 2026 16:06:04 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X2HECVC5GKQIJWVZV7BTXCXECFVC226C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNClRoaXMgcGF0Y2ggcmVwbGFjZXMgc3ByaW50ZigpIHdpdGggc25wcmludGYoKSB3
aGVuIGNvbnN0cnVjdGluZyB0aGUgQUxTQQ0KY29udHJvbCBkZXZpY2UgbmFtZSBzdHJpbmcgdG8g
cHJldmVudCBwb3RlbnRpYWwgYnVmZmVyIG92ZXJmbG93LiBVc2luZw0Kc2l6ZW9mKG5hbWUpIGVu
c3VyZXMgdGhlIHdyaXRlIHN0YXlzIHdpdGhpbiBib3VuZHMuDQoNClNpZ25lZC1vZmYtYnk6IE5p
c2hhbnQgS3VtYXIgU2luZ2ggPG5pc2hhbnRzaW5naDJqYW4xOTk4QGdtYWlsLmNvbT4NCg0KRnJv
bSA0ZWU3NTU1YzYyNjBjZjliOTY2YTA0MTM0ZWZkZmNjNjdiOTlmZTY0IE1vbiBTZXAgMTcgMDA6
MDA6MDAgMjAwMQ0KRnJvbTogTmlzaGFudCBLdW1hciBTaW5naCA8bmlzaGFudHNpbmdoMmphbjE5
OThAZ21haWwuY29tPg0KRGF0ZTogRnJpLCAyNyBNYXIgMjAyNiAwMzo1NjoxMCArMDAwMA0KU3Vi
amVjdDogW1BBVENIXSBhcGxheTogdXNlIHNucHJpbnRmIGluc3RlYWQgb2Ygc3ByaW50ZiBpbiBk
ZXZpY2VfbGlzdCgpDQoNCnNwcmludGYoKSBkb2VzIG5vdCBwZXJmb3JtIGJvdW5kcyBjaGVja2lu
ZyB3aGVuIHdyaXRpbmcgdG8gdGhlIG5hbWUNCmJ1ZmZlci4gUmVwbGFjZSBpdCB3aXRoIHNucHJp
bnRmKCkgdXNpbmcgc2l6ZW9mKG5hbWUpIHRvIGVuc3VyZSB0aGUNCndyaXRlIHN0YXlzIHdpdGhp
biB0aGUgYWxsb2NhdGVkIGJ1ZmZlciBhbmQgcHJldmVudCBhIHBvdGVudGlhbCBidWZmZXINCm92
ZXJmbG93Lg0KDQpTaWduZWQtb2ZmLWJ5OiBOaXNoYW50IEt1bWFyIFNpbmdoIDxuaXNoYW50c2lu
Z2gyamFuMTk5OEBnbWFpbC5jb20+DQotLS0NCiBhcGxheS9hcGxheS5jIHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
YXBsYXkvYXBsYXkuYyBiL2FwbGF5L2FwbGF5LmMNCmluZGV4IDAwNTAwMzIuLjc0ZWM5NDcgMTAw
NjQ0DQotLS0gYS9hcGxheS9hcGxheS5jDQorKysgYi9hcGxheS9hcGxheS5jDQpAQCAtMjgzLDcg
KzI4Myw3IEBAIHN0YXRpYyB2b2lkIGRldmljZV9saXN0KHZvaWQpDQogICAgICAgICAgICAgICBz
bmRfcGNtX3N0cmVhbV9uYW1lKHN0cmVhbSkpOw0KICAgICAgIHdoaWxlIChjYXJkID49IDApIHsN
CiAgICAgICAgICAgICAgIGNoYXIgbmFtZVszMl07DQotICAgICAgICAgICAgICBzcHJpbnRmKG5h
bWUsICJodzolZCIsIGNhcmQpOw0KKyAgICAgICAgICAgICAgc25wcmludGYobmFtZSwgc2l6ZW9m
KG5hbWUpLCAiaHc6JWQiLCBjYXJkKTsNCiAgICAgICAgICAgICAgIGlmICgoZXJyID0gc25kX2N0
bF9vcGVuKCZoYW5kbGUsIG5hbWUsIDApKSA8IDApIHsNCiAgICAgICAgICAgICAgICAgICAgICAg
ZXJyb3IoImNvbnRyb2wgb3BlbiAoJWkpOiAlcyIsIGNhcmQsDQpzbmRfc3RyZXJyb3IoZXJyKSk7
DQogICAgICAgICAgICAgICAgICAgICAgIGdvdG8gbmV4dF9jYXJkOw0KLS0NCjIuNDMuMA0K
