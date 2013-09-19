From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple codec
Date: Thu, 19 Sep 2013 11:40:28 +0100
Message-ID: <20130919104028.GI21013@sirena.org.uk>
References: <20130919105437.75e0f0a3@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U4Pv8ouM+6WX/UB7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130919105437.75e0f0a3@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--U4Pv8ouM+6WX/UB7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2013 at 10:54:37AM +0200, Jean-Francois Moine wrote:
> This patch adds a simple sound codec which is described by the DT.
> This codec may be used when no specific codec action is needed.

Hrm.  I'm generally not enthusiastic about this sort of thing because it
requires every user of the device to understand the capabilities of the
device instead of being able to just say they have a device of type X -
it seems better to type the data in once in a driver and then reference
it.  That said...

> +Child 'capture' and 'playback' required properties:
> +- stream-name: name of the stream

What does this mean in the binding?

> +Formats:
> +	"s8"
> +	"u8"

I'd cut this down to just the PCM formats for now - many of the formats
you list there aren't terribly well defined even within ALSA, I don't
think some of them have ever been used at all.  A binding document
should really document what things mean as well.

> +Rates:
> +	5512
> +	8000

This shouldn't be a list of defined rates, it should allow any number,
and it should support ranges since while some devices do enumerate
specific rates simpler devices often just support a continuous range of
rates.

> --- a/sound/soc/generic/Kconfig
> +++ b/sound/soc/generic/Kconfig

CODEC drivers should go in codecs.

> +#define DRV_NAME "simple-codec"

Just write the string in the one place where it is used.

> +static char *format_tb[] = {
> +	"s8", "u8", "s16_le", "s16_be",
> +	"u16_le", "u16_be", "s24_le", "s24_be",
> +	"u24_le", "u24_be", "s32_le", "s32_be",
> +	"u32_le", "u32_be", "float_le", "float_be",
> +
> +	"float64_le", "float64_be", "iec958_subframe_le", "iec958_subframe_be",
> +	"mu_law", "a_law", "ima_adpcm", "mpeg",
> +	"gsm", "", "", "",
> +	"", "", "", "special",

This seems a bit obscure and fragile - an explicit lookup table would be
better I think.

--U4Pv8ouM+6WX/UB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOtSZAAoJELSic+t+oim9w6gP/jDeTkuNs/3vZBzplaFWA6uC
YdSaQ8XELP+mm/AjujVlxuPjxYowGas7OGDcX/pA0aECpHsQ6XYEb0n49vBCG7Ut
iDNIpl3iz7Z1T7FTRWd/s+5aZBBr49ICpFtxQrQ6rd4E9NcUhgYK69CJwFdO9e+L
4ECrK+asiKWbP2G67yQGQMLhV7quO4AetQGQsKZ9XwWHtz2bbqRDXrxB9JjhjLu3
mtWlaj0403FR/INCIHiVeDQDZ7OvG2WRBYuG0N/mYhEwckXZecQZUtk4Jj5CpnIA
DHKQwysCN9tydcXduVWq3wW8yoY5XHqY6W27WWDjPw7zrH+GpK5D1TFfZiAFZqt9
LQ+Dr4jUBjNPY/LL9zpeE6Rn2wXMIjrg4V4Ppbnm9KI9w9V9s6+3g1gJMLtqZK1r
cfA5vf6br7ZXY5hO4HkCTLfUC9srUPQoW2bu0qseG3ooAoBHFuClr09AQVZhsNUu
Ki9iNVM6FHQ1eVdgloL2Ey6j4CVuSZe74F8yAUTYBhPBed48VMN7u1yNqEAlCGzr
8gOGoCy9AUBHJRWxe2rO4eH8TQCTNahpau/03+nk72CU1fHEnT0IcatdJ92MVB0/
mOkRYJH6pVXCgBaSFDCQBUnxzLgyGhpwFl2Iw9u7iOqbVuLY0GAAmWy9GUXlTrqY
vQ89nHf+TslHrn8mCwUX
=e1zT
-----END PGP SIGNATURE-----

--U4Pv8ouM+6WX/UB7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
