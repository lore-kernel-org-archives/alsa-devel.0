From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/4] ASoC: dt-bindings: add rockchip tranceiver
 bindings
Date: Fri, 7 Aug 2015 14:05:40 +0100
Message-ID: <20150807130540.GX20873@sirena.org.uk>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438947854-3743-2-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0X5fYEMtRnv/h11Z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438947854-3743-2-git-send-email-sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--0X5fYEMtRnv/h11Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 01:44:11PM +0200, Sjoerd Simons wrote:

> +- compatible: should be one of the following:
> +   - "rockchip,rk3066-spdif": for rk3066
> +   - "rockchip,rk3188-spdif", "rockchip,rk3066-spdif": for rk3188
> +   - "rockchip,rk3288-spdif", "rockchip,rk3066-spdif": for rk3288

The binding claims that we support these three compatibles but the
driver only supports rockchip,rk3066-spdif.  It's better to list all the
compatibles in the binding even if they all boil down to the same thing
since it's less error prone when we do start adding device specific
code - people are less likely to forget to handle some variant properly.

--0X5fYEMtRnv/h11Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxK0kAAoJECTWi3JdVIfQbGwH/ROkvDXXCTWZyu+uNNKmWVPB
2+aRpnINWRd/i/fwTCTmkmHRSc4caLE875lqvmIPKq63F2HGTtTAEkea975iZfB2
C5tINY7nkTaviS2jiQKLVUu4lS4hO9vKCOsdbQx+jJCNfMxUCxdd1Vv6Ysvkrqb+
jxNATguB1XHPhFPU+e18mZACxyRBx3vUV04vWr4dP6vag1UfeR/7sBxvl1gqHzLg
M+5gFV56NPrHwuH6CfwqrujW5OQo/hndyBYeoisdeh0dg/bbAODNSMTk86TrsaYf
mIuI5wAg9Bokji25SrrNr4JitMWND0M4ZPQZE5t+3DrcrsKX9dmKSnUF5K53Z7Q=
=l4PE
-----END PGP SIGNATURE-----

--0X5fYEMtRnv/h11Z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
