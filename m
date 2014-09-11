From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: fsl: add imx-tlv320aic3x machine
 driver
Date: Thu, 11 Sep 2014 08:40:16 +0200
Message-ID: <20140911064016.GE16489@pengutronix.de>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <20140910142740.GC16489@pengutronix.de>
 <CAGoOwPSpkNy6uNVAjG2HgiHHscKZjL5wgVrkyGwWCmyU7x+gWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGoOwPSpkNy6uNVAjG2HgiHHscKZjL5wgVrkyGwWCmyU7x+gWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 11:14:15AM -0700, Nicolin Chen wrote:
> On Wed, Sep 10, 2014 at 7:27 AM, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wro=
te:
> > Hi,
> >
> > On Wed, Sep 10, 2014 at 04:46:46PM +0300, Dmitry Lavnikevich wrote:
> >> This is driver for i.MX6 boards with tlv320aic3x audio codecs.
> >>
> >> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
> >> ---
> >>  .../bindings/sound/fsl,imx-audio-tlv320aic3x.txt   |  27 ++++
> >>  sound/soc/fsl/Kconfig                              |  13 ++
> >>  sound/soc/fsl/Makefile                             |   2 +
> >>  sound/soc/fsl/imx-tlv320aic3x.c                    | 177 ++++++++++++=
+++++++++
> >>  4 files changed, 219 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-au=
dio-tlv320aic3x.txt
> >>  create mode 100644 sound/soc/fsl/imx-tlv320aic3x.c
> >
> > Is it possible to use the simple-card
> > (Documentation/devicetree/bindings/sound/simple-card.txt) instead of
> > adding a new audio card driver? There are also DT bindings for the imx
> > audiomultiplexer (imx-audmux.txt).
>=20
> I don't know why my mutt doesn't display this mail.
>=20
> Anyway, if Simple Card supports audmux, yes, it's also a good idea.

Simple Card doesn't support it. But there are DT bindings for the audmux
device node which allow the definition of a default multiplexer setup.
That configuration is applied in the probe() function of the audmux driver.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUEUPPAAoJEEpcgKtcEGQQb2YQALHB2zU9+ynWsb5H3+LO/c0t
Th397KH56+T0/i1Qgbm6OwIQ8e1xYQ09EvQdPxxZg1RDt+cLnrSwiTjlBXV95Xfs
Ez7UHGn5P+r7QRj+HBnaYfeOk7Hw2dcL4HIPUTqyZJDRIwEJQ96ka7nOBMNRpc94
xOc56AEkt0ftffKdsLzTosPl2MPcfuG5fAp8jSbAChwXny5xx28YusUbQr3zNzXQ
XRvfWt8eYB8XVF+E8OYQhMhHN2KD7dkUs0pE94ZzXp4i0oUo8jGVgPZBPZVoIVJk
EXoTjsy7pCSEYYwlulDN1ujL41sHXvhnFB1Vli2UnmNygXELdd0q3jaa5sbUBiv8
/A26yauckAqhGVDew3ayRp1UH7q4HD5KfXdBWUIt6dDecNuO3k6t1yTIeRG1hBLW
DtvY3xGOTnwlvvJeuhQ1sK2IVQfyyi2U3CnlAJWybonmurtF4s9bnrY25xqakRa8
53igpZXpS2bnUdnHVTw4LjR2t8HTBtQICcjXy+aUREMvxq7p5hwPmvSA2mvCdftb
zFujI2hluuN8r5cfIVWQ/wfKyvNXmqv2Cl+3lUeoLToWUr2lS3h9gMXu0su/Ty2Q
as34YH+roCnARk2Ddl4C2EcLAkoyeZLSSDt8X45f20tcMqXg6pKui/lsPwOcYsOu
v7P+2VCwfHsgzcK21PE7
=/KzK
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
