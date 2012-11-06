From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC patch v3 3/4] ASoC: atmel-ssc-dai: register dai and pcm
 directly
Date: Tue, 6 Nov 2012 09:48:14 +0100
Message-ID: <20121106084814.GC5044@opensource.wolfsonmicro.com>
References: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
 <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com
List-Id: alsa-devel@alsa-project.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2012 at 01:57:53PM +0800, Bo Shen wrote:

>  static struct platform_device at91sam9260_ssc_device = {
> -	.name	= "at91rm9200_ssc",
> +	.name	= "at91rm9200_ssc_dai",
>  	.id	= 0,
>  	.dev	= {

No, this isn't converting things to device tree which presumably is the
goal here and obviously just doing the rename doesn't accomplish an
enormous amount.  What I said was that you should instantiate the ASoC
adaption when the machine driver needs to use them.  You shouldn't even
need a separate device for this.

Please do look at other platforms with similar hardware and do something
similar to them.

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmM7DAAoJELSic+t+oim9ppoQAJwJbKb1JezL/G48nwCk+FRO
lQs9UaGo7N9rZNlnLBuZcig8tYkA0aj3W9T3uvfuLau76LhN8K2aTqur/c+fZUQ2
nD9ThF9i8knuvI+QMciXVc6BNXi1PpYKcOK4lMJkeNvoIFroJz17BJB0COkp2oXC
DCqii9wriHfVsS6MW7+i4Zy7uCL9cuId1JiZcrPSg+BUN1OgvJj5KtThBdNIaI5v
+PI9PM/X87fVNODLQjP2z31DN9kxRRQYlXarxq9LcBVy2b/k0CJ00R8BXVsijqg6
9+BrLkLF2tY6XTV5yZgpLU7M5HxPeoyVTxMiSUAOvevYfZycS/qsqkOE6D6ZSsuV
znaDpAEdln4RIREyDRrW7d7qwXI3ArV3dCgWcV01I2FcbD/l5FpuaXsdsjYPzuYP
vVhjLXKDzq2z3xqE8NBh9zW+qZ0DiTVBx5O41HF52ZTVs6W2kqOrUFIEyhOHiLae
vMyYPmhWt9JqG6Dm6FPBowlx8xC9hAyPB/6loV6sxC00QMF9Xa7BpOnEst6go+Ol
jvY8JGoIi/SfrmpBfGtIrc5f/pc07Oa3X7p99iw0wY2zzLR6KmtSHvgs09I16T6w
WYKAIxhVYsIVt/zrn2YoOmY7jQXCZKW0UVRW8JXAPjZRpDBuf8qo0TQCEXSCOelS
bQTNCWBElZmsLpALGaQm
=1/dQ
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
