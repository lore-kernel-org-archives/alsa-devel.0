From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-abe-twl6040: Remove support for
 pdata (legacy boot)
Date: Fri, 12 Jul 2013 12:51:57 +0100
Message-ID: <20130712115157.GF24508@sirena.org.uk>
References: <1373628835-11439-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2141284202356150478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 985532659BB
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 13:52:01 +0200 (CEST)
In-Reply-To: <1373628835-11439-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2141284202356150478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8TMLq6GPUuN4DysL"
Content-Disposition: inline


--8TMLq6GPUuN4DysL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2013 at 01:33:55PM +0200, Peter Ujfalusi wrote:

> +/* TODO: This file can be removed in 3.12 since it is no longer needed */
> +

It's a bit late to do this for v3.11 so may as well just jump straight
to the removal?  Having the extra code isn't going to actively break
anything so it's just a cleanup.

--8TMLq6GPUuN4DysL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3+3aAAoJELSic+t+oim9VBwP/Rx2WM1yHTxEq/CtBD/j0ztD
bnE+ZJoMzh44ipIpAtOR4Peer7qA8zarnDNVU8jgmnbGbvi3sZKjVK+Qcj0oXIYj
NL0X+IXPKQOAGLqK/A4qKlP+Yp9axr94QtnnqQO+RPtKp/reu8k498eCQ5AOK8f9
A8En0iqttxQYY77cZpD5nlQGLB/MZqA0zJ4ohvrYY3wZDckDhWxK2uBmONJauEFd
gFh9VEMCevc+ZyyTi/rRE23K0iqN6TjP4iIctPHYx2YPsf309TnJyTzc9i4WG6Cj
C41beTUSa1se+UfUUdO1ReCYDS+pCipbMA4Z9uQNcO7z0s4NdnrfeDTKZBhAS0Xr
Sr0nfT62mYdU5r6e3qmKDHip9zksImzJGTfLDtETCzqZjkaZ0oNUuyf8HrUN6VEA
drOft/cxMTeC7xLCFU1JOWs5bYVBxqP0S14MSTWF3EVvG2b776Gt+gc3U6ZLlIPb
4huNV2wpmKVfbmeIt/0a3GipIMLJBbNAGuJ3PfvmzyipkVomXfK4QWEJMLSasnTT
0zHYqEJENQ0z2MRw/jIdox4Rk+GfdQLlds7Upq3VUoRWrjB+Kuom+TZ5kxMhpUGY
Lu5Wedy1neA96ATVUbi+z197nkJgV+aAdNh1AKkaPwod2gpSaJus9aBl4o8NEwEO
f/xlnbRJIGAC5J8a0gaO
=Aqbm
-----END PGP SIGNATURE-----

--8TMLq6GPUuN4DysL--

--===============2141284202356150478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2141284202356150478==--
