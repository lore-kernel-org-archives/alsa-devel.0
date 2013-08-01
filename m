From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.11
Date: Thu, 1 Aug 2013 10:09:38 +0100
Message-ID: <20130801090938.GI9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1029114362750817470=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E901265545
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 11:09:41 +0200 (CEST)
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


--===============1029114362750817470==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rFBFcZ/S0hlkfs4N"
Content-Disposition: inline


--rFBFcZ/S0hlkfs4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.11-rc3

for you to fetch changes up to 3fef7f795fff7ccc58d55a28315ca73305515884:

  Merge remote-tracking branch 'asoc/fix/wm0010' into asoc-linus (2013-07-31 21:07:23 +0100)

----------------------------------------------------------------

ASoC: Fixes for v3.11

A fix to make sure userspace knows when control writes have caused a
change in value, fixing some UIs, plus a few few driver fixes mainly
cleaning up issues from recent refactorings on less mainstream platforms.

----------------------------------------------------------------
Dimitris Papastamos (1):
      ASoC: wm0010: Fix resource leak

Lars-Peter Clausen (2):
      ASoC: dapm: Fix return value of snd_soc_dapm_put_{volsw,enum_virt}()
      ASoC: bf5xx-ac97: Fix compile error with SND_BF5XX_HAVE_COLD_RESET

Mark Brown (4):
      ASoC: bfin-ac97: Fix prototype error following AC'97 refactoring
      Merge remote-tracking branch 'asoc/fix/blackfin' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm0010' into asoc-linus

Ralf Baechle (1):
      ASoC: au1x: Fix build

 sound/soc/au1x/ac97c.c          |  2 +-
 sound/soc/blackfin/bf5xx-ac97.c |  5 +++--
 sound/soc/blackfin/bf5xx-ac97.h |  1 -
 sound/soc/codecs/wm0010.c       | 24 ++++++++++++------------
 sound/soc/soc-dapm.c            |  5 ++---
 5 files changed, 18 insertions(+), 19 deletions(-)

--rFBFcZ/S0hlkfs4N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+iXPAAoJELSic+t+oim9NJwP/jBCBYWS46JHZe8JvqpX3//o
lIphBEs7aQip1x7WO9dxtuoI29fkuhu/4ZgdddvaRb6tCZ2CzZa5H8OPc763le2B
gmwF088qnpXqYztyUfbSDb8mWmzu7+ND/rbPsXBDR7Em1QGfcNJxd60CQa3ifXUB
Lq4BcrTh2pctXj2Bshj1rMi70QRIjFaRZ0T7x5cl5q83Rx8dZe5D2OKdTPAC5jRh
Hs7jDjLpZjxGDS6VQ3+0mCjKcKUH3DGi4lxqgYI8szVKwp8QJVysszrRAJFzRdhz
+OTXfv4++wXtCCZPsEsr59FLm8CfrYbA1ACaa6D9n6KX8G5EoiTN1KXVTgldYM8m
BT1lbAKRfFKylYje24q896vxRZIOEQMUpQTJQpydank6ytvd1TqKjR2kt7BO5t8M
BzjVSiZsBfPFzcEppneQ7xkmS7lvO2iH2MPMUMKpVhb60WhqUCBIAWnpr9Glxv5W
Cvt6o0GCuyC1k+TomSCUgnWrClyQ5dP0QRFquW4NmP3qrkvZ3m8IpvzdHKhdXyfx
mFtaaQiq1yFe8ZgQI/zV4He149Vu+O0jgslReSH9MlW3RB/E80A8WkPomathKljL
NRdILf98fweVKrXOZlef4u2soP+iiKoMWkEAEthudntn1JWZSRjmu3lAYnSqjaGp
p9LSsiB5gAnubRRKsXv9
=WjA5
-----END PGP SIGNATURE-----

--rFBFcZ/S0hlkfs4N--

--===============1029114362750817470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1029114362750817470==--
