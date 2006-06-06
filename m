From: Alien <alien999999999@users.sourceforge.net>
Subject: OSS/ALSA issue
Date: Tue, 6 Jun 2006 21:57:37 +0200
Message-ID: <200606062157.43489.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1028599000=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1028599000==
Content-Type: multipart/signed; boundary="nextPart3682084.JITy3pnvF9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3682084.JITy3pnvF9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I don't know if this is true on any driver, but here's what happend yesterd=
ay:=20
(i have au8810 driver; on x86_64 system)

i was watching google video on my system

(google video is a flash thing; thus emulated and uses OSS (the only app th=
at=20
needs it))

and suddenly gaim reconnected a network and beeped using aplay (ALSA)

as a result, the sound was played, all sound looped (also flash), and a few=
=20
hours later, my /var/log/kernel/warnings was > 600MB (kernel warnings).


Now, we all know that:

1. ALSA has hardware mixing if the chipset/driver supports it (i know mine=
=20
does).

2. OSS does not do any multiple sounds


so, the OSS application is continually using soundcard. and aplay plays a=20
short one... should it work or must aplay be denied???

(i'm using latest alsa)

--nextPart3682084.JITy3pnvF9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEhd43uBWKXETrtdcRAr0TAKDed+yhyNfqq0dNKFmRxsDAvT3SOACgui1K
tBIzoHbWjFoC3Ms5JhN6SXU=
=+5an
-----END PGP SIGNATURE-----

--nextPart3682084.JITy3pnvF9--


--===============1028599000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1028599000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1028599000==--
