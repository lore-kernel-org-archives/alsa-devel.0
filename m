From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.4
Date: Wed, 23 Dec 2015 00:26:49 +0000
Message-ID: <20151223002649.GJ16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6069441902188818600=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8336A2666BE
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:26:56 +0100 (CET)
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


--===============6069441902188818600==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4ef7675344d687a0ef5b0d7c0cee12da005870c0:

  Linux 4.4-rc6 (2015-12-20 16:06:09 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-fix-v4.4-rc6

for you to fetch changes up to 3dd5fc0eeb5d7cc07b8e3e383037261799b38897:

  Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/es8328', 'asoc/fix/fsl-sai', 'asoc/fix/rockchip', 'asoc/fix/sgtl5000' and 'asoc/fix/wm8974' into asoc-linus (2015-12-23 00:23:27 +0000)

----------------------------------------------------------------
ASoC: Fixes for v4.4

A collection of small driver specific fixes here, nothing that'll affect
users who don't have the devices concerned.  At least the wm8974 bug
indicates that there's not too many users of some of these devices.

----------------------------------------------------------------
Jean-Michel Hautbois (1):
      ASoC: sgtl5000: fix VAG power up timing

John Keeping (2):
      ASoC: es8328: Fix deemphasis values
      ASoC: es8328: Fix shifts for mixer switches

Mans Rullgard (1):
      ASoC: wm8974: set cache type for regmap

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/es8328', 'asoc/fix/fsl-sai', 'asoc/fix/rockchip', 'asoc/fix/sgtl5000' and 'asoc/fix/wm8974' into asoc-linus

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Fix XDATA check in mcasp_start_tx

Sjoerd Simons (1):
      ASoC: rockchip: spdif: Set transmit data level to 16 samples

Zidan Wang (1):
      ASoC: fsl_sai: fix no frame clk in master mode

 sound/soc/codecs/es8328.c           | 25 +++++++++++++++++--------
 sound/soc/codecs/es8328.h           |  1 +
 sound/soc/codecs/sgtl5000.c         |  1 +
 sound/soc/codecs/wm8974.c           |  1 +
 sound/soc/davinci/davinci-mcasp.c   |  4 ++--
 sound/soc/fsl/fsl_sai.c             | 18 ++++++++++++++++++
 sound/soc/rockchip/rockchip_spdif.c |  6 ++++--
 sound/soc/rockchip/rockchip_spdif.h |  2 +-
 8 files changed, 45 insertions(+), 13 deletions(-)

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeepJAAoJECTWi3JdVIfQdI8H/2WpcnT3KS95l35K+FvNiufw
xczbeqmxoY7NSk5IJ6uHZNPpDdKH6hVp0V43elPKg72bw/eBMPGIbL4qPgeXSVyk
TWStHdpithQ/mvPxAf/EvUl4ER7iZOYGIFyQ7RqhgX235JNvOCBrNNqNTX3NYB5/
sKSTWc0oIbrqHXPGdB5T1HicGgOFmmVWkwEidTO33Yhp1+TT9ESYjk4d0u3+2dRy
4FcZ8+jfm5v3hsDEdi895mnzwX4pmQtHSlrfeJVyej45TZMAYdKYkRDnC6rUdABW
D6UQNQuQ3bvLvsrc6Aa9d3YN/lLSYjWvy5+TJmo8hlSwkhkUurQw0GE99+M3QRg=
=JOKI
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--

--===============6069441902188818600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6069441902188818600==--
