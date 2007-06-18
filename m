From: Ed Schouten <ed@fxq.nl>
Subject: Changing the sample rate/channels of an already opened
	PCM stream
Date: Mon, 18 Jun 2007 20:47:58 +0200
Message-ID: <20070618184758.GL27942@hoeg.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8085038342974260737=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from palm.hoeg.nl (mx0.hoeg.nl [83.98.131.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 35914243DA
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 20:47:59 +0200 (CEST)
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


--===============8085038342974260737==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ucgz5Oc/kKURWzXs"
Content-Disposition: inline


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I am the author of the command line music player Herrie
(http://herrie.info/). For a long time folks have asked me to add
support for OSS to Herrie, so this morning I decided to install Linux on
a spare disk of mine (Ubuntu 7.04, FWIW) to hack on ALSA support for
Herrie.

After (a real lot of) hours of reading code, reading the Doxygen stuff,
etc. I now have a functional ALSA output module for Herrie. It was quite
hard to get it working, so I guess I owe myself a beer! ;-)

Anyway, there still is one disadvantage to my module; each time I detect
that a new track is going to be started that needs a different amount of
channels or sample rate, I reopen the ALSA device, something that is
just impossible. The reason why it's impossible: Herrie has a nifty
chroot() functionality that allows users to trap the application in a
certain directory.

I have been trying to get the device to reset so I can change the sample
rate, but for some reason, it just gets ignored. Can someone explain me
how it's possible to reset the sample rate after preparing the handle?

For your information, here's a link to the latest version of the source
code of my ALSA module:

	http://g-rave.nl/gitweb?p=3Dherrie;a=3Dblob;f=3Dherrie/src/audio_output_al=
sa.c

Yours,
--=20
 Ed Schouten <ed@fxq.nl>
 WWW: http://g-rave.nl/

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (FreeBSD)

iD8DBQFGdtNe52SDGA2eCwURAn/rAJ42dpkTRLevEfZ0KCHznxtnKrnWowCfep0N
062qjuZ0sFlODOFuRcZppRo=
=Q/lf
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--

--===============8085038342974260737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8085038342974260737==--
