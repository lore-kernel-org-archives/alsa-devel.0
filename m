From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: lx6464es - support index module parameter
Date: Wed, 10 Jun 2009 23:41:54 +0200
Message-ID: <20090610234154.28ba1585@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5435090241722307313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id C6379244EB
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 23:42:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============5435090241722307313==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/n05G8iLuAv2Mu32ojSrJJoR";
 protocol="application/pgp-signature"

--Sig_/n05G8iLuAv2Mu32ojSrJJoR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

trivial patch to put the device to a specific index

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/lx6464es/lx6464es.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 870bfc5..dd0f12b 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -43,6 +43,9 @@ static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;
 static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
=20
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for Digigram LX6464ES interface.");
+
 static const char card_name[] =3D "LX6464ES";
=20
=20
--=20
1.6.2.1

--Sig_/n05G8iLuAv2Mu32ojSrJJoR
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkowKKIACgkQdL+4qsZfVsvDYwCggQjJeNWjLsSEUxD0wjvICSLX
cbcAoIcCt0oM8p0zaJMyuWsSMjNCAHjT
=rp4n
-----END PGP SIGNATURE-----

--Sig_/n05G8iLuAv2Mu32ojSrJJoR--

--===============5435090241722307313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5435090241722307313==--
