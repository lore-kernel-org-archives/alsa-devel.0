From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.5
Date: Fri, 8 Jun 2012 07:18:14 +0800
Message-ID: <20120607231813.GM14525@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5719792442638635479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B1241045FA
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 02:55:56 +0200 (CEST)
Received: from [116.228.53.169] (helo=finisterre.wolfsonmicro.main)
	by cassiel.sirena.org.uk with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <broonie@opensource.wolfsonmicro.com>)
	id 1ScnUY-0006dg-2B
	for alsa-devel@alsa-project.org; Fri, 08 Jun 2012 01:55:56 +0100
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


--===============5719792442638635479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pFpMklMRdxwSC3Yi"
Content-Disposition: inline


--pFpMklMRdxwSC3Yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.5

for you to fetch changes up to 3ff1ec27e9f567824e73316025a9025528494506:

  ASoC: wm2000: Always use a 4s timeout for the firmware (2012-06-08 07:00:13 +0800)

----------------------------------------------------------------
ASoC: Updates for 3.5

Some driver-specific updates, a few fixes for the dynamic PCM code and
the addition of pinctrl support for the i.MX audmux which didn't make it
into -rc1 due to cross tree dependency issues.

----------------------------------------------------------------
Liam Girdwood (3):
      ASoC: dapm: Fix connected widget capture path query.
      ASoC: dpcm: Fix dpcm_get_be() to check that DAI is BE
      ASoC: dapm: Fix input list to use source widgets

Mark Brown (3):
      ASoC: wm8994: Ensure all AIFnCLK events are run from the _late variants
      ASoC: wm8994: Apply volume updates with clocks enabled
      ASoC: wm2000: Always use a 4s timeout for the firmware

Richard Zhao (1):
      ASoC: imx-audmux: add pinctrl support

 sound/soc/codecs/wm2000.c  |   59 +++++++++----------------
 sound/soc/codecs/wm8994.c  |  105 ++++++++++++++++++++++++++++----------------
 sound/soc/fsl/imx-audmux.c |    8 ++++
 sound/soc/soc-dapm.c       |    4 +-
 sound/soc/soc-pcm.c        |    6 +++
 5 files changed, 103 insertions(+), 79 deletions(-)

--pFpMklMRdxwSC3Yi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0TatAAoJEBus8iNuMP3dh2MP/iZCJIGTAgCrp0YWYThP4Q64
DjjQt/6NBeor2LaUQWZK/ZItmFQJW/ZzWRyNF7FqVHYgWfKFPZBEjv3nbifQ1q1X
t0YGz7EVYHQwddZpL4OFmnCmdfKYj4DT8dr2KEaTLacWe2+/lpThQR9NXfNUubrO
EGSpyF2ABmfEIP2BsczWIgnfIeyhWSPM5Qn/ggp7HYt4HX+EG0ITdbNBPexo8/dh
tFNK3P60N0P1T1imstJOO/NVSYIusVwhsBqZTzfl9SdInoWABdzUhCYO3JhsjfUs
plcRGUWjq+7sA06xSbC17VLgEs9DbFj3ZK85PQRccNJU/BH0CFRIeMFPZgGyfC/t
WZQ6LsoCliujM0gqBZq6dn/0QImy7vxwdEXDFkhVyZP5FHmnkiPiDnPXCubiaQ6H
pNWrPNUSY3uqPczZWzd7Tiy7PVGODkbe4lIabUNobDDBP9q1Mj8TM1W4dGA3n0zN
08+0G6f9ZhrSTXJLXCzbFxxqc9OyWkR5zfdN8mZOrWQnA05NZM7ltgYDj5Tnmi9j
wiYwxfU200c2RQteDmk2ZV/T6fC/vKYIcFOvdzYdfgHuMU4d6YPplJJfH2jgULGZ
9bTJviYN7IG51bkjy/FS7V48o8sJNTqp7M53pOJHK1H6g6dMnBr75K8GKwcFWndi
Yg7wb+7raFmkm7z140PH
=my6C
-----END PGP SIGNATURE-----

--pFpMklMRdxwSC3Yi--

--===============5719792442638635479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5719792442638635479==--
