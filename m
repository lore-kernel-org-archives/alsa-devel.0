From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
Date: Sat, 27 Feb 2016 11:03:06 +0900
Message-ID: <20160227020306.GW18327@sirena.org.uk>
References: <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
 <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk>
 <878u2fxbp9.fsf@belgarion.home>
 <20160221014920.GK18327@sirena.org.uk>
 <87povkuuf6.fsf@belgarion.home>
 <20160226023021.GH18327@sirena.org.uk>
 <87k2lruqsw.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SdHVWq6Dvt91fbjv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87k2lruqsw.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--SdHVWq6Dvt91fbjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 10:04:15PM +0100, Robert Jarzmik wrote:

> Ok, let me think about it and propose something, an approach.

> I must admit I like the structure I saw in drivers/amba/bus.c, ie. to have
> something like :

...

> Well, if I'm totally mistaken, tell me. If not it will take me a bit of time to
> write is down properly in a Documentation/ file.

That seems pretty reasonable at first pass I think, the main issue is
just managing the transition safely for all the users.  There's a lot of
fragility in the AC'97 hardware and software so people have been very
reluctant to touch it.  Equally I think a lot of the more problematic
users probably aren't in use any more so you can probably get away with
more now than would have been the case in the past.

--SdHVWq6Dvt91fbjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW0QPYAAoJECTWi3JdVIfQNA4IAINyiCyLuywhBWk5v4RjLVQK
SzZwMwC76EWjlKG1aJCZSAgAek4hon2oHCEXR1kkvmZ12o8H2TFk0FBEPGjevp8h
hXBrvGr0isDfVVncnSDBl6nnzjwTfjSIY/XcfDHSbREkVzJd4uDJ9BqbacTUnr6t
8eqlXWt9A4G8eNrs6/zHS4QakbMhmhTH4ez+LhRw7RCqsHe6WH5yQKNcAmqOHoCE
sAg0zqEwovGTcZuwDrtEPAKCFLO6LzC1B5eRYsTdAmIFSjhkZuOcV2+86NWwUgqF
jJaP1kBDQkzpkBQDLUH5Yp4PRTranKsNq8hrkw3b7BfD5qVLal6UcQUyCK1LU5k=
=rSHE
-----END PGP SIGNATURE-----

--SdHVWq6Dvt91fbjv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
