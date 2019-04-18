From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 18 Apr 2019 11:17:13 +0100
Message-ID: <20190418101713.GD6702@sirena.org.uk>
References: <VE1PR04MB6479871F3FC087282D23582DE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479871F3FC087282D23582DE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2019 at 10:15:24AM +0000, S.j. Wang wrote:
> > On Thu, Apr 18, 2019 at 02:00:12AM -0700, Nicolin Chen wrote:
> > > On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:

> > > Just for curiosity, we had similar situation on imx6sx, so we added
> > > suspend/resume with regcache. Why will the clock enable state be lost
> > > too? Does CCM on imx8 (might not be called CCM
> > > though) have any difference? What about clock rate settings?

> > That sounds like a bug somewhere else - I'd expect that after resume the
> > clocking would be restored to the state it was in before suspend.

> There is limitation in our internal design. That is in imx8 the power of
> subsystem will be disabled at suspend, include the clock state , clock ra=
te.=20

Right, that's fairly normal but usually it'd be restored as part of the
resume process?

> This patch is to enable the pm runtime,  so I think it is better to move =
the
> clock operation to pm runtime,  and close the clock at suspend to reduce
> the power.

It's definitely good to turn the clock off as much as possible, yes.

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly4TqkACgkQJNaLcl1U
h9ALKAgAhnvp9dsorOBOcQOXt2Vq+2KD6GhkpwRpRuLi546nZ9RcO9/ADIT31G4a
CPIpTSxmQcE7gESw935EGIhfsg7hySIHmOn0gR/6Jxmp4bOzb8RX+CMZQ1t9PzV7
aWtKsRrHdnIvlg0U0ua6M/ZslqxRTqdJH6rjKOu60lhS+QmeT19wj1kWe2xoP3e1
KUkoMMzdYj0dD6X5DjbjTDi5M2NX1NfVoqAbMclgwQ/A5TSqTSB7y+sktSjRWWEM
YoaFvHpTL/VVfw/Kq6ixXpH1qzLEeSZ++TE3DN7L1m88lXouS1QpcY4Whjsqb9K2
WPl704mTbAKcfAieB4Dilba/VD5CPA==
=ioaN
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
