Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04BAC55ABF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:40:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ABB96024D;
	Thu,  6 Aug 2026 16:39:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ABB96024D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786027200;
	bh=p6sAENL0eJesYSTpamV7qYonSRxF1JG/VmfwRuyCHds=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=eVSTGQ6Oz7zcwdAIrb2j8JsW9rY5IpLmgM4iS3UZKrSQ7mQoaOI/7RGQoBMAMTctE
	 6CkaUgIQCz+AInz0lL/QmlcJB8cPfebH1o834wZuw1mZyf0rrJs8mIgukWcLBnsHbT
	 R92k6Gvl9Kr4efzRlevhokDplz0ao5a1AkX0sPFc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCDFDF805FA; Thu,  6 Aug 2026 16:39:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA440F805F2;
	Thu,  6 Aug 2026 16:39:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9DF15F8055A; Thu,  6 Aug 2026 01:57:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785974262;
	b=mt59iO/L0EF7O+wxpdHou2fB34FMBVl1ECHcFL5IJBw/30IsXvD5m5D6+aDt32J4WuQ/
	 nUHJc+DjLD3rLKNSsWvQ+bSeFvplodIiYXveDhtwwBQ71rjTlcpGeRtamPWFf0RCuItyd
	 NF4uQU/ZY07NK76nNLCNVxx+VGX7wBMQh6gyBnX5zmA/YqC8BX0tl7pVDqohEBuIAbQzT
	 UQlT8VWx1R8FUu4XWIkrwEh9znb1QF0xZH+4Ho2EEZxQzddKThNymfCyhGK9Z9XjRHrRT
	 UVCHmieFDQd/27Od37vigXfm+cXaMm7HnW6BfKT19bUg+5uVJaLE0I/1mbGSVrWpBXg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785974262;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=zXruWE4i8dGRztTu9qUakX4XRtYn8zOZucyx9FyMgus=;
	b=LyYGGIwJV9xMFnHDO91FTQmSJLZhRI84uDWIAgoM1+I1IeLZc6xN6Zot4p0FUtxoKhHx
	 C7v2hFJAJlO+OMqrh2EBluypgKzzwgj2PyAzhSSJ7y6FqVR3WkIVsCYRNAz6N7tPLwADT
	 9OHd+C4Jv4gCAuMXxeMTLFE+D2zTQ0CKQK2hFpXMq2Y65vWrFkx0+4Wh0UHz5KpE/Gz1F
	 4J4tCmWfBtFSudzNc9PpUgCMvWto8ahT0y9w2gTb+5oY0S7qz7hBMRbmRiE4FFhgScw1l
	 L2u++SEYVL3OSZGcWl4VZTdNDC8z90j9dC5qV3I2u9VPAhHVe1I1sZHyzRWnR+eUCgg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BAXb0A9g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98B06F800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 01:57:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98B06F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BAXb0A9g
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1933624a91.1
        for <alsa-devel@alsa-project.org>;
 Wed, 05 Aug 2026 16:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785974259; cv=none;
        d=google.com; s=arc-20260327;
        b=VmQa/a18YEXfLG8vOOp6BLokTFnfR+3S4EeV5UlB3itaRJVIYJ93LrTEpYQl83RLnh
         YmYG8LzzNSQ/hnzmkUSuhqPyMTaIwok5WMitnHiymP6bihF7zISTZaLzxPz1XhBXQfZ4
         aSjm5fdKf0H8A1eB64+XSoKhnpIW8mpPSkHl9KY7+s/sUFM/5fM7MBfsJ/9HVJqKiPr+
         WRr0R6pDQJWkhnzO4nkRFayPRioutyGdNR79gwFGffR7k7SAILEQXaNFS2uoMhAe97y1
         OjiPNQnb++92NsuCGSBIyqakMYI/LvY0pTzD9ir/uJjHrNfm+SPYvNz80u2BH4/hGMaP
         MAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xaQE/ooKydAChya7A9FJAqBtCQUQ/PGJxOGqaOcnHqc=;
        fh=dBSINSrh+dZtWEP0pR2323P8G/MRu1im4fhQaZzZhOY=;
        b=hqRqcsCRY2grlKXReEieRpikBzoZgmJEPQyFhavF1hbbzmup0zHx1itMwxdIIz7XD1
         ulF8pXPeLwReCRsTff8i8SV13+fgq3JVn3lVbzDtbXfGbgzgrtOCfKr+evjwP7fZppYt
         GuvAgLpJG0WmNJXPnp18dqKGmTCpNnjqnr2nUeUP4DJEd/7PJ0uUo6usCKjpn2XcKo1u
         nr6JpT06A9W3fijytdtLBAW4g1vXpnAqsHoYhVMg5tmJdgczqoNahHFMkhJLThUXtpV4
         PpCoX09c/JfvSv6kW9VlMq/FNA/DpL2eh/Jtko7XfYwJseHDP6o+f1Lkb3FVDb79lNTb
         oe5Q==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785974259; x=1786579059;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xaQE/ooKydAChya7A9FJAqBtCQUQ/PGJxOGqaOcnHqc=;
        b=BAXb0A9gk7CgEI26ztLDQ6F2xKLR7EMkKuFtyp+Txv3GK330D88XwR/hTzJ8V3Ao0m
         QC/mJLanVgTJ/kUv/ardToe94tDae1QTKQoKVz5eNV//i33mRUScIQLPscDBNiKjlJQy
         AyJbxGg7RwTFAyYyX5PvVjxZ89ztCexsF6xav/DDLZSvpOA34y0RFzxD2bYVQUGa2ErK
         f7jvUMinGAgXllV1TxqI8wTfanv0uf5zafVmqOYMKsyJ3QE3J0MPrArnPMVe5fAr0Pea
         uw9hCZTM+DR60wrRoznSE0ZykazC9XllF1QMNSTfRXYiakYUNvdPjplumGVjEfdzaDS5
         Q+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974259; x=1786579059;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xaQE/ooKydAChya7A9FJAqBtCQUQ/PGJxOGqaOcnHqc=;
        b=fFFMWTdYC86MwOCyaAvwOzH1bnYfOMYFKCXcHQfuRAfKXpgt8ASu4HyjQJWqYpHc3A
         RqJAb+eDTxHwKXhs0oX5CUhmqMK78wLsDEv6jCsoopLdFWTpGXYyMPFY/KH8nZrCwuSy
         6ZYfKkFuujfsjJd+Qg9HFvCl+jk+v6QdHSpc7VgfpWKM20Ti5BUMpd5WfXvzBjnw3H6u
         hd8DOzASiI1QmYXdCKG1yxCV3JMzMGIIVm6MYiBrQMuDVvhZt7KdItzLJk8/XN3rfUBf
         cw4DQVRx4KSufucFtQrJkpiykkrKucdCx2fP4qjuqkMW2YxNYOPeGWXcEWVJFpOlRszO
         SFoA==
X-Gm-Message-State: AOJu0Ywqy/snxiJ++nJOHq9IEG6fdEZxG4Es6fAD4Oh9LUMMfX5Hrczg
	UeGak1r1VSfYHDDKgjxYfN0YeYqiM4x/joWqP7rdo8+KBk/2xdCJ08kglF3rGhtRT2y6/vm4KCx
	FxUM+v1UI8RuotMVUqn8GB3RYRQ3kuEf5mw6fdQhMrg==
X-Gm-Gg: AR+sD10PZbF65cM+m1qRLIuU02OWdLFFwpTL15aFuD6mX6sq6o8qdSyZcCxctx8/vHp
	vasS1NWZ1dHoXQmTzCOsrQUlb3fTlWRlRbFUJgCw31CKzVa1NWteK1ZpozuXLc5YIMr/sPTTszi
	IhvkERXq4ry/andKrf0kylPFmIo2x4a/Cu1ZKa2pKcJESIq19wE8JxPKCIl/A0INqiVDqe9ZeM2
	4FiR28CLaEcqj41uhP4MRoMymq707DYvbjkl8PLbiMLxpy51Yl7+RSdbwA7Vr+J49ToyeJ6k/yr
	4iPeD2bmBf1VK/RstNxAiOHM7VNfKO6wkuEERpd8/LCGpA==
X-Received: by 2002:a17:90b:4b87:b0:37f:c2a8:ce45 with SMTP id
 98e67ed59e1d1-3903c537d5fmr9656623a91.4.1785974259134; Wed, 05 Aug 2026
 16:57:39 -0700 (PDT)
MIME-Version: 1.0
From: Carl Quist <equalizerjr@gmail.com>
Date: Wed, 5 Aug 2026 23:57:27 +0000
X-Gm-Features: AUfX_mwlGBP76L9jqNycQB36F-CivshS0y3UaYmi-r9Al1acAiwHmDXI50Lya1I
Message-ID: 
 <CAOtcGaxXndKxTK5MVSEcmF-LUy+V51K7fhE=qvLA+VvW5ZyCNA@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Enable mute LED on HP Laptop 15-dy0xxx
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
Content-Type: multipart/mixed; boundary="0000000000004bd3c10658558972"
X-MailFrom: equalizerjr@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: R5TYAZD4MBTJ6SWIAKVOQLM4UTUUXLJ3
X-Message-ID-Hash: R5TYAZD4MBTJ6SWIAKVOQLM4UTUUXLJ3
X-Mailman-Approved-At: Thu, 06 Aug 2026 14:39:19 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R5TYAZD4MBTJ6SWIAKVOQLM4UTUUXLJ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--0000000000004bd3c10658558972
Content-Type: text/plain; charset="UTF-8"

The mute LED on the HP Laptop 15-dy0xxx (PCI SSID 103c:864f, Realtek
ALC236) does not work, because the machine has no entry in the quirk
table. No fixup is applied, so no mute LED classdev is registered and
nothing ever drives the LED.

The LED is controlled by COEF index 0x07, bit 0. This was verified on
the hardware with hda-verb: setting the bit lights the mute LED and
clearing it turns the LED off.

  hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x07
  hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x1     # LED on
  hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x200   # LED off

That is exactly what ALC236_FIXUP_HP_MUTE_LED_COEFBIT2 configures, and
the closely related HP Laptop 15-dw0xxx (103c:85f0) already uses it.
Bit 9 (0x200) is set by default on this board and is preserved by the
fixup's read-modify-write.

Tested on an HP Laptop 15-dy0xxx (SKU 7FU54UA#ABA, board 864F,
BIOS F.40).

Signed-off-by: Carl Quist <equalizerjr@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c
b/sound/hda/codecs/realtek/alc269.c
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7149,6 +7149,7 @@
  SND_PCI_QUIRK(0x103c, 0x860c, "HP ZBook 17 G6",
ALC285_FIXUP_HP_GPIO_AMP_INIT),
  SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6",
ALC285_FIXUP_HP_GPIO_AMP_INIT),
  SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1",
ALC285_FIXUP_HP_GPIO_AMP_INIT),
+ SND_PCI_QUIRK(0x103c, 0x864f, "HP Laptop 15-dy0xxx",
ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
  SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
  SND_PCI_QUIRK(0x103c, 0x86c1, "HP Laptop 15-da3001TU",
ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
  SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32",
ALC274_FIXUP_HP_ENVY_GPIO),

--0000000000004bd3c10658558972
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-alsa-hda-realtek-mute-led-15-dy0xxx.patch"
Content-Disposition: attachment;
	filename="0001-alsa-hda-realtek-mute-led-15-dy0xxx.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msgqwgsu0>
X-Attachment-Id: f_msgqwgsu0

RnJvbTogQ2FybCBRdWlzdCA8ZXF1YWxpemVyanJAZ21haWwuY29tPgpTdWJqZWN0OiBbUEFUQ0hd
IEFMU0E6IGhkYS9yZWFsdGVrOiBFbmFibGUgbXV0ZSBMRUQgb24gSFAgTGFwdG9wIDE1LWR5MHh4
eAoKVGhlIG11dGUgTEVEIG9uIHRoZSBIUCBMYXB0b3AgMTUtZHkweHh4IChQQ0kgU1NJRCAxMDNj
Ojg2NGYsIFJlYWx0ZWsKQUxDMjM2KSBkb2VzIG5vdCB3b3JrLCBiZWNhdXNlIHRoZSBtYWNoaW5l
IGhhcyBubyBlbnRyeSBpbiB0aGUgcXVpcmsKdGFibGUuIE5vIGZpeHVwIGlzIGFwcGxpZWQsIHNv
IG5vIG11dGUgTEVEIGNsYXNzZGV2IGlzIHJlZ2lzdGVyZWQgYW5kCm5vdGhpbmcgZXZlciBkcml2
ZXMgdGhlIExFRC4KClRoZSBMRUQgaXMgY29udHJvbGxlZCBieSBDT0VGIGluZGV4IDB4MDcsIGJp
dCAwLiBUaGlzIHdhcyB2ZXJpZmllZCBvbgp0aGUgaGFyZHdhcmUgd2l0aCBoZGEtdmVyYjogc2V0
dGluZyB0aGUgYml0IGxpZ2h0cyB0aGUgbXV0ZSBMRUQgYW5kCmNsZWFyaW5nIGl0IHR1cm5zIHRo
ZSBMRUQgb2ZmLgoKICBoZGEtdmVyYiAvZGV2L3NuZC9od0MwRDAgMHgyMCBTRVRfQ09FRl9JTkRF
WCAweDA3CiAgaGRhLXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4MjAgU0VUX1BST0NfQ09FRiAweDEg
ICAgICMgTEVEIG9uCiAgaGRhLXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4MjAgU0VUX1BST0NfQ09F
RiAweDIwMCAgICMgTEVEIG9mZgoKVGhhdCBpcyBleGFjdGx5IHdoYXQgQUxDMjM2X0ZJWFVQX0hQ
X01VVEVfTEVEX0NPRUZCSVQyIGNvbmZpZ3VyZXMsIGFuZAp0aGUgY2xvc2VseSByZWxhdGVkIEhQ
IExhcHRvcCAxNS1kdzB4eHggKDEwM2M6ODVmMCkgYWxyZWFkeSB1c2VzIGl0LgpCaXQgOSAoMHgy
MDApIGlzIHNldCBieSBkZWZhdWx0IG9uIHRoaXMgYm9hcmQgYW5kIGlzIHByZXNlcnZlZCBieSB0
aGUKZml4dXAncyByZWFkLW1vZGlmeS13cml0ZS4KClRlc3RlZCBvbiBhbiBIUCBMYXB0b3AgMTUt
ZHkweHh4IChTS1UgN0ZVNTRVQSNBQkEsIGJvYXJkIDg2NEYsCkJJT1MgRi40MCkuCgpTaWduZWQt
b2ZmLWJ5OiBDYXJsIFF1aXN0IDxlcXVhbGl6ZXJqckBnbWFpbC5jb20+Ci0tLQogc291bmQvaGRh
L2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKCmRpZmYgLS1naXQgYS9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMgYi9z
b3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMKLS0tIGEvc291bmQvaGRhL2NvZGVjcy9y
ZWFsdGVrL2FsYzI2OS5jCisrKyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwpA
QCAtNzE0OSw2ICs3MTQ5LDcgQEAKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4NjBjLCAiSFAg
WkJvb2sgMTcgRzYiLCBBTEMyODVfRklYVVBfSFBfR1BJT19BTVBfSU5JVCksCiAJU05EX1BDSV9R
VUlSSygweDEwM2MsIDB4ODYwZiwgIkhQIFpCb29rIDE1IEc2IiwgQUxDMjg1X0ZJWFVQX0hQX0dQ
SU9fQU1QX0lOSVQpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDg2MWYsICJIUCBFbGl0ZSBE
cmFnb25mbHkgRzEiLCBBTEMyODVfRklYVVBfSFBfR1BJT19BTVBfSU5JVCksCisJU05EX1BDSV9R
VUlSSygweDEwM2MsIDB4ODY0ZiwgIkhQIExhcHRvcCAxNS1keTB4eHgiLCBBTEMyMzZfRklYVVBf
SFBfTVVURV9MRURfQ09FRkJJVDIpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDg2OWQsICJI
UCIsIEFMQzIzNl9GSVhVUF9IUF9NVVRFX0xFRCksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4
ODZjMSwgIkhQIExhcHRvcCAxNS1kYTMwMDFUVSIsIEFMQzIzNl9GSVhVUF9IUF9NVVRFX0xFRF9D
T0VGQklUMiksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODZjNywgIkhQIEVudnkgQWlPIDMy
IiwgQUxDMjc0X0ZJWFVQX0hQX0VOVllfR1BJTyksCg==
--0000000000004bd3c10658558972--
