From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: Move cache sync() to resume()
Date: Thu, 27 Mar 2014 11:09:55 +0000
Message-ID: <20140327110955.GH30768@sirena.org.uk>
References: <1395906947-27211-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8989726774006976119=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F1282652E3
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 12:10:20 +0100 (CET)
In-Reply-To: <1395906947-27211-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8989726774006976119==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 03:55:47PM +0800, Oder Chiou wrote:
> The patch fixes the defect in case of resume which doesn't sync the cache.

Applied, thanks.

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNAcAAAoJELSic+t+oim9bNcP/jxmsoWk7USsF+dEqj2M3JFp
rIY4zQ/K0lkKjY5VBK2KP5uKT/534wi9fFFem/cP34z+1VbCuH+TFAYWy98Y1Oc7
KQpcmPSZFvCkfcEJaBLzUvxzKVrgFcazOucyWHLvrouqZfjQj2d+CMY+zTac0K9x
yC1Qt/mE0Xrtf0462JjVnEaSYP5bFBdE1ELkNSBITtF2OxdRToQPLIkTq36TKmRh
n5lCJeUBVnNOvg3uRNCIieFn0Q4bCfyt2zJuKDU4bUth536BFyJWc2QnHDsa6BDF
xieKKXhs+fTeQByiSG3gd6xOuzoDKVVPuIqJLpkC54KMz6RkkZDJOITjvhB37Agw
jdOoXSs3d8UC1AyT27zyzuIIzEYnylIKTk3GlC2pB0BBi3WAG8uyuH3xy2Xi5aHx
dAOzfRtgF/GNTakoq9UeR/o5Oyy4Qh11LQcBrpZIO6xC2iAFIq3eV0O9rHBCfkk2
re/Mp1t5Fdfcos6KJ5GD4kCzFEsoq+fLx+tFUzvVu4F1X4ayHC18kEj3VmMf+YEm
PS9aL1FKgzYubgSLqwN9mgr/cX/RM42C5paEr2I6oPep2yN9y6BEaPH13vyfHzS4
NCg3WBVC/ZTouwH5/UGBorlUshp69lUM4OTHY0NP+OI+0C7hM0ZYA1moYB1rvWEt
Oe5QDNLrgWrYzHyoFu5V
=Mi0r
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--

--===============8989726774006976119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8989726774006976119==--
