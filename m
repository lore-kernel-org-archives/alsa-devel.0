From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Allow ioplugins to override snd_pcm_delay()
Date: Fri, 26 May 2006 11:38:11 +0200
Message-ID: <4476CC83.8080103@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0728407240=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 183B5156
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 11:38:15 +0200 (MEST)
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
--===============0728407240==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEFE241F739EC36FD8FF8F778"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEFE241F739EC36FD8FF8F778
Content-Type: multipart/mixed; boundary="------------020000050803020003010708"

This is a multi-part message in MIME format.
--------------020000050803020003010708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Some io plug-ins might want to adjust the reported delay value and not
strictly follow the current buffer usage (that's why we have two calls
after all).

Allow them to specify a delay() callback and use the previous behaviour
if they don't.

Signed-off-by: Pierre Ossman <ossman@cendio.se>


--------------020000050803020003010708
Content-Type: text/x-patch;
 name="ioplug-delay.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ioplug-delay.patch"

? ioplug-delay.patch
Index: include/pcm_ioplug.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-lib/include/pcm_ioplug.h,v
retrieving revision 1.5
diff -u -r1.5 pcm_ioplug.h
--- include/pcm_ioplug.h	24 May 2005 09:42:01 -0000	1.5
+++ include/pcm_ioplug.h	25 May 2006 19:05:23 -0000
@@ -130,6 +130,10 @@
 	 */
 	snd_pcm_sframes_t (*pointer)(snd_pcm_ioplug_t *io);
 	/**
+	 * get the delay for the running PCM; optional
+	 */
+	int (*delay)(snd_pcm_ioplug_t *io, snd_pcm_sframes_t *delayp);
+	/**
 	 * transfer the data; optional
 	 */
 	snd_pcm_sframes_t (*transfer)(snd_pcm_ioplug_t *io,
Index: src/pcm/pcm_ioplug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_ioplug.c,v
retrieving revision 1.10
diff -u -r1.10 pcm_ioplug.c
--- src/pcm/pcm_ioplug.c	28 Jun 2005 10:24:45 -0000	1.10
+++ src/pcm/pcm_ioplug.c	25 May 2006 19:05:24 -0000
@@ -106,8 +106,14 @@
=20
 static int snd_pcm_ioplug_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delay=
p)
 {
-	snd_pcm_ioplug_hw_ptr_update(pcm);
-	*delayp =3D snd_pcm_mmap_hw_avail(pcm);=20
+	ioplug_priv_t *io =3D pcm->private_data;
+
+	if (io->data->callback->delay)
+		return io->data->callback->delay(io->data, delayp);
+	else {
+		snd_pcm_ioplug_hw_ptr_update(pcm);
+		*delayp =3D snd_pcm_mmap_hw_avail(pcm);
+	}
 	return 0;
 }
=20

--------------020000050803020003010708--

--------------enigEFE241F739EC36FD8FF8F778
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEdsyF7b8eESbyJLgRAlVCAJ9UVnTAjMM/tLWrB66Lf7xsLLhi0QCgolrD
zYPXgiOeGi2gQofYSLwquOM=
=dKyq
-----END PGP SIGNATURE-----

--------------enigEFE241F739EC36FD8FF8F778--


--===============0728407240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0728407240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0728407240==--
