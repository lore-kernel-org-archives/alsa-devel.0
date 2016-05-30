From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/49] ASoC: simple-card-core: add
 asoc_simple_card_parse_card_widgets()
Date: Mon, 30 May 2016 17:23:58 +0100
Message-ID: <20160530162358.GU29837@sirena.org.uk>
References: <87lh35rs8w.wl%kuninori.morimoto.gx@renesas.com>
 <8760u9rrtl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="niUlcCfh/sMBwTxc"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8760u9rrtl.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--niUlcCfh/sMBwTxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 20, 2016 at 09:46:04AM +0000, Kuninori Morimoto wrote:

> +int asoc_simple_card_parse_card_widgets(struct snd_soc_card *card,
> +					char *prefix)
> +{
> +	struct device_node *np = card->dev->of_node;
> +	char prop[128];
> +	int ret = 0;
> +
> +	snprintf(prop, sizeof(prop), "%swidgets", prefix);
> +
> +	if (of_property_read_bool(np, prop))
> +		ret = snd_soc_of_parse_audio_simple_widgets(card, prop);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_widgets);

This seems like an extremely thin wrapper around existing core
functionality, shouldn't we just be adding the property check into the
core?

--niUlcCfh/sMBwTxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTGkdAAoJECTWi3JdVIfQYl0H/32JInYjfXbMIZe00pQMfe3J
+xpuX+/htdlM0tQhiwVeUTY08XbfOvbjA7W1Xom7+mmBU7oefb/FcFAN20hUcLol
oWXU5JrSi9KIev3H+iY+HXgnBywHYiMc4K6YP8Msh8bpAH5gCruIweidEc1uWxTk
xTLZkQqOjGyV7ghTm3//jjN7PrixRfwoEedvJFU17LmeiBmNDAc9Ru3M/warN+L6
/1TS6MLDlSEdntA0HMLhePgNMllcxi7VDF8Y4aV6O19kUcsMQzUjcxh+p0tS6RND
ptAehaqSPZt9sZuP/wfCcwIatI2R6gwZ9lYCJRTXhVkKhaUUZi2uK6QyI1G9U4U=
=SlGG
-----END PGP SIGNATURE-----

--niUlcCfh/sMBwTxc--
