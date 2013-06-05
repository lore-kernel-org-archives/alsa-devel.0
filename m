From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: WM8962: Add device tree binding
Date: Wed, 5 Jun 2013 13:27:18 +0100
Message-ID: <20130605122718.GC31367@sirena.org.uk>
References: <cover.1370433363.git.b42378@freescale.com>
 <1c716a6860c9486071c11a7f7752d14b217f4ef1.1370433363.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1618430376563224890=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4928326545B
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:27:22 +0200 (CEST)
In-Reply-To: <1c716a6860c9486071c11a7f7752d14b217f4ef1.1370433363.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, rob.herring@calxeda.com, grant.likely@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============1618430376563224890==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xtcA6s3naMKOsC7S"
Content-Disposition: inline


--xtcA6s3naMKOsC7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2013 at 08:12:56PM +0800, Nicolin Chen wrote:

> +  - gpio-cfg : A list of GPIO configuration register values. The list must
> +    be 6 entries long. If absent, no configuration of these registers is
> +    performed. And note that the max value for each entry is 0xffff, don't
> +    fill a large one.

It is nicer for users if out of band values are ignored, providing them
with a method for specifying the default register value without having
to actually encode it.  This is both more legible (they explicitly say
"use the default, I don't care") and less work (as the default doesn't
need to be checked).

--xtcA6s3naMKOsC7S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRry6iAAoJELSic+t+oim9cPwP/3HFCjso8Dho22pyBjcSRf6v
vvCXDOza+SweCtlLjuMiJNYRfMj3+/io2fcukquYT6CU9MBrJzyWw2eko8haKtsu
Zwv8M170pLDLTAGCX8XfKRWxyK93dGyXzwxhlEV/vuiNikbogxEtwCCDUSBK/tWP
24zSkwrazcFku2VVLXTGh5MQVB2cp5u5Hu5j4n9d6hWFGoLxDIhwfB7KCtYGT+8h
VqbMohl04EU2lfa5d0ZaCCbxQWcSaJgnlNlUNhxdtYQHYWLk5dNvnJ1NNbn2DjbE
m3+ij/h6ijAEVlS1EUeGSV/ClzWfpEUwWQQPSpAPTvC/0Oo/i8l883TzYuUolgQv
Tu/1ON4RIG1gHOswemZWOzoZWgNMYucOu8C6/pNBEea3rst8QXFhJIGH89LcPxrk
nNyNckI7oLb2nA4YAbfYT4A8QVaAZE6Geq1Uc1AAXQHMxVgbfklaEBxbcXA+Fwuf
LtJx1bp3CK84RRKTLX+YzCojBBatqPsHmb0J7e/bexMJOw1GN+oyHxGJuTINhOOH
dMRm8g6VQTrB3DHHha7SnyPY6/8BLmMnogI1hHemes1BYTqvNktCCXXUMKBgBAMW
TiNClAWCot9WqicJFdZLuP0E4kJkSlLZKp9HQZLXchIq5k6tBhtXeW/5Z5R+SyzE
KYqhNypOoVooDtPaS4tz
=/it4
-----END PGP SIGNATURE-----

--xtcA6s3naMKOsC7S--

--===============1618430376563224890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1618430376563224890==--
