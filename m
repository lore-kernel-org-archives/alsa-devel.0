Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0281F46C69
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:14:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 930FD601F4;
	Mon,  6 Apr 2026 20:14:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 930FD601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775499279;
	bh=Q1SXMtCjU3iBl5tv70DL7BY1NnM6cZpDZtmE+SIaxdo=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Om6vxJhJUn/lZmAGN3FfnNDDw/jms5/8ZtpQV5be7YOpLr9rre3hNJvgPxIBGctxj
	 37JUstysW0RPm7PQ1LG3eMGlJTdu9HtKPJAqXNhfnJjIzvBEqAZHy0906LefqPt44K
	 n5iH/mighGQpvrNEUzOJCwik0GzH7UJvNF4jzbJM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60238F805F2; Mon,  6 Apr 2026 20:14:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 06358F805EB;
	Mon,  6 Apr 2026 20:14:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1CE2CF8049C; Mon,  6 Apr 2026 20:13:57 +0200 (CEST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4C634F80212
	for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2026 20:13:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C634F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CHhqOpEM
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-38ded5277e5so13635141fa.1
        for <alsa-devel@alsa-project.org>;
 Mon, 06 Apr 2026 11:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775499234; cv=none;
        d=google.com; s=arc-20240605;
        b=U14h3UMas1U5AwHe24AC4Q/JHa/ECpx2Awt+4jOM61rmC/DtbfqAly7jlsSuJXGbDJ
         7Kt43N0r1gazCbzeViByR6pHareSZC+OfC4JSbZxVt5N70RdqjV67YRyrBcYXfmlekat
         ienrO3NodULv4F1hrA6CovsWKsIRTLGiPKLaRte0j9YTnOKixtXet4yjgjebtJdcSSmb
         0COjLr8y89bBijucARMhM1TlLShrgxQokaardaiKKlKNqoPYXR4m/NPCfXU8FOEQ967+
         wPcaM/b1gxGJth2qWJr8aSzlw2iWkk+2vB66eNznC1WdbOEklFWnzoeVfNQ6nMEXhhJJ
         35NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CoRq9FoVhv5ztwxa/B4XF+4Lu8o1r/U1vo1GnUcamHU=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=eySiSfL1ZXlVHpECxKhKRRulACrOKjjN/MDt5JjMxnjJ+UxLn4P7hGGwa2Pzm4SjUO
         BAhC+kVhnikC7vUoEhplk5B1D4/IG4DsvMdSMvIvtKMvc/vwKM+KvOF7pRzBEVbvr6kH
         LVa81Sk2hTH8lsvebNX9KTQ+FSiiOegiW8WKngmJQSgceKcN2u1C7vUD8MRrPFXilrly
         GF72Q5y1kBAU+41PjwSttVDgaQKEFoSu/wZlfRii7ZK+MYfnjc6qRptL7n4Ty18kk5ac
         Ubk23++O/Tf5sYT3OBuRX81MIynbIevQz5ff8wc7rCbPG1wNQm6SiQqHBUNgxNFXtuna
         /a+Q==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775499234; x=1776104034;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CoRq9FoVhv5ztwxa/B4XF+4Lu8o1r/U1vo1GnUcamHU=;
        b=CHhqOpEMuar9kWGtoEO06sDHNSGLOF30RFE0cKlmQAFbQcKkwW7MsBGQgVXHd5Hu3s
         xLb4nkHCFXhO40VTL+qb/yKXCq8rGHuZtecMrjF3tMd7jDSe5VwgfKMEgb3xwNIW7g4m
         m0SvVrZl/0IXn0Xcz3fGe7+fHzHclLQxPdQVWoW0xBUtABW/rudiaHjAA+7MUUySBw5f
         Z6LpTSOecnJ1DSd7qr1rGqRcAYlxtcYwDNrHsz6IIOtZIeQOxWLvkBRGsgTCd7VtC55C
         w5ISk32Nb63Fym9c5XsNvvFD7OrVPd3CB6mBUgpug+PZGgjzz/Z0H2gKAawqNMjhJP3S
         wDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499234; x=1776104034;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CoRq9FoVhv5ztwxa/B4XF+4Lu8o1r/U1vo1GnUcamHU=;
        b=jJuBSu+ZgDnwEZAge6xrYrP3gehJ2DIq31uxhu0Rzn5ndz1ZvhkpYd3Al62sW1iqnm
         rkUkjRb3HOqJZdv7DQAa1YhiRRn6MPV1jLtXBggIUe17uRZrmIsXd3BGP1Gtwaqbbvfh
         3sBKgtV8Wr5SIBh4EI3y9Axhg+MoaqIQO+BT+wAsaMB92HrSmFBqlK8zQccdA898q+vV
         n24niCqXBnvyR/K2ln1L69wifhSvMi564+v3620uyRYPZfTnFo5WeLbbZWfSh0agl5C0
         34GDhJDxijae7oY1lonxdrXeXzC1eJxOND02omYBjLDOSEcXQfEQVkDuhkOxfwuvjo2a
         kx8g==
X-Gm-Message-State: AOJu0Yy7a3STmCGC4CiV58nWe6v1rIYE7eamfo4PVol4C/LHVixiQ9Xv
	3mJQvma+lmZaARy8X9Lk+D0nJd/3fNz5EQXMMoxB2OhQilFgkUgA8lwagj/Tn7uvufoiURyvW2g
	FHER9k08DwTJ4motYwHVNXa1NjscMKliR9Z/m/0w=
X-Gm-Gg: AeBDietUchdBzIC9saH+HLlS5geOSQvomNvLuk3uXanc+LTnOsKyv9V5HmWKX85lTP/
	zzRzBx3+Mykzn+GJdnFEArY35G3/HXNDaPHWtgO1nYrwEknLYnEbLAQjU5f8hmipCbCwowbcsXY
	EyOpoO4AqGmK0k++vYCYNgzuowCrqwVIIfMhM1tQMm1bKcmdvTMQk3PxA4h7pKrsLHz1q52nzCI
	7Khy2MzznSg+WCBSiHN1u2vUUhlhnK/8aw+WbA0Eq1DuveTWoYHpSxoz+i/kpmvpvYo0UBN/PMq
	uwVNuJlEpA==
X-Received: by 2002:a05:651c:f17:b0:38a:5f1e:5a27 with SMTP id
 38308e7fff4ca-38d8d1d8622mr40553021fa.0.1775499233658; Mon, 06 Apr 2026
 11:13:53 -0700 (PDT)
MIME-Version: 1.0
From: Kumar S <nishantsingh2jan1998@gmail.com>
Date: Mon, 6 Apr 2026 23:43:40 +0530
X-Gm-Features: AQROBzAgZxjUfFxPxUc6coXB7TEIstybl_hJSQyKWv1_OQSeGwe2StNj4dOQtw8
Message-ID: 
 <CAPPx52yV5mpXZp88FRw=P_V6eiejFvYJohyJ-RUqFSRzKen8dw@mail.gmail.com>
Subject: [PATCH] aplay: use snprintf instead of sprintf in device_list()
To: alsa-devel@alsa-project.org
Message-ID-Hash: OIK4ATAS52GTRZPT7LL24BOHWC5D4FL5
X-Message-ID-Hash: OIK4ATAS52GTRZPT7LL24BOHWC5D4FL5
X-MailFrom: nishantsingh2jan1998@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OIK4ATAS52GTRZPT7LL24BOHWC5D4FL5/>
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
