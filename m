From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
Date: Thu, 16 Feb 2017 20:14:27 +0000
Message-ID: <20170216201427.z7ixcwbuyvb7ajgn@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
 <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
 <20170215145341.sntwx7oqyqmw6azv@sirena.org.uk>
 <338f8db7-2077-626f-986b-b4e3df40469c@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7tmmzmmcxmah5mqc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <338f8db7-2077-626f-986b-b4e3df40469c-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org" <kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Olivier MOYSAN <olivier.moysan-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--7tmmzmmcxmah5mqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2017 at 04:46:44PM +0100, Arnaud Pouliquen wrote:
> On 02/15/2017 03:53 PM, Mark Brown wrote:
> > On Wed, Feb 15, 2017 at 02:59:18PM +0100, Arnaud Pouliquen wrote:

> > No, copy() is an alternative to doing DMA rather than something
> > that works with DMA.  If you want to have some sort of post
> > processing operation it shoudn't be called copy().  It's probably
> > worth considering just making a new format and letting userspace
> > convert things here.

> You mean using a plug-in alsa to do it? this seems not possible with
> tiny-alsa...
> Without a plug-in, driver will not be compatible with standard audio
> application.

Right.  But if you're using tinyalsa you've got some open coded system
specific stuff anyway!

> Do you think this would be reasonable if i implement something similar
> in my driver, without using the soc generic DMA engine?

Probably.  It might even be possible to fit it elegently into the
generic dmaengine code, just don't say it's a copy() operation since
that's a specific thing in ALSA.

--7tmmzmmcxmah5mqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlimCCIACgkQJNaLcl1U
h9Cklgf6A8OM/wvcw9Pgv95z65Oh1spkmE78Oc9GpTsn19JugWb9tbmN4sj7XoU0
2dQgGD/SdYjwd9gnt1S8z7BzRg8xQV8uVkl7tgeJY2hlIxdrSOYsI0zJOfABuC3M
It+6DdGnpYTCyBCsa388Uhtyc02XI5Wnhg8MFevU/Lqq4kaNqdsA4451ufbejXdV
NB5JDmFv2nxCS2NYXt/D/eazCZqEJVHUyOW9+3nplJcekrKhRGiAjd68p640kWp3
OCU0wbUb84G5/M00pl4DzlsLrS1AgztfDP1CJrtJvlsheNzPPUDaqIhlBQVGn/aM
lxCG+tfZ47koyc0Iz7azf3qxJMfILw==
=c56f
-----END PGP SIGNATURE-----

--7tmmzmmcxmah5mqc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
