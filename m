From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: K42Jc Notebook(ALC269) port switch between headset,
 headphone, mic
Date: Thu, 03 Mar 2011 17:37:08 +0100
Message-ID: <1299170228.4457.15.camel@mattotaupa>
References: <AANLkTikZoGUFHpVXd6H1XbLchjEvuYd8j=mRfYCpayS5@mail.gmail.com>
	<AANLkTi=k0k1WqHcxJBSWXkeE5jkcTdG3iRUvERuoVoob@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2402858161312172261=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 288D1103819
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 17:37:11 +0100 (CET)
Received: from f053036173.adsl.alicedsl.de ([78.53.36.173]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1PvBWX-0003JV-Gy
	for alsa-devel@alsa-project.org; Thu, 03 Mar 2011 16:37:09 +0000
In-Reply-To: <AANLkTi=k0k1WqHcxJBSWXkeE5jkcTdG3iRUvERuoVoob@mail.gmail.com>
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


--===============2402858161312172261==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-atJmduKFLxC4HvptMXLj"


--=-atJmduKFLxC4HvptMXLj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Madura,


Am Montag, den 28.02.2011, 23:12 +0530 schrieb Madura Anushanga:

> I want to switch between headphone, headset, mic input/output modes when =
I
> plug in devices. Alsamixer shows two capture channels, one is for the
> internal mic. I don't know how to use the other. I've tried switching som=
e
> things on and off in hda-analyzer but I failed to get the functionality t=
hat
> I wanted. This notebook only has one audio port(TRS 3.5mm), so the select=
ion
> is vital if I'm going to use an external mic. Currently the port is actin=
g
> as an output only port. And something fishy goes on when I select "Analog
> Stereo Input" in profiles in Sound Preferences. It lets me use the extern=
al
> mic through the audio port but only if I push the jack half way, the inpu=
t
> is detected and I can record it(but there's no sound output after I selec=
t
> this profile, its input only). I some how think that this is the "mic" mo=
de
> and if I can get it to work on "headset" mode then I'd be able to use it =
for
> input and output.
>=20
> This is the information that I got from the script,
> http://www.alsa-project.org/db/?f=3De70dae201e5d830874536be93090aef0454c8=
c1e

Please also attach it next time, so no browser is needed to view these
details.

        !!Linux Distribution
        !!------------------
       =20
        Ubuntu 10.10 \n \l DISTRIB_ID=3DUbuntu DISTRIB_DESCRIPTION=3D"Ubunt=
u 10.10"

Since you are using Ubuntu 10.10, the easiest way is to follow their
instructions to solve sound related problems and report it them using
`ubuntu-bug audio` [1]. There are several developers working for(?)
Ubuntu who will probably be able to help you really quick.


I am sorry to not be able to help you right away. Thanks,

Paul


[1] https://wiki.ubuntu.com/DebuggingSoundProblems

--=-atJmduKFLxC4HvptMXLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1vw7QACgkQPX1aK2wOHVgK3ACfcK+ktCAj+/7AY3FGysBeIR7J
6cQAmgKw6I5Yn8zZuPGxEF1669AW3tmy
=xoHD
-----END PGP SIGNATURE-----

--=-atJmduKFLxC4HvptMXLj--


--===============2402858161312172261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2402858161312172261==--
