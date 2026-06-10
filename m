Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBDBCD98C6
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:20:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF8BC601F2;
	Wed, 10 Jun 2026 17:19:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF8BC601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781104799;
	bh=4/otZ6dNnGdMpvw4e6tj/w0wqqCKBMrQDjdOf/ot02w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PNPZCIlKcXorsTXxuVp1ZrnbyokV6ZLtHk+47l4o//lo/Lq6IC5GeZ7DgcYhIDAJM
	 JJTEJB+cHYJZWfDePqQjeglay7zK1hS7D9tyCr0BaOMqLVAPhmZdNvqcD53moJISss
	 ek9orymSQ6MNWDLerwSqolVNro9CnXaYiZpSggxE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15624F805F8; Wed, 10 Jun 2026 17:19:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B0456F805FA;
	Wed, 10 Jun 2026 17:19:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37A50F8058C; Wed, 10 Jun 2026 17:19:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781104757;
	b=nIBXvMAjbUwHPb694CvbaL9KsJ+wHWY6dkvuhOvh7zZs6NYg1+0A65RFMQmCDiJNHPWG
	 fG1OQhtIJnHILExHeuC1Xy+F301azv1sBQgttg1YO5ayNUeeHaJVe6kqOv2IpaJxvuj3x
	 qLsHW6AbvmOJ7BeFsDsiJM3cqxQQRgLd1dnWu/OYYq47D6A44BugXIG72/88sS/c6jPcl
	 bgwh4N06ka5pf2ZWS6AFLOSzTSS/MJrNJsaNoqAUceDeg16mQT7Dy3GZCx8y7Giv/pn+q
	 xS0sqsLzPZc+oaFQ8efsoOdYxHSA9n+Ce57vH+0gRY1ndXU+wp4CIv0EvHWUKzO8mtg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781104757;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=4/otZ6dNnGdMpvw4e6tj/w0wqqCKBMrQDjdOf/ot02w=;
	b=awXLGpV9FLglr5kOnoZV4ORqjGhw/f5VtzoXB5j9o4QMOfW7S1VbCa/iDLFnLc4yKD/6
	 +AEqSezaR2aF2kzjNOQvYUwiQIWplIdmQZUwAODhffa9P9ePwoeiIq7cc8Nk6ueMVtND/
	 8v0h3U+wyUpK9sgjF+PyhVVibUsDsMPt6ff2aV4wWv2XmlWZ84N5o1PcY2adpsDFwqws+
	 eCzvlQP1NOaZJj8QIkZ+v4oIeK+wgGjrQrnNtxtRuU/Q2lr2IruJQLf6mQUgaIe5ohk1W
	 MTS2UdyOTO4sm7ORqRXdXyi/Geg5UwiWoeVWQIm9+gfCbqYbpwB0FMbMM+D3hAkuwBA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mHyQwErq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 20A99F8011B
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 17:19:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20A99F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mHyQwErq
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490abf12f0fso36769795e9.0
        for <alsa-devel@alsa-project.org>;
 Wed, 10 Jun 2026 08:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781104755; cv=none;
        d=google.com; s=arc-20240605;
        b=JjZglL9k++kzRzPmh9qAI75tK65Hhv/2xXJmWiB56EUju2C7u3NZ5DnSH5Ufs75+e0
         bNP97Ox9b+QHsYz1WILQQbwZye/vxdPHs10bPBBgNq9BC+mE/K8s1V+Ndkm6X6JgaY6c
         s4bMXPtgu7jgNK73wYR4dc2+E8JY8YmyhPWuu779AoNIvuTpf+HJlTKxiSu1S88hEpkh
         4gkVjQuqJaVZuvIsPnGHngk6kuTIoMOPV5wSUR8HtsY2N3UmG3ApOtffW/ON59irOAGl
         KdQBSsupY1jwzvhPUZ6U4BnLwE/6+zeqQCy3zJfxXKPo8Ku+fTJSkrao4tAg4LAWEZxR
         ZfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zW/xHeUBEePb0yWec4IHTlITjRcFS1QNuHHsmYIp8Vg=;
        fh=KGWOUTsyWGECbg2AEsMY5rYXGoSJorM6UWj/Awq/GG0=;
        b=OvZ+GBAJDKOgATDMABIsLzsh5qCwF/gZPmQ3cnT1/TwlrgiUmRJGXyzoghPq7Joyf+
         sosZQ3t0H6/Yde+8TPlDIrsCXi/js0emmT9nLrifD0pTDtTWHztc16nHADIZi4kh07Sm
         wGRpLsLft/IzzpUkNvZ4aHCU8t08cBqTnGuf8CDzfKjntjrpz3hpi4q2I0A5jZ6DPoXc
         oECQ4LtgF0WofkYlabdGDZqy9OSFDBF2r8mI/su8Yi6ACWtgVRIl6+Lgh3ym5+ZGatlM
         xSDbooAxhkMQR1xWjtUIU+qEzxRpAb0FFbuBnc5Hoqgd4RJYfTi51wY4bhVO/vsYq07A
         ZYHQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781104755; x=1781709555;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW/xHeUBEePb0yWec4IHTlITjRcFS1QNuHHsmYIp8Vg=;
        b=mHyQwErqG7Ovr+lFsc3qS/H0Uac3fPwhcJm4VwOC9HxYk7ec56NkFqZagd3jP9XKaC
         BhEq062Gb933JsLtnG89Fpsvz3qMeVAO+QLykPleZ5w7rmgufeH6XOdXwRQjzzqrwbwQ
         1CgbEGwTU42XmP1fI1PazO8oDIFKVlrWZGAP15JC7fFHITOgXUpUoSMyQcn9jXYz463P
         6t640AW+tS5MT3HmpzrAJjHlxYv4bqBhh2IBsZJ+RGGU/6t1ym44RwZttRm0uGPDh49p
         tsij2R+La5ZFDbRMjSXaSTy0Q/28qnlx6LGxh6+4leijo2HgCn9FVX160/JqwAjBMDWF
         Uqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104755; x=1781709555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zW/xHeUBEePb0yWec4IHTlITjRcFS1QNuHHsmYIp8Vg=;
        b=i1ZUx0mMtIY/osxKjoC67ItCi03qAmlkW8JWvcjCXaBpNCM98V3k6N4isdRfQOIJxL
         Am5Yibsc7UbihGmpKK/kBkcFs6NgqDP2mjCw7FWyuQZXMKeXh8qZR45Fh/+pEmB4VH3U
         qoIFZVkjqckOPDxVAJJbjB9YzhZO5onYOuk8pFpjxigqKw08cFoh5dh3D0WU+G5Ct2Z7
         57CKS4V6dmr6AjU3ON75AviDGyRcxueqPmsjgniowhbD8A7JI+dmIKuNcTdndoZJxi0z
         DCWWWgJr/t06uf/vxT80uzh1SwcOqS3colFEB4OXzQDMq84JjO5MgUmsY52Rm+zJtxo9
         s6Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qJjvgXlnVizjpB4RocwcSct65Z4nOBu3FzOXB1CluK+QOYuCzZPL9zZJu6LZ4ITiySzBGwlEQmGRA@alsa-project.org
X-Gm-Message-State: AOJu0YyXWHhTK0doXqTt6aVBIxNK0Esq1MOk8LmXArjmM7uzg5wVMshp
	0Hd7RxGC6d7B/2oUBZaGN3+++JOzYEtz+ebesPKRPRfmRxhZd1/6dybL2ZyLN6sjKXXCrKNrElO
	Z+d2vsD14k+JXqRUyVhh0tVZhHckdmlQ=
X-Gm-Gg: Acq92OG1k1qF9dxuo5cw9V7kaWRk5nnxqPtmofc33B5rA+2o8yWKFzdqPpwaNkYrNrP
	Wh/DxYKfhmmD6qXq3AqAIcK9s339j+P8cA0UHlzg0IsiOFYP6XSRgtql5m1YbuoTmDtlfo/Dvzl
	Ih9zZF5Ephb0MmOucE5t48kxUD4n/f75sR40sT+4Kfp85DmQLdqs+DEUpWSuiIfQxnuliiQKfW6
	pgIbURVFJ49Em9zy7ZBkTaaUMBsx5j1CfAF3B880pNZN3o8dwyB8lsifgs2HLad08czU4yQA+Uq
	Gzc8Asi9TLmzhXjk10b08E+dF5je9OHeC6ntaQUJLo9vLPOERVyOmXMq5teZl3z0kIF/djyAqA=
	=
X-Received: by 2002:a05:600c:3b04:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-490c2cdd2bemr340744975e9.7.1781104754691; Wed, 10 Jun 2026
 08:19:14 -0700 (PDT)
MIME-Version: 1.0
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
 <87y0h2r3g6.wl-tiwai@suse.de>
 <CACYx1SrnTfg6GKK2S1Vb13f9OWOq1x=VUDA=AFWs1CALsC_B2g@mail.gmail.com>
 <8733z7pv5e.wl-tiwai@suse.de>
 <CACYx1SobX420vGovUv-1WROW-Kh-sPvaFBj0vNfgQnVnDyOeZg@mail.gmail.com>
 <87fr32wwpv.wl-tiwai@suse.de>
 <CACYx1SqT5sL7MpsjnB16dPwhjyvhzjL3M0E6-ka0Rn-cSgqiqA@mail.gmail.com>
 <875x3usg00.wl-tiwai@suse.de>
 <CACYx1SqBnPiGkoRYQoBTPiR1nhVS3ha2i+ADGKfMSpSfaiC04A@mail.gmail.com>
 <CACYx1Sq87CJfYa6w-dFuDZigzDA73OEX9am2FhKS2P6OOxw97g@mail.gmail.com>
 <87se6xqyn1.wl-tiwai@suse.de>
In-Reply-To: <87se6xqyn1.wl-tiwai@suse.de>
From: =?UTF-8?B?5ZGoT2NlYW4=?= <zhouoceanhy@gmail.com>
Date: Wed, 10 Jun 2026 23:19:01 +0800
X-Gm-Features: AVVi8Cfdaq8WWLuYPoBxPYeDOUURL8EDSLCV65XTtes8OeUyEDn1g3q01vrwsCw
Message-ID: 
 <CACYx1Soy=oqaZfX9A2NuvOdoghxPPyviFekk5giMMCJ5N+2NUQ@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: QIYXUDAVZ6S77FZG75EFS2VNUNJTNZNL
X-Message-ID-Hash: QIYXUDAVZ6S77FZG75EFS2VNUNJTNZNL
X-MailFrom: zhouoceanhy@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QIYXUDAVZ6S77FZG75EFS2VNUNJTNZNL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,

Thank you for the suggestions. I have tested the stock driver as requested.

Here are the results:

1. Does the jack detection work for the rear jack? Yes, the jack
detection works properly for the rear jack.

2. Does the output from the rear work as-is? Yes, the output works
normally. I primarily use this jack for an external TRS speaker.

3. Changing the pin control of 0x1c: I plugged a TRRS headset (with a
microphone) into the rear jack. Both the audio output and the headset
microphone worked properly without any modifications. When I ran sudo
hda-verb /dev/snd/hwC1D0 0x1c SET_PIN_WIDGET_CONTROL 0x00, the
headphone output stopped as expected, and the microphone continued to
work normally.

Based on these tests, the rear jack is a fully functional TRRS combo
jack, and there is no hardware interference between the output (0x1c)
and input (0x1b) pins.

The loud buzzing noise I reported earlier occurs only when a 3-pole
TRS plug (like my external speaker or a standard headphone without a
mic) is connected to the rear jack. It appears the hardware lacks
proper impedance sensing to distinguish between TRS and TRRS plugs,
and blindly leaves the mic input pin (0x1b) active. Since the TRS plug
shorts the mic ring to ground, the active 0x1b pin captures ground
loop noise.

This behavior is consistent with what I observe on Windows on the same
machine: when a TRS speaker is plugged in, Windows shows a microphone
device that captures no sound, likely because the pin is shorted to
ground.

Given that this machine is a Mini-PC and the rear jack is mostly used
for TRS external speakers, would applying a pin quirk to disable 0x1b
(setting it to 0x40000000) be the most appropriate upstream fix?

Best regards,

Ocean

Takashi Iwai <tiwai@suse.de> =E4=BA=8E2026=E5=B9=B46=E6=9C=888=E6=97=A5=E5=
=91=A8=E4=B8=80 15:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 07 Jun 2026 19:40:13 +0200,
> =E5=91=A8Ocean wrote:
> >
> > Hi Takashi,
> >
> > A quick follow-up to my previous email! I have a correction to make.
> >
> > First, I must apologize for a bit of confusion regarding the "loud
> > electrical hum" I mentioned. I realized that during my earlier
> > troubleshooting, I had accidentally cranked the Internal Mic Boost to
> > a massive +48dB in alsamixer to see if I could force any signal to
> > appear. After lowering the boost to a normal level, the stock driver's
> > behavior is exactly as I originally described: mostly silent but only
> > captures faint acoustic tapping on the chassis, with no actual voice.
> >
> > More importantly, following your guidance, I managed to find the
> > perfect and elegant fix for this issue!
> >
> > Instead of using my previous brute-force hack (locking the ADC to
> > 0x1e), I wrote a proper HDA pin override quirk for this machine (PCI
> > Subsystem ID: 0x2014:8004). The quirk simply sets the pin default for
> > the phantom Rear Mic (Node 0x1b) to 0x40000000 ([N/A] None).
> >
> > Once Node 0x1b is disabled, ALSA's auto-parser magically handles the re=
st:
> >
> > Without a headset plugged in, the system automatically defaults the
> > capture to 0x1e (Internal Mic), completely eliminating the noise and
> > allowing normal voice capture.
> >
> > When I plug a headset into the front panel, the system dynamically
> > switches the input to 0x1a (Front Headset Mic), and it works
> > perfectly!
> >
> > As for the rear speaker not auto-muting, I discovered that Auto-Mute
> > Mode was simply set to Disabled in my ALSA mixer. After enabling it,
> > the rear speaker correctly auto-mutes when the headset is plugged in.
> >
> > Just as you pointed out in your earlier email, hard-wiring the
> > connection wasn't the right approach. It seems that correcting the pin
> > default to hide the phantom node (0x1b) allows the parser to wire the
> > expected routes naturally. Could you let me know if using
> > HDA_FIXUP_PINS for this is the correct implementation route? If this
> > approach aligns with the proper topology handling, I would be very
> > happy to prepare and submit a v2 patch.
>
> Yes, disabling the pin config with that fixup makes sense.
>
> There are a few more things you can test, though:
>
> - Does the jack detection work for the rear jack?
>   There are two pins assigned, NID 0x1b and 0x1c for input and output.
>
> - Does the output from the rear work as-is?
>
> - If the output works, try to change the pin control of the output of
>   the rear jack (NID 0x1c), e.g. via hda-verb.  As default it's 0x40,
>   and set to 0x00.  Does it change anything on the input from that
>   jack?
>
>
> Takashi
