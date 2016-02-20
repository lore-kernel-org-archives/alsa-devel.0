From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
Date: Sun, 21 Feb 2016 04:59:25 +0900
Message-ID: <20160220195925.GF18327@sirena.org.uk>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l+RjsdkfuJDA0G6K"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <871t87z1gz.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--l+RjsdkfuJDA0G6K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 20, 2016 at 07:22:04PM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> > Instead we should be probing at runtime (as the non-ASoC AC'97 code does) or
> > something similar.

> When you say "non-ASoC AC'97 code", which file are you referring to ? Is it
> sound/pci/ac97/ac97_codec.c ?

Yes.

> If so is there already a table of tuples (AC97_VENDOR_ID1, AC97_VENDOR_ID2) ->
> (platform device, platform device data) and a matching mechanism already
> available to the ASoC drivers ?

ASoC doesn't really support the enumeration very well, you can use
ac97.c as the CODEC but that's about it.  There is a generic AC'97 PXA
driver in sound/arm, if your system can use that that'd be a better
route to DT integration for it I think.  Did you try that, if there are
problems with that perhaps we can improve that driver, it should  be
simpler.

--l+RjsdkfuJDA0G6K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyMWcAAoJECTWi3JdVIfQcpIH/1ulDFzu55nMKtVxAPHEWgG1
Yr2g0trmnh/LckYj2pkvyh9xTMgRs3JFfoYjP5sqlpajii0JDHQJZFVwJgCALYT5
eRK27JKj3wf5RVQqg2Xk1JBRmd1NKgzZAfTyzkm4QhmMrZIrB4m53MVE82m37Rff
trsSQKTGaP8AO7BcTpW/I9uVzyRx7RQ17f0kLTagBtid1e8LkoQ7LDavbA2Jx7P+
s/jb6ZSt0Y+JUDHYz7yEtMMo7PJp2vhfa6dRwtepEujGFfhKwWvIYcyRR4r2BTK6
0EYDHe2ewKOnu5O8u5sEOQXH4/iV8ITzciYGGew4xry8S8Y5Uy2laq8ppmMLPPI=
=qITc
-----END PGP SIGNATURE-----

--l+RjsdkfuJDA0G6K--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
