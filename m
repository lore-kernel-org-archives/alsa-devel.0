From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: arizona: Improve ultrasonic
	frequency response
Date: Fri, 31 Jan 2014 16:06:44 +0000
Message-ID: <20140131160644.GJ22609@sirena.org.uk>
References: <1391183234-13943-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1391183234-13943-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0479665029639847255=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B74F261B19
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 17:07:00 +0100 (CET)
In-Reply-To: <1391183234-13943-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, sameo@linux.intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0479665029639847255==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yPvoiCUUfIqTdDlV"
Content-Disposition: inline


--yPvoiCUUfIqTdDlV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 03:47:14PM +0000, Charles Keepax wrote:
> Evaluation of the device has given some settings to improve the
> ultrasonic frequency response. This patch allows the user the option of
> applying those.

Why would the user ever not want to do this?

> +	switch (priv->arizona->type) {
> +	case WM5102:
> +		if (priv->arizona->pdata.ultrasonic_response) {
> +			snd_soc_write(codec, 0x80, 0x3);
> +			if (params_rate(params) >= 176400)
> +				snd_soc_write(codec, 0x4dd, 0x1);
> +			else
> +				snd_soc_write(codec, 0x4dd, 0x0);
> +			snd_soc_write(codec, 0x80, 0x0);
> +		}
> +		break;

The code is only changing the configuration when the user is actually
using ultrasonic sample rates so it doesn't seem like it should have a
detrimental effect on other configurations.

--yPvoiCUUfIqTdDlV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS68oRAAoJELSic+t+oim9Cs4P/jUxWkMx5XLg/VRnBXdu0DJ0
gLVnRSJyEXpjcHGmnZ8g8dPeJWuIVhMsvuQbkUdo4Z6iWrUuPllzRMnu/OA/AZVS
GGcwLBW2/qB8rrTc32U7Bq36eHOBgkPoegMhUXGbt7cdPmOMhB3xe+ZNjo/dCSLj
+cNpQ99yK8B5yl8wsEd4f+GguJvynwZK3kpQjNjnlwSMjgq7ysqCAwAphZwrmlDC
MKGN0+CR9JgoPfSf+vvG4C3sbS1Mk2GApR9lQRwm37kjSmoig5mzu4jkoT9jPixs
9p1A1RYXgD5OZPSMYI8BRO/+nCXi1ZcVvnuQY38RepK7P81E1jfyhtpFAF9WLxAz
WDgHFrKC5CpSiiPgGHwnp9ms4G0JYz3HcARg9fiPZZnlX5gVBLwBy91wWzpSwY6m
pW5gkxRPLiv2C/1JisA4/mDOcSJCxtg5Pe7U412KkQKyuv0vUUSaGbrRWBGc6T4H
aZWfPWowT5ZX4dvIE6V3QVl6u8nFsxWLHELg6x0nQy4aSHG1W0fBmz60UhIv+w9n
53k96SAFDJbe7OI8fZjOdMuIFowY491qL41bouEBVo64gsmS0Y4YYiut8NsUbF2t
Vp0eCgC1riwK7UKG7hXihmAYSSkjflj4/Oo9bbzSE5C3DbGWji4fehcSh68axA8B
545pOJMGI8F7m68FkdaO
=e8m5
-----END PGP SIGNATURE-----

--yPvoiCUUfIqTdDlV--

--===============0479665029639847255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0479665029639847255==--
