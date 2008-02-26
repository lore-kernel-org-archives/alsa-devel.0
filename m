From: Michael Gerdau <mgerdau@tiscali.de>
Subject: Re: ALSA C++ API updated for 1.0.16
Date: Tue, 26 Feb 2008 15:49:50 +0100
Message-ID: <200802261550.03657.mgerdau@tiscali.de>
References: <47C30EDE.8000400@trn.iki.fi> <47C3E387.20800@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1030456468007386928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp10.unit.tiscali.de (smtp10.unit.tiscali.de [213.205.33.46])
	by alsa0.perex.cz (Postfix) with ESMTP id 599B21038D3
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 15:50:06 +0100 (CET)
In-Reply-To: <47C3E387.20800@ladisch.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, Lasse =?iso-8859-1?q?K=E4rkk=E4inen?= <tronic@trn.iki.fi>
List-Id: alsa-devel@alsa-project.org

--===============1030456468007386928==
Content-Type: multipart/signed;
  boundary="nextPart1291658.2QvxUc2zag";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1291658.2QvxUc2zag
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > ALSA_HPP_CLASS& set_##name(...) { ...; return *this; }\
>=20
> Is there a reason why you return the object itself?  Usually, returning
> an object implies that that object is a _different_ object with the
> setting applied, which would mean that the original object was _not_
> changed, but that isn't true here.

I'm not an OO design guru, but at least IOC (IBM OpenClass; it used to
be a rather powerful multiplatform GUI framework - before they made it
AIX only) used this very paradigma all over the place.

You were supposed to write statements like:
  obj.method1().method2().method3().___.method_n();

At least that's what all their example code looked like.

Best,
Michael
=2D-=20
 Michael Gerdau       email: mgerdau@tiscali.de
 GPG-keys available on request or at public keyserver

--nextPart1291658.2QvxUc2zag
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBHxCcbUYYhyuxDQc4RAmSqAJ9jD2VDXaG93I4TwqaMYyZNEDYY0wCePRut
oa7MQKKb3KVtlN3MG3PLDSQ=
=Qrwq
-----END PGP SIGNATURE-----

--nextPart1291658.2QvxUc2zag--

--===============1030456468007386928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1030456468007386928==--
