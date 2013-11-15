From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: cs42l52: Correct MIC CTL mask
Date: Fri, 15 Nov 2013 10:17:25 +0000
Message-ID: <20131115101725.GW26614@sirena.org.uk>
References: <1384451172-1532-1-git-send-email-brian.austin@cirrus.com>
 <1384451172-1532-2-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1363991438965353549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 30C9126030E
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 11:17:34 +0100 (CET)
In-Reply-To: <1384451172-1532-2-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgridwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1363991438965353549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ou5B7nmexOOGXbzo"
Content-Disposition: inline


--Ou5B7nmexOOGXbzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 11:46:12AM -0600, Brian Austin wrote:
> The mask for CS42L52_MIC_CTL_TYPE_MASK was wrong keeping the mic config
> from being set correctly.

Applied, thanks.

--Ou5B7nmexOOGXbzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShfSyAAoJELSic+t+oim9AOMP/1cO9R6OqPBZtSD7E/8G1+qj
4bfQMLpoLku63lJQzyeYFW0izIzOvUtP8q8ahRzsazlRZmQ96IgSe4WeLAchwYjo
9FBNxa7apLZxcj/b+Er9iwD7d4pgdyRkRJlYWMfY+HXvjRBk5Dd21YWps12onRh0
hr1aMyQ2ZbYvftw50djSguBaH3Vt04u8wrBDVBpd1Er8WY7tGM2yM1hWs1zQYI8M
OVr+VVxf/L4zstxGjZ9RCSyJH3YS6Os6/U/ub1uSx0IZ/aj0bKjrog/RJwxR6e4f
LEIfjqvSyRIB4JQL37YHXsObhsCKFNVXctlaHMW6BEXwYB2996r6SQ7P3fIoK+MH
Gj1QiKncY6wFTPjbD7r875X6SSjyESCDWoWSVK7bvTD53Csw0MEdGRpDy/7XWjbi
EkpczmYzcLBjhmhivZ1EKtUP9/74HiFIbFBrqSgY7JwrU9dflV7mcKnSVMqfwrUr
DeM0WBdvw+c7PoLuw583hd1NvgmIvumBpTPkpysiALl7sduTv+VnzM9yllR/5+PE
mxfeKIw5+aY6ZhxYM0gr46ybNnbA4e2N0LpMVzQuBH4of0ba4rCspgPRbbYoW52o
LG8flwU9YZceDmOQuVK6YV/nsBjmMZQ+ZZy0BF/lewC5idR6pmXUCNbLzyCtcONv
S4Ley1S6e59AABpJjL75
=0rFA
-----END PGP SIGNATURE-----

--Ou5B7nmexOOGXbzo--

--===============1363991438965353549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1363991438965353549==--
