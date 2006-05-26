From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Make snd_hctl_wait() respect the API
Date: Fri, 26 May 2006 11:40:44 +0200
Message-ID: <4476CD1C.1020108@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1881729104=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7EF0B151
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 11:40:45 +0200 (MEST)
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
--===============1881729104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig74A4CB63860C5BBFF891BC87"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig74A4CB63860C5BBFF891BC87
Content-Type: multipart/mixed; boundary="------------040001070201040207090302"

This is a multi-part message in MIME format.
--------------040001070201040207090302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

snd_hctl_wait() currently makes a lot of assumptions that fall outside
the defined API. snd_pcm_wait(), however, follows the API nicely so the
new version is based on that.

Signed-off-by: Pierre Ossman <ossman@cendio.se>


--------------040001070201040207090302
Content-Type: text/x-patch;
 name="hcontrol-wait.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hcontrol-wait.patch"

Index: hcontrol.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-lib/src/control/hcontrol.c,v
retrieving revision 1.37
diff -u -r1.37 hcontrol.c
--- hcontrol.c	27 Feb 2006 09:58:32 -0000	1.37
+++ hcontrol.c	25 May 2006 22:52:59 -0000
@@ -657,22 +657,52 @@
  * \brief Wait for a HCTL to become ready (i.e. at least one event pendi=
ng)
  * \param hctl HCTL handle
  * \param timeout maximum time in milliseconds to wait
- * \return 0 otherwise a negative error code on failure
+ * \return a positive value on success otherwise a negative error code
+ * \retval 0 timeout occurred
+ * \retval 1 an event is pending
  */
 int snd_hctl_wait(snd_hctl_t *hctl, int timeout)
 {
-	struct pollfd pfd;
-	int err;
-	err =3D snd_hctl_poll_descriptors(hctl, &pfd, 1);
+	struct pollfd *pfd;
+	unsigned short *revents;
+	int i, npfds, pollio, err, err_poll;
+=09
+	npfds =3D snd_hctl_poll_descriptors_count(hctl);
+	if (npfds <=3D 0 || npfds >=3D 16) {
+		SNDERR("Invalid poll_fds %d\n", npfds);
+		return -EIO;
+	}
+	pfd =3D alloca(sizeof(*pfd) * npfds);
+	revents =3D alloca(sizeof(*revents) * npfds);
+	err =3D snd_hctl_poll_descriptors(hctl, pfd, npfds);
 	if (err < 0)
 		return err;
-	if (! err)
-		return 0;
-	assert(err =3D=3D 1);
-	err =3D poll(&pfd, 1, timeout);
-	if (err < 0)
-		return -errno;
-	return 0;
+	if (err !=3D npfds) {
+		SNDMSG("invalid poll descriptors %d\n", err);
+		return -EIO;
+	}
+	do {
+		pollio =3D 0;
+		err_poll =3D poll(pfd, npfds, timeout);
+		if (err_poll < 0) {
+			if (errno =3D=3D EINTR)
+				continue;
+			return -errno;
+		}
+		if (! err_poll)
+			break;
+		err =3D snd_hctl_poll_descriptors_revents(hctl, pfd, npfds, revents);
+		if (err < 0)
+			return err;
+		for (i =3D 0; i < npfds; i++) {
+			if (revents[i] & (POLLERR | POLLNVAL))
+				return -EIO;
+			if ((revents[i] & (POLLIN | POLLOUT)) =3D=3D 0)
+				continue;
+			pollio++;
+		}
+	} while (! pollio);
+	return err_poll > 0 ? 1 : 0;
 }
=20
 /**

--------------040001070201040207090302--

--------------enig74A4CB63860C5BBFF891BC87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEds0c7b8eESbyJLgRAprPAKDDrSYzvWMRbdLHipwwo6P98+mOWgCfQKhZ
L+bliBIAHpmvDRqMYXgQIPc=
=lGdJ
-----END PGP SIGNATURE-----

--------------enig74A4CB63860C5BBFF891BC87--


--===============1881729104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1881729104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1881729104==--
