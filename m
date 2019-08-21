From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 20/21] ASoC: sun4i-i2s: Add support for TDM slots
Date: Wed, 21 Aug 2019 13:08:07 +0100
Message-ID: <20190821120807.GG5128@sirena.co.uk>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com>
 <c311e88a-fdd2-8a01-275e-675d98dc90ba@orpaltech.com>
 <20190821120551.r4b3h4nnet357wem@flea>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190821120551.r4b3h4nnet357wem@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <mripard@kernel.org>
Cc: Sergey Suloev <ssuloev@orpaltech.com>, Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com, codekipper@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 02:05:51PM +0200, Maxime Ripard wrote:
> On Tue, Aug 20, 2019 at 08:46:30AM +0300, Sergey Suloev wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > >   	.set_sysclk	= sun4i_i2s_set_sysclk,
> > > +	.set_tdm_slot	= sun4i_i2s_set_tdm_slot,
> > >   	.trigger	= sun4i_i2s_trigger,
> > >   };

> > it seems like you forgot to implement sun4i_i2s_dai_ops.set_bclk_ratio
> > because, as I far as I understand, it should alter tdm slots functionality
> > indirectly.

> As far as I can see, while this indeed changes a few things on the TDM
> setup, it's optional, orthogonal and it has a single user in the tree
> (some intel platform card).

> So I'd say that if someone ever needs it, we can have it, but it's not
> a blocker.

Yes, that's a compltely orthogonal callback.

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dNCcACgkQJNaLcl1U
h9Bl8Af/Xm2Xa9YOa6VFkbJ3jgkINICtBABTxYvKltNwmT5BP8nOJkVXFq1TtdMz
N5EyBg9dN2luySAos4G/tu/IoD8MDAenPS9xiljA5EGVzZFq+Alw8RwJLAOhEhip
0jt3BiI6CIRL286m17Eb2WIvebAqPZVT7gbqVNXzaQsQInq6AQ8xQRGsb6OAYunw
p7LOLWJ4LAYxGrwgO6dlnyeRyDSbg5lg0jdWYldy8C+2G7q3AZZ1E6KIo4n5+TJd
JjTrKX9kx5ABzsBJyu/hQ6Zn0MCdC11AJZRBSfYzO+fE/1l49SqVHoD6MxEtWM5g
Ica+0kC+/XGk7S294y0Hi2hz4cwrOw==
=B3Db
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
