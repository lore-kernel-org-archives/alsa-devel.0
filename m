From: Tim Blechmann <tim@klingt.org>
Subject: alsa driver for digigram lx6464es
Date: Sun, 22 Mar 2009 20:34:08 +0100
Message-ID: <49C692B0.7040609@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6547467602461908982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 22FCC2434C
	for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2009 20:34:16 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6547467602461908982==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC8BF25949A9764E99F91172C"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8BF25949A9764E99F91172C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi all,

i have implemented the prototype of an alsa driver for the digigram
lx6464es audio interface. audio i/o is basically working, although not
very well tested, yet. the driver is available from my git repository [1]=
=2E

features:
- i/o support for 64 channels via ethersound [2]

missing features:
- handling of xrun notification
- configuration of the ethersound network needs to be done externally

takashi, i would like to submit the patch to alsa soon ... how should i
proceed? can you do a review of the code?

thanks, tim

[1]
http://tim.klingt.org/git?p=3Ddigigram.git;a=3Dshortlog;h=3Drefs/heads/lx=
6464es
[2] http://www.ethersound.com/

--=20
tim@klingt.org
http://tim.klingt.org

I don't write music for sissy ears.
  Charles Ives


--------------enigC8BF25949A9764E99F91172C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknGkroACgkQdL+4qsZfVsuS4QCgnKD4NRzPicsg31zVWeyk3HyW
SfgAoIwUMlc4uX+xcrUWsfMvElyfXStP
=n5bw
-----END PGP SIGNATURE-----

--------------enigC8BF25949A9764E99F91172C--

--===============6547467602461908982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6547467602461908982==--
