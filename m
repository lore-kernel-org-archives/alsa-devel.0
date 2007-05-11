From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Undefined Symbols: snd-aoa-codec-tas.c:944 warning:
	implicit	declaration of function 'of_get_property'
Date: Fri, 11 May 2007 22:14:59 +0200
Message-ID: <20070511201459.GA28331@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0119498270196723862=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id C4A6F244D1
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 22:15:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org


--===============0119498270196723862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi all,


the aoa drivers in 1.0.14rc4 are not usable. Compiling the modules
there are much warnings "implicit declaration of function
'of_get_property'" Loading the module dmesg tells: snd_aoa: Unknown
symbol of_get_property. rc3 out of 2.6.21 works fine.


Any hints?

Thanks
Elimar



--=20
  You cannot propel yourself forward by
  patting yourself on the back.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRM7D3Ig8bsVPf7ARAuilAJ9LC3HTqffovXTV9LdfTRSsAk6XzQCgo9Cz
ycwrJSrHYnQeBdRSkSFBEl8=
=SlXu
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--===============0119498270196723862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0119498270196723862==--
