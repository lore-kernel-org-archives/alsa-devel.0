From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: codecs: add support for TAS5720 digital
 amplifier
Date: Tue, 26 Apr 2016 16:43:13 +0100
Message-ID: <20160426154313.GA3217@sirena.org.uk>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-3-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZMpvc8TwNEttvQ/F"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461615456-19510-3-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ZMpvc8TwNEttvQ/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 25, 2016 at 03:17:36PM -0500, Andreas Dannenberg wrote:

This looks mostly good, a few small things below.

> +	switch (width) {
> +	case 16:
> +	case 18:
> +	case 20:
> +	case 24:
> +		/*
> +		 * We only support the different left-justified serial audio
> +		 * formats in which case there is nothing to configure in the
> +		 * TAS5720.
> +		 */
> +		break;
> +	default:
> +		dev_err(codec->dev, "unsupported sample size: %d\n", width);
> +		return -EINVAL;
> +	}

If the driver doesn't do anything just remove the code.

> +	if ((curr_fault & TAS5720_OCE) && !(tas5720->last_fault & TAS5720_OCE))
> +		dev_warn(dev, "The Class-D output stage has experienced an over current event\n");

"Class D over current".  The verbosity is making the line over long and
the phrasing is a bit unclear (and makes it seem less critical than it
really is).  These should probably be dev_crit() or somthing too, over
current and similar events on a speaker output are generally extremely
serious.

--ZMpvc8TwNEttvQ/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXH4yOAAoJECTWi3JdVIfQ904H/2N2DZLqJZYH3o7THlpyEftE
HvgTXvCqQs6W2ynOTjbxeEv/06A/XaneaKaXdl8iGTKtWP/LwdAcADva4wtTsVts
MQJuIOHIa4sUoXwKKA3Pru1REDNNkya7neeHczRmw4gl4EpfQ6s3pji4yPSAJ8Xl
tM/YYDpPFCfTNXqFPN/MpQbS4rmeoB10nkpaeel5lszhJ2uk6uK/Ocav+UTCd+8Q
EDZjLGkPuUEA9sO5S93Dr+AIimCD/sjycnQQDDDP43JmAZxlVOhgAuiDjr0y2ZJr
9jfaF/lU21PCCpy1RAjUObKzqWpkecptbr+wIOn/QtBUy0GWqERkPZTfX4iMS1E=
=9yOJ
-----END PGP SIGNATURE-----

--ZMpvc8TwNEttvQ/F--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
