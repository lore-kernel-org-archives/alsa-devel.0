From: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Date: Wed, 17 Oct 2018 22:26:22 +0200
Message-ID: <CA+7wUsycUxKoCEk1CW+RKfJ5e9AxOumyfKoF93JYw3qmU5r=nQ@mail.gmail.com>
References: <20180606193811.16007-1-malat@debian.org> <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
 <20180831203752.37rsceiwotcmeses@pburton-laptop> <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
 <CA+7wUswC1SfC3G0RRH7OV4C6nQsp59R62FN_NiDSyCpxRDf__Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+7wUswC1SfC3G0RRH7OV4C6nQsp59R62FN_NiDSyCpxRDf__Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-MIPS <linux-mips@linux-mips.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul,

On Mon, Sep 3, 2018 at 8:15 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> On Fri, Aug 31, 2018 at 10:59 PM Paul Burton <paul.burton@mips.com> wrote:
> >
> > On Fri, Aug 31, 2018 at 01:37:52PM -0700, Paul Burton wrote:
> > > Further to that, this series doesn't seem to work for me. With
> > > v4.19-rc1, with the patch from [1] & then this series applied I see the
> > > following when booting a ci20_defconfig kernel:
> > >
> > >   [    0.846684] ALSA device list:
> > >   [    0.849642]   No soundcards found.
> >
> > D'oh! Apparently I haven't drunk enough coffee today - missing link can
> > be found below:
> >
> > [1] https://www.spinics.net/lists/linux-gpio/msg31965.html
>
> Awesome, thanks for testing. I'll return to this series once I receive
> replacement for my laptop hard drive.

I see it now :

[    0.289701] bus: 'platform': really_probe: probing driver
jz4740-i2s with device 10020000.i2s
[    0.289713] jz4740-i2s 10020000.i2s: no pinctrl handle
[    0.289782] OF: /i2s@10020000: could not find phandle

I'll try to make sense of this.

> thanks,
> -M
