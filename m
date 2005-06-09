From: Mario Lang <mlang@delysid.org>
Subject: alsa-tools small handle leak
Date: Thu, 09 Jun 2005 14:21:01 +0200
Message-ID: <873brrzpoy.fsf@lexx.delysid.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Hi.

WHile reading hdspmixer sources, I found a potential
handler leak:

Index: hdspmixer/src/HDSPMixerWindow.cxx
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-tools/hdspmixer/src/HDSPMixerWindow.cxx,v
retrieving revision 1.5
diff -u -r1.5 HDSPMixerWindow.cxx
=2D-- hdspmixer/src/HDSPMixerWindow.cxx	27 Nov 2003 10:42:40 -0000	1.5
+++ hdspmixer/src/HDSPMixerWindow.cxx	9 Jun 2005 11:42:18 -0000
@@ -935,6 +935,7 @@
     snd_ctl_elem_value_set_integer(ctl, 2, value);
     if ((err =3D snd_ctl_elem_write(handle, ctl)) < 0) {
         fprintf(stderr, "Alsa error: %s\n", snd_strerror(err));
+        snd_ctl_close(handle);
         return;
     }
=20=20=20=20=20

=2D-=20
CYa,
  Mario | Debian Developer <URL:http://debian.org/>
  .''`. | Get my public key via finger mlang@db.debian.org
 : :' : | 1024D/7FC1A0854909BCCDBE6C102DDFFC022A6B113E44
 `. `'=20
   `-

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCqDQ53/wCKmsRPkQRApYGAKCKxeF3yrX8O7Ql7oCHoyaFFRYp2QCfRe9F
V6hQLPS6/YzJnlv2ZPhxTZM=
=hunj
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
