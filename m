From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] ASoC: dapm: Fix potential NULL pointer
	dereference
Date: Sun, 2 Dec 2012 13:14:34 +0900
Message-ID: <20121202041433.GT17981@opensource.wolfsonmicro.com>
References: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
 <1353488819-13902-6-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0820275617768656228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5389B2650DF
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:14:38 +0100 (CET)
In-Reply-To: <1353488819-13902-6-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============0820275617768656228==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZcSDOt7TZFizttpn"
Content-Disposition: inline


--ZcSDOt7TZFizttpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 02:36:59PM +0530, Sachin Kamat wrote:

>  		if (!w) {
>  			dev_err(dapm->dev, "Failed to create %s widget\n",
>  				dai->driver->playback.stream_name);
> +		} else {
> +			w->priv = dai;
>  		}

This isn't a particularly sensible fix, we should be erroring out or
something rather than limping along with the rest of the function.

--ZcSDOt7TZFizttpn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutWiAAoJELSic+t+oim9CY0P/iCtZmu4/SRv2KwDZAQHk282
HjV4ayAS0yGGiFUDinlqDUszgQvhRyzwbd1p4lclGCkDKAi+8ZDFUIFJeOu9HbEb
SbgYeiJUC7BLTPipukyEXkMNrqYSmh2qjI5gleIyaJNGEfhGqg0KKY1ktxAKZm82
j7X2PzGneDgG7cbGCHPs0JNTTPZG6VcgkVrv9EPQEAR/dXgblKuT4ujuVC7vrJjQ
aThotUmrlhMn5dGVtgldF2OgLb6P7kv6v6uKR7spyymyYDNmyrKVpIVZB0sBuMPu
UTpyOrMqgJ/7tlKuUZ33Pu+ftBllCfz9jqEy2AD71g27Coizh8cJJYdYv4x7MwFu
J9/rfgEda9y6I85ShxfEkDTJ76ZiX/N4mcWWESYYZ/KqB3htBITeEv0WWsA/3WwN
LzPwOr7o10poWEF5065qDz9OkwEn3ImiqG3euY49WTzncY96Cce8mSfNxvQsL0ek
5gImCIK5rkLFZLoNaTLLYkPmVo/dARCS7NbivU6z9p3ZhXpzObFwrEQ6xxgCr0Az
LFyNUHDDRcoQU0RAehPiGNvRMWIWvogFPnnUd6hwuL18jP8Z7jtIMIMW58fVVNMA
sw0OfkmIk9HzZRO38BzaZyHIoDxjBCKCdQYW4qUJZbROHdswcQZxLjOYFkPjRSNU
gKhbsngxXPyqGkv5rW/3
=Zk9c
-----END PGP SIGNATURE-----

--ZcSDOt7TZFizttpn--

--===============0820275617768656228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0820275617768656228==--
