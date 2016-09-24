From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: simple-card: add support for aux devices
Date: Sat, 24 Sep 2016 18:58:15 +0100
Message-ID: <20160924175815.7sfoguqipwwzfwbs@sirena.org.uk>
References: <1474614673-12350-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20160923222541.GA25693@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lhggdlhk33pnzdzu"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160923222541.GA25693@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Otto =?iso-8859-1?Q?Kek=E4l=E4inen?= <otto-Gh1NM5ZPXYb1KXRcyAk9cg@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mengdong Lin <mengdong.lin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Healy <cphealy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--lhggdlhk33pnzdzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 05:25:41PM -0500, Rob Herring wrote:

> Ah, one more property to the "simple" card. At what point in adding=20
> properties is it not simple?

There are a *lot* of tunables for audio subsystems and a lot of ways
they can be designed, this is why complaining at the less realistic DT
advocates who object to having a card at all.  Probably most cards won't
use anything like all the properties but simple-card does cover a large
proportion of common place cards and keeps those DT advocates who object
to having a card object at all happier.

--lhggdlhk33pnzdzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5r62AAoJECTWi3JdVIfQ+eEH/1zn1hgWfoQiMQeIyRQADr9O
JesbxbkowEUZ0Ms9NZoQG7ndGw5aogJezAs6+71MCRzlb9I5cF+hdE0mKZqMKNpL
nTC9b5cX8FRqnqXWQdGjJQ/5dku8Ev2dTsQScBwMP7tpAGorzD1+WY6y9vF8hFQa
xoBEHD//2SG2Z83/PdxUPxy7P2+FX8bOP0LLZKKOzTAVQjFd+yqZ8wqjJhf5ZyOn
ySIa5rB9wGvMQ87c541/PWLipNuRsJSxMOm+pl8Ob6xTkH5DfM2CE3EsIgHuqHlj
rivcO0Dvk2XB8wCz5IZ56pAWHvZUMcw4J0KRqnT+4JKr1420GcpvMaH8ilSkk0A=
=Moex
-----END PGP SIGNATURE-----

--lhggdlhk33pnzdzu--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
