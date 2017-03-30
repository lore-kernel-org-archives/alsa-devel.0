From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.11
Date: Thu, 30 Mar 2017 18:56:33 +0100
Message-ID: <20170330175633.wylkmyn5omb2s7hp@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3624708468697033015=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D01266829
 for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2017 19:56:42 +0200 (CEST)
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


--===============3624708468697033015==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5t7nfpd2fh47ncg"
Content-Disposition: inline


--t5t7nfpd2fh47ncg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-fix-v4.11-rc4

for you to fetch changes up to 2ddaa6762696db4bb35726063b421782a9e0436f:

  Merge remote-tracking branches 'asoc/fix/rt5665', 'asoc/fix/simple', 'aso=
c/fix/sti' and 'asoc/fix/sun8i' into asoc-linus (2017-03-29 12:55:08 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.11

A relatively large pile of fixes for mainline, the first since the merge
window.  The biggest block of changes here by volume is the sun8i-codec
set, the driver was newly added in the merge window but it was realized
that renaming some of the user visible controls was required so these
are being pushed for v4.11 to avoid the original code appearing in a
release.  Otherwise it's all fairly standard bugfix stuff.

----------------------------------------------------------------
Arnaud Pouliquen (1):
      ASoC: STI: Fix reader substream pointer set

Arnd Bergmann (1):
      ASoC: mediatek: add I2C dependency for CS42XX8

Bard Liao (6):
      ASoC: rt5665: fix getting wrong work handler container
      ASoC: rt5665: increase LDO level
      ASoC: rt5665: Vref3 is necessary for Mono Amp
      ASoC: rt5665: CLKDET is also a power of ASRC
      ASoC: rt5665: fix define of RT5665_HP_DRIVER_5X
      ASoC: rt5665: fix wrong shift rt5665_if2_1_adc_in_enum

Brian Norris (1):
      ASoC: don't dereference NULL pcm_{new,free}

Charles Keepax (2):
      ASoC: wm_adsp: Return an error on write to a disabled volatile control
      ASoC: wm_adsp: Acknowledge controls should also check the DSP is runn=
ing

Hiroyuki Yokoyama (1):
      ASoC: rsnd: fix sound route path when using SRC6/SRC9

Jeeja KP (2):
      ASoC: hdac_hdmi: avoid reference to invalid variable of the pin list
      ASoC: hdac_hdmi: don't update the iterator in pcm list remove

Kuninori Morimoto (3):
      ASoC: rcar: avoid SSI_MODEx settings for SSI8
      ASoC: rcar: clear DE bit only in PDMACHCR when it stops
      ASoC: rcar: dma: remove unnecessary "volatile"

Lucas Stach (1):
      ASoC: simple-card: fix simple_dai clk lookup

Mark Brown (4):
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/adsp', 'asoc/fix/atmel', 'as=
oc/fix/hdac-hdmi' and 'asoc/fix/mtk' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5665', 'asoc/fix/simple', =
'asoc/fix/sti' and 'asoc/fix/sun8i' into asoc-linus

Myl=E8ne Josserand (5):
      ASoC: sun8i-codec: Remove analog "HP" widget
      ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE
      ASoC: sun8i-codec: Fix space on audio-routing widget
      ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN
      ARM: dts: sun8i: Update audio-routing with renamed widgets

Songjun Wu (1):
      ASoC: atmel-classd: fix audio clock rate

Takashi Sakamoto (1):
      ASoC: Intel: Skylake: fix invalid memory access due to wrong referenc=
e of pointer

 arch/arm/boot/dts/sun8i-a33.dtsi       |  4 +-
 sound/soc/atmel/atmel-classd.c         |  2 +-
 sound/soc/codecs/hdac_hdmi.c           | 16 ++++----
 sound/soc/codecs/rt5665.c              | 10 +++--
 sound/soc/codecs/rt5665.h              |  2 +-
 sound/soc/codecs/wm_adsp.c             |  9 ++++-
 sound/soc/generic/simple-card-utils.c  |  1 +
 sound/soc/intel/skylake/skl-topology.c |  2 +-
 sound/soc/mediatek/Kconfig             |  2 +-
 sound/soc/sh/rcar/cmd.c                | 36 ++++++++++--------
 sound/soc/sh/rcar/dma.c                | 18 ++++++++-
 sound/soc/sh/rcar/ssiu.c               |  6 ++-
 sound/soc/soc-core.c                   |  8 +++-
 sound/soc/sti/uniperif_reader.c        |  3 ++
 sound/soc/sunxi/sun8i-codec.c          | 67 +++++++++++++++---------------=
----
 15 files changed, 109 insertions(+), 77 deletions(-)

--t5t7nfpd2fh47ncg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljdRtAACgkQJNaLcl1U
h9AoAgf/auBYsCNwRsFBODcJH7gHEBzuNcr7ihRngdV8qAT2rdBZZQBpfJAHYFsf
w0EdrsZiAUUtZ0HD1p23fed4UMIjQYLMdBIPYZLExWD84ZszAvEelZwo/4/QDVjo
5aZXaMrPY7r1VWvR/yKYmC2QyCLaD2jkCq8KGn5h9+8YB8p1NXQVfhmZcCNp7xXJ
CnoDN2/NoBafV97lsTdZ77kcrJj3m3fOWakzbyz6O8PQD0zsJvOPJmy5H06lzWiT
b4Pn0n/SJ+IZcajaENxfNpu/kc7cLMFJfymhTprhCh3Mus0X4v4ZZJAy4K2KJwTj
b2Ev/5Tbq4yPo+eBbOqu0vrDWfJFpw==
=BVFo
-----END PGP SIGNATURE-----

--t5t7nfpd2fh47ncg--

--===============3624708468697033015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3624708468697033015==--
