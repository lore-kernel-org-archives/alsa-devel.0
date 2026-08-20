Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE88C5DF85
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:55:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE6336025E;
	Thu, 20 Aug 2026 06:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE6336025E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787201722;
	bh=vynmilly8XsPzEpO3xcUxLf7gp5EctSC1FgEv8+LX+I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rA66ZOOxpTrNaPMDpLIF1abE7hVsvVJm99z4OnU7g3t7Sd6Jx6D70KctHzNkHjz6S
	 X0SnfNZbqEqg2On2TxX78nJO4OM0IbQk9bhzmwBw/bfQ0XDvm4vq7VfYodFLYuHhkE
	 HKKdmk2fTs5m5WQdAOSE3B+Cx8KT9jk+ae5STByY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57E2DF80600; Thu, 20 Aug 2026 06:54:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7A69F805FF;
	Thu, 20 Aug 2026 06:54:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D20DDF8053D; Thu, 20 Aug 2026 06:54:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787201676;
	b=nuAtBfNzezZTXXmHfYy5MxsRErt1fE64riCzcRYeqkBvXnTU7coq52VNk338IkSBOLR8
	 GKXlYSn7a34jnoNIath/pShaqBrG2fLi9fxQDT/7KB/TP1db8dXkBEi90tIbCw5jC0Aj6
	 sZs2DYxQDU9ejD3fVL7sI+6LZmHFNcWAFboX6zRzdGtYiTIThJ/mQ4Ac/To1PTgHmiIEX
	 oJiNtivaEvyEU09mPxS/HSL6FkFC5RS3wbtxF+dnmBIHsFNmzxAVpNk0VlALLmVFBwzGy
	 vvyZ7u5+wrEAzmw1Y+laCWfAi4z22O6UsdRFsx0/v8OjCy+StJpdj2Wo8qIgaf5QysA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787201676;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vynmilly8XsPzEpO3xcUxLf7gp5EctSC1FgEv8+LX+I=;
	b=SW1kjMjFE749+xPMCA1fJ529raeQ4zyK7ZOR9VYijtt1TsaiAWmu1UdEEZSKZ4WQ6lBH
	 k6oaL6vtXJUHHxkIstS9PWEzL/vRx1SQtVuApfBCEP6Q3xvB6vVoBZ9pXYyZr8L0n02Ci
	 nm9pXB3N6FtNqluavOZdD+cx8ZxBSjjeKwHgeoB2pxwKDVLZUMnbyCxyPSLgBBlerXJ7y
	 gfwb38qA20o3n0c1aBH53+nFMzWj8lDYZXMbpxGRY1baFtVnsmGFdOof14tLdWzt8+0AG
	 pHINr7OJffz8oreKKIVFvfUR0ZpOgcnYlreP08/DsIXtmXCfVxCUz4ghdJKkm/UnG9w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E0i3gR1G;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2F376F80246
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2026 06:54:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F376F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E0i3gR1G
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5b2a4359d16so1907372e87.3
        for <alsa-devel@alsa-project.org>;
 Wed, 19 Aug 2026 21:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787201674; x=1787806474;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IULvsnAXkyEItFxGdMx1MOp6yfZD4FFRLsd6O9tEYjQ=;
        b=E0i3gR1G5makOwd8ePzM9mtRVxfr6r20JpiuvscU9iaOv4AuV6aNJIWO3A3smtBqlJ
         Di9anXvfITYG6f1NONsjt9IKt/CHQZ97Xwk4ptmMtGY6FEHXRB9oi9woU1be6fUvvZ8G
         uCk5/pF62OHPY3wnSFiAukW6wXM8uxBHAhf6rITaaPE10ZIniHwXbCq9fWKS0NAbe+4G
         pDntJ1gDxtmF2lc+pCfZWUKBbw/CjtKjjX7cY0Es5fXWZ0ztUjiUw1t5y4Dx3f0KtNeD
         ADvEAgeyKsvGIB3NrkovTMFbW8J2u2wUeQUAh9MVxpEna7hci821CwHVw3PA46vHl3jb
         kw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787201674; x=1787806474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IULvsnAXkyEItFxGdMx1MOp6yfZD4FFRLsd6O9tEYjQ=;
        b=siGBDUiEDnzJOrdhZnXqJOJQCAVmVWQ72Jm8oo5VPJm1Ap59+2YARdgS+DdXHym+qF
         LbGVQ3BdZklH9n4jagDbOPGgCHbWBsvJU3Ydj+eJl+/Lrl4/V5zJg8u9uzyfRtGlXVlP
         hF7UjpJeSKOQE9mcHu5Dq9BTthwIH0LUcQvuzwD9SNLDsBGItaUHKROx53znE7McbjyO
         M7snEj+E3UOwM7GYpgJ7dZ3DbRCwBwiXFwfcOdO5rAxdP2j9aY2uNScflezToMpb0RU2
         Eh8i7oT+jvaHvjaLKLekehEKUArOfGDCHGYViLdI18cW1/Bwax516QQ+ne5kIN0nYfPR
         wveg==
X-Gm-Message-State: AOJu0Yy4y+LT44G48bKSbv2MjBfcFC+0a3QAzALBz58Qx0Tj6qy5JrEd
	YhuaKg/smEsQa2AnmgLW3JIKSqr/KkUzYeQ9r9xikcDqOK2r0tJpAXxtZrRwI3+36DpyOA==
X-Gm-Gg: AR+sD13YJuRHrOHW2NJgYt5hgruDuWoobW1+2yz58Bcgd0+uF2H+NaImgCllOqk6+DU
	B/CseOBAk5qSRFXx3/v94309iOfKaMQg0namGno6XmgFpU9pdkQuyDwt0oidpZa2z0EeZxDQ0Fy
	MKCAV9Ni1gMwBmQE8BzeWtz4VBRqxJqVePY+NJm2kcV6jHSMHZtnoKa4m7MYhI6CjXGOzc1YR5j
	99vzhDpnhBH/XG6uH+6CswXkHdie/RvV9XMrFbIorPO6r+JVQvCbBGceVYUgcAwRP0hohbSb717
	DaKD74csbfpk0U9GMofRPmHT9GfunfaDk8rIynd1vfpXnA/rlsOUoTxyAdZ6zm1yNzRmk+W/hgr
	0l5Jz4OQax+lIvK+TWlHJwRGcuef00OJBi0jVUkMUGe3PdGXhHBbcl3iMxlYxiBxLwphNlbWThp
	dnO8lOBU8dIT1/kN9JccKczHgg7eN9TiFLkgEGWYJZ5GnHyotBZKSgoA==
X-Received: by 2002:a05:6512:3d04:b0:5b2:a483:a369 with SMTP id
 2adb3069b0e04-5b478bdf42emr2827072e87.21.1787201673366;
        Wed, 19 Aug 2026 21:54:33 -0700 (PDT)
Received: from riper-83lr ([31.76.27.112])
        by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b478853b1dsm1000902e87.2.2026.08.19.21.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 21:54:31 -0700 (PDT)
From: Viktor Menshin <ripeeerr@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
Subject: Re: Missing Cirrus CS35L56 firmware for Lenovo Xiaoxin Pro 14 ASP10
 (SSID 17aa:3912) causes distorted/crackling audio
Date: Thu, 20 Aug 2026 13:54:19 +0900
Message-ID: <20260820045419.9846-1-ripeeerr@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SMMD4UHH2TFB5Y4Y7EM4GU6WVSTMF3CE
X-Message-ID-Hash: SMMD4UHH2TFB5Y4Y7EM4GU6WVSTMF3CE
X-MailFrom: ripeeerr@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SMMD4UHH2TFB5Y4Y7EM4GU6WVSTMF3CE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Follow-up to my earlier report, with a correction and a partial fix.

Correction: I initially assumed a Cirrus Logic smart amp (ACPI HID
CIRQ1080) was involved and that CS35L56 firmware was missing. That was
wrong - CIRQ1080 is actually a Cirrus touch controller (touchpad), not an
audio amplifier. There is no Cirrus amp ACPI device on this system at all
(no CSC3551/CSC3556 HID present). Sorry for the noise on that front.

What I've found instead: the codec falls back to the generic "17aa:0000"
Lenovo pin fixup (no entry for SSID 17aa:3912 in patch_realtek.c), and the
ALC287 vendor-specific processing coefficients (node 0x20) are left at
generic/uninitialized defaults. The Windows Realtek driver programs a
model-specific coefficient table into this node at init that the generic
Linux fallback never applies.

To find the actual values, I used VFIO passthrough to hand the physical
HD Audio controller (0000:c2:00.6, 1022:15e3) to a Windows 10 guest
running the stock Realtek driver, logged CORB verb traffic with a patched
QEMU, and extracted the SET_COEF_INDEX / SET_PROC_COEF sequence for node
0x20 using https://github.com/ryanprescott/realtek-verb-tools
(wiki: https://github.com/ryanprescott/realtek-verb-tools/wiki/How-to-sniff-verbs-from-a-Windows-sound-driver)

Headphones - fixed. A single coefficient write completely eliminates the
crackling/distortion on the headphone output:

  hda-verb /dev/snd/hwC1D0 0x20 SET_COEF_INDEX 0x36
  hda-verb /dev/snd/hwC1D0 0x20 SET_PROC_COEF 0x77d7

I've verified this is stable across reboots and under load.

Internal speakers - not fixed. I captured a much larger coefficient table
from a speaker-only session (headphones unplugged, 255 index/value pairs
on node 0x20, representing what looks like the driver's full cold-init
pass) and replayed it via hda-verb. This does not resolve the speaker
crackling.

Attached below:
1. Confirmed-working single coefficient write for headphones
2. The larger speaker-session table I tried, included for reference even
   though it doesn't fix the issue.

System info (unchanged from prior report): Lenovo Xiaoxin Pro 14 ASP10
(83LR), AMD Ryzen AI 9 365, ALC287 codec, SSID 17aa:3912, currently
running Linux 7.1.6-arch1-1.

Thanks,
Viktor Menshin
# Confirmed working fix for headphone crackling on Lenovo Xiaoxin Pro 14 ASP10
# (SSID 17aa:3912), Realtek ALC287, node 0x20 (vendor processing coefficients)

hda-verb /dev/snd/hwC1D0 0x20 SET_COEF_INDEX 0x36
hda-verb /dev/snd/hwC1D0 0x20 SET_PROC_COEF 0x77d7

# As a kernel-style fixup:
#
# static void alc287_fixup_lenovo_xiaoxin_pro14_asp10_hp(struct hda_codec *codec,
#                                                          const struct hda_fixup *fix, int action)
# {
#         if (action != HDA_FIXUP_ACT_INIT)
#                 return;
#
#         alc_write_coef_idx(codec, 0x36, 0x77d7);
# }

--- speaker-session 255-coefficient table (does NOT fix speaker crackling) ---

#!/bin/bash
# Full init table - first occurrence of each coefficient index, from cold speaker-path start
DEV=/dev/snd/hwC1D0

hda-verb $DEV 0x20 SET_COEF_INDEX 0x0
hda-verb $DEV 0x20 SET_PROC_COEF 0x2
hda-verb $DEV 0x20 SET_COEF_INDEX 0x1
hda-verb $DEV 0x20 SET_PROC_COEF 0xaaaa
hda-verb $DEV 0x20 SET_COEF_INDEX 0x2
hda-verb $DEV 0x20 SET_PROC_COEF 0x8aaa
hda-verb $DEV 0x20 SET_COEF_INDEX 0x3
hda-verb $DEV 0x20 SET_PROC_COEF 0xf042
hda-verb $DEV 0x20 SET_COEF_INDEX 0x4
hda-verb $DEV 0x20 SET_PROC_COEF 0xaa89
hda-verb $DEV 0x20 SET_COEF_INDEX 0x5
hda-verb $DEV 0x20 SET_PROC_COEF 0x700
hda-verb $DEV 0x20 SET_COEF_INDEX 0x6
hda-verb $DEV 0x20 SET_PROC_COEF 0x6115
hda-verb $DEV 0x20 SET_COEF_INDEX 0x7
hda-verb $DEV 0x20 SET_PROC_COEF 0x200
hda-verb $DEV 0x20 SET_COEF_INDEX 0x8
hda-verb $DEV 0x20 SET_PROC_COEF 0x4a37
hda-verb $DEV 0x20 SET_COEF_INDEX 0x9
hda-verb $DEV 0x20 SET_PROC_COEF 0x8000
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa
hda-verb $DEV 0x20 SET_PROC_COEF 0x7770
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb
hda-verb $DEV 0x20 SET_PROC_COEF 0x7779
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc
hda-verb $DEV 0x20 SET_PROC_COEF 0x816f
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd
hda-verb $DEV 0x20 SET_PROC_COEF 0xa023
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe
hda-verb $DEV 0x20 SET_PROC_COEF 0x65c0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf
hda-verb $DEV 0x20 SET_PROC_COEF 0x2a2
hda-verb $DEV 0x20 SET_COEF_INDEX 0x10
hda-verb $DEV 0x20 SET_PROC_COEF 0x320
hda-verb $DEV 0x20 SET_COEF_INDEX 0x11
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x12
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x13
hda-verb $DEV 0x20 SET_PROC_COEF 0x2200
hda-verb $DEV 0x20 SET_COEF_INDEX 0x14
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x15
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x16
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x17
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x18
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x19
hda-verb $DEV 0x20 SET_PROC_COEF 0x2c91
hda-verb $DEV 0x20 SET_COEF_INDEX 0x1a
hda-verb $DEV 0x20 SET_PROC_COEF 0x8c83
hda-verb $DEV 0x20 SET_COEF_INDEX 0x1b
hda-verb $DEV 0x20 SET_PROC_COEF 0xa6b
hda-verb $DEV 0x20 SET_COEF_INDEX 0x1c
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x1d
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x1e
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x1f
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x20
hda-verb $DEV 0x20 SET_PROC_COEF 0x1000
hda-verb $DEV 0x20 SET_COEF_INDEX 0x21
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x22
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x23
hda-verb $DEV 0x20 SET_PROC_COEF 0x8804
hda-verb $DEV 0x20 SET_COEF_INDEX 0x24
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x25
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x26
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x27
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x28
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x29
hda-verb $DEV 0x20 SET_PROC_COEF 0x3000
hda-verb $DEV 0x20 SET_COEF_INDEX 0x2a
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x2b
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x2c
hda-verb $DEV 0x20 SET_PROC_COEF 0xf00
hda-verb $DEV 0x20 SET_COEF_INDEX 0x2d
hda-verb $DEV 0x20 SET_PROC_COEF 0x1f4f
hda-verb $DEV 0x20 SET_COEF_INDEX 0x2e
hda-verb $DEV 0x20 SET_PROC_COEF 0x290e
hda-verb $DEV 0x20 SET_COEF_INDEX 0x2f
hda-verb $DEV 0x20 SET_PROC_COEF 0xef57
hda-verb $DEV 0x20 SET_COEF_INDEX 0x30
hda-verb $DEV 0x20 SET_PROC_COEF 0x9007
hda-verb $DEV 0x20 SET_COEF_INDEX 0x31
hda-verb $DEV 0x20 SET_PROC_COEF 0x80c0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x32
hda-verb $DEV 0x20 SET_PROC_COEF 0x50a8
hda-verb $DEV 0x20 SET_COEF_INDEX 0x33
hda-verb $DEV 0x20 SET_PROC_COEF 0x8580
hda-verb $DEV 0x20 SET_COEF_INDEX 0x34
hda-verb $DEV 0x20 SET_PROC_COEF 0xa281
hda-verb $DEV 0x20 SET_COEF_INDEX 0x35
hda-verb $DEV 0x20 SET_PROC_COEF 0x8daa
hda-verb $DEV 0x20 SET_COEF_INDEX 0x36
hda-verb $DEV 0x20 SET_PROC_COEF 0x77d7
hda-verb $DEV 0x20 SET_COEF_INDEX 0x37
hda-verb $DEV 0x20 SET_PROC_COEF 0xfe05
hda-verb $DEV 0x20 SET_COEF_INDEX 0x38
hda-verb $DEV 0x20 SET_PROC_COEF 0x7909
hda-verb $DEV 0x20 SET_COEF_INDEX 0x39
hda-verb $DEV 0x20 SET_PROC_COEF 0x330a
hda-verb $DEV 0x20 SET_COEF_INDEX 0x3a
hda-verb $DEV 0x20 SET_PROC_COEF 0x10
hda-verb $DEV 0x20 SET_COEF_INDEX 0x3b
hda-verb $DEV 0x20 SET_PROC_COEF 0x60d9
hda-verb $DEV 0x20 SET_COEF_INDEX 0x3c
hda-verb $DEV 0x20 SET_PROC_COEF 0xf135
hda-verb $DEV 0x20 SET_COEF_INDEX 0x3d
hda-verb $DEV 0x20 SET_PROC_COEF 0xc2ba
hda-verb $DEV 0x20 SET_COEF_INDEX 0x3e
hda-verb $DEV 0x20 SET_PROC_COEF 0xa928
hda-verb $DEV 0x20 SET_COEF_INDEX 0x3f
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x40
hda-verb $DEV 0x20 SET_PROC_COEF 0x8800
hda-verb $DEV 0x20 SET_COEF_INDEX 0x41
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x42
hda-verb $DEV 0x20 SET_PROC_COEF 0x2000
hda-verb $DEV 0x20 SET_COEF_INDEX 0x43
hda-verb $DEV 0x20 SET_PROC_COEF 0x3d97
hda-verb $DEV 0x20 SET_COEF_INDEX 0x44
hda-verb $DEV 0x20 SET_PROC_COEF 0x4900
hda-verb $DEV 0x20 SET_COEF_INDEX 0x45
hda-verb $DEV 0x20 SET_PROC_COEF 0x5289
hda-verb $DEV 0x20 SET_COEF_INDEX 0x46
hda-verb $DEV 0x20 SET_PROC_COEF 0xcc4
hda-verb $DEV 0x20 SET_COEF_INDEX 0x47
hda-verb $DEV 0x20 SET_PROC_COEF 0xa47a
hda-verb $DEV 0x20 SET_COEF_INDEX 0x48
hda-verb $DEV 0x20 SET_PROC_COEF 0xd049
hda-verb $DEV 0x20 SET_COEF_INDEX 0x49
hda-verb $DEV 0x20 SET_PROC_COEF 0x49
hda-verb $DEV 0x20 SET_COEF_INDEX 0x4a
hda-verb $DEV 0x20 SET_PROC_COEF 0x2010
hda-verb $DEV 0x20 SET_COEF_INDEX 0x4b
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x4c
hda-verb $DEV 0x20 SET_PROC_COEF 0x65c
hda-verb $DEV 0x20 SET_COEF_INDEX 0x4d
hda-verb $DEV 0x20 SET_PROC_COEF 0x7fff
hda-verb $DEV 0x20 SET_COEF_INDEX 0x4e
hda-verb $DEV 0x20 SET_PROC_COEF 0x7fff
hda-verb $DEV 0x20 SET_COEF_INDEX 0x4f
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x50
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x51
hda-verb $DEV 0x20 SET_PROC_COEF 0x5f5f
hda-verb $DEV 0x20 SET_COEF_INDEX 0x52
hda-verb $DEV 0x20 SET_PROC_COEF 0x100
hda-verb $DEV 0x20 SET_COEF_INDEX 0x53
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x54
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x55
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x56
hda-verb $DEV 0x20 SET_PROC_COEF 0xfd00
hda-verb $DEV 0x20 SET_COEF_INDEX 0x57
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x58
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x59
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x5a
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x5b
hda-verb $DEV 0x20 SET_PROC_COEF 0x777
hda-verb $DEV 0x20 SET_COEF_INDEX 0x5c
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x5d
hda-verb $DEV 0x20 SET_PROC_COEF 0x6000
hda-verb $DEV 0x20 SET_COEF_INDEX 0x5e
hda-verb $DEV 0x20 SET_PROC_COEF 0x4000
hda-verb $DEV 0x20 SET_COEF_INDEX 0x5f
hda-verb $DEV 0x20 SET_PROC_COEF 0x6200
hda-verb $DEV 0x20 SET_COEF_INDEX 0x60
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x61
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x62
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x63
hda-verb $DEV 0x20 SET_PROC_COEF 0xc000
hda-verb $DEV 0x20 SET_COEF_INDEX 0x64
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x65
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x66
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x67
hda-verb $DEV 0x20 SET_PROC_COEF 0x3000
hda-verb $DEV 0x20 SET_COEF_INDEX 0x68
hda-verb $DEV 0x20 SET_PROC_COEF 0x1
hda-verb $DEV 0x20 SET_COEF_INDEX 0x69
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x6a
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x6b
hda-verb $DEV 0x20 SET_PROC_COEF 0xa394
hda-verb $DEV 0x20 SET_COEF_INDEX 0x6c
hda-verb $DEV 0x20 SET_PROC_COEF 0x7fff
hda-verb $DEV 0x20 SET_COEF_INDEX 0x6d
hda-verb $DEV 0x20 SET_PROC_COEF 0x7000
hda-verb $DEV 0x20 SET_COEF_INDEX 0x6e
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x6f
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x70
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x71
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x72
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x73
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x74
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x75
hda-verb $DEV 0x20 SET_PROC_COEF 0x4101
hda-verb $DEV 0x20 SET_COEF_INDEX 0x76
hda-verb $DEV 0x20 SET_PROC_COEF 0x8300
hda-verb $DEV 0x20 SET_COEF_INDEX 0x77
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x78
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x79
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x7a
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x7b
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x7c
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x7d
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x7e
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x7f
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x80
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x81
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x82
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x83
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x84
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x85
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x86
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x87
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x88
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x89
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x8a
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x8b
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x8c
hda-verb $DEV 0x20 SET_PROC_COEF 0xff80
hda-verb $DEV 0x20 SET_COEF_INDEX 0x8d
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x8e
hda-verb $DEV 0x20 SET_PROC_COEF 0x2
hda-verb $DEV 0x20 SET_COEF_INDEX 0x8f
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x90
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x91
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x92
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x93
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x94
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x95
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x96
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x97
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x98
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x99
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x9a
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x9b
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x9c
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x9d
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x9e
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0x9f
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa0
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa1
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa2
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa3
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa4
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa5
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa6
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa7
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa8
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xa9
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xaa
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xab
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xac
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xad
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xae
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xaf
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb0
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb1
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb2
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb3
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb4
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb5
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb6
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb7
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb8
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xb9
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xba
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xbb
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xbc
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xbd
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xbe
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xbf
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc0
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc1
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc2
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc3
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc4
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc5
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc6
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc7
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc8
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xc9
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xca
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xcb
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xcc
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xcd
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xce
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xcf
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd0
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd1
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd2
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd3
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd4
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd5
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd6
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd7
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd8
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xd9
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xda
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xdb
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xdc
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xdd
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xde
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xdf
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe0
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe1
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe2
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe3
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe4
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe5
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe6
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe7
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe8
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xe9
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xea
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xeb
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xec
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xed
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xee
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xef
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf0
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf1
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf2
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf3
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf4
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf5
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf6
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf7
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf8
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xf9
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xfa
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xfb
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xfc
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xfd
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
hda-verb $DEV 0x20 SET_COEF_INDEX 0xfe
hda-verb $DEV 0x20 SET_PROC_COEF 0x0
