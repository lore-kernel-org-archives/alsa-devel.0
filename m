From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8580: Fix build error
Date: Fri, 24 Jan 2014 11:10:35 +0000
Message-ID: <20140124111035.GS11727@sirena.org.uk>
References: <1390552765-32210-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4672067226696082792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 268BD261693
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 12:10:44 +0100 (CET)
In-Reply-To: <1390552765-32210-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4672067226696082792==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZVTVymsHR1TEBjP"
Content-Disposition: inline


--4ZVTVymsHR1TEBjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 02:09:24PM +0530, Sachin Kamat wrote:

> +#if IS_ENABLED(CONFIG_I2C)
> +static const char *wm8580_supply_names[WM8580_NUM_SUPPLIES] = {
> +	"AVDD",
> +	"DVDD",
> +	"PVDD",
> +};

This is obviously not sensible - the device doesn't suddenly stop
needing power if it is using SPI.

--4ZVTVymsHR1TEBjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4konAAoJELSic+t+oim9KwYP/ReeAESwtZyebkA/wJ2V8IDq
vQiXAy+W0NxAQUb4fqpJcjCIXtfnmobWmr39njPUza0bIQXb2+0kZbQbkK0zbQWv
qBN4bh5qB2zmTRXPhmU1Nd/GcddVIOL6pnNlvvoX7iIKikFE91OFtMiFoDmqo6bN
cMNAHln40IMPKZjaQGuVptuNCDE8PIZMkYgbfe4SQqoL/TnEM+JJ6KrB0FVMM/Ky
B3EDIhxe/2fz0BZlLAQreF08xTiJTXmV3kf7E25wDZcnRsV9Lynicoc4QBy0opij
5Q+XesVcBsxxndpgf9Usz4eFgm1ag43wZZ7umxuJ5ODTbTuyl8K9sspXh/Mcqu1E
lfOrFeiqpY+bE0UD+3iXefcb+Vp7Wzxnb5rP1qnF42SLn92lZxnA+39JkkAePeTZ
1dnILQ6T8BCazQQb9kUfp70SuYbD14+ag3Vt+gty0/2Aa8w2h/4+D2FQgbgYlC4p
ERA42Maz1Jm4ApMhW+QinvkGQIcHLai3TzjrAdGiwgzjWybKTpxfLtOW5UmPSX+g
t+gZ5xMeYrhCeZNQG3oV0PZAIBcPxIYQU8p0KKkvsgXZTGWZt+a+Y2O2Dc6bs24r
4aQeS6q3KLWH2M29Vbeps/N/RVFMIhi6pdy+icbA8loOHgz1ZXp2hRp2Cr0BsqCG
Tr0sbL9YBRCgY87ZqSLv
=jTwi
-----END PGP SIGNATURE-----

--4ZVTVymsHR1TEBjP--

--===============4672067226696082792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4672067226696082792==--
