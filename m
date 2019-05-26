From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
Date: Sun, 26 May 2019 20:47:35 +0200
Message-ID: <CAJiuCcf4d-5-U++wQ4wkrcSSk_SyeuHnxyz0DMvHaS4YuOsx3A@mail.gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com> <20190525162323.20216-2-peron.clem@gmail.com>
 <20190526182220.hgajlcyssujjkmiu@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190526182220.hgajlcyssujjkmiu@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jagan Teki <jagan@amarulasolutions.com>, Linux-ALSA <alsa-devel@alsa-project.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Maxime,

On Sun, 26 May 2019 at 20:22, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Sat, May 25, 2019 at 06:23:17PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Allwinner H6 has a SPDIF controller with an increase of the fifo
> > size and a sligher difference in memory mapping compare to H3/A64.
> >
> > This make it not compatible with the previous generation.
> >
> > Introduce a specific bindings for H6 SoC.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.=
txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> > index 0c64a209c2e9..c0fbb50a4df9 100644
> > --- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> > +++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> > @@ -7,10 +7,11 @@ For now only playback is supported.
> >
> >  Required properties:
> >
> > -  - compatible               : should be one of the following:
> > +  - compatible               : Should be one of the following:
> >      - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
> >      - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
> >      - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
> > +    - "allwinner,sun50i-h6-spdif": for the allwinner H6 SoC
>
> This won't apply anymore on top of next, we've moved to a YAML
> schemas.

Indeed I have based this series on sunxi instead of sound.
Thanks for pointing out that.
Cl=C3=A9ment

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
