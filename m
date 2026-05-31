Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889FECD6E4C
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:12:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F207A60234;
	Mon,  1 Jun 2026 10:12:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F207A60234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780301532;
	bh=WuDGWsQv7VpwAK/lhr9JBoytqRRZ6LIx0oQNrNdL4Lw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MP7Jc1bKwVvylfVFlbfQtpzNRJ5sXsSEbSc8z6w8oiT9FMUk2L8oUjjwXKpCKB0A4
	 TgHjsaFalEw59M1Y0xuPzyW2RyrGOPT3TWdtMOImJBbYdhejRz+lQ8zfy2aOgwPv6X
	 lT96rjUSxu6DNd7UYbTrtoUKR2TxgGFf8S4RB7X8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 028FCF80637; Mon,  1 Jun 2026 10:11:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D959F80631;
	Mon,  1 Jun 2026 10:11:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 597B9F805B0; Sun, 31 May 2026 06:02:16 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9EE5AF8057E
	for <alsa-devel@alsa-project.org>; Sun, 31 May 2026 06:02:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EE5AF8057E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BYr4J39q
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-51749faf06eso2881271cf.0
        for <alsa-devel@alsa-project.org>;
 Sat, 30 May 2026 21:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780200131; cv=none;
        d=google.com; s=arc-20240605;
        b=keRLkCRUZKEfLvkeM0BnLaFQQz7S0P8HuZ9e+76oihYRPmvzjh9VxT+2HL+xl/Tk7N
         XUFRJAE9+2eLQKHc/OdEFetuR4Bh/O8qEFh3h5WliFBsvPI8jmeIOPmUfroIghUjUTE9
         jlNtY5vVaEiK2anaNI9r4/4bwMhQOxAIYz5MmWhDbFpDsDhFqGJuOL6GcAnL2HYHLor0
         Bnm8J7i0Tpxnl4lHXH7/zSTECIiRWHpamPdbUoaFsm7sNI4p9s3dVZg2wJacJX42oSNB
         msO5KVqLOnHBQADQ+LvV4Gyhe64R7nzYsnMnaetQ/q4vgFWRs+XY6s5A3jyTTX+KsyPe
         ttKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/jNuVuhVHz0DEKEmK2BaNxKD76y23sfAaTBaibJFXE=;
        fh=VLUV8cgy8RAsv0xJuYHeIgWjNMhcOnqzF2ZJvS1xDJo=;
        b=lqipghRVlxKlozgdNJYZh1NnaayQMOWLQU/EB6jk9/Z6E0OV9IybEZxDDp5ihlYHb5
         ZY6RVQCxoboQBVyZoxsSe8EvfjMqkk+RbO/4jp0JnuDqhrkpddGfCZU+VwymGyEpkFRb
         XGIFYdmAQ3s8t21ES/YCYVCo3AAXEo7G1wYIpIKeOTUZsEkEBD+VyjjRqgzJp/QQOg3Z
         uPFaSKbLNG/ZB7Cudwd++uWkwYXI/dYbiX4Mue4qmuEbu8xmyZa3wHCc/Cn0KK8nJO4l
         s77zF4411nnWQwjRqF9q7PSDLUwquzr5/RQ4csNTV8F2qAonkmY1awRk3fqsecqasNog
         yl6w==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780200131; x=1780804931;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/jNuVuhVHz0DEKEmK2BaNxKD76y23sfAaTBaibJFXE=;
        b=BYr4J39q1Tmzd/tjWTQvSkuvFDL2xAUK/hK275Yxig8vFruELiaZtAe0uqxjMCHNC8
         EYi7Q+SmWV5+PWMvQ2+OHjmsM41yVmb/6nB0sMmB/JuDiK+Be0z3CiKbfWY7OYwy8GzI
         Wd02rkyMxXf6YwhxMf0adnxX8pjPrmS8IwyNvk/xp+D8PwO7Kf24TZiX209fA9fy/tWS
         A5ZIB/0FOQ1dKUILCIa0ZmcR50O3bjti0pWEPVdyC6VHpi3qPoSd28coSuCzfTAxZhCp
         CeD9L3RSP7IJoRFocb5xkSiwj1pIzE1A5Tdack8as8eyMdyjRBV39ZNiOT0hrqQEK4Fc
         RJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780200131; x=1780804931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/jNuVuhVHz0DEKEmK2BaNxKD76y23sfAaTBaibJFXE=;
        b=NFVyKL9Pbeg7rSNsv5lgZej2Q86rQvZxJ076MnzbVHEMf8UVcxB+jv2sXEQV3rmpY+
         DfhG0FQSe8EVXnlZj5HPbrHTlZT01Dc0+8ItFP48MpLoTZdFTHGs/RMoDmG6pQkswr1K
         F1zWNXSVPRUrlY3JZvqHaHkIEuTw1PTsSUD4nqMH7xqfcl/UJXlWolD6pnXc3ZfhbBBM
         yyLsagyrPVHekvf1WVyqy77M96azMcjR/sYhduLemcqM2JCiXmojLN2xU3zMijuyfvV9
         NpMWsZxEhtut2kuiXHrauYA427YrCVmdG40cxnDPuokmK4iv3aqbQqRUGeAknC+47XqX
         exuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Y8O3OkGPeXj6FyVLLZ0PYGRE6/d+F/WKWD1dN31yJKls7jeJ1YtY8Kr/GjxewjeWEMeRuUxHLcZ6l@alsa-project.org
X-Gm-Message-State: AOJu0YyA1h7vTKtBxn3SCU+1FPTgs84gxXflh5UjuzzhUGsTrOTAtVHk
	Bjz+aKnJMxmU1b/PXUN1T9cLYGcoVE69WG7VC1QzGMuF+X429w/v4tfM/SBa5ZaE5iYFg9GmGaa
	Bqs1p+tBsNKEB6G1tflaPSLaqtfN6GC4=
X-Gm-Gg: Acq92OGxMAMFedN1dZjXevNJoLwTHUDz7n/XLJgpTkhPHYjuzHgaVz/yx56V2+dJfLC
	VaIuRnb7Q4jeVYbS5xWvwxHawBa/VfnqiSszsLftlBntathrV4ELR4tOYn//FpRhlLGiDlGRlnC
	loOZ01CMbyp8259vQ24hkisIe8JWDpAcw7+9HIa6JCO8wvyT1Lzfgkwt49OuDbAjjLl43dlmNMp
	p/3zE+jjvIs/aMPnqZO6CtfaRktUe5TzuL2ijaYqfQUhL0kQPSQojU6/AtZEQkU/j+nICBS2z5E
	5yGVc+GWK+EtdxyKWhvfBBC3G7f19ap07kXkdY4Hhk5H8LWFXvLoRjr7mhkN
X-Received: by 2002:a05:622a:d0e:b0:516:e517:6dd3 with SMTP id
 d75a77b69052e-5173a851999mr68605821cf.40.1780200131052; Sat, 30 May 2026
 21:02:11 -0700 (PDT)
MIME-Version: 1.0
References: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
 <87y0h2r3g6.wl-tiwai@suse.de>
In-Reply-To: <87y0h2r3g6.wl-tiwai@suse.de>
From: =?UTF-8?B?5ZGoT2NlYW4=?= <zhouoceanhy@gmail.com>
Date: Sun, 31 May 2026 12:02:00 +0800
X-Gm-Features: AVHnY4JSbhAkyEl1tHXTRjbzgNMd72hf_MbG_ga4LXN_EI-idoKzOBWaE6feLl0
Message-ID: 
 <CACYx1Spieb3O=nKPnU45zB-z9wgHZFmFOpwYiPLGrLWGj7QEbg@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic
 mux
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: zhouoceanhy@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: JS2PFAIPOQ4GGOKQR672X6OGZIPP2K2T
X-Message-ID-Hash: JS2PFAIPOQ4GGOKQR672X6OGZIPP2K2T
X-Mailman-Approved-At: Mon, 01 Jun 2026 08:11:06 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JS2PFAIPOQ4GGOKQR672X6OGZIPP2K2T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,

Thanks for your quick reply and professional guidance!

Here is the original topology of Conexant CX20632 (SSID 2014:8004) on
FEVM FA880 PRO:

- Node 0x14 [Audio Input] (Analog Capture)
  Connection: 4
     0x1a 0x1b 0x1d 0x1e*   (Note: 0x1e is selected by default)

- Node 0x1e [Pin Complex] (Internal Mic)
  Pin Default 0x95a60120: [Fixed] Mic at Int Top
  Connection: None (It's a digital/fixed mic pin)

- Node 0x1a [Pin Complex] (Front Mic): Pin Default 0x02a1103e
- Node 0x1b [Pin Complex] (Rear Mic): Pin Default 0x01a13030

Regarding the kernel crash, I encountered a kernel Oops in
try_assign_dacs() during the auto-config stage on the newer
7.0.10-cachyos kernel. I suspect it might be triggered when loading my
out-of-tree custom DKMS module, or due to changes in how
try_assign_dacs() interacts with this specific topology on the new
kernel. (Fortunately, the system works perfectly fine on the 6.18-lts
kernel with my custom module).

In the older kernel (like 6.18), the auto-parser didn't crash but
would incorrectly route Node 0x14 away from Node 0x1e after probing,
disabling the internal microphone. That was why my previous patch
forced index 0x03 on Node 0x14 in HDA_FIXUP_ACT_INIT.

Since you mentioned correcting the routes before parsing, should we
override the connection list of Node 0x14 to restrict it during
HDA_FIXUP_ACT_PRE_PROBE, or override the pin default configuration via
HDA_FIXUP_PINS to fix this properly?

I would really appreciate your advice on how we should construct the
fixup gracefully!

Thanks again,

Ocean


Takashi Iwai <tiwai@suse.de> =E4=BA=8E2026=E5=B9=B45=E6=9C=8829=E6=97=A5=E5=
=91=A8=E4=BA=94 17:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 29 May 2026 06:11:47 +0200,
> ocean wrote:
> >
> > From: Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
> >
> > FEVM FA880 PRO mini PC uses Conexant CX20632 codec. The internal
> > microphone is connected to pin 0x1e. In order to make it work,
> > we need to force ADC 0x14 connection to 0x1e (connection index 3).
> >
> > This patch adds a new quirk CXT_FIXUP_CX20632_INTMIC to force
> > the connection selection on initialization, and applies it
> > for the SSID 2014:8004.
> >
> > Signed-off-by: Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com=
>
>
> If a hard-wire is needed, usually we correct the routes before
> parsing (e.g. correcting the connection list), so that the parser
> would wire via the expected route.
>
> How does the original topology look like and how it should be changed?
>
>
> thanks,
>
> Takashi
>
> > ---
> >  sound/pci/hda/patch_conexant.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conex=
ant.c
> > index 2d4094be83ab..5e2279267104 100644
> > --- a/sound/pci/hda/patch_conexant.c
> > +++ b/sound/pci/hda/patch_conexant.c
> > @@ -300,6 +300,7 @@ enum {
> >       CXT_PINCFG_SWS_JS201D,
> >       CXT_PINCFG_TOP_SPEAKER,
> >       CXT_FIXUP_HP_A_U,
> > +     CXT_FIXUP_CX20632_INTMIC,
> >  };
> >
> >  /* for hda_fixup_thinkpad_acpi() */
> > @@ -343,6 +344,15 @@ static void cxt5066_increase_mic_boost(struct hda_=
codec *codec,
> >                                 (0 << AC_AMPCAP_MUTE_SHIFT));
> >  }
> >
> > +static void cxt_fixup_cx20632_intmic(struct hda_codec *codec,
> > +                                  const struct hda_fixup *fix, int act=
ion)
> > +{
> > +     if (action !=3D HDA_FIXUP_ACT_INIT)
> > +             return;
> > +
> > +     /* Force ADC 0x14 to internal mic pin 0x1e (conn index 3). */
> > +     snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_CONNECT_SEL, 0x03=
);
> > +}
> > +
> >  static void cxt_update_headset_mode(struct hda_codec *codec)
> >  {
> >       /* The verbs used in this function were tested on a Conexant CX20=
751/2 codec. */
> > @@ -1035,6 +1045,10 @@ static const struct hda_fixup cxt_fixups[] =3D {
> >               .type =3D HDA_FIXUP_FUNC,
> >               .v.func =3D cxt_fixup_hp_a_u,
> >       },
> > +     [CXT_FIXUP_CX20632_INTMIC] =3D {
> > +             .type =3D HDA_FIXUP_FUNC,
> > +             .v.func =3D cxt_fixup_cx20632_intmic,
> > +     },
> >  };
> >
> >  static const struct hda_quirk cxt5045_fixups[] =3D {
> > @@ -1140,6 +1154,7 @@ static const struct hda_quirk cxt5066_fixups[] =
=3D {
> >       SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A=
1004),
> >       SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A=
1205),
> >       SND_PCI_QUIRK(0x1d05, 0x3012, "MECHREVO Wujie 15X Pro", CXT_FIXUP=
_HEADSET_MIC),
> > +     SND_PCI_QUIRK(0x2014, 0x8004, "FEVM FA880 PRO", CXT_FIXUP_CX20632=
_INTMIC),
> >       HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPE=
AKER),
> >       HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPE=
AKER),
> >       {}
> > @@ -1165,6 +1180,7 @@ static const struct hda_model_fixup cxt5066_fixup=
_models[] =3D {
> >       { .id =3D CXT_PINCFG_TOP_SPEAKER, .name =3D "sirius-top-speaker" =
},
> >       { .id =3D CXT_FIXUP_HP_A_U, .name =3D "HP-U-support" },
> > +     { .id =3D CXT_FIXUP_CX20632_INTMIC, .name =3D "cx20632-intmic" },
> >       {}
> >  };
> >
