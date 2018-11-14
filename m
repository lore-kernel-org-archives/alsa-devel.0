From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: ak4118: Add support for AK4118
 S/PDIF transceiver
Date: Wed, 14 Nov 2018 16:07:21 +0100
Message-ID: <alpine.DEB.2.20.1811141602590.20252@lnxricardw1.se.axis.com>
References: <20181114121642.1404-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114121642.1404-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Adrien Charruel <adrien.charruel@devialet.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On Wed, 14 Nov 2018, Clément Péron wrote:

> From: Adrien Charruel <adrien.charruel@devialet.com>
> 
> The AK4118A is a digital audio transceiver supporting 8 input channels
> at 192kHz and with 24bits resolution.
> It converts the S/PDIF signal to I2S format and is configurable over I2C.
> 
> This driver introduce a minimal support of the AK4118, like selecting the
> input channel, reading input frequency and detecting some errors.

I'm curious, from what it seems, there is no checking that the input 
sample rate actually matches the configured sample rate? It's perfectly 
understandable for a driver which has 'minimal support', but it's 
something a user must be aware of; for instance if someone does

arecord -r 48000 output.wav

when the input data actually has a rate of 44100 Hz then the file will be 
written with a header specifying 44100 Hz but the data will actually be 
48000 Hz.

It's not an objection on my part, just an observation. I don't know how 
ALSA could enforce this in any way; ideally (barring automatic sample rate 
conversion) one would want an error message that the sample rate specified 
when opening the stream does not match the sample rate of the S/PDIF input 
data.

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
