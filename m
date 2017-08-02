From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: soc-core: add component
 remove/unregister_exp/lookup functions
Date: Wed, 2 Aug 2017 12:05:49 +0100
Message-ID: <20170802110549.ncpzscdey43nplmp@sirena.org.uk>
References: <87a83t6ulz.wl%kuninori.morimoto.gx@renesas.com>
 <878tjd6ukd.wl%kuninori.morimoto.gx@renesas.com>
 <877eyx6uiu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nmwkiuihnn3odb7l"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877eyx6uiu.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--nmwkiuihnn3odb7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2017 at 04:00:48AM +0000, Kuninori Morimoto wrote:

> ALSA SoC platform/codec will be replaced to component soon.
> This means 1 device might have multiple components. But current
> unregister component function only checks "dev" to find it.
> This means, unexpected component might be unregistered by current
> function.
> But, it is no problem if driver registered only 1 component.

Isn't this just a convenience for drivers though?  It means they can
just clean things up with one call and I'm having a hard time thinking
of any use cases for only unregistering some components.

> To avoid this issue, this patch adds new component
> unregister_exp/lookup/remove functions. "lookup" function finds
> component by "dev" and "driver name", and "remove" function removes it.
> "unregister_exp" will use these functions.

The exp name here seems a bit confusing...  perhaps just _internal() or
something?

> +#define snd_soc_unregister_component(dev) snd_soc_unregister_component_exp(dev, NULL)

A static inline is better, it's got better type safety.

--nmwkiuihnn3odb7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmBsgwACgkQJNaLcl1U
h9BWgAf9EOjvCn+Jjuw/1sG8XqdLoSpwjqXZtxbufyGAnj+lDQpS7QJmmRRz2K5R
MRUYYB08jXnXweMz7sCpr8bfsU8Gs8NAsmbF3saBUy97SE4o9cJrEW4IYLJ9umuO
AGhCD+/8wbiQWumMxNNsuznniZbAAmKzFQNNmxbvWb6i4nxRlbt1ZTHV+ijjEy1s
nqPo/EUaJ/vdC9JaS2K7xqvqBc0VGfEAsjaXoktGI3BrS2l1/mk58RI6S3l5BrzF
6w2hxOsIcdqPeS8x953CG24ZFeioyUQbA9jFGmzao9u8dtHC1tGScivlYmB5Ox1z
JLvVaE85Z13IP77lTwJnJm1FJdoIPw==
=18G1
-----END PGP SIGNATURE-----

--nmwkiuihnn3odb7l--
