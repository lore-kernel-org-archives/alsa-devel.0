Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DF2FF885A
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:35:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B63360205;
	Mon,  4 May 2026 13:35:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B63360205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894513;
	bh=lW+D560PuMz9H6AG1H85+U+4XtXxO3i+/t9n6366iGA=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lE9MMEzOkwSzNR5t1sjRRw+3OiYw35iJML/QwxhQ2QyJPEx1MbcqImXv+oZ5NrOKc
	 4Wwcf5+iKnd+PUQDosCGAJBcgc+3tA11sHiNkm/YWKngHGRG7frYrZEbims/XZwBII
	 Y+JTO6jwGsmGbK0FoB4gnhQOQxKde9ic2ib/LhrA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06A4AF80600; Mon,  4 May 2026 13:34:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A59AEF80602;
	Mon,  4 May 2026 13:34:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3467F802BE; Thu, 30 Apr 2026 22:00:35 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99098F80154
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2026 22:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99098F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gtKzEov3
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8b3d6b215cfso18306906d6.3
        for <alsa-devel@alsa-project.org>;
 Thu, 30 Apr 2026 13:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777579230; cv=none;
        d=google.com; s=arc-20240605;
        b=Nr01OeXARrfM2JOPv/o9U+2KuHC9kcSfIZhfrJPO+C4gNs2X+aFy/CM38td9UOzqSo
         4sSdTw3kr0qsHHWIVOvdFFT5DAy72IPek9Zlu1Ca5uOD73CGFI2Ve6vi1nZAne7OC6jh
         dzNV/7StFHqqAqcCqsDYcWnT6s80+VVrnSjiUmeMf4fYgKg+99ShrFLA1tquoob74gzp
         e+HcdEOKA3Y/MA+n4MIec63D9gBBxj7nrsO8y/u8dRLgWo18ZVaUm0nnECe+TzKgUyej
         +Q1Iu8hx7F3Zh4sjBacnkUgzDgnzVEsVoBO5REOTTP6b2W+IUBkLr+w9Giyrbv8xMCld
         0mHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ct854h8PfGHw7ZvZrKJ34RvP4cjTnNKYWdU3LvzvWmY=;
        fh=u9tMOiwAdMJM1Xkoid39Ndxk/MmNqtB2utGbZ7lwtI0=;
        b=IPa7Fbl5RjFWGkBkzF5J9bYz1qrPYlpVDTvpRLVKvh+ruT/NDOc2tcYmAfOEuJQqUB
         ultSYGaXBeTJP9+IkRBFrpvC4GCtlyB/JYfC/8zIWxujUzM7hhsIEjkUEsrcUd6nWXU3
         83x0rzNlfJ7467ik9akXBv04Lcp41CdUNG14f0iNw+qDgguLZ+83aozlWyj5AkxmQBbq
         8xXMIpkJDh0e/XCXqfFkM9e/3ob2CaYQ+oKxlpwNFS5v3vVneKYIDPstDK3J8paR6iWo
         +U+bxl7NCYBfTnIJ5b1nmzB4sieXC12ZM3ydJrGhUgfaoOYVglOfKtxa4NVeNaAB72Y/
         hAPw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777579230; x=1778184030;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ct854h8PfGHw7ZvZrKJ34RvP4cjTnNKYWdU3LvzvWmY=;
        b=gtKzEov3m7tYz9cFlLHAZRx2GNzvZg5WviIKa+RBPqxbEIJadk9B+rGe4qePH1BYLn
         medobmfQM2hxyEeqL260sehHu/uPpIjYqCoX6bDZII6fbrTLNJADS78RGBfLAFqiP7dy
         7Ryp+MO5/cg2PGsQy5Uq1czZYQ9Yx3+GtMBcu0fi7abDdpeRf1SBT9q7nDXdsfne4yZt
         e2ic7F+PcCPRXQEdpgt9+wOxTaIZNWpWrWR7gROJC724m/Q2SRg5g3lhGdDbH0Qhk4LX
         1D4PS1NQ9Bf4idhX6rAFNv9kYdQIykuPguNvlsdytHg1IteFiHW+81YPZBcEcvYGrhxa
         oOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579230; x=1778184030;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ct854h8PfGHw7ZvZrKJ34RvP4cjTnNKYWdU3LvzvWmY=;
        b=oFWOvaKWggndF0XZa+wTBkWTlnqbDKm3yZe2hZuI1qn/yiMGEO1nxcih/d2X9OXmQ7
         cTV82axNwGtik8HCkKBJI5uGcpPZsmlznaWDNOeaCiorRInY9XJF0h42bb/WFXrCGBBZ
         WmL80lLhS29PU2WC8aAf4H8d6aZVsp4XMJzfP1v0gkiyJiBC9Pka4Wcb9fZ7tri3p9I1
         x8amOfBWAA7cMiHy4eIDuYijpVON26Qzhc/cSXCiUgMBTKF9oyvt6UAJ0h+lTykVcqaJ
         litBix/y2xTOsynrWpufkkgK4aEclGADgoSM94C3Z3hhzcsam8BylZsU5HNP5ORAZtsG
         3bUQ==
X-Gm-Message-State: AOJu0Yx7Kjay1674XZ9lHelTYrR3aVMJ5N6UktU3ZACSfIHie9a5X5ra
	wUc4feh1WBL1rckcYS2RXgtXdMwShVLa1eRjxjgHaRG23tojTedT6h2n8NOk3RItgQ1cURS3Z9A
	9sLMsToy1oTK7sLakKbkIgeEv0mWeIPHerw==
X-Gm-Gg: AeBDievvngJFQ73sgerOUb0KymJvM6tHUpqk6QZqr/f4HqbW9Xgje5VYoNDKusenu14
	hjmr1GKf12OXCTvRlZnlyHcvMwPoZ/Oq0diSDp5hbIG43U+2MPQh5Yj9//af3ZnbouXiYFE9H5X
	P0ymHAIrgcDWuN6RdZcbDb6kJk/KqXoYV7nr7c65RbANYi1iPKExMJEAn8IkEB7lwjsE216IzLO
	WfaD21ahM7rfoIGAH8IyPJpxEzIbSj+Q6isUGTB8uLGNmNOicEGURr2KNvzk/r2ef4Qv1iL5pqB
	p/r5jIZrZ1LQD3hjwSvIY1zjI6yVLeB+CDR5s3uIxbLG1DDg5q6P
X-Received: by 2002:a05:622a:1455:b0:509:965f:888f with SMTP id
 d75a77b69052e-5102a942c12mr62517041cf.0.1777579225928; Thu, 30 Apr 2026
 13:00:25 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0KHQsNC90Y8g0J/RgNC+0L3RgdGM0LrQuNC5?=
 <sanapronskij96@gmail.com>
Date: Thu, 30 Apr 2026 23:00:12 +0300
X-Gm-Features: AVHnY4IAo7rM-8k5yWjSxhOGIRWfc8I_TNZESL5OM2BB5bNUEa0d8WxP-eHXWBc
Message-ID: 
 <CAJ8cwZTBJ97OOh_bOP5y2_RujpZB_wtumJ0uvkatp4vSf+y+7Q@mail.gmail.com>
Subject: AACI driver bug
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="0000000000005338fd0650b2ea59"
X-MailFrom: sanapronskij96@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: P46HKR7GL7WYNSWRGFMLLWKNJY7ATH4D
X-Message-ID-Hash: P46HKR7GL7WYNSWRGFMLLWKNJY7ATH4D
X-Mailman-Approved-At: Mon, 04 May 2026 11:34:17 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P46HKR7GL7WYNSWRGFMLLWKNJY7ATH4D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--0000000000005338fd0650b2ea59
Content-Type: text/plain; charset="UTF-8"

Hello,
I've noticed a potential race condition in the AACI driver
(sound/arm/aaci.c).
The current implementation of aaci_fifo_irq() accesses the substream pointer
outside the spinlock-protected area, which could lead to a NULL pointer
dereference or use-after-free if the substream is released in a parallel
thread.
This patch ensures the substream pointer is safely captured under the lock
before use.
Best regards,
Alexander Pronskiy

--0000000000005338fd0650b2ea59
Content-Type: text/x-diff; charset="US-ASCII"; name="0001-fix-aaci-race.patch"
Content-Disposition: attachment; filename="0001-fix-aaci-race.patch"
Content-Transfer-Encoding: base64
Content-ID: <19ddffa37d113ac950e1>
X-Attachment-Id: 19ddffa37d113ac950e1

RnJvbTogQWxleGFuZGVyIFByb25za2l5IDxzYW5hcHJvbnNraWo5NkBnbWFpbC5jb20+CkRhdGU6
IFRodSwgMzAgQXByIDIwMjYgMjI6NDU6MDAgKzAzMDAKU3ViamVjdDogW1BBVENIXSBBTFNBOiBh
YWNpOiBGaXggcG90ZW50aWFsIHVzZS1hZnRlci1mcmVlIGluIGFhY2lfZmlmb19pcnEKClRoZXJl
IGlzIGEgcmFjZSBjb25kaXRpb24gaW4gYWFjaV9maWZvX2lycSgpIGJldHdlZW4gdGhlIGludGVy
cnVwdCBoYW5kbGVyCmFuZCB0aGUgUENNIGNsb3NlL3N0b3Agb3BlcmF0aW9ucy4gVGhlIGZ1bmN0
aW9uIGNoZWNrcyBmb3IgdGhlIGV4aXN0ZW5jZQpvZiBhYWNpcnVuLT5zdWJzdHJlYW0gYXQgdGhl
IGJlZ2lubmluZyBvZiBlYWNoIGludGVycnVwdCBibG9jaywgYnV0IHRoZQphY3R1YWwgY2FsbCB0
byBzbmRfcGNtX3BlcmlvZF9lbGFwc2VkKCkgb2NjdXJzIG91dHNpZGUgdGhlIHNwaW5sb2NrCnBy
b3RlY3RlZCBhcmVhLgoKSWYgdGhlIHN1YnN0cmVhbSBpcyByZWxlYXNlZCBhbmQgbnVsbGVkIGlu
IGFub3RoZXIgdGhyZWFkIChlLmcuLCBkdXJpbmcKYWFjaV9wY21fY2xvc2UpIGFmdGVyIHRoZSBz
cGlubG9jayBpcyByZWxlYXNlZCBidXQgYmVmb3JlIHRoZSBjYWxsYmFjayBpcwpleGVjdXRlZCwg
aXQgbGVhZHMgdG8gYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ugb3IgdXNlLWFmdGVyLWZyZWUu
CgpUaGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBjYXB0dXJpbmcgdGhlIHN1YnN0cmVhbSBw
b2ludGVyIGludG8gYQpsb2NhbCB2YXJpYWJsZSB3aGlsZSBob2xkaW5nIHRoZSBzcGlubG9jayBh
bmQgdXNpbmcgdGhhdCBsb2NhbCB2YXJpYWJsZQpmb3IgdGhlIGNhbGxiYWNrIG9ubHkgaWYgaXQg
d2FzIHZhbGlkIGR1cmluZyB0aGUgY3JpdGljYWwgc2VjdGlvbi4KClNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRlciBQcm9uc2tpeSA8c2FuYXByb25za2lqOTZAZ21haWwuY29tPgotLS0KIHNvdW5kL2Fy
bS9hYWNpLmMgfCAxNCArKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvYXJtL2FhY2kuYyBiL3Nv
dW5kL2FybS9hYWNpLmMKaW5kZXggZDY1NDNiMS4uZTgyMmExMiAxMDA2NDQKLS0tIGEvc291bmQv
YXJtL2FhY2kuYworKysgYi9zb3VuZC9hcm0vYWFjaS5jCkBAIC0xNTUsNiArMTU1LDcgQEAgc3Rh
dGljIHZvaWQgYWFjaV9maWZvX2lycShzdHJ1Y3QgYWFjaSAqYWFjaSwgaW50IGNoYW5uZWwsIHUz
MiBtYXNrKQogCWlmIChtYXNrICYgSVNSX1JYSU5UUikgewogCQlzdHJ1Y3QgYWFjaV9ydW50aW1l
ICphYWNpcnVuID0gJmFhY2ktPmNhcHR1cmU7CiAJCWJvb2wgcGVyaW9kX2VsYXBzZWQgPSBmYWxz
ZTsKKwkJc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW07CiAJCXZvaWQgKnB0cjsK
IAogCQlpZiAoIWFhY2lydW4tPnN1YnN0cmVhbSB8fCAhYWFjaXJ1bi0+c3RhcnQpIHsKQEAgLTE2
NCw2ICsxNjUsOCBAQCBzdGF0aWMgdm9pZCBhYWNpX2ZpZm9faXJxKHN0cnVjdCBhYWNpICphYWNp
LCBpbnQgY2hhbm5lbCwgdTMyIG1hc2spCiAJCX0KIAogCQlzY29wZWRfZ3VhcmQoc3BpbmxvY2ss
ICZhYWNpcnVuLT5sb2NrKSB7CisJCQlzdWJzdHJlYW0gPSBhYWNpcnVuLT5zdWJzdHJlYW07CisJ
CQlpZiAoIXN1YnN0cmVhbSkKKwkJCQlyZXR1cm47CisKIAkJCXB0ciA9IGFhY2lydW4tPnB0cjsK
IAkJCWRvIHsKIAkJCQl1bnNpZ25lZCBpbnQgbGVuID0gYWFjaXJ1bi0+Zmlmb19ieXRlczsKQEAg
LTIwNCw4ICsyMDcsOCBAQCBzdGF0aWMgdm9pZCBhYWNpX2ZpZm9faXJxKHN0cnVjdCBhYWNpICph
YWNpLCBpbnQgY2hhbm5lbCwgdTMyIG1hc2spCiAJCQlhYWNpcnVuLT5wdHIgPSBwdHI7CiAJCX0K
IAotCQlpZiAocGVyaW9kX2VsYXBzZWQpCi0JCQlzbmRfcGNtX3BlcmlvZF9lbGFwc2VkKGFhY2ly
dW4tPnN1YnN0cmVhbSk7CisJCWlmIChwZXJpb2RfZWxhcHNlZCAmJiBzdWJzdHJlYW0pCisJCQlz
bmRfcGNtX3BlcmlvZF9lbGFwc2VkKHN1YnN0cmVhbSk7CiAJfQogCiAJaWYgKG1hc2sgJiBJU1Jf
VVJJTlRSKSB7CkBAIC0yMTYsNiArMjE5LDcgQEAgc3RhdGljIHZvaWQgYWFjaV9maWZvX2lycShz
dHJ1Y3QgYWFjaSAqYWFjaSwgaW50IGNoYW5uZWwsIHUzMiBtYXNrKQogCWlmIChtYXNrICYgSVNS
X1RYSU5UUikgewogCQlzdHJ1Y3QgYWFjaV9ydW50aW1lICphYWNpcnVuID0gJmFhY2ktPnBsYXli
YWNrOwogCQlib29sIHBlcmlvZF9lbGFwc2VkID0gZmFsc2U7CisJCXN0cnVjdCBzbmRfcGNtX3N1
YnN0cmVhbSAqc3Vic3RyZWFtOwogCQl2b2lkICpwdHI7CiAKIAkJaWYgKCFhYWNpcnVuLT5zdWJz
dHJlYW0gfHwgIWFhY2lydW4tPnN0YXJ0KSB7CkBAIC0yMjUsNiArMjI5LDggQEAgc3RhdGljIHZv
aWQgYWFjaV9maWZvX2lycShzdHJ1Y3QgYWFjaSAqYWFjaSwgaW50IGNoYW5uZWwsIHUzMiBtYXNr
KQogCQl9CiAKIAkJc2NvcGVkX2d1YXJkKHNwaW5sb2NrLCAmYWFjaXJ1bi0+bG9jaykgeworCQkJ
c3Vic3RyZWFtID0gYWFjaXJ1bi0+c3Vic3RyZWFtOworCQkJaWYgKCFzdWJzdHJlYW0pCisJCQkJ
cmV0dXJuOworCiAJCQlwdHIgPSBhYWNpcnVuLT5wdHI7CiAJCQlkbyB7CiAJCQkJdW5zaWduZWQg
aW50IGxlbiA9IGFhY2lydW4tPmZpZm9fYnl0ZXM7CkBAIC0yNjUsOCArMjcxLDggQEAgc3RhdGlj
IHZvaWQgYWFjaV9maWZvX2lycShzdHJ1Y3QgYWFjaSAqYWFjaSwgaW50IGNoYW5uZWwsIHUzMiBt
YXNrKQogCQkJYWFjaXJ1bi0+cHRyID0gcHRyOwogCQl9CiAKLQkJaWYgKHBlcmlvZF9lbGFwc2Vk
KQotCQkJc25kX3BjbV9wZXJpb2RfZWxhcHNlZChhYWNpcnVuLT5zdWJzdHJlYW0pOworCQlpZiAo
cGVyaW9kX2VsYXBzZWQgJiYgc3Vic3RyZWFtKQorCQkJc25kX3BjbV9wZXJpb2RfZWxhcHNlZChz
dWJzdHJlYW0pOwogCX0KIH0KLS0gCjIuNDMuMAo=
--0000000000005338fd0650b2ea59--
