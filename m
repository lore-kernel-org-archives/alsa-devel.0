From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: frequency analysis with alsa and fftw
Date: Sun, 27 Dec 2009 13:53:43 +0100
Message-ID: <20091227125343.GG7599@lug-owl.de>
References: <20091227122631.62660@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1457662004994457877=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	by alsa0.perex.cz (Postfix) with ESMTP id BF33524490
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 13:53:44 +0100 (CET)
In-Reply-To: <20091227122631.62660@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Vogl <markus.vogl@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1457662004994457877==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enbeIAqa8YisR7TD"
Content-Disposition: inline


--enbeIAqa8YisR7TD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-12-27 13:26:31 +0100, Markus Vogl <markus.vogl@gmx.net> wrote:
> my project is to analyse the mic input frequency from my asus eepc
> 1008ha with ubuntu 9.10  and show it in a terminal window. i would
> use my acoustic 6 string guitar to play in front of my netbook.
> =20
> i=C2=B4ve testet the howto from linuxjornal.com ..
> http://www.linuxjournal.com/article/6735
> =20
> ...but i=C2=B4ve no plan to use the mic input and  then analyse it with f=
ftw.

Why do you need to do ALSA programming in the first place? Isn't it
enough to use any given ALSA-capable audio recorder (eg. arecord) to
record some sound, convert it to raw PCM data (eg. cut off the WAV
header) and then shift all the data into the FFT lib?

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
 Signature of:                            If it doesn't work, force it.
 the second  :                   If it breaks, it needed replacing anyway.

--enbeIAqa8YisR7TD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks3WNcACgkQHb1edYOZ4bvfgACfaXg9h0fuIzC0jgcnGiECBsgR
2aEAoJIJz1PdMyXI9C0Dpui6bxy6d8/e
=9hHF
-----END PGP SIGNATURE-----

--enbeIAqa8YisR7TD--

--===============1457662004994457877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1457662004994457877==--
