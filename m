Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82288CD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:41:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05BC9601CA;
	Sun,  7 Jun 2026 19:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05BC9601CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854073;
	bh=9ZxybhdaMUc7C3+RoIO5/uqy0kU/qq7dGeBSMzkdb1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mjwwATXvX8FJa4xynSUoyfZlSYWQCvJJi9xm0T3v+4b8yK8Z/QRLIGXi0LVlixkTD
	 fD1Mul8LczC8IxfxHeEvNpEh5M/GR/+l9RHJZ1FA5LQvSyORoOGv8/GZjSZK+g9g/2
	 L3uXLnGzzgOcCxtMhDe7IRfawUnJLmcJNrFFLOyI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DE3F3F805C5; Sun,  7 Jun 2026 19:40:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3329F805FF;
	Sun,  7 Jun 2026 19:40:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FA41F8055B; Sun,  7 Jun 2026 19:40:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1780854027;
	b=UD+KjQZWOAKSxIWX4VUZJHSrAHrZJh66rXNk2ka9kh2NamgPaUguCSrBnmE6jWbg+xJP
	 LdkTF+R60x7/+Eo+FmSPagnrBdiHBbYFR2rUWXR7ysWqo+i7UDqVSUQFyMaiCpmLEwl8W
	 cU8+ldIJ7adD8tMUZePzldAq4VGviXUcqlEcqkNr06kDc9TptP1tHXkl7jw7yE8Q4XCPn
	 8BxcozMGgXXBoIREKQYlW3lSG5+14r06ZxG+BHgpanne7ammaDCf0sxIKDWQVQSVtDux0
	 FOfSwLlyZTs1kEtewAQ2sPs/ZUYXoqKVNhbNOj5nHBp9QOF7Zy9nvWRSFH2zmRoZOMg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780854027;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=9ZxybhdaMUc7C3+RoIO5/uqy0kU/qq7dGeBSMzkdb1k=;
	b=sBDnSKbFUa/g4xV4XIEiLxqGOs+spMQ37wyppjvZjp42b4EQaz7KX/eoPpSD+hIW7rUp
	 596u5MIF1pIKJISrIdWzeHDSt8wG5ZdSssQWf/jS+yrlHK+gldqn7Ep/Ng0YRveATqD+j
	 KhH0WDLrieVa8IqXLYmHDR5LCGi3YzjQ3FEu3EIXuAwoqeIy+sz9uaTHaSsghym4nTBfa
	 sR+rA8iZchH6g6X+jVDwlTfKFJKXAdjLtHNDqmHtTKJvhaEoeIIOOcqWOA7lWi6rRGAFC
	 iLfaFT1TMubhSVC/Ob+4CSSdqAe9x8oIcnGTMXAi/2ODVrmonC9evQro4Qaw0AqtjWw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Tw52Qb8a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CEB18F8051D
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 19:40:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEB18F8051D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Tw52Qb8a
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45efb698ef2so1564778f8f.3
        for <alsa-devel@alsa-project.org>;
 Sun, 07 Jun 2026 10:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780854026; cv=none;
        d=google.com; s=arc-20240605;
        b=ebgwHKVZmVQCoJUBRgP1FGE6XpialadX288cWOBfY7oYI23+FGvu0gQvPuyZgfOAI0
         ZA1nyITLwf8KIPSxsk6xM/IbyNs2LLXDsaLzl7pBoU6qi3qYnu7imaEq4Gzq3Bfb7ib7
         d/zNndOl8Gsw4CLGEGibAkTI/LzNSdnp771r8mChxt+0h20E3YK/Wwjgbtl/AOcef2Bo
         5scCwiBRUYsKXXQC7KgcSv9cGXSu6hH1LpZhFy6EMj/XK0yX/jbquz2hDKr0OX07H1OZ
         P24Q4BhpQ5Ye2T7LenyqDEOB4TpTDF5Bmvvxw5JHTTecI23ho+1Ix63/sXB+b0SLjWNz
         Ln/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qxEIxSaEp55NKnCtPVN7+jHUzK7Ifdc3IwVTbChqlI=;
        fh=yHYy4E/BKEGzAClHZeUZTk1n6hWjZSLzeX8WfXuC3mw=;
        b=HbpWqQjVRGP/3jActiD5NWmTHAJEOpZ+e81+Oxd8iqqeiSbW4CSgZTpvoV48k/Vu3w
         F0uhL0/YadGSA9/TnfhioTiHKD+5xiTF2Mw+K2bkHtaqgSHsT6mUH5J6DcHFgbPgfrGU
         j2qrpEDKWS7PSlqi8R5m2cFu6312CpHghJWW/jGuB8ylWKQgyORxj5rsRHNSNsx7+pNh
         VPFDrPDCtA1WC/ONyH9udxh4ZAPsEEWkCf9M9WVZg5h1Cg78OeDHxVtxuQUYoTqBvzdE
         auziMCQ9AtCREnPXfgCr+dkMm4Hv/FDI0XBFfVKDP15Wb7BvTPcc/L3ZgMGwUdn6NCP2
         4+sw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780854026; x=1781458826;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qxEIxSaEp55NKnCtPVN7+jHUzK7Ifdc3IwVTbChqlI=;
        b=Tw52Qb8azdjlH6iuBmf4VGgY8S4ia9bulu3rXiIAe47Ev8ZclDM4LV2jMIuvKarzpC
         j9BCpO4Hk9jGq2VG7xPOTxvIFePt4QNrRRh/FhwEmPmrd/xvoUSnoNF78nA4ITXxmb9X
         6Ea13uV5vpco/wq6Jug0PipwUC3E3CRfWyHglw2XZhv0M5QQsBFogpEv5xxuohOfFVVo
         x1AOBznhtz6WsQa2zv/mxguSSUq2jCNSMc3I46WDQHZMZnEmg56KZj3+Bd5bRRB3JmVU
         VR7Bp5J79sse35nYDw7X9V6UbWsSZvSP3P8CQCwBICqKoTWbY2m7FMkqpcsvZAoCOzpJ
         ktkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780854026; x=1781458826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qxEIxSaEp55NKnCtPVN7+jHUzK7Ifdc3IwVTbChqlI=;
        b=KUOVMJLtAU4KalTpRX5WYOG7EGGV6Zs0RXj1tlQ+za8EiWftDE2f/IxCVPYFgP8/bZ
         tZXVwtbSNVDG82m5PqJKRbB08ceXkQuS1lwbEoRo4kAeW6GFr886U9YJwfPwbm+5M+Gf
         UoGJ9Lo7ZFjiy9AvdWmenSCHCp9JTfzsOaZHVzh6LPJwkx0hfoFUH6TVI/Sk5x+wqUIN
         EPFPojIvaQamoRLqOv+cEN9xI3AeKfFU4RTOnL90aX/7PMFfjsMPDLTo12rt9Cpij1fx
         Fg/JNkKgdIFEIX6YEwJZLbiHdaEgWSasH+HBYkJr6gJcRyiE0znX18Afs0cR7ibTHJvm
         5qYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ96+NhlKTX/XQtEvB7DCNXCOnpyJD3Ekr1SAbjPJ+/jsNImXhx3DWBcaW0KeHLMpbBcrlu+sjpDCNXf@alsa-project.org
X-Gm-Message-State: AOJu0YyyDbIFsmHWR8zXLOpR0rviZP4r4xb8SMx1byh9ZKz4jKW6GQHK
	EcPiBf9s0GlwlFo0uFyLL5N7FGDDwXTb/OEq6lGrYlP08N0XdqX3gvQ9GibySf08G67hQJUbbo/
	2nylNjooMY21lltrgFPP6gYsneB1o6mw=
X-Gm-Gg: Acq92OEKhsJ/4EhCf9j4b5We5w6R5asPOE52Y+R5U2bnIyFoI77Sw44XO2LKnEbkfbN
	OPI34WA6i+eOXjZ1QUmZKOD8TF0pcNNMFGL8yQIFnvu83F8pdnlXlJI+HLTYSC8iGyz+Bq9LON9
	HbKeyt3Xz4i2EF4mEU3ndj5aA5+x0U52hznma6X6741jNIOThSIt18xuGhBLzII/bZ/K8G17s64
	uQDeGqTZzSty+Klxx8HhinFn6lBSsADoUN2uEj6PIXuWTOyfruCJetktQP2P5P864W+6Jd26bf8
	O+nHODjbjQOXYokrTa4Pw5OcUGuhDIlw5NfhUbUuPxcnkg72DLTBciVqRTQ=
X-Received: by 2002:a5d:5f44:0:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-460302fd190mr19687348f8f.15.1780854025526; Sun, 07 Jun 2026
 10:40:25 -0700 (PDT)
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
In-Reply-To: 
 <CACYx1SqBnPiGkoRYQoBTPiR1nhVS3ha2i+ADGKfMSpSfaiC04A@mail.gmail.com>
From: =?UTF-8?B?5ZGoT2NlYW4=?= <zhouoceanhy@gmail.com>
Date: Mon, 8 Jun 2026 01:40:13 +0800
X-Gm-Features: AVVi8Ce_v2Y8H3KfA79gg8IKKK7fVHEpKe6FU5HA4TyG_7hPIxsRTqANr0HwGG0
Message-ID: 
 <CACYx1Sq87CJfYa6w-dFuDZigzDA73OEX9am2FhKS2P6OOxw97g@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: VX6446UNOKU66WLBBRP2JO7UJ56PNQPT
X-Message-ID-Hash: VX6446UNOKU66WLBBRP2JO7UJ56PNQPT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VX6446UNOKU66WLBBRP2JO7UJ56PNQPT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,

A quick follow-up to my previous email! I have a correction to make.

First, I must apologize for a bit of confusion regarding the "loud
electrical hum" I mentioned. I realized that during my earlier
troubleshooting, I had accidentally cranked the Internal Mic Boost to
a massive +48dB in alsamixer to see if I could force any signal to
appear. After lowering the boost to a normal level, the stock driver's
behavior is exactly as I originally described: mostly silent but only
captures faint acoustic tapping on the chassis, with no actual voice.

More importantly, following your guidance, I managed to find the
perfect and elegant fix for this issue!

Instead of using my previous brute-force hack (locking the ADC to
0x1e), I wrote a proper HDA pin override quirk for this machine (PCI
Subsystem ID: 0x2014:8004). The quirk simply sets the pin default for
the phantom Rear Mic (Node 0x1b) to 0x40000000 ([N/A] None).

Once Node 0x1b is disabled, ALSA's auto-parser magically handles the rest:

Without a headset plugged in, the system automatically defaults the
capture to 0x1e (Internal Mic), completely eliminating the noise and
allowing normal voice capture.

When I plug a headset into the front panel, the system dynamically
switches the input to 0x1a (Front Headset Mic), and it works
perfectly!

As for the rear speaker not auto-muting, I discovered that Auto-Mute
Mode was simply set to Disabled in my ALSA mixer. After enabling it,
the rear speaker correctly auto-mutes when the headset is plugged in.

Just as you pointed out in your earlier email, hard-wiring the
connection wasn't the right approach. It seems that correcting the pin
default to hide the phantom node (0x1b) allows the parser to wire the
expected routes naturally. Could you let me know if using
HDA_FIXUP_PINS for this is the correct implementation route? If this
approach aligns with the proper topology handling, I would be very
happy to prepare and submit a v2 patch.

Best regards,
Ocean

=E5=91=A8Ocean <zhouoceanhy@gmail.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=B8=80 00:48=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Takashi,
>
> Thank you for pointing that out.
>
> The physical reality of my machine is that it does not have a
> dedicated "Rear Mic Jack" at all. The rear panel only has one single
> audio jack, which I am currently using to plug in my external speaker
> (standard TRS, so no built-in mic).
>
> You are exactly right about the route. Because the system falsely
> reports a "Rear Mic" as plugged in and routes ADC 0x14 to pin 0x1b
> (which is physically missing/floating on my motherboard), it generates
> the static noise.
>
> In the patch I submitted earlier, I made a brute-force modification to
> force the ADC to connect to the internal host microphone (Pin 0x1e,
> conn index 3): snd_hda_codec_write(codec, 0x14, 0,
> AC_VERB_SET_CONNECT_SEL, 0x03); This successfully bypassed the
> floating 0x1b pin, immediately silenced the noise, and got my built-in
> host mic working.
>
> However, this hardcoded patch completely breaks the front panel audio rou=
ting:
>
> When I plug a headset into the front panel, the OS does detect the
> plug event (I get a volume change notification), but the rear speaker
> does not auto-mute. Both the front headset and the rear speaker play
> sound simultaneously.
>
> Because my patch locks the ADC to the internal mic, the front panel
> microphone cannot be dynamically switched to and does not work at all.
>
> I also noticed another clue regarding the behavior of this noise:
>
> Without my patch (stock driver): The noise is a very loud, constant
> buzzing/humming sound. It completely fails to capture any voice, and
> even tapping the Mini-PC chassis leaves absolutely no signal in the
> recording.
>
> In a previous older state (before forcing this widget connection): The
> noise behaved differently=E2=80=94it was mostly silent, but it would capt=
ure
> the acoustic vibration of tapping the Mini-PC chassis, though it still
> wouldn't record actual voice.
>
> This shift to a pure, loud electrical hum further confirms that
> without the patch, the input is routed to a completely
> floating/unterminated pin (0x1b), which picks up heavy environmental
> EMI.
>
> To show you the physical layout, I have uploaded a photo of my
> computer's rear panel here: https://sm.ms/kyPL
>
> Given this messy pin configuration from the manufacturer, what would
> be the proper way to handle this via pin configs or a quirk so that
> the internal mic works by default, while retaining dynamic switching
> and auto-muting for the front panel? Please let me know if you need
> any further diagnostics or logs.
>
> Best regards,
> Ocean
>
> Takashi Iwai <tiwai@suse.de> =E4=BA=8E2026=E5=B9=B46=E6=9C=887=E6=97=A5=
=E5=91=A8=E6=97=A5 20:16=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, 06 Jun 2026 16:19:26 +0200,
> > =E5=91=A8Ocean wrote:
> > >
> > > Hi Takashi,
> > >
> > > To be honest, I'm not an expert on the low-level hardware design of
> > > this codec, but I can confirm that the internal microphone only works
> > > normally when we apply this patch.
> > >
> > > I realized why the previous two dumps were identical: the user-space
> > > audio server (PipeWire) automatically restored the routing and
> > > switched NID 0x14 to NID 0x1e (index 3) at runtime, masking the actua=
l
> > > boot defaults.
> > >
> > > This time, I stopped PipeWire entirely, reloaded the stock driver, an=
d
> > > captured the true hardware defaults. Please find the new logs
> > > attached:
> > >
> > > 1. alsa-info-raw-defaults.txt.gz (Stock driver, pure hardware default=
s):
> > > Here, NID 0x14 actually defaults to NID 0x1b (index 1, Rear Mic) on b=
oot:
> > >    Connection: 4
> > >       0x1a 0x1b* 0x1d 0x1e
> > >
> > > 2. alsa-info-with-patch.txt.gz (Patched driver):
> > > Here, the quirk forces it to NID 0x1e (index 3, Internal Mic) at init=
ialization:
> > >    Connection: 4
> > >       0x1a 0x1b 0x1d 0x1e*
> > >
> > > Without the patch, testing the microphone in the stock driver yields =
a
> > > loud buzzing/humming noise (typical of a floating/unconnected input
> > > pin on NID 0x1b) with only a very faint sound when tapping the chassi=
s
> > > (due to signal crosstalk/leakage from NID 0x1e to NID 0x1b). Even if
> > > PipeWire switches the connection to 0x1e at runtime later, it fails t=
o
> > > record normal sound.
> > >
> > > Applying the quirk at ACT_INIT ensures NID 0x14 is correctly mapped t=
o
> > > the physical internal mic pin (0x1e) from boot, resolving the floatin=
g
> > > pin noise and restoring mic capture to a normal level.
> >
> > Looking at your alsa-info.sh outputs, it shows that the rear mic jack
> > is plugged:
> >
> >         control.17 {
> >                 iface CARD
> >                 name 'Rear Mic Jack'
> >                 value true
> >                 comment {
> >                         access read
> >                         type BOOLEAN
> >                         count 1
> >                 }
> >         }
> >
> > so the driver makes ADC 0x14 connected to 0x1b, which is the pin
> > for the rear mic.
> >
> > If you get a noise from it, it means that something wrong with that
> > route.
> >
> >
> > Takashi
