From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.9
Date: Fri, 4 Nov 2016 12:41:13 -0600
Message-ID: <20161104184113.p6nvwvdxr4gehwbn@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2761981998606480972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC2F02674D5
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 19:41:22 +0100 (CET)
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


--===============2761981998606480972==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dpkbbobdkbll6etj"
Content-Disposition: inline


--dpkbbobdkbll6etj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.9-rc3

for you to fetch changes up to 0b203d699e08424288b5f3eab1347143dd5d1e68:

  Merge remote-tracking branch 'asoc/fix/topology-abi' into asoc-linus (2016-11-04 12:34:05 -0600)

----------------------------------------------------------------
ASoC: Fixes for v4.9

The most important fix in here is a change which removes the #error
making the topology API unusable as-is since we have recently discovered
some production uses on Chromebooks so need to acknowledge that what
we've got there now is an ABI.

There's also a very big batch of driver specific fixes here which have
kept on being delayed due to more arriving so the update is another of
these bigger than I would like ones.  There is one especially big one in
there, for the Qualcomm code which fixes simultaneous playback and
capture which was broken during the merge window.  The diff for that is
large because it moves blocks of code to different functions but it's
functionally fairly simple and if it breaks it should have been very
obvious in testing.

----------------------------------------------------------------
Arnaud Pouliquen (2):
      ASoC: sti: fix channel status update after playback start
      ASoC: sti-sas: enable fast io for regmap

Arnd Bergmann (2):
      ASoC: Intel: haswell depends on sst-firmware
      ASoC: PXA: Brownstone needs I2C

Bard Liao (1):
      ASoC: rt298: fix jack type detect error

Chen-Yu Tsai (2):
      ASoC: sun4i-codec: return error code instead of NULL when create_card fails
      ASoC: sun4i-codec: Enable bus clock after getting GPIO

Dan Carpenter (1):
      ASoC: rt5663: fix a debug statement

Jon Medhurst (Tixy) (1):
      ASoC: hdmi-codec: Fix hdmi_of_xlate_dai_name when #sound-dai-cells = <0>

Lukas Wunner (1):
      ASoC: Intel: Skylake: Always acquire runtime pm ref on unload

Marek Szyprowski (1):
      ASoC: samsung: get access to DMA engine early to defer probe properly

Mark Brown (5):
      ASoC: topology: Reenable use from userspace
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/cs4270', 'asoc/fix/da7219', 'asoc/fix/hdmi-codec', 'asoc/fix/pxa', 'asoc/fix/qcom' and 'asoc/fix/rt298' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5663', 'asoc/fix/samsung', 'asoc/fix/sti', 'asoc/fix/sti-codec', 'asoc/fix/sunxi' and 'asoc/fix/tas571x' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/topology-abi' into asoc-linus

Petr Kulhavy (4):
      ASoC: tas571x: wait 50ms after oscillator trim
      ASoC: tas571x: move mixer volume controls from TAS5711 to TAS5717
      ASoC: tas571x: extend the t_i2c time to comply with TAS5721
      ASoC: tas571x: remove improper PDN signal usage in set_bias_level

Sathyanarayana Nujella (1):
      ASoC: Intel: report JACK_LINEOUT event

Sodhi, VunnyX (1):
      ASoC: Intel: Skylake: Fix to turn off hdmi power on probe failure

Srinivas Kandagatla (2):
      ASoC: lpass-platform: Fix broken pcm data usage
      ASoC: lpass-cpu: add module licence and description

Stephen Barber (1):
      ASoC: da7219: Connect output enable register to DAIOUT

Sylwester Nawrocki (1):
      ASoC: samsung: spdif: Fix DMA filter initialization

Wei Yongjun (1):
      ASoC: Intel: Atom: add terminate entry for dmi_system_id tables

murray foster (1):
      ASoC: cs4270: fix DAPM stream name mismatch

 include/uapi/sound/asoc.h                     |   6 -
 sound/soc/codecs/cs4270.c                     |   8 +-
 sound/soc/codecs/da7219.c                     |   3 +-
 sound/soc/codecs/hdmi-codec.c                 |   7 +-
 sound/soc/codecs/rt298.c                      |   5 +
 sound/soc/codecs/rt5663.c                     |   4 +-
 sound/soc/codecs/sti-sas.c                    |   2 +-
 sound/soc/codecs/tas571x.c                    |  37 ++----
 sound/soc/intel/Kconfig                       |   3 +-
 sound/soc/intel/atom/sst/sst_acpi.c           |   1 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c |   4 +-
 sound/soc/intel/skylake/skl.c                 |   8 +-
 sound/soc/pxa/Kconfig                         |   2 +-
 sound/soc/qcom/lpass-cpu.c                    |   3 +
 sound/soc/qcom/lpass-platform.c               | 165 ++++++++++++--------------
 sound/soc/qcom/lpass.h                        |   1 -
 sound/soc/samsung/ac97.c                      |  10 +-
 sound/soc/samsung/i2s.c                       |  19 +--
 sound/soc/samsung/pcm.c                       |  19 +--
 sound/soc/samsung/s3c2412-i2s.c               |  16 +--
 sound/soc/samsung/s3c24xx-i2s.c               |  14 +--
 sound/soc/samsung/spdif.c                     |  19 ++-
 sound/soc/sti/uniperif_player.c               |   6 +-
 sound/soc/sunxi/sun4i-codec.c                 |  19 +--
 24 files changed, 188 insertions(+), 193 deletions(-)

--dpkbbobdkbll6etj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYHNZIAAoJECTWi3JdVIfQuEQH/jrA3MCgWiYVlnyO459sywYj
wnVX8bh/DjaP0M8ebFM81ZbJWJBU0JUpVCiEGqYp6J85rWM5l7dLzjUSjMUMGVJQ
ykCYdo3oOcnZLk5dLoAluAZllGx/if3hTXldCl1bBV/TuX5EgpJEQHkEZfowV4yD
aB+9fMWqQIPD2OWohugXlau02OxlOW4gSVNi2wVIO1hFx57ckbfmS5hJFDUkrvD6
oZTY8X9L9xWc+hGT1ahzQJZ89dHC+L/4ljB1EeJMfV/Tj5uGaVRc1RDM9uK38TEp
QlAuYmsT/nN0MPYT9ml8bgrpkD9vzPSS0dc5WI90wSpy+5aTjZ9+dqU6AxHbfP4=
=LrNI
-----END PGP SIGNATURE-----

--dpkbbobdkbll6etj--

--===============2761981998606480972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2761981998606480972==--
