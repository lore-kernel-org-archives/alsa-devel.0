From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/21] ASoC: io: Prevent use of regmap if
	request fails
Date: Thu, 26 Jul 2012 12:32:04 +0100
Message-ID: <20120726113204.GY3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6606467248213802997=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3017265E60
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 13:32:03 +0200 (CEST)
In-Reply-To: <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============6606467248213802997==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R0SsnouPYaG+7rP6"
Content-Disposition: inline


--R0SsnouPYaG+7rP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2012 at 11:28:40AM +0100, Lee Jones wrote:

> @@ -52,10 +52,13 @@ static unsigned int hw_read(struct snd_soc_codec *cod=
ec, unsigned int reg)
>  		if (codec->cache_only)
>  			return -1;
> =20
> -		ret =3D regmap_read(codec->control_data, reg, &val);
> -		if (ret =3D=3D 0)
> -			return val;
> -		else
> +		if (codec->using_regmap) {
> +			ret =3D regmap_read(codec->control_data, reg, &val);
> +			if (ret =3D=3D 0)
> +				return val;
> +			else
> +				return -1;
> +		} else

No, this makes no sense.  There is no non-regmap I/O support in soc-io,
anything using the soc-io hw_read() function must be using regmap.

>  	case SND_SOC_REGMAP:
>  		/* Device has made its own regmap arrangements */
> -		codec->using_regmap =3D true;

Again, this makes no sense.  If we're explicitly being asked to use
regmap then we should be using regmap or just failing to set up I/O
(which is obviously a catastrophic failure).

--R0SsnouPYaG+7rP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQESquAAoJEBus8iNuMP3d9DsP/iDnBdEh+CX25QbvBdsNCa6/
KjsDUX0kLU07gIfa8dq+A1k6MLIsHte5h43MhHZS3Tuck3GvxfGD1nPLA2ok4V/5
uLEgzGxPJywXpf3130/2H8pHTsFKXt9lNPPhsGuBNdF3YJcKMtRtRL+JHxY+p4Vc
heIjm9Ap90nDRbU2l6uWlC1T1pBzlY4KwZvJMqtCJja6DwEptnnBklk/vpyl5d2J
CvquDClF76pSZgtbrfN8hpOpi6CLWf0+Ks9a2RXhw9SM9YWRh/x0nNMUfpJjWwZQ
4a+5f5R2DPkO3t8ir8IPL9YQf+gKVfBcPFzi3hc0b2EPIuPJjqIj7j1NjczG9p7z
Pf03Bqj3o34QAVgvL3n7zbE66YK5PjhQlxC5o3e3maejeBoOr8EEGOhkZqvlImeR
chD2O6dTrHWvkck+ethnT2/Sq0fS1kCBg/aBAOZMCnrezYZAf1MU4myLaHbK3678
TIV1pj63qakN18IdwoKVncDC1SgIIMgvCbR5pg7kQYIh4SKusDdDpqbTemfEs4Qc
yZeTXK5ENnriN1jZsIMRIu88rh/XHrHdbtmas1aQHX1vuhnlXD40wDuwPOzxEgBt
0kr+mgXGOoEG4ZVMtXEBp590jxXJs1oZoMy1YhHzmCeqJz4R0gU0G5qf8HmZat3u
+H9v3cdDja4WWYPTLJa/
=mbZQ
-----END PGP SIGNATURE-----

--R0SsnouPYaG+7rP6--

--===============6606467248213802997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6606467248213802997==--
