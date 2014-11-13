From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/6] Documentation: devicetree: arizona: Add bindings for
 WM8280
Date: Thu, 13 Nov 2014 18:06:21 +0000
Message-ID: <20141113180621.GL3815@sirena.org.uk>
References: <1415901046-3391-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1415901046-3391-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7Rze0zIwr58YS37C"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415901046-3391-3-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--7Rze0zIwr58YS37C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2014 at 05:50:42PM +0000, Richard Fitzgerald wrote:

> -  - AVDD-supply, DBVDD1-supply, DBVDD2-supply, DBVDD3-supply (wm5102, wm5110),
> -    CPVDD-supply, SPKVDDL-supply (wm5102, wm5110), SPKVDDR-supply (wm5102,
> -    wm5110), SPKVDD-supply (wm8997) : Power supplies for the device, as covered
> -    in Documentation/devicetree/bindings/regulator/regulator.txt
> +  - AVDD-supply, DBVDD1-supply, DBVDD2-supply, DBVDD3-supply (wm5102, wm5110,
> +    wm8280), CPVDD-supply, SPKVDDL-supply (wm5102, wm5110, wm8280),
> +    SPKVDDR-supply (wm5102, wm5110, wm8280), SPKVDD-supply (wm8997)
> +    : Power supplies for the device, as covered in
> +    Documentation/devicetree/bindings/regulator/regulator.txt

This is getting pretty illegible, how about either a per device list or
breaking each supply onto a separate line?

--7Rze0zIwr58YS37C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZPMdAAoJECTWi3JdVIfQZqQH+wZoGeWn8YnovgWARutLXtb9
FBhW5UGwl8uUnNFPwAIljwPCfeKMGieMCgq78KybkmXGMnS2ewf9180gtnSNhriz
U656k4yFTGRn138IMqd54vyCiA/Xp3wAhH/aEHMsZ66H9e4q7kUk1Eipb8rilPIu
WMOAQBjJmnC3SvG585U/Q3HlO68xrZeNjfud5CKQesOswNc5dSsP8izrp6HLSZLa
XVQrHFHhoK3ysHXnO34FX0HjdhMYXG6znVI+bWGGWznr5TeYn9DAZNkwf99wpV4F
qL+zYaS3SuxqcSC1mHvnn3XoO/V2Ahdi7s1Z3ElX7jAGfpx3fNN+S8DSEktHtSk=
=ghzR
-----END PGP SIGNATURE-----

--7Rze0zIwr58YS37C--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
