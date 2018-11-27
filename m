From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.20
Date: Tue, 27 Nov 2018 14:44:53 +0000
Message-ID: <20181127144453.GD3206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9176170556403289006=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 26FB526751A
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 15:44:54 +0100 (CET)
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


--===============9176170556403289006==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6be0f96d799f487f05eb412d362d5a1747d665c2:

  ASoC: stm32: sai: fix master clock naming (2018-10-23 10:51:45 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v4.20-rc4

for you to fetch changes up to ffdcc3638c58d55a6fa68b6e5dfd4fb4109652eb:

  ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE (201=
8-11-23 14:05:30 +0000)

----------------------------------------------------------------
ASoC: Fixes for v4.20

Lots of fixes here, the majority of which are driver specific but
there's a couple of core things and one notable driver specific one:

 - A core fix for a DAPM regression introduced during the component
   refactoring, we'd lost the code that forced a reevaluation of the
   DAPM graph after probe (which we suppress during init to save lots
   of recalcuation) and have now restored it.
 - A core fix for error handling using the newly added
   for_each_rtd_codec_dai_rollback() macro.
 - A fix for the names of widgets in the newly introduced pcm3060
   driver, merged as a fix so we don't have a release with legacy names.

----------------------------------------------------------------
Andreas Dannenberg (1):
      ASoC: pcm186x: Fix device reset-registers trigger value

Cl=E9ment P=E9ron (1):
      MAINTAINERS: add ASoC maintainers for sound dt-bindings

Hans de Goede (1):
      ASoC: intel: cht_bsw_max98090_ti: Add quirk for boards using pmc_plt_=
clk_0

Katsuhiro Suzuki (1):
      ASoC: rockchip: add missing slave_config setting for I2S

Keyon Jie (1):
      ASoC: acpi: fix: continue searching when machine is ignored

Kirill Marinushkin (1):
      ASoC: pcm3060: Rename output widgets

Kuninori Morimoto (1):
      ASoC: rsnd: fixup clock start checker

Peter Ujfalusi (4):
      ASoC: omap-abe-twl6040: Fix missing audio card caused by deferred pro=
bing
      ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
      ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CP=
U_IDLE
      ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE

Pierre-Louis Bossart (3):
      ASoC: fix oops w/ for_each_rtd_codec_dai_rollback() macro
      ASoC: Intel: Power down links before turning off display audio power
      ASoC: Intel: Skylake: fix Kconfigs, make HDaudio codec optional

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix dma-unsafe read of scratch registers

Rohit kumar (2):
      ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask
      ASoC: qcom: Set dai_link id to each dai_link

Srinivas Kandagatla (2):
      ASoC: qdsp6: q6asm-dai: Only add routing once.
      ASoC: qdsp6: q6afe-dai: Fix the dai widgets

Tzung-Bi Shih (1):
      ASoC: dapm: Recalculate audio map forcely when card instantiated

Vasily Khoruzhick (3):
      ASoC: sunxi: rename SND_SUNXI_ADDA_PR_REGMAP to SND_SUN8I_ADDA_PR_REG=
MAP
      ASoC: sun8i-codec: fix crash on module removal
      ASoC: sun8i-codec: add missing route for ADC

kbuild test robot (1):
      ASoC: stm32: sai: fix noderef.cocci warnings

 MAINTAINERS                                  |   1 +
 include/sound/soc.h                          |   2 +-
 sound/soc/codecs/hdac_hdmi.c                 |  11 +-
 sound/soc/codecs/pcm186x.h                   |   2 +-
 sound/soc/codecs/pcm3060.c                   |  12 +-
 sound/soc/codecs/wm_adsp.c                   |  37 ++---
 sound/soc/intel/Kconfig                      |  26 +++-
 sound/soc/intel/boards/Kconfig               |  24 ++--
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |  32 ++++-
 sound/soc/intel/skylake/skl.c                |  32 +++--
 sound/soc/omap/omap-abe-twl6040.c            |  67 ++++-----
 sound/soc/omap/omap-dmic.c                   |   9 ++
 sound/soc/omap/omap-mcbsp.c                  |   6 +-
 sound/soc/omap/omap-mcpdm.c                  |  43 +++++-
 sound/soc/qcom/common.c                      |   9 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c             | 208 +++++++++++++----------=
----
 sound/soc/qcom/qdsp6/q6afe.c                 |  16 +--
 sound/soc/qcom/qdsp6/q6asm-dai.c             |  33 -----
 sound/soc/qcom/qdsp6/q6routing.c             |  19 +++
 sound/soc/rockchip/rockchip_pcm.c            |   1 +
 sound/soc/sh/rcar/ssi.c                      |   2 +-
 sound/soc/soc-acpi.c                         |  10 +-
 sound/soc/soc-core.c                         |   1 +
 sound/soc/stm/stm32_sai_sub.c                |   2 +-
 sound/soc/sunxi/Kconfig                      |   2 +-
 sound/soc/sunxi/sun8i-codec.c                |  12 +-
 26 files changed, 360 insertions(+), 259 deletions(-)

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv9WGQACgkQJNaLcl1U
h9Awjgf9Gd50ZylNxqqq80SAI7MlHQPhUCtHW/W9lqYY6r4q4gPHKSKL/dkOxwSY
J5d8aTbnsCJ3ux0oi1fQXQEqVTGUvHlIhC1uV+ESUGTk2YhmxsgGk4gjvtJgHrhK
SsStNLsIcqAlADKTfgauePzibavojuGTyYN1sbpD1CSPekHR8/T1PJK2oY4xhcne
7tcM/lvgfasZLlCv/qee63yUMsj0LBcG02sJZVX2Q44wjaS2RitHBV/KnpHIIrpZ
/6HKbHno0Wg6J6yfaxjXOmgfE02v7ISxeHDc9fZCbc2kzmpMsZir5WLsC2zfaeHA
YEp5Vkcrv16fgfXDixBOUjsG6eZb5Q==
=VDIa
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--

--===============9176170556403289006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9176170556403289006==--
