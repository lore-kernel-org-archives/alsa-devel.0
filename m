From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/3] ASoC: cygnus: Add Cygnus audio DAI driver
Date: Wed, 2 Dec 2015 10:45:43 +0000
Message-ID: <20151202104543.GD1929@sirena.org.uk>
References: <1447114664-21799-1-git-send-email-ssimran@broadcom.com>
 <1447114664-21799-3-git-send-email-ssimran@broadcom.com>
 <20151122134440.GQ26072@sirena.org.uk>
 <565E54D2.50806@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="17ucDnirktTaGR4W"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <565E54D2.50806-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arun Parameswaran <arunp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--17ucDnirktTaGR4W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2015 at 06:17:54PM -0800, Simran Rai wrote:
> On 11/22/2015 5:44 AM, Mark Brown wrote:

> >I would expect any initialisationn of clocks beyond the ones that the
> >device directly interacts with to be handled within the clock API
> >configuration rather than in a specific driver, this avoids the driver
> >being dependent on a particular system integration.

> I will have to figure out a way to propagate the frequency from leaf clocks to the parent
> clock. Will send out another patch with the fix.

The idea is that the clock API should take care of this.

--17ucDnirktTaGR4W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXsvWAAoJECTWi3JdVIfQizUH/2COn8Y6LRhnAHyYeH1bRmWx
4ch+FHrhThvsHo+Q4g2qx6Di51y06ypneutLyNEM8bUaZ9YTpMazia1XX0YrDvGp
hSgEooiAvFbCljagWfJWwLlNy+86wzi6bPcTYTJml6hfTjY5xVdd3rPDu7YiYGMX
qcf9lI42nFPQn1HG+9D/fS2QKfXWg+U6g2PPq3Fh25VrS0rRdVhLJ76RAQh2uVGk
M/7I/VNf4cGgg82LYQTPfkBQy/YEZR+EKnCyACIl6jEG5h1uBxGpWnQp6e4ZyhmI
0+xAMhouweBOE8qutqz9lKRkWuQsBDFzLvTDjSq65rWlZIkNnMUSYnKw2dIGdHk=
=RGTF
-----END PGP SIGNATURE-----

--17ucDnirktTaGR4W--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
