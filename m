From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.13
Date: Thu, 16 Jan 2014 12:34:40 +0000
Message-ID: <20140116123440.GQ15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6968811409462200569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6668E261616
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 13:34:45 +0100 (CET)
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


--===============6968811409462200569==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RU5vHP6eAM91MAfE"
Content-Disposition: inline


--RU5vHP6eAM91MAfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7e22e91102c6b9df7c4ae2168910e19d2bb14cd6:

  Linux 3.13-rc8 (2014-01-12 17:04:18 +0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.13-rc8

for you to fetch changes up to c5281227c90578c7b7beffca56e8c3a68d4607de:

  Merge remote-tracking branches 'asoc/fix/adau1701', 'asoc/fix/fsl' and 'asoc/fix/tlv320aic32x4' into asoc-linus (2014-01-15 23:17:15 +0000)

----------------------------------------------------------------

ASoC: Fixes for v3.13

A few small fixes in drivers, nothing too remarkable here but all good
to have - mainly these are fixes for things that were introduced in the
last merge window but only just got useful testing.

----------------------------------------------------------------
Lars-Peter Clausen (1):
      ASoC: adau1701: Fix ADAU1701_SEROCTL_WORD_LEN_16 constant

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/adau1701', 'asoc/fix/fsl' and 'asoc/fix/tlv320aic32x4' into asoc-linus

Markus Pargmann (2):
      ASoC: codec: tlv320aic32x4: Fix regmap range config
      ASoC: tlv320aic32x4: Fix regmap range_min

Nicolin Chen (1):
      ASoC: imx-spdif: Use snd-soc-dummy CODEC driver to link card

 sound/soc/codecs/adau1701.c      |  2 +-
 sound/soc/codecs/tlv320aic32x4.c |  4 +-
 sound/soc/fsl/Kconfig            |  1 -
 sound/soc/fsl/imx-spdif.c        | 84 ++++++++++------------------------------
 4 files changed, 24 insertions(+), 67 deletions(-)

--RU5vHP6eAM91MAfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS19HcAAoJELSic+t+oim99Z0QAIP1owZGwerdvhePcoevza/J
fqCXUHZILAB/JlchASmb4w9mtB5UaGPh532l8aAnOxARniW2jKGX3k2iTSorOZdk
53YGjqALnUJK4d+2XrVOndzf2WpXmprce4dJwmui8w3XDW24W0iNRKVtP77QkQ4b
UiaUFmiJem/AGroq6B/RvmzaxQPIalUyDiyeQCaZ7KPlDdomoYVjxZFmFRJsp/Ct
WYMmVpQA7xQZRd5MpXSuSQkTrisNyodoL0MjR4S5fT7nJD0CGDf4/JUvjJ46+KYl
DkTVo3B/tstqlMgf67TsApomySMwD1voWE7gah51E+w/E5QSstjoLx+8j0IdFvR5
fL/NuxULw7OcArmHH0KLfvZ3bBaQvYRtS3i4irFA+PfspvWH7BMOsggqvlfkA0JX
STqoGfSGBTa4bQQ0O0Cb5RmtZ7VtqpdoP7M4rEVBfYseDVmMqdzZv4T+DF/PfE8S
uQH2fje5CRqF5V6EdcaP8aafN9kKYjNZcY4hYYHOfgJ3NE+KXufvV1KrCB0YDnzG
MgNHqZYhwI/lcEStgMUN3NFbggeppXhZFtvrsDdoq8eAXj4M0tngvakDJRUqgjPC
k/KlI2zaHgjCpnNB9ZFF7WaTpGuy4r/w54f5zPhOgY5qfAYUpPRV24h8p3chQfIp
O+BshbpKrvDErJbPxWLY
=1b4T
-----END PGP SIGNATURE-----

--RU5vHP6eAM91MAfE--

--===============6968811409462200569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6968811409462200569==--
