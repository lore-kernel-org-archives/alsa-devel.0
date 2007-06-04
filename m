From: Michael Gerdau <mgd@technosis.de>
Subject: Re: v1.0.14 - test packages #2
Date: Mon, 4 Jun 2007 12:50:35 +0200
Message-ID: <200706041250.48356.mgd@technosis.de>
References: <Pine.LNX.4.61.0706040930220.7767@tm8103.perex-int.cz>
	<200706041151.10173.mgd@technosis.de>
	<Pine.LNX.4.61.0706041205000.7767@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5961604529650261762=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id A89A524551
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 12:50:49 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0706041205000.7767@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============5961604529650261762==
Content-Type: multipart/signed;
  boundary="nextPart1253190.3R6sk8rbbH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1253190.3R6sk8rbbH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > > 	I recreated driver and tools packages in /pub/testing to fix
> > > reported problems. Please, test...
> >=20
> > configure still fails for me in subdir qlo10k1 of alsa-tools-1.0.14.
> >=20
> > I'm on openSUSE 10.2, x86_64. The problem most likely has to do with
> > correctly finding the 64bit Qt libs.
>=20
> Thanks. Could you try new alsa-tools package in /pub/testing ?

The problem is still there. The errorlog is identical.

The 64bit qt-libs are under /usr/lib/qt3/lib64/* or
/usr/lib64/qt3/lib64/* (/usr/lib64/qt3 is a symlink to /usr/lib/qt3).

It seems as if the algorithm that's searching for the libs can't
deal with the two lib64 "branches" in the dirtree and thus ends with
grabbing the 32bit libs under /usr/lib/qt3/lib/*

At least all works fine after issuing the following commands:
mv /usr/lib/qt3/lib /usr/lib/qt3/lib.old
ln -s /usr/lib/qt3/lib64 /usr/lib/qt3/lib

Best,
Michael
=2D-=20
 Technosis GmbH, Gesch=E4ftsf=FChrer: Michael Gerdau, Tobias Dittmar
 Sitz Hamburg; HRB 89145 Amtsgericht Hamburg
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver

--nextPart1253190.3R6sk8rbbH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGY+6IUYYhyuxDQc4RAqSgAKCmhaCdynRhGgxbtbixHwzfK3l81ACghOrd
PVccHt0nlCCKxuGO/H/5MPo=
=dTTG
-----END PGP SIGNATURE-----

--nextPart1253190.3R6sk8rbbH--

--===============5961604529650261762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5961604529650261762==--
