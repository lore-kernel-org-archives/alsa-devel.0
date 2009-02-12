From: Tim Blechmann <tim@klingt.org>
Subject: Re: pointer callback question
Date: Thu, 12 Feb 2009 19:04:10 +0100
Message-ID: <4994649A.8080005@klingt.org>
References: <49946175.5070008@klingt.org>	<s5h1vu3k0bj.wl%tiwai@suse.de>	<499462A5.2000705@klingt.org>
	<s5hy6wbillh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6616635586072888224=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id F2CAE2414D
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 19:04:11 +0100 (CET)
In-Reply-To: <s5hy6wbillh.wl%tiwai@suse.de>
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
--===============6616635586072888224==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D5319C9D1678467DE8E7CD9"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D5319C9D1678467DE8E7CD9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
> At Thu, 12 Feb 2009 18:55:49 +0100,
> Tim Blechmann wrote:
>>>> the brief log is (4 periods of 64 frames):
>>>> stream_pointer at 64
>>>> stream_pointer at 128
>>>> stream_pointer at 192
>>>> stream_pointer at 256
>>> This is invalid.  The pointer callback must return 0 in this case.
>>> The value the pointer callback returns is between 0 and buffer_size-1=
=2E
>> sry, typo, 5 periods of 64 frames
>=20
> Then it must be OK.  If the stream is stopped, it's likely by the
> buffer underrun detection or so...

is there any way to compile alsa to get some debugging information about
that?

> BTW, you should be sure that the buffer size is aligned to the period=20
> size if such a design is assumed.  Without the extra constraint, it
> could be unaligned as default.

hm, afaict alignment should be ok ...

thnx, tim

--=20
tim@klingt.org
http://tim.klingt.org

A good composer does not imitate; he steals.
  Igor Stravinsky


--------------enig6D5319C9D1678467DE8E7CD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmUZJ4ACgkQdL+4qsZfVsta8QCdGZWL5s608D/2yUPjIjxkn/Mg
CqEAn2052mU3VckOm4fG3tRpe3SdqeQZ
=5/G+
-----END PGP SIGNATURE-----

--------------enig6D5319C9D1678467DE8E7CD9--

--===============6616635586072888224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6616635586072888224==--
