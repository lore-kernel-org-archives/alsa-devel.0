From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.4
Date: Wed, 2 May 2012 10:30:23 +0100
Message-ID: <20120502093022.GA5722@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1776321999495615424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3512E1043FA
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 11:30:25 +0200 (CEST)
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


--===============1776321999495615424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1a38336b8611a04f0a624330c1f815421f4bf5f4:

  ASoC: wm8994: Improve sequencing of AIF channel enables (2012-04-23 12:55=
:52 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.4

for you to fetch changes up to 06412088ce98f745405b8f65cfc51ddd6b842bbf:

  ASoC: s3c2412-i2s: Fix dai registration (2012-04-30 23:45:25 +0100)

----------------------------------------------------------------
ASoC: Updates for 3.4

Nothing terribly exciting here, a bunch of small and simple fixes
scattered around the place.

----------------------------------------------------------------
Eric B=E9nard (1):
      ASoC: tlv312aic23: unbreak resume

Fabio Estevam (1):
      ASoC: dt: sgtl5000.txt: Add description for 'reg' field

Heiko St=FCbner (1):
      ASoC: s3c2412-i2s: Fix dai registration

Lars-Peter Clausen (1):
      ASoC: bf5xx-ssm2602: Set DAI format

Mark Brown (2):
      ASoC: wm_hubs: Make sure we don't disable differential line outputs
      ASoC: wm8350: Don't use locally allocated codec struct

Richard Zhao (1):
      ASoC: core: check of_property_count_strings failure

 Documentation/devicetree/bindings/sound/sgtl5000.txt |    2 ++
 sound/soc/blackfin/bf5xx-ssm2602.c                   |    2 ++
 sound/soc/codecs/tlv320aic23.c                       |    4 ++--
 sound/soc/codecs/wm8350.c                            |   11 ++++++-----
 sound/soc/codecs/wm_hubs.c                           |   15 +++++++++------
 sound/soc/samsung/s3c2412-i2s.c                      |    2 +-
 sound/soc/soc-core.c                                 |    6 +++---
 7 files changed, 25 insertions(+), 17 deletions(-)

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoP6fAAoJEBus8iNuMP3dBzsP/3cVO4ItK9CDk43gHkHBVHD8
1y7ErtxKc1bmg5VzyR0ItiG41VkvTz6qmeEkVD43o90QOwQf797rM5WetA9ASM/Y
6/yeOK4C5LRX8Pasq7KqlOv6UWoAT8XlcL1Hi8STQHHUPrHj8Z17R53Jk9CftzF0
8Rv3RoD4AmFUn7bSP6R7ELlqw81TiYNCp2UwG3M3KUVVX0eQ3y+p+oK73dLJPpiv
7wl+2F/67V0IwcRQ4w8bauphFXqjijzgzrKXeMVcb4KmQDKtVPp8QB2C8iQI5ANG
ynkKkcHLr8raH0bLW0PxBvRVqfRvJvoiol+KgjNUQN+FUMvN3CHXUN3S0+oj4Lv5
/DnlKwU7Az9TVe2rusbAlnBbG61Ascwrf16m+1GYWcM6yPqvlzsdEDEgFXYLDwut
eljYQAJtvqp62rmN9Kk9KFLaODY/lUxR5z83qiSVlxew4zNvVDmRqJ9PDjtUpus0
sWGcwP6TEbMDbfP/3UPpGyH3Wd5Y2QlLMSL+xmXlRlP2P57CYE7pMPNVMRDwZ05g
174CDuv7AEFYm0/k/1yTGb9PJnfgIMQFPznH2x8pLndK0KOkt8gHAzRn04OPDKou
i6QOQuIcpW0qNDA0AgsCswDtRIeDBBvM64KejdvQ1GgvSpnEPooikdOpKms6yQ2+
gUWeZJZyvWo1kvum3wqr
=shOz
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

--===============1776321999495615424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1776321999495615424==--
