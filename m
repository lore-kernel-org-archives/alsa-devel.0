From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: ak4118: Add support for AK4118
 S/PDIF transceiver
Date: Thu, 15 Nov 2018 17:47:28 +0100
Message-ID: <alpine.DEB.2.20.1811151742510.20252@lnxricardw1.se.axis.com>
References: <20181114121642.1404-1-peron.clem@gmail.com> <alpine.DEB.2.20.1811141602590.20252@lnxricardw1.se.axis.com> <CAJiuCcd_LAhODGGu=EBj4WBvx2PufcVbw=tO1+Mm+1Hj0k6BRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJiuCcd_LAhODGGu=EBj4WBvx2PufcVbw=tO1+Mm+1Hj0k6BRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Adrien Charruel <adrien.charruel@devialet.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On Wed, 14 Nov 2018, Clément Péron wrote:

> > > The AK4118A is a digital audio transceiver supporting 8 input channels
> > > at 192kHz and with 24bits resolution.
> > > It converts the S/PDIF signal to I2S format and is configurable over I2C.
> > >
> > > This driver introduce a minimal support of the AK4118, like selecting the
> > > input channel, reading input frequency and detecting some errors.
> >
> > I'm curious, from what it seems, there is no checking that the input
> > sample rate actually matches the configured sample rate? It's perfectly
> > understandable for a driver which has 'minimal support', but it's
> > something a user must be aware of; for instance if someone does
> >
> > arecord -r 48000 output.wav
> >
> > when the input data actually has a rate of 44100 Hz then the file will be
> > written with a header specifying 44100 Hz but the data will actually be
> > 48000 Hz.
> >
> > It's not an objection on my part, just an observation. I don't know how
> > ALSA could enforce this in any way; ideally (barring automatic sample rate
> > conversion) one would want an error message that the sample rate specified
> > when opening the stream does not match the sample rate of the S/PDIF input
> > data.
> 
> I'm quite new with linux audio driver but adding in ak4118_hw_params a
> check like if params_rate(params) == ak4118_rate should do the job no

It will if the SPDIF stream is already running when the driver is started 
up, but if for some reason the sample rate changes or the SPDIF source is 
not transmitting anything when the stream is started it won't work to do 
it hw_params. A changing sample rate might be an unusual usecase, but one
could imagine having an SPDIF source which is silent (e.g. not even 
plugged in) when the stream is set up.

Like I said, it might not be a problem in many applications. And I'm not 
really sure how to solve it. Perhaps someone else knows. ALSA likes to be 
in control of parameters such as the sample rate, but it can't with an 
external device controlling the sample rate of the SPDIF receiver.

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
