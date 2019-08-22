From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO in
 sun4i_i2s_init_regmap_fields()
Date: Thu, 22 Aug 2019 15:41:43 +0100
Message-ID: <20190822144143.GB4630@sirena.co.uk>
References: <20190822065252.74028-1-yuehaibing@huawei.com>
 <20190822141826.is6nizjpdgvhd7ra@flea>
 <5b15becf-b79b-ae5d-91e2-6521ded50946@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5b15becf-b79b-ae5d-91e2-6521ded50946@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuehaibing <yuehaibing@huawei.com>
Cc: Maxime Ripard <mripard@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2019 at 10:34:37PM +0800, Yuehaibing wrote:
> On 2019/8/22 22:18, Maxime Ripard wrote:
> > On Thu, Aug 22, 2019 at 06:52:52AM +0000, YueHaibing wrote:

> >> -	if (IS_ERR(i2s->field_fmt_sr))
> >> -		return PTR_ERR(i2s->field_fmt_sr);
> >> -
> >> -	return 0;
> >> +	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);

> > I'm not really convinced that this more readable or more maintainable
> > though. Is there a reason for this other than we can do it?

> No special reason, just suggested by scripts/coccinelle/api/ptr_ret.cocci

Which is a bit of a reason in itself since it'll save other people
looking at the same thing though with a return like this I have to agree
with Maxime a bit and question if the coccinelle script is really a good
idea.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1eqacACgkQJNaLcl1U
h9CAkwf/Uf2VAqlhiMOqQ0rV7FeewNL+az6bwpVvk0y9wd3MeFAYAwjfhm6ssxTm
0VFGFwQOrBZly3V5sM2+RPO7rvR+73k8ilAAKH4Te423k6tghyvem195C+W8XoE5
A8R0VBmnIIocvgj1PjbeF1R6Tq5uUWP88SUMCHbRDBGcLqXGY3JlVWao6UKXbas4
bHRmTBWA7qliaKrmrXnVXLpl/zYvz30YzW6IOBSzWVIDPL6ivAZjvRNz+x0iYs3E
xbv5KF1NPxQQILnHCxAQ5W+4PmqJ856qMgrFcnrc1D6VKE+1Nph67EOVrGy1lf65
l5xMPz2Dd7PtRcLXKdLVxuXxeJzUxw==
=BB78
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
