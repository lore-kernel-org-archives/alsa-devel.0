From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: Re: [PATCH 3/6] ALSA: hda/ca0132: Restore behavior of
	QUIRK_ALIENWARE
Date: Sat, 16 Jun 2018 20:56:54 -0400
Message-ID: <CAEcYz2QAhySdJiasZXNf4ZSrNO0n+dkbHYuut+Hu2vyKQt42dw@mail.gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
 <20180616015620.26663-4-alastair.bridgewater@gmail.com>
 <CAM8Agx1Rbf3QbzbcLncRD6UuJky-os69DyhnBHwsUMMdnYXb+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DEF22676B9
 for <alsa-devel@alsa-project.org>; Sun, 17 Jun 2018 02:56:56 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id u4-v6so13897383iof.2
 for <alsa-devel@alsa-project.org>; Sat, 16 Jun 2018 17:56:56 -0700 (PDT)
In-Reply-To: <CAM8Agx1Rbf3QbzbcLncRD6UuJky-os69DyhnBHwsUMMdnYXb+A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

That makes a certain amount of sense, but there are a few things that
would invalidate that reasoning.  First, the contrived scenario:
Running Linux on the Chromebook with the sound card routed to a Qemu
VM running Some Other Operating System.  Second, there's no quirk
matching for the Chromebook, which means that every unknown card (and
these unknown cards would presumably have the opportunity to be
dual-boot windows devices) would be denied the benefit of having the
extra volume bits cleared.  Third, if Linux starts to use those extra
bits, and someone is dual-booting between kernel versions, we get the
same effect.

At this point, unless there is reason to expect that clearing these
volume parameters could be harmful, I think that doing so globally is
the right thing.  I can prep a patch for that in a day or so.

On Sat, Jun 16, 2018 at 11:37 AM, Connor McAdams <conmanx360@gmail.com>
wrote:

> Going through the code again today, I realized why I did this. I don't
> believe the Chromebook will ever go into Windows, so I don't think I
> have to set the 0x797 and 0x798 audio volume verbs to 0x00 on it. I
> did this so that the Alienware laptops, which probably have booted
> into Windows, would have those values set to 0 if they hadn't been
> already.
>
> On Fri, Jun 15, 2018 at 9:56 PM, Alastair Bridgewater
> <alastair.bridgewater@gmail.com> wrote:
> > Commit e93ac30a32a6ba7ac3b4b2a4379af1dadb91e505 (ALSA: HDA/ca0132:
> > add extra init functions for r3di + sbz) introduced an extra
> > initialization function that was improperly guarded, taking effect
> > on systems with QUIRK_ALIENWARE, even though such systems were
> > supposedly not affected.
> >
> > It may be that this piece of initialization should be done for all
> > systems, but that's not a call that I can make.
> >
> > Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
> >
> > diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> > index bdd626bde267..ca7375e48138 100644
> > --- a/sound/pci/hda/patch_ca0132.c
> > +++ b/sound/pci/hda/patch_ca0132.c
> > @@ -7223,7 +7223,7 @@ static int ca0132_init(struct hda_codec *codec)
> >
> >         snd_hda_sequence_write(codec, spec->base_init_verbs);
> >
> > -       if (spec->quirk != QUIRK_NONE)
> > +       if (spec->use_alt_functions)
> >                 ca0132_alt_init(codec);
> >
> >         ca0132_download_dsp(codec);
> > --
> > 2.16.1
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
