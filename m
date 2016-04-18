From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: jack: Add a jack detect callback via codec
Date: Mon, 18 Apr 2016 10:22:18 +0100
Message-ID: <20160418092218.GL3217@sirena.org.uk>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-2-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3141822313800025064=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1460967452-24574-2-git-send-email-zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============3141822313800025064==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4e5ZDkbgLEOfWmLx"
Content-Disposition: inline


--4e5ZDkbgLEOfWmLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 04:17:30PM +0800, Xing Zheng wrote:
> This patch add a callback when a codec have the jack detect feature.

> +void snd_soc_jack_codec_detect(struct snd_soc_codec *codec,
> +				struct snd_soc_jack *jack)
> +{
> +	if (codec && codec->driver && codec->driver->detect_jack)
> +		codec->driver->detect_jack(codec, jack);
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_jack_codec_detect);

I've no idea what this is supposed to do sorry, you need a much better
changelog and probably also a restructuring of the code.  This says it
is adding a callback but it doesn't do that, it adds an export of a
function that calls an operation in a driver with no explanation.

--4e5ZDkbgLEOfWmLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFKdJAAoJECTWi3JdVIfQfFsH/0cTD0fCjL8ulsJuFqWvTD47
UCIed86ZfZG+ueP537JrwiNxfWeZhmqpLrfrn2yqazBx0CG236El/OBzIVDQ7RZS
i0NberfYQTE2SwXe6KYoouG9i8ygfwJczZwFRSk5+U7l0vVwb+KQaIf66au49SHO
Z7EmPZsYidIEpE0RCMtXqS/MrXkK3n4cc6bv0ePH6nNoyoe3A4cS8wxTFUVYENJ2
PMkjR0VNgKPnv+LVIL57RvwoAUIqhIjwsRZrXng6eDY5zpY+I23hgC9laB3bPVzd
JFOkHJlZ9eh9NldP120ks4nWIOBdG+pQDIV63TqusRV+fW64bq2nyn0KFaSv+ls=
=ALD6
-----END PGP SIGNATURE-----

--4e5ZDkbgLEOfWmLx--


--===============3141822313800025064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============3141822313800025064==--
