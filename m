Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A09E98FDD
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:58:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F45860211;
	Thu,  9 Apr 2026 11:57:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F45860211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775728681;
	bh=rk9wbOyeSfL4He4hyh+jfhVWYok7p/JSYsceV/jRLww=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bY9fBwWp8ObBUw9aFYjLX8SqB3AykDSwd0ZQyVnYPQCP5/GJFQPquHuIjhT54VMsc
	 B0nHl5D49qw//zxrV02M5KKTloVc8UTgUHWPXsVTYcH2/RDiMcPD3g8ZdS/OGZrCQz
	 o5GpJjp4WLWbI246X62qjD2hY3Nc5opJdAOCXpvw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B936F80609; Thu,  9 Apr 2026 11:57:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 38BC6F8060B;
	Thu,  9 Apr 2026 11:57:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19A66F80548; Tue,  7 Apr 2026 18:18:50 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C8590F8001F
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 18:18:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8590F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pq/1ez9/
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-79f855b2575so52198867b3.2
        for <alsa-devel@alsa-project.org>;
 Tue, 07 Apr 2026 09:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775578725; cv=none;
        d=google.com; s=arc-20240605;
        b=iNNlL0VDsjHChdAgNq7UxMNeChistF9xhIC59UBJeBNmnV7cBEJehdxnNhX6k7nPWJ
         KfU9j5JleRCZB9qUzELVTfq2bvB6h7SGqHQxxXLkUM26dNWcvDiw4XOKYogTkMLak1xS
         PKBECbmKqNepD40mhFckuCuKRgRxLipj++wJNqClNrSZZcR/27y+D5fBRdYfHItFnUAA
         Q7X2d32jJAntS9lh0PVWEkdeu8wUz9oi1gSPbi8aYA1EmtzSG+569sQ9qO44wRN2JfXR
         2zwyAXTdSMiwPuVTMPBabkaX4mGYoSp3UEZn4xovCXi0ruD+n5oV6bZqcxRZYOVLDuDF
         0llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LL5eiEOFXgLtskTMd3wIp9uNQ2A2CSfGpUnMdtXorw0=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=ZlzbNVtnOwJmBOeRNyOxARduKP58saEJL4HLmPHbqkmYlx5lYYPSgxjg/sV9A9EF0C
         m4EK9/lRW1rhJLb+UBNnOqZeCKbfkJxU2CjyFdApEu6qhWNHyFDo08DYnh19pbV03u6Q
         94QaPPho3N0KvzKsj9EkK1rGEcnV9tj3PXL0XsbKI715vMrQp6QUFq8xj6exqW5BvE3p
         K+hYabGHKLhPfj2NsjN9JsA4U6nhRBpnw38WxVLW1CwlurP/D+CAlVFTPOt+OFkS/2gD
         2CjMhlPd6Y9qfjNXE44Z2CaXCvCS1SrekyxcakRcmGWuR4x2M0pgNgZRbJ0FTrDWn0SK
         X1Jw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578725; x=1776183525;
 darn=alsa-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL5eiEOFXgLtskTMd3wIp9uNQ2A2CSfGpUnMdtXorw0=;
        b=pq/1ez9/63xanc2n47rvxPoBnBrhyOFqAHDqAsNVAA/XABHBnu4woHJut0vPTOw4zo
         z96ARH2k0uXzRhbstZ2Yc4IBMbrUVbjhel48u1bEQEYff5IhMcKs7gICmdH4JYgAuKIb
         QnhOo5aP5oBmBCfSodfnyGBo3K/FOTn0DrzImHMHMVbyX9PgwxrEwKXdTzcq5TYD5UF5
         pjMWfzYuLonQ2yivtbLTUPwH4vDhrcD/UNjFNgvvf8fEqWgLomBknceSlItZsJpwIIes
         stMHbI7owewFYz6h3+t3qZbAdqZzXhMDjdEAfClwoy4fSVMksCvclwcEKb+OSJSZjS4x
         ftgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578725; x=1776183525;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LL5eiEOFXgLtskTMd3wIp9uNQ2A2CSfGpUnMdtXorw0=;
        b=bqld4EI1i4UzYW1nHyx9KDV0tS18SyRkmKH9p6D0IscLyQrSI9zYqnMVX9/nkpLMEV
         l8sZJE3ugOGawD23V3k7GkvzXNtU38pp+aZwAOjN8ZgFDQ1Nb6+IO41YwDlU1fJ6tAz6
         2kUebhnT85rWuWGrdEHmxZTBuxP+hdduOSgoLAUfAYRLnI4hTr95vhZWhOTLezZ+eGu1
         fKrgXA/3A/3ifItFFNG++A0ogxVDQmhOfFxtIS77tnhoJeAymaJyLmdJ730PIqrN0wDc
         I4uUX/DcqujUJj3iN3CpWUXs8lfsJrusH28Ec3flZCwzXltcgSKJLmutkIDEJNUwNZtG
         zOxw==
X-Gm-Message-State: AOJu0Yx3o31Y2UzHpDE/4jWTo587lyT0l9qn6JyKTZcdaProLYOuJGyM
	0N3uu5+SbUD6uQHO5x2w0IRov7Z7hpw226p+YBtO3m+6ZheLXpw3QHNkhOhXQPJ8cIIdkJ8OGH4
	9sjnCQvbOUZhqTTKZlmwCXsqTfdlxXJB7/oGmgAU=
X-Gm-Gg: AeBDievZ7mNARTiawHGyt0tTuhRlkhnKEb+g3euBp5seMUWK0myzZvmgQWm6obKpeeg
	lsGfBSvVj/qGYOQvvXE0a4umf1KLbqk9IOjpXSQPnDO13wtvZu6tL+a1zjzsHEl+vFLdfhvu7Y5
	RrMJpMq6NsMcApMddbNMVMW3sDdtfYiTy0QTICK+h8rsMWS6CEKO6PGW3co4sNixfVDazS8El9U
	ZN2pFRZ4lKBM+wAIgnZdcT7slmiRl57OAG4xymYjv/e6PhkJcVyqSYYKlvKIMlO0lokE2auFW1c
	FIDdHo9TZQ==
X-Received: by 2002:a05:690c:2609:b0:798:5a44:7821 with SMTP id
 00721157ae682-7a4d5f538f3mr160715937b3.38.1775578725234; Tue, 07 Apr 2026
 09:18:45 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CANDawC1cfcr1k1BED8wW+Vt93PzKJaYnNmrtk31hFDz1HntVbw@mail.gmail.com>
In-Reply-To: 
 <CANDawC1cfcr1k1BED8wW+Vt93PzKJaYnNmrtk31hFDz1HntVbw@mail.gmail.com>
From: =?UTF-8?Q?Carlos_David_Garc=C3=ADa_Mart=C3=ADnez?= <backich99@gmail.com>
Date: Tue, 7 Apr 2026 10:18:31 -0600
X-Gm-Features: AQROBzCS4ifb0hDyutaYQNZzOXrWhrPxW2XBHJn6FN32C_15gSo-p6D-OxhkLxg
Message-ID: 
 <CANDawC3cyym9W1FpzD3abZwTiDBhcGm2b1cGFAa_np5MRuvk7g@mail.gmail.com>
Subject: Re: No audio output and missing internal mic on ThinkPad E14 Gen 7
 Intel (Conexant SN6140, subsystem 17aa:5130)
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: backich99@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FZHLUIAKBRRBG3EBMS6XP72OC2NWQWQD
X-Message-ID-Hash: FZHLUIAKBRRBG3EBMS6XP72OC2NWQWQD
X-Mailman-Approved-At: Thu, 09 Apr 2026 09:57:04 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FZHLUIAKBRRBG3EBMS6XP72OC2NWQWQD/>
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

Codec: Conexant SN6140
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x14f11f87
Subsystem Id: 0x17aa5130
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
   rates [0x540]: 48000 96000 192000
   bits [0xa]: 16 24
   formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
 Power states:  D0 D1 D2 D3 D3cold S3D3cold CLKSTOP EPSS
 Power: setting=3DD0, actual=3DD0
GPIO: io=3D5, o=3D0, i=3D0, unsolicited=3D1, wake=3D1
 IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
 IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
 IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
 IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
 IO[4]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
 Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
   ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
 Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
   ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
 Device: name=3D"SN6140 Analog", type=3D"Audio", device=3D0
 Amp-Out caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
 Amp-Out vals:  [0x80 0x80]
 Converter: stream=3D0, channel=3D0
 PCM:
   rates [0x540]: 48000 96000 192000
   bits [0xa]: 16 24
   formats [0x1]: PCM
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
 Control: name=3D"Speaker Playback Volume", index=3D0, device=3D0
   ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
 Control: name=3D"Speaker Playback Switch", index=3D0, device=3D0
   ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
 Amp-Out caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
 Amp-Out vals:  [0x4a 0x4a]
 Converter: stream=3D0, channel=3D0
 PCM:
   rates [0x540]: 48000 96000 192000
   bits [0xa]: 16 24
   formats [0x1]: PCM
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
Node 0x12 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
 Control: name=3D"Beep Playback Volume", index=3D0, device=3D0
   ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
 Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
   ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
 Amp-Out caps: ofs=3D0x07, nsteps=3D0x07, stepsize=3D0x0f, mute=3D0
 Amp-Out vals:  [0x03]
Node 0x13 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
 Control: name=3D"Capture Volume", index=3D0, device=3D0
   ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
 Control: name=3D"Capture Switch", index=3D0, device=3D0
   ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
 Device: name=3D"SN6140 Analog", type=3D"Audio", device=3D0
 Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D1
 Amp-In vals:  [0x80 0x80] [0x50 0x50] [0x80 0x80] [0x80 0x80]
 Converter: stream=3D0, channel=3D0
 SDI-Select: 0
 PCM:
   rates [0x540]: 48000 96000 192000
   bits [0xa]: 16 24
   formats [0x1]: PCM
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
 Connection: 4
    0x18 0x19* 0x1a 0x15
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
 Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D1
 Amp-In vals:  [0x4a 0x4a] [0x4a 0x4a]
 Converter: stream=3D0, channel=3D0
 SDI-Select: 0
 PCM:
   rates [0x540]: 48000 96000 192000
   bits [0xa]: 16 24
   formats [0x1]: PCM
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
 Connection: 2
    0x1a* 0x15
Node 0x15 [Vendor Defined Widget] wcaps 0xf0050b: Stereo Amp-In
 Amp-In caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
 Amp-In vals:  [0x4a 0x4a] [0x4a 0x4a]
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
 Connection: 2
    0x10* 0x11
Node 0x16 [Pin Complex] wcaps 0x400581: Stereo
 Pincap 0x0001001c: OUT HP EAPD Detect
 EAPD 0x2: EAPD
 Pin Default 0x03211040: [Jack] HP Out at Ext Left
   Conn =3D 1/8, Color =3D Black
   DefAssociation =3D 0x4, Sequence =3D 0x0
 Pin-ctls: 0xc0: OUT HP
 Unsolicited: tag=3D02, enabled=3D1
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
 Connection: 2
    0x10* 0x11
Node 0x17 [Pin Complex] wcaps 0x400501: Stereo
 Pincap 0x00010010: OUT EAPD
 EAPD 0x2: EAPD
 Pin Default 0x91170110: [Fixed] Speaker at Int Rear
   Conn =3D Analog, Color =3D Unknown
   DefAssociation =3D 0x1, Sequence =3D 0x0
   Misc =3D NO_PRESENCE
 Pin-ctls: 0x40: OUT
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
 Connection: 2
    0x10 0x11*
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
 Amp-In vals:  [0x00 0x00]
 Pincap 0x00001324: IN Detect
   Vref caps: HIZ 50 80
 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
   Conn =3D Unknown, Color =3D Unknown
   DefAssociation =3D 0xf, Sequence =3D 0x0
   Misc =3D NO_PRESENCE
 Pin-ctls: 0x00: VREF_HIZ
 Unsolicited: tag=3D00, enabled=3D0
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
 Control: name=3D"Mic Boost Volume", index=3D0, device=3D0
   ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
 Amp-In vals:  [0x03 0x03]
 Pincap 0x00001324: IN Detect
   Vref caps: HIZ 50 80
 Pin Default 0x03a11030: [Jack] Mic at Ext Left
   Conn =3D 1/8, Color =3D Black
   DefAssociation =3D 0x3, Sequence =3D 0x0
 Pin-ctls: 0x20: IN VREF_HIZ
 Unsolicited: tag=3D01, enabled=3D1
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
Node 0x1a [Pin Complex] wcaps 0x40048b: Stereo Amp-In
 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
 Amp-In vals:  [0x00 0x00]
 Pincap 0x00000024: IN Detect
 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
   Conn =3D Unknown, Color =3D Unknown
   DefAssociation =3D 0xf, Sequence =3D 0x0
   Misc =3D NO_PRESENCE
 Pin-ctls: 0x00:
 Unsolicited: tag=3D00, enabled=3D0
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Vendor Defined Widget] wcaps 0xf0058b: Stereo Amp-In
 Amp-In caps: N/A
 Amp-In vals:
 Unsolicited: tag=3D00, enabled=3D0
 Power states:
 Power: setting=3DD0, actual=3DD0
 Connection: 0
Node 0x1e [Vendor Defined Widget] wcaps 0xf0058b: Stereo Amp-In
 Amp-In caps: N/A
 Amp-In vals:
 Unsolicited: tag=3D00, enabled=3D0
 Power states:
 Power: setting=3DD0, actual=3DD0
 Connection: 0
Node 0x1f [Vendor Defined Widget] wcaps 0xf0058b: Stereo Amp-In
 Amp-In caps: N/A
 Amp-In vals:
 Unsolicited: tag=3D00, enabled=3D0
 Power states:
 Power: setting=3DD0, actual=3DD0
 Connection: 0
Node 0x20 [Audio Output] wcaps 0x611: Stereo Digital
 Converter: stream=3D0, channel=3D0
 Digital:
 Digital category: 0x0
 IEC Coding Type: 0x0
 PCM:
   rates [0x540]: 48000 96000 192000
   bits [0xe]: 16 20 24
   formats [0x5]: PCM AC3
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
Node 0x21 [Pin Complex] wcaps 0x400701: Stereo Digital
 Pincap 0x00000010: OUT
 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
   Conn =3D Unknown, Color =3D Unknown
   DefAssociation =3D 0xf, Sequence =3D 0x0
   Misc =3D NO_PRESENCE
 Pin-ctls: 0x00:
 Power states:  D0 D1 D2 D3 EPSS
 Power: setting=3DD0, actual=3DD0
 Connection: 1
    0x20

## References

- Same issue reported by other E14 Gen 7 users (no fix found):
  https://forums.linuxmint.com/viewtopic.php?t=3D451664
- LKML patch renaming SN6140 (Jun 2025):
  https://lkml.org/lkml/2025/6/16/331

El mar, 7 abr 2026 a las 10:14, Carlos David Garc=C3=ADa Mart=C3=ADnez
(<backich99@gmail.com>) escribi=C3=B3:
>
> **Hardware:** Lenovo ThinkPad E14 Gen 7 (Intel Core i5, Raptor Lake-P)
> **OS:** TUXEDO OS 24.04.4 LTS
> **Kernel:** 6.17.0-111019-tuxedo
> **Codec:** Conexant SN6140 (Vendor ID: 0x14f11f87, Subsystem ID: 0x17aa51=
30)
>
> ## Problems
>
> 1. Headphone jack (3.5mm) produces no sound
> 2. Internal microphone not detected
>
> ## Root cause identified
>
> The driver reads PCI subsystem ID as `17aa:0000` instead of the correct
> `17aa:5130`, so no ThinkPad-specific fixup is applied:
>
>     snd_hda_codec_conexant: SN6140: picked fixup for PCI SSID 17aa:0000
>
> A board-specific fixup entry for subsystem `0x17aa5130` is needed in
> sound/pci/hda/patch_conexant.c to initialize the GPIO/EAPD amplifier
> and define pin configs for the internal mic (Node 0x18, currently N/A).
>
> ## Things already tried (without success)
>
> - options snd_hda_intel model=3Dauto
> - options snd_hda_codec_conexant model=3Dthinkpad
> - hda-jack-retask.fw firmware patch with pin overrides
> - Manual sysfs writes to user_pin_configs + reconfig
> - snd_hda_intel.dmic_detect=3D0 kernel parameter
> - hda-verb EAPD commands on node 0x16
>
> ## Full codec dump
>
> (pega aqu=C3=AD el contenido de: cat /proc/asound/card0/codec#0)
>
> ## References
>
> - Same issue reported by other E14 Gen 7 users (no fix found):
>   https://forums.linuxmint.com/viewtopic.php?t=3D451664
> - LKML patch renaming SN6140 (Jun 2025):
>   https://lkml.org/lkml/2025/6/16/331
>
> --
> -----
> Carlos Garc=C3=ADa



--=20
-----
Carlos Garc=C3=ADa
