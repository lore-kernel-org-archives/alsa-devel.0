From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: ak4118: Add support for AK4118 S/PDIF transceiver
Date: Thu, 15 Nov 2018 17:31:44 +0100
Message-ID: <CAJiuCccTwxA4Am=H5vMw9PBJQi_+ErSPEsT5C7PRpv_b6y9EPA@mail.gmail.com>
References: <20181108124934.32381-1-peron.clem@gmail.com> <20181113225135.GQ2089@sirena.org.uk>
 <CAJiuCcewYbt4SDZfFzDfTfTzj_Z1cm=S3_GAA-zcYGW-jzXR4w@mail.gmail.com> <20181114173129.GY2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114173129.GY2089@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Adrien Charruel <adrien.charruel@devialet.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, 14 Nov 2018 at 18:31, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 14, 2018 at 11:55:17AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Tue, 13 Nov 2018 at 23:51, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Nov 08, 2018 at 01:49:33PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
>
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * ak4118.c  --  Asahi Kasei ALSA Soc Audio driver
> > > > + *
>
> > > Please make the entire comment a C++ one so this looks more intention=
al.
>
> > I check from other files and also this article says :
> > "For normal C source files, the string will be a comment using the
> > "//" syntax; header files, instead, use traditional (/* */) comments
> > for reasons related to tooling"
> > https://lwn.net/Articles/739183/
>
> Right, and what I said was that you should make the entire comment a C++
> one which means that the magic line will be C++ as required.

Yes, sorry I was confused between C++ and C99,
Regards,
Clement
