From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.5
Date: Fri, 29 Jun 2012 02:50:00 +0100
Message-ID: <20120629014959.GN28922@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7278916615542059005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE7E610BA04
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 03:50:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7278916615542059005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U6leaJ20qZQc29iB"
Content-Disposition: inline


--U6leaJ20qZQc29iB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 3419ae781f1592b3d367107db6500090495490cd:

  ASoC: tegra+wm8903: turn of mic detect when card is removed (2012-06-12 1=
1:38:48 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.5

for you to fetch changes up to 5e531fc87875fc0bbfb3ca46a8a178674c4e9b7c:

  ASoC: tlv320aic3x: Fix codec pll configure bug (2012-06-27 12:46:25 +0100)

----------------------------------------------------------------
ASoC: Updates for 3.5

A couple of unexciting driver specific changes plus a fix for gain
controls used as DAPM controls which isn't yet needed in mainline but is
a definite bug.

----------------------------------------------------------------
Beno=EEt Th=E9baudeau (1):
      ASoC: dapm: Fix snd_soc_dapm_put_volsw() connect

Hebbar, Gururaja (1):
      ASoC: tlv320aic3x: Fix codec pll configure bug

Mark Brown (1):
      ASoC: wm2200: Add missing BCLK rate

 sound/soc/codecs/tlv320aic3x.c |    4 +---
 sound/soc/codecs/tlv320aic3x.h |    1 +
 sound/soc/codecs/wm2200.c      |    1 +
 sound/soc/soc-dapm.c           |    8 +-------
 4 files changed, 4 insertions(+), 10 deletions(-)

--U6leaJ20qZQc29iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7Qm+AAoJEBus8iNuMP3dmDYP/2QPTBxGnTs82FI3W9TXXIF/
4B1DpwWIvJzHLOOrBJYJql6z0aajytuvLps/3t04CEXS96pEPhngpq9n+PW26DeR
1OQ/U+0q2ZEOj2dq5N7jxnuj3tlhqMYSRGF0h2kAEy1TQNVhQfqvo0hFtmM26owp
MFXbMOH7fHgXPKdU+rDIs2saGh8uuUo58/lXG1rHM3jRicyq+/SdV0Dx88sScYUj
pw5MxcHrkIgu7P8FhvOWmR2ZX9MaeJjPz1fCCY7tUmCSmLuNPUrZSSxeNrHpN87j
zGahHK/lXBEd5/tFJDYaJKCA53iQsYPxVDGHBpzESIQM8zOz2J6VbPpz9Jhvye6K
SrV3ZqkuvRWtsYZCnha4Lg1JcJU7gIbUEQDypE9tohs9HEvYs5M17l+GP5PLBTxH
6i9XCtu/snnoA7xdcLP2lXAYcaYqUa34Jz9e2VAFzjc7aw6DLkE+K0PzX5wJVV4V
7XE95tJ82ZSczqVlgkKcsnxX1jpzLMeVqiSlgGQWAdkt7EWHRosT0sxlBaoXtzvj
CSMCGxvH4hg7N1yln6obb+kHIfnDoVrYmiAUcuLuq/nAGGmM16iVKYyoW1knQbKE
hs00iMrffuGU5p/YJY7R1iCnXCqKfuoCln6alxiDPsZOxl4s7TSP6kBebNaDYKGn
GKxcfe5JYZHa3ZJ4fb6G
=B4Zq
-----END PGP SIGNATURE-----

--U6leaJ20qZQc29iB--

--===============7278916615542059005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7278916615542059005==--
