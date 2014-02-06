From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: pcm512x: Add PCM512x driver
Date: Thu, 6 Feb 2014 14:22:06 +0000
Message-ID: <20140206142206.GS32298@sirena.org.uk>
References: <1391689575-4039-1-git-send-email-broonie@kernel.org>
 <52F38CF7.7060306@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OtP8TOIcu2/MSuWQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52F38CF7.7060306-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--OtP8TOIcu2/MSuWQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2014 at 02:24:07PM +0100, Lars-Peter Clausen wrote:
> On 02/06/2014 01:26 PM, Mark Brown wrote:

> >+static const char *pcm512x_dsp_program_texts[] =3D {

> Nitpick: should be "static const char * const ...", a immutable
> array of pointers pointing to immutable strings. Same for all the
> enum texts in this driver.

Oh, good - someone fixed the core code for that without me noticing.
Last time I looked if you made the strings const there were annoying
warnings since they got passed in to things that weren't expecting const
strings and it seemed to annoying to check that it was actually safe in
all cases.

> Another reason why I think it is better to separate the I2C and SPI
> bits into different modules. If the registration of the SPI driver
> fails you'll return an error and the module will not be loaded. At
> the same time the i2c driver is already registered. I know that this
> is rather theoretical, but if we don't care if our error handling is
> correct, because we assume that the error will never happen, we do
> not need error handling at all.

Like I say I'm perfectly aware of the issues, I just don't have much
enthusiasm myself since they pretty much only affect unrealistic and
apparently quite rare randconfigs - the time I might spend on that is
more likely to get spent on things like the format negotiation stuff.
If someone (you? :P) wants to do the work that's fine but nobody had
shown any sign of that until your driver the other day. =20

I do also want to see some explicit conversion happening so it's clearer
that this is a deliberate change that's being rolled out.

--OtP8TOIcu2/MSuWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS85qLAAoJELSic+t+oim95NUP/2wXDzKr+Y8jQto8PAv2D9se
1roGIH7rSek4CvdkJcqFHe1CDMDT1SGqk4Snm4dKrBqJlcffLk9iy4aUr6fERiBd
P21OI3d20ADmjI/N9v2RqqHG8Rxfcvk3lj2g6aGWZE4/BlImTzkvEP0qzlMs0ksY
nKiBn9PSHqo4p3XBqCQM5+9Mdrmpx5G674Zm3BvrA9+T8oMftcgxkVCOFcNUIvL1
Y6L/WPhFpB0poISzWgsQJFJOr7xLPxQqi+C1TJ7FsXEY0VJe40GEKCP8yCJLpH7k
zVnDtgakO63MkKUVmy5wXh17mMGFw/QJsGKXqybCCTDSYq1/HQCpUjqp49wLYKjn
wxNyFvS2q1BPz/jPmWm2iBYMnYHrv3ItNZff9QEFkfarrP9ThRofM3wL+GmbEhv3
RRKbAvX6hcj6j9ruQAEKNA5FVwrno+Vwt0dyFZDiESgbdHsw2DBA1rNkXabGUhOX
dGsm9WOj1x+CmeRC2/wRHywHBpME8cS73xSvSF4OiG9EwXQyKlp/r9WBDayFGZ4z
e0FpvUSbwQeUCSLeJZaFjZ8dJKBzq3D6RvlT3m9LMQN/maemg8RIdDXRAsqq9550
UVxnVC2fzr8Io+LI+ZT+peTLmriTq0QHV0j8+5PL+N000mwtM22SVQT4ze7qNcWS
rx06fcpKKMyPNvNySFOd
=jXv5
-----END PGP SIGNATURE-----

--OtP8TOIcu2/MSuWQ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
