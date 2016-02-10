From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7][RFC] regmap: add
 regmap_raw_update_bits() and merge all regmap_update_bits_xxx()
Date: Wed, 10 Feb 2016 09:38:17 +0000
Message-ID: <20160210093817.GR13270@sirena.org.uk>
References: <871t8lthka.wl%kuninori.morimoto.gx@renesas.com>
 <87ziv9s2yf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6370707711984262143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B97D2606CB
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 10:38:30 +0100 (CET)
In-Reply-To: <87ziv9s2yf.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============6370707711984262143==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o0y1lerN6xYE2ROn"
Content-Disposition: inline


--o0y1lerN6xYE2ROn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 10, 2016 at 02:44:11AM +0000, Kuninori Morimoto wrote:

> Current regmap has many similar update functions, but the difference is
> very few. This patch adds new regmap_raw_update_bits() and merge all
> update functions into it by macro.

This is a bit hard to review due to the way the diff comes out, it's not
entirely clear what the code comes out looking like and I'm a bit
nervous about what the gains might be since macro conversions often
obscure things (this is making the macros undocumented for example).
Creating the new function and then using it in a separate patch would be
better.

> +int regmap_raw_update_bits(struct regmap *map, unsigned int reg,
> +			   unsigned int mask, unsigned int val,
> +			   bool *change, bool async, bool force)

_raw specifically means something that works with the direct physical
data format within regmap, a different name would be better.

> -	map->async = true;
> +	map->async = async ? true : false;

This is abuse of the ternery operator where a normal if statement would
do, and it's also rewriting a bool into a bool so a simple assignment is
enough.

>  /**
> - * regmap_update_bits_check_async: Perform a read/modify/write cycle on the
> - *                                 register map asynchronously and report if
> - *                                 updated
> + * regmap_write_bits: Perform a read/modify/write cycle on the register map

This looks like it renames update_bits() to write_bits()...

> +#define regmap_update_bits(map, reg, mask, val) \
> +	regmap_raw_update_bits(map, reg, mask, val, NULL, false, false)
> +#define regmap_update_bits_async(map, reg, mask, val)\
> +	regmap_raw_update_bits(map, reg, mask, val, NULL, true, false)
> +#define regmap_update_bits_check(map, reg, mask, val, change)\
> +	regmap_raw_update_bits(map, reg, mask, val, change, false, false)
> +#define regmap_update_bits_check_async(map, reg, mask, val, change)\
> +	regmap_raw_update_bits(map, reg, mask, val, change, true, false)
> +

...but we don't seem to use it?  The new name is also a bit confusing.

--o0y1lerN6xYE2ROn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuwUHAAoJECTWi3JdVIfQ++wH/1arwLzpTr5uWrq9f+ODiFPE
26AonIdOxD+gwFv5ibVVb2z5manZc677qk9bMomAx/5O0xm8uUZXdW3GPFL9XY7h
wRVnU6OsEQA+ZrwGU9vMrbq8OlXnAQbCSD8vR0z8i8qrju9N39PQYooIVjB2ThV3
rO+9BficQZ3IXB8Vkk0N0TM59RSZ2+WWzphK2jvWOqwlqnlW0aZsEC4sH4gvI2VY
5vx8aCdSJwC07khy8G4423uiwoZqbaZ+Yj0YaZtx16hsDqbysZPaAofuclubGaFK
DPWoTgOd8iLIZ21gWwgW0oToKDTuUYdXmxUS5N16ppeWTO5mh34ByXYjG1lDXSE=
=K08y
-----END PGP SIGNATURE-----

--o0y1lerN6xYE2ROn--

--===============6370707711984262143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6370707711984262143==--
