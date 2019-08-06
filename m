From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v5.3
Date: Tue, 6 Aug 2019 11:17:07 +0100
Message-ID: <20190806101707.GA4527@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5530310094021784170=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84C73F800F3
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 12:17:09 +0200 (CEST)
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


--===============5530310094021784170==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 87a6fe80d56be85bda093c4dd8a3e6535bda7e4a:

  ASoC: SOF: Intel: implement runtime idle for CNL/APL (2019-07-06 12:23:47 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-fix-v5.3-rc3-2

for you to fetch changes up to 7c0767643f3b6b0dd2cda923ae37a18590d431cf:

  ASoC: max98373: Remove executable bits (2019-08-06 11:15:06 +0100)

----------------------------------------------------------------
ASoC: Fixes for v5.3

Incremental fix removing executable bits added in a prior patch
accidentally.

----------------------------------------------------------------
Cezary Rojewski (1):
      MAINTAINERS: Update Intel ASoC drivers maintainers

Charles Keepax (1):
      ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks

Cheng-Yi Chiang (1):
      ASoC: rockchip: Fix mono capture

Christophe JAILLET (1):
      ASoC: Intel: Fix some acpi vs apci typo in somme comments

Enric Balletbo i Serra (1):
      SoC: rockchip: rockchip_max98090: Enable MICBIAS for headset keypress detection

Hans de Goede (1):
      ASoC: Intel: bytcht_es8316: Add quirk for Irbis NB41 netbook

Joe Perches (1):
      ASoC: rt1308: Remove executable attribute from source files

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: remove misleading error trace from IRQ thread

Kirill Marinushkin (1):
      ASoC: Relocate my e-mail to .com domain zone

Kuninori Morimoto (3):
      ASoC: simple_card_utils.h: care NULL dai at asoc_simple_debug_dai()
      ASoC: simple-card-utils: care no Platform for DPCM
      ASoC: audio-graph-card: add missing const at graph_get_dai_id()

Marcus Cooper (1):
      ASoC: sun4i-i2s: Incorrect SR and WSS computation

Mark Brown (1):
      ASoC: max98373: Remove executable bits

Masahiro Yamada (1):
      ASoC: SOF: use __u32 instead of uint32_t in uapi headers

Peter Ujfalusi (2):
      ASoC: ti: davinci-mcasp: Fix clk PDIR handling for i2s master mode
      ASoC: ti: davinci-mcasp: Correct slot_width posed constraint

Ricard Wanderlof (1):
      ASoC: Fail card instantiation if DAI format setup fails

Shengjiu Wang (1):
      ASoC: cs42xx8: Fix MFREQ selection issue for async mode

Shuming Fan (1):
      ASoC: rt1011: fix DC calibration offset not applying

Stephan Gerhold (1):
      ASoC: qcom: apq8016_sbc: Fix oops with multiple DAI links

Tzung-Bi Shih (1):
      ASoC: max98357a: use mdelay for sdmode-delay

Vijendar Mukunda (2):
      ASoC: amd: acp3x: use dma_ops of parent device for acp3x dma driver
      ASoC: amd: acp3x: use dma address for acp3x dma driver

Wen Yang (6):
      ASoC: simple-card: fix an use-after-free in simple_dai_link_of_dpcm()
      ASoC: simple-card: fix an use-after-free in simple_for_each_link()
      ASoC: audio-graph-card: fix use-after-free in graph_dai_link_of_dpcm()
      ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()
      ASoC: samsung: odroid: fix an use-after-free issue for codec
      ASoC: samsung: odroid: fix a double-free issue for cpu_dai

Wenwen Wang (1):
      ASoC: dapm: fix a memory leak bug

fengchunguo (1):
      ASoC: max98373: add 88200 and 96000 sampling rate support

 MAINTAINERS                                        |   3 +-
 include/sound/simple_card_utils.h                  |   4 +
 include/uapi/sound/sof/fw.h                        |  16 +--
 include/uapi/sound/sof/header.h                    |  14 +--
 sound/soc/amd/raven/acp3x-pcm-dma.c                |  20 ++--
 sound/soc/codecs/cs42xx8.c                         | 116 +++++++++++++++++----
 sound/soc/codecs/max98357a.c                       |  25 +----
 sound/soc/codecs/max98373.c                        |   6 ++
 sound/soc/codecs/max98373.h                        |   2 +
 sound/soc/codecs/pcm3060-i2c.c                     |   4 +-
 sound/soc/codecs/pcm3060-spi.c                     |   4 +-
 sound/soc/codecs/pcm3060.c                         |   4 +-
 sound/soc/codecs/pcm3060.h                         |   2 +-
 sound/soc/codecs/rt1011.c                          |   4 +-
 sound/soc/codecs/rt1308.c                          |   0
 sound/soc/codecs/rt1308.h                          |   0
 sound/soc/generic/audio-graph-card.c               |  30 +++---
 sound/soc/generic/simple-card-utils.c              |   7 ++
 sound/soc/generic/simple-card.c                    |  26 ++---
 sound/soc/intel/boards/bytcht_es8316.c             |   8 ++
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c  |   2 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  |   2 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  |   2 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |   2 +-
 sound/soc/intel/common/soc-acpi-intel-glk-match.c  |   2 +-
 sound/soc/intel/common/soc-acpi-intel-hda-match.c  |   2 +-
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c    |   2 +-
 sound/soc/intel/common/soc-acpi-intel-icl-match.c  |   2 +-
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c  |   2 +-
 sound/soc/intel/common/soc-acpi-intel-skl-match.c  |   2 +-
 sound/soc/qcom/apq8016_sbc.c                       |  16 +--
 sound/soc/rockchip/rockchip_i2s.c                  |   5 +-
 sound/soc/rockchip/rockchip_max98090.c             |  32 ++++++
 sound/soc/samsung/odroid.c                         |   8 +-
 sound/soc/soc-core.c                               |   7 +-
 sound/soc/soc-dapm.c                               |  10 +-
 sound/soc/sof/intel/cnl.c                          |   4 +-
 sound/soc/sof/intel/hda-ipc.c                      |   4 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   4 +-
 sound/soc/ti/davinci-mcasp.c                       |  46 ++++++--
 40 files changed, 304 insertions(+), 147 deletions(-)
 mode change 100755 => 100644 sound/soc/codecs/rt1308.c
 mode change 100755 => 100644 sound/soc/codecs/rt1308.h

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1JU6IACgkQJNaLcl1U
h9BP/Af/Sx1jb7S6yZZ6zRq+1dIy45salE3OxslZPHv87S6Xm7swaFNOZgnGjIUV
d725Nnt8vigzcG8W7I+/DN3LIJeCnAozurzGD6FRBPLHTM4uSxhXhb6bVjYp1L2T
fvGu+dCieliDF82UMAM3dvkMKESL+0YGffBAIuMBmNeJiKIsLSuXj0DQD0MZUMou
WRr6ad0EhQb8zRMzbFB3DDrQrLv8Rl+vJCuQJVGLOONimPMCdELZVbpS/GimDdIc
5vSlQA6TD3+XV/Ei1GwmQMcrtgtDeQcRb1N18p27n8u+cS8GUU4xF2N2/16WOwVT
HD142TMffq7bOnp5CI81mZEoekrRjw==
=ojtk
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

--===============5530310094021784170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5530310094021784170==--
