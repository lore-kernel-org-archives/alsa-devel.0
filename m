From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/2] ASoC: img: Add driver for Pistachio internal DAC
Date: Tue, 8 Dec 2015 19:00:05 +0000
Message-ID: <20151208190005.GY5727@sirena.org.uk>
References: <1449594324-2597-1-git-send-email-Damien.Horsley@imgtec.com>
 <1449594324-2597-3-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9QtXyXGM8HCrXlir"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449594324-2597-3-git-send-email-Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--9QtXyXGM8HCrXlir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 08, 2015 at 05:05:24PM +0000, Damien Horsley wrote:

> +static int pistachio_internal_dac_set_mute(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct pistachio_internal_dac *dac = snd_soc_codec_get_drvdata(codec);
> +	u32 reg;
> +
> +	dac->mute = ucontrol->value.integer.value[0];
> +
> +	if (dac->mute)
> +		reg = PISTACHIO_INTERNAL_DAC_CTRL_MUTE_MASK;
> +	else
> +		reg = 0;
> +
> +	regmap_update_bits(dac->regmap, PISTACHIO_INTERNAL_DAC_CTRL,
> +			PISTACHIO_INTERNAL_DAC_CTRL_MUTE_MASK, reg);
> +
> +	return 0;
> +}

Shouldn't this just be a standard SOC_SINGLE() now?  We've got a regmap.
Otherwise this looks good.

--9QtXyXGM8HCrXlir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWZyi1AAoJECTWi3JdVIfQNgkH/A79T4Olc1ZhHbUlIiaJXBuU
m2PWGTCJ/y+yjbD6tCSfhSfQ3hs+nDhij/HiMKjYrr3DnUg3w1/eL4ND9a5bEqrr
wCfpfF9EMEanqgch7C5zCksrDRDJVIU77I3AnvGiC0OVrauPnbT0nkpjnqEzSZDo
xBRQcVUT5jshPD9VtD2Ps4EYiw3YInosrn0CCXykchbUIoLfNkF9lrSrSCB/8aR+
v24tT9m+SNRgfk1VH1lT4nI+kHKvxkZXoz+PJVYFbyGBg48jnvYMJoEICj1ZJQyq
mqoqKnlV1OJdfPhVRgCcLaHBFmMS46BGhq5PgSpc3glihVuWi6KI8TNv8h/GjU4=
=ih2Z
-----END PGP SIGNATURE-----

--9QtXyXGM8HCrXlir--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
