From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.4
Date: Thu, 24 Sep 2015 13:39:08 -0700
Message-ID: <20150924203908.GF30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0810886277353668566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 226352605CC
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 22:39:48 +0200 (CEST)
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


--===============0810886277353668566==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wUMz9o/vfMbinXcu"
Content-Disposition: inline


--wUMz9o/vfMbinXcu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.3-rc2

for you to fetch changes up to 4922e7a1b767fcf6f29ce121ad74e424f4045eff:

  Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next (2015-09-2=
3 11:01:30 -0700)

----------------------------------------------------------------
ASoC: Updates for v4.4

A first batch of updates targetted at v4.4.  There are no substantial
core fixes here, the biggest block of changes is updates to the rcar
drivers and the addition of a CODEC driver for the AK4613.

----------------------------------------------------------------
Adam Thomson (1):
      ASoC: fsl_ssi: Fix checking of dai format for AC97 mode

Anatol Pomozov (1):
      ASoC: Document snd-soc-dummy-dai purpose

Arnaud Pouliquen (1):
      ASoC: sti: check return of of_property_read

Axel Lin (11):
      ASoC: mediatek: Convert to devm_snd_soc_register_card
      ASoC: au1x: Convert to devm_snd_soc_register_card
      ASoC: blackfin: Convert to devm_snd_soc_register_card
      ASoC: mxs-sgtl5000: Convert to devm_snd_soc_register_card
      ASoC: pxa: Convert to devm_snd_soc_register_card
      ASoC: SPEAr: Make SND_SPEAR_SOC select SND_SOC_GENERIC_DMAENGINE_PCM
      ASoC: au1x: psc-i2s: Fix unused variable 'ret' warning
      ASoC: sh: siu_dai: Convert to use resource managed APIs
      ASoC: intel: broadwell: Convert to devm_snd_soc_register_card
      ASoC: SPEAr: Make SND_SPEAR_SOC select SND_SOC_GENERIC_DMAENGINE_PCM
      ASoC: rockchip: Fix missing CLKDEV_LOOKUP dependency

Charles Keepax (4):
      ASoC: arizona: Add default cases for event switches
      ASoC: arizona: Add utility function to check if an input is analog
      ASoC: Add SOC_SINGLE_RANGE_EXT_TLV macro
      ASoC: wm5110: Add additional analogue input enable for early revs

Emilio L=F3pez (1):
      ASoC: sunxi: add support for the on-chip codec on early Allwinner SoCs

Jarkko Nikula (1):
      spi: atmel: Remove needless bits_per_word and speed_hz tests

Jeeja KP (1):
      ASoC: Intel: Skylake: Remove unused CPU dais

John Lin (3):
      ASoC: rt5645: Add struct dmi_system_id "Google Ultima" for chrome pla=
tform
      ASoC: rt5645: Add dmi for Broadwell
      ASoC: rt5645: Add jd_invert for Broadwell

Julia Lawall (1):
      ASoC: qcom: change PTR_ERR argument

Jyri Sarha (7):
      ASoC: davinci-mcasp: Set .symmetric_rates =3D 1 in snd_soc_dai_driver
      ASoC: tlv320aic3x: Improve tdm support
      ASoC: davinci-mcasp: Add set_tdm_slots() support
      ASoC: simple-card: Add tdm slot mask support to simple-card
      ASoC: soc-core: Fix sparse warning in be32_to_cpup() call
      ASoC: davinci-mcasp: Get rid of bclk_lrclk_ratio in private data
      ASoC: hdmi: Remove obsolete dummy HDMI codec

Koro Chen (1):
      ASoC: mediatek: Increase periods_min in capture

Kuninori Morimoto (20):
      ASoC: ak4642: use *dev on ak4642_i2c_probe()
      ASoC: ak4642: enable to use MCKO as fixed rate output pin on DT
      ASoC: rsnd: tidyup rsnd_dma_to_xxx() position
      ASoC: rsnd: rename rsnd_src_pcm_new() to rsnd_src_pcm_new_gen2()
      ASoC: rsnd: remove unneeded sh_clk header
      ASoC: rsnd: add missing #sound-dai-cells explain on Document
      ASoC: rsnd: Add Gen3 initial support
      ASoC: rsnd: add rsnd_mod_get() macro and use it
      ASoC: rsnd: ADG uses mod base common method
      ASoC: rsnd: add common mod confirm method
      ASoC: rsnd: ADG initial setup on rsnd_adg_ssi_clk_init()
      ASoC: rsnd: tidyup ADG clock calculate method
      ASoC: rsnd: tidyup ADG debug message for clock selection
      ASoC: rsnd: adg: ignore undefined clock error
      ASoC: rsnd: add AUDIO_CLKOUT support
      ASoC: rsnd: SND_SOC_RCAR depends on COMMON_CLK
      ASoC: ak4642: exchange macro name to avoid redefinition
      ASoC: rsnd: fixup clkout_name[] index error for single AUDIO_CLKOUT S=
oC
      ASoC: add ak4613 support
      ASoC: ak4613: add Digital Playback Volume support

Liam Girdwood (1):
      ASoC: intel: Fix SSP port configuration after RTD3 resume.

Luis de Bethencourt (8):
      ASoC: atmel_wm8904: Fix module autoload for OF platform driver
      ASoC: fsl-asoc-card: Fix module autoload for OF platform driver
      ASoC: fsl_sai: Fix module autoload for OF platform driver
      ASoC: jz4740: Fix module autoload for OF platform driver
      ASoC: kirkwood: Fix module autoload for OF platform driver
      ASoC: pxa: Fix module autoload for OF platform drivers
      ASoC: mop500: Fix module autoload for OF platform driver
      ASoC: ux500: Fix module autoload for OF platform driver

Maciej S. Szmigiero (1):
      ASoC: fsl-asoc-card: put ASRC OF node in case of unknown device

Mark Brown (14):
      Merge branch 'fix/rt5645' of git://git.kernel.org/.../broonie/sound i=
nto asoc-fix-rt5645
      Merge branch 'fix/rt5645' of git://git.kernel.org/.../broonie/sound i=
nto asoc-rt5645
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/doc', 'a=
soc/fix/fsl-card', 'asoc/fix/fsl-ssi', 'asoc/fix/intel' and 'asoc/fix/maint=
ainers' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/mtk', 'asoc/fix/psc', 'asoc/=
fix/pxa', 'asoc/fix/spear', 'asoc/fix/sti' and 'asoc/fix/wm0010' into asoc-=
linus
      Merge remote-tracking branches 'asoc/fix/wm8960' and 'asoc/fix/wm8962=
' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ak4613', 'asoc/topic/ak464=
2', 'asoc/topic/arizona', 'asoc/topic/atmel' and 'asoc/topic/au1x' into aso=
c-next
      Merge remote-tracking branches 'asoc/topic/blackfin', 'asoc/topic/dav=
inci', 'asoc/topic/fsl', 'asoc/topic/hdmi' and 'asoc/topic/intel' into asoc=
-next
      Merge remote-tracking branches 'asoc/topic/jz4740', 'asoc/topic/kirkw=
ood', 'asoc/topic/mtk', 'asoc/topic/multi' and 'asoc/topic/mxs' into asoc-n=
ext
      Merge remote-tracking branches 'asoc/topic/pxa', 'asoc/topic/qcom', '=
asoc/topic/rcar' and 'asoc/topic/rockchip' into asoc-next
      Merge remote-tracking branches 'asoc/topic/sh', 'asoc/topic/simple', =
'asoc/topic/spear', 'asoc/topic/sunxi' and 'asoc/topic/tlv320aic3x' into as=
oc-next
      Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next

Maxime Ripard (1):
      ASoC: sunxi: Add the Allwinner A10 codec bindings

Oder Chiou (5):
      ASoC: rt5645: Remove incorrect settings
      ASoC: rt5645: Remove the repeated definitions
      ASoC: rt5645: Use the type SOC_DAPM_SINGLE_AUTODISABLE to prevent the=
 weird sound in runtime of power up
      ASoC: rt5645: Increase the delay time to remove the pop sound
      ASoC: rt5645: Prevent the pop sound in case of playback and the jack =
is plugging

Peter Ujfalusi (2):
      ASoC: davinci-mcasp: Revise the FIFO threshold calculation
      ASoC: davinci-mcasp: Fix devm_kasprintf format string

Ricard Wanderlof (1):
      ASoC: Handle multiple codecs with split playback / capture

Richard Fitzgerald (1):
      MAINTAINERS: Update website and git repo for Wolfson Microelectronics

Robert Jarzmik (2):
      ASoC: fix broken pxa SoC support
      ASoC: pxa: pxa2xx-ac97: fix dma requestor lines

Sudip Mukherjee (5):
      ASoC: wm0010: fix memory leak
      ASoC: dapm: fix memory leak
      ASoC: Intel: remove unused function
      ASoC: wm0010: fix memory leak
      ASoC: wm0010: fix error path

Zidan Wang (4):
      ASoC: wm8960: correct the min gain value of some PGA
      ASoC: wm8960: correct gain value for input PGA and add microphone PGA
      ASoC: wm8962: remove 64k sample rate support
      ASoC: wm8960: correct the max register value of mic boost pga

kbuild test robot (1):
      ASoC: sunxi: fix platform_no_drv_owner.cocci warnings

 Documentation/devicetree/bindings/sound/ak4613.txt |  17 +
 Documentation/devicetree/bindings/sound/ak4642.txt |  22 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   7 +
 .../devicetree/bindings/sound/sun4i-codec.txt      |  33 +
 .../devicetree/bindings/sound/tdm-slot.txt         |  11 +-
 MAINTAINERS                                        |   9 +-
 drivers/spi/spi-atmel.c                            |  21 +-
 include/sound/rcar_snd.h                           |   1 -
 include/sound/rt5645.h                             |   2 +
 include/sound/simple_card.h                        |   2 +
 include/sound/soc.h                                |  14 +
 sound/arm/Kconfig                                  |  15 +-
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/atmel/atmel_wm8904.c                     |   1 +
 sound/soc/au1x/db1000.c                            |  10 +-
 sound/soc/au1x/db1200.c                            |  10 +-
 sound/soc/au1x/psc-i2s.c                           |   1 -
 sound/soc/blackfin/bf5xx-ad1836.c                  |  11 +-
 sound/soc/blackfin/bfin-eval-adau1373.c            |  12 +-
 sound/soc/blackfin/bfin-eval-adau1701.c            |  12 +-
 sound/soc/blackfin/bfin-eval-adav80x.c             |  12 +-
 sound/soc/codecs/Kconfig                           |   9 +-
 sound/soc/codecs/Makefile                          |   4 +-
 sound/soc/codecs/ak4613.c                          | 497 ++++++++++++++
 sound/soc/codecs/ak4642.c                          | 153 +++--
 sound/soc/codecs/arizona.c                         |  16 +
 sound/soc/codecs/arizona.h                         |   2 +
 sound/soc/codecs/hdmi.c                            | 109 ----
 sound/soc/codecs/rt5645.c                          |  57 +-
 sound/soc/codecs/rt5645.h                          |   6 +-
 sound/soc/codecs/tlv320aic3x.c                     |  30 +-
 sound/soc/codecs/wm0010.c                          |  23 +-
 sound/soc/codecs/wm5110.c                          | 187 +++++-
 sound/soc/codecs/wm8960.c                          |  26 +-
 sound/soc/codecs/wm8962.c                          |   3 +-
 sound/soc/davinci/davinci-mcasp.c                  | 319 +++++----
 sound/soc/fsl/fsl-asoc-card.c                      |   4 +-
 sound/soc/fsl/fsl_sai.c                            |   1 +
 sound/soc/fsl/fsl_ssi.c                            |   5 +-
 sound/soc/generic/simple-card.c                    |   8 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |  17 -
 sound/soc/intel/boards/broadwell.c                 |   9 +-
 sound/soc/intel/haswell/sst-haswell-ipc.c          |  20 +-
 sound/soc/intel/skylake/skl-pcm.c                  |  33 -
 sound/soc/jz4740/jz4740-i2s.c                      |   1 +
 sound/soc/kirkwood/armada-370-db.c                 |   1 +
 sound/soc/mediatek/mt8173-max98090.c               |  11 +-
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  11 +-
 sound/soc/mediatek/mtk-afe-pcm.c                   |  17 +
 sound/soc/mxs/mxs-sgtl5000.c                       |   6 +-
 sound/soc/pxa/Kconfig                              |   2 -
 sound/soc/pxa/brownstone.c                         |   9 +-
 sound/soc/pxa/corgi.c                              |  11 +-
 sound/soc/pxa/e740_wm9705.c                        |   5 +-
 sound/soc/pxa/e750_wm9705.c                        |   5 +-
 sound/soc/pxa/e800_wm9712.c                        |   5 +-
 sound/soc/pxa/hx4700.c                             |   4 +-
 sound/soc/pxa/imote2.c                             |  11 +-
 sound/soc/pxa/mioa701_wm9713.c                     |  11 +-
 sound/soc/pxa/palm27x.c                            |   9 +-
 sound/soc/pxa/poodle.c                             |  11 +-
 sound/soc/pxa/pxa-ssp.c                            |   1 +
 sound/soc/pxa/pxa2xx-ac97.c                        |   4 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |   1 +
 sound/soc/pxa/spitz.c                              |   5 +-
 sound/soc/pxa/tosa.c                               |   5 +-
 sound/soc/pxa/ttc-dkb.c                            |  12 +-
 sound/soc/qcom/lpass-cpu.c                         |   3 +-
 sound/soc/rockchip/Kconfig                         |   4 +-
 sound/soc/sh/Kconfig                               |   1 +
 sound/soc/sh/rcar/adg.c                            | 303 +++++++--
 sound/soc/sh/rcar/core.c                           |  12 +
 sound/soc/sh/rcar/ctu.c                            |   6 +-
 sound/soc/sh/rcar/dvc.c                            |   6 +-
 sound/soc/sh/rcar/mix.c                            |   6 +-
 sound/soc/sh/rcar/rsnd.h                           |  15 +-
 sound/soc/sh/rcar/src.c                            |  17 +-
 sound/soc/sh/rcar/ssi.c                            |  98 +--
 sound/soc/sh/siu_dai.c                             |  85 +--
 sound/soc/soc-core.c                               |  25 +
 sound/soc/soc-dapm.c                               |   2 +-
 sound/soc/soc-pcm.c                                |  49 ++
 sound/soc/soc-utils.c                              |   9 +
 sound/soc/spear/Kconfig                            |   2 +-
 sound/soc/sti/uniperif_player.c                    |  14 +-
 sound/soc/sti/uniperif_reader.c                    |   6 +-
 sound/soc/sunxi/Kconfig                            |  11 +
 sound/soc/sunxi/Makefile                           |   2 +
 sound/soc/sunxi/sun4i-codec.c                      | 719 +++++++++++++++++=
++++
 sound/soc/ux500/mop500.c                           |   1 +
 sound/soc/ux500/ux500_msp_dai.c                    |   1 +
 92 files changed, 2484 insertions(+), 834 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4613.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt
 create mode 100644 sound/soc/codecs/ak4613.c
 delete mode 100644 sound/soc/codecs/hdmi.c
 create mode 100644 sound/soc/sunxi/Kconfig
 create mode 100644 sound/soc/sunxi/Makefile
 create mode 100644 sound/soc/sunxi/sun4i-codec.c

--wUMz9o/vfMbinXcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWBF9sAAoJECTWi3JdVIfQ8lIH/R2EoRHp8RlqvevbqMohFhiG
4fpM44f1bS9ZbNgAkxxDHxRegOAdIYmHNeixLAN8nRCuy+NMjM0t/XGBypP/GecA
Q2j9yZQ4EvtDrG81JJMb0ueJyhpMVYLp3HUPtnXllA3kTjQZEdVEk2QNxQNW0vx7
zUurB3+1cLyOJ0dKLcBnru0Ufv702DQQksBHemisV5boG1MhnocPrS/ooVvtUULV
yarijuyLTp5zZjkErrXQrGhTcafam35rqWI77Jf3m80dXFtZuMbeLu6FvTYF78Zv
15y+Ir6FXuRIE4YkHqC2dv7DsKnuZc6SnmOlj/nEldA/r0j29dfQJ3+Jk85jrN4=
=kmHS
-----END PGP SIGNATURE-----

--wUMz9o/vfMbinXcu--

--===============0810886277353668566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0810886277353668566==--
