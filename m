Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C92C54F54
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:27:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E9A760207;
	Fri, 31 Jul 2026 09:27:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E9A760207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785482862;
	bh=+B5b0V8Z6JZ+F/x3K8YBahQqXunBOdn/yfSRHuqkDBQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Kp8nmYFNqu2SDdNlqZETkW6svt27jDWunB98whCmJ1XuI0DUHL2HWyvwr8Hf//XHQ
	 lNZYYMuQdIAJjvQMK8BXDY/kSB9vfRjcA+HhDOyXHm52b2zhs9ErAAtT5Z/l+gatDm
	 kpDOU5hzK20ZmZdeYuWDvQNT/mA/w7joAT7bLEAs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89604F80680; Fri, 31 Jul 2026 09:26:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B591EF8063B;
	Fri, 31 Jul 2026 09:26:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 399D9F80496; Thu, 30 Jul 2026 10:15:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785399315;
	b=ghUxKg+mjiRBtroK1Oub6ZUaKWN+E1S9/cZP5GczMaoZLIM78Z1zcWAO0vtrnnQKDI0t
	 +MLdmvjNQmWzbRnyMrqYHHM9k7vDRXCLPSTJZZpNuYrT8sEm7caoZduQGITIkqrzaTu9s
	 bx+GowjQvwcFakQzkROAQdsAll26X3+9x/8UFrG/ngCnK7mbxTl9LR03a+y0zkAbsOB9T
	 xCHGvoK8msbgsNp0C4TOunI1okA3I3ujq6od5CezRzwVuDVGHoiKw8Np4xGPH7slbLanU
	 /ToxQtBjjmLxT/JQZEdLIbmmb2DXq2P8Y3Fm/TJI7dD4Q6jxAVmPujYabe/Orm3tFbw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785399315;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=BPsenXcViqVZXkJD51vQDbW1uM1paMA2RctJZ0ntpdU=;
	b=la0ZWsUPgN3/wC5aRe/R25w/yaau7UBVeNwacStDqBM2n9o8/oG1uFJRsEXVb8MB/f7D
	 G71zzhxZfH2lvfyzY2/Fm6u3go80zhI3rTABojUdNsJ85d3uj0hpgPZANidtAGKXjPnVV
	 kUCmJJ9fjbbRiQfxfcwtFPzQib/Oisp1tqRmnL6EAepuie4RruLEfCuchGHbLGOEzHrfW
	 HGAXn4LPzF6XFECJ0iQBrunYE+ZGewyrPOKkxaG1pR47XfXbDygvC0qV/mKmYaGSp2jS+
	 j4Dv0vSTG4vPUnAJs41LrOvOOd8OOHmcGeSySGWJdS0UOtbFwQZh4S9XwuMTJ/A6BNg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q4NicFNx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 52713F800F3
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 10:15:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52713F800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q4NicFNx
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so1062220a12.3
        for <alsa-devel@alsa-project.org>;
 Thu, 30 Jul 2026 01:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785399312; cv=none;
        d=google.com; s=arc-20260327;
        b=c89ZifEXql4ATZpQ2S98wzLQzK12bHbH7sHQlWBlQlcnEGZwOxBT4dbsKWG2HCiqIi
         q5p3XctjyL6ZACqUKx3kqmSzc0XE+dgWluVQ5dK5hN4i2cGKhqMijJmwE7jWjo1RQ6Og
         s9Siz0hWo6X/pym1jYYGnKeF8APjNcAI5uAtTQWag3wVPH+zYtKsry7CJ9D87xT8XH0R
         uRRfO0ro9zp4TgOM1NTm8YY2NPj1Drp+DZvkPJdX1h31wAcQCHvB528rSBWVr3gsuvKE
         Vg4bWQQJjoS56paXrjJnlkoS8UnxbzBg5ZDFkXPB5kcchSQxtzswUhuBMUsVM0iN/Umy
         2YcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FLnR1vJpynHVvkhHMBCHyMgubpadAMBBkM8KLXQWHzk=;
        fh=jHXQUnLdYVGPkOuOsNEn+KU3AMd0uAbIjZezuAHxK98=;
        b=MT512sPyjCbg8uNS9J9dqZmcmaCUjtb6eq9djPrIDdCVNtAZ40zqIXrdPg6w3vXjOB
         JB16hC/JESF94IDwoo5TcD+8bpkHEbLYGko2qhAf2bIUhjrFp34j+mBxoTA7I0abCKeJ
         ftT0wIH24b68CJorxF8FbPz1MWv/HjbrkXSr7iMoNWMNKc+V0KxHDftEHwfXL2SmWsVu
         P4leOyBOmCtXdzugjeSziaEnLgFUXYkeBxZovnN9/aRNSHm86TlrP01PZwmlBzfWD6mz
         FGEdYbbcxL7WqyN7PWw2bO5fNzoSksTVND+VnjKRjt/iqL5tRRBwekRt31BLbeRg06x2
         xHDw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785399312; x=1786004112;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FLnR1vJpynHVvkhHMBCHyMgubpadAMBBkM8KLXQWHzk=;
        b=q4NicFNxnqHauKKYmm3UlfAA8pvlH4d0G8cnsjUgTr7BQx1+B4oZXhuO1jx9q8c7v+
         U0UieIDfnHWtrMS2KrdG6Pmb+UBADmmBS45bIpAdAio79QjiOYv209wtRxLlLFRcGTy8
         A6aOwE3bfpO2ldZb/6ESQf8Rll4Sq6STBCLqjmV+isl1kEQxgHP1Zf6YKq+mq9phiow+
         dkG0UO5jOu6p60UL98q1VrTj2XtbHhthjnVsfON8D7Z9J7bd1eunhXxKRMjXDDMZM3Tm
         xMORJv1Y+BSlmWj3NXeNd5V0MgecIDORU4pb3gqsSwC8kvgtcnssXmdvSw4Wq5JS+JKM
         +qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399312; x=1786004112;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FLnR1vJpynHVvkhHMBCHyMgubpadAMBBkM8KLXQWHzk=;
        b=WWO3oui3Vd2yWjCiOtKoeOpXh8cnidhppOHClJs/lxQ7VQvpnprZNdQFFcKtJEgijH
         ELmQ8vmAuuVY4H5MgacoT2xUrSioaLVATGn1nIK3OkZlF9HWvvtupkOTaf9BW81kxxBI
         yQY8RB9A+VVbwtVSyT+Mh4/7CBdb3GLnvkIksQ4jt2jjhkh78xUmKkkP1m2/WDs1Zenv
         QL47vkXf/K7WeUBlCXImpyCWqrwWrz0S+FbPZ7hWcs+AgT3mv9HKIKbrLWfLE+ITU7EU
         LHxkL1m/LDhjCMp6JAW/tbZUo/Iv3ZfBnWSmjNMz+xvr7rBLTWbKYgn/fsQsJJO6kvJQ
         IvSQ==
X-Gm-Message-State: AOJu0YyorTqd4AJ32rKvuYE03qcQQKhtfP1wwRUfOXvdtYovQj+zSaaA
	qslaScLQScgbEW0uas8PPjCnIxMmJU9KBJDercZb17Qllq3dKTvkqnpX0fQZGAvUPYrseZ6IUsZ
	jSNqElzD2QyL10mgSKpjde/5z21LU8pdGwX4P9BM=
X-Gm-Gg: AR+sD101pyEDY4HdZmjOG7SNJfwARg+I/XJUhbxolKc9MNjMsIO27SZdW4mv/mHclUG
	JCHyJz7PwHf4hRL3exbL309WbSgrdkwha+x9bPdCg3yAZlNw9uMZ5npKN8Ttya40GdVBr0esJWj
	T/J7/+Y6T9RAzcoxKRKFMXetz7b8LpOce5esow8jG45dg9SXiwqlcAS3Z3/YgiI3EAwW+seFsD9
	wFcgM+Rx64o9ZbxOGIfTBZMS621KlM2mWZxJ8qqklLQv2zlBsBy0BuiPokFuUFz1ivUCwCYbRBn
	RlulwMgf7D0OlrFFXhxSnMEssQWNXwraDCVczkfwg+PMAy8PKfqVCRQ2YPQ6H06NPSHEwZKDaSr
	y2g==
X-Received: by 2002:a05:6a21:9983:b0:3b4:5ff3:45cb with SMTP id
 adf61e73a8af0-3c900473860mr1590601637.8.1785399311763; Thu, 30 Jul 2026
 01:15:11 -0700 (PDT)
MIME-Version: 1.0
From: Attila Hudecz <ahudecz@gmail.com>
Date: Thu, 30 Jul 2026 10:14:35 +0200
X-Gm-Features: AUfX_mxxiXGPwXBlZLy6GFC6M7OgExdKC49YVdxfuSZXcTipuYwtjNoCS9Xv7qA
Message-ID: 
 <CAKuZFtLvRRNZnJ23xNBWwDcEsY8Wnz0eR2N6x12qtgiBWDp7iQ@mail.gmail.com>
Subject: 
 =?UTF-8?Q?=5BBUG=5D_hda=2Fconexant=3A_SN6140_=280x14f11f87=29_loses_widget?=
	=?UTF-8?Q?_state_across_suspend_=E2=80=94_silent_capture_=2B_dead_speaker=2C_no_?=
	=?UTF-8?Q?resume_callback?=
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, bo.liu@senarytech.com
X-MailFrom: ahudecz@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FKWIWZU4XCF7L3XWHYB7S3QLGZDYLKZM
X-Message-ID-Hash: FKWIWZU4XCF7L3XWHYB7S3QLGZDYLKZM
X-Mailman-Approved-At: Fri, 31 Jul 2026 07:26:27 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FKWIWZU4XCF7L3XWHYB7S3QLGZDYLKZM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNCkNvbmV4YW50IFNONjE0MCAocGF0Y2hfY29uZXhhbnQpIGludGVybWl0dGVudGx5IGVu
ZHMgdXAgd2l0aCBpdHMgQXVkaW8NCkZ1bmN0aW9uDQpHcm91cCBhbmQgd2lkZ2V0cyBpbiBEMyBh
ZnRlciBzeXN0ZW0gc3VzcGVuZC9yZXN1bWUgKGFuZCBhZnRlciBsb25nIGlkbGUpLA0Kd2hpbGUN
CkFMU0Egc3RpbGwgdHJlYXRzIHRoZSBzdHJlYW0gYXMgUlVOTklORy4gUmVzdWx0OiB0aGUgaW50
ZXJuYWwgbWljIHJlY29yZHMNCmRpZ2l0YWwNCnNpbGVuY2UgYW5kIHRoZSBpbnRlcm5hbCBzcGVh
a2VyIGlzIGRlYWQgKHNhbWUgY29kZWMgZHJpdmVzIGJvdGgpLiBUaGUNCmtlcm5lbA0KbG9ncyBu
b3RoaW5nIGF0IHRoZSBtb21lbnQgb2YgZmFpbHVyZS4gV3JpdGluZyB0bw0KL3N5cy9jbGFzcy9z
b3VuZC9od0N4RHkvcmVjb25maWcgKGZ1bGwgY29kZWMgcmUtaW5pdCkgcmVsaWFibHkgcmVzdG9y
ZXMgaXQ7DQphDQp1c2Vyc3BhY2UgKFBpcGVXaXJlKSByZXN0YXJ0IGRvZXMgbm90Lg0KDQpUaGlz
IGxvb2tzIGxpa2UgdGhlIHNhbWUgUzMvcmVzdW1lIHN0YXRlLXJlc3RvcmF0aW9uIHdlYWtuZXNz
IHRoYXQgd2FzDQpyZWNlbnRseQ0KYWRkcmVzc2VkIGZvciB0aGUgc2libGluZyBTZW5hcnl0ZWNo
IFNONjE4NiBpbiB0aGUgbmV3IHBhdGNoX3NlbmFyeSBkcml2ZXINCihyZXN1bWUgY2FsbGJhY2sg
dGhhdCByZS1zeW5jcyByZWdjYWNoZSwgcmUtYXBwbGllcyBpbml0IHZlcmJzLCBhbmQgcmVzZXRz
DQp0aGUNCmJ1cykuIFRoYXQgZml4IGRvZXMgbm90IGV4aXN0IG9uIHRoZSBwYXRjaF9jb25leGFu
dCAvIFNONjE0MCBwYXRoLiBDb3VsZA0KdGhlIHNhbWUNCnJlc3VtZSBoYW5kbGluZyBiZSBhZGRl
ZCBmb3IgU042MTQwPw0KDQo9PSBIYXJkd2FyZSAvIHNvZnR3YXJlID09DQoNCi0gTWFjaGluZTog
VFVYRURPIEluZmluaXR5Qm9vayBQcm8gQU1EIEdlbjEwLCBCSU9TIE4uMS4yMEExMw0KLSBTb0M6
IEFNRCBSeXplbiBBSSA5IDM2NSAoU3RyaXggUG9pbnQpDQotIEhEQSBjb250cm9sbGVyOiBBTUQg
Unl6ZW4gSEQgQXVkaW8gWzEwMjI6MTVlM10gQCBQQ0kgMDAwMDo2NTowMC42DQotIENvZGVjOiBD
b25leGFudCBTTjYxNDANClZlbmRvciBJZCAweDE0ZjExZjg3DQpTdWJzeXN0ZW0gSWQgMHgxZDA1
MzAxMg0KUmV2aXNpb24gSWQgMHgxMDAxMDANCi0gRHJpdmVyOiBzbmRfaGRhX2NvZGVjX2NvbmV4
YW50IChwYXRjaF9jb25leGFudCkNCi0gS2VybmVsOiA2LjE3LjAtMTIyMDM1LXR1eGVkbyAoVWJ1
bnR1IC8gVFVYRURPIE9TIDI0LjA0KQ0KLSBBTFNBOiBrNi4xNy4wLTEyMjAzNS10dXhlZG8NCi0g
Tm90ZTogdGhlIEFNRCBBQ1AgZGlnaXRhbC1taWMgcGF0aCBpcyB1bmF2YWlsYWJsZSBvbiB0aGlz
IG1hY2hpbmUNCihhY3BfYXNvY19hY3A3MC4wOiB3YXJuaW5nOiBObyBtYXRjaGluZyBBU29DIG1h
Y2hpbmUgZHJpdmVyIGZvdW5kKSwgc28gdGhpcw0KSERBDQpjb2RlYyBpcyB0aGUgb25seSBjYXB0
dXJlIHBhdGggLS0gYSB3ZWRnZSBsZWF2ZXMgdGhlIGxhcHRvcCB3aXRoIG5vIGF1ZGlvLg0KDQo9
PSBGYWlsZWQgc3RhdGUgPT0NCg0KRHVyaW5nIGFuIGFjdGl2ZSBjYXB0dXJlIChBTFNBIHN0YXRl
OiBSVU5OSU5HKToNCg0KLSBBdWRpbyBGdW5jdGlvbiBHcm91cCBhbmQgd2lkZ2V0cyByZWFkIFBv
d2VyOiBzZXR0aW5nPUQzLCBhY3R1YWw9RDMsDQppbmNsdWRpbmcNCnRoZSBhdWRpbyBvdXRwdXQg
KE5JRCAweDExKSwgdGhlIEFEQyAoTklEIDB4MTMpLCB0aGUgdmVuZG9yIHdpZGdldCAoMHgxNSkN
CmFuZA0KdGhlIHBpbnMgKDB4MTYvMHgxNy8weDFhKS4gVGhlIG1pYyBwaW4gMHgxYSBoYXMgUGlu
LWN0bHM6IDB4MDAgKGlucHV0IG9mZikuDQotIFRoZSBjYXB0dXJlIGNvbnZlcnRlciBOSUQgMHgx
MyBoYXMgbm8gc3RyZWFtIHRhZyAoc3RyZWFtPTApLg0KLSAvcHJvYy9hc291bmQvY2FyZFgvcGNt
MGMvc3ViMC9zdGF0dXM6IHN0YXRlOiBSVU5OSU5HIGJ1dCBod19wdHIgbmV2ZXINCmFkdmFuY2Vz
Ow0KcmVjb3JkaW5ncyBhcmUgNDQtYnl0ZSAoaGVhZGVyLW9ubHkpIFdBVnM7IGFyZWNvcmQgLUQg
aHc6MSwwIHJldHVybnMNCklucHV0L291dHB1dCBlcnJvci4NCi0gUGxheWJhY2sgc2lkZSBpcyBz
eW1tZXRyaWM6IHBjbTBwIGh3X3B0ciBhZHZhbmNlcyB3aGlsZSBvdXRwdXQgd2lkZ2V0cw0Kc2l0
IGluDQpEMyAtLSB0aGUgc3RhY2sgInBsYXlzIiBpbnRvIGEgcG93ZXJlZC1kb3duIG91dHB1dCBz
dGFnZS4NCi0gQ3J1Y2lhbGx5LCB0aGUgY29kZWMgZGV2aWNlIHN0YXlzIGFjdGl2ZS9EMCAoUENJ
IHBvd2VyX3N0YXRlIEQwLCBoZGF1ZGlvDQpwb3dlci9jb250cm9sIG9uKSAtLSBpdCBpcyB3aWRn
ZXQtbGV2ZWwgcG93ZXIgdGhhdCBpcyBub3QgcmVzdG9yZWQsIG5vdCBhDQp3aG9sZS1jb2RlYyBy
dW50aW1lIHN1c3BlbmQuDQoNCnNuZF9oZGFfaW50ZWwgcG93ZXJfc2F2ZT0wIHBvd2VyX3NhdmVf
Y29udHJvbGxlcj1OIGlzIHNldCBhbmQgdmVyaWZpZWQgbGl2ZQ0KYW5kDQpkb2VzIG5vdCBwcmV2
ZW50IGl0IC0tIGNvbnNpc3RlbnQgd2l0aCB0aGlzIGJlaW5nIHRoZSBzdXNwZW5kL3Jlc3VtZSBw
YXRoDQpyYXRoZXINCnRoYW4gcnVudGltZSBQTS4NCg0KPT0gVGhlIG9uZSAibG91ZCIgb2NjdXJy
ZW5jZSAocG9pbnRzIGF0IHN1c3BlbmQgZW50cnkpID09DQoNClVzdWFsbHkgdGhlIGZhaWx1cmUg
aXMgc2lsZW50LCBidXQgb25jZSBpdCBwcm9kdWNlZCBlcnJvcnMgMS4wNnMgYWZ0ZXINClBNOiBz
dXNwZW5kIGVudHJ5IChzMmlkbGUpOg0KDQphenhfZ2V0X3Jlc3BvbnNlIHRpbWVvdXQsIHN3aXRj
aGluZyB0byBwb2xsaW5nIG1vZGU6IGxhc3QgY21kPTB4MDE2NzBjMDANCk5vIHJlc3BvbnNlIGZy
b20gY29kZWMsIGRpc2FibGluZyBNU0k6IGxhc3QgY21kPTB4MDE2NzBjMDANCmF6eF9nZXRfcmVz
cG9uc2UgdGltZW91dCwgc3dpdGNoaW5nIHRvIHNpbmdsZV9jbWQgbW9kZTogbGFzdCBjbWQ9MHgw
MTY3MGMwMA0KDQpsYXN0IGNtZD0weDAxNjcwYzAwID0gU2V0IEVBUEQvQlRMIEVuYWJsZT0wIG9u
IHBpbiAweDE2IChIUCBwaW4sIHBlciB0aGUNCmNvZGVjDQphdXRvLXByb2JlIGhwX291dHM9MSAo
MHgxNikpIC0tIGkuZS4gdGhlIGNvZGVjIHN0b3BwZWQgcmVzcG9uZGluZyB3aGlsZSBpdHMNCmFt
cA0Kd2FzIGJlaW5nIHBvd2VyZWQgZG93biBlbnRlcmluZyBzdXNwZW5kLCB0aGVuIGRyb3BwZWQg
dG8gc2luZ2xlX2NtZCBtb2RlLg0KVGhpcw0KbWF0Y2hlcyB0aGUgaW4tY29kZSBjb21tZW50IGlu
IHRoZSBTZW5hcnl0ZWNoIHN1Ym1pc3Npb24NCigNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vdXJs
P3E9aHR0cHM6Ly9wYXRjaGV3Lm9yZy9saW51eC8yMDI0MDYwNjAxNTcwMy4zNzExOC0xLWJvLmxp
dUBzZW5hcnl0ZWNoLmNvbS8mc291cmNlPWdtYWlsJnVzdD0xNzg1NDg1MzE1MTkwMDAwJnNhPUUN
Cik6DQoiU29tZSBsYXB0b3BzIHdpdGggU2VuYXJ5IGNoaXBzIHNob3cgc3RhbGxzIGluIFMzIHJl
c3VtZSwgd2hpY2ggZmFsbHMgaW50bw0KdGhlDQpzaW5nbGUtY21kIG1vZGUuIEJldHRlciB0byBt
YWtlIHJlc2V0LCB0aGVuLiINCg0KPT0gRnJlcXVlbmN5IC8gcGF0dGVybiAoMTggb2NjdXJyZW5j
ZXMgb3ZlciB+MTEgZGF5cywgbW9uaXRvcmVkKSA9PQ0KDQotIH4xLTMgcGVyIGRheTsgNTYlIG9j
Y3VyIDA2OjAwLTA5OjAwIChmaXJzdCBjYXB0dXJlIGFmdGVyIG92ZXJuaWdodA0Kc3VzcGVuZC9p
ZGxlKS4NCi0gMTcgb2YgMTggYXJlICJjYXB0dXJlIG5ldmVyIHN0YXJ0ZWQiIChod19wdHI9MCBh
dCBvcGVuKSAtLSBpLmUuIHRoZSBjb2RlYw0Kd2FzDQphbHJlYWR5IGluIHRoZSBiYWQgc3RhdGUg
YmVmb3JlIHRoZSBzdHJlYW0gb3BlbmVkOyAxIHdhcyBhIG1pZC1zdHJlYW0gc3RhbGwuDQotIFJl
Y292ZXJ5IHZpYSByZWNvbmZpZyB2ZXJpZmllZCByZXBlYXRlZGx5IChyZWFsIGF1ZGlvLCBSTVM+
MCwgYWZ0ZXIpLg0KDQo9PSBXaGF0IHJlY292ZXJzIGl0ID09DQoNCldyaXRpbmcgMSB0byAvc3lz
L2NsYXNzL3NvdW5kL2h3Q3hEeS9yZWNvbmZpZyAoYWZ0ZXIgcmVsZWFzaW5nIHRoZSBkZXZpY2Up
DQp0cmlnZ2VycyBoZGEtY29kZWM6IHJlY29uZmlndXJpbmcgKyB0aGUgbm9ybWFsIFNONjE0MCBh
dXRvLXByb2JlIGFuZCBmdWxseQ0KcmVzdG9yZXMgYm90aCBtaWMgYW5kIHNwZWFrZXIuIFRoaXMg
aXMgZWZmZWN0aXZlbHkgYSBtYW51YWwgdmVyc2lvbiBvZiB0aGUNCnJlc3VtZS1jYWxsYmFjayBy
ZS1pbml0IHRoZSBTTjYxODYgcGF0aCBub3cgcGVyZm9ybXMuDQoNCj09IFJlcXVlc3QgPT0NCg0K
UGxlYXNlIGNvbnNpZGVyIGFkZGluZyBTMyByZXN1bWUgaGFuZGxpbmcgZm9yIHRoZSBDb25leGFu
dCBTTjYxNDAgaW4NCnBhdGNoX2NvbmV4YW50IGVxdWl2YWxlbnQgdG8gdGhlIFNONjE4NiB3b3Jr
IGluIHBhdGNoX3NlbmFyeToNCi0gcmVzdW1lIGNhbGxiYWNrOiByZWdjYWNoZSByZS1zeW5jICsg
cmUtYXBwbHkgaW5pdCB2ZXJicyArIHJlLXJlcG9ydCBqYWNrDQpzdGF0ZQ0KKA0KaHR0cHM6Ly93
d3cuZ29vZ2xlLmNvbS91cmw/cT1odHRwczovL2xrbWwuaXUuZWR1L2h5cGVybWFpbC9saW51eC9r
ZXJuZWwvMjYwMy4wLzA3ODg3Lmh0bWwmc291cmNlPWdtYWlsJnVzdD0xNzg1NDg1MzE1MTkxMDAw
JnNhPUUNCiksDQotIGluaXQtdmVyYiAvIGZpeHVwIGZyYW1ld29yaw0KKA0KaHR0cHM6Ly93d3cu
Z29vZ2xlLmNvbS91cmw/cT1odHRwczovL2xrbWwuaXUuZWR1L2h5cGVybWFpbC9saW51eC9rZXJu
ZWwvMjYwMy4wLzA3ODg2Lmh0bWwmc291cmNlPWdtYWlsJnVzdD0xNzg1NDg1MzE1MTkxMDAwJnNh
PUUNCiksDQotIGJ1cyByZXNldCBvbiB0aGUgc2luZ2xlX2NtZCBzdGFsbC4NCg0KSSBjYW4gcHJv
dmlkZSBmdWxsIGRtZXNnLCBjb2RlYyMwIGR1bXBzIGluIGJvdGggaGVhbHRoeSBhbmQgZmFpbGVk
IHN0YXRlcywNCnJhdw0KSERBLXZlcmIgcmVhZC93cml0ZSB0cmFuc2NyaXB0cywgYW5kIHRpbWVz
dGFtcGVkIG1vbml0b3IgbG9ncywgYW5kIEknbQ0KaGFwcHkgdG8NCnRlc3QgcGF0Y2hlcyBvbiB0
aGlzIGhhcmR3YXJlLg0KDQpUaGFua3MsDQpBdHRpbGEgSHVkZWN6DQo=
