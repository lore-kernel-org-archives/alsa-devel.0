From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH] arecord without timelimit produces buggy wav files.
Date: Wed, 18 Dec 2002 15:45:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021218144558.GA24742@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: stevenk@debian.org, madkiss@madkiss.org
List-Id: alsa-devel@alsa-project.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[resent with my subscriber address... is someone moderating alsa-devel?]

Hello,

Daniel Kobras reported a bug in arecord ages ago, against
beta10a. Quoting:

> When running arecord without timelimit (no -d option), the size of the
> RIFF chunk in a wav file is not updated when the recording is finished.
> The resulting wav causes trouble with some applications as the dummy
> chunk size is negative. (Chunk sizes are spec'ed as signed integer.
> Don't ask me why.) The following patch adds the proper fixup for the
> RIFF chunk. Patch against version 0.9.0beta10a-2 of alsa-utils.


--- aplay.c.orig	Sat Dec  1 21:26:46 2001
+++ aplay.c	Fri Feb  1 18:11:39 2002
@@ -1548,12 +1548,17 @@
 {				/* only close output */
 	WaveChunkHeader cd;
 	off_t length_seek;
+	u_int rifflen;
 =09
 	length_seek =3D sizeof(WaveHeader) +
 		      sizeof(WaveChunkHeader) +
 		      sizeof(WaveFmtBody);
 	cd.type =3D WAV_DATA;
 	cd.length =3D LE_INT(fdcount);
+	rifflen =3D fdcount + 2*sizeof(WaveChunkHeader) + sizeof(WaveFmtBody) + 4;
+	rifflen =3D LE_INT(rifflen);
+	if (lseek(fd, 4, SEEK_SET) =3D=3D 4)
+		write(fd, &rifflen, 4);
 	if (lseek(fd, length_seek, SEEK_SET) =3D=3D length_seek)
 		write(fd, &cd, sizeof(WaveChunkHeader));
 	if (fd !=3D 1)

The current Debian packages have this patch applied, and the full bug
log is in http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D131875.

Thanks,
Jordi

PS: recently, new people started working on Debian's ALSA packages.
We'll try to forward all the bugs and patches that have piled up against
our packages in the previous era. What's the prefered way of reporting
bugs and problems against alsa packages components?
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE+AIomJYSUupF6Il4RArxfAJj67Dt/g9k1y6d8ay63CkjubcfbAKDJe/JL
XsZa+HsxwIGavbdkD6q1kQ==
=PV0d
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
