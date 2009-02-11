From: Tim Blechmann <tim@klingt.org>
Subject: snd_pcm_runtime.buffer_size question
Date: Wed, 11 Feb 2009 18:21:11 +0100
Message-ID: <49930907.2090108@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1261450555634907525=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 45D851037EB
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 18:21:31 +0100 (CET)
Received: from [10.9.3.234] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-5) with ESMTP id n1BHLUvD027789
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 18:21:30 +0100
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
--===============1261450555634907525==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC42748F9F6EC6E79B0082710"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC42748F9F6EC6E79B0082710
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi all,
i am currently fighting with the snd_pcm_runtime.buffer_size. how is the
value defined?

i would expect:
channels * periods * period_size * sample_bits/8
(in my case 64*5*128*3)

however in the code, i am working on, it seems to be:
periods * period_size
(in my case 5*128)

am i missing something obvious?

thanks, tim

--=20
tim@klingt.org
http://tim.klingt.org

Just what the hell is the experimental tradition?
  Morton Feldman



--------------enigC42748F9F6EC6E79B0082710
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmTCRsACgkQdL+4qsZfVss2NACgp7g6rWyLEvVrwoFSxchUO1UT
Q9UAn30zmXEbgBZJxamGa+WY5YvmtDHF
=IXb6
-----END PGP SIGNATURE-----

--------------enigC42748F9F6EC6E79B0082710--

--===============1261450555634907525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1261450555634907525==--
