From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Fix SUSPEND -> OFF bias
	sequence
Date: Mon, 5 May 2014 12:41:29 -0700
Message-ID: <20140505194129.GT22111@sirena.org.uk>
References: <1399223826-28522-1-git-send-email-lars@metafoo.de>
 <1399223826-28522-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3613973208525350333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9538265098
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:59:04 +0200 (CEST)
In-Reply-To: <1399223826-28522-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3613973208525350333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J9YdZykiGPT3Jhx7"
Content-Disposition: inline


--J9YdZykiGPT3Jhx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 04, 2014 at 07:17:06PM +0200, Lars-Peter Clausen wrote:

> -	/* Prepare for a STADDBY->ON or ON->STANDBY transition */
> -	if (d->bias_level != d->target_bias_level) {
> +	/* Prepare for a transition to ON or away from ON */
> +	if ((d->target_bias_level == SND_SOC_BIAS_ON &&
> +		 d->bias_level != SND_SOC_BIAS_ON) ||
> +		(d->target_bias_level != SND_SOC_BIAS_ON &&
> +		 d->bias_level == SND_SOC_BIAS_ON)) {

Can you fix the indentation so that the two sides of the or are lined
up?  It's a bit of a fiddly test and having the two cases not lined up
makes it harder to read.

--J9YdZykiGPT3Jhx7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+lmAAoJELSic+t+oim96BoP/jJ4mrYNO1UBBlEGM9kJlpuY
HnbEbP5rvUEeqkab25i+MTSf/KhlyeA4VNwNPaDgMqehGdoxCwysXtffmMhfu3Tu
cLEy09d2cknBwpuWTo7RTgqmuHn6DY3w92o4Az3NS8DaT/nA+m8KUL47GPGvvI61
ywvOw8vi1al/J+s7K6UxJB3lAf3K5n4o2/M34h8rrG5LYIyclxBzs/oOYX7Ud9hF
wBLHSzUDqVpHv6VywoqAPsSE1gf/83ru8B2m+jfwg5zJVlhRL80eTMn67JsHiPCc
1xzx2l8eKAAAd1+W7IbkBt+SUCFw4M6YuFTLa0IikyS60kPcWwPteEJxmTccTeOR
wOVuZn4VWOx5hqNylkwsq0h/ClUdMBvYHEgKVMkK4UPcI2nVVxjIS8XUxeaR9rn6
DiKirh01xEDlOviMZY28+knm7hKLsl01/hZ9jacq9oKM94um648CnocqQvgpdeXv
rSRO5HFipcNJXt0OkPb2mFLuJpqToEbj6y/n1CZFOMKfox7DwzJ/LiMJ+nZZxpIk
LErZdN34rlHKPev4lIVau2jwdve8FCKyUcAv5DfmspJJsyQ8ysj5wCjS5Wphr563
85Oue5IGcQQQQxsZZ7tXIMRAy9Hsc3xgr5O5DGS9aC19/R0CO0X/sA3FS1eaFxvG
HcekWMx59yxTEC7ECqQd
=X9YA
-----END PGP SIGNATURE-----

--J9YdZykiGPT3Jhx7--

--===============3613973208525350333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3613973208525350333==--
