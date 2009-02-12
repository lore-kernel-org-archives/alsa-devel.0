From: Tim Blechmann <tim@klingt.org>
Subject: pointer callback question
Date: Thu, 12 Feb 2009 18:50:45 +0100
Message-ID: <49946175.5070008@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5433879574316518027=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 585861037E3
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 18:50:48 +0100 (CET)
Received: from [10.9.3.234] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-5) with ESMTP id n1CHolV3010851
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 18:50:47 +0100
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
--===============5433879574316518027==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig515DB2E1D5DBE0C6AB2D49B2"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig515DB2E1D5DBE0C6AB2D49B2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi all,

one question about the pointer callback.

the docs say:
>  This callback is called when the PCM middle layer inquires the current=

>  hardware position on the buffer. The position must be returned in
frames,
>  ranging from 0 to buffer_size - 1.

i am using a ringbuffer to communicate with my audio device. but when
the position is reset to 0, alsa requests to stop the stream
(SNDRV_PCM_TRIGGER_STOP).

the brief log is (4 periods of 64 frames):
stream_pointer at 64
stream_pointer at 128
stream_pointer at 192
stream_pointer at 256
stream_pointer at 0

after returning 0, a stop is requested.

am i missing something?
thanks, tim

--=20
tim@klingt.org
http://tim.klingt.org

Contrary to general belief, an artist is never ahead of his time but
most people are far behind theirs.
  Edgar Var=C3=A8se


--------------enig515DB2E1D5DBE0C6AB2D49B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmUYXkACgkQdL+4qsZfVstN+QCgiTWXrUbPvzNWcUvVo33yFHOr
PVoAmgL3WVflA9/AY67hMsPD0WGfpH/M
=jI/h
-----END PGP SIGNATURE-----

--------------enig515DB2E1D5DBE0C6AB2D49B2--

--===============5433879574316518027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5433879574316518027==--
