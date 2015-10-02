From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop transferring issue
Date: Fri, 2 Oct 2015 18:05:44 +0100
Message-ID: <20151002170544.GX12635@sirena.org.uk>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BtNCO5h84ExDStzY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yitian <yitian.bu@tangramtek.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, Andrew.Jackson@arm.com, wsa@the-dreams.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--BtNCO5h84ExDStzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 10:43:17PM +0800, yitian wrote:

> --- a/sound/soc/dwc/designware_i2s.c
> +++ b/sound/soc/dwc/designware_i2s.c
> @@ -141,13 +141,22 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev
> *dev, u32 stream)

This doesn't apply because it's been corrupted by line wrapping - git am
can't understand it.  Since it's just that one line I fixed it up by
hand but please look at your mail setup to make sure this works (this
might've been what happened with your other patch yesterday).

--BtNCO5h84ExDStzY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDrlnAAoJECTWi3JdVIfQNfUH/iM+IVlEUrsAfF2lR5m1ye3a
hlz0SwawN1MhSBw7LKSNrcfPIL9iLe3ys/A2G+WHNx5lOoxZdEffaawDgxtjeFmo
PkELg5OjX9Ca3d5OGxehiFnJCplyycKcNMFiyPrBMUm601oz9mjbsxlhCDfHOk/D
LJj8CaDnnoaxS8hEO2VRUEH7uCslEizefMpsBTuP9xx3iJ+FYj33ceWvzLObu9Pk
M337QM304kATcIu5sTsQSX79uqNJjEAYtkNYf6qOkbe9l2fB+i2QKcVdO7JzNDJU
feKLe/BM47kCOmmYb3Vfz7gbw2ua5nhT4Xwokjd6GKW0OTyegX2aEQAznH87NHs=
=+//R
-----END PGP SIGNATURE-----

--BtNCO5h84ExDStzY--
