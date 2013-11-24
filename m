From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: rcar: some dubious one-bit signed bitfields
Date: Sun, 24 Nov 2013 13:42:55 +0000
Message-ID: <20131124134255.GW14725@sirena.org.uk>
References: <20131108094653.GF27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m9FEOsnejx470nED"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131108094653.GF27977@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--m9FEOsnejx470nED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2013 at 12:46:53PM +0300, Dan Carpenter wrote:
> Because these are signed they can either be 0 or -1 instead of 0 and 1
> as intended.  It doesn't cause a problem from what I can see, but it's
> dangerous and Sparse complains:

Applied, thanks.

--m9FEOsnejx470nED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSkgJcAAoJELSic+t+oim9I+UP/RLKtSZD0GFl6jPzZH2QLCAM
4lgEMFCfZclE0i75kfaFVv4UtHJwna7IloGEoZA8WL+LzLCk4qfG7i5lh8n9RqLY
5BEXAjtGKyeDR/TXHt9tUfnHQ5WhVsn/ZYPhB1XV3zalguRdLx6EpOU2tV5RFfGS
Pu9CCFIcK388nNNLa7z4Uael7C5fzJ8aQ2K8meIgIvv6JdaN2Qu92PU64I6tjWYl
sc+cdjzNpZVHhsCaw0MsGVlITdRPymN574m2xtOPeYQWb/Yxo48610+qSy9nOEO2
D0VA4zD9TiD1o8V2lccXmXJpos3VqYiYGxfaSyh95WMw8ugz01lhOm/n+knyj3TI
UFQE2OX/cP3IuGYWVf2ZQZL4c1ZQ63TmgYb5N09V9lXIqbYU0nA6KTzxGiUqIJQ7
wjTrVwg1J6JTvtEBxgPpTO36o5y0+uI/1Fhik/5K5eCQ+9KU7BzfjUL9BZlyI6in
7DfdpSKTTIDgndJNLAKM5nOQeF+fBpGeIaXSn2pS9wZiE6MTIA5i9PQ+QpSN7REx
BUs09xsS+ZiHox3jvGsQlXkdfHGGgfldqXWUvQHrU3HfsdHHPJ0Kv06ce+2CXo9E
JT6UKqcvZScPEXdY5pOmsM41HxFOGVSwbEEE4zicvJLEBh0TtyTMN/ue9J/GMsQc
NXw9+F2ghtdDQWmL/AMr
=hYPZ
-----END PGP SIGNATURE-----

--m9FEOsnejx470nED--
