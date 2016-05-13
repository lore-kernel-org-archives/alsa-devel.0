From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: wm8985: add device-tree support
Date: Fri, 13 May 2016 12:27:14 +0100
Message-ID: <20160513112714.GG22038@sirena.org.uk>
References: <1463068730-18817-1-git-send-email-petr@barix.com>
 <1463068730-18817-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463068730-18817-2-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, plamen-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 05:58:50PM +0200, Petr Kulhavy wrote:

>  	.driver = {
>  		.name = "wm8985",
> +		.of_match_table = wm8985_of_match,

of_match_ptr()

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNboOAAoJECTWi3JdVIfQ9ckH/iq4e/Eypl818sPrNeBhNsuu
TINVdOSJAsosDnOt5iLPSveFMhLB/UDGe9EHUcD05owRIpAbA318qbYjjePH1bED
H2jM6oTCiYm9vB45Gja4uTWxC2pUaa+TDCVTD8bomQjOFXXCWlygzADC/kRfk8NA
rsD1Xr1wyEBrp0yRm0gJXiyjVCRJlOHxZQOYKvI/a37M6SHxpswPF/9Id7LXjbpG
Sst1Jv7Tm1KoLbHtI21OFtmJGBVeJikcPNvmWA7VZ87tCSkIKC/9kMZ5yZNy/JTT
bxX0jpL2mlyKPtdyK8tnxwkyou9jzoRlngcsC1lsRcRoJi4rgIiyePsnn9yHwFo=
=drmN
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
