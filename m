From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt286: Add customize setting for
	Dell Dino
Date: Thu, 5 Feb 2015 19:16:24 +0000
Message-ID: <20150205191624.GJ21293@sirena.org.uk>
References: <1423125634-8367-1-git-send-email-bardliao@realtek.com>
 <1423125634-8367-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8159567128870389009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21AB2260524
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 20:16:41 +0100 (CET)
In-Reply-To: <1423125634-8367-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8159567128870389009==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3WHXSKva2fGRnTbi"
Content-Disposition: inline


--3WHXSKva2fGRnTbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 04:40:34PM +0800, Bard Liao wrote:
> The patch add the customize setting for Dell Dino project.

I've applied this to get the support in for v3.20 but...

> +	if (dmi_check_system(dmi_dell_dino)) {
> +		regmap_update_bits(rt286->regmap,
> +			RT286_SET_GPIO_MASK, 0x40, 0x40);
> +		regmap_update_bits(rt286->regmap,
> +			RT286_SET_GPIO_DIRECTION, 0x40, 0x40);
> +		regmap_update_bits(rt286->regmap,
> +			RT286_SET_GPIO_DATA, 0x40, 0x40);
> +		regmap_update_bits(rt286->regmap,
> +			RT286_GPIO_CTRL, 0xc, 0x8);
> +	}

...this code is getting out of hand and really needs to become more data
driven instead of having open coded register writes of magic numbers for
each case.  As the number of machines increases it's going to become
difficult to manage and hard to restructure handling of features if the
driver changes.

What I'd suggest is to define a struct with all the quirks that might be
applied, put all the machines in a table and then figure out which one
matches the current one by looking at that table (dmi_first_match()
might be helpful here).  The code can then look at the struct and make
whatever configuration changes are required.

--3WHXSKva2fGRnTbi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU08GHAAoJECTWi3JdVIfQ21YH/1FR+fqlU1WUjesDRRXLQc2J
ur4lYiPmMlMOVcOj4Ijact04K89m3e86QXwVaCm142xaNmEMTIIctawt3v02CU+N
+a7+QX7PzLrura/ExiJOWw1QW3SDZ/6l7iAhl8LaeW0NBZqWlfaAX8NvSKVME98V
LUIWMq3o5NRAqOe6hnMwXnVom02Qj8c4TMkYlM6Rsi68w7FkmU86S+huNWsCvBBv
pYsdAGqg/pq0jFYWXPgRF58Phed0jxo1y++3FfnEC3WTp9h3FhYkho8iOJo3obSB
vUG7iydPUwZLlt44Hlk3yIwC9IrhrPadhiYvSHneQi0ErScxIGPIO5FjCDGhVCM=
=QjC7
-----END PGP SIGNATURE-----

--3WHXSKva2fGRnTbi--

--===============8159567128870389009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8159567128870389009==--
