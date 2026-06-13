Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F12DCD98D8
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2026 16:47:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 509F3601F6;
	Sat, 13 Jun 2026 18:46:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 509F3601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781369225;
	bh=LcRrH7du8+oS1mhkCephCvbU1ayy7+t6v4EL01OBppA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dR3LTkgHwLknq0B7bam3tm122RzvLO7MzBQWXceXFm8XH/CHVv27puJ3hE9Ih/pmB
	 zpXBltbyz91dk/y6GQs1Flvv1EBfACwjtgB4QTFYCrWjYhP7jIy7s3bs0jOQz5XvrF
	 pcOGmEdschVDFNyzW+nqc8QuVGhg7Rw7fJrlHiV0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1823F80600; Sat, 13 Jun 2026 18:46:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AB3BF805F9;
	Sat, 13 Jun 2026 18:46:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36431F804F2; Sat, 13 Jun 2026 18:46:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781369182;
	b=nTdVGKVVXXN5O3vBttUqucPI/Ww/GJnXqMLEDtlR8CGwTX89ORTmAdRdEy/A2StMbdGQ
	 52EkeAqkTuk4l7BZjmwZLmOcd0uN8QB7VeYBzGKyalAsSH403tUSPv47AfMpaeSKBrQ+t
	 szaPCjZSeu3AzHFphi74TiE4NoUL+2UhxFFacuIF/w7cZaWXZsV60zMcPoBSEwYxp+pjp
	 wEP6OCNdPZnyccvYWvH+Ym6VcvSKFRc/TbNjGkVbzAxHv4NBRUBWhf47b3u7eEXrqVtQk
	 DJ0w/Ez+dfQMs6qeTRiOhXtg7uS0SO8sWxEAgsHMaMKZ1JgLgWC1rzPRZI9JTPX4ogA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781369182;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=Bh7GA3v8G/+ukNwWKN6TQPUO3rEsOCd9n0vAS+60QfQ=;
	b=kAIjFjq8B2zaU0p3BICJs1WtEUT5lqA7EKvZ5KdCg2ja/oGXnaK+YLLy8z5LvBSmzhNT
	 OvxCCAohd01ZI275B5xZzTBLmSY5jgsfq3MPW4TUv5zzyxxnIWNRBApa5Ir3Oz6TpGo6K
	 4NTm5FmUDzzTdk4lMgLwUP5Ji5jSkUfJ9XGnWOTxVeR4MRPw48OoIrprm0UpEEhsXVea6
	 NcPMW7HWyjwR+/0P0RMnRXiQOLeEIucbEyvMPfxpnjp3Xm2pbiJJzHYjDrpxOTQ+JxFPI
	 gddabGx71nwmnOmmBFKZB2dVlIzERBLMS18rTVbUdIoToqlkUtds3ERcQKxwoY6lfZw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZKOu48Yd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3A3B5F801F5
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2026 18:46:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A3B5F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZKOu48Yd
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-59ccf81e6feso719923e0c.2
        for <alsa-devel@alsa-project.org>;
 Sat, 13 Jun 2026 09:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781369179; cv=none;
        d=google.com; s=arc-20240605;
        b=AnbNR2g6v/RJzY9IoqJHZhBD1tLHe1EwjQUT+Zc4AJfqsosDsd6aNBFqA2u1h0Qsbr
         0e0RAdGUbnk/PMgFO50yab+/WVdv4VWl0CPFCB1L/oEXP9XWqfLdozQ72JWRoq8qe+QU
         Gko0YmslILeQvq+FvtXlqYu9hDBGqOLk2c8DOMy3ib7/zXIPCvuSp3Osq0CdsdpTcuzE
         NhNzVsY6A1JhRknA/M6yc7lBQE4PWthvu3KaQzswN4SezKAKBnX7QusRlZ8MPeQrC/Jz
         J0FMh6BG9d+QrgC3yVy/4cZ+LFeuMJbStTtu0IhQl9mv+GzQn6Qbbg4KoagS1u6fL2J6
         zDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qGQ4mOHbbBXazPy1dTKgu1b1HGpBpzOpnO6+aedNgXI=;
        fh=Ew/FczzB7o7aRfej3b0OqrTSMw6fQi9VXUH7aRGOf/4=;
        b=GpkEm91p56e69HF1X4SRq3mu2eJxkXok+bXBF9CpVllFaCkXyp37jusrAz90GNHGRq
         EkLN+MuNQmFJdWO2RZ7IikKWJuopBNVGIi9VAeMAXT6g+Q+A+cMCfC3agbUnFgJEOPem
         b7usDJvoKDV2qtNbfSe3JMFaR9uQmcA5Fx+E5UQte7vfrXwAKzqaDUq8OcdqT5sDB9vD
         r9q3/uQGWk76TygwihXwvxZD3M2AjVuySzkl8R9ArR5JR92eC0cSHgN6/6ECwY9q0SX/
         NI9w9LovHw/PiSaiVIai90+SHkSIQlAHGm0Z24V6w6jb5858rI5EGd/wNu9td1BVsH6X
         ml5A==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781369179; x=1781973979;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qGQ4mOHbbBXazPy1dTKgu1b1HGpBpzOpnO6+aedNgXI=;
        b=ZKOu48YdQTHF0i8GZ/tmXVnOa3xh78IRhbTDUUVWKijhpEAMV9W1Awk1Ex7rTnyFm0
         ztWGSVllU5PJxEHoU1mEMQHbbl8LOfVuDRWXrxZcgeC9vMAWRQ18LbNTGNW8GcXJO3vt
         LSveAsi+QFGr71YQlsMjovjy1BIn9FqNtGXQ4kJHqzXDdUTUu6z3lDwCZn3mOk4o8Ivo
         StBUElg6o8E2+QSJlIEND252zy0s+ktNDA86bxnF6GDG4/IwduTPu0oV+zgfTffr/jb0
         EVruDLO3sGc8Leh5ciXWw6840uv1ntWHmMDsaMV9sRbfHPuqPgj6ojlyp7ppjjNwq/RF
         EfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781369179; x=1781973979;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGQ4mOHbbBXazPy1dTKgu1b1HGpBpzOpnO6+aedNgXI=;
        b=WyWp2Cik8vVWMRU8Lk3n6GmbkSw9Le/V+9M/TQc7U5GKg/bOULwiwQsEOg1d4p6a5Y
         PubVRvYlgyT8z6dbWrDCS5gqvNZVb36+MgmIFQ1a7FZY8mkAZemhUCZhc7ti/XigrLqQ
         irD5oSxMDgnt2RCfUbPTPNrNVxSeHT1Pkf8JQDr2K3Q1M9i/Up0IYuLCs8cR0KQH91bJ
         FTlYWJzhlc2cjUvhm8zBQpyQkiLK+LlUJ0gGtgb73afhEK5uJ3Hf8rN07wec6umw8CFz
         Bb0nLgaMHcu+eKU2WMs512FI3MA6/JmIz/nvzqcDqoRbxTa0alfF7d6s+7Ap9V0sZqWw
         1cJQ==
X-Gm-Message-State: AOJu0YwJ4+iVPSVP2Xo5J3yfrM3zKerplKRmLMeYiaTrhrFda9tqN8xO
	+pfw5MNbhFxwlGueoZFWadSKUnKEOY5bIsMrx05tUvakYWsiOzzVO0soHiR13r40BPopA32cemV
	FZeHpg5obcmE+93P3Tq5t8q/2v1s7GiKr6GPFoHI=
X-Gm-Gg: Acq92OEByaK6E0h2qNEi6eJIy89AriexCxddvSiPytFAK78tb4KN+D6nkh68GkGEmq+
	X2hoRQSH53rhmjPN4Lc9OeqsakehCrGQBjCIE9hLpv5XuHnRwQw1GeNjLZUgFyM3psvkbkSNJ7Z
	dE4nbsrZyJABu/POKkMqXnXryJIIeGTT4aIrEgRXz1xiaHSARyTh3EpuylTV67ZJbKEqPLpV2A8
	teoR2aTWxy0FhCtjq90fQWUFW4U2FeJEuYtMWTjM7at0r5xAARFSO4JJv3pIQ60/43h5fBzT9Af
	P8kYBBOARbS8OK1ZrjQ=
X-Received: by 2002:a05:6122:6e09:b0:575:fea0:559 with SMTP id
 71dfb90a1353d-5bb6bfddb98mr4205153e0c.4.1781369179334; Sat, 13 Jun 2026
 09:46:19 -0700 (PDT)
MIME-Version: 1.0
From: Ripeer <ripeeerr@gmail.com>
Date: Sun, 14 Jun 2026 01:46:07 +0900
X-Gm-Features: AVVi8CcdCGFkbIgndhT50s_oaiidmaT8hHFQcBM6n438w5knPoIMJF4pLBgt0uw
Message-ID: 
 <CANj20GgeB2y7jUrj43g1vP2_+u7awtecZCig0MxoJBJBM5=3ow@mail.gmail.com>
Subject: [PATCH RFC] ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin 14 GT
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz
Message-ID-Hash: Q5RNFVDE5AKUAXU2EKRBMGH2GXGS6TCO
X-Message-ID-Hash: Q5RNFVDE5AKUAXU2EKRBMGH2GXGS6TCO
X-MailFrom: ripeeerr@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q5RNFVDE5AKUAXU2EKRBMGH2GXGS6TCO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

RnJvbTogcmlwZWVlcnJAZ21haWwuY29tDQoNCkFMU0E6IGhkYS9yZWFsdGVrOiBBZGQgcXVpcmsg
Zm9yIExlbm92byBYaWFveGluIDE0IEdUDQoNClRoZSBMZW5vdm8gWGlhb3hpbiAxNCBHVCAoQ2hp
bmVzZSBtYXJrZXQgbW9kZWwsIEFNRCBSeXplbiBBSSA5IDM2NSkNCnByb2R1Y2VzIGNvbnN0YW50
IGVsZWN0cmljYWwgaGlzc2luZyBhbmQgY3JhY2tsaW5nIG5vaXNlIGZyb20gYm90aA0KaW50ZXJu
YWwgc3BlYWtlcnMgYW5kIDMuNW1tIGhlYWRwaG9uZSBqYWNrIGR1cmluZyBhdWRpbyBwbGF5YmFj
ay4NCkF1ZGlvIHdvcmtzIGNvcnJlY3RseSBvbiBXaW5kb3dzLiBUaGUgbm9pc2UgaXMgbG91ZGVy
IHRoYW4gdGhlIGF1ZGlvDQppdHNlbGYgYW5kIGlzIHByZXNlbnQgb24gYWxsIHRlc3RlZCBkaXN0
cmlidXRpb25zIChBcmNoIExpbnV4LCBGZWRvcmEgNDQsDQprZXJuZWxzIDYuMTIgYW5kIDcuMC16
ZW4pLg0KDQpUaGUgUENJIFNTSUQgMTdhYTozOTEyIGlzIG5vdCBwcmVzZW50IGluIHRoZSBxdWly
ayBsaXN0LiBBZGRpdGlvbmFsbHksDQppbiBzb21lIGNvbmZpZ3VyYXRpb25zIHRoZSBCSU9TIHJl
cG9ydHMgdGhlIFNTSUQgYXMgMTdhYTowMDAwLCBjYXVzaW5nDQp0aGUga2VybmVsIHRvIGFwcGx5
IG5vIGZpeHVwIGF0IGFsbDoNCg0KICBzbmRfaGRhX2NvZGVjX2FsYzI2OSBoZGF1ZGlvQzFEMDog
QUxDMjg3OiBwaWNrZWQgZml4dXAgZm9yIFBDSSBTU0lEDQoxN2FhOjAwMDANCg0KQ29kZWMgaW5m
byAoL3Byb2MvYXNvdW5kL2NhcmQxL2NvZGVjIzApOg0KICBDb2RlYzogUmVhbHRlayBBTEMyODcN
CiAgVmVuZG9yIElkOiAweDEwZWMwMjg3DQogIFN1YnN5c3RlbSBJZDogMHgxN2FhMzkxMg0KICBS
ZXZpc2lvbiBJZDogMHgxMDAwMDINCg0KQXVkaW8gZGV2aWNlczoNCiAgYzI6MDAuMSBBTUQvQVRJ
IFJhZGVvbiBIRCBBdWRpbyBbMTAwMjoxNjQwXQ0KICBjMjowMC41IEFNRCBBdWRpbyBDb3Byb2Nl
c3NvciBbMTAyMjoxNWUyXQ0KICBjMjowMC42IEFNRCBSeXplbiBIRCBBdWRpbyBDb250cm9sbGVy
IFsxMDIyOjE1ZTNdDQoNCkdQSU8gc3RhdGUgKGFsbCB6ZXJvcywgYW1wbGlmaWVyIGFwcGVhcnMg
dW5pbml0aWFsaXplZCk6DQogIElPWzAtNF06IGVuYWJsZT0wLCBkaXI9MCwgZGF0YT0wDQoNClRo
ZSBwcm9wb3NlZCBmaXh1cCBBTEMyODdfRklYVVBfWU9HQTlfMTRJQVA3X0JBU1NfU1BLX1BJTiBp
cyBjaG9zZW4NCmJ5IGFuYWxvZ3kgd2l0aCBuZWlnaGJvcmluZyBMZW5vdm8gMTQiIEFNRCBtb2Rl
bHMgKDE3YWE6MzkxMSwgMTdhYTozOTBkKQ0KdGhhdCB1c2UgdGhlIHNhbWUgZml4dXAuIEhvd2V2
ZXIsIHRoaXMgaGFzIE5PVCBiZWVuIHZlcmlmaWVkIGJ5IHRlc3RpbmcNCmEgY29tcGlsZWQga2Vy
bmVsIOKAlCBJIGRvIG5vdCBjdXJyZW50bHkgaGF2ZSBhIHdvcmtpbmcgTGludXggaW5zdGFsbGF0
aW9uDQpvbiB0aGlzIG1hY2hpbmUuIEd1aWRhbmNlIGZyb20gbWFpbnRhaW5lcnMgb24gdGhlIGNv
cnJlY3QgZml4dXAgaXMNCnZlcnkgd2VsY29tZS4NCg0KU2lnbmVkLW9mZi1ieTogcmlwZWVlcnJA
Z21haWwuY29tDQotLS0NCiBzb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMgfCAxICsN
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL2hk
YS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYw0KYi9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxj
MjY5LmMNCmluZGV4IGRjYmM2Njk4NC4uMGQ4ZjE1N2M5IDEwMDY0NA0KLS0tIGEvc291bmQvaGRh
L2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jDQorKysgYi9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsv
YWxjMjY5LmMNCkBAIC03Nzc0LDYgKzc3NzQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9x
dWlyayBhbGMyNjlfZml4dXBfdGJsW10gPSB7DQogIFNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDM5
MGQsICJMZW5vdm8gWW9nYSBQcm8gNyAxNEFTUDEwIiwNCkFMQzI4N19GSVhVUF9ZT0dBOV8xNElB
UDdfQkFTU19TUEtfUElOKSwNCiAgU05EX1BDSV9RVUlSSygweDE3YWEsIDB4MzkxMSwgIkxlbm92
byBZb2dhIFBybyA3IDE0SUFIMTAiLA0KQUxDMjg3X0ZJWFVQX1lPR0E5XzE0SUFQN19CQVNTX1NQ
S19QSU4pLA0KKyBTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgzOTEyLCAiTGVub3ZvIFhpYW94aW4g
MTQgR1QiLA0KQUxDMjg3X0ZJWFVQX1lPR0E5XzE0SUFQN19CQVNTX1NQS19QSU4pLA0KICBTTkRf
UENJX1FVSVJLKDB4MTdhYSwgMHgzOTEzLCAiTGVub3ZvIDE0NSIsIEFMQzIzNl9GSVhVUF9MRU5P
Vk9fSU5WX0RNSUMpLA0KICBTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgzOTFhLCAiTGVub3ZvIFlv
Z2EgU2xpbSA3IDE0QUtQMTAiLA0KQUxDMjg3X0ZJWFVQX1lPR0E5XzE0SUFQN19CQVNTX1NQS19Q
SU4pLA0K
