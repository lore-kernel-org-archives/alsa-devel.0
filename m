From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/5] ASoC: adau17x1: Support platform data via DT
Date: Thu, 18 Feb 2016 17:38:49 +0000
Message-ID: <20160218173849.GA6065@sirena.org.uk>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
 <1455627405-18155-6-git-send-email-andire@axis.com>
 <20160218143735.GS9654@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160218143735.GS9654@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal-VrBV9hrLPhE@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas =?iso-8859-1?Q?Irest=E5l?= <andire-VrBV9hrLPhE@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2016 at 08:37:35AM -0600, Rob Herring wrote:
> On Tue, Feb 16, 2016 at 01:56:45PM +0100, Andreas Irest=E5l wrote:

> > +	MICBIAS_0_90_AVDD - 0.9 * AVDD
> > +	MICBIAS_0_65_AVDD - 0.65 * AVDD

> What does this mean?

It's specifying the microphone bias as a function of the AVDD supply
voltage.  This should be obvious to anyone with any knowledge of the
domain, it's a fairly common way of configuring such things.

> > +Optional properties (ADAU1361/ADAU1461/ADAU1761/ADAU1961 only)

> > + - adi,jack-detection	If present, configures codec to use the digmic/j=
ackdet
> > +			pin for jack detection. must provide one of
> > +			JACKDETECT_ACTIVE_LO or JACKDETECT_ACTIVE_HI followed
> > +			by debounce time in ms, which must be 5, 10, 20, or 40.

> Seems like this could be common. No existing examples to copy?

If it's just a GPIO with a fancy name and some offloading (sounds like
it) there's an existing binding for the GPIO.

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxgGiAAoJECTWi3JdVIfQdvUH/0CsvQio0j6QtqIYBaW7rfEZ
oi5NH7f88TFFMlFLZ8oqaQiK+qm8LDzhgqE+4XmTWLtJMN/28Jcs6vVM18LW4wXj
WvED00sDz4ymVqu5xHRelzuUTBakvK1gRA2wFlm8BPcdq0UFiEvow/1LdNV4OtUb
yMv2YWjgRlehKWJia8TQU3lh2CSsLx0DKjUg5EtbYy1yC0GxwHeP/Redf9ibW6JS
wSvsfGm97FW7OLpM2oaRW0xWUoqP3Rm8OjiglVvdoCuzpZPNqR9Nl63Tp3paPYB4
aHsFhSf4QYEs6uGbKQ9HQvl8AlXt/p3MZ0xj2g7cJbj/1z+Yv3w9iuMz5PyhyXI=
=EySm
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
