From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH V2 08/10] ASoC: img: Add driver for SPDIF
 input controller
Date: Mon, 19 Oct 2015 19:27:58 +0100
Message-ID: <20151019182758.GK32054@sirena.org.uk>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-9-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k18oBAwMkTg3OUap"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444653637-14711-9-git-send-email-Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--k18oBAwMkTg3OUap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 01:40:35PM +0100, Damien Horsley wrote:

> +static int img_spdif_in_get_lock_acquire(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
> +	struct img_spdif_in *spdif = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	ucontrol->value.integer.value[0] = spdif->lock_acquire;
> +
> +	return 0;
> +}

It would be nice to get some documentation of what these controls are...

--k18oBAwMkTg3OUap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJTYuAAoJECTWi3JdVIfQUSsH/0OyVUdjnBm+bHJDFM447k+U
3ObSZ6IIGW+Wjq4t7p+cJqmtC2E0aHz+8Knfjo4G7ItoHIYbUObkehmml7UJuZR0
843C2jjwob5oaaKsXjNZi3EIya1frsin31OLt9OK+PBZHldot2nHKqFGExO5oiMf
dVqgdlsOjGGUL8h/DOD7SkeJnXhi2HbJWqSWFOImiBRlyE4P8+G7Qof9+nrPKPcu
hkTngSWg1Ho6IwnhYm9N1a6NCZHyTkm0RzMb73qk7/cxwPKGF0uiIdOfBpyNr2uA
syJZ7NjhWgMjVFWS1XPpa4ggjz23p9KNf87jbzQFbHpoTCi0eVmRi5nBqmRqpUk=
=wqHD
-----END PGP SIGNATURE-----

--k18oBAwMkTg3OUap--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
