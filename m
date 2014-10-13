From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] audio: sgtl5000: Add MicBias resistor support in DT
Date: Mon, 13 Oct 2014 12:10:08 +0200
Message-ID: <20141013101008.GF27755@sirena.org.uk>
References: <1413149951-2882-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <20141013100504.GA14739@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHDeMLmKefytWajp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141013100504.GA14739@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>, "fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--PHDeMLmKefytWajp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2014 at 11:05:04AM +0100, Mark Rutland wrote:
> On Sun, Oct 12, 2014 at 10:39:11PM +0100, Jean-Michel Hautbois wrote:
> > Some systems may require a different resistor than the default one (4K).
> > This adds a property in sgtl5000 codec.
> > It keeps the default of 4K when nothing is specified so it does not bre=
ak
> > existing code.
> >=20
> > v2: modify the default case on DT parsing

Don't include noise like this in the changelog, add it after the --- as
covered in SubmittingPatches.

> > +- sgtl5000-micbias-resistor : the bias resistor to be used
> > +        1 or SGTL5000_MICBIAS_2K - MICBIAS resistor is set to 2K
> > +        2 or SGTL5000_MICBIAS_4K - MICBIAS resistor is set to 4K
> > +        3 or SGTL5000_MICBIAS_8K - MICBIAS resistor is set to 8K
> > +        0 or SGTL5000_MICBIAS_OFF - MICBIAS resistor is not used
> > +	If this node is not mentioned or if the value is unknown, then
> > +	micbias	resistor is set to 4K.

> The SGTL5000_MICBIAS_* constants aren't in a DT header, so shouldn't be
> referenced here.

Or the constants should be moved of course but...

> Why not have mcbias-resistor-k-ohms as 2, 4, 8, or 0?

> That would be much easier to read as a human.

=2E..this is even better.

--PHDeMLmKefytWajp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO6UAAAoJECTWi3JdVIfQjw4H/3cFrKjjZwyfwpj0RGP3KXhg
Wj9tsszXq99xa5CUNpvMvOGcstDZIJTx6DSGJRMFpXfWwz/fGZwiK/aKsYTYObHn
4B3x3IQB4FnJ9kgNSpkYSeygNMdL6TJwZ7NYE+22ml7hMtZHh77wi0WKAgR0hJbs
y9O65Om9O+PC/TTv1Ouux8opfhKPeGB/Zm22v+vCkCHkUxbCWzO26+SIyYvrSGfp
pMlRgKBa8rj+Mracj/In36dZOeOrNwmbLgzc3CTfCqUtfhVQLlh6a0+FGobFiwoV
H903t3oXJmIg3n5Rudw2BzjNGkMZM4Jc9erV8/ybxfy0ceytkMYvRsnQ7hroXQ4=
=y50+
-----END PGP SIGNATURE-----

--PHDeMLmKefytWajp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
