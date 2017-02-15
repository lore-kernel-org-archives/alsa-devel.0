From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
Date: Wed, 15 Feb 2017 14:53:41 +0000
Message-ID: <20170215145341.sntwx7oqyqmw6azv@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
 <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="33ckhs5hsnh4v5h7"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40633f7c-a2ac-1658-cc9d-b30eaff8a95a-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org" <kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Olivier MOYSAN <olivier.moysan-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--33ckhs5hsnh4v5h7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2017 at 02:59:18PM +0100, Arnaud Pouliquen wrote:

> For DFSDM we need to re-arrange samples after DMA transfer, before
> sending them to application.
> For this, a copy ops(called in snd_pcm_lib_read_transfer) alreday exists
> in snd_pcm_ops struct.

No, copy() is an alternative to doing DMA rather than something that
works with DMA.  If you want to have some sort of post processing
operation it shoudn't be called copy().  It's probably worth considering
just making a new format and letting userspace convert things here.

--33ckhs5hsnh4v5h7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlika3QACgkQJNaLcl1U
h9DKrgf/RKMVllUuaZSVpCSv327C4V+u3rtHbhzk50hwN25T16xLJtEr4+Jeuol8
qab3PO4EkbLfr4VbKZi2c57+2nwRw+XXNiKxIOjkb8t0D2y6UCMvNezepacWnJhM
pBiT3YmP2y8voF+iXAfM/5EhYIjoTcD7tA4U0tfCH/dDdW3UShgdgm8Tg8C6rh0c
7JmCH4scZuaqnud2Rwyd8zjdmWXpbQije7TVyc3zmLMxUpx3qgFt5c8Isen6lYRm
jhPEULoAZslyN8yAzbdFnuRFovFeY2qxfdXmgicNB39yaDNGhcUit5IIxa51NlXZ
0mnvwj+gqc1sN2/25xIMw4lRnDka7w==
=iYQi
-----END PGP SIGNATURE-----

--33ckhs5hsnh4v5h7--
