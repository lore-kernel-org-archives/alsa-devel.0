From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: ak4118: Add support for AK4118
 S/PDIF transceiver
Date: Wed, 14 Nov 2018 16:24:44 +0100
Message-ID: <CAJiuCcd_LAhODGGu=EBj4WBvx2PufcVbw=tO1+Mm+1Hj0k6BRw@mail.gmail.com>
References: <20181114121642.1404-1-peron.clem@gmail.com> <alpine.DEB.2.20.1811141602590.20252@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1811141602590.20252@lnxricardw1.se.axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ricard.wanderlof@axis.com
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Adrien Charruel <adrien.charruel@devialet.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Ricard,

On Wed, 14 Nov 2018 at 16:07, Ricard Wanderlof
<ricard.wanderlof@axis.com> wrote:
>
>
> On Wed, 14 Nov 2018, Cl=C3=A9ment P=C3=A9ron wrote:
>
> > From: Adrien Charruel <adrien.charruel@devialet.com>
> >
> > The AK4118A is a digital audio transceiver supporting 8 input channels
> > at 192kHz and with 24bits resolution.
> > It converts the S/PDIF signal to I2S format and is configurable over I2=
C.
> >
> > This driver introduce a minimal support of the AK4118, like selecting t=
he
> > input channel, reading input frequency and detecting some errors.
>
> I'm curious, from what it seems, there is no checking that the input
> sample rate actually matches the configured sample rate? It's perfectly
> understandable for a driver which has 'minimal support', but it's
> something a user must be aware of; for instance if someone does
>
> arecord -r 48000 output.wav
>
> when the input data actually has a rate of 44100 Hz then the file will be
> written with a header specifying 44100 Hz but the data will actually be
> 48000 Hz.
>
> It's not an objection on my part, just an observation. I don't know how
> ALSA could enforce this in any way; ideally (barring automatic sample rat=
e
> conversion) one would want an error message that the sample rate specifie=
d
> when opening the stream does not match the sample rate of the S/PDIF inpu=
t
> data.

I'm quite new with linux audio driver but adding in ak4118_hw_params a
check like if params_rate(params) =3D=3D ak4118_rate should do the job no
?

Regards,
Clement

>
> /Ricard
> --
> Ricard Wolf Wanderlof                           ricardw(at)axis.com
> Axis Communications AB, Lund, Sweden            www.axis.com
> Phone +46 46 272 2016                           Fax +46 46 13 61 30
