From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v5.3
Date: Mon, 5 Aug 2019 14:13:27 +0100
Message-ID: <20190805131327.GF6432@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2776640357674466878=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67C7CF800F4
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 15:13:29 +0200 (CEST)
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


--===============2776640357674466878==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 87a6fe80d56be85bda093c4dd8a3e6535bda7e4a:

  ASoC: SOF: Intel: implement runtime idle for CNL/APL (2019-07-06 12:23:47 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.3-rc3

for you to fetch changes up to 30c21734d853dae99d05a5295a59b7e26ccd5135:

  ASoC: amd: acp3x: use dma address for acp3x dma driver (2019-08-02 19:04:43 +0100)

----------------------------------------------------------------
ASoC: Fixes for v5.3

A relatively large batch of mostly unremarkable fixes here, a couple of
small core fixes for fairly obscure issues, more comment/email updates
with no code impact than usual and a bunch of small driver fixes.

The support for new sample rates in the max98373 driver is a fix for the
fact that the driver declared support for those rates but would in fact
return an error if these rates were selected.

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
 mode change 100644 => 100755 sound/soc/codecs/max98373.c
 mode change 100644 => 100755 sound/soc/codecs/max98373.h
 mode change 100755 => 100644 sound/soc/codecs/rt1308.c
 mode change 100755 => 100644 sound/soc/codecs/rt1308.h

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1IK3YACgkQJNaLcl1U
h9DLWQf/WjnbEnS8y65hHVN829qpflkGNzRV0m4H3KVKvNhyOvdcO5LjMfTTEvg2
9ECkSnxfhEFWrcAuabYagA7IWCAZg7vZEGOkH6f8nDM2hP5nRJ02Eo174Xd+oKNI
KHwj/OgbVxJHjVff7f7gwBlVO0zWjiGZ5WBs0hllSxVQcOw7J1/5NdDDe7accITT
KzQfPlH9mcvIwfKU0y6EollIASGuXtZ7yO1HG81JNv8HghHP0xrpQrUL51lbQdJw
tA8Bi8SiQpDuTSizPI5efKuyC/13PWS0IdHlLLxOjgadCvtdW+o/AGwvKnXMWUOq
uUBa7hjgugwjySLooMHXS8Ny3t6jjA==
=GgZp
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--

--===============2776640357674466878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2776640357674466878==--
