From: Pierre Ossman <ossman@cendio.se>
Subject: How to send patch with moves?
Date: Wed, 12 Jul 2006 09:25:28 +0200
Message-ID: <44B4A3E8.8060509@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1561212005=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CEAE2167
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 09:25:33 +0200 (MEST)
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
--===============1561212005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDE1028887F425BD5C83F117B"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE1028887F425BD5C83F117B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi there!

I've updated the polypaudio plugin (in alsa-plugins) to the latest
release. Polypaudio recently changed its name to PulseAudio, so I've
made the corresponding changes in ALSA. I am at a loss on how to
generate a patch that will carry the necessary information though as it
would be nice to keep the history of the files as they are renamed (I
have moved them locally with 'hg mv')

--=20
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


--------------enigDE1028887F425BD5C83F117B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEtKPr7b8eESbyJLgRAsZkAKDAb6uf605+S8GWruAxtejyN5GBqACeLoy9
rkDNnDqYH5hqYR9YZk6R4R0=
=ewaN
-----END PGP SIGNATURE-----

--------------enigDE1028887F425BD5C83F117B--


--===============1561212005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1561212005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1561212005==--
