From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/8] ASoC: core: Add debug-print helper
	function
Date: Mon, 23 Apr 2012 19:03:15 +0100
Message-ID: <20120423180315.GS8318@opensource.wolfsonmicro.com>
References: <1334914372-27409-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1392200599376346713=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5F1D243B3
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 20:03:17 +0200 (CEST)
In-Reply-To: <1334914372-27409-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1392200599376346713==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80Ds8Z/hZmemMosa"
Content-Disposition: inline


--80Ds8Z/hZmemMosa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2012 at 11:32:52AM +0200, Ola Lilja wrote:

> +/* Get a string naming the direction of a stream */
> +const char *snd_soc_stream_str(struct snd_pcm_substream *substream)
> +{
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		return "Playback";
> +	else
> +		return "Capture";
> +}

This should be added to the ALSA core, there's nothing ASoC specific
about it.

--80Ds8Z/hZmemMosa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlZlbAAoJEBus8iNuMP3dLc8P+wR82hFkrT9vgabiqoWsa7jR
b0s6yAMyPZAb+vPfrA7bYjfreVlGfzEU+t2d9e7Exq9SRlov+0VYEJ+Kr7ZxwbJ/
LPuB/hGL06jUC+s3kOZ/05msxcEEkBY8133bx9uuyb3mtXDjaGqpp7Cp+SwObKiH
lh71i/EE6jXguVH0KSIPo8rf99RZyyweAQ0aqjngQ3czLvgdDxIsIwpjCS+83Wpe
oBPmotiiR22OVqzfnf4fctD57v76BBzRY1zCqXKGBtpw5NA414hlHKaGaU9MssrZ
N0DZBZGm157UiOXN3gqeZ6erqeHHo30HnkTz4E5XEpzSA8NdksP1/udddL2f9gFh
DSDl+9pRZ1h5XKpXKO6wwCqh29A6nEBoJSR2hxgzuFti28ZlInIXvzk6QRKyckMH
9hLaye9/Ei+9EbQxMXFnw9RgMl/zoPOwpHzuMZ/JdmQ/uYt835QSpfBFRd1J6I8n
B17B+a/yBH7rsltvT/FrJN1h7vqKO1XdkHFqiQtMYIy6m8TGWMknjZvQfUp+f3tV
NAl1pDBwGeVOu4l8rMwo7N5Fb8uIa1poZrYKd5lCWIG/aer770MeP2NcvLKruzik
X7HO4aaC8V7rX0jnsJ5MHRJxd1hm+fGH1Kzghf7tuVOtzqTldTDk5+3I1E269Hn4
tmymDxo6Sa9CZCcivBQe
=4Vxb
-----END PGP SIGNATURE-----

--80Ds8Z/hZmemMosa--

--===============1392200599376346713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1392200599376346713==--
