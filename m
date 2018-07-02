From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: es7134: add support for the es7154
Date: Mon, 2 Jul 2018 11:21:12 +0100
Message-ID: <20180702102112.GH18211@sirena.org.uk>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
 <20180629150924.18197-6-jbrunet@baylibre.com>
 <20180702100533.GD18211@sirena.org.uk>
 <1530526528.2900.145.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7SAgGoIHugoKhRwh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530526528.2900.145.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--7SAgGoIHugoKhRwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 02, 2018 at 12:15:28PM +0200, Jerome Brunet wrote:
> On Mon, 2018-07-02 at 11:05 +0100, Mark Brown wrote:
> > On Fri, Jun 29, 2018 at 05:09:24PM +0200, Jerome Brunet wrote:

> > >  	{ .compatible = "everest,es7134", .data = &es7134_chip },
> > >  	{ .compatible = "everest,es7144", .data = &es7134_chip },
> > > +	{ .compatible = "everest,es7154", .data = &es7154_chip },
> > >  	{ }

> > This needs to be added to the DT documentation.

> I believe I added this in patch 3 of this serie, which I'll resubmit.
> Shall I resubmit this patch along with it ?

Yes, please.

--7SAgGoIHugoKhRwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5/JcACgkQJNaLcl1U
h9AK/wf/aWLL6P8w0pVtvfLSuK7ceCaZq4UdHCdZgMbnTGGU+lz+r5uL2etaZZOp
6gAPuHEBfm15/7eE3M01hwnUVTJOVcBWYwj2xTpHC2OWeVnTfc4XiEn2iBQPw7i5
N6FgJZV7ZBhxmgooJSgAr6OqhtCZubx6infsqK2O3cHCauzdILmrBFWxe2GwkDAS
uUkGyLD8DrRcSdOaDtifhEkNMoL6QGRyjpWw4VCuTVOCVMeU7Ip8nsi0Z6wWkgH5
4SK5Ts5/DO1r4/Nm5/r2lCW4tS2AAhGgHImBAEJXL5jrXbXD75B5aM+SmAIdSX64
l6SzgojAkPiAK6uxwaORbBeMTdRtiw==
=geal
-----END PGP SIGNATURE-----

--7SAgGoIHugoKhRwh--
