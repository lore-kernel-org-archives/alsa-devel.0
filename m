Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA20BC531D0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:25:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27A62601FD;
	Fri, 24 Jul 2026 04:25:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27A62601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784859955;
	bh=5PqKbXOu7pgHahvADmV/VVY9dR6aeSWAtzLqt//anPY=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=fhCkW6SZGkoy3EfQ29VJGuFemOP/0F08siNX+0/+l/eIl1c+SkGbC+08uA6izdb6G
	 comLo4MJIBiif+G4TR8J1eHi4q9cKSo9Yv6QUz/EO4FBOLEYDsyVP7Fos3A/jCSsMH
	 sKvlT8yMOs00CY3J24bMadX4jS2HeuprXeaCwWds=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD410F805F0; Fri, 24 Jul 2026 04:25:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF176F805F8;
	Fri, 24 Jul 2026 04:25:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6FA3F805BF; Fri, 24 Jul 2026 04:25:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784859911;
	b=qpc3CNxpVjo2Jq9p9iHFM3fNTe0ZOHSkmMYewsT1FbTGI1fK2/2Mxchyo2g9MSYSJQlD
	 WavDit4bakH69GbBFs6Gm4UHRsaYqIqf0Q/Oi/zyxH2W+cp3eqgjB/O0SbqqtV7s79I29
	 RTYzct+vmIH9FmHELbLKciSMLavN7GLcUEs5/wm2lBc0kQqnKe9JUhBN6OYwJTc3WsEr7
	 PvIRPOccfdsNtyMCRaXQtBZgeoUFbpz486yFX2i/bVgjuP4o1G5z+pE9Q7Z8Ht1Sk/cpU
	 V6f2LXWhrYlaW7RAvIlppJy9qxbg++d1Zpt8q0cKlJdw4cI6rVhNXfHZIMUglsMmWOQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784859911;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=VtZvtOgPveHU3jAA0ERlEKRUBqtKJfJy9/ocYAN/q1g=;
	b=Pdtf9KkOvdBuWGvz2U9JktP5jUjtwFUjglKDdbG03G/oZqhWKziURY7E7rt/GWVFMuFg
	 qyX1r0yC+VkaNFA8b2TDfwQwCyvhiUGy1VMranqk/384mHJDbLnSsn0zQ4Vd+E+yos8dO
	 Vaft/tkUG6H73Pxhhit/+fSh6aIBa5EAUHymTjWc4h5N6OTXeJAwBbFDlybByRCCFFbqX
	 xCvuekzn0K51k8xbPiD4brAolOGBCq8eP5jThq2Ivw0eHM3fz/Pw0M64QXc0qUg8AGCUA
	 QO4JdOH14CyZZqBa+DyNvXs+3m2QdjdDYRd69YaA+3fLEKXIReiit4VyYTPlDT8Cidw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fsaANFgl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E3543F8027B
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2026 04:25:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3543F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fsaANFgl
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-9061a795d76so13349996d6.3
        for <alsa-devel@alsa-project.org>;
 Thu, 23 Jul 2026 19:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784859908; cv=none;
        d=google.com; s=arc-20260327;
        b=Y8HFfnerweHlgRWaxTpv1ZJ4S+gX+5EeBOtrAsPb2Jehx2bxDAXCVm4Zj2jAxfR73k
         X6eBVpYlCu/mea7IcOUZbCnPgylaBpSEyV0s9HZ+cZIISRb/gL4HaHwA72ov+wXfOYm9
         swA4y6PIv9sZmfFn2dt8F9HMCgHD9HbZRcsLalpKu8aVC+4pnwSx6+gl5OTRFuBZJUnj
         73cM6+k1VBW58mr8Ddaw+PbqyHtsNlFjyPAP69h/3Hh2xxT1HfZbHe7be4DrhHDwy+gM
         0l+yWwFlvJrsVHtLqw43fSEgnXLg8BGrsJj8LqWEq4azHmkGXJ2/hDzP+OpI3c9uHqT5
         QkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VtZvtOgPveHU3jAA0ERlEKRUBqtKJfJy9/ocYAN/q1g=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=adVEmgmHvuCxNjNDbvloPPRIRlneefmvj8xcyFWi87WMoUxEmCHbf74ATHdTAIF7YL
         i8CpNdJUHS674oX77omF0iK+mDQjXxNEzbcHbA77trbXt6F0lSIX0rmD/03GPgi/9Jyr
         Ed1cuGOFGu5fwdJcMxaLD0ksrott+UugupvvOwC/vzxXLUSpMkUEKA6BxvsEB4XRgFcr
         lmcv0Sf1WC8v/hwNHd+Sv23uWWgeW4+6gEXp8LYwsvbrGRRmubrXYxlWNsPiSXFHvG77
         t7u5vEd7gcR4JyOD1Ac3F28uCI9rBN+dYtBvfW+29rK+2z7yZ5CmvMBIpxIc6iWroo7j
         5njg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784859908; x=1785464708;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VtZvtOgPveHU3jAA0ERlEKRUBqtKJfJy9/ocYAN/q1g=;
        b=fsaANFglb/HSZRig5wBzWiDNQv1JFDeSzIq9utFmWOiwBwZ/4YAsiptJ6TDdWvU/e2
         9NkAcSB0HXp53fkNfCmugreD29a3rW68RH2kwjorz2QW5MeL7cbk6uV2RHQ1q29+vV8M
         JLcrcHojlbGlq7f1F+E2Wj+9T/NLp/FTNAfrqnioHMM2bVKAso19hJxBqzhei7TUQEEC
         hWFuRyvtQdHBscitnmeFHoA8dqmLrKb3xwAwjX6v6+LMN/T54p/B6OnOWTD9UBpGd4iD
         kIcf+3TSf49Jt4ESwitBxwOQQkDLW6hsp8Dh6EyPSc+ozRaZyIs8T/vE7qdhKVCD3XAY
         hJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784859908; x=1785464708;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VtZvtOgPveHU3jAA0ERlEKRUBqtKJfJy9/ocYAN/q1g=;
        b=n6NCmKhfslwsFcyfM6FYy5u70BzXVe/EAVGAFN/4oEB0BIL+RT7EGROgz3ILFTRnoc
         +XK+0eJIgLYgYnoP52hxhRZZKI56zW6O0Ek02+6nrmcPW4GbX3mzojPrdRLclIiPiLLH
         iUJ22SvkZsVm1Zp3lm0/1aDptzWa3xJToxa5a1ZhsN/bSG7GHX2Jb7n/07fo+sN7GjuT
         h+5lx4BTZ6+zo7UazMCYTKABhE0LkmyUYsgg6zb3NL6fBVLxdaGQrdl5ROeH0pmxd7iT
         t0ErDBWlkcJ0ey3fnZxnqJ3hEc5aVFJoDOn8St9a6BlvTYJ7KOF3Cf4g8/PgqUEE+HaC
         m1ug==
X-Gm-Message-State: AOJu0YwUIn9F/rMXhsJW0s+46ZdJFEldzkdyxthv5HCdhP+3usdEdVP0
	G5gRaEy22sI/VO5EbO7n6W4jLzAlZFK15dw/qavnselXl0dUtsm1MUO4MpBnSNspAtVXH9YAPE3
	AaHjhC0UXLY5OWSKCCBPXHQkFiIFbgZhciwjS
X-Gm-Gg: AR+sD12E+cjEv/Kmrg233Q8ZID9Ic/9hiooA+fLiPlgJLHpKzGjCrB2Yp6d1ZjM7VzM
	GfOQ1bhEkXHbYCwMugP84M4skw39Ro++3A8iNtUAjpETwKPU1RTnXrmaRrqRTvsUlCw0zd4cDLX
	DGs4beXEKlwwihdWZh1qFv1WV4YKlAS1P+BCf2Fl0rLZFWrHgdPc2s+fmVoz1of296WthZagsuT
	kTrw5o81435HKcinjwwD32lkgmi9NfgcaNB5zDtkyGvqiuohaK/LIYgw4OUQqpS
X-Received: by 2002:a05:6214:194e:b0:8ce:b2e9:a4bd with SMTP id
 6a1803df08f44-907ca55ac37mr68183516d6.17.1784859907710; Thu, 23 Jul 2026
 19:25:07 -0700 (PDT)
MIME-Version: 1.0
From: Luis Pablo Gasparotto <lpgasparotto@gmail.com>
Date: Thu, 23 Jul 2026 23:24:56 -0300
X-Gm-Features: AUfX_mzlPq0D_Pj0jE5VLc_E-jZonhb0-e3L_oJdZdI1VVdfEuDRwglStAQeIGU
Message-ID: 
 <CAEx9QT7W2Whthpi67deVcivxe1q=+3ixd+mosqLEPmz+bSYvHg@mail.gmail.com>
Subject: Apogee Duet 2 (USB) support (I want to contribute)
To: alsa-devel@alsa-project.org
Message-ID-Hash: BDNCQR4DYMQ2CPEBZN3FYCBAHSMZ3SYI
X-Message-ID-Hash: BDNCQR4DYMQ2CPEBZN3FYCBAHSMZ3SYI
X-MailFrom: lpgasparotto@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BDNCQR4DYMQ2CPEBZN3FYCBAHSMZ3SYI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQpJIHJlY2VudGx5IGJvdWdodCBhbiBBcG9nZWUgRHVldCAyIGF0IGEgYmFyZ2FpbiBwcmlj
ZSBhbmQgaXQncyBhbg0KaW5jcmVkaWJsZSBhdWRpbyBpbnRlcmZhY2UuIFNpbmNlIGl0J3MgVVNC
IDIuMCBhbmQgbmV3IE1hY0Jvb2tzIGRvbid0IGhhdmUNClVTQiAyLjAgcG9ydHMgc28gdGhlcmUn
cyBhIGxvdCBvZiB0aGVtIGZvciBzYWxlLg0KDQpUaGVyZSdzIGEgcHJvamVjdCB3aGljaCBhbGxv
d3MgeW91IHRvIHNlbGVjdCB0aGUgaW5wdXQgdHlwZSwgYWN0aXZhdGUNCnBoYW50b20gcG93ZXIs
IGFkanVzdCBpbnB1dCBhbmQgb3V0cHV0IGxldmVscyBhbmQgdG8gdXNlIHRoZSBpbnRlcm5hbCBt
aXhlci4NCg0KaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbm9jb2RpbmcvdGFrZV9jb250cm9sDQoN
CkJ1dCB0aGUgR1VJIHdhcyBkZXNpZ25lZCBmb3IgdGhlIFVTQiAyLjAgQ29tcGxpYW50IER1ZXQg
dmVyc2lvbiwgdGhlIG9uZQ0Kd2hpY2ggd29ya3Mgd2l0aCBpUGFkcyBhbmQgaVBob25lcyAoaWRQ
cm9kdWN0ID0gMHgwMDE2KS4gSSBoYXZlIHRoZQ0Kb3JpZ2luYWwgRHVldCAyIChOb24gY29tcGxp
YW50KSwgYnV0IEkgY2FuIHNldCB0aGUgaW5wdXQgdHlwZSBhbmQgdG8NCmFjdGl2YXRlIHBoYW50
b20gcG93ZXIuIFRoZSBpbnRlcm5hbCBtaXhlciBkb2Vzbid0IHdvcmsgYW5kIHRoZSBvdXRwdXQN
CmxldmVscyBzZWVtIHRvIGJlIHdyb25nbHkgbWFwcGVkLg0KDQpJJ2QgbGlrZSB0byBjb250cmli
dXRlIHRvIGRldmVsb3BpbmcgYW4gQUxTQSBkcml2ZXIgZm9yIHRoaXMgaW50ZXJmYWNlLiBJDQpo
YXZlIGEgdW5pdCwga25vdyBQeXRob24gYW5kIGhvdyB0byB1c2UgV2lyZXNoYXJrLiBIb3cgY291
bGQgSSBoZWxwDQp0byBhY2hpZXZlIHRoaXM/IElzIHRoZXJlIGFueWJvZHkgaW50ZXJlc3RlZCBv
biBtYWtpbmcgdGhpcyBpbnRlcmZhY2Ugd29yaw0Kb24gTGludXg/DQoNClRoYW5rIHlvdSB2ZXJ5
IG11Y2ggaW4gYWR2YW5jZSwNCkx1aXMgUGFibG8NCg==
