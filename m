From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH] ASoC: remove duplicated code on pxa-ssp.c
Date: Wed, 10 Jun 2009 15:23:24 -0300
Message-ID: <1244658204.25905.10.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2051292273554889201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A1E62443F
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 20:23:30 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1350896qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 11:23:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============2051292273554889201==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-idu2MjpuMpeSECeQqV5T"


--=-idu2MjpuMpeSECeQqV5T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

* We don't need to write the registers twice, remove the first write.
* DAIFMT_INV switch is duplicated inside DAIFMT_FORMAT switch, move it
  out.

(This patch is for Mark's for-2.6.32 branch, I have not checked if the
code is duplicated on current 2.6.30)

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

---
 sound/soc/pxa/pxa-ssp.c |   50 ++++++++++++++-----------------------------=
---
 1 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 19c4540..e22c5ce 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -457,31 +457,27 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cp=
u_dai,
 		return -EINVAL;
 	}
=20
-	ssp_write_reg(ssp, SSCR0, sscr0);
-	ssp_write_reg(ssp, SSCR1, sscr1);
-	ssp_write_reg(ssp, SSPSP, sspsp);
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		sspsp |=3D SSPSP_SFRMP;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		sspsp |=3D SSPSP_SCMODE(2);
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		sspsp |=3D SSPSP_SCMODE(2) | SSPSP_SFRMP;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		sscr0 |=3D SSCR0_PSP;
 		sscr1 |=3D SSCR1_RWOT | SSCR1_TRAIL;
-
 		/* See hw_params() */
-		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-		case SND_SOC_DAIFMT_NB_NF:
-			sspsp |=3D SSPSP_SFRMP;
-			break;
-		case SND_SOC_DAIFMT_NB_IF:
-			break;
-		case SND_SOC_DAIFMT_IB_IF:
-			sspsp |=3D SSPSP_SCMODE(2);
-			break;
-		case SND_SOC_DAIFMT_IB_NF:
-			sspsp |=3D SSPSP_SCMODE(2) | SSPSP_SFRMP;
-			break;
-		default:
-			return -EINVAL;
-		}
 		break;
=20
 	case SND_SOC_DAIFMT_DSP_A:
@@ -489,22 +485,6 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu=
_dai,
 	case SND_SOC_DAIFMT_DSP_B:
 		sscr0 |=3D SSCR0_MOD | SSCR0_PSP;
 		sscr1 |=3D SSCR1_TRAIL | SSCR1_RWOT;
-
-		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-		case SND_SOC_DAIFMT_NB_NF:
-			sspsp |=3D SSPSP_SFRMP;
-			break;
-		case SND_SOC_DAIFMT_NB_IF:
-			break;
-		case SND_SOC_DAIFMT_IB_IF:
-			sspsp |=3D SSPSP_SCMODE(2);
-			break;
-		case SND_SOC_DAIFMT_IB_NF:
-			sspsp |=3D SSPSP_SCMODE(2) | SSPSP_SFRMP;
-			break;
-		default:
-			return -EINVAL;
-		}
 		break;
=20
 	default:
--=20
tg: (a3ba169..) asoc/remove-code-duplication (depends on: asoc/upstream-for=
-2.6.32)

--=20
Daniel Ribeiro

--=-idu2MjpuMpeSECeQqV5T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkov+hYACgkQw3OYl0G0liTJBQCfcJjoVIqEjgOrAUakaLPx1l1o
adMAn1OlTj/0gbnXsMVJQuF2o33+CqkI
=wtuW
-----END PGP SIGNATURE-----

--=-idu2MjpuMpeSECeQqV5T--


--===============2051292273554889201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2051292273554889201==--
