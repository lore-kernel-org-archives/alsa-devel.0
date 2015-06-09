From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: wm_adsp: Add code_probe and codec_remove
 stubs
Date: Tue, 9 Jun 2015 17:20:45 +0100
Message-ID: <20150609162045.GF14071@sirena.org.uk>
References: <1433863017-25349-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150609160043.GD14071@sirena.org.uk>
 <20150609161356.GB27675@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gi2vSq8QtPYbuTNa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150609161356.GB27675@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Gi2vSq8QtPYbuTNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 05:13:56PM +0100, Richard Fitzgerald wrote:
> On Tue, Jun 09, 2015 at 05:00:43PM +0100, Mark Brown wrote:

> > I'm still not a big fan of the double registration that's being done -
> > if nothing else the fact that it's not also factoring out the creation
> > of the DSP controls seems wrong.

> I don't see the point of trying to fight against the design of ASoC with
> the second probe. ASoC gives us what we need at the codec_probe stage
> so why try to invent something different?

Well, you could've still hung things off the struct device - it's not
like the ASoC level device is a requirement here - and like I say the
fact that it's not actually factoring out the initialisation that's
already happening at the ASoC probe isn't good.

--Gi2vSq8QtPYbuTNa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdxJcAAoJECTWi3JdVIfQ/2cH/2hPBo4q0bAZUAY9sgGrUIbO
RzZBhQankNKFiDa7jC25NoA96UJsRw9mT/n4rOttqUFK34176QMNDkifV3drFAjY
RQrEX73UV9/J1pVL2m5ZYRhLN6dcU6UcmeKCQyNFa/xNR+hOTLS3vMpz/Dpg3eo8
8NuR5Ig5ep5CpfSAk/gkkwnoJSN109LnxcgtSrur0Nu6s+yKTQ55R3OyJMZI1CZR
3DtPo0adhk925vW4sdG7Jp7xLcCvzQpmNVu4qSadM1m7Bh6oOtNDMNBJSTy8ifrR
kJ8IbVWETi2JT9ZNKIkCAsn+bllQUmjeS9EDCoLpSmRSedALdGkZZBNi1S3KBUY=
=u9cT
-----END PGP SIGNATURE-----

--Gi2vSq8QtPYbuTNa--
