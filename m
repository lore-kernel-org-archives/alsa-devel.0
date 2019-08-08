From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date: Thu, 8 Aug 2019 14:02:17 +0100
Message-ID: <20190808130217.GE3795@sirena.co.uk>
References: <20190808123655.31520-1-stefan@agner.ch>
 <20190808124437.GD3795@sirena.co.uk>
 <s5hlfw3izhl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hlfw3izhl.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Agner <stefan@agner.ch>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, Stefan Agner <stefan.agner@toradex.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 03:00:06PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > No, they absolutely should tell the user why they are deferring so the
> > user has some information to go on when they're trying to figure out why
> > their device isn't instantiating.

> But it's no real error that *must* be printed on the console, either.
> Maybe downgrading the printk level?

Yes, downgrading can be OK though it does bloat the code.

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MHVkACgkQJNaLcl1U
h9B5dgf+Ki7SUxxyvriFNENPkuylZV1sbMznsZZIogox9AW2hDHgCKXsLjFT5kM9
gQ644qx/g31SqeClGf5qFCdskrusee9JBrbD4KrcjJIUsCJxWo9o04+gzBE2cZSu
KdEgzsGLKWRLHw6KAcOCi8A0ivv+SvHkN0pFABLaT+j/rVwgIk+nqwvCEAw+9TC4
l6TyunmOBcu3V7Xf3zlwtyZvP0s3SppGl2meEHdct3tJvXc/qFuGB6Tajd/6Vlcm
hopnicRj76Ujscy8cubggj371VruYsMEhcv5tdANbC2bEIpOIO7xzcPRHkkV62HR
pcs1+xufhA2K5hluWd7IVYq2+m529w==
=AqHH
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
