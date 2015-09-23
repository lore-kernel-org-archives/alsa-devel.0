From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels capture and
 lrck-mode support
Date: Wed, 23 Sep 2015 09:24:33 -0700
Message-ID: <20150923162433.GQ30445@sirena.org.uk>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ub0O6GltjzY0fXqz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Ub0O6GltjzY0fXqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2015 at 11:41:22AM +0800, Sugar Zhang wrote:

> +	/* configure tx/rx lrck use mode */
> +	if (!of_property_read_u32(node, "rockchip,lrck-mode", &val)) {
> +		if (val >= LRCK_TXRX && val <= LRCK_RX_SHARE)
> +			regmap_update_bits(i2s->regmap, I2S_CKR,
> +					   I2S_CKR_TRCM_MASK,
> +					   I2S_CKR_TRCM(val));
> +	}

This looks like it's for a board configuration thing so I'd not really
expect this to be handled in a device specific property - it's fairly
common to have this situation and we already have the symmetric_rates
flag for the DAI to handle it (and if we do end up adding this property
we'd need the driver to set that flag so that the core can handle things
properly and make sure that userspace doesn't try to set different rates
in different directions).

My initial thought here is that the machine driver should be responsible
for setting this and then the DAI driver should check to see if
symmetric_rates are in use and configure itself appropriately.  Is there
a reason why this won't work here?

--Ub0O6GltjzY0fXqz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAtJBAAoJECTWi3JdVIfQXs8H/2m7foDsKJ4w/RoLzde3r0aV
7Zfw15ZQTb+fPjOMLhe5KuPGhr+w8rvuk9FwKEBPezKnv9MrKjlnBEBh23AXSDkI
ubqra5jKIBdokTpQ6C914r283qYYpLw7gc+TzbTix4NPhP6C2agD1r08ShQp6v1d
mv7q9M6Ld80BXd52GW9SDF+0QFInt2vUUQ+7D80mZottMWWHOedB9+m8vkbxvm/f
T0nNz/aaCz4ZF0TrWHxdIYd8s9GMfBMWFFmXGHqDx+6Mdgkg2D1jr6Jmgw478ika
ekv18rSWXFF/LT/mV/VB8xUy4eL2V9u+Je/MfooKPLo/0X14awHd+IJztUuW0Ys=
=vdTG
-----END PGP SIGNATURE-----

--Ub0O6GltjzY0fXqz--
