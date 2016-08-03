From: Mark Brown <broonie@kernel.org>
Subject: Re: How to post cleanup patches ?
Date: Wed, 3 Aug 2016 11:56:11 +0100
Message-ID: <20160803105611.GO10376@sirena.org.uk>
References: <87k2fy8xy5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mpBQsTDkJwM+mRv6"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k2fy8xy5.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--mpBQsTDkJwM+mRv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 03, 2016 at 01:12:25AM +0000, Kuninori Morimoto wrote:

> But my concern is that you hate big-patch-set, and it is almost 70 patches.
> Can I post these patches to ML ? or should I use git pull request ? or I shouldn't post ?

A very repetitive patch series which does the same thing to multiple
drivers (so is essentially the same patch lots of times) is not such a
problem, the problem is huge numbers of different patches that all need
individual review.

--mpBQsTDkJwM+mRv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXoc3KAAoJECTWi3JdVIfQc/QH/0jgEVncSb5vq3FNj/8307Fg
L9VrsO3NmWuLjVb7AuiOFhXxzP4HWWNfZ07ChEt9OlIHzjN5SxeIVxQ7uDm0MXwK
KzC+0enjQZ0MIPvi+tSDbT2cSGD3qnGMRtPPkhsN6ueGln+qNat1iIpleKDUw2f5
3LxGUaab/a3Zvk0WziVBOmWwV+WM3jBRtquQQVFQxVlOOAoNL/UHYg0NnaY8TgFU
I+ab1i8jvb4zkJTKkAVdA+Xwglne8sPc/I5Xpr0xDzE9g7PnpVFHQ+dV7NtjXALk
+1qMG15BJlYkzDFxyWNB3XZh10DjOQuS4r/NJEfspJJX+AdVkI/cShTUbEJUNTM=
=4zBQ
-----END PGP SIGNATURE-----

--mpBQsTDkJwM+mRv6--
