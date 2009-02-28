From: Tim Blechmann <tim@klingt.org>
Subject: Re: pointer callback question
Date: Sat, 28 Feb 2009 13:48:14 +0100
Message-ID: <49A9328E.2090304@klingt.org>
References: <49946175.5070008@klingt.org>	<s5h1vu3k0bj.wl%tiwai@suse.de>	<499462A5.2000705@klingt.org>	<s5hy6wbillh.wl%tiwai@suse.de>
	<49A6AABD.7040300@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3415616598967942626=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id A8AB01037FB
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 13:48:18 +0100 (CET)
In-Reply-To: <49A6AABD.7040300@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3415616598967942626==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig350F7AB6F50851000E89BD71"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig350F7AB6F50851000E89BD71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> directly after returning 0 from the pointer callback, alsa requests a s=
top:
> [ 2825.559067] ->lx_pcm_trigger
> the timing seems to be fine (2.7 ms for 128 frames).
>=20
> any idea, why alsa wants to stop the transfer? am i missing something,
> like to i need to inform alsa, that the cyclic buffer wraps around?

hm, answering my own question ... moving card interaction from the
interrupt handler to a tasklet seems to solve the issue now ...

--=20
tim@klingt.org
http://tim.klingt.org

I had nothing to offer anybody except my own confusion
  Jack Kerouac


--------------enig350F7AB6F50851000E89BD71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmpMpMACgkQdL+4qsZfVsssnQCgjuqFe582zp/3nvnzdlCnRyip
Xa4An1Ma9Hxm1Cdktf0n9VC/0jWTr/yd
=Fyww
-----END PGP SIGNATURE-----

--------------enig350F7AB6F50851000E89BD71--

--===============3415616598967942626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3415616598967942626==--
