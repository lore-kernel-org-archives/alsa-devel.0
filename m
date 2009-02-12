From: Tim Blechmann <tim@klingt.org>
Subject: Re: pointer callback question
Date: Thu, 12 Feb 2009 18:55:49 +0100
Message-ID: <499462A5.2000705@klingt.org>
References: <49946175.5070008@klingt.org> <s5h1vu3k0bj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3917123587239182649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id F00B91037FE
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 18:55:51 +0100 (CET)
In-Reply-To: <s5h1vu3k0bj.wl%tiwai@suse.de>
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
--===============3917123587239182649==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC22CA805F7C7B4E9AAF632E3"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC22CA805F7C7B4E9AAF632E3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> the brief log is (4 periods of 64 frames):
>> stream_pointer at 64
>> stream_pointer at 128
>> stream_pointer at 192
>> stream_pointer at 256
>=20
> This is invalid.  The pointer callback must return 0 in this case.
> The value the pointer callback returns is between 0 and buffer_size-1.

sry, typo, 5 periods of 64 frames

--=20
tim@klingt.org
http://tim.klingt.org

The aim of education is the knowledge, not of facts, but of values
  William S. Burroughs


--------------enigC22CA805F7C7B4E9AAF632E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmUYqoACgkQdL+4qsZfVssDnACfah96gRX1ijuC3FEmjKf5g4qb
3d4AnArTsQE0n8qjC6To5fWzeDCqgy/k
=9ijj
-----END PGP SIGNATURE-----

--------------enigC22CA805F7C7B4E9AAF632E3--

--===============3917123587239182649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3917123587239182649==--
