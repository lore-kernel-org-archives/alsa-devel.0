Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813D8CD4F54
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 08:42:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 081676025C;
	Wed, 27 May 2026 10:42:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 081676025C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779871362;
	bh=ssGbXmoyU7hJzsPkMCj7Cu+yO/j3FWj16Zl7VBffQJs=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CXts7frIbJGXQ/mW3thVJ/eyVThmrJQIhqQwxuZpangUdRLA6qboxx+WYonEC/HTV
	 yhJe6yUmHJyG+iOPRWGlH2PCp8Rp8hZOQ0TqhehFUCSuvm3u4eVGsWkv6Fu18+qVPX
	 ozO1AIZ0zQ2/dGYB1Z2Pnq79hXyIzYJbmWmrbjCM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F746F805F0; Wed, 27 May 2026 10:42:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C402CF805EC;
	Wed, 27 May 2026 10:42:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85063F804FF; Wed, 27 May 2026 10:41:59 +0200 (CEST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 58018F80087
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 10:41:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58018F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YXlL9gDq
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-956995b5bb6so3579261241.3
        for <alsa-devel@alsa-project.org>;
 Wed, 27 May 2026 01:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779871315; cv=none;
        d=google.com; s=arc-20240605;
        b=iO1sRtmzE2J5GzYo7GQmHEJuveRpiAovnKoRyaCujb6YZvVlkqUeUveJ89dnUwyJor
         +Q4qRcFDNTKzS64gbupqEGrq1EbQK7+5mDvnGgEFsEmm7UpcwnVcwlWKMghtYRiudr5d
         AVQAvVv9C+QPgOLrKU1syR2iihCXH7ay8hUoiQzFD8tp1+yCNNobf4CiOQeeQ82j8wtR
         xAWmqeCn8KxexL80orXR/LPBG1+LZNQC/owCBhPIJWxAverG46vUeFP0HtkONKLoednY
         vYIs/xr3xxweic9N6kOF43VOKo2JGEtl7yBQjvn+66kYjIEzpf1M5OARnThSnuFcr+PQ
         j7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Q3cbHNaBWG850D03EXV84m/W5J2MfVjctap92g7bifk=;
        fh=307Qf9PaxvmAVWpOiSWTmZZR8cwsTMN/1GdoHyRXIDw=;
        b=Ddb4R6nS5yB34ebtYaot+EcIruUUywavpWes2GHpXreceOq54bMCG3rmJIS6QxM+gy
         FbQV1pCOXJydT+LzvnCsELaQvBFT5nqiyPmvTLGuC6MMjlxok0KOupbrHRn4oZRwjpx2
         xr7zcXzflkW1+3KJjnqIAzLs/MI9P0yj0Zki6/CDGMim9qQLES/GggaBTlyNFGZEZDUT
         cu5M5//RE5wenhP2TxV+LpJFHxuqHlzHymcXWb9VMU4gmAbdoApoyT4cTpWuQO3ZlLwv
         VWk7zrF4eZTWfZjr3fAwnmIJU7N5aCGOtkoxwD5fGGr7T1DVHcmEO0r9jCc8qFWShyNQ
         14fg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779871315; x=1780476115;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3cbHNaBWG850D03EXV84m/W5J2MfVjctap92g7bifk=;
        b=YXlL9gDqBEx/ciHHHgEtqr4LEtxZ0wIEI879DRnaEZmAd+FLYO2A7bhpBD3hwWzUlk
         f2PJWXfM0E4lY3jykOYZGIDeCzFQT2oODqk0sDpGTrS2/2P562jvqrH+N2giFw8prLOZ
         qynuAIhZqPXWBJDcxgMlvTsUK9oaddXAOu9fOJgLWhMbqyNuH4EgieBODXj5xhKFMwjS
         zgmeFwr93MVWlbSoOeuC/bnIPdlPLV1wB0Dzs48r/muIK9Sl0eANY+h6uPoeDm12+303
         +EVP1xdQYGbwCE1+ZSGz+s8C4kMsIzfhCzTOgLIYyCZdfvrpph/71wtn7Y9Ug5yRVpc4
         8kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779871315; x=1780476115;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3cbHNaBWG850D03EXV84m/W5J2MfVjctap92g7bifk=;
        b=KRbpl7zfhMlNqulfriQtSXDPyjQf/4/wrVDI5lEVBxOfZ2QLtjcQ6xdRcZ6PYmQw1D
         h1U/zgZ6GLl5dOgCB+5Bm6yYXlbt91i91/OIuX3g2BgrNSrMRX3CgMwFC+S159ZLKCPV
         0vONYtnVpcSykTxU00h+XGdCe2bbbE4E7Gqfo2QhMb5rs1FB/nHpDuQziwiSLKZ6doCq
         m+O9h/7+SEHBvSQSRpmI1jaZ5dpn5InHqT6rRa8d0GSC8gFnkriK2Bcm6wS69rtEoJ9T
         Skkn8zAeZoHmqoUF6HjSlyrsewYs3i7co2nnbK8olwx4mO1Ss1z7Ps/CJaB2AjWhKkNp
         TLcg==
X-Gm-Message-State: AOJu0YxVDHojmdqR5M6rL6Cp58PeAhLyR9GYa/23n8rRyQjElZAorfwe
	vNjUfmvoB/7j3G/yzABM6JNeRISo2Wjs8SjhtMPQs4qB0s7k5tjfT8SMKQoBReWYQIEj0mYG0TG
	dkoWpzXWA2p40sBtisahQXzvKQ0c8Laemfohg7zUJUA==
X-Gm-Gg: Acq92OHG2cntX+/FMeOP9EnzSSIazsnr45YFot2zLWLn+S+kdrgFMQPN6BcpTRmmH4+
	T0SwtDfdqwGxkvyRsj/ruo6UT91ye0eNIr8xjfDk0e15piNjpch+yGckdpH3KvpQO3odm4wg06q
	E3lwU9Fllb652dowrJti8dno7SEzlk7yoAJEJowWfCIwbdTBONvFUDJAML3w2vj2GRXKYiBuTxZ
	bShXlSDcuT1YBIZr1GP/dqRRNXD47tDE0i2Ci4OmMkXjZY1SNrWyW7fAg/6OyS1XVqbm2n1Dsj6
	eTpGg3G5icsXD61epOo=
X-Received: by 2002:a05:6102:32d5:b0:631:3740:7d61 with SMTP id
 ada2fe7eead31-67c8a07640emr10670266137.17.1779871315114; Wed, 27 May 2026
 01:41:55 -0700 (PDT)
MIME-Version: 1.0
From: Ripeer <ripeeerr@gmail.com>
Date: Wed, 27 May 2026 17:41:43 +0900
X-Gm-Features: AVHnY4KsQOini4ZrzZN1yPJHEJA5MYfbcfg_Q11OTPZjaqpsFvUWI7ng_5MwxYU
Message-ID: 
 <CANj20GjhR=qDNQfz_5KZHXymVAbo_osxHAs_aktXTqHq3uRDPA@mail.gmail.com>
Subject: ALC287: Add quirk for Lenovo Xiaoxin 14 GT (SSID 17aa:3912) - audio
 noise on all distributions
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz
Message-ID-Hash: CLFN7YLNVYY46KXLNBP5FKQ6PMAU77ZH
X-Message-ID-Hash: CLFN7YLNVYY46KXLNBP5FKQ6PMAU77ZH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CLFN7YLNVYY46KXLNBP5FKQ6PMAU77ZH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNCkkgaGF2ZSBhIExlbm92byBYaWFveGluIDE0IEdUIChDaGluZXNlIG1hcmtldCBt
b2RlbCkgd2l0aCBBTUQgUnl6ZW4gQUkgOQ0KMzY1Lg0KVGhlcmUgaXMgY29uc3RhbnQgZWxlY3Ry
aWNhbCBoaXNzaW5nIGFuZCBjcmFja2xpbmcgbm9pc2UgZnJvbSBib3RoIGludGVybmFsDQpzcGVh
a2VycyBhbmQgMy41bW0gaGVhZHBob25lIGphY2sgZHVyaW5nIGF1ZGlvIHBsYXliYWNrIG9uIEFM
TCBMaW51eA0KZGlzdHJpYnV0aW9ucyB0ZXN0ZWQgKEFyY2ggTGludXgsIEZlZG9yYSA0NCkuIEF1
ZGlvIHdvcmtzIGNvcnJlY3RseSBvbg0KV2luZG93cy4NClRoZSBub2lzZSBpcyBsb3VkZXIgdGhh
biB0aGUgYXVkaW8gaXRzZWxmLg0KDQo9PSBQcm9ibGVtID09DQoNClRoZSBkZXZpY2UgU1NJRCBp
cyBub3QgaW4gdGhlIHF1aXJrIGxpc3QuIEluIEZlZG9yYSBMaXZlIFVTQiBpdCBzaG93ZWQgYXMN
CjE3YWE6MDAwMCAoQklPUyBub3QgcGFzc2luZyBjb3JyZWN0IElEKS4gSW4gQXJjaCBMaW51eCB0
aGUgY29ycmVjdCBTU0lEDQp3YXMgY29uZmlybWVkOg0KDQogIENvZGVjOiBSZWFsdGVrIEFMQzI4
Nw0KICBWZW5kb3IgSWQ6IDB4MTBlYzAyODcNCiAgU3Vic3lzdGVtIElkOiAweDE3YWEzOTEyDQog
IFJldmlzaW9uIElkOiAweDEwMDAwMg0KDQpLZXJuZWwgbWVzc2FnZToNCiAgc25kX2hkYV9jb2Rl
Y19hbGMyNjkgaGRhdWRpb0MxRDA6IEFMQzI4NzogcGlja2VkIGZpeHVwIGZvciBQQ0kgU1NJRA0K
MTdhYTowMDAwDQoNCj09IEF1ZGlvIGRldmljZXMgKGxzcGNpKSA9PQ0KDQogIGMyOjAwLjEgQXVk
aW8gZGV2aWNlOiBBTUQvQVRJIFJhZGVvbiBIRCBBdWRpbyBbMTAwMjoxNjQwXQ0KICBjMjowMC41
IE11bHRpbWVkaWEgY29udHJvbGxlcjogQU1EIEF1ZGlvIENvcHJvY2Vzc29yIFsxMDIyOjE1ZTJd
DQogIGMyOjAwLjYgQXVkaW8gZGV2aWNlOiBBTUQgUnl6ZW4gSEQgQXVkaW8gQ29udHJvbGxlciBb
MTAyMjoxNWUzXQ0KDQo9PSBHUElPIHN0YXRlIChhbXBsaWZpZXIgbm90IGluaXRpYWxpemVkKSA9
PQ0KDQogIElPWzBdOiBlbmFibGU9MCwgZGlyPTAsIGRhdGE9MA0KICBJT1sxXTogZW5hYmxlPTAs
IGRpcj0wLCBkYXRhPTANCiAgSU9bMl06IGVuYWJsZT0wLCBkaXI9MCwgZGF0YT0wDQogIElPWzNd
OiBlbmFibGU9MCwgZGlyPTAsIGRhdGE9MA0KICBJT1s0XTogZW5hYmxlPTAsIGRpcj0wLCBkYXRh
PTANCg0KPT0gVGVzdGVkIGFuZCBmYWlsZWQgPT0NCg0KICAtIHBvd2VyX3NhdmU9MA0KICAtIG1v
ZGVsPWFsYzI4Ny15b2dhOS1iYXNzLXNway1waW4NCiAgLSBtb2RlbD1hbGMyODctaWRlYXBhZC1i
YXNzLXNway1hbXANCiAgLSBHUElPMSwgR1BJTzIsIEdQSU80IGFjdGl2YXRpb24gdmlhIGhkYS12
ZXJiDQogIC0gV2lyZVBsdW1iZXIgc3VzcGVuZCB0aW1lb3V0IGZpeA0KDQo9PSBTeXN0ZW0gPT0N
Cg0KICBDUFU6IEFNRCBSeXplbiBBSSA5IDM2NSAoMTAgY29yZXMpDQogIEtlcm5lbCB0ZXN0ZWQ6
IDYuMTIuMTAtMzAwLmZjNDQsIDcuMC43LXplbjItMS16ZW4NCiAgRGlzdHJvIHRlc3RlZDogQXJj
aCBMaW51eCwgRmVkb3JhIDQ0DQoNCkNvdWxkIHlvdSBwbGVhc2UgYWRkIGEgcXVpcmsgZm9yIFN1
YnN5c3RlbSBJRCAxN2FhOjM5MTI/DQpJIGFtIGF2YWlsYWJsZSB0byBwcm92aWRlIGFueSBhZGRp
dGlvbmFsIGluZm9ybWF0aW9uIG9yIHJ1biB0ZXN0cy4NCg0KVGhhbmsgeW91Lg0K
