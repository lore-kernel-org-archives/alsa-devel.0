From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: frequency analysis with alsa and fftw
Date: Sun, 27 Dec 2009 15:04:54 +0100
Message-ID: <20091227140454.GH7599@lug-owl.de>
References: <20091227122631.62660@gmx.net> <20091227125343.GG7599@lug-owl.de>
	<DCFE698CA76D4C32B964618FB02D7745@RDF2008PC>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5056124770442033383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 84F4224366
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 15:04:54 +0100 (CET)
In-Reply-To: <DCFE698CA76D4C32B964618FB02D7745@RDF2008PC>
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


--===============5056124770442033383==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kPepdeVVZyud5ZkI"
Content-Disposition: inline


--kPepdeVVZyud5ZkI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-12-27 14:50:20 +0100, Markus Vogl <markus.vogl@gmx.net> wrote:
> Von: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de]:
> > On Sun, 2009-12-27 13:26:31 +0100, Markus Vogl <markus.vogl@gmx.net> wr=
ote:
> > > my project is to analyse the mic input frequency from my asus
> > > eepc 1008ha with ubuntu 9.10  and show it in a terminal window.
> > > i would use my acoustic 6 string guitar to play in front of my
> > > netbook.
> > > =20
> > > i=C2=B4ve testet the howto from linuxjornal.com ..
> > > http://www.linuxjournal.com/article/6735
> > > =20
> > > ...but i=C2=B4ve no plan to use the mic input and  then analyse it
> > > with fftw.
> >=20
> > Why do you need to do ALSA programming in the first place? Isn't
> > it enough to use any given ALSA-capable audio recorder (eg.
> > arecord) to record some sound, convert it to raw PCM data (eg. cut
> > off the WAV header) and then shift all the data into the FFT lib?
>
> i have to do this in realtime (like a guitartuner) and with my
> "project" i have to see the frequency shift in realtime in a
> terminal window.

Sure. Just let eg. arecord write to stdout or to a FIFO and read the
data from there. You can directly request raw output, all you need to
do is to shouvle the data through the FTT lib...

MfG, JBG
PS: I did some clean-up of your TOFU email.

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                     Eine Freie Meinung in einem Freien Kopf
the second  :                   f=C3=BCr einen Freien Staat voll Freier B=
=C3=BCrger.

--kPepdeVVZyud5ZkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks3aYYACgkQHb1edYOZ4bt8mwCfaH0wN1/3std2F963pAnBVljG
JZkAn0mE2+XD/36g5vLMisiZrRF+4yGh
=TKRf
-----END PGP SIGNATURE-----

--kPepdeVVZyud5ZkI--

--===============5056124770442033383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5056124770442033383==--
