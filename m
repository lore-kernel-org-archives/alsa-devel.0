From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.5
Date: Sun, 17 Jun 2012 21:58:56 +0100
Message-ID: <20120617205855.GX4267@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2617313166151164109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C69324482
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2012 22:58:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2617313166151164109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BtNCO5h84ExDStzY"
Content-Disposition: inline


--BtNCO5h84ExDStzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 69c5b7530651c8e375d2fbecd157a9a9a20c4cc9:

  ASoC: tegra: add MODULE_DEVICE_TABLE to tegra30_ahub (2012-06-08 08:49:30 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.5

for you to fetch changes up to 3419ae781f1592b3d367107db6500090495490cd:

  ASoC: tegra+wm8903: turn of mic detect when card is removed (2012-06-12 11:38:48 +0800)

----------------------------------------------------------------
ASoC: Updates for 3.5

All driver specific and fairly small.  The pxa-ssp changes are larger
than I'd like but they're build failures and are pretty clear to
inspection.

----------------------------------------------------------------
Mark Brown (5):
      ASoC: wm8904: Fix GPIO and MICBIAS initialisation for regmap conversion
      ASoC: wm8904: Fix cache only management
      ASoC: wm8996: Remove spurious regulator_bulk_free()
      ASoC: wm8996: Move reset before the initial regulator disable
      ASoC: wm8996: Mark the CODEC as cache only when powering off on boot

Qiao Zhou (2):
      ARM: MMP: add pxa910-ssp into ssp_id_table
      ASoC: fix pxa-ssp compiling issue under mach-mmp

Stephen Warren (1):
      ASoC: tegra+wm8903: turn of mic detect when card is removed

 arch/arm/plat-pxa/ssp.c        |    1 +
 include/linux/pxa2xx_ssp.h     |    2 ++
 include/linux/spi/pxa2xx_spi.h |    2 +-
 sound/soc/codecs/wm8904.c      |   26 ++++++++++++--------------
 sound/soc/codecs/wm8996.c      |    8 +++-----
 sound/soc/pxa/pxa-ssp.c        |   38 +++++++++++---------------------------
 sound/soc/tegra/tegra_wm8903.c |   13 +++++++++++++
 7 files changed, 43 insertions(+), 47 deletions(-)

--BtNCO5h84ExDStzY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP3kUJAAoJEBus8iNuMP3dvogQAInqR2YII6xq0CecmPLthQep
BgKbCmdA6QpVBWcEx1w5rB1nKAGAvGpNNh5kchI9LcuEBIAo4IZtJzbrV7Fy6PXS
XYHpMVnLz8Lt8T3FnOCAe29ljHyZ79qtMxa1i3bAWApzFnCJoxPZv31eou49I+33
jD0iggn2X6Ts1w7DTERLp1G88Qqfs1dryYaUzsa1KXfk/enN957TpmM3VgEcZrW8
XeajbxtUa/H0FA1QcNpZq7OGr38YNNiGrxYcp+NQqujsji/cWQeVD/iMS5yePEbp
rNKi4wr/pL3D2BXIYM3pCmffY4u1wmfIiekifFSGkhXwUeWXVwStXzAyo44WUfcP
tJUOTpjaDv+Yk+gpMPonSPWrPWOTF1wktydiZSj4B93YbsoGlGlV2mKqWeeSacSD
9Xu8Ygv0DQaoJQ9eMGslRrdDcwD3IzGaZurGY49qpFNRPocx381QWaSASIFFg/5q
ps0rU7PCZPnrBilQ39LbUR3cNaDvqoO8sio4pCpUodfpLeYqqz4b0pPYjzjbz4xF
AgYtOBMxJIttMTkfkcwH43tsRvFK2C3SavJAz+gyWjS2gwgbGPscmoE8r4tSLpul
zcqe3ut0FgyPZTg0pq0QpB6oem3q4avscAsmPBbc4QT+b30++4xjAP2ZIY7oHOVA
YP8dWmyo4S3KAooIl1tS
=pw7F
-----END PGP SIGNATURE-----

--BtNCO5h84ExDStzY--

--===============2617313166151164109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2617313166151164109==--
