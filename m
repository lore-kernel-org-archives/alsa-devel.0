From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v4 0/7] Allwinner H6 SPDIF support
Date: Mon, 15 Jul 2019 21:21:01 +0200
Message-ID: <CAJiuCcc3_1jZWV7G3+fFQYRZ8b6qcAbnH+K6pkRvww6_D=OMAw@mail.gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com> <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm missing ACK from ASoC Maintainers patch 2-3-4.

It's really small paches, if you could have a look at it.
Many thanks,
Cl=C3=A9ment



On Fri, 14 Jun 2019 at 10:29, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi,
>
> On Mon, 27 May 2019 at 22:10, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
> >
> > *H6 DMA support IS REQUIRED*
>
> DMA has been merged, so this series can be merge when ASoC maintainers
> have reviewed it.
>
> Regards,
> Cl=C3=A9ment
>
> >
> > Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) whi=
ch
> > is different from the previous H3 generation and not compatible.
> >
> > Difference are an increase of fifo sizes, some memory mapping are diffe=
rent
> > and there is now the possibility to output the master clock on a pin.
> >
> > Actually all these features are unused and only a bit for flushing the =
TX
> > fifo is required.
> >
> > Also this series requires the DMA working on H6, a first version has be=
en
> > submitted by Jernej =C5=A0krabec[1] but has not been accepted yet.
> >
> > [1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=
=3D89011
> >
> > Changes since v3:
> >  - rename reg_fctl_ftx to val_fctl_ftx
> >  - rebase this series on sound-next
> >  - fix dt-bindings due to change in sound-next
> >  - change node name sound_spdif to sound-spdif
> >
> > Changes since v2:
> >  - Split quirks and H6 support patch
> >  - Add specific section for quirks comment
> >
> > Changes since v1:
> >  - Remove H3 compatible
> >  - Add TX fifo bit flush quirks
> >  - Add H6 bindings in SPDIF driver
> >
> > Cl=C3=A9ment P=C3=A9ron (7):
> >   dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
> >   ASoC: sun4i-spdif: Move quirks to the top
> >   ASoC: sun4i-spdif: Add TX fifo bit flush quirks
> >   ASoC: sun4i-spdif: Add support for H6 SoC
> >   arm64: dts: allwinner: Add SPDIF node for Allwinner H6
> >   arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
> >   arm64: defconfig: Enable Sun4i SPDIF module
> >
> >  .../sound/allwinner,sun4i-a10-spdif.yaml      |  1 +
> >  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 38 ++++++++++++++
> >  arch/arm64/configs/defconfig                  |  1 +
> >  sound/soc/sunxi/sun4i-spdif.c                 | 49 ++++++++++++++++---
> >  5 files changed, 87 insertions(+), 6 deletions(-)
> >
> > --
> > 2.20.1
> >
