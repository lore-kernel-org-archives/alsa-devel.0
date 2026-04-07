Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3449DE98FDD
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:57:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48CFC60202;
	Thu,  9 Apr 2026 11:57:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48CFC60202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775728668;
	bh=sQBM2LXzH9UodZ0G5wbLy8kPFqUBrmcAfm7Jw9ILdNI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=P2gtnlAzG3tS/BeIvShaDPjcagSEtsfTZ7zW7myUjeyfxspjea8vSJwOYDMceE7GJ
	 bsA1u7Ry8dj06VaxXLZbb4L9PvMSBD40U6IbOuw4wBoBF8oTE3pwjkvTpsjU5cAz5j
	 EDSETUasZLVd2/OQaxxd5cMWYc98TMejmgA9yZRE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30E78F805F3; Thu,  9 Apr 2026 11:57:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EECDF805F1;
	Thu,  9 Apr 2026 11:57:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B14E0F80548; Tue,  7 Apr 2026 18:14:58 +0200 (CEST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 714CAF80154
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 18:14:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 714CAF80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fyM+j+CZ
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-794719afcd4so51242557b3.1
        for <alsa-devel@alsa-project.org>;
 Tue, 07 Apr 2026 09:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775578493; cv=none;
        d=google.com; s=arc-20240605;
        b=hWD76KKmVGbdyc1kxu4MEH2JIVkaWKw2dLuTSMMQxrP2kaT4s9fzAOcEJteCfrgH9Y
         fauPeNzUZmWJfudRFs704v158l6lzGOwkOGe8Hci6bCmcp4WgvrxHd6/4SCb/NlMwkWG
         I1M/FMMHx7osDfGD3tuuuKOUtXEur5f0sGjxhWdwOilc4kmChKu6a+luP5oBR7RB2jCW
         hjmy3QUn9CDa9tsI/m2JwKmxC9UQRPqoHlkuyZmWSgYbaLhTMEsNlXJv7AW5Assw6IsO
         gSCDDL5+TJ7oScOjjDfubCTiQWcKnoMroeWUDOqXFj9cPWTlhPRGCQGamnY6NDHyhBay
         Z/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=nhfraOcnoZ2ejEo//uTWXLFpGdPvhP0DI8AXIW9n3AE=;
        fh=dBSINSrh+dZtWEP0pR2323P8G/MRu1im4fhQaZzZhOY=;
        b=cUryVkcia/xH9sBKlWrLiSfwX5Xy0RWhoQ+ar8yZB09UhZgTRp49/hG84sabD9Y8J7
         KYpBZ/NNfckLSMGKjZU5v+20uj0aB8Rx1rRxOVwRPi7ombT1/yUcIqkEOu4465C3zE4c
         h3w0gzBfnv2xyvrY2MBWhGsgwATITtKi74pYde4lxUAZuerrBxrGQqSgcBJjFT78k12L
         m3Bth5ClfiD2Enm7Jr5RxBzgXbX27EGlcRpU0cQ2130ZtYTpKVCIPD+jNF76P49v9MDH
         rJXyoYbyC91h67oGGvizYAD85XIjsY4dRgAUwrr3EBzClPHSt0fBH+OLS/2noTVRVMq2
         wpFw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578493; x=1776183293;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nhfraOcnoZ2ejEo//uTWXLFpGdPvhP0DI8AXIW9n3AE=;
        b=fyM+j+CZK2J6sCfAmQMTRAf6uYyt5nCjdozTcLPqjfm3E677LPXe9ZGRN6cvHzac2I
         s6k4tIUmHDib5FZusc/LfJ2DXpKevvOBXMq8aZxbOm2aXtEU03lB2S22p25bHqwV8Uoh
         0kHZMUn59e1arQPsoOXWhSRk586Q4zwqh3+Wq3hI+MoKAJ1+myK2VBokMWMKE+Ut/Pff
         SoLkR41YTeXShPGYOXq53dTg5KlLxGbIsZZZr/eO02ISJEezRInqSAoJKfvGLWPY8tNp
         o4vk7XIPkrc+fKsy5Zsw73PjLdJ/EakPdMP4RPE3YiCqlztJaMin/ML35n8F3dTfKfUB
         lrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578493; x=1776183293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhfraOcnoZ2ejEo//uTWXLFpGdPvhP0DI8AXIW9n3AE=;
        b=jzzkrY1KjXKLu2GLuihn2XTc5mRR+aJz3Z/sK8XWccGPmvh8ZiqYmdBSLWNDOBPhxT
         9mxhcWJVOMvokNlvyg5Mp0799Gu5rn3eii6p43l8I5fE56sdZxOB87htNA2XyfM03JbA
         1TVFFtqKKW5ok89E6c3vAGw7swk2skqpVOwn6mZm3ETidpb7ypQONz/T56lcv6hCJ4gr
         OuFmJWDVDBCy2AbxZ6fLw9XEhTwKzuyVRQz7Qxr2vSSR0fUGefM8ttZFYFflLPiIiFkP
         ENppkLJslMh3ZrHbUSOTHu6lVooSHOZE9OEv6se4ITMeNaQ8ek0LuoidY3fACmKvd4Be
         0amg==
X-Gm-Message-State: AOJu0YyfKKn5owxkkfjE3R6TYBaRdKSzJjo3c3IqpEHWNwpFOBPLJWiH
	tF9HYpd8UdGWzp3KQ8yJ9E776+7Sy6X11Oqw7GG+hvj2047m4rDecviIBcTqg4Q8fAEpREo+c4c
	GlVcIbJk0Zf9F+QibZRZ7tou/ACZZry0VA9I/0z8=
X-Gm-Gg: AeBDieuuVA0uBCJjLWwdNw2nVO0CGPgurBa1OZ5gC2DLPodXimHUZi2+/9PJXB2A7k5
	k92Uh6xMN0OPsClRJ3Cos2EmSh6pZI9wyg2FagZpVIdkEwH2/kTzXfmWCBUnBFjPC5qxAxy5VF/
	EhPpcmwCVs6ft1xYaF1MRz2p6Y3pKrwZv5Kit0lwuuXAJK2VgIFxJysu+otWRpEAuQn65+zfrim
	SO1q9nu4WM79Xq8TagbPIgAXuZsBqCgHPEjDG1oAc7vVs4wPlK0DHVP9JWklIhX9SlbAStGPCQT
	yDq/0XFpyQ==
X-Received: by 2002:a05:690c:660e:b0:79e:1fe4:80d7 with SMTP id
 00721157ae682-7a4d5d5d907mr166903337b3.48.1775578493396; Tue, 07 Apr 2026
 09:14:53 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Carlos_David_Garc=C3=ADa_Mart=C3=ADnez?= <backich99@gmail.com>
Date: Tue, 7 Apr 2026 10:14:39 -0600
X-Gm-Features: AQROBzB65xOshrmSOO_SysSkgdAPdH1Q3QczWBOcEMOnEO-Xm12dhisE9DfbmXk
Message-ID: 
 <CANDawC1cfcr1k1BED8wW+Vt93PzKJaYnNmrtk31hFDz1HntVbw@mail.gmail.com>
Subject: No audio output and missing internal mic on ThinkPad E14 Gen 7 Intel
 (Conexant SN6140, subsystem 17aa:5130)
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: backich99@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: H7CLUPH733BON7AP6KYBSCF6XCISNY25
X-Message-ID-Hash: H7CLUPH733BON7AP6KYBSCF6XCISNY25
X-Mailman-Approved-At: Thu, 09 Apr 2026 09:57:03 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H7CLUPH733BON7AP6KYBSCF6XCISNY25/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

**Hardware:** Lenovo ThinkPad E14 Gen 7 (Intel Core i5, Raptor Lake-P)
**OS:** TUXEDO OS 24.04.4 LTS
**Kernel:** 6.17.0-111019-tuxedo
**Codec:** Conexant SN6140 (Vendor ID: 0x14f11f87, Subsystem ID: 0x17aa5130=
)

## Problems

1. Headphone jack (3.5mm) produces no sound
2. Internal microphone not detected

## Root cause identified

The driver reads PCI subsystem ID as `17aa:0000` instead of the correct
`17aa:5130`, so no ThinkPad-specific fixup is applied:

    snd_hda_codec_conexant: SN6140: picked fixup for PCI SSID 17aa:0000

A board-specific fixup entry for subsystem `0x17aa5130` is needed in
sound/pci/hda/patch_conexant.c to initialize the GPIO/EAPD amplifier
and define pin configs for the internal mic (Node 0x18, currently N/A).

## Things already tried (without success)

- options snd_hda_intel model=3Dauto
- options snd_hda_codec_conexant model=3Dthinkpad
- hda-jack-retask.fw firmware patch with pin overrides
- Manual sysfs writes to user_pin_configs + reconfig
- snd_hda_intel.dmic_detect=3D0 kernel parameter
- hda-verb EAPD commands on node 0x16

## Full codec dump

(pega aqu=C3=AD el contenido de: cat /proc/asound/card0/codec#0)

## References

- Same issue reported by other E14 Gen 7 users (no fix found):
  https://forums.linuxmint.com/viewtopic.php?t=3D451664
- LKML patch renaming SN6140 (Jun 2025):
  https://lkml.org/lkml/2025/6/16/331

--=20
-----
Carlos Garc=C3=ADa
