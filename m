From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Thu, 8 Jan 2015 17:42:57 +0100
Message-ID: <20150108174257.557f7ea5@armhf>
References: <cover.1420628786.git.moinejf@free.fr>
	<0084acea5a3475a77531d6a77483f36d3469111a.1420628786.git.moinejf@free.fr>
	<54AE99F5.1010404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54AE99F5.1010404-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, 8 Jan 2015 16:53:41 +0200
Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:

> > +  - audio-ports: must contain one or two values selecting the sour=
ce
> > +	in the audio port.
> > +	The source type is given by the corresponding entry in
> > +	the audio-port-names property.
> > + =20
>=20
> This binding does not allow multi channel i2s setups with multiple i2=
s=20
> pins. It would be nice to support that in the DT binding, even if the=
=20
> code is not yet ready for it.
>=20
> How about having these two optional properties instead of audio-ports=
=20
> and audio-port-names:
>=20
> audio-port-i2s: Upto 4 values for selecting pins for i2s port
> audio-port-spdif: Value for selecting input pin for spdif port
>=20
> Presence of one of the properties would be mandatory and both are all=
owed.
>=20
> Sorry to notice this only now, but I have not yet looked the drm side=
=20
> changes too closely.

=46rom Andrew's datasheet, the TDA998x's which are handled by the tda99=
8x
driver have only 4 input audio pins, the first two ones being either
S/PDIF or I2s, the last ones being I2S only.

So, the DT description could be reduced to a simple list indexed by
the pin number (=3D DAI number) and defining the protocol type.

Examples:

- for the Cubox:

	audio-inputs =3D "i2s", "spdif";

- for some other board with I2S on the pins 3 and 4 only:

	audio-inputs =3D "none", "none", "i2s", "i2s";

- for a fully wired TDA9983B (no driver yet):

	audio-inputs =3D "i2s", "i2s", "i2s", "i2s", "spdif";

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
