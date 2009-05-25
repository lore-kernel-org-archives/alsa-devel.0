From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 20:27:14 +0200
Message-ID: <4A1AE302.8080702@yellowcouch.org>
References: <4A1AB98B.9010604@yellowcouch.org>
	<s5hk54589xd.wl%tiwai@suse.de>	<4A1ADAEF.3070803@yellowcouch.org>
	<s5h8wklvyfc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1646422508059322795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A2CA2447E
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 20:25:14 +0200 (CEST)
In-Reply-To: <s5h8wklvyfc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1646422508059322795==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDA8BC93BB70E82E5D4930C62"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA8BC93BB70E82E5D4930C62
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
> You can control it via fcntl().  See fcntl(2) man page.
>  =20
I looked at that but I didn't find any place in alsalib (or libalsa
whatever the order of those two words), where I can obtain the file
handle. They are all of type pcm_something_t. I found a file handle
quite deep in this library but there seems no way to actually obtain
that handle.

Do you think fcntl on a pcm_t device would work (if we got it to compile
first :-)

Werner,-

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enigDA8BC93BB70E82E5D4930C62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoa4wMACgkQYJM5sO5rAR3kFQCggBJZfQiWeBSiAX1tr6LdMvgT
vwQAoNdz5q96w6ou03mOHbeOzfdxinl7
=Vp3h
-----END PGP SIGNATURE-----

--------------enigDA8BC93BB70E82E5D4930C62--

--===============1646422508059322795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1646422508059322795==--
