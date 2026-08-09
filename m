Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177BBC5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:26:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC0AF60243;
	Wed, 12 Aug 2026 11:26:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC0AF60243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526787;
	bh=VfxrqZnAvVTkEGRFv/uF4fpWhP7JeGsEoEO7I9pV6V4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=KO9sfVu/4mFuefpCUQSGNtADMeqdzrg2XluGkd3Xe4k9QKBqgc2y4eekZE16yqTlb
	 qaDxWFm7upshm+Qw32ll3ROYpfSeXPoTdKHPNVwRpMpHi8OI0Tx9BP5QMab8s02P/2
	 7s45KYKCeRYFOXNnuLWn9Q4DUnFPGZGATdBG7Ua4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BFBEF806AC; Wed, 12 Aug 2026 11:24:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42F26F806BC;
	Wed, 12 Aug 2026 11:24:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 894DCF8026A; Sun,  9 Aug 2026 14:53:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786279989;
	b=a4fV0Nd0H5OtV9SsuMycKRqanTR896kckKHVi5icRjasl18YBWwKX6pMfcou5kHjzgt4
	 n67a4emAXKgjgyT08HmOtcX2BKGKyKlg3eqvg/YTydL1xw+IsAJV5j3rF+FQkLlhhPsCP
	 yPgRKVuzFUD9zxYChIdkzld7hMxoWW28XPhAJWGlhXVNmpmr7A3B+XSDPV8Cp4EPqKNlm
	 9hLPnBKZJTgyw5EDjYgx37gPU8AJvxiHKBqdcdP/P2x1LR+ERhoAUCUcppVMcq56YlfVb
	 rw6mnncYIcu4Cj8tNiDopc8Ng5pNDLHZ0r6A7DdMhj+o/9eUMJxcGkNREAEEpNn8EAA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786279989;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=POKTinaM2lL5oFBvPcan8mMtoxnadAI7fEcDfrJbMEQ=;
	b=WhAVpcOIDNTFhmqrcAsfvBfXmdIsiNOT0feSiQnSEno71KDnzzSamgCwzF4R3q1LeyuH
	 kW/sooPVFgye/fQsQQNRKmui363QPYZyi2GQVebKA1uVE4ybRDM6Eu5oPY8Qavi+AsACW
	 1qZzGC+xfOr9Eopv8cfYzmMCNIan/YVgX3j2SZOO7XvwT4bU6ALLXAWuC60d4kAPsOg6f
	 RCQPrKDO4jVDnFLwPgmWGgJJkcJnMOqHTxmzrvn1zRiuqbKsKRWpFLEjJKPC1PiLLetRr
	 VSjfG53uMtJBDuUEcuM6Q3ebgZxJAzxeEYmb5gweXTJ/JntHDwmxV7OUsyrfxigktaw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pAjgNuAR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5E54F80240
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 14:53:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5E54F80240
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pAjgNuAR
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so555695f8f.1
        for <alsa-devel@alsa-project.org>;
 Sun, 09 Aug 2026 05:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786279988; cv=none;
        d=google.com; s=arc-20260327;
        b=VSRb9pEiZcPt59GPGMzjiAm+0xOXAU2Af4C1qWasCML/55NxZwIpqipKpEt8dIPdHi
         Pvf7hj2h2sp1TZDW0otC8M1ZglU6fmTNU+rX6cPP6VtW1vPUx5Z6+pAaWTQ0m6QdFkot
         S17a1zlfJoWdPnZLgJRVhoXbjf9WiVfacwmA0y1jUn5ODSXE3L3psi4O43Do+pyOffyw
         baDthAsV8FdIQF/tgQFa5BwDRDhryLPd3FjuQWe07jgnwuCQIgd1mZQRkHn1mEJDB/Tf
         NWyry+GstjkHPnFAFFv85g3R0kf60sjSFoQh13mrSB1XQqrLIDk12qW6+crPq5Plr6vL
         jZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=X8l4LwXCQ/gabwv/JCpXYGexVh0j2DJnAUr4ZINsAS0=;
        fh=9Zdl++5Dnv6hsojrpgD7emxCQGHpzNTh0zZVjUx1wWw=;
        b=UgAnQ1NQodtGTxWHgiBnzbfS37QMMq5jvTMT9NZHdLcP8e2WpRlfHLpkXYZKqm0vUI
         kXd8p8Te64RQxaQxC0y0/iof4WlyQWmW7XekFXsWlhe+uil2TIZpLUnadJkj/hMjOIXd
         UwD0iP9Bki+JdK/Ri8c55oNKQk1U/LU9B1HsdAd3GUvNvBgiLzfPpWaNE763NYz6plMH
         7OP8S4u8+2OiUfIQDLS4IaraWc/dpEslU0tif98TsOMYfEEI1QV5WAlY86B3Qbhtut50
         PXgzXut9sPb7MjyaUtYNUg1uaZnYvIWcPfZTXa8Jooyz19/O/AJj8Xhe7O40Z1XiD+Ec
         EktA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786279988; x=1786884788;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X8l4LwXCQ/gabwv/JCpXYGexVh0j2DJnAUr4ZINsAS0=;
        b=pAjgNuARXuYtonu3woITDUGDjKJROrnTrklHbuXtw3waO0P3oOwTHhVW2FOhO0zyaz
         rmzBVtUZ7utHzwi14HJBFNwzorG1Oain0dLInQwPQRLvsahFpsoMP0F54bqKdUO94+jw
         NC/Bnat9PZPMxik9JeVU+Mp0zzZQDd4cQJaE86Z/lZyXZ9ssp/RKhMDWue4WI5X/XRpf
         hSgkWS8Fkxmbg0JRqZaLVeZ+zd00rYE8SFhSk6ReFptAflQxBIAkuNK6B8lokuNAuEm+
         PduzmauHn48wtcvd1fUHLkRIEX7t1O2k2lRuG7SgB99jGXfnNKoJl1z9hJmCwf8bQkzF
         LR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786279988; x=1786884788;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X8l4LwXCQ/gabwv/JCpXYGexVh0j2DJnAUr4ZINsAS0=;
        b=s5ZPEuJrmXshx2UqH8YpMqj7LnkUYgSr1IxdsAdkCx8Es3Jxm1Y5GB6JkNY/YLOPzP
         RPfnRR5xg0cxKVrsZBpZ1HkrTbw8e/fuL2WAnaGxq92uXbibR/LOt7hzaMuGMnk6oZS2
         zfxjmuaD8Q5SwNfrt6kdBGOhyWjPMuno1RaHoGGhxg8TuB2uoo8X9Az+IOSuyKrzdZ56
         e8QNHW54twEKOiIhP6XXvm/NjNrfnZHB9UAJCM6zbqX6+311NnrAQqTmtDCe5/ITLO1f
         O+TSOMg4pib2Cl2ZV5GCF8/X5bfWw3G69obZbzeIHZiyEtwi7cfwNMbj6v8/uJzOE0VP
         uKhA==
X-Gm-Message-State: AOJu0YxJV9TEhJ1yFqFXYVq6YdBDvJ9Hrfac/RuxybqGV6JN4VbPIAaZ
	zeelSwmhE7HMWAGyyAxr6GkVvrcdygNFWx3k/yRklr+jyvFRYzYUGlI/KoPLA5OZcuQXjDZ2XYn
	Pzow7/7KLF4mkNIGEoVaWPvb8uZuWwCsmRunF
X-Gm-Gg: AR+sD11wfZzv58+I/qxNnDoNT7dVOfKO9nLnySBf/O48gr5gUizSiAEMb8gzC5KQR1O
	7neWju4zM9rE2eRI0+px0etH9g5miD+BmYnYBMXVVkcl/z1l6cnk1OCwiIUxkO+di5XO9TfhXMA
	3x+ffbe+8sm1VNvbd3HuV/9CNA2jNNfYbaJitJJjtzNp0eXVfvy7XrNC2kIpxUSVlJK3GMJ6fXG
	uGIZp9Vn534UR5yOzPg8oJVrpkmsXcZYfAiNRTl07HDzlCyHHKa9LIYFXK6WIp8tXGiPTpg0KbW
	PkherSut+u3X/7zSAAODd3grXb29T6KnzJRWiP7VMbF2DQUkkpK4Xgc=
X-Received: by 2002:a05:6000:18a6:b0:47f:96f9:a99f with SMTP id
 ffacd0b85a97d-47fec50830fmr48395329f8f.13.1786279987649; Sun, 09 Aug 2026
 05:53:07 -0700 (PDT)
MIME-Version: 1.0
From: Alexandru <eraleexxx@gmail.com>
Date: Sun, 9 Aug 2026 14:52:55 +0200
X-Gm-Features: AUfX_mwLbPOWEyBlDUigPcIYchSlPrpSxNidTiqQ7c_DWMN5y6nzJ2SGy1Z9GSU
Message-ID: 
 <CAB-5r0nx0fxnvoYqwHHfuGMuXngPk_AuXa=Q2RjCun2xRpt5og@mail.gmail.com>
Subject: [PATCH/BUG] ALSA: acp6x: Add DMI/PCI quirk for HP 255R G10 internal
 microphone (103c:8d22)
To: alsa-devel@alsa-project.org
Cc: mario.limonciello@amd.com, vijendar.mukunda@amd.com
X-MailFrom: eraleexxx@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 6OZZJSR3EBICLDLK6LTQYOE2G7RNU2GC
X-Message-ID-Hash: 6OZZJSR3EBICLDLK6LTQYOE2G7RNU2GC
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:24:47 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6OZZJSR3EBICLDLK6LTQYOE2G7RNU2GC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNClRoZSBpbnRlcm5hbCBkaWdpdGFsIG1pY3JvcGhvbmUgKERNSUMvUERNKSBvbiB0
aGUgSFAgMjU1UiBHMTAgbGFwdG9wIGlzIG5vdA0KZGV0ZWN0ZWQvd29ya2luZyB1bmRlciBMaW51
eC4NCg0KU1lTVEVNIElORk9STUFUSU9OOg0KLSBNb2RlbDogSFAgMjU1UiBHMTANCi0gQ1BVOiBB
TUQgUnl6ZW4gNyA3NzM1VSAoUmVtYnJhbmR0LVIgLyBZZWxsb3cgQ2FycCkNCi0gQUNQIFBDSSBE
ZXZpY2U6IDEwMjI6MTVlMiAocmV2IDYwKQ0KLSBTdWJzeXN0ZW0gSUQ6IDEwM2M6OGQyMg0KLSBU
ZXN0ZWQgS2VybmVsczogNi54IC8gNy54IChDYWNoeU9TIC8gQXJjaCBMaW51eCkNCg0KUFJPQkxF
TSBERVNDUklQVElPTjoNClRoZSBBTUQgQUNQIDYueCBQQ0kgZGV2aWNlICgxMDIyOjE1ZTIpIGlz
IGJvdW5kIGJ5IHRoZSBgc25kX3BjaV9hY3A2eGANCmRyaXZlciwgYnV0IG5vIEFMU0EgRE1JQy9Q
RE0gUENNIGNhcHR1cmUgZGV2aWNlIGlzIGluc3RhbnRpYXRlZCAoYGFyZWNvcmQNCi1sYCBvbmx5
IGxpc3RzIHRoZSBIREEgQUxDMjM2IGNvZGVjKS4NCg0KSW4gV2luZG93cywgdGhlIGludGVybmFs
IG1pY3JvcGhvbmUgd29ya3MgcHJvcGVybHkgdGhyb3VnaCB0aGUgQU1EIEF1ZGlvDQpDb1Byb2Nl
c3NvciBkcml2ZXIgKGFtZGFjcGJ1cy5zeXMpIHVzaW5nIEhQIERNSUMgZXh0ZW5zaW9ucw0KKGBh
bWRkbWljZXh0dF9ocF8qLmluZmApIGFuZCBpcyBwcmVzZW50ZWQgYXMgIk1pY3JvcGhvbmUgQXJy
YXkgKEFNRCBBdWRpbw0KRGV2aWNlKSIuDQoNCkluIExpbnV4LCB0aGUgYm9hcmQgc3Vic3lzdGVt
IElEICgxMDNjOjhkMjIpIGFwcGVhcnMgdG8gYmUgbWlzc2luZyBmcm9tIHRoZQ0KRE1JIG1hdGNo
IHRhYmxlIGluIGBzb3VuZC9zb2MvYW1kL3ljL2FjcDZ4LW1hY2guY2AgKG9yIGVxdWl2YWxlbnQg
QUNQIDYueA0KbWFjaGluZSBkcml2ZXIpLg0KDQpETUkgLyBQQ0kgREVUQUlMUzoNClZlbmRvciBJ
RDogMHgxMDIyDQpEZXZpY2UgSUQ6IDB4MTVlMg0KU3Vic3lzdGVtIFZlbmRvcjogMHgxMDNjDQpT
dWJzeXN0ZW0gRGV2aWNlOiAweDhkMjINCg0KYGxzcGNpIC1ubmsgLXMgMDM6MDAuNWA6DQowMzow
MC41IE11bHRpbWVkaWEgY29udHJvbGxlciBbMDQ4MF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMs
IEluYy4gW0FNRF0NCkF1ZGlvIENvcHJvY2Vzc29yIFsxMDIyOjE1ZTJdIChyZXYgNjApDQpTdWJz
eXN0ZW06IEhld2xldHQtUGFja2FyZCBDb21wYW55IERldmljZSBbMTAzYzo4ZDIyXQ0KS2VybmVs
IGRyaXZlciBpbiB1c2U6IHNuZF9wY2lfYWNwNngNCktlcm5lbCBtb2R1bGVzOiBzbmRfcGNpX2Fj
cDZ4LCBzbmRfc29jX2FjcDZ4X21hY2gNCg0KUmVxdWVzdGluZyB0byBhZGQgYSBxdWlyay9lbnRy
eSBmb3IgRE1JX0JPQVJEX05BTUUgIjhEMjIiIC8gU3Vic3lzdGVtDQoxMDNjOjhkMjIgdG8gZW5h
YmxlIEFDUCBQRE0vRE1JQyBzdXBwb3J0IGZvciB0aGlzIGxhcHRvcCBtb2RlbC4NCg0KQmVzdCBy
ZWdhcmRzLA0KQWxleA0K
