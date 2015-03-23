From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: pcm512x: Remove hardcoding of pll-lock to GPIO4
Date: Mon, 23 Mar 2015 14:38:44 -0700
Message-ID: <20150323213844.GV14954@sirena.org.uk>
References: <1427145421-5544-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TG7lY2/6mW/akb80"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427145421-5544-1-git-send-email-hm-n6SlHCM0l+K9FHfhHBbuYA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Howard Mitchell <hm-n6SlHCM0l+K9FHfhHBbuYA@public.gmane.org>
Cc: peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--TG7lY2/6mW/akb80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 09:17:01PM +0000, Howard Mitchell wrote:
> Currently GPIO4 is hardcoded to output the pll-lock signal.
> Unfortunately this is after the pll-out GPIO is configured which
> is selectable in the device tree. Therefore it is not possible to
> use GPIO4 for pll-out. Therefore this patch removes the
> configuration of GPIO4.

Applied, thanks.  Please pay attention to your CC lists - try to avoid
CC irrelevant people on your mails.  This helps cut down on people's
mail loads.

--TG7lY2/6mW/akb80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEIfjAAoJECTWi3JdVIfQu/IH/3yzgU/nLeKm32oWI7d9mpK/
+DkfQiRT22DMAnUkCvAj7ZRhqeet7JS8Uu+eHISy5OCnR/lpn0dKEooZavazrelj
uU3zRuR+FzpEf+RApjLgN/B/9an2TqpNzjdmLOlDBF1q8Glbbce2zaywXbT57Nlu
CAgbh6+kKrDfuMwrP0+DYU0kICGcLJBdCLWrXGz+a1pTzbOQrRWmOePjjYGVUqc+
wgYX5DEVmn98xUGCZw2VfH5eEUSor2QBGd47ZwBS11UkbSBzu6x5i7pqPDJmBGW2
cGzwTGh99N0zr+7DBnscGhpVKyXS2n3FpHAO3MyHqdjYj+oYUO215+KMfTJt7aE=
=SWXY
-----END PGP SIGNATURE-----

--TG7lY2/6mW/akb80--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
