From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: fix powerup/down of micbias-voltage
Date: Fri, 12 Jan 2018 22:10:05 -0200
Message-ID: <CAOMZO5D8hpwg+mfZ0LFhuvQU8EX0n+qkfc8PR=BF7ar2Fp=hJw@mail.gmail.com>
References: <DD64F087E8F0B540A1C9216D6716FFBDF994813E@defrsexc01.swissphone.de>
 <CAOMZO5A9ypZOhA01hHwS3Eyig7t=3ivD2nnWh8NF7PB2P-w-Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5A9ypZOhA01hHwS3Eyig7t=3ivD2nnWh8NF7PB2P-w-Uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fischer, Christian" <fischerc@swissphone.de>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "bhumirks@gmail.com" <bhumirks@gmail.com>, "richard.leitner@skidata.com" <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 12, 2018 at 10:05 PM, Fabio Estevam <festevam@gmail.com> wrote:

> What about using simple audio card binding in your device tree instead?
>
> You could pass the simple-audio-card,routing property as described in
> Documentation/devicetree/bindings/sound/simple-card.txt
>
> A dts where sgtl5000 is used with simple audio card is
> arch/arm/boot/dts/imx7s-warp.dts.
>
> This one does not use simple-audio-card,routing, but at least it gives
> you a reference.

This one uses sgtl5000 with simple-audio-card,routing:
arch/arm/boot/dts/imx6ul-tx6ul.dtsi

Hope it helps.
