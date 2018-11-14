From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: ak4118: Add support for AK4118 S/PDIF transceiver
Date: Wed, 14 Nov 2018 11:55:17 +0100
Message-ID: <CAJiuCcewYbt4SDZfFzDfTfTzj_Z1cm=S3_GAA-zcYGW-jzXR4w@mail.gmail.com>
References: <20181108124934.32381-1-peron.clem@gmail.com> <20181113225135.GQ2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113225135.GQ2089@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Adrien Charruel <adrien.charruel@devialet.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, 13 Nov 2018 at 23:51, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 08, 2018 at 01:49:33PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
>
> This looks mostly good, a few small things below but nothing too major:
>
> > --- /dev/null
> > +++ b/sound/soc/codecs/ak4118.c
> > @@ -0,0 +1,449 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ak4118.c  --  Asahi Kasei ALSA Soc Audio driver
> > + *
>
> Please make the entire comment a C++ one so this looks more intentional.

I check from other files and also this article says :
"For normal C source files, the string will be a comment using the
"//" syntax; header files, instead, use traditional (/* */) comments
for reasons related to tooling"
https://lwn.net/Articles/739183/

>
> > +static const char * const ak4118_iec958_fs_texts[] =3D {
> > +     "44100",
> > +     "Reserved",
>
> If you use a _VALUE_ENUM_SINGLE you can hide the reserved/invalid values
> from userspace which is easier to use.

Ok will change to SOC_VALUE_ENUM_SINGLE_DECL

>
> > +     ret =3D request_threaded_irq(gpiod_to_irq(ak4118->irq), NULL,
> > +                                ak4118_irq_handler, IRQF_TRIGGER_RISIN=
G |
> > +                                IRQF_ONESHOT, "ak4118-irq", ak4118);
> > +     if (ret < 0) {
> > +             dev_err(component->dev, "Fail to request_irq: %d\n", ret)=
;
> > +             return ret;
> > +     }
>
> You should request resources in the device level probe, there's no point
> in requesting and releasing the interrupt like this.

Ok, will change to devm_request_threaded_irq and remove the irq_free

Thanks for the review,
Regards,
Cl=C3=A9ment
