From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Subject: Re: Since kernel-2.6.32 alsactl thinks my sound card
 is "Unknown"
Date: Tue, 07 Sep 2010 13:39:40 +0200
Message-ID: <1283859581.24491.6.camel@localhost.localdomain>
References: <alpine.LNX.2.00.1009021538070.10278@eeebox2.perex-int.cz>
Reply-To: pacho@condmat1.ciencias.uniovi.es
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8093010899521789991=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp02.jazztel.es (smtp02.jazztel.es [62.14.3.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 9605524383
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 13:39:51 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1009021538070.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============8093010899521789991==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-frmFfrBInB4Wdi4AOEoP"


--=-frmFfrBInB4Wdi4AOEoP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 02-09-2010 a las 15:38 +0200, Jaroslav Kysela escribi=C3=B3:
> On Thu, 2 Sep 2010, Pacho Ramos wrote:
>=20
> >> Perhaps "Generic" hardware?
> >>
> >
> > Looks fine for me :-)
>=20
> I changed the message to text like:
>=20
> Found hardware: "HDA-Intel" "Realtek ALC888" "HDA:10ec0888,10438331,00100=
001" "0x1043" "0x8331"
> Hardware is initialized using a generic method
>=20
>  					Jaroslav
>=20
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>=20
>=20

I have seen the changes, thanks :-D, but could you also update
alsactl/init/00main information? It's still referring to an "error":
#   5) if RESULT!=3D"true", initialize hardware using a guess method,
#      print an error message and return with exit code 99


Thanks a lot

--=-frmFfrBInB4Wdi4AOEoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyGJHwACgkQCaWpQKGI+9RdmQCfePa0c6Kc6+k0JWbbYoYybwnN
56gAnjvqrY3zZ2K0IECIslPQiGyR6Yye
=FYjX
-----END PGP SIGNATURE-----

--=-frmFfrBInB4Wdi4AOEoP--


--===============8093010899521789991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8093010899521789991==--
