From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm9712: Fix build due to missing
 definition of "runtime"
Date: Tue, 10 Apr 2012 22:38:10 +0100
Message-ID: <20120410213809.GV7499@opensource.wolfsonmicro.com>
References: <1334093587-18184-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2168904353059724811=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E0D0104208
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 23:38:12 +0200 (CEST)
In-Reply-To: <1334093587-18184-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2168904353059724811==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nT6ukc3bqTvTgwkF"
Content-Disposition: inline


--nT6ukc3bqTvTgwkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 06:33:07PM -0300, Fabio Estevam wrote:
> Fix the following build error:
>=20
> sound/soc/codecs/wm9712.c:482:32: error: 'runtime' undeclared (first use =
in this function)
> sound/soc/codecs/wm9712.c:499:33: error: 'runtime' undeclared (first use =
in this function)

On second thoughts looking at what the setting is being used for
applied...  the code is rather odd here, though.

In general changes like this which make no attempt to understand what
they're changing are a bad idea - don't just cut'n'paste some errors
into your changelog, explain what's gone wrong and why.  It's like when
people just initialise a variable to some random value to shut a warning
up without understanding why, the fact that the error goes away doesn't
mean that the fix is sensible.

--nT6ukc3bqTvTgwkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPhKg7AAoJEBus8iNuMP3d1u8P/0UvA8uee7YZhrpbG6Wqm3gJ
zssc4Dg8TixsYRc837lielzXdPhOAgZF6bnAaYhTS/szXz1ieNiaG3FusUy2v4DS
p9cY6ozMzfS+4pSFW0TLBn6OjYQLqhAGd32bK6Fu9zaUoSJbt8RM55VVFZnUmK6p
BWFtVCb4nRT1/xwaTbrM3CTyY9PuWhh9sdXXAIphsJuPEE5PZ3uwEzgub7Ri+H6I
FzlUwhPASjUB5G5MGfi1h5choDYTOS+wGtHR5ebbwvcdRBHS5YMCCr61JZ3VArka
6Y7saSgppZGOhslJuydW+EcfYgA6/aYTf5m5oOlb56NFs6ycP420ZaMscF/l5pUj
mkZ3PO6v7PMTvFrGDhVbeOipTxJEURKsWSRANriaxjqgnlHxrhEAIFhVjwrh5zrr
/JQwm5HzDHr4c/87fVnSdT0v/m8jcp1p+k8ImgnlF4drbUt4SWMluN/WNtGvQi3w
xJkccvLPreMbmpdZ6tLhZgwsMXFYY7qz7GALPRZc4KE72HWUPfGJs0L0OxjyEK1P
bkzL2BMPo9C3evvqoNBPXwnIUF/mRrVNPjm11ppRRhBXDTNaFscZ39yFDag+O0IV
RF9TkN5nhwInRO+OsycFh9IRvalJeTQu12wmzw3/7qOV9VH/t4CcpHd7xygV4zsw
WhaEywXD7yRZeNVRMOfy
=cF9f
-----END PGP SIGNATURE-----

--nT6ukc3bqTvTgwkF--

--===============2168904353059724811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2168904353059724811==--
