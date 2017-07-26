From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/11] ASoC: samsung: s3c2412: Handle return value of
 clk_prepare_enable.
Date: Wed, 26 Jul 2017 15:47:12 +0100
Message-ID: <20170726144712.nfn5jvkjfo52tffv@sirena.org.uk>
References: <84c0014d4dbd466f52c45d8efbd2c1080d8174fb.1501047400.git.arvind.yadav.cs@gmail.com>
 <20170726112817.sdcfz25nhiitkhd2@sirena.org.uk>
 <b042a76a-4b18-faad-3d79-0d3132441250@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4arruq4saz5zl5kd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b042a76a-4b18-faad-3d79-0d3132441250@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--4arruq4saz5zl5kd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2017 at 05:35:32PM +0530, Arvind Yadav wrote:
> On Wednesday 26 July 2017 04:58 PM, Mark Brown wrote:
> > On Wed, Jul 26, 2017 at 11:15:25AM +0530, Arvind Yadav wrote:

> > > +err:
> > > +	clk_disable(s3c2412_i2s.iis_pclk);
> > This will disable the clock if we failed to enable it which is clearly
> > not correct.  It's also matching a clk_prepare_enable() with a
> > clk_disable() which is going to leave an unbalanced prepare.

> s3c_i2sv2_probe is enabling "iis" clock. And s3c2412_i2s_probe is enabling
> "i2sclk"  and "mpll"clock. If, "mpll" clk_prepare_enable fails. We need to
> disable and
> free the clock "iis".  and devm will handle other clock "i2sclk". In this
> code we have used
> "s3c2412_i2s.iis_cclk" for all the clock which is more confusing for me.
> Please correct me if i am wrong.

OK, they are different clocks.  This inconsistent handling seems like a
big part of the problem though - it's going to be a source of errors.
We're also still only disabling here, not unpreparing, so we're missing
something.

--4arruq4saz5zl5kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4q28ACgkQJNaLcl1U
h9AaXgf/UfCtPRkwiy21axXkJX+UtF0lTsXREK/Kw8SNbn9aLhZdOjAlCWMhwZzE
njy4nHEKGTcVnQOB2PlvuxnQdsNZzBZ7MeohZzBS1unJW2kizJpaBHB/+oJHsLt1
OTMh1rxrvd4uwbfVFgeh0DALbSsdeFj3d2pa2y4FRuaD+BPdPMq6V51DSTXr0L1R
i8/HlzZf8lJpHej8MarD6WEhK4uan4vrfzf80zZFCKtyFqmEbR3IvQTCNbBlYwUZ
uatMViIa9H3eBOP+wAMezlWSfF2K2iKjJGi1yjhv6gRhxqjfKlnyNEcYdWz9eIH3
jW7Zt0qGQwQro5WGaiXnkzcCREKybw==
=FWeJ
-----END PGP SIGNATURE-----

--4arruq4saz5zl5kd--
