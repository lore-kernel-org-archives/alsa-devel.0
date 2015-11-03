From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] mfd: arizona: Add DT binding for irq-gpios property
Date: Tue, 3 Nov 2015 15:04:50 +0000
Message-ID: <20151103150450.GP20228@sirena.org.uk>
References: <1446559806-3315-1-git-send-email-sjan@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ssZxAlvqSOvXAj81"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446559806-3315-1-git-send-email-sjan-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastien Jan <sjan-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ssZxAlvqSOvXAj81
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2015 at 03:10:06PM +0100, Sebastien Jan wrote:

> +  - irq-gpios : GPIO specifier for the GPIO connected to /IRQ

The platform data this is providing is essentially a workaround for the
lack of an irq_to_gpio() function and the use of it is a workaround for
the lack of level triggered IRQ emulation in genirq...  do we really
want this in the ABI (especially as a generic thing)?

--ssZxAlvqSOvXAj81
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOM0RAAoJECTWi3JdVIfQ+AQH/09S0d5+AzdVFTjFytEc5MGk
th1v5OlWKQ612HOZK1Qux2ib/FNcSQsNGVDH+/zOs9Q0/va+brCHd57l+XO6W2gi
0/6j+a+OhsHMqTQ+yjGHTMDEssjp3VQxXXzlG9Xrf4eYlkg8dUd6huYBC6om0NWc
Ue+1EY/zinmvVpLkOGUgnFWCFan1o0zkgm23cKVuijAyRWXAOnETlDMNMHL0Uyqs
uNm77+Qo41GRW1w6YoEwc5AZAv2uemEJCM+++ZViJ5mQx2bfmOB6nju+SnpzMsm4
fNO+DvPh2ZI9VGQ5NblFaskYQDim/hy3ZtrVs8+JPUjT3IQZ4qHzDvPf1aoKqh8=
=/f+2
-----END PGP SIGNATURE-----

--ssZxAlvqSOvXAj81--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
