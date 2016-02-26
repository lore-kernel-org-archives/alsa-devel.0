From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: ads117x: Add device tree compatible string
Date: Fri, 26 Feb 2016 11:14:06 +0900
Message-ID: <20160226021406.GG18327@sirena.org.uk>
References: <1454686334-9668-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1454686334-9668-3-git-send-email-florian.vaussard@heig-vd.ch>
 <56CD5D85.8070501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DtJW00gg9Uj+27As"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56CD5D85.8070501-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Vaussard <florian.vaussard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--DtJW00gg9Uj+27As
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2016 at 08:36:37AM +0100, Florian Vaussard wrote:
> >  			.name =3D "ads117x-codec",
> > +			.of_match_table =3D of_match_ptr(ads117x_dt_ids),
> >  	},
> > =20
> >  	.probe =3D ads117x_probe,
> >=20

> Do you have any more comments on this patch?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  Sending content
free pings just adds to the mail volume (if they are seen at all) and if=20
something has gone wrong you'll have to resend the patches anyway.

--DtJW00gg9Uj+27As
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWz7TsAAoJECTWi3JdVIfQMVoH/3vuy5GhyhACQ2doDvIvANI2
VZyoEJH1ctqOpQgqWcYA7IZ/pHohAE4szCJ5UVfaanMoKRIQEThFs3Tw2/wpwTSb
Jax++y0o6Ocp4ZydV4StGnSV410E6kk4oYsnk/dCJDeykizf4+4WlBkAqIXtik4+
zS/c4+qTc10d4Hgy+P++5rO+3jT76sbEUrzbGQBQYyjc3Tmxk22cZQaRSR7H7S0e
v7NgNELCl+2l0/7iW3rkCTyLrFYSaj7tZsTD4K0wLko66cbUTFNaImauymNks+Tm
+/tnUrbs/DBeTOiUFvWW5jqRpogb50cWQ3ULRAa4zJhI5QR8mH0nqJazITA3sZw=
=nV9P
-----END PGP SIGNATURE-----

--DtJW00gg9Uj+27As--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
