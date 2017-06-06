From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.12
Date: Tue, 6 Jun 2017 17:29:08 +0100
Message-ID: <20170606162908.nfwf5nb34ewumolk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6262578272528434792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E5A1266E84
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 18:29:20 +0200 (CEST)
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


--===============6262578272528434792==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ru6bgbxzpesrkbb2"
Content-Disposition: inline


--ru6bgbxzpesrkbb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-fix-v4.12-rc4

for you to fetch changes up to 7327a946a3b921d60d48924d34ac99eae2fae57d:

  Merge remote-tracking branch 'asoc/fix/rt286' into asoc-linus (2017-05-26 12:42:28 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.12

This is the usual collection of device specific fixes, all accumilated
since the merge window, plus one fix from Takashi for a nasty use after
free bug that bit some things with deferred probe and an update to the
maintainer address for the former Wolfson parts.

----------------------------------------------------------------
Adam Thomson (1):
      ASoC: da7213: Fix incorrect usage of bitwise '&' operator for SRM check

Charles Keepax (1):
      MAINTAINERS: Update email address for patches to Wolfson parts

Kuninori Morimoto (4):
      ASoC: rsnd: don't use PDTA bit for 24bit on SSI
      ASoC: rsnd: don't call free_irq() on Parent SSI
      ASoC: rsnd: SSI PIO adjust to 24bit mode
      ASoC: rsnd: fixup parent_clk_name of AUDIO_CLKOUTx

Mark Brown (4):
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/atmel', 'asoc/fix/cirrus', 'asoc/fix/da7213', 'asoc/fix/free' and 'asoc/fix/jack' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt286' into asoc-linus

Pardha Saradhi K (1):
      ASoC: Intel: Skylake: Fix IPC rx_list corruption

Quentin Schulz (1):
      ASoC: atmel-classd: sync regcache when resuming

Shreyas NC (1):
      ASoC: Intel: Skylake: Fix to parse consecutive string tkns in manifest

Stefan Agner (1):
      ASoC: simple-card: fix mic jack initialization

Takashi Iwai (1):
      ASoC: Fix use-after-free at card unregistration

Vinod Koul (1):
      ASoC: Intel: Skylake: Move i915 registration to worker thread

Yifeng Li (1):
      rt286: add Thinkpad Helix 2 to force_combo_jack_table

 MAINTAINERS                            |   2 +-
 sound/soc/atmel/atmel-classd.c         |   9 ++
 sound/soc/codecs/da7213.c              |   2 +-
 sound/soc/codecs/rt286.c               |   7 ++
 sound/soc/generic/simple-card.c        |   2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c  |   5 +
 sound/soc/intel/skylake/skl-topology.c |   2 +-
 sound/soc/intel/skylake/skl.c          | 162 ++++++++++++++++++---------------
 sound/soc/intel/skylake/skl.h          |   4 +-
 sound/soc/sh/rcar/adg.c                |   6 +-
 sound/soc/sh/rcar/cmd.c                |   1 +
 sound/soc/sh/rcar/core.c               |  51 +++++++++++
 sound/soc/sh/rcar/gen.c                |   1 +
 sound/soc/sh/rcar/rsnd.h               |   2 +
 sound/soc/sh/rcar/src.c                |  12 ++-
 sound/soc/sh/rcar/ssi.c                |  18 +++-
 sound/soc/sh/rcar/ssiu.c               |   3 +-
 sound/soc/soc-core.c                   |   5 +-
 18 files changed, 205 insertions(+), 89 deletions(-)

--ru6bgbxzpesrkbb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk22FMACgkQJNaLcl1U
h9AGAggAgIU193WEjf2CS1o7XllIa41vKi4R7wJhwsCwBh+YsKrvL54MkVy9MOv0
j3pxiXIzs1mMEFZeG4hz9MgpKXUjoazARfoh+7qRN73EGZLrHl/5SKSw5A1vQVho
m4aWduK3g8rJjmJXAelzzNglzn+NY/IF/cbXbbeHq82+alWFrZARgk/JHN5McEWe
N+5LljL9AUXL0cACKI1wEGJvpyKuldHF2vxxD5SRC14WXwZWSdOQmWfaJLsAXPKb
aySISebqwlFZbIAjc+KHi53lBbdoaWGwV5jXysmEt8h7MaE1xQZ3akxhgxDcsxMj
wDYreqktxB/kLl7rHnaSnjSNQ5cwmg==
=VZhY
-----END PGP SIGNATURE-----

--ru6bgbxzpesrkbb2--

--===============6262578272528434792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6262578272528434792==--
