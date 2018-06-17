From: Connor McAdams <conmanx360@gmail.com>
Subject: Re: [PATCH 3/6] ALSA: hda/ca0132: Restore behavior of
	QUIRK_ALIENWARE
Date: Sat, 16 Jun 2018 21:57:34 -0400
Message-ID: <CAM8Agx0oeNwQ4iP2nxkthOSTScFJAS_OPRVNEGHuToS4Km=A9Q@mail.gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
 <20180616015620.26663-4-alastair.bridgewater@gmail.com>
 <CAM8Agx1Rbf3QbzbcLncRD6UuJky-os69DyhnBHwsUMMdnYXb+A@mail.gmail.com>
 <CAEcYz2QAhySdJiasZXNf4ZSrNO0n+dkbHYuut+Hu2vyKQt42dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DF04E266F93
 for <alsa-devel@alsa-project.org>; Sun, 17 Jun 2018 03:57:36 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id t133-v6so11994825oif.10
 for <alsa-devel@alsa-project.org>; Sat, 16 Jun 2018 18:57:36 -0700 (PDT)
In-Reply-To: <CAEcYz2QAhySdJiasZXNf4ZSrNO0n+dkbHYuut+Hu2vyKQt42dw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Well, here's how I've been treating this. The ca0132 driver was made
for the Chromebook's ca0132 chip. So in my mind, QUIRK_NONE is the
Chromebook, and any added support for other cards is something that
has been tacked on top of it's base. I don't know of any Core3D based
cards that work just fine by going through the default setup without
some sort of QUIRK related fixes. I don't envision ALSA getting
floating point decibel volume, but I guess if that were to happen,
maybe this could become an issue.

In my mind, there is probably a reason Creative didn't make any
reference to that verb on the driver that they, the people with the
actual documentation, wrote. I try not to make any changes to things
that I have no real reason to make a change to. It worked fine before
without it, so I see no reason to begin doing that. But, if you
believe that it's a necessary thing to do, then I guess you can. I
just don't like touching things that I don't need to.

On Sat, Jun 16, 2018 at 8:56 PM, Alastair Bridgewater
<alastair.bridgewater@gmail.com> wrote:
> That makes a certain amount of sense, but there are a few things that
> would invalidate that reasoning.  First, the contrived scenario:
> Running Linux on the Chromebook with the sound card routed to a Qemu
> VM running Some Other Operating System.  Second, there's no quirk
> matching for the Chromebook, which means that every unknown card (and
> these unknown cards would presumably have the opportunity to be
> dual-boot windows devices) would be denied the benefit of having the
> extra volume bits cleared.  Third, if Linux starts to use those extra
> bits, and someone is dual-booting between kernel versions, we get the
> same effect.
>
> At this point, unless there is reason to expect that clearing these
> volume parameters could be harmful, I think that doing so globally is
> the right thing.  I can prep a patch for that in a day or so.
>
> On Sat, Jun 16, 2018 at 11:37 AM, Connor McAdams <conmanx360@gmail.com>
> wrote:
>>
>> Going through the code again today, I realized why I did this. I don't
>> believe the Chromebook will ever go into Windows, so I don't think I
>> have to set the 0x797 and 0x798 audio volume verbs to 0x00 on it. I
>> did this so that the Alienware laptops, which probably have booted
>> into Windows, would have those values set to 0 if they hadn't been
>> already.
>>
>> On Fri, Jun 15, 2018 at 9:56 PM, Alastair Bridgewater
>> <alastair.bridgewater@gmail.com> wrote:
>> > Commit e93ac30a32a6ba7ac3b4b2a4379af1dadb91e505 (ALSA: HDA/ca0132:
>> > add extra init functions for r3di + sbz) introduced an extra
>> > initialization function that was improperly guarded, taking effect
>> > on systems with QUIRK_ALIENWARE, even though such systems were
>> > supposedly not affected.
>> >
>> > It may be that this piece of initialization should be done for all
>> > systems, but that's not a call that I can make.
>> >
>> > Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
>> >
>> > diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
>> > index bdd626bde267..ca7375e48138 100644
>> > --- a/sound/pci/hda/patch_ca0132.c
>> > +++ b/sound/pci/hda/patch_ca0132.c
>> > @@ -7223,7 +7223,7 @@ static int ca0132_init(struct hda_codec *codec)
>> >
>> >         snd_hda_sequence_write(codec, spec->base_init_verbs);
>> >
>> > -       if (spec->quirk != QUIRK_NONE)
>> > +       if (spec->use_alt_functions)
>> >                 ca0132_alt_init(codec);
>> >
>> >         ca0132_download_dsp(codec);
>> > --
>> > 2.16.1
>> >
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
