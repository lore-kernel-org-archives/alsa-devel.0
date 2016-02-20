From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
Date: Sun, 21 Feb 2016 02:14:59 +0900
Message-ID: <20160220171459.GA18327@sirena.org.uk>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AX2clmtSw6ieHBMM"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455979079-9030-1-git-send-email-robert.jarzmik-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--AX2clmtSw6ieHBMM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 20, 2016 at 03:37:56PM +0100, Robert Jarzmik wrote:

> +WM9713 audio CODEC
> +
> +This devices supports I2C.

No, it clearly doesn't...  The problem with doing this is that since
AC'97 is an enumerable bus we really shouldn't need to list AC'97 CODECs
in the device tree.  Instead we should be probing at runtime (as the
non-ASoC AC'97 code does) or something similar.

--AX2clmtSw6ieHBMM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyJ8RAAoJECTWi3JdVIfQFPQH+wd9CRwGIeFbtrfR2xECr/2w
3Kykx+ZXYKgaNlb+LKmwKEo119khWVJddiXRNAMJW5T3GwVWMGRUvr+D8p6EBvCj
zbUHi7JqGg/hlV4bKgu70OXIe2ObXW+YlO47PTjMOtyaQzaabZLoqje1GzPeCwPn
Osx6G+KRPUSsmV/YXtvXcFkwRZwIHZgGmYW/cQdsA9KOs0EkinOw2WPPhithEG0B
sWJL/NSZP9Bp+gydm/WXuW3vyxjgBLBCr49A0dhbdryFNHyJigcCZh7YNPOFFY0e
8+AMmLKgpsSe7VcvrOY81gDi2kM1NvOKKBJfOKI2SmARXc0MMpHXDiWBSYd4Ff8=
=x7rU
-----END PGP SIGNATURE-----

--AX2clmtSw6ieHBMM--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
