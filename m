From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
Date: Wed, 15 Feb 2017 16:53:00 +0000
Message-ID: <20170215165300.wxkzxvq5bjjovgop@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
 <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
 <9b875a75-294a-2f59-5830-cc0f6b3b62c7@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aougrl6cl6xjtuex"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9b875a75-294a-2f59-5830-cc0f6b3b62c7-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org" <kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Olivier MOYSAN <olivier.moysan-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--aougrl6cl6xjtuex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 05:39:53PM +0100, Arnaud Pouliquen wrote:
> On 02/14/2017 06:45 PM, Mark Brown wrote:

> > What's the physical minimum period limit?  The comment makes this=20
> > sound like it's just made up.

> I did not find physical minimum period limit, that why i considered
> this value from a scheduling point of view. I will re-check these values.

If there's no physical limit the minimum is one byte, it's the
application's problem if it's not actually able to sustain what it
chooses.

--aougrl6cl6xjtuex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlikh2sACgkQJNaLcl1U
h9DK/wf/ZdPsIU/jcL+tYmRvBQC7Gxf8w/pyyH32dI+6F5qOy5saetbOFL2RSfmo
yrLCDS9ZzKrlCyxmKGsAuZZQ8usz3O7jllgoxWCIi8+DRd0sJzB0z1xebtaTeFD0
BpPX1h115Yd6fk8sJzR5YrXTbSaVe0Pl4Oo0EN32exMwA027weQtetRSD+re+1LM
aIinPIFVaM/SnuVat5zo/skRDHfBVMJcc0neDiwdEmIP5QPXzXoqvMrLE28MM/Q3
Zl/rJCrTxVd8XmgoClPy6TigTWgHeDkbyt/pOgt+hi9/25pUDMk2c3ihYbYBh3hv
rvahh4s/myabNfJPY0Rbu6DuNqMvkg==
=A+xo
-----END PGP SIGNATURE-----

--aougrl6cl6xjtuex--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
