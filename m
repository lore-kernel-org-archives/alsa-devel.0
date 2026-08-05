Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC45C55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:30:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 571D060225;
	Wed,  5 Aug 2026 12:29:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 571D060225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785925806;
	bh=g5BbabOnyuwecCi+ODvNg4JaskqsXFyc/4YDBOrvG48=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TtqygYaE3TCCRH1FWkgzlHmP5T5L900YKfjAvIXFqyHyKKuYhD4UGrZqVq+2n5eXa
	 mMd0aLRg9cDBOLYaD7010CsJhjwiFh9hDXVz4kwbeSaPMIk+jhK7QIN1XVlkexbLf8
	 P0XOLXJ5MDDvXj6cH4whVGfiFFpE7jrRz3Bdu9UM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75CB1F8067F; Wed,  5 Aug 2026 12:29:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 876BAF8067D;
	Wed,  5 Aug 2026 12:29:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71CFEF8027B; Wed,  5 Aug 2026 11:20:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785921607;
	b=o/Dh2vooJdZ1GS6n/bu3qkUkeWhGbwjdi3xkwIb2vlTPwPGzm3R4CyYreUvfaRbxy+d+
	 zPibRc7Aq2zNXwecxzENQ4FlWSyGcwLZgpzaBrdcg64T1VZUPZoxyFJzGltDzcP0vu0dz
	 ER4HkxWCoDc4/pvkgeBPL6uPw258eEVR4tlPuVptke0XSPOfICtQ6KBCXSDdb1ENntQgh
	 bUSH3AUEwc7TxjLzTwvDrn7c+z+Olsoi5f5/0+V3GwU9bxspRGkqR0fxXrLszK2z6fXsY
	 rLbYQ/zKiZBlAZRm/4H1TsiNrKq7e1zKO5l8rw4aCVICEBksWayoZ+UloKFdqLgYBxg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785921607;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=uj3EiNicO6kmO0qSDHCYN8a+68osJ4foJl0c9WgFUPg=;
	b=QFlDgbi+DtMDITZUG8J+0iPBbbk+KaVgFe2RIR8iP6YfbuvsDhrH9ux/51UoxolEGELd
	 xxTerfUxSZlIvKmlQ/pTyWQI6h0Myd6EwKLOl9flJLOo/yqxIWNGBlEBbWIXngeXc/2zs
	 VElGGqHjXwN2cydRBKjymKhoOLccdr/zCQD2glQSKL9mDE8Jn5po3hJVgbzW1pJra/guf
	 T2BEFhXP2vPDlPixGXo53WTmBeF9opAghDkQEC59/UuJvl28cu5qBRBQaANqGOxAYi2YK
	 owg0vU9CDnbt0N3lPosKAvGRt6zdef/y/SuOT8GVPHkqff2ZYVhnm+RbEXkqNbEn2pw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=U308zohR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BA767F800C1
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 11:20:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA767F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=U308zohR
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-6aae5eb0ee0so245335eaf.3
        for <alsa-devel@alsa-project.org>;
 Wed, 05 Aug 2026 02:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785921604; cv=none;
        d=google.com; s=arc-20260327;
        b=WBv5hpfJwKLSQrXpXNnsp0gCBaZ4DH9CAW8o1N4gqacMfmWZKztUaVldHVZrXu+Ycp
         AwLIXd/pcRzlhZRJEH4irfAARbtGH1J+Z8Dp+vpaa+wvuKD17/YgvCWLLL6wKW9H8t6p
         bJ8arH0RrB397BKQZpyGmRB20l+tBOAWhXYC5WmvAotTXxXTVXzCnEz7zkgGc2YNrXn9
         XIbYwImQ1frawj1hsYhscuqcLODpEipHB5DIuZ1ayGGeeAYk0GXNNZHFpOOeU2H5ixHa
         7RnrOxOVzCO+IwzakC+lIweY7zyNYQbPJZBZePSxNLq2V5SNur9OjPBORaN02pEA5irU
         DOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HC9FYYyG6BhjPW4vSod3ORKXcQFrSVY1DJf70jsETaM=;
        fh=VsRHOisaB2BwKzV3ST/7QhdcEvgcSjAZmRwsqaMMeWs=;
        b=bxVf7Z+NVq+xOuSn/nLwjYbKGCRqfwno6RIqpHc+1IFZp3FdvrJ5uDE6UVzaelyTVG
         yzbSar78NJm0hTqgqUBRvAZ/SbfcHz8VDztqi8OTniBnqkXD5bPODpLBXNHFDkHRFwWO
         fNQ3OC49iKmbrqYQDpxJnxlfhTjZ5M9UuR9h32AhiqaU/y3lNxlk9G6L6FUTwWIk+goB
         XoiZlA9IxEh7ZOk6SFTciojlVHJFYVDBAPY50vBpxRe5peBD0hbC0i8eCmMuDxd8dgUx
         JS7LqBN1lm8a8j4Wl+uaLk4ckgFp/ZQ3MPEy/c7t2svyi1AW6PPGjKv2Jz72o4LoprFf
         ozXw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785921604; x=1786526404;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HC9FYYyG6BhjPW4vSod3ORKXcQFrSVY1DJf70jsETaM=;
        b=U308zohRfUwqixGOIzDRpfSUlFV+7uQWEfU/vbhTah5HGp+4Sml5xT/nAGkSyi9w7C
         rm8s5yKA/Me6swcy5qZx0NzPTseuoI6ib6vLSmyR+QO1yUnHy3ZehFPNENF+fTto1SNn
         N7P3FH1aHuU/rU8RsuHeTAtnvfn3DxrNGrpysQO8/ipLgIlNYJ7rB3v9EjWQ7SI8hSlh
         5l5sTln5kd+IxgALNL+F+7urRFLa0/K9abRmh2ypkR5o63KNmV2W7UWow7XPH20yf6ZJ
         5iEdgnLgA1mk7PZVndidWrgxy9Yc1PZqBlcQrrDCHobIk/8suDs6/kF276WsKv2Vgp8q
         iWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921604; x=1786526404;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HC9FYYyG6BhjPW4vSod3ORKXcQFrSVY1DJf70jsETaM=;
        b=IjpAJYQxDmScmPVVR3adMzGcnOB8KsIaFQQ3SE/qUGF7uNxUDY5jCmY2jIr2j2uCV2
         vshmpgEcLgTizMlasgFaB75KsgHPDniqhUWMmNPQWb7ixbXsVX7eRQ6qgB1OZzwc78DV
         HWlYfQ7LKUC+2mc1Xe53N6PLsfwyjWfezc52OEbwVEubr/qPC/PtVmUV7n0V67qDhytW
         vjXrmlLbJLfTWexaqfHj302emXH7SgFIXRNAdj9WV6FxTGlRCJyvmV6Lsbt0Qq++VI3l
         lyJG38TBkIt6pc4O9g5/0JmML9v1vK+cpo6FoTdIi0Tldee6UlPml0R0WVJWur+zlhOu
         H3Lg==
X-Gm-Message-State: AOJu0YwsUqO9jS1LL7A2XSedAegsH6RbLHcralnAUEx18v1fYpBnXjcJ
	4xx0ewA0tgt877jrtHV8sLF/C3/Gp0x14Ht7uT8Qdp+MHfiCXbo0eo624OLEneg2e0WF64duY3U
	tzQGXbVcsUWR59nEL66ut2ENacFS4/7pf9DyBOEapiw==
X-Gm-Gg: AR+sD11QzXQs41Ueb6CnmvVtfr8M5X2R1+ABtf5f0avJ8ajL5Nm+1BfncI77tHm76hR
	qu5slxuSMvPi95B7BAYpRv3KAY9TCtuvAJS0WDse+HajIf4Mk5hSCaqK4mJwLhacXzAVW8AUpiy
	Tss44aaCtQV6sNSb2phEK3oelkiHTsygkqOYRQbEt0Q64XEd+MmeMTWXr7BcdVhRIsBR9vvaXik
	ix6ehg/FiWsmjxtcET6fHOFiETLNReSVxCk6t6vnNPZSohecu9MV4uH1Non2FWn2q20q0XHZk0u
	O3VfuQL8UVPMe/JV70la6Q1OuT5hiaCvM1TbneswAf0Xm8uwCvkPBA==
X-Received: by 2002:a05:6820:2214:b0:6ae:47e0:be20 with SMTP id
 006d021491bc7-6ae96bcccd2mr2761763eaf.7.1785921604217; Wed, 05 Aug 2026
 02:20:04 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5byg5bu6?= <soldierjazz2013@gmail.com>
Date: Wed, 5 Aug 2026 17:19:54 +0800
X-Gm-Features: AUfX_mxQN_j9v5KpOpM277n_ZBtrGCMQ0WquEbzTzTeJpzmM2n5LpWEv27aHbAI
Message-ID: 
 <CAEoG+NRpPip1Eymi1ZSgG7FdYH2UkRneat2GJRWXL_M38xfD9w@mail.gmail.com>
Subject: [BUG REPORT] sound/usb: Fix Use-After-Free in snd-usb-audio
 error_timer during device disconnect
To: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Cc: tiwai@suse.de
X-MailFrom: soldierjazz2013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FMSFOBHUU5G4KOZPZAGOMB5VJSZPM6DN
X-Message-ID-Hash: FMSFOBHUU5G4KOZPZAGOMB5VJSZPM6DN
X-Mailman-Approved-At: Wed, 05 Aug 2026 10:28:55 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FMSFOBHUU5G4KOZPZAGOMB5VJSZPM6DN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgVGFrYXNoaSBhbmQgTGludXggVVNCL0FMU0EgbWFpbnRhaW5lcnMsDQoNCldlIGlkZW50aWZp
ZWQgYSByZXByb2R1Y2libGUgVXNlLUFmdGVyLUZyZWUgKFVBRikga2VybmVsIHBhbmljIGluDQpz
b3VuZC91c2IvbWlkaS5jIGR1cmluZyBVU0IgTUlESSBkZXZpY2UgaG90LXVucGx1ZyB1bmRlciBh
Y3RpdmUgVVJCDQp0cmFuc2ZlcnMuDQoNClRoZSBpc3N1ZSB3YXMgcmVwcm9kdWNlZCBvbiBRdWFs
Y29tbSBwbGF0Zm9ybXMgKFNuYXBkcmFnb24gOCBHZW4gMyBMaW51eA0KNi4xLjE0NSAvIEFuZHJv
aWQgMTQsIFNuYXBkcmFnb24gOCBFbGl0ZSBMaW51eCA2LjYuNzcgLyBBbmRyb2lkMTYgZXRjLiku
DQpUaGUgY3Jhc2ggY29uc2lzdGVudGx5IGhpdHMgX19ydW5fdGltZXJzICh0aW1lciBzb2Z0aXJx
KSBkZXJlZmVyZW5jaW5nDQpwb2lzb24gcG9pbnRlci4NCkNyYXNoIFRyYWNlDQoNClsgIDE2OS40
OTM5MDddIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSBJbnRlcm5hbCBlcnJvcjogT29wcyAt
IENGSToNCjAwMDAwMDAwZjIwMDgyMzQgWyMxXSBQUkVFTVBUIFNNUA0KWyAgMTY5LjQ5Mzk0MV0g
SVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHNlYyxxYy1yc3RfZXhpbmZvDQpzb2M6c2Ftc3Vu
ZyxxY29tLXJzdF9leGluZm86IGZhdWx0IGhhbmRsZXIgOiB1bmtub3duDQpbICAxNjkuNDk1NDQy
XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0gQ1BVOiAxIFBJRDogMTc5NCBDb21tOg0Kc3Vy
ZmFjZWZsaW5nZXIgVGFpbnRlZDogRyBTICAgICAgV0MgTw0KNi4xLjE0NS1hbmRyb2lkMTQtMTEt
MzI1NDc0My1hYlM5MjgwWkNTNkRaRjIgIzENClsgIDE2OS40OTU0NDddIElbIDE6IHN1cmZhY2Vm
bGluZ2VyOiAxNzk0XSBIYXJkd2FyZSBuYW1lOiBTYW1zdW5nIEUzUQ0KUFJPSkVDVCAoYm9hcmQt
aWQsMDkpIChEVCkNClsgIDE2OS40OTU0NTVdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSBw
c3RhdGU6IDAyNDAwMDA1IChuemN2IGRhaWYNCitQQU4gLVVBTyArVENPIC1ESVQgLVNTQlMgQlRZ
UEU9LS0pDQpbICAxNjkuNDk1NDY0XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0gcGMgOiBj
YWxsX3RpbWVyX2ZuKzB4NDQvMHgyNmMNClsgIDE2OS40OTU0NzFdIElbIDE6IHN1cmZhY2VmbGlu
Z2VyOiAxNzk0XSBsciA6IF9fcnVuX3RpbWVycysweDFiOC8weDMwYw0KWyAgMTY5LjQ5NTQ3NV0g
SVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHNwIDogZmZmZmZmYzAwODAwYmU0MA0KWyAgMTY5
LjQ5NTQ4MF0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHgyOTogZmZmZmZmYzAwODAwYmU0
MCB4Mjg6DQpkZWFkMDAwMDAwMDAwMTIyIHgyNzogMDAwMDAwMDAwMDAwMDAwMA0KWyAgMTY5LjQ5
NTQ5MF0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHgyNjogZmZmZmZmYzAwODAwYmU5MCB4
MjU6DQowMDAwMDAwMDAwMDAwMDAxIHgyNDogZmZmZmZmOGE3MTMzMTJiMA0KWyAgMTY5LjQ5NTUw
MV0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHgyMzogZmZmZmZmYzAwYTQyNzAwMCB4MjI6
DQpmZmZmZmY4ODY4YTcwMDAwIHgyMTogZmZmZmZmODA0YzQ4NWM0MA0KWyAgMTY5LjQ5NTUxMV0g
SVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHgyMDogZmZmZmZmODA0YzQ4NWM1OCB4MTk6DQow
MDAwMDAwMDAwMDAwMTAwIHgxODogMDAwMDAwMDAwMDAwMDAwMA0KWyAgMTY5LjQ5NTUyMl0gSVsg
MTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHgxNzogMDAwMDAwMDA5MWI0YTgzYSB4MTY6DQowMDAw
MDAwMDAwMDAwMDAwIHgxNTogMDAwMDAwMDAwMDAwMDAwMA0KWyAgMTY5LjQ5NTUzMl0gSVsgMTog
c3VyZmFjZWZsaW5nZXI6IDE3OTRdIHgxNDogZmZmZmZmODA0YzQ4NWM0MCB4MTM6DQowMDAwMDAw
MDAwMDAwMDBkIHgxMjogMDAwMDAwMDAwMDAwMDAyOA0KWyAgMTY5LjQ5NTU0Ml0gSVsgMTogc3Vy
ZmFjZWZsaW5nZXI6IDE3OTRdIHgxMTogZmZmZmZmYzAwODAwYmU5OCB4MTA6DQpmZmZmZmY4YTcx
MzMxMjQwIHg5IDogMDAwMDAwMDEwMDAwMDEwMA0KWyAgMTY5LjQ5NTU1M10gSVsgMTogc3VyZmFj
ZWZsaW5nZXI6IDE3OTRdIHg4IDogMDAwMDAwMDEwMDAwMDEwMCB4NyA6DQowMDAwMDAyNzc2NDk3
NzM2IHg2IDogMDAwMDAwMjc3NjQ5NzczNg0KWyAgMTY5LjQ5NTU2M10gSVsgMTogc3VyZmFjZWZs
aW5nZXI6IDE3OTRdIHg1IDogMDAwMDAwMjc3NjQ5NzczNiB4NCA6DQowMDAwMDAwMDAwMDAwMDAx
IHgzIDogMDAwMDAwMDAwMDAwMDljNA0KWyAgMTY5LjQ5NTU3M10gSVsgMTogc3VyZmFjZWZsaW5n
ZXI6IDE3OTRdIHgyIDogMDAwMDAwMDBmZmZmODA4ZCB4MSA6DQpmZmZmZmY4MDRjNDg1YzU4IHgw
IDogZmZmZmZmODA0YzQ4NWM0MA0KWyAgMTY5LjQ5NTU4NF0gSVsgMTogc3VyZmFjZWZsaW5nZXI6
IDE3OTRdIENhbGwgdHJhY2U6DQpbICAxNjkuNDk1NTkxXSBJWyAxOiBzdXJmYWNlZmxpbmdlcjog
MTc5NF0gIGNhbGxfdGltZXJfZm4rMHg0NC8weDI2Yw0KWyAgMTY5LjQ5NTU5OF0gSVsgMTogc3Vy
ZmFjZWZsaW5nZXI6IDE3OTRdICBfX3J1bl90aW1lcnMrMHgxYjgvMHgzMGMNClsgIDE2OS40OTU2
MDVdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSAgcnVuX3RpbWVyX3NvZnRpcnErMHgyNC8w
eDRjDQpbICAxNjkuNDk1NjE0XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0gIGhhbmRsZV9z
b2Z0aXJxcysweDEyMC8weDNlMA0KWyAgMTY5LjQ5NTYyMV0gSVsgMTogc3VyZmFjZWZsaW5nZXI6
IDE3OTRdICBfX2RvX3NvZnRpcnErMHgxNC8weDIwDQpbICAxNjkuNDk1NjI4XSBJWyAxOiBzdXJm
YWNlZmxpbmdlcjogMTc5NF0gIF9fX19kb19zb2Z0aXJxKzB4MTAvMHgyMA0KWyAgMTY5LjQ5NTYz
NV0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdICBjYWxsX29uX2lycV9zdGFjaysweDNjLzB4
NzQNClsgIDE2OS40OTU2NDFdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSAgZG9fc29mdGly
cV9vd25fc3RhY2srMHgxYy8weDJjDQpbICAxNjkuNDk1NjQ4XSBJWyAxOiBzdXJmYWNlZmxpbmdl
cjogMTc5NF0gIF9faXJxX2V4aXRfcmN1KzB4NTQvMHhiNA0KWyAgMTY5LjQ5NTY1NV0gSVsgMTog
c3VyZmFjZWZsaW5nZXI6IDE3OTRdICBpcnFfZXhpdF9yY3UrMHgxMC8weDFjDQpbICAxNjkuNDk1
NjY1XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0gIGVsMF9pbnRlcnJ1cHQrMHg1NC8weDE3
NA0KWyAgMTY5LjQ5NTY3MV0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdICBfX2VsMF9pcnFf
aGFuZGxlcl9jb21tb24rMHgxOC8weDI4DQpbICAxNjkuNDk1Njc3XSBJWyAxOiBzdXJmYWNlZmxp
bmdlcjogMTc5NF0gIGVsMHRfNjRfaXJxX2hhbmRsZXIrMHgxMC8weDFjDQpbICAxNjkuNDk1Njgz
XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0gIGVsMHRfNjRfaXJxKzB4MWE0LzB4MWE4DQpb
ICAxNjkuNDk1NjkwXSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0gQ29kZTogNzI5NTA3NTEg
NzJiMjM2OTENCjZiMTEwMjFmIDU0MDAwMDQwIChkNDMwNDY4MCkNClsgIDE2OS40OTU2OTZdIElb
IDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAw
IF0tLS0NCg0KUm9vdCBDYXVzZSAmIFJhY2UgQ29uZGl0aW9uDQoNClRoZXJlIGlzIGEgc2VxdWVu
Y2UgZGVmZWN0IGluIHNuZF91c2JtaWRpX2Rpc2Nvbm5lY3QoKSBjb21iaW5lZCB3aXRoIHRoZQ0K
VVJCIGNvbXBsZXRpb24gaGFuZGxlcjoNCg0KICAgMS4NCg0KICAgSW4gc25kX3VzYm1pZGlfZGlz
Y29ubmVjdCgpLCBkZWxfdGltZXJfc3luYygmdW1pZGktPmVycm9yX3RpbWVyKSBpcw0KICAgaW52
b2tlZCBCRUZPUkUga2lsbGluZyBpbi1mbGlnaHQgSU4gVVJCcyB2aWEgdXNiX2tpbGxfdXJiKCku
DQogICAyLg0KDQogICBQcmlvciB0byB1c2Jfa2lsbF91cmIoKSBmaW5pc2hpbmcsIGFuIGluLWZs
aWdodCBJTiBVUkIgY29tcGxldGVzIHdpdGggYW4NCiAgIHVuY29udmVudGlvbmFsIGVycm9yIHN0
YXR1cyAoZS5nLiwgLUVQSVBFKSB3aGVuIFVTQiBkaXNjb25uZWN0Lg0KICAgMy4NCg0KICAgc25k
X3VzYm1pZGlfaW5fdXJiX2NvbXBsZXRlKCkgY2FsbHMgc25kX3VzYm1pZGlfdXJiX2Vycm9yKHVy
YikuIFdoZW4NCiAgIHJlY2VpdmluZyBub24tZGlzY29ubmVjdCBlcnJvciBjb2RlcyAoVGhpcyBl
cnJvciBjb2RlIGlzIG91dHNpZGUgdGhlIHNjb3BlDQogICBvZiB0aGUgZXJyb3IgY29kZXMgaGFu
ZGxlZCBieSBzbmRfdXNibWlkaV91cmJfZXJyb3IuKSwgaXQgaW52b2tlcw0KbW9kX3RpbWVyKCZl
cC0+dW1pZGktPmVycm9yX3RpbWVyLA0KICAgLi4uKSB3aXRob3V0IGNoZWNraW5nIHVtaWRpLT5k
aXNjb25uZWN0ZWQuDQogICA0Lg0KDQogICBUaGlzIHJlLWFybXMgZXJyb3JfdGltZXIgQUZURVIg
ZGVsX3RpbWVyX3N5bmMoKSBoYXMgYWxyZWFkeSBleGVjdXRlZC4NCiAgIDUuDQoNCiAgIHNuZF91
c2JtaWRpX2Rpc2Nvbm5lY3QoKSBjb21wbGV0ZXMgYW5kIGZyZWVzIHN0cnVjdCBzbmRfdXNiX21p
ZGkgaW4NCiAgIHNuZF91c2JtaWRpX2ZyZWUuDQogICA2Lg0KDQogICBMYXRlciB3aGVuIGVycm9y
X3RpbWVyIGZpcmVzIG9uIGRlYWxsb2NhdGVkIG1lbW9yeSwgbGVhZGluZyB0byBhIFVBRg0KICAg
cGFuaWMgaW4gX19ydW5fdGltZXJzLg0KDQpQbGVhc2UgbGV0IHVzIGtub3cgeW91ciB0aG91Z2h0
cyBvbiB0aGlzIGlzc3VlLg0KDQpUaGFua3MhDQo=
