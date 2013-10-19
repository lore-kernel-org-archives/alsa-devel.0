From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.12
Date: Sat, 19 Oct 2013 13:56:07 +0100
Message-ID: <20131019125607.GA2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4340901010571435911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 32C7A260885
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 14:56:10 +0200 (CEST)
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


--===============4340901010571435911==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZNMkbfjzv9RSo/Cd"
Content-Disposition: inline


--ZNMkbfjzv9RSo/Cd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:

  Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.12-rc5

for you to fetch changes up to 40f8989695660dee984338861ca9900b8e0b5183:

  Merge remote-tracking branch 'asoc/fix/tlv320aic3x' into asoc-linus (2013=
-10-18 14:17:14 +0100)

----------------------------------------------------------------

ASoC: Fixes for v3.12

A number of small, fairly unexciting, fixes for drivers - nothing stand
out.

----------------------------------------------------------------
Axel Lin (3):
      ASoC: pcm1681: Fix max_register setting
      ASoC: pcm1681: Fix max_register setting
      ASoC: pcm1792a: Fix max_register setting

Guenter Roeck (1):
      ASoC: fsl_ssi: Fix irq_of_parse_and_map() return value check

Jarkko Nikula (1):
      ASoC: omap: Fix incorrect ARM dependency

Kuninori Morimoto (1):
      ASoC: rcar: fixup generation checker

Mark Brown (6):
      Merge remote-tracking branch 'asoc/fix/fsl' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/omap' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm1681' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm1792a' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/tlv320aic3x' into asoc-linus

Peter Ujfalusi (1):
      ASoC: tlv320aic3x: Connect 'Left Line1R Mux' and 'Right Line1L Mux'

Philippe R=E9tornaz (2):
      ASoC: fsl: Fix sound on mx31moboard
      ASoC: fsl: imx-ssi: fix probe on imx31

 include/sound/rcar_snd.h       |  1 +
 sound/soc/codecs/pcm1681.c     |  2 +-
 sound/soc/codecs/pcm1792a.c    |  2 +-
 sound/soc/codecs/tlv320aic3x.c |  4 ++++
 sound/soc/fsl/fsl_ssi.c        |  2 +-
 sound/soc/fsl/imx-mc13783.c    |  2 +-
 sound/soc/fsl/imx-ssi.c        | 23 ++++++++++++-----------
 sound/soc/fsl/imx-ssi.h        |  2 ++
 sound/soc/omap/Kconfig         |  4 ++--
 sound/soc/sh/rcar/rsnd.h       |  4 ++--
 10 files changed, 27 insertions(+), 19 deletions(-)

--ZNMkbfjzv9RSo/Cd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYoFkAAoJELSic+t+oim9j5wP/RHZXe90QyYCA2XTa8jebvqp
wHBLmb5W56nyoovFSg6JFLuvPFN/DWspuO9GPpjdsRWz8KtmvL59wIon5NmAdjog
3UWvfN/gHSCDbPsGsNfsxp/xWvHkYXIhNNtZ+Ph8Fk1xEFa7ZhIDyf0atVDjkvVp
msbj+QXLRwH9UnTKNLe3JhqZ8daiPTPcIQ3w+px9qs134lIkTzejBHo4SK2ivCUR
mL9AdfCMvpvs2LsdfAUMS97cjZbikkLQswmwkdcm+3fwTDcS53jysx9NpWCApveI
kCypw7et1CgguhggqQowQbOfhEy2YvyhSasJtoGXyIftktYM5fJbQSagG5LT5tih
Q0ed0VIFQsu0XzZL5ZokjoFoZfCPnyPB630Ja7zUXDiXOYQ07+ewUKoNytTaTkz8
+JcWWzZzhNA2dQoPFwgZYZqdO4WUmm9r45A8XRY/qDY57XPU9IkTZB0l5XDYgYvB
UDZEnUT6C/ySQm79ed+DIymhrSOCzRZmkv0MgTlonBog8u+8YA01nMQIlIvcVVvd
/TaebN4T/gsgFwzui8rds8bM/pubJhtXln4AYTjnvl6/KfZkICBkhDz9L/63sXxZ
3vY+nvOQQP3Ut7S1ZiG9OVSxzjJs954byB+v7Et6tOEaR17xUoJYqZWOk/nIpCRP
pHW+9sAbSlpcDBvyi4dH
=9F8x
-----END PGP SIGNATURE-----

--ZNMkbfjzv9RSo/Cd--

--===============4340901010571435911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4340901010571435911==--
