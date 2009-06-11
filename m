From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: lx6464es - support standard alsa module
	parameters
Date: Thu, 11 Jun 2009 11:09:00 +0200
Message-ID: <20090611110900.5504eeea@thinkpad>
References: <s5hprdbvb1s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6051882473151014379=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 80B2D10380C
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 11:09:05 +0200 (CEST)
Received: from thinkpad (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-9) with ESMTP id n5B994N5017353
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2009 11:09:05 +0200
In-Reply-To: <s5hprdbvb1s.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

--===============6051882473151014379==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//iwnnrMiC1u28PXJiOUOrTU";
 protocol="application/pgp-signature"

--Sig_//iwnnrMiC1u28PXJiOUOrTU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

trivial patch to support the alsa module parameters `index', `id'
and `enable'

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/lx6464es/lx6464es.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 870bfc5..ccf1b38 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -43,6 +43,13 @@ static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;
 static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
=20
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for Digigram LX6464ES interface.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for  Digigram LX6464ES interface.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable/disable specific Digigram LX6464ES soundc=
ards.");
+
 static const char card_name[] =3D "LX6464ES";
=20
=20
--=20
1.6.2.1


--Sig_//iwnnrMiC1u28PXJiOUOrTU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkowyawACgkQdL+4qsZfVsvS8QCZAVqenMWOVHDqs5KUD8WVOT3r
ez8Amwa9NolooYwqgczrwDNKw0NK0HXB
=OVU0
-----END PGP SIGNATURE-----

--Sig_//iwnnrMiC1u28PXJiOUOrTU--

--===============6051882473151014379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6051882473151014379==--
