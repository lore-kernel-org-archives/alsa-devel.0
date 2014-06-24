From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: cs4265: bindings: sound: Add binding for
 CS4265 CODEC.
Date: Tue, 24 Jun 2014 16:18:16 +0100
Message-ID: <20140624151816.GM23300@sirena.org.uk>
References: <1403562593-31952-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kkcDP0v44wDpNmbp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403562593-31952-1-git-send-email-Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawl.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--kkcDP0v44wDpNmbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2014 at 05:29:52PM -0500, Paul Handrigan wrote:
> This patch adds binding documentation for the Cirrus Logic CS4265 I2C COD=
EC.

Applied both, thanks.  I suspect you'll end up needing to split the
S/PDIF mute operation but it doesn't make such a big difference at the
framework level.

> Changes for v2:
>=20
> * Change DT reset pin name to "reset-gpios"

As covered in SubmittingPatches things like this should go after the
---.

--kkcDP0v44wDpNmbp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqZa1AAoJELSic+t+oim9FpUP/3P1KlHjoJ8ozY8Hbf9g/zKo
a0hCd6yrfXf3t6FYTsQ6eWi0VKa43r8/uy7az+SfDBKnISMhdmMd5Ifi8M/ygGbd
0nJ3jgMx4qxgKkQEvDh0U2yZ1KtF9Ua2knsJjdKAYA4EoWisHENuC423l5CSdkQH
kvKyw6NoTV0ryDd6eE/aZgDR6a/jFL7WEiju+cU3Eb5QfLWHf24G8XuD5gZRnoJO
Ncf/5S3/Z/4f26YhKM6SbSMcYoM+s0CwJWuwWUstOKwTWLPTqNqoEw8B7Y5Qd6kX
s9ILdwKlbkxemSd+Z7F+Jrs44VEQS1l5plcIsY+w+xOEbsJEIL4y/ZV8AouyNN43
ws3l6Ox//K1OX3fklsG1SJ1XNLnmtO5kxBjYxEH1k1VLwJy2lGPSbjp6W42xrEGH
2oaY6w1+kHxcJsjmjozjNe4ATA8Qmwqbi33sPx1+PTsMGMmZ6cAKDcozjmZyX6ZD
eq9q1Vz0JrOYvnmLadQtZ+uuqIuequvbzXffZoXeil67JoVne9VtWQi2wdz6nguD
UWYHtHTH+uxXMjzWG8pbfQXkssehoD3QFGc/LN3wtddyYVEU1FXJRxXdNrSRs35P
K1o6syZkjnHxID50G0Oo8MMmlxXQ+l4/1R9uYYc26WGQ1wtLnGgS2e7e5CBa9Xi2
cVlBggqXvY9xJyY2nYxE
=bZjB
-----END PGP SIGNATURE-----

--kkcDP0v44wDpNmbp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
