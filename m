From: Marco Schuster <marco@harddisk.is-a-geek.org>
Subject: ALC268 auto-parsing
Date: Wed, 16 Jan 2008 18:48:23 +0100
Message-ID: <478E4367.6040107@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0849010228437468250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.velirat.de (velirat.de [85.25.68.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E0522451C
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 18:48:30 +0100 (CET)
Received: from dslb-088-064-088-191.pools.arcor-ip.net ([88.64.88.191]
	helo=[192.168.0.102])
	by www.velirat.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.68) (envelope-from <marco@harddisk.is-a-geek.org>)
	id 1JFCNH-0002W0-S1
	for alsa-devel@alsa-project.org; Wed, 16 Jan 2008 18:48:28 +0100
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
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0849010228437468250==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9193DD9CFA5E251CBF5A73E5"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9193DD9CFA5E251CBF5A73E5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I am a bit interested in how the Realtek Windows driver gets its pin
config. There IMO are two options:
a) it uses the bios autoconfig - as parsing this doesn't work in alsa
here, there must be something special in it
b) it uses a config file - it should be easy to get out the pin config.

Any opinions what is correct way?

Marco


--------------enig9193DD9CFA5E251CBF5A73E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHjkNrW6S2GapJUuQRAsO7AJ0a5IX4Y0ROUcUrQT/XWbNjvLYRHgCfT+5N
WzEjJCPQwaVxVDUshpq9K0U=
=9ddJ
-----END PGP SIGNATURE-----

--------------enig9193DD9CFA5E251CBF5A73E5--

--===============0849010228437468250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0849010228437468250==--
