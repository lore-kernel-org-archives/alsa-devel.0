From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.3
Date: Fri, 23 Oct 2015 08:48:42 +0900
Message-ID: <20151022234842.GE29919@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1478169118872554495=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E5EC266C0E
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:48:52 +0200 (CEST)
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


--===============1478169118872554495==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7379047d5585187d1288486d4627873170d0005a:

  Linux 4.3-rc6 (2015-10-18 16:08:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.3-rc6

for you to fetch changes up to f69eccc4b248ce53b1b830034babd0a795d5763c:

  Merge remote-tracking branches 'asoc/fix/rt298', 'asoc/fix/sx', 'asoc/fix/wm8904' and 'asoc/fix/wm8962' into asoc-linus (2015-10-23 08:44:14 +0900)

----------------------------------------------------------------
ASoC: Fixes for v4.3

A bunch of driver fixes plus one core fix which fixes problems with
misreporting values from _SX controls following a recent refactoring.
This had gone unnoticed as such controls are quite rare.

----------------------------------------------------------------
Bard Liao (2):
      ASoC: rt298: correct index default value
      ASoC: rt298: fix wrong setting of gpio2_en

Charles Keepax (2):
      ASoC: Add info callback for SX_TLV controls
      ASoC: wm8904: Correct number of EQ registers

Jiada Wang (1):
      ASoC: wm8962: mark cache_dirty flag after software reset in pm_resume

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-fix-rt5645
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt298', 'asoc/fix/sx', 'asoc/fix/wm8904' and 'asoc/fix/wm8962' into asoc-linus

 include/sound/soc.h       |  6 ++++--
 include/sound/wm8904.h    |  2 +-
 sound/soc/codecs/rt298.c  | 26 +++++++++++++-------------
 sound/soc/codecs/wm8962.c |  2 ++
 sound/soc/soc-ops.c       | 28 ++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 16 deletions(-)

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKXXZAAoJECTWi3JdVIfQ4fsH/jSLKr1+43c1PU4Bgq4tJQMM
DPA1mJgG2wrPsmmokiMcCYvtr9p4GBigsJvE55/nBFIXiq8g6N+27jzr8FJfG3xu
rRr1D0pJy4wDWHzEHOpGnpvwbzUohm4r75oVuJ+3aPYFJhih5DQLGt0f2228muzJ
LxS5BoOrl44CwWVjjlmxrNcWBubFGAhEpgiuD0n7/ZQwqzFtdzzzVSSjG3z7U/DG
O8vigdDJjmfXPrGucw7JUSvCNKKaU6dTMU4VnOeH+pVjow1VHNUvj+2GYtqLO2lc
v3bNdgNJnaKr6B2n7v0AgPLXltbULNEz8V6caR6wlrr6i+5oF48MiVVgGZSDNvA=
=mZqQ
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--

--===============1478169118872554495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1478169118872554495==--
