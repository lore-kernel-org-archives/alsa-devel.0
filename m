From: Tim Blechmann <tim@klingt.org>
Subject: Re: RME HDSP rev 37 does not work on 64-bit linux
Date: Sun, 01 Feb 2009 17:56:34 +0100
Message-ID: <4985D442.50509@klingt.org>
References: <70a871c80902010708s2a10ff8bobe79622949da62fe@mail.gmail.com>	<70a871c80902010713p2b49c7cbj98356d56bdb4ed62@mail.gmail.com>	<200902011616.49454.faber@faberman.de>
	<70a871c80902010846i1059ab26t63c1d7e530126caf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3288087818792681767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id D67A22437C
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 17:56:34 +0100 (CET)
In-Reply-To: <70a871c80902010846i1059ab26t63c1d7e530126caf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3288087818792681767==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC02FFF4F52E989BC80893E7"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC02FFF4F52E989BC80893E7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>>> under 32-bit ubuntu 8.10 with the same kernel 2.6.27-11-generic and
>>> the same version of alsa-*: 1.0.17-0ubuntu1,
>>> everything works fine both with cold boot + hdsploader and winxp ->
>>> reboot-> no hdsploader.
>> It works fine with 64 bit linux, I have pure 64 bit machines and all h=
dsp(e)
>> cards work as they should. Must be something else then.
>=20
> Which distribution/kernel(s) do you use?
>=20
> I just revived my 64-bit Gentoo partition, and vanilla 2.6.28.2 says
> No Multiface or Digiface found, disabling the card.

i have the same issue with my hdsp on a 64-bit kernel, using the
standard firmware (whatever is shipped with alsa). once i tried to debug
this issue, finding, that the card actually has the register value that
the card is not connected, although it is.

usually, unloading/reloading the kernel module should resolve it,
though. maybe the hardware is not initialized correctly? are there some
more detailed information about the hdsp hardware available or did the
developers of the kernel module receive some specification under nda
restrictions?

tim

--=20
tim@klingt.org
http://tim.klingt.org

You can play a shoestring if you're sincere
  John Coltrane


--------------enigBC02FFF4F52E989BC80893E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmF1EUACgkQdL+4qsZfVstobgCgjel/e11BZFUyrD1kL4kaIB1o
iKgAoJGNluLp6Eb5gHrDvZHd0Op3iryW
=B+9l
-----END PGP SIGNATURE-----

--------------enigBC02FFF4F52E989BC80893E7--

--===============3288087818792681767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3288087818792681767==--
