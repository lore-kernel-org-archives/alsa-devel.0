From: Tim Blechmann <tim@klingt.org>
Subject: Re: alsa driver for digigram lx6464es
Date: Mon, 23 Mar 2009 12:04:43 +0100
Message-ID: <49C76CCB.6000003@klingt.org>
References: <49C692B0.7040609@klingt.org>
	<s5hljqwlogv.wl%tiwai@suse.de>	<49C763C3.3000509@klingt.org>
	<s5htz5k5xas.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0943409399301018265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E5A81037FF
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2009 12:04:46 +0100 (CET)
In-Reply-To: <s5htz5k5xas.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0943409399301018265==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDC49C7AEB08321F48621024A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC49C7AEB08321F48621024A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> please note, that i included 4 header files and some minor code portio=
ns
>> from digigram's windows driver, which do not match the linux coding
>> style. i preferred to do so in order to keep the similarity to the
>> windows driver, which was my main reference for implementing the drive=
r.
>=20
> Well, basically it doesn't help to keep the non-standard coding style.
> Once after your code is merged to the kernel tree, it's no more your
> baby.  Everyone will modify the code, and one of people's favorite
> actions is to re-format codes to improve the readability :)

ok, i'll write a new header file for the specific definitions ... that's
probably better than messing with Lindent or similar to reformat the
digigram sources ...

and thanks for the other comments ... i'll adapt the code ...

cheers, tim

--=20
tim@klingt.org
http://tim.klingt.org

I don't write music for sissy ears.
  Charles Ives


--------------enigDC49C7AEB08321F48621024A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknHbM4ACgkQdL+4qsZfVstqEwCfS1UsCnDGXGwSsNU0yXnhQI7q
DikAnRDKaqJT+yzyhnxlYRieErLhdrx2
=6XDI
-----END PGP SIGNATURE-----

--------------enigDC49C7AEB08321F48621024A--

--===============0943409399301018265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0943409399301018265==--
