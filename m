From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC fixes for v3.13
Date: Thu, 21 Nov 2013 14:49:31 +0000
Message-ID: <20131121144931.GB8120@sirena.org.uk>
References: <20131121140456.GS2674@sirena.org.uk>
 <s5hli0hom0v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5594505544279850888=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 131082650E5
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:49:34 +0100 (CET)
In-Reply-To: <s5hli0hom0v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5594505544279850888==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 03:41:04PM +0100, Takashi Iwai wrote:

> +#else
> +static inline int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
> +					 struct snd_soc_jack_gpio *gpios)
> +{
> +	return 0;
> +}
> +static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
> +					   struct snd_soc_jack_gpio *gpios)
> +{
> +}
>  #endif

This stubbing seems fine (with a blank between those two).  Can you send
a patch please?

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjh14AAoJELSic+t+oim98M8P/RUGo+Iw0AIiVwDjtZi0rlqV
SQLifFuN9CBYFjM47J5vTAVvWj9v80Su0z7BQCpA0UPNGIZWvpmXSD19cwQ7GxCq
rJjRekn/eR2oGODJq2J1+GiSnc9gEjDeOkj/sAdDAdvW0KTABrvt4/+x998ZeVUT
ACNpcpxLOZt/0Lq2E4rxjNcYbNRjGpmulfhIOftZZL3KM3rDD7uANaDNE/tj0WXC
Q21xg1NSEF7h1EOIfkc7Nd6D0GPYMJcIQN58s3pGdvqwsXZ2Uvsdd/yPW4m6uLGr
28jRLETxy7BSCYq9dzX6an/kwzUuVEdu6EzUQU5nMQnUZISSt4B1xvwqGlKltIaD
gS6s6vaULmu6b48HukuPGUW77QgYi22fjiXJvDxENMK43ugfafRSqUjdQctQ01LS
dMdKtql1/BU2HSajqdfX6q4bi5oke5LnvFl56QBAsAprnd3xO5wVWFzwILtaJm6m
xfjzi4Ru1Au6ja7JjYIotEUIOa8efDSK84yb7NlF+vF7+YDvlVd1H7//kNNybolU
mmYG5y/ONaxH4uU7rAmQp6A0nE3LP4gkbj8Q1hkPWwbBbzbaqeVHSrWytsGOHMb0
dY9+uLP5V8kvh67Wu6FtwwK31Ur/YUOFukqO3eAs+SUPejm2y+8Xjd8LGnYE04AY
09fXig+a3urZrdh1gCs1
=vmxW
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

--===============5594505544279850888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5594505544279850888==--
