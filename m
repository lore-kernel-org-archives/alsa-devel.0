From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: max98090: Remove unnecessary
	braces
Date: Wed, 20 Feb 2013 16:52:58 +0000
Message-ID: <20130220165258.GK2726@opensource.wolfsonmicro.com>
References: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
 <1361187134-7525-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0937307001124493486=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 960F82616BF
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:52:59 +0100 (CET)
In-Reply-To: <1361187134-7525-4-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============0937307001124493486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cy+5HEalSgyXkpVS"
Content-Disposition: inline


--Cy+5HEalSgyXkpVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2013 at 05:02:13PM +0530, Sachin Kamat wrote:

> -	if (val >= 1) {
> -		if (w->reg == M98090_REG_MIC1_INPUT_LEVEL) {
> +	if (val >= 1){

Your coding style fixes shouldn't introduce new coding style issues
and...

> +		if (w->reg == M98090_REG_MIC1_INPUT_LEVEL)

...in cases where you're nesting with other if statements it's often
clearer to have the braces consistently over all levels of the
conditional.

For the isolated if statements this is fine though.

--Cy+5HEalSgyXkpVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJP9jAAoJELSic+t+oim9b2EP/3A5kE/mKoBqfq/dnLWKVqIk
GA4106OexAyO1n6/xWsa9BVkiAaqXO/Z/XSfz9PCYFtx4StfIQ5CGs6+J6oNxdhD
wEXpnffu4LyiBItiAoxRUPZfPkEDd86+2ni+LizvPeg8QJWVuxsW/pjW2yfX+HtX
ofPvstlARlHQ/rRjxX/IPrAh4skhcdgaIf3PfLAzjTVC3FQXHswrhqQVc82qTwfT
+YXvmUCPEVSmjhhb/AGeF/bNG6gVIDPzug5eGHx+CganHyOwr+9Tslr0kryiKCqU
ypL0t0J3gfG/FVGJ1osIz87L5aZGh3BXqGWefLGLeb+C6GmQGwjhfhT0Iowk1xo2
MqQNMnDHJHZ2CpVLltoEXztpGsHclq/H08LDhkXekdzKUdPrVX4JIvQC+Vo+GDuT
Jew4UqTOMQgYYd0F4gSaZSOR1uxa8zVT4OKkA041FayzuBrpoAymVQsqMVrDQCzu
NnincpF8OGSSf0F4uW1bXzUwozREUw2M/5VCJkOahbTHcq47HzSVNWH4FKeqa9jD
CUpbMYCEKpld5zG1H1eLgspehfxCcjKHO52RZwZmraE/cdTafbAZwcS6KPHS4Fgh
/MpSa8tGVNIzOZ9qc8K2qGrEUOutaFubB5Hs06p5+BmYhIHXTMF+wLdscLtf7Rsy
HLYcP3ZWGYwiLF81sxEd
=AXAA
-----END PGP SIGNATURE-----

--Cy+5HEalSgyXkpVS--

--===============0937307001124493486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0937307001124493486==--
