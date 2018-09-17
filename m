From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.19
Date: Mon, 17 Sep 2018 17:38:30 +0100
Message-ID: <20180917163830.GB2471@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1507677190933914148=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 25B6E267819
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 18:38:34 +0200 (CEST)
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


--===============1507677190933914148==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit f2cf0ef7c0ce141bb38f315c34c56e6ef5667a27:

  ASoC: adav80x: mark expected switch fall-through (2018-08-09 14:41:50 +01=
00)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v4.19-rc4

for you to fetch changes up to 75383f8d39d4c0fb96083dd460b7b139fbdac492:

  sound: don't call skl_init_chip() to reset intel skl soc (2018-09-12 11:2=
2:09 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.19

This is the usual set of small fixes scatterd around various drivers,
plus one fix for DAPM and a UAPI build fix.  There's not a huge amount
that stands out here relative to anything else.

----------------------------------------------------------------
Akshu Agrawal (1):
      ASoC: AMD: Ensure reset bit is cleared before configuring

Andrew F. Davis (1):
      ASoC: tas6424: Save last fault register even when clear

Charles Keepax (1):
      ASoC: dapm: Fix NULL pointer deference on CODEC to CODEC DAIs

Danny Smith (1):
      ASoC: sigmadsp: safeload should not have lower byte limit

Dmitry V. Levin (1):
      ASoC: uapi: fix sound/skl-tplg-interface.h userspace compilation erro=
rs

Hans de Goede (1):
      ASoC: Intel: bytcr_rt5640: Add quirks for 2 more devices

Jiada Wang (1):
      ASoC: rsnd: fixup not to call clk_get/set under non-atomic

Katsuhiro Suzuki (1):
      ASoC: uniphier: change status to orphan

Kuninori Morimoto (2):
      ASoC: rsnd: adg: care clock-frequency size
      ASoC: rsnd: don't fallback to PIO mode when -EPROBE_DEFER

Marcel Ziswiler (1):
      ASoC: wm9712: fix replace codec to component

Oder Chiou (1):
      ASoC: rt5514: Fix the issue of the delay volume applied again

Pierre-Louis Bossart (1):
      ASoC: wm8804: Add ACPI support

Ryan Lee (2):
      ASoC: max98373: Added speaker FS gain cotnrol register to volatile.
      ASoC: max98373: Added 10ms sleep after amp software reset

Shuming Fan (1):
      ASoC: rt5682: Change DAC/ADC volume scale

Srinivas Kandagatla (1):
      ASoC: q6routing: initialize data correctly

S=E9bastien Szymanski (1):
      ASoC: cs4265: fix MMTLR Data switch control

Yong Zhi (1):
      ASoC: Intel: Skylake: Acquire irq after RIRB allocation

Yu Zhao (3):
      Revert "ASoC: Intel: Skylake: Acquire irq after RIRB allocation"
      sound: enable interrupt after dma buffer initialization
      sound: don't call skl_init_chip() to reset intel skl soc

 MAINTAINERS                             |   3 +-
 include/sound/hdaudio.h                 |   1 +
 include/sound/soc-dapm.h                |   1 +
 include/uapi/sound/skl-tplg-interface.h | 106 ++++++++++++++++------------=
----
 sound/hda/hdac_controller.c             |  15 +++--
 sound/soc/amd/acp-pcm-dma.c             |  21 +++++++
 sound/soc/codecs/cs4265.c               |   4 +-
 sound/soc/codecs/max98373.c             |   3 +
 sound/soc/codecs/rt5514.c               |   8 +--
 sound/soc/codecs/rt5682.c               |   8 +--
 sound/soc/codecs/sigmadsp.c             |   3 +-
 sound/soc/codecs/tas6424.c              |  12 +++-
 sound/soc/codecs/wm8804-i2c.c           |  15 ++++-
 sound/soc/codecs/wm9712.c               |   2 +-
 sound/soc/intel/boards/bytcr_rt5640.c   |  26 ++++++++
 sound/soc/intel/skylake/skl.c           |   2 +-
 sound/soc/qcom/qdsp6/q6routing.c        |   4 +-
 sound/soc/sh/rcar/adg.c                 |   5 ++
 sound/soc/sh/rcar/core.c                |  21 ++++++-
 sound/soc/sh/rcar/dma.c                 |   4 ++
 sound/soc/sh/rcar/rsnd.h                |   7 +++
 sound/soc/sh/rcar/ssi.c                 |  16 +++--
 sound/soc/soc-core.c                    |   4 +-
 sound/soc/soc-dapm.c                    |   4 ++
 24 files changed, 208 insertions(+), 87 deletions(-)

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluf2IUACgkQJNaLcl1U
h9BzCwf/Uu2a/g95F/s1ic7N0nARtrn2wXSIfnQaAG5wQUX9ofGzB4YWlvTM9DbO
KkZeawwfjXe87ncZ7WmMVMy088nL1L/urTF+HeDVJ6JEm+p44e4646NkFu1QogPS
K/hD+LV1n23pEfHb8mu8tqVyu+B7R2RYdEr7BnHSfWJxl8bp4i/WCyHBrL6pS9qx
Jj7VljlG6XKLzLzibuSosJF0mCLKMm/JK7mqwJteErjUx/aiRfAEP85oSMEDhkW5
uafz7NvhFz8aXuGScVKzikCNM9trYdyLbDEbzQ91l46q6M7GP1sxqPSXDGCvBgB/
EtW4EOpyFAPLTvFJs8TnTq0fsnP9LA==
=W6+D
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

--===============1507677190933914148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1507677190933914148==--
