From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: twl4030: don't report EBUSY if no change
 requested.
Date: Sat, 8 Nov 2014 09:22:42 +0000
Message-ID: <20141108092242.GB2722@sirena.org.uk>
References: <20141108002637.6561.19002.stgit@notabene.brown>
 <20141108003803.6561.42934.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141108003803.6561.42934.stgit-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 08, 2014 at 11:38:03AM +1100, NeilBrown wrote:

> +	int val = ucontrol->value.integer.value[0];
> +
> +	if (!!(twl4030_read(codec, TWL4030_REG_CODEC_MODE)
> +	       & TWL4030_OPTION_1) == !!val)
> +		/* No change */
> +		return 0;

We shouldn't be accepting attempts to set out of range values so there
should be no need for the !! on val (which confused me when I was
reading this).

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXeDhAAoJECTWi3JdVIfQ1XcH/RJqfPlYEBnb4iLaKsPfm8tN
RyoEOUlJYmg//4n3ndaam/M6dllUyR3JXRJq2iaE9ZonUGHdMhtaLSFuJb3UmZsU
9BO6uqYe09HMgZobAsk4YTbu9dzFgVKpZsbFD19n5MpScO2EKnSimUyi9iMBztcN
G+YAQ3feVyAgnGJWIZx4DMWBdZ4ACiCYW8G+G4vnA3unefdMfybPn4LVDN6+ekDh
7YaQ+5K6wMtmLcF5hGsXAhr2vH0FY4WZKUYnCKvO6s2/EX0jP1yegMwe6d+irBvR
LucPyGXjJNGDX2//gUgyuWMfHLWBXp0qDbfvcYD5EWAEonnMyydN19HXkoHJqaE=
=E2Wg
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
