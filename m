From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] Cygnus Audio Driver
Date: Mon, 6 Apr 2015 10:58:03 +0100
Message-ID: <20150406095803.GD6023@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <20150331064338.GE2869@sirena.org.uk>
 <551EEAF8.7050108@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Xnt6BZa+I2KmHWw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <551EEAF8.7050108-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazao <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, abrestic-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, bryeung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, pwestin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--+Xnt6BZa+I2KmHWw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 12:33:12PM -0700, Scott Branden wrote:
> On 15-03-30 11:43 PM, Mark Brown wrote:
> >On Mon, Mar 30, 2015 at 08:16:22PM -0700, Scott Branden wrote:

> >>The audio PLL is embedded in the audio block and only used
> >>by the audio block. The audio PLL registers are also in the middle of
> >>the audio register map.

> >When you say it's only used by the audio block do you mean to say that
> >the audio block exposes no clock signals other than the bit and frame
> >clocks?

> The audio block exposes the MCLK in addition to the bit and frame clock.

OK, then it's going to need to be a clock provider at some point - the
clock will be going into external devices which are going to need to be
able to interact with the clock (for example, to get the rate).

--+Xnt6BZa+I2KmHWw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIliqAAoJECTWi3JdVIfQdjoH/1joz01UIrzgobn+St3bC0rY
o1pA7Ul7sENnJI66FoHZwHn8NzwJQpI1EEQBlMlZbAnXUtKvSprrirFex0hWYg/N
is8kTIsoj5Wfr7JingLCQ72WB3T7JV4dGqttFcVYY3HmH5MtW0Zr3lqk46aW9bby
lpEqiF6Wx73ouwiz36GV1OFdCH1BgYQXxAKfd+S18mLHbEfN7uGirp2Itf5Oehpn
1Yyiwko+7vLI3ypDrMINRr+Xsnbz8hDFbzHRfJ3zFSOP5hwUpqvzGH0gbrHBNZKB
YVa4RX84OL6FORizMvY5Y3aWRJ+wOtPDkcnndRh8rEFYaqAiAdCDo/42uKO9wUs=
=/stg
-----END PGP SIGNATURE-----

--+Xnt6BZa+I2KmHWw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
