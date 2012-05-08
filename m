From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/11] sound: core: Add debug-print helper
	function
Date: Tue, 8 May 2012 15:08:03 +0100
Message-ID: <20120508140802.GS15893@opensource.wolfsonmicro.com>
References: <1336485385-27077-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7960492142238929758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6BC51043C7
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 16:08:05 +0200 (CEST)
In-Reply-To: <1336485385-27077-1-git-send-email-ola.o.lilja@stericsson.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7960492142238929758==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ga5bsqHr1s/xcZEm"
Content-Disposition: inline


--ga5bsqHr1s/xcZEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2012 at 03:56:25PM +0200, Ola Lilja wrote:
> Adds a function getting the stream-name as a string for
> a specific stream.

Adding Takashi as this is an ALSA core thing.  Always CC maintainers on
patches and always try to use subject lines matching the standard for
the subsystem.  Not cutting any text for his benefit.

>=20
> Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
> ---
>  include/sound/pcm.h |    2 ++
>  sound/core/pcm.c    |   10 ++++++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 0d11128..8a153e6 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -1073,4 +1073,6 @@ static inline void snd_pcm_limit_isa_dma_size(int d=
ma, size_t *max)
> =20
>  const char *snd_pcm_format_name(snd_pcm_format_t format);
> =20
> +const char *snd_pcm_stream_str(struct snd_pcm_substream *substream);
> +
>  #endif /* __SOUND_PCM_H */
> diff --git a/sound/core/pcm.c b/sound/core/pcm.c
> index 1a3070b..9e83f00 100644
> --- a/sound/core/pcm.c
> +++ b/sound/core/pcm.c
> @@ -1187,6 +1187,16 @@ static void snd_pcm_proc_done(void)
>  #define snd_pcm_proc_done()
>  #endif /* CONFIG_PROC_FS */
> =20
> +/**
> + * Get a string naming the direction of a stream
> + */
> +const char *snd_pcm_stream_str(struct snd_pcm_substream *substream)
> +{
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		return "Playback";
> +	else
> +		return "Capture";
> +}

This needs to be exported for modular builds, or perhaps just made a
static inline in the header.

> =20
>  /*
>   *  ENTRY functions
> --=20
> 1.7.8.3
>=20

--ga5bsqHr1s/xcZEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqSdqAAoJEBus8iNuMP3deeEQAIwB1Xo6gDlisoW7tBA1PhGu
RA7PNkMZvKACxNk4NnoYeGzRuQMMYEUEKxPgRbOgmB+hhpit5Q03ADOMh/5jyfoQ
Iirs1qzLko4OMwEZBlEOi8+dSLYhFcVCj1/QoiyCLJvD24mrSO5ZCdnuVXaWyvo0
kiQRH6rA98UyP1abx6ZFzxjWNpKOeIRE1JSWfOQPorZPbwFX/2B2IxYV/V22RUVa
6bEMmEjzW0+mqwM4mPP6iFaGZw0Wf//yBDdz39M3st/09xwFPgrN+p+xz7vp5F1c
KeWAFhf/k7yB0QCTRrkfjm+VCloIisdctSLgSrHnb/8aCuxpzAJkgY2XZDfTWPgJ
Cq7YMrbqopA1f45k60sCam5Qzp9E1BJOwUQqJhjWSOyhKB2bqph5SNWk13QRFrIY
X8P36t4oIG11xTyggSp3mnZWcDzHWQ/ul5HV4txCRkzy9w8janJ826gdo4hmE5Hk
AT4fkiPYnDyqqvqCTXWmIpLlmbTIl8Gt0oRQPapsCvJTCAaDIFXkchbjf7Ubye7S
Jkt/GFyIS5kHzxuIxT6D4/3gMPO35LAZLZrbGcQInghLn4ZzPxX9PK1MzjV37n+N
whwLvaeXLU1QhUCzmBwCUEUu+7PrGrTBOMX7Onn78cAi4XOBi39oA4pxme77MOuh
Ds9sjkdYhE1ZV3jG0sX1
=b2IN
-----END PGP SIGNATURE-----

--ga5bsqHr1s/xcZEm--

--===============7960492142238929758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7960492142238929758==--
