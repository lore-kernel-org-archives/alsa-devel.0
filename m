From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v14 1/3] drm/i2c: tda998x: Add support of a DT graph of
 ports
Date: Mon, 3 Aug 2015 19:40:31 +0200
Message-ID: <20150803194031.5e45019e@armhf>
References: <cover.1438076750.git.moinejf@free.fr>
	<fb313682b8d14e16565fc317b7f5a249748c069f.1438076750.git.moinejf@free.fr>
	<55BF8111.4080905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55BF8111.4080905-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Aug 2015 17:56:17 +0300
Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:

> On 05/08/15 11:18, Jean-Francois Moine wrote:
> > Two kinds of ports may be declared in a DT graph of ports: video an=
d audio.
> > This patch accepts the port value from a video port as an alternati=
ve
> > to the video-ports property.
> > It also accepts audio ports in the case the transmitter is not used=
 as
> > a slave encoder.
> > The new file include/sound/tda998x.h prepares to the definition of
> > a tda998x CODEC.
> >
> > Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> > ---
> >   .../devicetree/bindings/drm/i2c/tda998x.txt        | 51 +++++++++=
+++
> >   drivers/gpu/drm/i2c/tda998x_drv.c                  | 90 +++++++++=
++++++++++---
> >   include/sound/tda998x.h                            |  8 ++
> >   3 files changed, 140 insertions(+), 9 deletions(-)
> >   create mode 100644 include/sound/tda998x.h
> >
> > diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt =
b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> > index e9e4bce..35f6a80 100644
> > --- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> > +++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> > @@ -16,6 +16,35 @@ Optional properties:
> >
> >     - video-ports: 24 bits value which defines how the video contro=
ller
> >   	output is wired to the TDA998x input - default: <0x230145>
> > +	This property is not used when ports are defined.
> > +
> > +Optional nodes:
> > +
> > +  - port: up to three ports.
> > +	The ports are defined according to [1].
> > +
> > +    Video port.
> > +	There may be only one video port.
> > +	This one must contain the following property:
> > +
> > +	- port-type: must be "rgb"
> > +
> > +	and may contain the optional property:
> > +
> > +	- reg: 24 bits value which defines how the video controller
> > +		output is wired to the TDA998x input (video pins)
> > +		When absent, the default value is <0x230145>.
>=20
> Using reg property for something else than for address of some kind=20
> seems confusing to me. Should we just add an explicit property rgb ma=
pping?

Indeed, there could be an attribute as 'port-value'.

> > +
> > +    Audio ports.
> > +	There may be one or two audio ports.
> > +	These ones must contain the following properties:
> > +
> > +	- port-type: must be "i2s" or "spdif"
> > +
> > +	- reg: 8 bits value which defines how the audio controller
> > +		output is wired to the TDA998x input (audio pins)
> > +
>=20
> Here I do not even understand what what the values 3 ad 4 stand for.=20

These values come from the TDA19988 documentation (the TDA9988 and
TDA9989 have the same video and audio input registers).
- 0x03 is WS (Word Select - bit 0) =3D 1 (I2S) and AP (Audio Pin) =3D 1=
 (bit 1)
- 0x04 is WS =3D 0 (S/PDIF) and AP =3D 2 (bit 2)

> Also when trying to make a device file following the above binding I =
get=20
> errors related the different widths of for the register property valu=
es=20
> (I do not have the exact error at hand right now), but that prevented=
 me=20
> from using these patches when I last tried them.

Strange. I have no error.

> Anyway having some clearly defined property that explicitly defines t=
he=20
> audio pins would make more sense to me. Even if that is not possible =
due=20
> lack of proper documentation it would be better not add to the confus=
ion=20
> by unusual usage of reg property.

I don't remember from where I got the TDA19988 documentation, but,
anyway, the port values are the same as the ones found in the first
kernel provided by the Cubox manufacturer.

> Best regards,
> Jyri
>=20
> ps. Did you ever give my generic hdmi codec patch a try?

No, because I don't need a so complex codec. Mine has no codec device,
no private data, no clock, and it is less than 150 lines of code.
Also, as my machine is now obsolete, I will stop any development for it
and keep the kernel I have and which works fine enough for me.

Best regards.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
