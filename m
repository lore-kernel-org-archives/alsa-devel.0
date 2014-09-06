From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASOC: dapm: add code to configure dai link parameters
Date: Sat, 6 Sep 2014 15:16:34 +0100
Message-ID: <20140906141634.GF2601@sirena.org.uk>
References: <1409561813-24753-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409561813-24753-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2014 at 09:56:53AM +0100, Nikesh Oswal wrote:
> dai-link params for codec-codec links were fixed. The fixed
> link between codec and another chip which may be another codec,
> baseband, bluetooth codec etc may require run time configuaration
> changes. This change provides an optional alsa control to select
> one of the params from a list of params.

As I'm fairly sure I've told you several times now please use subject
lines matching the style for the subsystem - if your commit logs look
different to all the other commit logs that's probably not a good sign.
In this specific case "ASOC" and "ASoC" are not the same thing.

> +	for (count = 0 ; count < num_params; count++) {
> +		w_param_text[count] = kmemdup((void *)(config->stream_name),
> +			strlen(config->stream_name) + 1, GFP_KERNEL);
> +		if (!w_param_text[count]) {
> +			ret = -ENOMEM;
> +			goto  outfree_w_param;
> +		}
> +		config++;
> +	}

This will happily create values with a completely empty name if the user
didn't specify one.  This doesn't seem great - it's going to be an easy
mistake to make and fail to notice.  I'd at least expect a warning here.

> +	w_param_enum[0].items = num_params;
> +	w_param_enum[0].texts = (const char * const *) w_param_text;

Why the casts?  This tends to be a sign that something is wrong.

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUCxdBAAoJECTWi3JdVIfQXfUH/3RACVvoMg5Va5HKVHsbUUC5
xRXfPf/guW3Ie2ML5D92oTgk3FyFR6ozWP58nQfn+bl2ZBoowg8RJGzzFpYqjaWP
1NfEVdHpwhlbVS9ipNEOYRaejweLt9yJBiXdjc1JK8byeShRtnT1BXgYc1p4Nw0x
GGu184Cx47/Wm9Lc6iwLlCRkWK5B3zeYK8dSAl9ea432xfNn4cbqu3JppYbvzuxq
RQ37GkuafiOMURoWWBcyGZAH6KHuuqcUiJAlJbmF/jaTvx4awcTEZeiz+1vY9/um
5Hi58V2jE6g0nQoNA+oNlyUglepywG++FSC3zNvwWWATUe5uPkJhHax0AEcf8eQ=
=B1th
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
