From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates for v3.15
Date: Thu, 13 Mar 2014 14:29:39 +0000
Message-ID: <20140313142939.GZ366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1188437567216977860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5671C265255
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 15:29:48 +0100 (CET)
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


--===============1188437567216977860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwSFAA0Com6UqrPP"
Content-Disposition: inline


--wwSFAA0Com6UqrPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit deeed33850c8a376addabbf971df433b2a1ba74c:

  Merge remote-tracking branches 'asoc/topic/wm8996', 'asoc/topic/wm9081' and 'asoc/topic/wm9705' into asoc-next (2014-03-12 23:05:31 +0000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.15-2

for you to fetch changes up to 56fe48976db38ed3984e0e68b71e503e8179dd89:

  Merge remote-tracking branch 'asoc/topic/tlv320aic31xx' into asoc-next (2014-03-13 14:19:54 +0000)

----------------------------------------------------------------

ASoC: Updates for v3.15

This is mostly a few additional fixes from Lars-Peter, a new driver and
cleaning up a git failure with merging the Intel branch (combined with
an xargs failure to pay attention to error codes).  The history lists a
bunch of additional commits for the branch but the content of those
commits is actually present already but not recorded in history due to
git failing.  Unfortunately xargs is used in the merge script and it
doesn't do a good job of noticing errors from the commands it invokes.

----------------------------------------------------------------
Dan Carpenter (4):
      ASoC: Intel: sst-firmware: missing curly braces (harmless)
      ASoC: intel: restore IRQs on error
      ASoC: intel: incorrect sizeof()
      ASoC: Baytrail: fix error handling in sst_byt_dsp_init()

Jarkko Nikula (15):
      ASoC: Intel: Add common SST driver loader on ACPI systems
      ASoC: Intel: Move extended fw base and size fields in struct sst_pdata
      ASoC: Intel: sst-acpi: Request firmware before SST platform driver probing
      ASoC: Intel: sst-acpi: Add support for multiple machine drivers per platform
      ASoC: Intel: Add Baytrail SST ID and Baytrail specific register bits
      ASoC: Intel: Add Intel Baytrail SST DSP support
      ASoC: Intel: Add Intel Baytrail SST DSP IPC support
      ASoC: Intel: Add Intel Baytrail SST PCM platform driver
      ASoC: Intel: Add machine driver for Baytrail SST with RT5640 codec
      ASoC: Intel: Add Baytrail SST and byt-rt5640 machine driver probing
      ASoC: Intel: Add build support for Baytrail SST
      ASoC: Intel: sst-acpi: Fix Oops in case of missing firmware
      ASoC: Intel: byt-rt5640: Update internal mic and speaker kcontrol names
      ASoC: Intel: byt-rt5640: Use init time DAI format
      ASoC: Intel: Baytrail: Fix implicit declaration of function 'memcpy_fromio'

Jyri Sarha (1):
      ASoC: tlv320aic31xx: Add basic codec driver implementation

Lars-Peter Clausen (5):
      ASoC: ams-delta: Fix compile error
      ASoC: snappercl15: Convert to table based DAPM setup
      ASoC: pxa: magician: Convert to table based DAPM and control setup
      ASoC: pxa: tosa: Convert to table based DAPM and control setup
      ASoC: s6105-ipcam: Convert to table based DAPM setup

Liam Girdwood (18):
      ASoC: Intel: Add a mfld prefix to Intel SST drivers.
      ASoC: Intel: Add Intel SST audio DSP low level shim driver.
      ASoC: Intel: Add Intel SST audio DSP Firmware loader.
      ASoC: Intel: Add trace support for generic SST IPC messages.
      ASoC: Intel: Add build support for Intel SST DSP core.
      ASoC: Intel: Add GFP_KERNEL flag to firmware DMA buffer.
      ASoC: Intel: Rename SST trace event header to be less generic.
      ASoC: Intel: Fix sparse warnings for firmware loader
      ASoC: Intel: Fix build for sst-dsp.c on PPC architecture
      ASoC: Intel: Add support for Haswell/Broadwell DSP
      ASoC: Intel: Add Haswell/Broadwell IPC
      ASoC: Intel: Add Haswell and Broadwell PCM platform driver
      ASoC: Intel: Add trace support for Haswell/Broadwell SST IPC messages.
      ASoC: Intel: Add build support for Haswell ADSP
      ASoC: Intel: Add Haswell Machine support
      ASoC: Intel: Check Haswell IPC process_reply/notification return value.
      ASoC: Intel: Use .dai_fmt for setting Haswell BE format.
      ASoC: Intel: Clean up indentation for Haswell machine driver/Kconfig

Mark Brown (26):
      MAINTAINERS: Add entry for Cirrus CODEC drivers
      ASoC: io: Remove SPI support
      Merge remote-tracking branches 'asoc/topic/ak4671', 'asoc/topic/cs42l51' and 'asoc/topic/alc5623' into asoc-io
      ASoC: io: Remove SND_SOC_I2C
      ASoC: da732x: Replace hw_read usage with snd_soc_read()
      ASoC: io: Remove hw_read() operation
      Merge branches 'topic/ad193x', 'topic/tlv320aic23', 'topic/tlv320aic32x4', 'topic/wm8991', 'fix/si476x' and 'fix/88pm860' of git://git.kernel.org/.../broonie/sound into asoc-io
      Merge branch 'topic/dapm' of git://git.kernel.org/.../broonie/sound into asoc-pxa
      Merge tag 'asoc-v3.15' into asoc-intel
      Merge tag 'asoc-v3.14-rc6' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/spear' into asoc-linus
      Merge tag 'asoc-v3.15' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cirrus' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/io' into asoc-next
      Merge remote-tracking branch 'asoc/topic/jack' into asoc-next
      Merge remote-tracking branch 'asoc/topic/kirkwood' into asoc-next
      Merge remote-tracking branch 'asoc/topic/lm4857' into asoc-next
      Merge remote-tracking branch 'asoc/topic/lm49453' into asoc-next
      Merge remote-tracking branch 'asoc/topic/maintainers' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98088' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98095' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pxa' into asoc-next
      Merge remote-tracking branch 'asoc/topic/s6000' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tlv320aic31xx' into asoc-next

Stephen Warren (1):
      ASoC: Intel: don't select RT5640 if !I2C

Takashi Iwai (4):
      ASoC: lm4857: Use SOC_ENUM_SINGLE_EXT_DECL()
      ASoC: max98088: Use SOC_*_ENUM_SINGLE_DECL()
      ASoC: max98095: Use SOC_ENUM_SINGLE_DECL()
      ASoC: lm49453: Use SOC_ENUM_SINGLE_DECL()

Thomas Petazzoni (2):
      ASoC: kirkwood: enable Kirkwood driver for mvebu platforms
      sound: ASoC: add ASoC board driver for Armada 370 DB

Xiubo Li (6):
      ASoC: io: Clean up snd_soc_codec_set_cache_io()
      ASoC: core: Set the default I/O up try regmap.
      ASoC: sgtl5000: Simplify ASoC probe code
      ASoC: codec: Simplify ASoC probe code.
      ASoC: io: New signature for snd_soc_codec_set_cache_io()
      ASoC: core: Fix check before setting default I/O up try regmap

xiangxiao (2):
      ASoC: add data field into snd_soc_jack_gpio
      ASoC: delay the initial jack detect by debounce_time

 .../bindings/sound/armada-370db-audio.txt          |   24 +
 .../devicetree/bindings/sound/mvebu-audio.txt      |    1 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   61 +
 MAINTAINERS                                        |    7 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |    8 +
 include/sound/soc.h                                |   13 +-
 sound/soc/cirrus/snappercl15.c                     |   18 +-
 sound/soc/codecs/88pm860x-codec.c                  |    3 +-
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ad193x.c                          |   10 +-
 sound/soc/codecs/adau1373.c                        |    7 -
 sound/soc/codecs/adav80x.c                         |    7 -
 sound/soc/codecs/ak4535.c                          |    9 -
 sound/soc/codecs/ak4641.c                          |    8 -
 sound/soc/codecs/ak4642.c                          |    8 -
 sound/soc/codecs/ak4671.c                          |   12 +-
 sound/soc/codecs/alc5623.c                         |    7 -
 sound/soc/codecs/alc5632.c                         |    8 -
 sound/soc/codecs/cq93vc.c                          |    3 +-
 sound/soc/codecs/cs4270.c                          |    9 -
 sound/soc/codecs/cs42l51.c                         |    6 -
 sound/soc/codecs/cs42l52.c                         |    9 +-
 sound/soc/codecs/cs42l73.c                         |   11 +-
 sound/soc/codecs/da7210.c                          |    8 -
 sound/soc/codecs/da7213.c                          |    8 -
 sound/soc/codecs/da732x.c                          |   29 +-
 sound/soc/codecs/da9055.c                          |    8 -
 sound/soc/codecs/isabelle.c                        |   16 -
 sound/soc/codecs/lm4857.c                          |    3 +-
 sound/soc/codecs/lm49453.c                         |   31 +-
 sound/soc/codecs/max9768.c                         |    5 -
 sound/soc/codecs/max98088.c                        |   45 +-
 sound/soc/codecs/max98090.c                        |    8 -
 sound/soc/codecs/max98095.c                        |   56 +-
 sound/soc/codecs/max9850.c                         |    8 -
 sound/soc/codecs/mc13783.c                         |    4 +-
 sound/soc/codecs/ml26124.c                         |   10 -
 sound/soc/codecs/rt5631.c                          |    9 -
 sound/soc/codecs/rt5640.c                          |    8 -
 sound/soc/codecs/sgtl5000.c                        |    8 -
 sound/soc/codecs/si476x.c                          |    6 +-
 sound/soc/codecs/sn95031.c                         |    2 -
 sound/soc/codecs/ssm2518.c                         |   10 -
 sound/soc/codecs/ssm2602.c                         |    7 -
 sound/soc/codecs/sta32x.c                          |   14 -
 sound/soc/codecs/sta529.c                          |   10 -
 sound/soc/codecs/tlv320aic23.c                     |    8 -
 sound/soc/codecs/tlv320aic26.c                     |    2 -
 sound/soc/codecs/tlv320aic31xx.c                   | 1295 ++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h                   |  258 ++++
 sound/soc/codecs/tlv320aic32x4.c                   |    2 -
 sound/soc/codecs/tlv320aic3x.c                     |    6 -
 sound/soc/codecs/tlv320dac33.c                     |    1 -
 sound/soc/codecs/wm2000.c                          |    2 -
 sound/soc/codecs/wm2200.c                          |    7 -
 sound/soc/codecs/wm5100.c                          |    7 -
 sound/soc/codecs/wm5102.c                          |    4 +-
 sound/soc/codecs/wm5110.c                          |    3 +-
 sound/soc/codecs/wm8350.c                          |    4 +-
 sound/soc/codecs/wm8400.c                          |    3 +-
 sound/soc/codecs/wm8510.c                          |   10 +-
 sound/soc/codecs/wm8523.c                          |    7 -
 sound/soc/codecs/wm8580.c                          |    6 -
 sound/soc/codecs/wm8711.c                          |    6 -
 sound/soc/codecs/wm8728.c                          |   11 +-
 sound/soc/codecs/wm8731.c                          |    7 -
 sound/soc/codecs/wm8737.c                          |    6 -
 sound/soc/codecs/wm8741.c                          |    6 -
 sound/soc/codecs/wm8750.c                          |    6 -
 sound/soc/codecs/wm8753.c                          |    7 -
 sound/soc/codecs/wm8770.c                          |    6 -
 sound/soc/codecs/wm8776.c                          |    6 -
 sound/soc/codecs/wm8804.c                          |    8 -
 sound/soc/codecs/wm8900.c                          |    8 +-
 sound/soc/codecs/wm8903.c                          |   10 +-
 sound/soc/codecs/wm8904.c                          |    9 -
 sound/soc/codecs/wm8940.c                          |    6 -
 sound/soc/codecs/wm8955.c                          |    8 -
 sound/soc/codecs/wm8960.c                          |    6 -
 sound/soc/codecs/wm8961.c                          |    7 -
 sound/soc/codecs/wm8962.c                          |    7 -
 sound/soc/codecs/wm8971.c                          |    6 -
 sound/soc/codecs/wm8974.c                          |    6 -
 sound/soc/codecs/wm8978.c                          |    8 +-
 sound/soc/codecs/wm8983.c                          |    6 -
 sound/soc/codecs/wm8985.c                          |    7 -
 sound/soc/codecs/wm8988.c                          |    8 -
 sound/soc/codecs/wm8990.c                          |    8 -
 sound/soc/codecs/wm8991.c                          |    8 -
 sound/soc/codecs/wm8993.c                          |    7 -
 sound/soc/codecs/wm8994.c                          |    3 +-
 sound/soc/codecs/wm8995.c                          |    7 -
 sound/soc/codecs/wm8996.c                          |   12 +-
 sound/soc/codecs/wm8997.c                          |    4 +-
 sound/soc/codecs/wm9081.c                          |   11 +-
 sound/soc/codecs/wm9090.c                          |   10 -
 sound/soc/intel/Kconfig                            |    4 +-
 sound/soc/kirkwood/Kconfig                         |   10 +-
 sound/soc/kirkwood/Makefile                        |    2 +
 sound/soc/kirkwood/armada-370-db.c                 |  120 ++
 sound/soc/kirkwood/kirkwood-i2s.c                  |    1 +
 sound/soc/omap/ams-delta.c                         |    2 +-
 sound/soc/pxa/magician.c                           |   34 +-
 sound/soc/pxa/tosa.c                               |   35 +-
 sound/soc/s6000/s6105-ipcam.c                      |   28 +-
 sound/soc/soc-core.c                               |   14 +-
 sound/soc/soc-io.c                                 |   64 +-
 sound/soc/soc-jack.c                               |    5 +-
 109 files changed, 1958 insertions(+), 795 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/armada-370db-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 create mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
 create mode 100644 sound/soc/codecs/tlv320aic31xx.c
 create mode 100644 sound/soc/codecs/tlv320aic31xx.h
 create mode 100644 sound/soc/kirkwood/armada-370-db.c

--wwSFAA0Com6UqrPP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIcDQAAoJELSic+t+oim9UwkQAJ4iDwAQ1KGyk1dCPu4aSb7b
PfZ0aovgpGsVx0lKGD0wozz8nAI6x8bpjyZ44pfyiK6lEGftMKB60rHug7xqsbWT
Z/tWDhZ7Fi4gU+Iqq0wA1Snz+QG+DKyp233fJS5l50WNHph6ca3wEv/Z6I66gM76
bSjcoqjLTqPTgzxI2aVSmjPmEbIBzLOC/1FhEObokS2BjlCRAhiNs4mavjeIDFN7
TpL1ikYRNAEdKHSgBWDkbrBtZgGXFPPMAUN3ipCdraj0bCVaOvBWdskz8xz3RB5d
lPZjL8cCDIQsEe3bKBPy8HQVOOr2RvsP/niLMSE6IvWkFX8dXk9EHFLDMOFyGi4l
lx+1cghGx77+bmZxOWpuCfTp8KA0pMCIBoU1loWIIsq8eS5NAT8ukKu4oy+tj+Gw
euHzlWN7mmDt0c9t0e+h1c7Pw2BQywueDpNpSZXJHnMfC4Rh72MKEc6L4mv1ebG5
9KERnecoLtoVzmXN9v96bJNhfKDq0dzW64HeSBkK3/pz34Pce3RTZ1Wp2Itrckwu
7iFsfb6hFLcbcpcZ+OfY5ppubXXJiayLswsK3AldIV0ohbGbaEhTfWbhs9v2144W
d1XJZtXw2UuXQhI3fkYzcSoZuf+o0C7fd0M8DX/bkxkLDE6/jkLWFHqVAhkweOT6
u9SuBClLwVN7bsmC5gEs
=mIED
-----END PGP SIGNATURE-----

--wwSFAA0Com6UqrPP--

--===============1188437567216977860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1188437567216977860==--
