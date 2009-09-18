From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] ALSA: lx6464es - remove unused struct member
Date: Fri, 18 Sep 2009 23:00:57 +0200
Message-ID: <4AB3F509.2030202@klingt.org>
References: <cc69ca17240a9e4f5c2e7876520e778a449d5671.1253307496.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9095223232098870314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 9403F244AA
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 23:00:54 +0200 (CEST)
Received: from [192.168.178.3] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-9) with ESMTP id n8IL0sUM008173
	for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2009 23:00:54 +0200
In-Reply-To: <cc69ca17240a9e4f5c2e7876520e778a449d5671.1253307496.git.tim@klingt.org>
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============9095223232098870314==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEF53AE310380607C8C2DDD61"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF53AE310380607C8C2DDD61
Content-Type: multipart/mixed;
 boundary="------------020502060503020401010003"

This is a multi-part message in MIME format.
--------------020502060503020401010003
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


we cannot set the sampling rate of the device, but can only read it
from the board, so we don't need the member for it.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/lx6464es/lx6464es.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)




--------------020502060503020401010003
Content-Type: text/x-patch;
 name="0002-ALSA-lx6464es-remove-unused-struct-member.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0002-ALSA-lx6464es-remove-unused-struct-member.patch"

diff --git a/sound/pci/lx6464es/lx6464es.h b/sound/pci/lx6464es/lx6464es.=
h
index 16442da..51afc04 100644
--- a/sound/pci/lx6464es/lx6464es.h
+++ b/sound/pci/lx6464es/lx6464es.h
@@ -94,7 +94,6 @@ struct lx6464es {
 	uint                    hardware_running[2];
 	u32                     board_sample_rate; /* sample rate read from
 						    * board */
-	u32                     sample_rate;	   /* our sample rate */
 	u16                     pcm_granularity;   /* board blocksize */
=20
 	/* dma */


--------------020502060503020401010003--

--------------enigEF53AE310380607C8C2DDD61
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqz9QkACgkQdL+4qsZfVsvpNACfTAovcepfLXOxPUPGuoVfdLCO
X98AoIC4Ya7wOzQVThbC7FDs4nDYti7D
=u0s/
-----END PGP SIGNATURE-----

--------------enigEF53AE310380607C8C2DDD61--

--===============9095223232098870314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9095223232098870314==--
