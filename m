From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.19
Date: Mon, 29 Dec 2014 15:59:12 +0000
Message-ID: <20141229155912.GN17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7536863729584783145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E743F26672D
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 16:59:28 +0100 (CET)
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


--===============7536863729584783145==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDakB1N7OkbC0NTe"
Content-Disposition: inline


--KDakB1N7OkbC0NTe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v3.19-rc2

for you to fetch changes up to f2ec1d3b25776051a9205289dab12e9401d33f8a:

  Merge remote-tracking branches 'asoc/fix/dwc', 'asoc/fix/intel', 'asoc/fix/rockchip' and 'asoc/fix/rt5677' into asoc-linus (2014-12-24 12:56:32 +0000)

----------------------------------------------------------------
ASoC: Fixes for v3.19

A few fixes for v3.19, a few driver specifics and one core fix which
fixes a boot crash on OMAP if deferred probing kicks in due to
attempting to modify static data.

----------------------------------------------------------------
Andrew Jackson (2):
      ASoC: dwc: Ensure FIFOs are flushed to prevent channel swap
      ASoC: dwc: Iterate over all channels

Fang, Yang A (1):
      ASoC: rt5677: fixed rt5677_dsp_vad_put rt5677_dsp_vad_get panic

Jarkko Nikula (3):
      ASoC: Intel: Add I2C dependency to two new machines
      ASoC: Intel: Fix BYTCR firmware name
      ASoC: Intel: Fix BYTCR machine driver MODULE_ALIAS

Jianqun Xu (2):
      ASoC: rockchip: i2s: fix error defination of transmit data level
      ASoC: rockchip: i2s: fix maxburst of dma data to 4

Jie Yang (1):
      ASoC: Intel: correct the fixed free block allocation

Mark Brown (3):
      ASoC: dapm: Remove snd_soc_of_parse_audio_routing() due to deferred probe
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/dwc', 'asoc/fix/intel', 'asoc/fix/rockchip' and 'asoc/fix/rt5677' into asoc-linus

 sound/soc/codecs/rt5677.c           |  9 ++++---
 sound/soc/dwc/designware_i2s.c      | 49 +++++++++++++++++++++++--------------
 sound/soc/intel/Kconfig             |  4 +--
 sound/soc/intel/bytcr_dpcm_rt5640.c |  2 +-
 sound/soc/intel/sst-firmware.c      |  6 ++++-
 sound/soc/intel/sst/sst_acpi.c      |  2 +-
 sound/soc/rockchip/rockchip_i2s.c   |  4 +--
 sound/soc/rockchip/rockchip_i2s.h   |  2 +-
 sound/soc/soc-core.c                | 14 ++++-------
 9 files changed, 52 insertions(+), 40 deletions(-)

--KDakB1N7OkbC0NTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoXpPAAoJECTWi3JdVIfQJUkH/27Nima66p+pYnUAY9HB0Eta
OYnsFCKesGoHmft3to6Av9mhIco3gnV2wyB1NA4YOHAheKwbaz8YcKs4yRN1zCbD
xIhPsD8Ur7AmCgjTpoHG1mJX7eF4njXeMYgiYxefWjJ6O576Cen2OiMgjA2UJngB
wXy4nNkkpbaXGCigASx6yzgOv6LPDSuDtyjLMiMyFf3lQRfnSzwVaoaJH3NGYbxN
xvMx7qvqYBy4ZpBfO+bkCLjdozxpOvt2pifZ5ppztoNDCYtpOr7iqMnbu9qbO/Ax
NQd1XaJpXyAIHkYPNT4KGYivwUtzs5rYDMNrkt5UmzuDR+3LSoIjLyFxTXMqas4=
=p5f4
-----END PGP SIGNATURE-----

--KDakB1N7OkbC0NTe--

--===============7536863729584783145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7536863729584783145==--
