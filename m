From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v4.5
Date: Fri, 12 Feb 2016 00:39:04 +0000
Message-ID: <20160212003904.GE1953@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5273570397144004856=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC527265919
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 01:39:10 +0100 (CET)
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


--===============5273570397144004856==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.5-rc4

for you to fetch changes up to f11aec0d7c835c3b83e74e3fd60d2e48a850c857:

  Merge remote-tracking branches 'asoc/fix/rt5659', 'asoc/fix/sigmadsp', 'asoc/fix/simple', 'asoc/fix/wm5110' and 'asoc/fix/wm8960' into asoc-linus (2016-02-10 19:23:09 +0000)

----------------------------------------------------------------
ASoC: Fixes for v4.5

A rather large batch of fixes here, almost all in the Intel driver.
The changes that got merged in this merge window for Skylake were rather
large and as well as issues that you'd expect in a large block of new
code there were some problems created for older processors which needed
fixing up.  Things are largely settling down now hopefully.

----------------------------------------------------------------
Aaro Koskinen (1):
      ASoC: simple-card: don't fail if sysclk setting is not supported

Arnd Bergmann (2):
      ASoC: mediatek: add i2c dependency
      ASoC: rt5659: avoid unused variable warning for rt5659_acpi_match

Axel Lin (1):
      ASoC: rt5659: Fix irq leak

Bard Liao (2):
      ASoC: rt286: fix capture doesn't work at some cases
      ASoC: rt5645: fix the shift bit of IN1 boost

Dan Carpenter (1):
      ASoC: AMD: free memory on error

Dharageswari.R (1):
      ASoC: Intel: Skylake: Fix pipe memory allocation leak

Guneshwor Singh (2):
      ASoC: Intel: Skylake: Fix delay wrap condition
      ASoC: Intel: Skylake: Fix mcps freeup after module unbind failure

Jeeja KP (6):
      ASoC: Intel: Skylake: Fix return of skl_get_queue_index
      ASoC: Intel: Skylake: Fix the module state check condition
      ASoC: Intel: Skylake: Fix not to stop sink pipe in pga pmd event
      ASoC: Intel: Skylake: Fix bind of source with multiple sinks
      ASoC: Intel: Skylake: Add missing PRE/POST_PMU handlers for vmixer
      ASoC: Intel: Skylake: Fix stereo DMIC record

Jon Medhurst (Tixy) (1):
      ASoC: dwc: Ensure i2s_reg_comp{1,2} is always initialised

Lars-Peter Clausen (2):
      ASoC: imx-spdif: Fix crash on suspend
      ASoC: dapm: Don't prefix autodisable widgets twice

Maciej S. Szmigiero (1):
      ASoC: fsl_ssi: remove explicit register defaults

Mans Rullgard (1):
      ASoC: mxs-saif: fix clk_prepare() without matching clk_unprepare()

Mark Brown (7):
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel-kconfig' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/amd', 'asoc/fix/arizona', 'asoc/fix/dpcm', 'asoc/fix/dwc', 'asoc/fix/fsl' and 'asoc/fix/fsl-ssi' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/imx-spdif', 'asoc/fix/mtk', 'asoc/fix/mxs-saif', 'asoc/fix/qcom' and 'asoc/fix/rt286' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5659', 'asoc/fix/sigmadsp', 'asoc/fix/simple', 'asoc/fix/wm5110' and 'asoc/fix/wm8960' into asoc-linus

Pascal Huerst (1):
      ASoC: sigmadsp: Fix missleading return value

Pierre-Louis Bossart (2):
      ASoC: Intel: Atom: fix regression on compress DAI
      ASoC: Intel: Load the atom DPCM driver only

Richard Fitzgerald (2):
      ASoC: wm5110: Unregister compressed platform when driver is removed
      ASoC: arizona: fref must be limited in pseudo-fractional mode

Srinivas Kandagatla (1):
      ASoC: qcom: use correct device pointer in dma allocation

Stuart Henderson (2):
      ASoC: wm8960: Fix input boost mixer left/right naming
      ASoC: wm8960: Fix WM8960_SYSCLK_PLL mode

Sudip Mukherjee (1):
      ASoC: Intel: Skylake: Fix memory leak

Vinod Koul (6):
      ASoC: dpcm: fix the BE state on hw_free
      ASoC: Intel: Skylake: Fix the memory overwrite of tlv buffer
      ASoC: Intel: Skylake: Remove autosuspend delay
      ASoC: Intel: Revert "ASoC: Intel: fix ACPI probe regression with Atom DPCM driver"
      ASoC: Intel: Create independent acpi match module
      ASoC: Intel: Add module tags for common match module

Xiubo Li (1):
      ASoC: fsl: document DT compatible string "fsl,imx-audio-wm8960"

 .../devicetree/bindings/sound/fsl-asoc-card.txt    |  2 +
 sound/soc/amd/acp-pcm-dma.c                        |  1 +
 sound/soc/codecs/arizona.c                         | 43 ++++++++++++-
 sound/soc/codecs/rt286.c                           | 26 +-------
 sound/soc/codecs/rt5645.c                          |  2 +-
 sound/soc/codecs/rt5659.c                          | 31 ++++-----
 sound/soc/codecs/rt5659.h                          |  1 -
 sound/soc/codecs/sigmadsp-i2c.c                    |  5 +-
 sound/soc/codecs/wm5110.c                          |  1 +
 sound/soc/codecs/wm8960.c                          | 40 ++++++------
 sound/soc/dwc/designware_i2s.c                     |  5 +-
 sound/soc/fsl/fsl_ssi.c                            | 42 ++++++------
 sound/soc/fsl/imx-spdif.c                          |  2 -
 sound/soc/generic/simple-card.c                    |  2 +-
 sound/soc/intel/Kconfig                            | 13 +++-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |  1 +
 sound/soc/intel/boards/skl_rt286.c                 |  5 +-
 sound/soc/intel/common/Makefile                    |  9 +--
 sound/soc/intel/common/sst-acpi.c                  |  4 ++
 sound/soc/intel/common/sst-match-acpi.c            |  3 +
 sound/soc/intel/skylake/skl-messages.c             |  6 +-
 sound/soc/intel/skylake/skl-pcm.c                  |  1 +
 sound/soc/intel/skylake/skl-topology.c             | 75 +++++++++++++++-------
 sound/soc/intel/skylake/skl.c                      |  2 -
 sound/soc/mediatek/Kconfig                         |  4 +-
 sound/soc/mxs/mxs-saif.c                           | 13 +++-
 sound/soc/qcom/lpass-platform.c                    | 15 ++---
 sound/soc/soc-dapm.c                               |  8 +--
 sound/soc/soc-pcm.c                                |  3 +-
 29 files changed, 221 insertions(+), 144 deletions(-)

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWvSmmAAoJECTWi3JdVIfQ9u0H/jGRLBeIEp9jNhbfkPZNhzwZ
LHE/S5V127ClRAPnIUX2v7x9/HABKyiZ67qWfbiWm9kEPpQijfOnP9W1DF1FYVcv
/4ihDIONHJ1V5dQgG6tet6iwEZb7RMRjK5JbzcKlOie/pZ7zcnghRwR5+h29orlc
PxwdzX+z1mvozxVcd2LhqW860xLaRenlwrw49npOTtE99cvyaHe+7j6piE1J6lIS
gQwRI2jIYZToWctqc/9029Oe/TkJGK3j3DhP2+7AEbz+x3dhASq1w0YUEygNWO99
09VZpXSgYkQ2CEF7VqJeovjKKEy1ZG5Rbkd9GWfNh1oVNdmQwfoj8nBYMCaL32k=
=WIoh
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--

--===============5273570397144004856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5273570397144004856==--
