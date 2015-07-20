From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] ASoC: fsl_ssi: Add driver suspend
 and resume to support MEGA Fast
Date: Mon, 20 Jul 2015 18:50:02 +0100
Message-ID: <20150720175002.GK11162@sirena.org.uk>
References: <ee6572bca11f44288db1d38e1934c0a7e7fb9ed2.1436339869.git.zidan.wang@freescale.com>
 <32243d772f82eb67e4a561b842be9661d730f0b1.1436339869.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4293706252269104269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 330EB26149E
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:50:12 +0200 (CEST)
In-Reply-To: <32243d772f82eb67e4a561b842be9661d730f0b1.1436339869.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============4293706252269104269==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ejJQ0IcBGdgxjfAY"
Content-Disposition: inline


--ejJQ0IcBGdgxjfAY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2015 at 03:22:29PM +0800, Zidan Wang wrote:

>  static const struct regmap_config fsl_ssi_regconfig = {
>  	.max_register = CCSR_SSI_SACCDIS,
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
>  	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.readable_reg = fsl_ssi_readable_reg,
> +	.volatile_reg = fsl_ssi_volatile_reg,
> +	.writeable_reg = fsl_ssi_writeable_reg,
> +	.cache_type = REGCACHE_RBTREE,
>  };

Same thing here - should this be an rbtree?

--ejJQ0IcBGdgxjfAY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVrTTJAAoJECTWi3JdVIfQiz4H/RXpbPfKqKE59xQ0asnxQDKD
Gc384y42v5dtd+XT02NQuaZeBf0VlIF8FB2Wo4wNBGiOI941iZgRZAggLXYNbYVA
hKXcLY+0YFQPhdEDjAIyndwDY9GAydOlf7HK1g7UmwXSJOHiFXnaZIYFBYXQhDVv
rHcLPWa93P3LcHRz3W8mRgxQFWKoPWG2WGQtWhZHYLSp3N/6dQDUzUK4zKOCf0zs
gSsdSADSAQL3DwnqEp62/vJ1I58H2bkQisXJpOD+rNy0QnBjCy2q/kHXVUvJJrex
J3gt4o1bZVMO3xk8D9d+05/3blWGWtiPDpmlgKbNtvR0sjQ6oMIMO9pSxIb7WB8=
=LkGX
-----END PGP SIGNATURE-----

--ejJQ0IcBGdgxjfAY--

--===============4293706252269104269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4293706252269104269==--
