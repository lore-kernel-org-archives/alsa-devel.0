From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 3/4] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Sat, 25 Apr 2015 12:35:09 +0100
Message-ID: <20150425113509.GB31708@sirena.org.uk>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
 <1429915008-22015-4-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429915008-22015-4-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: lgirdwood@gmail.com, lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2015 at 03:36:47PM -0700, Kevin Cernekee wrote:

> +			gpiod_set_value(priv->pdn_gpio, 0);
> +			usleep_range(5000, 6000);
> +
> +			regcache_cache_only(priv->regmap, false);
> +			ret = regcache_sync_region(priv->regmap, 0,
> +				priv->chip->regmap_config->max_register, false);
> +			if (ret)
> +				return ret;

This is also a problem with your first patch BTW - even if we are going
to add an argument we shouldn't be having drivers do _sync_region() to
sync the entire register map, that's just ugly.

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVO3vtAAoJECTWi3JdVIfQgwIH/2pCj1ZWoqOCcskJNM94B18g
SD0o+3YY3Nzwb+dvcAP9Z1wpLKBx9CtVfKzEeVZ6qICLZmeBzzerKC3N8R+1qNF3
n89vboB19vfwLSd2jQvVmgWsvEgWraZ4XubrY+QoGmOsFtkFBWuoHiSryj10QtUm
q0w9eyp3fhkQ8lXP0P2eg997kjm1ktCsj9ffPDczpuNkfTm8pSdu2TyhCjDDUNpb
hSOSWfb1rn4NOAtd0fcaAyDOGWWe9beuR20mJXA9aWPgI8HjPxpnxqG7+NLjhzJh
XlJHK7IdZOtlsynu25p3V/CF7kGZEOUi+hpDSvUrEie1d65XQK+fyDw+Sd6uisU=
=9hPX
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
