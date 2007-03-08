From: Michael Gerdau <mgd@technosis.de>
Subject: Compilation error with alsa-plugins-1.0.14rc3: gcd.h
	not found
Date: Thu, 8 Mar 2007 12:09:05 +0100
Message-ID: <200703081209.17773.mgd@technosis.de>
Reply-To: mgd@technosis.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0750183092=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D28A2435E
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2007 12:09:19 +0100 (CET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0750183092==
Content-Type: multipart/signed; boundary="nextPart3731128.FSprySiX1A";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3731128.FSprySiX1A
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi list,

while trying to compile alsa-plugins-1.0.14rc3 I get this error:

gcc -DHAVE_CONFIG_H -I. -I. -I.. -Wall -g -I/usr/include/alsa -g -O2 -MT ra=
te_lavcrate.lo -MD -MP -MF .deps/rate_lavcrate.Tpo -c rate_lavcrate.c  -fPI=
C -DPIC -o .libs/rate_lavcrate.o
rate_lavcrate.c:23:17: error: gcd.h: No such file or directory
rate_lavcrate.c: In function 'pcm_src_init':
rate_lavcrate.c:85: warning: implicit declaration of function 'gcd'
make[2]: *** [rate_lavcrate.lo] Fehler 1
make[2]: Leaving directory `/home/mgd/src/alsa-plugins-1.0.14rc3/rate-lavc'
make[1]: *** [all-recursive] Fehler 1
make[1]: Leaving directory `/home/mgd/src/alsa-plugins-1.0.14rc3'
make: *** [all] Fehler 2

Where am I supposed to get gcd.h from ?

Best wishes,
Michael
=2D-=20
 Technosis GmbH, Gesch=C3=A4ftsf=C3=BChrer: Michael Gerdau, Tobias Dittmar
 Sitz Hamburg; HRB 89145 Amtsgericht Hamburg
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver

--nextPart3731128.FSprySiX1A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBF7+7dUYYhyuxDQc4RAqnIAKCO6GdDbe8OICu0hAdlLW9DGvl5oACfTQ9Z
MJCz8BZTmdQEvYH7dQtvVGw=
=ytt3
-----END PGP SIGNATURE-----

--nextPart3731128.FSprySiX1A--


--===============0750183092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0750183092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0750183092==--
