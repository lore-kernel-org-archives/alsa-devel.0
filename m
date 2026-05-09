Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2976FCD37BE
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:45:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DC83601D1;
	Mon, 11 May 2026 16:45:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DC83601D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510727;
	bh=gFQd6lYVjklfunaumPmnBPTs6Io1cQDOV9pFeFhIIeo=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=QbjnmkYdgir6nYx2DsgatIPD+31AP8Pbtx4OKAkfE3+z6XQM0OdIrHDIlc98zZdy7
	 44aMfiAO0jtpGjcXYsLLKmMIADP9Mwf83Wz6BK+0z3fH5wrCdx92SyWcE2SIMCKADj
	 y47lB7Xls7vK0QNTMQ2s9C3/z95IHBIn9SVAUiC0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99E99F80630; Mon, 11 May 2026 16:44:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 613BCF80630;
	Mon, 11 May 2026 16:44:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A883F80544; Sat,  9 May 2026 09:39:14 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7BE43F800E2
	for <alsa-devel@alsa-project.org>; Sat,  9 May 2026 09:39:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BE43F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jDVjgJRh
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8c70b5594f4so310915685a.1
        for <alsa-devel@alsa-project.org>;
 Sat, 09 May 2026 00:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778312350; cv=none;
        d=google.com; s=arc-20240605;
        b=eTFqcsQuDD5tOWcn8OfNay+JM2D0e1HBaLnQzoNb0y6Bt7bwzMY3xEh00nc/GP4rsl
         yjGb3+tvTkhsHgroGhbp6G2ErIFDZupBC3mMhDtVhdmcLPYthRIU0rY3k4+Zt1H0LMDz
         /clrlqYSnmudBVwXfql0v06L7rbOiAGczJRCGQAoN9JYPx4GBIqzW2B9eK5gaFaHXd9V
         Uri1cwyYvv5dBLavvp63kZBR0XVdM8s5muZWwjrqIb6WiHR2nkc5DLr762bBQjCGj009
         McC8eKB/r44eWzXVWE1GYEmPyWQxqRtZF5CUEJgEzLqiLKPJzSqTM3q++DLAnTQpFSLE
         gHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RRv0eM1+ipVT242+NGff+AG63iml+vlaTodvGGo/VQ4=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=X0mKzDvnYD9OEIi5ToGh8nSFB2Jcx3NLLY83AhZBHOM3iig7L3B8VQTrDwSSegF2vc
         ZJS5N3BX2pHogNq0zEqPLlHbE+BNEDO4hrbBnLHkMD8c/DHYce+fgJzq/buwh7S5mbuu
         TO5FSUgYAj+b5dzDDB8d3WUhlWvA7RMa3+ohqT3tGMLdAUC3CpcS9zteuMEMLdFXvrx6
         k9po5W537WssY6xlt6JM4Ho52TqcHdGY6/KJLBk9GKtWP5mMs08+bEU7lD69Jx5GJ62t
         pBUWItLkLjMjyalNG5L6mEYb+r3DqVzmCeIKIpXmYPVUChgC4gF3SjwpYVBT8K/q1F5Q
         degA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778312350; x=1778917150;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRv0eM1+ipVT242+NGff+AG63iml+vlaTodvGGo/VQ4=;
        b=jDVjgJRhIjuVRQm6oB/ikIdQziXKh6yg8FdvhhwR9lgJNITCgqvr1airZ64Ceh7j1R
         ZbhLuAgjTJeiWRjoX22yfwWXCaGRmPYImcRSF9kqyH/JAO4Pd0nbsYvVVU3Z93lcLQB4
         YmOHrHCpkzvuvBrSsugs1Ga6VPdS8R2COlV5NRQX0DgsIXLOI6ds+VgJ1Yy8uwxmiH16
         /nwWxXyd2JSf58DoF1QL73qPN6DJlHb6KNpXe2Lf65pYvvWRFhjL4kwhHOSCZ3y+5rTY
         65Abf7K3FKmGyh8QB7+/GtRG24iwo1rE35nSZK7RQGtc9yTuxZEfIpt/06RfAvZ1mK5h
         oDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778312350; x=1778917150;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRv0eM1+ipVT242+NGff+AG63iml+vlaTodvGGo/VQ4=;
        b=J8SqGWahhsWP4ddyNwlHVWwsMp00wYLwC9LrPUWod0q4Vs/Y/ZfiCojBYodLEg0U4I
         c5Oyc49Cb4bbeE6ohd5xWfd5/etxrXQCF3B0OIRjWFEvMWzOb88FGk03RjcZBMYGGULW
         FGpBY5GOWDrgs6b+sW1qvsqf2AkhI7HqGnvYs16bdF4FY2SsNtYU4P08DayJszQPKG4L
         94uavuUfm6U5jVhYIeEsf9pBUmvucvphRpWfzLpnAbqX+8A+99yrWQKRMRf1bq64JMOE
         Bk+pph82gHuX2g6pp3almG5Ezjtj786aOMD22B/EpN7y+ZwNhQcMh58unXc/R901sa1N
         0FKw==
X-Gm-Message-State: AOJu0YxeX62f6d8ncTwaD2M/PWkQNV+rWMSbQpd8njfxvZZ6xG4e2sSk
	//rQtFzlN1XqEif/gLpm9EOncX3ftenQy+IuJEUyMwdENoUbahXRs7Y580rm71cRpPe7jBocYdU
	NKEtUMfK0LdQLT6U7P/LIi8d4FMirAyab6GXw
X-Gm-Gg: AeBDiesAU03e+htLCRzwbnDm3meJ5/dgPE21ABBZ+Iq9Q3FCTHOEXrhL0RP5UKv8Vvr
	0Ag8ASGCxQezGM+1GpNkBrYGBdKEIO+liJqFvml5Pu8C2GlXMe/vqXAlWbaHEIgNOuychcknk9T
	iCt1kJhJL7Up+nTOosINk/0Sncwwh9/v+M+3Vk7gNYkLAPc+f8fQ0wkon7oURFmZZgz0OunbX+c
	AJzCkW3rjgrGTx9oj9XL4wM/ov7ElBT478iNc2pSwjXgzI/mo8g8lO1O2l1Xs+DEKaDpqQyuhWC
	C3wcGKEHwK9ojsCN4aooNAhhIZwLUneN4jIqQInWe5VME6YjqCHMDJ8Lx4VJ1BhZPs0lNSgcwg=
	=
X-Received: by 2002:a05:620a:29c2:b0:905:ebde:ffa4 with SMTP id
 af79cd13be357-9065353f41cmr1376460185a.23.1778312350027; Sat, 09 May 2026
 00:39:10 -0700 (PDT)
MIME-Version: 1.0
From: Matthaeus Muniz <matthaeusmuniz@gmail.com>
Date: Sat, 9 May 2026 00:38:58 -0700
X-Gm-Features: AVHnY4IMhwoNk0_JvuZ3cVs1SEp8v1qrPwh5B6_QHcKFN3h644Bp0u6es-qurkM
Message-ID: 
 <CANZdgkko7C6gXbpdsu6rRxULRSyTtenCeN0jmODODbT8yi-b9A@mail.gmail.com>
Subject: ALSA: hda/realtek - ALC257 SSID 17aa:22b1 missing quirk (ThinkPad T14
 Gen 1)
To: alsa-devel@alsa-project.org
X-MailFrom: matthaeusmuniz@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FWD4WZ247WURH33AUJIJ7B4CROPN7GUE
X-Message-ID-Hash: FWD4WZ247WURH33AUJIJ7B4CROPN7GUE
X-Mailman-Approved-At: Mon, 11 May 2026 14:44:28 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FWD4WZ247WURH33AUJIJ7B4CROPN7GUE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGFyZHdhcmU6IExlbm92byBUaGlua1BhZCBUMTQgR2VuIDEgKDIwUzEwMDJUQlIpDQpDb2RlYzog
UmVhbHRlayBBTEMyNTcgKDEwZWM6MDI1NykNClBDSSBTU0lEOiAxN2FhOjIyYjENCktlcm5lbDog
Ni4xNy4wLTIzLWdlbmVyaWMNCg0KUHJvYmxlbToNCkRyaXZlciByZWFkcyBTU0lEIGFzIDE3YWE6
MDAwMCBhZnRlciBJbnRlbCBNRSBmaXJtd2FyZSB1cGRhdGUNCigyMjUuNzUuMjQyMCDihpIgMjI1
Ljc3LjI0OTcpLCBmYWxsaW5nIGJhY2sgdG8gZW1wdHkgZml4dXAuDQpJbnRlcm5hbCBtaWNyb3Bo
b25lIChETUlDKSBzdG9wcGVkIHdvcmtpbmcuDQoNCi9zeXMvYnVzL2hkYXVkaW8vZGV2aWNlcy9o
ZGF1ZGlvQzBEMC9zdWJzeXN0ZW1faWQgPSAweDE3YWEyMmIxDQovc3lzL2J1cy9wY2kvZGV2aWNl
cy8wMDAwOjAwOjFmLjMvc3Vic3lzdGVtX2RldmljZSA9IDB4MjJiMQ0KDQpkbWVzZyBzaG93czoN
CnNuZF9oZGFfY29kZWNfYWxjMjY5OiBBTEMyNTc6IHBpY2tlZCBmaXh1cCBmb3IgUENJIFNTSUQg
MTdhYTowMDAwDQoNClN1Z2dlc3RlZCBmaXg6IGFkZCBxdWlyayBlbnRyeSBmb3IgMTdhYToyMmIx
IGluIHBhdGNoX3JlYWx0ZWsuYw0K
