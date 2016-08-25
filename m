From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.8
Date: Thu, 25 Aug 2016 16:52:29 +0100
Message-ID: <20160825155229.GH6635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2767796722436370193=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59693268B0A
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 18:08:38 +0200 (CEST)
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


--===============2767796722436370193==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.8-rc4

for you to fetch changes up to cfb89f2e7505c6823020a18bbdc5410284305234:

  Merge remote-tracking branches 'asoc/fix/max98371', 'asoc/fix/nau8825', 'asoc/fix/omap', 'asoc/fix/samsung', 'asoc/fix/simple' and 'asoc/fix/wm2000' into asoc-linus (2016-08-24 19:05:25 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.8

A clutch of fixes for v4.8.  These are mainly driver specific, the most
notable ones being those for OMAP which fix a series of issues that
broke boot on some platforms there when deferred probe kicked in.
There's also one core fix for an issue when unbinding a card which for
some reason had managed to not manifest until recently.

----------------------------------------------------------------
Adam Thomson (1):
      ASoC: da7213: Default to 64 BCLKs per WCLK to support all formats

Charles Keepax (3):
      ASoC: Fix leak of rtd in soc_bind_dai_link
      ASoC: wm2000: Fix return of uninitialised varible
      ASoC: compress: Fix leak of a widget list in soc_compr_open_fe

Christoph Huber (1):
      ASoC: atmel_ssc_dai: Don't unconditionally reset SSC on stream startup

Hiroyuki Yokoyama (1):
      ASoC: rsnd: Fixup SRCm_IFSVR calculate method

John Hsu (2):
      ASoC: nau8825: fix bug in playback when suspend
      ASoC: nau8825: fix static check error about semaphone control

Kuninori Morimoto (1):
      ASoC: simple-card-utils: add missing MODULE_xxx()

Mark Brown (7):
      ASoC: core: Clean up DAPM before the card debugfs
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/atmel', 'asoc/fix/compress', 'asoc/fix/da7213' and 'asoc/fix/debugfs' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/max98371', 'asoc/fix/nau8825', 'asoc/fix/omap', 'asoc/fix/samsung', 'asoc/fix/simple' and 'asoc/fix/wm2000' into asoc-linus

Nicolin Chen (1):
      ASoC: dapm: Add a dummy snd_pcm_runtime to avoid NULL pointer access

Peter Ujfalusi (3):
      ASoC: omap-mcpdm: Drop pdmclk clock handling
      ASoC: omap-abe-twl6040: Correct dmic-codec device registration
      ASoC: omap-mcpdm: Fix irq resource handling

Sylwester Nawrocki (1):
      ASoC: samsung: Fix clock handling in S3C24XX_UDA134X card

Vinod Koul (1):
      ASoC: Intel: Skylake: Check list empty while getting module info

Wei Yongjun (2):
      ASoC: Intel: Skylake: Fix error return code in skl_probe()
      ASoC: max98371: Add terminate entry for i2c_device_id tables

 .../devicetree/bindings/sound/omap-mcpdm.txt       | 10 ---
 sound/soc/atmel/atmel_ssc_dai.c                    |  5 +-
 sound/soc/codecs/da7213.c                          |  4 +-
 sound/soc/codecs/max98371.c                        |  1 +
 sound/soc/codecs/nau8825.c                         | 78 +++++++++-------------
 sound/soc/codecs/wm2000.c                          |  2 +-
 sound/soc/generic/Makefile                         |  6 +-
 sound/soc/generic/simple-card-utils.c              |  6 ++
 sound/soc/intel/skylake/skl-sst-utils.c            |  5 ++
 sound/soc/intel/skylake/skl.c                      |  4 +-
 sound/soc/omap/omap-abe-twl6040.c                  | 61 +++++++++--------
 sound/soc/omap/omap-mcpdm.c                        | 22 +-----
 sound/soc/samsung/s3c24xx_uda134x.c                |  7 +-
 sound/soc/sh/rcar/src.c                            |  6 +-
 sound/soc/soc-compress.c                           |  4 +-
 sound/soc/soc-core.c                               |  5 +-
 sound/soc/soc-dapm.c                               | 10 +++
 17 files changed, 115 insertions(+), 121 deletions(-)

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvxQ8AAoJECTWi3JdVIfQNQ0H/irC8bYNsuGWiqs+R2L0DTR9
viPYCrGsnepjaTuMUsHtTwEDawnlouBBx1QQ1EHuEkaRdaJT7+UbUkmNDGzV20hw
UVj4zaz6cHXKwMr+TbPw/0NTjZif0RGIUXw5fqbSn/2k32Gcn4xRh4iM2/hzO9bK
FX/Jv//pqmI7HNOCExQrcVd9Vtu5D/BYXyeJPi20cGqOcVq3m3UMy7Cw44GldXUn
AMUrSxHUbxeICu4OdDiK3u6oqP3Vn3ntRay9p/yrVi1/0tzf6SHT3svoDNbbi4P/
XCC8dMZlvsYVyQrRfXbmDM5e+jNRT5mNOakInjMET7J8ocToYccnYRSyhW5wiBs=
=glXE
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--

--===============2767796722436370193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2767796722436370193==--
