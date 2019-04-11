From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v5.1
Date: Thu, 11 Apr 2019 12:09:52 +0100
Message-ID: <20190411110952.GD7953@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7959810048776428884=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F5E2F89616
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 13:09:54 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7959810048776428884==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.1-rc4

for you to fetch changes up to ac71317e6be01812cc0c54d8be6d3c1139c8380b:

  ASoC: wcd9335: Fix missing regmap requirement (2019-04-10 17:07:59 +0100)

----------------------------------------------------------------
ASoC: Fixes for v5.1

A few core fixes along with the driver specific ones, mainly fixing
small issues that only affect x86 platforms for various reasons (their
unusual machine enumeration mechanisms mainly, plus a fix for error
handling in topology).

There's some of the driver fixes that look larger than they are, like
the hdmi-codec changes which resulted in an indentation change, and most
of the other large changes are for new drivers like the STM32 changes.

----------------------------------------------------------------
Annaliese McDermond (2):
      ASoC: tlv320aic32x4: Fix Common Pins
      ASoC: tlv320aic32x4: Change author's name

Arnaud Pouliquen (1):
      ASoC: stm32: fix sai driver name initialisation

Charles Keepax (6):
      ASoC: wm_adsp: Correct handling of compressed streams that restart
      ASoC: wm_adsp: Correct error messages in wm_adsp_buffer_get_error
      ASoC: wm_adsp: Add locking to wm_adsp2_bus_error
      ASoC: wm_adsp: Shutdown any compressed streams on DSP watchdog timeout
      ASoC: wm_adsp: Check for buffer in trigger stop
      ASoC: cs35l35: Disable regulators on driver removal

Daniel Mack (1):
      ASoC: cs4270: Set auto-increment bit for register writes

Guenter Roeck (1):
      ASoC: intel: Fix crash at suspend/resume after failed codec registration

Gustavo A. R. Silva (1):
      ASoC: ab8500: Mark expected switch fall-through

Hans de Goede (1):
      ASoC: Intel: cht_bsw_max98090_ti: Enable codec clock once and keep it enabled

Jenny TC (1):
      ASoC: Intel: Skylake: enable S24_LE format support

Jerome Brunet (1):
      ASoC: dpcm: skip missing substream while applying symmetry

Jiada Wang (2):
      ASoC: rsnd: src: Avoid a potential deadlock
      ASoC: rsnd: src: fix compiler warnings

John Hsu (2):
      ASoC: nau8824: fix the issue of the widget with prefix name
      ASoC: nau8810: fix the issue of widget with prefixed name

Jonathan Hunter (1):
      ASoC: soc-core: Fix probe deferral following prelink failure

KaiChieh Chuang (2):
      ASoC: mediatek: btcvsd add loopback
      ASoC: dpcm: prevent snd_soc_dpcm use after free

Kuninori Morimoto (2):
      ASoC: audio-graph-card: don't select DPCM via audio-graph-card
      ASoC: simple-card: don't select DPCM via simple-audio-card

Marc Gonzalez (1):
      ASoC: wcd9335: Fix missing regmap requirement

Mark Brown (2):
      Merge branch 'for-5.0' of https://git.kernel.org/.../broonie/sound into asoc-5.1
      Merge tag 'v5.1-rc1' into asoc-5.1

Olivier Moysan (9):
      ASoC: stm32: sai: fix iec958 controls indexation
      ASoC: stm32: sai: fix exposed capabilities in spdif mode
      ASoC: stm32: sai: fix race condition in irq handler
      ASoC: stm32: sai: fix oversampling mode
      ASoC: stm32: sai: fix set_sync service
      ASoC: stm32: i2s: fix registers declaration in regmap
      ASoC: stm32: dfsdm: manage multiple prepare
      ASoC: stm32: dfsdm: fix debugfs warnings on entry creation
      ASoC: stm32: sai: fix master clock management

Pankaj Bharadiya (1):
      ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol

Philipp Puschmann (1):
      ASoC: tlv320aic3x: fix reset gpio reference counting

Rander Wang (3):
      ASoC:soc-pcm:fix a codec fixup issue in TDM case
      ASoC:hdac_hda:use correct format to setup hda codec
      ASoC:intel:skl:fix a simultaneous playback & capture issue on hda platform

Ranjani Sridharan (6):
      ASoC: dapm: set power_check callback for widgets that shouldnt be always on
      ASoC: intel: skylake: add remove() callback for component driver
      ASoC: topology: Use the correct dobj to free enum control values and texts
      ASoC: core: conditionally increase module refcount on component open
      ASoC: pcm: update module refcount if module_get_upon_open is set
      ASoC: pcm: fix error handling when try_module_get() fails.

Russell King (2):
      ASoC: hdmi-codec: fix S/PDIF DAI
      ASoC: hdmi-codec: avoid limiting params->msbits in hw_params()

S.j. Wang (2):
      ASoC: fsl_asrc: add constraint for the asrc of older version
      ASoC: fsl_esai: fix channel swap issue when stream starts

Shuming Fan (3):
      ASoC: rt5682: Check JD status when system resume
      ASoC: rt5682: fix jack type detection issue
      ASoC: rt5682: recording has no sound after booting

Sugar Zhang (2):
      ASoC: rockchip: pdm: fix regmap_ops hang issue
      ASoC: rockchip: pdm: change dma burst to 8

Sylwester Nawrocki (2):
      ASoC: samsung: i2s: Fix DAPM routes for capture stream
      ASoC: samsung: odroid: Fix clock configuration for 44100 sample rate

Tzung-Bi Shih (2):
      ASoC: mediatek: mt8183: skip for i2s5 in mck_disable
      ASoC: Intel: kbl: fix wrong number of channels

 include/sound/soc.h                                |  11 +-
 sound/soc/codecs/Kconfig                           |   1 +
 sound/soc/codecs/ab8500-codec.c                    |   1 +
 sound/soc/codecs/cs35l35.c                         |  11 ++
 sound/soc/codecs/cs4270.c                          |   1 +
 sound/soc/codecs/hdac_hda.c                        |  53 ++++++---
 sound/soc/codecs/hdac_hda.h                        |   1 +
 sound/soc/codecs/hdmi-codec.c                      | 121 ++++++++++-----------
 sound/soc/codecs/nau8810.c                         |   4 +-
 sound/soc/codecs/nau8824.c                         |  46 ++++++--
 sound/soc/codecs/rt5682.c                          |  56 +++++-----
 sound/soc/codecs/tlv320aic32x4-i2c.c               |   4 +-
 sound/soc/codecs/tlv320aic32x4-spi.c               |   4 +-
 sound/soc/codecs/tlv320aic32x4.c                   |   2 +
 sound/soc/codecs/tlv320aic3x.c                     |   4 +-
 sound/soc/codecs/wm_adsp.c                         |  40 +++++--
 sound/soc/codecs/wm_adsp.h                         |   1 +
 sound/soc/fsl/fsl_asrc.c                           |  14 +++
 sound/soc/fsl/fsl_esai.c                           |  47 ++++++--
 sound/soc/generic/audio-graph-card.c               |  11 +-
 sound/soc/generic/simple-card.c                    |  12 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   8 ++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |  47 +++++++-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   2 +-
 sound/soc/intel/skylake/skl-messages.c             |   1 +
 sound/soc/intel/skylake/skl-pcm.c                  |  28 ++++-
 sound/soc/mediatek/common/mtk-btcvsd.c             |  69 +++++++++++-
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c         |   4 +
 sound/soc/rockchip/rockchip_pdm.c                  |   4 +-
 sound/soc/samsung/i2s.c                            |  10 +-
 sound/soc/samsung/odroid.c                         |   4 +-
 sound/soc/sh/rcar/core.c                           |   2 +
 sound/soc/sh/rcar/rsnd.h                           |   5 +
 sound/soc/sh/rcar/src.c                            |  21 ++--
 sound/soc/soc-core.c                               |   6 +-
 sound/soc/soc-dapm.c                               |  11 ++
 sound/soc/soc-pcm.c                                |  66 +++++++++--
 sound/soc/soc-topology.c                           |   7 +-
 sound/soc/stm/stm32_adfsdm.c                       |  38 ++++++-
 sound/soc/stm/stm32_i2s.c                          |   3 +-
 sound/soc/stm/stm32_sai.c                          |   8 +-
 sound/soc/stm/stm32_sai_sub.c                      | 114 ++++++++++++++-----
 42 files changed, 668 insertions(+), 235 deletions(-)

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyvIH8ACgkQJNaLcl1U
h9Cy5wf/eDRkSYyuMDJstboOrWgQ4WYwe7VvFaIS6yVcwtx05THBVsOM40gX8ke3
UIKOQsZRyHIb4OVIlef+M9kzM1qIHSHg6bbpaqqNzNV2YzEyxIoHQJWZTDxda4/A
cB5MtLwm7POdejCVR1fbhuTIw75awK/yGslc+EXRhV8ggBFG4lzsS0Tk69saP4MV
eMRvLWETNPd6ZY84HEKknpEORSoHH4ziavc0DwY4N36XxZY7g1QX/bb1l8M4YIgZ
z0L2AEzP4HW/Uvxa/4RfhhxZWy1+qDgYeCsH97eeLALXFUYxphraqxAF2732LEo5
luaK5JjdT2/EK4Pt5RG8oLTrIrR5iw==
=bBGy
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--

--===============7959810048776428884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7959810048776428884==--
