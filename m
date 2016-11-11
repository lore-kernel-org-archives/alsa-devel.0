From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] ASoC: atmel_ssc_dai: if not provided, default to
 sensible dividers
Date: Fri, 11 Nov 2016 16:05:32 +0000
Message-ID: <20161111160532.b4vyit6722nbvhk6@sirena.org.uk>
References: <1478863752-10569-1-git-send-email-peda@axentia.se>
 <1478863752-10569-2-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4sm5dnfnpoaz5tnz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478863752-10569-2-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--4sm5dnfnpoaz5tnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2016 at 12:29:10PM +0100, Peter Rosin wrote:
> When this driver masters BCLK and/or LRCLK, and noone has stated
> differently, assume that all the bits of a frame are used.
>=20
> This relieves the cpu dai users from the duty to fill in the dividers for
> the common case.

This looks good and like what I was meaning with my earlier feedback
(you sent a new version before I could reply to that).  I'll leave this
for a little while to give others time to review though.

--4sm5dnfnpoaz5tnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYJexMAAoJECTWi3JdVIfQplcH/iQKF6W0HZL44QflWyRnGjsm
QG35WcXZ4gyhqSihpwAQO1uEZc5ffYXsHIDAnm+WoadMxeuJYkFva0s4V8z1BDCo
wgYY2YdbPEDd1tfmYf9qrjdP0prqDcmk88UuuOVVjj4Pq8B6So+A+7bqhHAj1b1R
3yAbgYSziL1pv5ParBdZuPAHj+lx1Id1EYo8gC5uc1h17LfXWwF8Wy3gKCKiAXJ8
Navdq6C1Uy6yAzG+jCBQcJCmfIRoQL1YyW9MD46ADioz4R1R53VmuTfnCTnQvksb
xt7fVelWWwEuYtjoC6sFfyio1F8eXiYTcqNsJ4JycOStGajjdQqXofR0x+bqPW0=
=BZEH
-----END PGP SIGNATURE-----

--4sm5dnfnpoaz5tnz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
