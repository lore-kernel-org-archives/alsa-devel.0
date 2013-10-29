From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Fix null pointer pdata
 access in I2C probe()
Date: Tue, 29 Oct 2013 09:35:56 -0700
Message-ID: <20131029163556.GI16686@sirena.org.uk>
References: <1383037587-19439-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8410806732849364727=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5645F2610CE
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 17:36:24 +0100 (CET)
In-Reply-To: <1383037587-19439-1-git-send-email-b42378@freescale.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============8410806732849364727==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2013 at 05:06:27PM +0800, Nicolin Chen wrote:
> When using DT binding to pass private data, there would be Kernel panic
> occuring due to NULL pointer access in wm8962_i2c_probe(). Thus fix it.

Applied, thanks, so it makes v3.13 though...

> -	for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
> -		if (pdata->gpio_init[i]) {
> +	for (i = 0; i < ARRAY_SIZE(wm8962->pdata.gpio_init); i++)
> +		if (wm8962->pdata.gpio_init[i]) {

...it'd be neater to just ensure that pdata is always initialised.

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb+PpAAoJELSic+t+oim9KEoQAJ5+L+rVrHWnQn3rtnjudnaI
c1MGCeoPbczgWDeBdw/2XIgXcdaMpZR2HPhEOdz/wq/jBm4T5pQ7sVzvWh/2SS1O
8nS/vhTLRMmr3ADqH2VpiyGRC+VMzQtHvoyTI1gjpTvP3qmoJEwv5fc0mMz9LMfU
so8i7nNiEicaPVkFbniHBvl6a5X0gQfHkNcFSlNqASTDM/o19IzJP4lmfamnECjO
KPDzCFz2wMI1V2DZt72B+tjLgSu+H6rtli+QdUk91eeiRM7cmM97ra8A6S3o2lNU
f8+dD4rSOiggu2Ey7gZlHPikvYI+r2kW98LMDmepdKKLMkfDe1NAhv8Gfspv0C5S
Tr8J0NI+R93RdYRjXvO9Ga5R7/a9lNMgl/BNOm7oJ7lwhPGgebsf+M7+gAwen4PP
RfOqe27nyEaKD9j97lUSWyZ9vWdNaBNh/8+sCViONrs51XnKljqeKcw99D5A1gvL
neWJmcDx6JOUr2iclSWmZJOBTDCd/iZ6dGMot3Fum99gdasOmK/J6jp8pmnbGEQK
zc889IHoQxfsqBE76UH9r6ZtDUDSrROE/I+UcWTJsDZoDRs23cWvehraLvCFbscA
jowgihWbk9cPbjNF8/ZX+34Ybv5a6KjtxMzhpnboloejEpiOn3UbcrJQpRnmBNfk
yz6jnqMtics/jSNB3GHk
=iayW
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--

--===============8410806732849364727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8410806732849364727==--
