From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for CS42L56 CODEC
Date: Mon, 5 May 2014 18:24:22 -0700
Message-ID: <20140506012422.GB22111@sirena.org.uk>
References: <1399320549-16645-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kxn/JluRpPoM1h3S"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399320549-16645-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, paul.handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--kxn/JluRpPoM1h3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 05, 2014 at 03:09:08PM -0500, Brian Austin wrote:
> This patch adds support for the Cirrus Logic Low Power Stereo I2C CODEC

Applied, thanks.  A couple of minor issues it'd be good to look at
incrementally.

> +	SOC_ENUM("PCMA Swap", pcma_swap_enum),
> +	SOC_ENUM("PCMB Swap", pcmb_swap_enum),
> +	SOC_ENUM("ADCA Swap", adca_swap_enum),
> +	SOC_ENUM("ADCB Swap", adcb_swap_enum),

Can these be moved to DAPM?

> +	regcache_cache_bypass(cs42l56->regmap, true);

You shouldn't need to do this, if no default is provided regmap should
just go to hardware.

> +	dev_info(&i2c_client->dev, "Cirrus Logic CS42L56 ");
> +	dev_info(&i2c_client->dev, "Alpha Rev %X Metal Rev %X\n",
> +		 alpha_rev, metal_rev);

It's better to just put things on one line and ignore the line length
warnings from checkpatch - this makes the code more grepable.

--kxn/JluRpPoM1h3S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTaDnDAAoJELSic+t+oim9XMMP/0WIYpeXtjZ9A7oJOz7QiqOL
nXYMh5G1a5MfuWpVK+7ykCxtZW/L9RDUVef9Ii3PnPGriz6y/PMtiCZqV6uF51gH
sM/6GJ136tb+ANpaaJaMBS/r/FSEEWOgA/GhVWvabM2gssLfnBpuLiRzCspTxFrS
pYgK8021vSiSvJL6mCSqT8qwXqbr9KUSzm44baYyF3PlAmk8d3VQm1ruuoe13LpT
LE9HKTBLswIIgPKlN+MF8T9XMKbcArCahVzGkP469CHyP2cxjH5Y7WzAmQPfvLfa
z25N0NDzhpRQQ3KGua+pHuj21JfTx74Afj8qFBu0b1QthVI4gmhtZuuHVBkErRLN
q1O5OBADQDvXdLTJIb5w6zitUinIq+5YQyom81Pb5WahCRkTgNUoTDPv8BAkhvld
M9ZIfiZX2MPEXaIQT6JPGI8PcMtJh47V7saks+MjtS6GxW49al5GW/UFzp4GG4K0
fOxBgNyzjcHGZGJKsnnuGOYo72EAatuiM1WlRntnDxC7ReqqM4gYPz/x0uV03oys
lIk4kQg+iL/MWghDGJCLl2xeApId9Gs9H+zpVYLgtBuG0vMfoS5bpfb6hdveBpcW
mEoGSY8r9HQIrJDQSi2SqfmoycHzerWEh6fJEWx7MBDZpWV+rssgDTXRAmDNwpLD
MzY4LbRM8HHCtVPrWLDo
=GFHa
-----END PGP SIGNATURE-----

--kxn/JluRpPoM1h3S--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
