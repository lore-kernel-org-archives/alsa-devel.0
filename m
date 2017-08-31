From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.13
Date: Thu, 31 Aug 2017 12:51:35 +0100
Message-ID: <20170831115135.p4yzf77cy7hkdfwk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1364477981320547086=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B3AB9267217
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 13:51:37 +0200 (CEST)
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


--===============1364477981320547086==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6vmfvbsc5aq6rrln"
Content-Disposition: inline


--6vmfvbsc5aq6rrln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.13-rc7

for you to fetch changes up to 05997302b7aa56a7f4a7b9d49d0661865c17874d:

  Merge remote-tracking branch 'asoc/fix/rt5670' into asoc-fixes (2017-08-31 12:49:46 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.13

A couple of fixes, one for a regression in simple-card introduced during
the merge window that was only reported this week and another for a
regression in registration of ACPI GPIOs.

----------------------------------------------------------------
Lucas Stach (1):
      ASoC: simple_card_utils: fix fallback when "label" property isn't present

Mark Brown (1):
      Merge remote-tracking branch 'asoc/fix/rt5670' into asoc-fixes

Takashi Iwai (1):
      ASoC: rt5670: Fix GPIO headset detection regression

 sound/soc/codecs/rt5670.c               |  2 +-
 sound/soc/generic/simple-card-utils.c   |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

--6vmfvbsc5aq6rrln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn+EcACgkQJNaLcl1U
h9CBwQf8C8RVtxzNZZNbzjUgqFzbeabBjSyhbkhmxWXlClHcLDSSXLtC5iQ/pDfB
5tOymVWG+ye64lenOwbHyFXme5CXrunwLHCTIjZ5gfGfc8Kn/zcWKoTP1sHe+cl1
Mh1uEGbP8Guen79j45O9fH8Qm9FniVVCcfeMvuIiitReNqSrWFTYdzeQ7i76uqmd
C5MDvgGszLonPML1VBUhInyZNRefhZOayLu/KLl4DJt1a7UGRbsFLiLOmL2yn/5G
yvmOKMcKfUvYs1jIs5+bpDlyzh5UxmyCtuRKG5EAc3pXch8jlxR1UCc/p2iKWITd
/QbJjTzw9umqPsNUvUEl0amtXPj66g==
=EhM1
-----END PGP SIGNATURE-----

--6vmfvbsc5aq6rrln--

--===============1364477981320547086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1364477981320547086==--
