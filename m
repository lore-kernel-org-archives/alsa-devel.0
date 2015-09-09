From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
Date: Wed, 9 Sep 2015 10:52:45 +0100
Message-ID: <20150909095245.GG9751@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk>
 <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk>
 <55EEAC01.3080409@atmel.com>
 <20150908122322.GB9751@sirena.org.uk>
 <55EFA478.1000109@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55EFA478.1000109-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wu, Songjun" <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2015 at 11:16:08AM +0800, Wu, Songjun wrote:
> On 9/8/2015 20:23, Mark Brown wrote:

> >If you want to have three controls you need to write code so that the
> >user can only change one of them from 0dB at once, returning an error
> >otherwise.  That was why it looked like they were three separate
> >controls.

> If user operates two or tree controls at the same time, for my
> understanding, these operations are serial actually in kernel, not parallel,
> and the last operation will be effective. I only write the function
> 'classd_get_eq_enum' to get the enumeration value, if user changes one of
> controls, the other controls will get 0dB. Is my understanding correct?

Yes, that's what's going to end up happening but it's not how controls
are expected to behave - applications will expect changing one control
to leave others unaffected so it's better to return an error rather than
change the other control.

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8AFsAAoJECTWi3JdVIfQye8H+wf02/aB0e20Mvlxa6YKHcSG
aBfl8eKeJZ3chMtf9jYo/NKX6K9X5OVyG+nE2hA1kodJ1ErC6LXXnpu9R3p3zuSJ
7Nu1qlB6YxE6BRJDVK2sVEOWYxBS0JiY/ERjmlY6nGqfVw5dG8i79xDZrEZ9fI5T
vGCf9NsqmZlRxPnNLqmA8SW0+BsaMiDwBmI/P/K31E5pVseo/cVT7tJre2H3Bjtk
aCCDkXCx2DUpUWN55BQ8RpCFLtfwZtQowGnsFJG3rP9TI9uN13y6qkIjCxMrOWbm
xF6qPbo6VYKs00JZlNrcudz+AUHEGkiLh4hrJ/FLz7RXbUUAdtR0bd+UIUL4Mrc=
=ePzc
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
