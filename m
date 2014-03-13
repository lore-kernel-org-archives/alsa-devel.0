From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.15
Date: Thu, 13 Mar 2014 17:56:22 +0000
Message-ID: <20140313175622.GD366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6934064896132048640=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A827126537D
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 18:56:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6934064896132048640==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2kvLHdEX2DcGdqq"
Content-Disposition: inline


--G2kvLHdEX2DcGdqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e00447fafbf7daf2cd49205b97e63d9734068a4f:

  ASoC: tlv320aic31xx: Add basic codec driver implementation (2014-03-13 12:09:51 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/tlv320aic31xx-fixes

for you to fetch changes up to 9296f4da3bafa23d8b9abc5cd271a66ea8f90cd2:

  ASoC: tlv320aic31xx: Staticise non-exported symbols (2014-03-13 17:44:22 +0000)

----------------------------------------------------------------
ASoC: Fixes for tlv320aic31xx

A few fixes for issues not yet identified by the zero day tester due to
the last pull request being rushed in order to clean up the problem with
the git mismerge.

----------------------------------------------------------------
Jyri Sarha (2):
      ASoC: tlv320aic31xx: Fix unused variable warning from aic31xx_clk_off
      ASoC: tlv320aic31xx: Remove snd_soc_codec_set_cache_io() call

Mark Brown (1):
      ASoC: tlv320aic31xx: Staticise non-exported symbols

 sound/soc/codecs/tlv320aic31xx.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

--G2kvLHdEX2DcGdqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIfFDAAoJELSic+t+oim9pUYP/3f76p+f7E5dkRWCI9rj4mtP
qRQRvQwcEkKHtDpAo5L73oN/9+3pAVYJ3iGl659HDKBepwPPzcpKjL9BfjlMAPJ2
qHCTVK2U2QgPW2BarjwJ9iO1P0gJhkxSSEeQAVSOnf5EnImdcLuW29H69+ndIQJN
MdGgKTcdZ16f/eySBG708hIjm0kjvDgS+9pFjRoDf/DFiVbrVszSrBLQer3TObok
/rowhG6i7eOCyxwVogexAGZIMiReOTYdixfogqrR2PCPWcL2qUvHYMZLBCPeXLII
Ha6R+mFHxmivVZ0peNlr+N1MC5g65Ha6NX9v4WGCye+e62cxzRL41M5fEKp4UF47
ud1c4J9GrIppOIzyi82iB6LIWJOwkJ7Lu8kgl7QpCXFoA378+tUKaNuZCjt3MRJi
Lmo6O9gpKF2l6jg01AiMziqpaKWcU2/sGcBcTIYGPY4v5GeKmE24Vr0rgV/tVTw2
krBQL0iXM35enLncoyjZJx+8kQ16DGLuLVdG/ntM+G+Lqz3CtYQKsUW9GeVPW5Ly
HoZ/8uueiSx54mOyOz0WCLBp4O2ahWUKKOtQ3HnrDspuDU5WeieUVfom1zwtjEy8
X+zORb7IHXyXaLFCZXjzdjSF3hpT6kcHVPJdmCeOgb4IcpZ+uQpCFO310B7r1cGV
KOE0QIXWVaSMsQ8inxmk
=mPjE
-----END PGP SIGNATURE-----

--G2kvLHdEX2DcGdqq--

--===============6934064896132048640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6934064896132048640==--
