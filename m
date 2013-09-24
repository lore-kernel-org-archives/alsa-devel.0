From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rsnd: remove rsnd_priv_read/write/bset()
Date: Tue, 24 Sep 2013 19:53:56 +0100
Message-ID: <20130924185356.GJ3226@sirena.org.uk>
References: <87sixrre8r.wl%kuninori.morimoto.gx@renesas.com>
 <87mwnvsy7a.wl%kuninori.morimoto.gx@renesas.com>
 <87hae3sxt2.wl%kuninori.morimoto.gx@renesas.com>
 <20130917130402.GE21013@sirena.org.uk>
 <uioxzfuoi.wl%kuninori.morimoto.gx@renesas.com>
 <20130917133525.GG21013@sirena.org.uk>
 <87y56mrbqg.wl%kuninori.morimoto.gx@renesas.com>
 <87wqm6rbnn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wqm6rbnn.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon <horms@verge.net.au>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2013 at 11:12:17PM -0700, Kuninori Morimoto wrote:
> adg.c only used rsnd_priv_read/write/bset()
> which is the only user of NULL mod.
> but, it can be removed.

Applied both, thanks.

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQd/AAAoJELSic+t+oim9Dl4P/j3TwQGGb0vm5Q8N0ThF6JqH
PhmXclqk2YScw53eazMmTKHR1nvUY4nCDc/sOLgA01X7KArau23Y0RWMFFlsezjU
Yyq7dFNB1uU8diPmxu3GGFDEH/Z3LfJhw0+j5bbdy3g3F4pww3+41gk6lEl4pAYD
gxrtY8Bu7qeu6GhWmsWe9jsURzgBNF8fUlQ5A5GuoEIQOTjTRo2jiapFRE35XO65
+6+JbW5aIWtabVWzIpdGFj3Ww7H+Fsdj04YspHuML/bsq4ERZp63WfrCP6bMuqLG
iWm9iOWppgk2YRfvZJX9aPxpvkjoTKsDGjymCMRITCS47R+Ma6kjKg2CGQUOT3ir
Mc04VEzNEK3hgVh/wL1ia0OIvcuMTPfKVkjGjs00mmuqeSPrgRNmAmLh+AO5ekpb
U7fMHL1kEZSxHB5dEvkToq4bNGjy93ENysBV6DbR41pAOL93xzcBSwI1mSiV7ZDa
GK+Y07ycU0SQhpgjIoVba8GncX09xDCtZRgtxMPrAv6tK07XgG2xkQcKV7qkrIAr
FVOX4rY1Y9eGsFAva3DwmsflgPDdelspOTAn3qzm4/4RAw0YpUzCLycTEFoI/1Ng
Ec6g6ZRJTlu6OO0bNXhjuJQ6g2tMFHGGDeSjIZ7WCldEz+giGJvvtzFo5NWK1PyT
UXciaIUNYgp6/anGGMoz
=F+Ef
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
