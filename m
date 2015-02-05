From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.19
Date: Thu, 5 Feb 2015 19:43:17 +0000
Message-ID: <20150205194317.GN21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7758406471225111412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D24B260558
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 20:43:22 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmial.com>
List-Id: alsa-devel@alsa-project.org


--===============7758406471225111412==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fhUoTqY4/dToCG+A"
Content-Disposition: inline


--fhUoTqY4/dToCG+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e36f014edff70fc02b3d3d79cead1d58f289332e:

  Linux 3.19-rc7 (2015-02-01 20:07:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v3.19-rc7

for you to fetch changes up to c503ca52a57cfe24f8937ca145a96ba94f6bb112:

  Merge remote-tracking branch 'asoc/fix/samsung' into asoc-linus (2015-02-05 19:36:29 +0000)

----------------------------------------------------------------
ASoC: Fixes for v3.19

A few last minute fixes for v3.19, all driver specific.  None of them
stand out particularly - it's all the standard people who are affected
will care stuff.

The Samsung fix is a DT only fix for the audio controller, it's being
merged via the ASoC tree due to process messups (the submitter sent it
at the end of a tangentally related series rather than separately to the
ARM folks) in order to make sure that it gets to people sooner.

----------------------------------------------------------------
Bo Shen (2):
      ASoC: atmel_ssc_dai: fix start event for I2S mode
      ASoC: atmel_ssc_dai: fix the setting for DSP mode

Eric Nelson (1):
      ASoC: sgtl5000: add delay before first I2C access

Filip Brozovic (1):
      ASoC: sgtl5000: Use shift mask when setting codec mode

Jarkko Nikula (1):
      ASoC: rt5640: Add RT5642 ACPI ID for Intel Baytrail

Jie Yang (2):
      ASoC: Intel: Used lock version to update shim registers
      MAINTAINERS: ASoC: add maintainer for Intel BDW/HSW ASoC driver

Manuel Lauss (1):
      ASoC: wm8731: init mutex in i2c init path

Mark Brown (7):
      Merge remote-tracking branch 'asoc/fix/atmel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5640' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/sgtl5000' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/tlv320aic3x' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8731' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/samsung' into asoc-linus

Peter Ujfalusi (1):
      ASoC: tlv320aic3x: Fix data delay configuration

Sylwester Nawrocki (1):
      ARM: dts: Fix I2S1, I2S2 compatible for exynos4 SoCs

 MAINTAINERS                       | 10 ++++++++++
 arch/arm/boot/dts/exynos4.dtsi    |  4 ++--
 sound/soc/atmel/atmel_ssc_dai.c   | 24 +++++++-----------------
 sound/soc/codecs/rt5640.c         |  1 +
 sound/soc/codecs/sgtl5000.c       | 13 ++++++++-----
 sound/soc/codecs/tlv320aic3x.c    |  2 +-
 sound/soc/codecs/wm8731.c         |  2 ++
 sound/soc/intel/sst-haswell-ipc.c |  4 ++--
 8 files changed, 33 insertions(+), 27 deletions(-)

--fhUoTqY4/dToCG+A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU08fUAAoJECTWi3JdVIfQDFYIAIGkpp4FYZAXwyUZxbfY7g0d
sL7J9pCObQ/86PWTfqsvbIKAiSXj7QMiD7I+4mMN7EhbbGV7yoj8gmWzedo2vv/g
HQ7fskxfA0FRKvkgDNMuT6iCV/T+waTMXiUuVLNROIKFJ1A1uVnwt8M7N35tJ0Fo
5zqv00BdBn7xh5wF5BnAIvD/FTj9q8pR+URXF028vP9flSCFV6KnET9lNvykzJgt
rXFk3WU1nPRhVGn0pUy/TUaPeH8wx7NvlXvSEjWxFdIpAyQy6ZCSY6d71369A3RZ
HOxCx0rGIeiHTfNu9nlKNyCIWA0Z6l6HaPQoNiMP07cPVoh7oFWasMUXDabSz3Q=
=361V
-----END PGP SIGNATURE-----

--fhUoTqY4/dToCG+A--

--===============7758406471225111412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7758406471225111412==--
