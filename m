From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add more settings for rt5639
Date: Wed, 9 Apr 2014 21:44:21 +0100
Message-ID: <20140409204421.GS6518@sirena.org.uk>
References: <1397045989-13518-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1447907281925873976=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B55EC265044
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 22:44:33 +0200 (CEST)
In-Reply-To: <1397045989-13518-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1447907281925873976==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QHhm1I6mwQR20oIa"
Content-Disposition: inline


--QHhm1I6mwQR20oIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2014 at 08:19:49PM +0800, Oder Chiou wrote:

> index 0000000..d63c662
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rt5639.txt
> @@ -0,0 +1,48 @@
> +RT5639 audio CODEC

This doesn't really need to be a separate document, just add the
information to the rt5640 document.

> +#if defined(CONFIG_OF)
> +static const struct of_device_id rt5640_of_match[] = {
> +	{ .compatible = "realtek,rt5640", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt5640_of_match);
> +
> +static const struct of_device_id rt5639_of_match[] = {
> +	{ .compatible = "realtek,rt5639", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt5639_of_match);
> +#endif

This looks broken - you should have one driver with one table.

> +#if defined(CONFIG_OF)
> +		.of_match_table = of_match_ptr(rt5640_of_match),
> +#endif

Drop the ifdef, the whole point with of_match_ptr() is that you don't
need it.

> +static struct i2c_driver rt5639_i2c_driver = {
> +	.driver = {
> +		.name = "rt5639",
> +		.owner = THIS_MODULE,

No, add an ID table to the I2C driver - look at wm8904 for an example.

--QHhm1I6mwQR20oIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRbEiAAoJELSic+t+oim9SM8P/1Im9kPBoLCt30SxRRIo7moJ
HbMX9ktoWT7QRCxTqAmWvVDloV+dw1vFYXdRIioxJO1C2ko0O9ARt0hHWgOTQNTK
6Z8qIdJRdboWK/E4d9v/ae3QlhniDMnkDeufvqoyCIa8mSdW5o3342gpctzWyKv5
FTWSQbngl0QRZMiYOhlpSKsEsfJ4pGUpgIu7YTI+2F2EaIggZd9AuUmgmUZ9eWEP
+yDFicr1ddt87pAG0b03m3N12rpJdtlffUARXv7ECgTRVdCTFu+PwyWy+TY1KpWt
ajwf1bzc/qAQTdc1xOIoDiBZ0nl/7qeyse81mFFeIY8V5Ggf742b9u6eZ6Jle2W+
IW63KFpYGSzhKBS6lq2pPg+m+O+aMFGfyyQY/6zYTox6VOQMuJiVdFvas1zzxNlW
bS8BvaaxLjlVVBh39IPm6zSgThOFlr70XWFCOGLeqwExAMMljjS/xDHLiK2bFqcl
OABMvJERF7MHjiVifXexiRS7fdDQsxcMHkNTSRZEd0aSGaL8A2P1mBtwn91sgnN5
OC7718G315q6AQxvcjR6GxaT3JTYpbpVwGLc4YlFGi0RXv0q1XV7etn4LYDjvwF3
tSLDbo4hZOm6+/Da/PiWCoZlX6VyQqGWzKJC8yfNhgSIdpRgE7RskDSzhoKoIwJg
SzWI8C8+xnlNJfDFkFan
=+NWw
-----END PGP SIGNATURE-----

--QHhm1I6mwQR20oIa--

--===============1447907281925873976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1447907281925873976==--
