From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Add component driver name
Date: Wed, 8 May 2019 15:24:59 +0900
Message-ID: <20190508062459.GJ14916@sirena.org.uk>
References: <20190507233213.53036-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5442244428135578018=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92418F80796
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 08:25:09 +0200 (CEST)
In-Reply-To: <20190507233213.53036-1-cujomalainey@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5442244428135578018==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5HJNHpVrs9F5Roc"
Content-Disposition: inline


--z5HJNHpVrs9F5Roc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 04:32:13PM -0700, Curtis Malainey wrote:

> Add name to component driver so it is possible to lookup the component
> when needed.

This claims that the change is adding a name...

>  static const struct gpio_chip rt5677_template_chip = {
> -	.label			= "rt5677",
> +	.label			= RT5677_DRV_NAME,

...but the actual content of the change appears to consist of rewriting
existing names to use a #define.

--z5HJNHpVrs9F5Roc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSdjoACgkQJNaLcl1U
h9Cabwf/QmN9TCd1xk5Sa4R0xXwVvN8bDpKpU26vmDQh5762hphHTHXVD1ZwvjUL
j+Q+GN9S8TCtw7J47C8rMou+z4m2gQ1KZR5yQ6aT4OHtqEaTCnxn3MqfjJ4GIlq0
FqFtXRUDQBowgsdZZ/030xeG9PESkTz0Qp+aud0tX05XbBgqjuvvjTbuqbUkSMOe
9uUBH9vxuYSjeUXHwuCR9ecMP4I6Pk69uA8vwNsaSAjT9rL5QJYCBJKy4JYM3WWS
yQhH3ndGjZPGNgTghzrDCUjCJbBb3D8lBCVMcliSV8MgC45aYJiuIqhf+L9xHU9r
cjHuo7c/ui9a1uBZFX3hktSd/Z5rvg==
=vUq0
-----END PGP SIGNATURE-----

--z5HJNHpVrs9F5Roc--

--===============5442244428135578018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5442244428135578018==--
