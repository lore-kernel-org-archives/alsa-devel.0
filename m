From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: cs4265: bindings: sound: Add bindings for
 CS4265 CODEC
Date: Fri, 23 May 2014 21:28:58 +0100
Message-ID: <20140523202858.GM22111@sirena.org.uk>
References: <1400872614-21666-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IHQEUyCPif9NwElJ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400872614-21666-1-git-send-email-Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--IHQEUyCPif9NwElJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 02:16:53PM -0500, Paul Handrigan wrote:

> +Optional properties:
> +
> +  - reset-gpio : a GPIO spec for the reset pin. If specified, it will be
> +		 deasserted before communication to the codec starts.

GPIO properties are supposed to be named -gpios by convention even if
they only specify a single GPIO.

--IHQEUyCPif9NwElJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTf6+BAAoJELSic+t+oim9cvcP/RXEHHfMnxv/iM9qpGUcWeus
puen8SLQiint0YM45bJJQUY77QzjbB2DBesqDJsnzloFpHLNPeZG0QerFgbg2tXo
bVywGBQhrq8WfI3zM+FRODmZERBDhzd3MxeNZ4u2qsJxqq8u687ozQZseiu1uwuo
0eXF8/6BoarGtXKrE9hnKi3UkhqDDYL66zdFuUbkvCkWYVq8XuAQVoKon8mWvj65
ovMpi+vemie7fretVNWtQmgrXLOY5QtGNwRCIMfJ0GKVLNXyl4QnUJ6J5sW6dXpd
0Q33tb1QnbsCCTPnxyov4/0R9GSYuTHq/o2wCdGiWdN5dFjXr9xfbYiDgcX64W1r
Czbzunb9UJjV4MJE4/SjWBFrQn1GRep+KBSsIPkbE+beneQML87VNE4XDeAOnsRR
KwijVOtFOHBAfNx33ACjb2AuqlpBI8fuj1W8A+/xGwFbxZLqaoawqwpFQDUKlihD
rdB40jSGADQ7cYjRiI8wNP8gRmOAumm53d4izLGjX3Fpn6s6pAUdLPJ/pnE8IaCF
Tx5IkWSyPdZBHoBhKn7ga1acXz5bJLCwaOxHYHX5PFD5Vc8VAHr0T2iVpVoqLeY3
9ai8QehrAHPH9aC7COlsKQ/DCmwwHmSznjvEzjvNB2tyZmzLokJNElltG3mT6ZVg
bxVbZDKj0ikl3qubRr/p
=Ivei
-----END PGP SIGNATURE-----

--IHQEUyCPif9NwElJ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
