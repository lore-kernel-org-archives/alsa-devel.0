From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/2] ASoC: WM8962: Add device tree binding
Date: Thu, 6 Jun 2013 14:28:57 +0100
Message-ID: <20130606132857.GA31367@sirena.org.uk>
References: <cover.1370518627.git.b42378@freescale.com>
 <a7acc6e603272a9d48324712f54da9bb1fa46889.1370518627.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1076844599961466242=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <a7acc6e603272a9d48324712f54da9bb1fa46889.1370518627.git.b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============1076844599961466242==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HHsIqWg7hQfWlXNC"
Content-Disposition: inline


--HHsIqWg7hQfWlXNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 07:38:46PM +0800, Nicolin Chen wrote:

> +Optional properties:
> +  - spk-mono: Default register value for SPK_MONO of R51 (Class D Control 2).

This doesn't correspond to the code.  This is a boolean property, if
it's present then that bit gets set indicating that the speaker is in
mono mode.

> +  - mic-cfg : Default register value for R48 (Additional Control 4).
> +    If absent, the default is 0.

Again if it's absent the default should be the register default.

--HHsIqWg7hQfWlXNC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsI6WAAoJELSic+t+oim98yQP/0+Bq3FqFeJWM+Yn+X2XckGP
pLr/HQiLDdhHTAohhHhIHA03MNHfh6pS7Shwp+Ht6xPDprDwR7ffFfe0d5yebWLk
QrvcrKP3JHzY2dglA5p2IXhpm4GqLjhXiO1BGExSLKXSYD6r7hsspu/zlaO7YJpW
8TPYu3d9arOOyhhCOefHGdvPq+4UkdvlMZC/7BlnoX6g1k9bGJnvioqACmUntvbv
yiI0/yqw0HasIqOV1q90XfWKTq8LaVZtSB6KK2Dut9YxnCR3cmV2ch+F3cTXm13t
EzzP4A1JuPbxiS4KE8iV8ekSZKljzf1FgYkTuYeLC4XAoIbS420zo+lSnuCWkB8O
8v0ob/o4Ksy1qFxk48nzRTafOugjQwm9mYGpqi6NenZo3KbbqPbw24wCZMcYzDq1
dM0nLsRX4UtxHCMK6jjn8WsW5UBqs1Um/RWt2HYJYnW/hmKp2skfqSXh6hDMk7Uz
np5ZmlbzaBRG5ABuw2Rri7eGiZC7ik++GD2ZNAeYZIrpQ+iSl8RqSIxEnIJH1u38
nx9TS4Z/ze2rpY9EZrOGLJc0w7WAN6o1ACsaaOHQxBMqHCyS8edDHVv/RmnPKwLP
jA3v7kJgwl+Iy7+3OJAJKmLC+dexUh7EgpwiTSRFyNVpFv6DDSNeL4t0k+0BruP7
Hqz40xwmXCeiczZO2Q7M
=1LLn
-----END PGP SIGNATURE-----

--HHsIqWg7hQfWlXNC--

--===============1076844599961466242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1076844599961466242==--
