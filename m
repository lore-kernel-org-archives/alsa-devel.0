From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Allow ioplugins to override snd_pcm_delay()
Date: Fri, 26 May 2006 16:01:16 +0200
Message-ID: <44770A2C.7030109@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0692759676=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B6B017A
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 16:01:20 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0692759676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig27C1207E9D0A22FBECDE01B0"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27C1207E9D0A22FBECDE01B0
Content-Type: multipart/mixed; boundary="------------090206060500010807040301"

This is a multi-part message in MIME format.
--------------090206060500010807040301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Some io plug-ins might want to adjust the reported delay value and not
strictly follow the current buffer usage (that's why we have two calls
after all).

Allow them to specify a delay() callback and use the previous behaviour
if they don't.

Signed-off-by: Pierre Ossman <ossman@cendio.se>

--------------090206060500010807040301
Content-Type: text/x-patch;
 name="ioplug-delay.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ioplug-delay.patch"

Index: src/pcm/pcm_ioplug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_ioplug.c,v
retrieving revision 1.10
diff -u -r1.10 pcm_ioplug.c
--- src/pcm/pcm_ioplug.c	28 Jun 2005 10:24:45 -0000	1.10
+++ src/pcm/pcm_ioplug.c	26 May 2006 13:59:14 -0000
@@ -106,8 +106,15 @@
=20
 static int snd_pcm_ioplug_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delay=
p)
 {
-	snd_pcm_ioplug_hw_ptr_update(pcm);
-	*delayp =3D snd_pcm_mmap_hw_avail(pcm);=20
+	ioplug_priv_t *io =3D pcm->private_data;
+
+	if ((io->data->version >=3D 0x010001) &&
+		(io->data->callback->delay))
+		return io->data->callback->delay(io->data, delayp);
+	else {
+		snd_pcm_ioplug_hw_ptr_update(pcm);
+		*delayp =3D snd_pcm_mmap_hw_avail(pcm);
+	}
 	return 0;
 }
=20
@@ -872,7 +879,9 @@
 	       ioplug->callback->stop &&
 	       ioplug->callback->pointer);
=20
-	if (ioplug->version !=3D SND_PCM_IOPLUG_VERSION) {
+	/* We support 1.0.0 to current */
+	if ((ioplug->version < 0x010000) ||
+		(ioplug->version > SND_PCM_IOPLUG_VERSION)) {
 		SNDERR("ioplug: Plugin version mismatch\n");
 		return -ENXIO;
 	}
Index: include/pcm_ioplug.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-lib/include/pcm_ioplug.h,v
retrieving revision 1.5
diff -u -r1.5 pcm_ioplug.h
--- include/pcm_ioplug.h	24 May 2005 09:42:01 -0000	1.5
+++ include/pcm_ioplug.h	26 May 2006 13:59:14 -0000
@@ -65,7 +65,7 @@
  */
 #define SND_PCM_IOPLUG_VERSION_MAJOR	1	/**< Protocol major version */
 #define SND_PCM_IOPLUG_VERSION_MINOR	0	/**< Protocol minor version */
-#define SND_PCM_IOPLUG_VERSION_TINY	0	/**< Protocol tiny version */
+#define SND_PCM_IOPLUG_VERSION_TINY	1	/**< Protocol tiny version */
 /**
  * IO-plugin protocol version
  */
@@ -184,6 +184,10 @@
 	 * dump; optional
 	 */
 	void (*dump)(snd_pcm_ioplug_t *io, snd_output_t *out);
+	/**
+	 * get the delay for the running PCM; optional
+	 */
+	int (*delay)(snd_pcm_ioplug_t *io, snd_pcm_sframes_t *delayp);
 };
=20
=20

--------------090206060500010807040301--

--------------enig27C1207E9D0A22FBECDE01B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEdwov7b8eESbyJLgRAg2fAJwIIUmeh8KNsKesxay+cbIMkTsX3ACeNEPg
yYRpTMv7YZsDJGw/9BJydx0=
=2BD4
-----END PGP SIGNATURE-----

--------------enig27C1207E9D0A22FBECDE01B0--


--===============0692759676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0692759676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0692759676==--
