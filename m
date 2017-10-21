From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/14] regmap: Add SoundWire bus support
Date: Sat, 21 Oct 2017 10:34:26 +0100
Message-ID: <20171021093426.vzhv3ponaxhi4yw3@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0586434101452162164=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 737CC266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 11:34:41 +0200 (CEST)
In-Reply-To: <1508382211-3154-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============0586434101452162164==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m3dr2wzmgkqq57we"
Content-Disposition: inline


--m3dr2wzmgkqq57we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2017 at 08:33:23AM +0530, Vinod Koul wrote:

> + *  BSD LICENSE
> + *
> + *  Copyright(c) 2015-17 Intel Corporation.
> + *
> + *  Redistribution and use in source and binary forms, with or without
> + *  modification, are permitted provided that the following conditions
> + *  are met:

Really unhappy with the dual licensing for regmap code, this is
interface code for some GPL only kernel code and...

> +static int regmap_sdw_write(void *context, unsigned int reg, unsigned in=
t val)
> +{
> +	struct device *dev =3D context;
> +	struct sdw_slave *slave =3D dev_to_sdw_dev(dev);
> +
> +	/* Check for Slave */
> +	if (!slave)
> +		return 0;

We silently ignore the device not existing?

> +static struct regmap_bus regmap_sdw =3D {
> +	.reg_read =3D regmap_sdw_read,
> +	.reg_write =3D regmap_sdw_write,

Given that the bus appears to support bulk operations why are we
implementing this with reg_read() and reg_write()? =20

> +		return ERR_PTR(ret);
> +
> +	return __regmap_init(&sdw->dev, &regmap_sdw,
> +			&sdw->dev, config, lock_key, lock_name);
> +}
> +EXPORT_SYMBOL(__regmap_init_sdw);

=2E..this is just an obvious attempt to allow non-GPL code to directly use
GPL code.

--m3dr2wzmgkqq57we
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrFKIACgkQJNaLcl1U
h9AfrAf/aqnMLF+cczpew0IHhZp4pu1bBBWAgqoBeXZvR1/2/kYvX+D+w3djJX8u
afo/vaOJ59EGBnsnAOh4Lj5lq0xDEFAwxSruZl3DQLio5JwpMrrlk7DWXAwRbMAk
LJd/6eHzOJCNNsSg0fcD/ZRbiDA/yeClu7Xq8pOUNFnefFjRJUYwwYNHgyfcA/VJ
EJv7eDjmHzosu8EIHK0ZSJ10XfpkLvJ1YJyNR7nBkmmXPoWP61vWh12aC1brAVw0
Ej4ajHkpeRWjA9jpOYvLDc2m1bFUddcAphLLHOUj0u3EzVEgNCucEYNAzjoiE2IJ
6rK8mgNNReC+M9ul2NCVIGjh6DLIBg==
=Fa+q
-----END PGP SIGNATURE-----

--m3dr2wzmgkqq57we--

--===============0586434101452162164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0586434101452162164==--
