From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau17x1: Implemented safeload
	support
Date: Fri, 10 Aug 2018 11:55:55 +0100
Message-ID: <20180810105555.GD20971@sirena.org.uk>
References: <20180810060756.15342-1-robertr@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3948711451727991137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E8DE12676A2
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2018 12:55:57 +0200 (CEST)
In-Reply-To: <20180810060756.15342-1-robertr@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Rosengren <robert.rosengren@axis.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Robert Rosengren <robertr@axis.com>, Liam Girdwood <lgirdwood@gmail.com>, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org


--===============3948711451727991137==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2018 at 08:07:56AM +0200, Robert Rosengren wrote:

> +bool adau17x1_has_safeload(struct adau *adau)
> +{
> +	switch (adau->type) {
> +	case ADAU1761:
> +	case ADAU1781:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(adau17x1_has_safeload);

Why is this exported - what are the intended users?

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttbzsACgkQJNaLcl1U
h9AG6Af9Hu7nVfj5MTbtYQ1c7ACsqLhCjMRffmbOGRTRBXhx+fdTlN7qUws7YO3w
5u5Yev9Z3GcVYGNbChrKQQ45NPE9nU0V/Vd0LaD5OgDO77/18sJJxy53ZdBF3/bU
cAnSE3KfBoY8ex6v20RpPQ8YD5cDwjMhHZc7Vb5KrSTUcn2GvSFiWfi4FAEzeJTx
0etpFGg+8LppiW+DhogToO2SgBnNtyg3avv2nQWZDhIXWfequi6bQnjXKvKW+9Ax
DFD1ljy0uAnpQasWv0Iio0J3ecp+jxHVqIsFeF0uXR9jh0TAoc2aAP89Tb+m0VRD
3+ar7iiJOSPRdzw10MoEEGlVlYXxQg==
=JVwG
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--

--===============3948711451727991137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3948711451727991137==--
