Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A1DCD4851
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 07:06:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70A22601B5;
	Wed, 13 May 2026 09:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70A22601B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778655989;
	bh=S4xbOdnk+KIZ5Ar6BtxpcUPTL9vqlItv1Kr8T1oU/TA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dyxk7TCIfo32Fltuv8ZiGI2Aw7NM3Be9jy5uDrDDK73D8Br7r4AievKDQLJv+SPGF
	 T9FDnmh3R/t3vi1k3kgtSi43i6r3xWukVx7DRQN4GsOvj8mAMEYXdSneCYONAdP40e
	 NqETvgdB0UdRnmrvW6+xz2FBZ01b0ZPOYKraO8yk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34369F80579; Wed, 13 May 2026 09:05:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF195F80621;
	Wed, 13 May 2026 09:05:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1859F8049C; Wed, 13 May 2026 01:24:08 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D733DF8001F
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2026 01:24:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D733DF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=svm6AOGn
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-5148cbdea08so37392031cf.2
        for <alsa-devel@alsa-project.org>;
 Tue, 12 May 2026 16:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778628244; cv=none;
        d=google.com; s=arc-20240605;
        b=eavoHXX8QUbMPs2ekHw+GlgBv57XAA29QdIUc7hfM1hYmLGSFsj50mTRXQ7/B0HahN
         IPeOAFnNPaMc/uRyVWUV3GNAstmsHmUEoeDBz9u+dsFLNfNytKG3vqpdFkISEpKXspdG
         1+3GdUeCRoBOtFIbynmrX9eBIIQk8WrTIZkhKIWLM5EwTRruE4BCpGXCWurMTWWP/uQu
         7F/W2QBcGu+j1jv17JPvqRo/CYvRIc5053lhI3yid0zR9ocyju4QX1xnVKt/DyNQzb3s
         ZEl64n02wgUmo6EjXJQoSrZW9WTqROUGdHyjovVGW6pdEBouvcyx6cBKVdrWKbiFPbHO
         d0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CWmgCcv9Q+I8NoSuHmstIoHK+4oSjnL/j8fp5pfGY6o=;
        fh=dBSINSrh+dZtWEP0pR2323P8G/MRu1im4fhQaZzZhOY=;
        b=QjomMbTMCkq4LwxX1MhBrDaJRcNNjH5UeV+mHz1FnCX5uJw5ZMehDfhZAGy8KoupvP
         7ZHZh3dPY2s07L7T5k61IjkV1ARsl92tIGSkEeloWVmUNo0UfDOdes3H1T3qHJT6vR+Z
         71G1bIfsw6IQSYXxF1p6Qzd4dr2vkXIGDTm5ud98W79JClmPjMI+4HIoLwRIAoNqUWYD
         ghJ3Y3VgtDJV0yjKO3a3OiR4J1Z12bqJMx/Jq5/BerDTpT2ofFl+Fqj1WZkPoc/NxdUS
         b7OJWAtRSmDW2DP8LbbZcnBtq6GNl2SNgQuFPEY2959a4uRh2N9t2MCWjLlQGQeciyyK
         D3tg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778628244; x=1779233044;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CWmgCcv9Q+I8NoSuHmstIoHK+4oSjnL/j8fp5pfGY6o=;
        b=svm6AOGnKrz7ocp0JcwFRCnIP7cRMa3JiqmHW0gq9HgHsV/i8cxeFDOUiQhl+4gb93
         vX6jxu8CGRoSq12j8fmPnoBKWrClJns38k0rprgqHDLT3M/DS+HPPE4ERfSvjKh1Nd4a
         nkXX9QPxziREGlJbX5EZNctErqaSVJilOFDs7eFfqVFyRQ8vpifqiOn5qkhlo83qsB/o
         x8lJAbUVeHgKrH29wlJV2xcoABPOuogSmDcKdX0R+1MJdAL2+ku6mOq0p1b4VYpcabQa
         0a1vb13Fs9kqrAat1kmaIe+KdPXm5xi8dzLPFQPcpa9OssN7UGndFPINVNR00kxKeB1F
         lkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778628244; x=1779233044;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWmgCcv9Q+I8NoSuHmstIoHK+4oSjnL/j8fp5pfGY6o=;
        b=p8mARsIl1c/1+7JaB0MLWhfxBfVbj+uBzqemnqYwC38IqN/cWu3kOQI7Iy8KRWWOXr
         H/QyF6sajJQKaemQWTQAKsE6XGJL5Fqv0qhESvnFXlqoBkCCwhtilfpxMktquOoCATMD
         o5VQhTs00ww4d+QQNZjVnL9CNq5s8By9QxKcAQuqC89z3rkZZoPSXaxbIeTBFdP/B98j
         UuewXqlkNLSTa22cSiuv6SCB9Fcg1N0xLR9dKxcQJ9kGhtan5nlWhRNSHRnGMArLRLj3
         pYRWzcdo8dvDO8szm1aPXMFCWx3oFi2B9aQTIMx8u1IsI2hIbeMDZFdG2zttqC5C/ctl
         Jfyg==
X-Gm-Message-State: AOJu0YwvgrdvJ6d+G0kYpomGszlus/w1FPa+GdpEjOeW2BkWPLL98mC0
	rhK3oO4Tt+pCCerXoRmIvDYB9knhnV/LtZgh+GocCDwta1iqmQY6oIwpeJhB0Ahty+XsgmFFEwz
	7UEpfMFmnEbReQJJt7RGsB2ApFbZxpsl7loeE89k=
X-Gm-Gg: Acq92OG2FljOpQzngYdG/zDxGbVy0+S9ufhivCFzh2/eS5Z0CekOW1PSWXHRcl3Aldh
	91Jbz5CmNlXIcmTnaNuZcwAwF2ZPv4rOO7lf9kTY9wjQLs8POk/lAHNC4ToNpj0fs+Ep5bP/ayb
	O9OLD1ZEb5SDiCJbumIHPcYZiUPElKsMRRH2ERoxi4iruEx5AEONXGeyNb7XOlEYar+b9wQvLrW
	bkdjXoaNzoDhNj0B4Dfdva9ddeBUMDQ7okPAF/TVURkvhvriXxS5sKSj+7H5RmRlLWEjV9JZ2l3
	HAya+TMAfXPSVd2RbLoEECxo944nB1olLSYfvx1O
X-Received: by 2002:ac8:5e4a:0:b0:50d:a6a0:8f04 with SMTP id
 d75a77b69052e-5162f60fbeemr10939301cf.42.1778628244436; Tue, 12 May 2026
 16:24:04 -0700 (PDT)
MIME-Version: 1.0
From: Alejandro Barros Argibay <alebararg@gmail.com>
Date: Wed, 13 May 2026 01:23:53 +0200
X-Gm-Features: AVHnY4K5Qlpxss-ctOfxsIw1e2XzUtH0y8cJx8nCEdaICKPYob-PrOWEjMhWe0M
Message-ID: 
 <CACRap3VsCceAkuudzkMFY=DKUBt2fajzkUkjwx-xUGJ1GQk8aw@mail.gmail.com>
Subject: Asunto: SAVITECH JM45 (262a:0001) needs QUIRK_FLAG_DSD_RAW for native
 DSD
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
X-MailFrom: alebararg@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: RKRL27OAYUXRCGKZYZ7WYZBRMHBC4P2B
X-Message-ID-Hash: RKRL27OAYUXRCGKZYZ7WYZBRMHBC4P2B
X-Mailman-Approved-At: Wed, 13 May 2026 07:05:26 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RKRL27OAYUXRCGKZYZ7WYZBRMHBC4P2B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNCkkgaGF2ZSBhIFNBVklURUNIIEpNNDUgVVNCIERBQyB0aGF0IHN1cHBvcnRzIG5hdGl2
ZSBEU0QgcGxheWJhY2sgYnV0DQppcyBub3QgaW4gdGhlIHF1aXJrX2ZsYWdzX3RhYmxlLiBXaXRo
b3V0IGEgcXVpcmssIHRoZSBEU0QgYWx0c2V0IGlzDQpleHBvc2VkIGFzIFNQRUNJQUwgYW5kIHVz
ZXJzcGFjZSBmYWxscyBiYWNrIHRvIERvUCBvciBQQ00gY29udmVyc2lvbi4NCg0KVVNCIGRlc2Ny
aXB0b3I6DQoNCiAgQnVzIDAwMyBEZXZpY2UgMDA5OiBJRCAyNjJhOjAwMDEgU0FWSVRFQ0ggQ29y
cC4gSk00NQ0KDQpSZWxldmFudCBwYXJ0IG9mIC9wcm9jL2Fzb3VuZC9jYXJkTi9zdHJlYW0wICh3
aXRob3V0IHF1aXJrKToNCg0KICBJbnRlcmZhY2UgMg0KICAgIEFsdHNldCA0DQogICAgRm9ybWF0
OiBTUEVDSUFMDQogICAgQ2hhbm5lbHM6IDINCiAgICBSYXRlczogNDQxMDAsIDQ4MDAwLCA4ODIw
MCwgOTYwMDAsIDE3NjQwMCwgMTkyMDAwLCAzNTI4MDAsIDM4NDAwMA0KICAgIEJpdHM6IDMyDQog
ICAgRFNEIHJhdzogRE9QPTAsIGJpdHJldj0wDQoNCkFmdGVyIGxvYWRpbmcgd2l0aDoNCg0KICBt
b2Rwcm9iZSBzbmRfdXNiX2F1ZGlvIHF1aXJrX2ZsYWdzPTI2MmEwMDAxOjB4ODAwMA0KDQpUaGUg
YWx0c2V0IGlzIGNvcnJlY3RseSBleHBvc2VkIGFzIERTRF9VMzJfQkUgYW5kIE1QRCAwLjI0IHBs
YXlzIERTRg0KZmlsZXMgbmF0aXZlbHkgYXQgRFNENjQvMTI4LzI1NiAodmVyaWZpZWQgdmlzdWFs
bHk6IHRoZSBEQUMncyBzdGF0dXMNCkxFRCBzd2l0Y2hlcyBmcm9tIGdyZWVuIHRvIGJsdWUgaW5k
aWNhdGluZyByYXcgRFNEIHJlY2VwdGlvbiwgYW5kDQovcHJvYy9hc291bmQvY2FyZE4vcGNtMHAv
c3ViMC9od19wYXJhbXMgc2hvd3MgZm9ybWF0OiBEU0RfVTMyX0JFKS4NCg0KQ291bGQgUVVJUktf
RkxBR19EU0RfUkFXIGJlIGFkZGVkIGZvciAyNjJhOjAwMDE/DQoNCktlcm5lbDogIGxpbnV4IFNh
bXN1bmcgNy4wLjUtMi1jYWNoeW9zDQooQ2FjaHlPUyByb2xsaW5nKQ0KVGVzdGVkIHdpdGg6IG1w
ZCAwLjI0LjEwLCBhbHNhLWxpYiAxLjIueA0KDQpUaGFua3MsDQpBbGVqYW5kcm8NCg==
