From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] Cygnus Audio Driver
Date: Tue, 31 Mar 2015 07:43:38 +0100
Message-ID: <20150331064338.GE2869@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1MovezAcxqLtNama"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427771784-29950-1-git-send-email-sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazao <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, abrestic-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, bryeung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, pwestin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--1MovezAcxqLtNama
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2015 at 08:16:22PM -0700, Scott Branden wrote:

> The audio PLL is embedded in the audio block and only used
> by the audio block. The audio PLL registers are also in the middle of=20
> the audio register map.

When you say it's only used by the audio block do you mean to say that
the audio block exposes no clock signals other than the bit and frame
clocks?

--1MovezAcxqLtNama
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGkIaAAoJECTWi3JdVIfQGrEH/iGykGJzu81+lPktlVNEUG8q
h79v8GTsjD2eXwqtvpPrlOMUk0WxFNSXh2C/tdK/rNkUxip62VdBh9Y5lUkXKpZn
hvnrlsUrGz1zBYT4nj30PdrzkdboUUdoatmBe+Njgrw688llicw2d6/2QDYzEqy3
3wr7FiS2eiu9QGPbf1/zrOC7XJ5wDOqoJ8xOJYy8x44evs4NWWyl20VFlZjjUfk1
ZVvCkkq1X5ahmnGtNe9a8BVZqNbMJ7qAw/lUOIINsdmUHZMYPRyhZQnCjnyBrgch
hz0qOtzB1AiO1yMU/yf0Mbn1NMC+4kiUsNMrF85LyD3TWkssaIA2UH5RS/FIJCE=
=uHqD
-----END PGP SIGNATURE-----

--1MovezAcxqLtNama--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
