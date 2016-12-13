From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for CS43130 codec
Date: Tue, 13 Dec 2016 17:05:13 +0000
Message-ID: <20161213170513.sik7igsdeg2mdyx2@sirena.org.uk>
References: <09a77398-831b-4be7-9089-f7ac4fcfc16a@EX4.ad.cirrus.com>
 <20161208162336.l5g5cbcc2bzt65ke@sirena.org.uk>
 <148597dd-ce8d-4684-8f39-149e780d2b3b@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r2aaxzesnobkfsgq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <148597dd-ce8d-4684-8f39-149e780d2b3b-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "Austin, Brian" <Brian.Austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--r2aaxzesnobkfsgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 02:21:03PM -0600, li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org wrote:
> Thank you for timely feedback.
>=20
> I have fixed all except following.

Please fix your mail client configuration, it is not marking quoted
material as quoted and there's no word wrapping which makes everything
very hard to read.

> -------------------------------------------------------------------------=
--------------------------------------------------------------------------

There's also random stuff like the above appearing in the mail.

I strongly suggest working with some of your colleagues who are more
familiar with working upstream to try to understand the processes and
tooling.

> -------------------------------------------------------------------------=
--------------------------------------------------------------------------
> > +     /* Enable HP detect */
> > +     regmap_update_bits(cs43130->regmap, CS43130_HP_DETECT,
> > +             CS43130_HP_DETECT_CTRL_MASK, CS43130_HP_DETECT_CTRL_MASK);

> Why enable this when the only handling is a couple of log messages?

> Placeholder for driver modification when the driver is integrated to syst=
em such as Android OS.

> I suppose I could remove it, but when the driver is integrated into actua=
l system, it may not be clear to system integrators,
> where to add HP DET IRQ hooks

Don't just add unfinished code that does nothing useful - that just
wastes everyone's time and makes the driver harder to review.  I'm
fairly sure that if people are able to implement jack detection they
will be able to figure out the fairly trivial code that's here and of
course this is something that when it's done should be just a driver
feature accessed through normal driver APIs.

--r2aaxzesnobkfsgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhQKkgACgkQJNaLcl1U
h9B31wf/aWjvC4TbLI8q8URB3qP4ZgS8AsfR7YLn6fFwyfin5raQLycV+LXiY3Zh
s191RZWCANGrrYHCMXPgpIl7poiL9F8c9Fd4yjNKh+1TSlUgdL+zzdtO0MGxrDr1
FzTmlSEwXxngDswGxGfM1CPoqg+2hlFysoYNbCVYGoNdIo15x2zsI0v+d65Qlr72
BHJ9ytV58TuvmwROiYCIL1ou8UkeKaQm1TVb0wvPjwiLDk488eHJngmqbqMu0dWY
YyO6oEFbSfoXj/Qw/aj9irJxIyR2LxTJ63jiBrPiLwPLuEpELOvnKOoWW7PPff47
6Yl+sBi7XA1YKLxQpqSiG0XzQwElxg==
=2BVD
-----END PGP SIGNATURE-----

--r2aaxzesnobkfsgq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
