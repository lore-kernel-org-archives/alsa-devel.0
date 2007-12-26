From: Marco Schuster <marco@harddisk.is-a-geek.org>
Subject: ALC268 "test" model
Date: Wed, 26 Dec 2007 19:05:42 +0100
Message-ID: <477297F6.6040607@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1507897121077026517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.velirat.de (velirat.de [85.25.68.44])
	by alsa0.perex.cz (Postfix) with ESMTP id A29ED1038A3
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 19:05:48 +0100 (CET)
Received: from dslb-084-056-055-011.pools.arcor-ip.net ([84.56.55.11]
	helo=[192.168.0.102])
	by www.velirat.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.68) (envelope-from <marco@harddisk.is-a-geek.org>)
	id 1J7adW-0007t1-78
	for alsa-devel@alsa-project.org; Wed, 26 Dec 2007 19:05:46 +0100
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
--===============1507897121077026517==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFE12098F5C3C35860953654F"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE12098F5C3C35860953654F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I try to use a patch from J. Woithe to put a test model into the
ALC268 driver [1] (enabling all pins etc.); unfortunately it gives a
lot of compiling errors ([2]) which I am unable to understand as I
don't have sufficient knowledge of the internal API of HDA codec.

Can someone please look over it and correct the mistakes?

Marco Schuster

[1]: http://harddisk.is-a-geek.org/patch.txt
[2]: http://harddisk.is-a-geek.org/compiling-errors.txt


--------------enigFE12098F5C3C35860953654F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHcpf6W6S2GapJUuQRAn6NAJ45mfHbNEcbMAFJ+8YAqM3cik9LLwCdFPQ8
W2XlWCaS7/xwKcc3yhfyD40=
=Fe4B
-----END PGP SIGNATURE-----

--------------enigFE12098F5C3C35860953654F--

--===============1507897121077026517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1507897121077026517==--
