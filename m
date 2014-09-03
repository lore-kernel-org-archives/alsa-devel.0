From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v3.17
Date: Wed, 3 Sep 2014 15:18:54 +0100
Message-ID: <20140903141854.GN29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2520882728105603649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 115D62655F2
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 16:19:10 +0200 (CEST)
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


--===============2520882728105603649==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wm6Et8bt556AKwYA"
Content-Disposition: inline


--Wm6Et8bt556AKwYA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-v3.1=
7-rc3

for you to fetch changes up to f58f0cba15c2d0bfbc72b1eedd0a6294e8c83419:

  Merge remote-tracking branches 'asoc/fix/axi', 'asoc/fix/cs4265', 'asoc/f=
ix/da732x', 'asoc/fix/omap', 'asoc/fix/rsnd', 'asoc/fix/rt5640', 'asoc/fix/=
rt5677', 'asoc/fix/simple' and 'asoc/fix/tegra' into asoc-linus (2014-09-02=
 23:33:39 +0100)

----------------------------------------------------------------
ASoC: Fixes for v3.17

A few more driver specific fixes on top of the currently pending fixes
(which are already in your tree but not Linus').

----------------------------------------------------------------
Andreas F=E4rber (1):
      ASoC: axi: Fix ADI AXI SPDIF specification

Bard Liao (1):
      ASoC: rt5677: correct mismatch widget name

Jarkko Nikula (1):
      ASoC: rt5640: Do not allow regmap to use bulk read-write operations

Lars-Peter Clausen (2):
      ASoC: Use dev_set_name() instead of init_name
      ASoC: rcar: Use && instead of & for boolean expressions

Mark Brown (2):
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/axi', 'asoc/fix/cs4265', 'as=
oc/fix/da732x', 'asoc/fix/omap', 'asoc/fix/rsnd', 'asoc/fix/rt5640', 'asoc/=
fix/rt5677', 'asoc/fix/simple' and 'asoc/fix/tegra' into asoc-linus

Paul Handrigan (2):
      ASoC: cs4265: Fix clock rates in clock map table
      ASoC: cs4265: Fix setting of functional mode and clock divider

Peter Ujfalusi (1):
      ASoC: omap-twl4030: Fix typo in 2nd dai link's platform_name

Rasmus Villemoes (2):
      ASoC: da732x: Fix typo in include guard
      ASoC: tegra: Fix typo in include guard

Subhransu S. Prusty (1):
      ASoC: core: fix .info for SND_SOC_BYTES_TLV

Xiubo Li (1):
      ASoC: simple-card: Fix bug of wrong decrement DT node's refcount

 Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt |  2 +-
 include/sound/soc.h                                          |  2 +-
 sound/soc/codecs/cs4265.c                                    | 12 ++++++--=
----
 sound/soc/codecs/da732x.h                                    |  2 +-
 sound/soc/codecs/rt5640.c                                    |  1 +
 sound/soc/codecs/rt5677.c                                    |  8 ++++----
 sound/soc/generic/simple-card.c                              |  8 ++++++++
 sound/soc/omap/omap-twl4030.c                                |  2 +-
 sound/soc/sh/rcar/gen.c                                      |  2 +-
 sound/soc/soc-core.c                                         |  2 +-
 sound/soc/tegra/tegra_asoc_utils.h                           |  2 +-
 11 files changed, 26 insertions(+), 17 deletions(-)

--Wm6Et8bt556AKwYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUByNKAAoJELSic+t+oim9bZAP/1LZY5aKC4Rp12oJz0j4BGnX
lhoK2NrJtqaEFfD9SWrSdQRb/9hua5HHZEYaibd2Jzi1PojxjEeNS6YQV5W7VjkK
G7VDmiWBrEqR5WYuEr3ZSz4WCdOOlbHcZKLoivYMxlmquNUdC4YwSWnDdftkwxwC
hLR4x6Cs2dzdgrIRDHiGSbTWW4RbX4/+KuvsucAIUc3uyx3SIuDTu97bQDsDzt4f
x6gHifd9U7EGuuB5wv9OyfoT2Cp7E4zWo1qae9aRt4QkZ5843wTJT9hXef0RsIXr
OvnEgBqY5ksg5uGNz2qGBfODpPxhWDNNXmHYQCGS5fBVQL89pJaxZC4H878Tlfbx
XZqlNTNGujCzGymmrSC6kZLXerSHFb8WWP78aDn21FAtIudiMY2qJU6WU2juq6wv
AqloTffEvqWVljJWEkcIA7Uo3rpQPrx37gkfLOT+zVwVnIC4+1tMiyDYkY+4pOha
eOd4E/l+9w+cbkPg9GtwtpKwlFEWeu8Dzyf0jKp0EXjZdaXOfk7Pri8QG1Yl2+Jp
WwUFzaPNPDoBZ5mSXidMwzqRXubJy4bGdTCPzedsEj2AVKEBJuZ5gOp0NGQZyMFk
mFcMGFo5JmA0Mkpx+cCW5EvyOEzr4rc9FGa0pZPWD0TD3CIqyIiSb/+MFVt3F/UD
j8AbPbU3tepY+e5Zm2hi
=QsbS
-----END PGP SIGNATURE-----

--Wm6Et8bt556AKwYA--

--===============2520882728105603649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2520882728105603649==--
