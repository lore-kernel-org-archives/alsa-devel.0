From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4271: fix dapm routing table
Date: Sun, 11 Aug 2013 18:41:48 +0100
Message-ID: <20130811174148.GE6427@sirena.org.uk>
References: <1376237219-31503-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2516899621115914986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C558F2615B6
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 19:41:50 +0200 (CEST)
In-Reply-To: <1376237219-31503-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru
List-Id: alsa-devel@alsa-project.org


--===============2516899621115914986==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g/2gxic02LijnRx4"
Content-Disposition: inline


--g/2gxic02LijnRx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 11, 2013 at 06:06:59PM +0200, Daniel Mack wrote:
> The widgets are names "AINA" and "AINB", which is also what the
> datasheets calls the terminals. Fix the routing table to match these
> names.

Oh, now I see this...  sorry.

--g/2gxic02LijnRx4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSB8zZAAoJELSic+t+oim9L+8P/1ahbg53xmp3pzpz/obfM9qA
mRWFZj8fLmm0Dp4+KXBT1AwwLATv5LXG+9sitGLj1Zjl0MGR1nI0R8AsX0Yoh1K6
Z0SUsjzD6gmDPwYTaE4HCaTEEH695HOeVBwFogAkx14eu3Tsj9xpbQ06ekmQaCGH
TqApZONZHRrlyBlKkn+a58ybU2TxjQBjf1EaC2R8IeegKBo8Y2Ux4WLAOcZIAX0a
nuj06dYQKBK6hZ35aVp6rSDtLu9lh+RIx3qeqHeQ012AngELyf1gl/JZjnoc6P/t
i0ouU6tQ9r1oWECHNQ7vOF3WSX6rjM5cWPVep0aDrCOjwp1x5hBKXzscNAMJMpw6
OJ8Ap7HAcd0OHlwek31PE0aQBTKP6f1epPQbVj3dLkKF/N3IF4DuT8nz0LTJ+ywJ
tJgwq6oZiDuCZTydjGNNf1BQrgwJ1m+a9Ry+NyVZRE118RBFQzna94pbcI+zHWJY
ZwqIco9jzv4FKhoaWIGIjr+BMzV6GTi+FU3cOUgaKFhgaUmzFEfF9XyGgGsZlIv+
oe3HQ2ZwWBl0h1Ng14r1WeB/qivsly1R9B6mfMlt3dsSmy8RTr3Ly/JLvzXD1Prd
LylcIpYjxeBJQIxrXEW4Q5tiZzSxan2GIqiSiFLXWSJxTXM7/l2eO+qheqrY6jla
T6O/creSdcXaX1bbmgQn
=S2yz
-----END PGP SIGNATURE-----

--g/2gxic02LijnRx4--

--===============2516899621115914986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2516899621115914986==--
