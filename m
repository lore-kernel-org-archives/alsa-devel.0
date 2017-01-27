From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: davinci - Fix possible NULL derefrence.
Date: Fri, 27 Jan 2017 11:58:06 +0000
Message-ID: <20170127115806.vvjvw47qbzcxukrz@sirena.org.uk>
References: <CGME20170127111104epcas1p2810feef80b04b21983efd16c00b1b651@epcas1p2.samsung.com>
 <1485515457-3055-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3t7awmi2s2oxh3u"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485515457-3055-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: alsa-devel@alsa-project.org


--u3t7awmi2s2oxh3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2017 at 04:40:57PM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.

It would be worth explaining how the device can instantiate with no
match...

--u3t7awmi2s2oxh3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliLNc0ACgkQJNaLcl1U
h9Bg5Af/fGYd+lT2NpIUbzoWx4mxBaNItHxQybx6tN6Lb9cgmcoxcCWnkUH1lDKM
0I0+qD/Ehp1vUURmUa6JPEwpSyMrSueSbHv2+P98qIZjjNnGuPBwOfbSM7qurUOl
6YPvxuUMh1H9d/qESp1xmCZ1i7Xv5nw3YlWLkjAgyffPnEPPenf2B0Eqi7P6vvcZ
+4QeB6yFlNwuKrJBXhsJJ3FXs5YvfidHtS3eTuZpdLhUmPPwgdGgHX7fAkfwvTEr
lGaXg6jqEHzBsF325oYyABheWRyx7kEfnFEO2TmCvhJE3Zohi7PmO3Ceo9rXjg+r
OD47FwR0T/Jv5Uh00y3hUQaayHtU+g==
=5sP+
-----END PGP SIGNATURE-----

--u3t7awmi2s2oxh3u--
