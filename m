From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.13
Date: Wed, 2 Aug 2017 15:54:57 +0100
Message-ID: <20170802145457.jmrncvbhqlqznrmt@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2139794213951309061=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D0235267299
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 16:55:06 +0200 (CEST)
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


--===============2139794213951309061==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oomyr2tzacwhdib3"
Content-Disposition: inline


--oomyr2tzacwhdib3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.13-rc3

for you to fetch changes up to 60668a2dcafcf8aad0860f5a5c93eb2d7438052e:

  Merge remote-tracking branches 'asoc/fix/rt5663', 'asoc/fix/rt5665', 'asoc/fix/samsung', 'asoc/fix/sgtl5000' and 'asoc/fix/sh' into asoc-linus (2017-08-01 15:17:11 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.13

Quite a few fixes here that have been sent since the merge window, the
biggest one is the fix from Tony for some confusion with the device
property API which was causing issues with the of-graph card.  This is
fixed with some changes in the graph API itself as it seemed very likely
to be error prone.

----------------------------------------------------------------
Banajit Goswami (1):
      ASoC: do not close shared backend dailink

Bard Liao (2):
      ASoC: rt5665: fix GPIO6 pin function define
      ASoC: rt5665: fix wrong register for bclk ratio control

Damien Riegel (1):
      ASoC: codecs: msm8916-analog: fix DIG_CLK_CTL_RXD3_CLK_EN define

Fabio Estevam (1):
      ASoC: sgtl5000: Use snd_soc_kcontrol_codec()

Geert Uytterhoeven (1):
      ASoC: pxa: SND_PXA2XX_SOC should depend on HAS_DMA

Gustavo A. R. Silva (1):
      ASoC: imx-ssi: add check on platform_get_irq return value

Harsha Priya N (2):
      ASoC: Intel: Enabling ASRC for RT5663 codec on kabylake platform
      ASoC: Intel: Use MCLK instead of BLCK as the sysclock for RT5514 codec on kabylake platform

Johan Hovold (2):
      ASoC: fix pcm-creation regression
      ASoC: ux500: Restore platform DAI assignments

Kuninori Morimoto (1):
      ASoC: sh: hac: add missing "int ret"

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/dpcm', 'asoc/fix/imx', 'asoc/fix/msm8916', 'asoc/fix/multi-pcm', 'asoc/fix/of-graph' and 'asoc/fix/pxa' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5663', 'asoc/fix/rt5665', 'asoc/fix/samsung', 'asoc/fix/sgtl5000' and 'asoc/fix/sh' into asoc-linus

Subhransu S. Prusty (1):
      ASoC: Intel: Skylake: Fix default dma_buffer_size

Sylwester Nawrocki (1):
      ASoC: samsung: odroid: Fix EPLL frequency values

Tony Lindgren (1):
      device property: Fix usecount for of_graph_get_port_parent()

Vinod Koul (1):
      ASoC: Intel: Skylake: Fix missing sentinels in sst_acpi_mach

oder_chiou@realtek.com (1):
      ASoC: rt5663: Update the HW default values based on the shipping version

 drivers/of/property.c                              | 17 ++++++++--
 include/sound/soc.h                                |  6 ----
 sound/soc/codecs/msm8916-wcd-analog.c              |  2 +-
 sound/soc/codecs/rt5663.c                          | 18 +++++------
 sound/soc/codecs/rt5665.c                          |  4 +--
 sound/soc/codecs/rt5665.h                          |  4 +--
 sound/soc/codecs/sgtl5000.c                        |  4 +--
 sound/soc/fsl/imx-ssi.c                            |  4 +++
 sound/soc/generic/audio-graph-card.c               | 10 +++---
 sound/soc/generic/audio-graph-scu-card.c           | 15 +++++----
 sound/soc/generic/simple-card-utils.c              |  8 ++---
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 17 +++-------
 sound/soc/intel/skylake/skl-messages.c             |  8 +++++
 sound/soc/intel/skylake/skl.c                      |  2 ++
 sound/soc/pxa/Kconfig                              |  1 +
 sound/soc/samsung/odroid.c                         |  6 ++--
 sound/soc/sh/hac.c                                 |  2 ++
 sound/soc/soc-core.c                               | 27 ++--------------
 sound/soc/soc-pcm.c                                | 36 ++++++++--------------
 sound/soc/ux500/mop500.c                           |  4 +++
 20 files changed, 92 insertions(+), 103 deletions(-)

--oomyr2tzacwhdib3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmB58AACgkQJNaLcl1U
h9BpjQf+JSQkOcqECxkKFccks77mkB3nT+yRLeECdXy1HzZ63n7II4JQnTvebOxL
RcYPsAfLLFHBY2/pvCUaQPR8+AKaLE0gu9JSZ1yss2YEkVNER8XkwaBO7g6a1qdg
HVa+oz7NASIVZauqV7L2n3EDcYzKW60MEQzDwKoDbpmkqEDKoo1z3dL/ptmIrxo/
ueXnPXWfEcv4EXHEOeclpijEOP0uNoUrP8K739ie6lfQvqvu3KvoVx5ZA1clBsUo
zf/hPFk1A+gYRXZ0J9QHggY/9ddvXA0zSuvmw+rFAuUJT69A3FUJvHz7Rda3cylo
3Mun0G0w32+zhchpKrNqfcRQqXwGEw==
=clZH
-----END PGP SIGNATURE-----

--oomyr2tzacwhdib3--

--===============2139794213951309061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2139794213951309061==--
