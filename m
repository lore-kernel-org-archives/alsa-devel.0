From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple codec
Date: Mon, 30 Sep 2013 18:43:19 +0100
Message-ID: <20130930174319.GG19304@sirena.org.uk>
References: <20130919105437.75e0f0a3@armhf>
 <5240B07C.6080404@wwwdotorg.org>
 <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
 <5249AB82.60701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0EphSjNCSB1asamE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5249AB82.60701-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--0EphSjNCSB1asamE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 30, 2013 at 10:49:06AM -0600, Stephen Warren wrote:

> The only potential issue with that approach is if the CODEC can be used
> in a "simple" mode where e.g. no control GPIOs, regulator manipulation,
> etc. are required, or in a more complex mode where such things are
> required, you may end up with the device-specific binding being written
> to the simple mode, and hence missing features required for the complex
> mode. Having a separate simple binding prevents the device-specific
> binding from being broken that way.

That would probably indicate a bug in the complex bindings since if the
simple mode exists then usually that would mean that the bindings for
the complex mode ought to be specifying things as optional, these things
are typically just done by strapping pins instead of routing them to the
CPU.

--0EphSjNCSB1asamE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSbg0AAoJELSic+t+oim9WokP/35cunBYLfbNVepbijrz7Rmf
ybeUeVJ/BYziDPYBl9CgvZYyE9F7E1SPhZFNpYYcQ8HtUUslt50kwvpNucay4Ksc
GYsQ7oEKHMUuZxVXxvAtl5Of8RG3BXHwmzWDjnqy/LDGdV+nUv0WEEBdJxYT+v2F
7m/caF+7DCHeV2Yg/IYJw0AWz2zHaCkS9P817xad97DOvYFVKDRf5FO/GZ33VWGA
EmNBHQIu2aaZ2Pj8Cem590tHPCsDz7Bg8bOoIKbbOfiyWDi93zNDVZ/QYy5mINwn
KtG/yHqVupB6VwpQ1fwtdTqZ3qgOPgwE30/ioB9vg7V2WSL8KF1Dc4dl9I1qLmzV
yZJQGSN45HRaWt9InmsgdEE3loxLAbgG8DkO1wqiXXFic0cYAz4DldYk0aEWMtwD
iaQVCaJyEUzY9xBP7AP9+3P8Jj8LxFCCnhTIRbw2fiX0LIik86xGGCZb8H2JRj3M
sKH+DUQEnaSrXi4T/swlPkKS9WHqD8HRuG3k83qzb1MMMdKOeRTQgS6t15FRe6UU
lUP4StCDU3r1zZSEAuuLSNrEJwRGGdZ5mokuOq4eqgeOO/lXB+tvvkFu8XQN5+ld
sjGRAJyISvdoG1YqllzTiI5CtMtTt0/5XJrhlDhWk6+wQcS3v9ADezeeJfiZOZqT
GsuKREintH/jfaaekRyF
=5Ztw
-----END PGP SIGNATURE-----

--0EphSjNCSB1asamE--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
