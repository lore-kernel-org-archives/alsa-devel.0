From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ab8500-codec: Revert back to regmap
Date: Mon, 1 Sep 2014 17:59:40 +0100
Message-ID: <20140901165940.GK29327@sirena.org.uk>
References: <1408954845-19022-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2604790270284461222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C338A264F53
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 18:59:59 +0200 (CEST)
In-Reply-To: <1408954845-19022-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2604790270284461222==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JUntuW47Nl+13QpX"
Content-Disposition: inline


--JUntuW47Nl+13QpX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 25, 2014 at 10:20:44AM +0200, Lars-Peter Clausen wrote:
> Commit ff795d614bfa ("ASoC: ab8500: Convert register I/O to regmap")
> initially converted the ab8500 CODEC driver to use regmap rather than

Applied, thanks.

--JUntuW47Nl+13QpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBKX4AAoJELSic+t+oim9G2wP/jYtFDFbMa0/Xu3j9ECRsCFu
9iLIFsMqJUn4OnkNzycP/W327FM4XP+G6fmfN/fli/qtuPN0KclhG8Ihpe7jTIoh
wPfI3M3TWDWMPgZ2TeKcHM+c69gPzdOs4S1UQjvU27fRXRlY9qmyayZeogRooMbj
17RTBJicr/kq/HW9PhRho1D0+OJtPxF6Phoa6rOzaBV2nlFBAG/kpnm92a2AK68j
wzTYHTJwGl82rmhcn/lCIV0ihgmfe9lWmL7Bvqmg0wN4H6vxX3zKi0DqIAG/TlX/
Shz4K5tsvZE9TZaJ7HwdbF/3doanmXdLjwFnzxFQUc4Bsp0141B5e6X340E1jaWb
4NwdmU0Xu3MugKjQ1BY3AAChwyMFJYOnVfHWNQGWf/iOr709u4awgsAaDYT9erm7
go9Clnh42YcHv9LdvDcHtPxR8IV1gOGGuGLShLsMMefTqbm2Swk8dNglRgMSrjGK
V6CDMGV723T9ltDaq1igm++k+xsU6OhS0IS4N4B/ZvOCU9Ml+QRgYrzeA29WTmtS
tTSP0Lbnq8BsROWGPSWqGmjYhq0THtzqgjgWXckLGhSIPltotzMbEcHdUgc4sJ7y
5dclb8iYPWXHB9lwfGUkwEqNzw+Kk0Tw0cZs69nl1agCKdlnnYqfJUvEHg35BzIo
cyJ9a/jgtan4mpkkYQwx
=cQxv
-----END PGP SIGNATURE-----

--JUntuW47Nl+13QpX--

--===============2604790270284461222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2604790270284461222==--
