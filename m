From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 18 Apr 2019 10:06:38 +0100
Message-ID: <20190418090638.GA6702@sirena.org.uk>
References: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
 <20190418090011.GA4028@Asurada>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418090011.GA4028@Asurada>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 02:00:12AM -0700, Nicolin Chen wrote:
> On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:

> > In imx8 when systerm enter suspend state, the power of subsystem will
> > be off, the clock enable state will be lost and register configuration

> Just for curiosity, we had similar situation on imx6sx, so we
> added suspend/resume with regcache. Why will the clock enable
> state be lost too? Does CCM on imx8 (might not be called CCM
> though) have any difference? What about clock rate settings?

That sounds like a bug somewhere else - I'd expect that after resume the
clocking would be restored to the state it was in before suspend.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly4PhsACgkQJNaLcl1U
h9D0+Qf/Qb3ZB7++N4KWIotelaGoJliU91cFGeVtbV14n7Hb9xPZ3PzNlZBY9iYN
zhzzBdDCqWV5btb21LZ8lCcFicsKQTJieKm6Ufjrnr7SJ/9pjoOuV4JnDZ6aFucA
1krwDMkcK/ZD4Dj+favuOXRQUQ892A1Km2dp1ihRlQTIVIRyubA/7F3PQdr8ZjQl
8sLhALAl7K5u5ylLUX9SItPTJSQeVxb7V+JaHCrmVpsYP1oSu3I77DHvHPKLNK7p
JJe0CvyDco+KWEJ4VXnZVt/hkEyT8tvhlmAX37A+NxYxjyXdHQZYVNOn83FuWPo7
f2Krw/3Jy9Th/DZfw4A0/wLL+dMzDA==
=OW6D
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
