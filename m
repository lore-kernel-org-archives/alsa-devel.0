From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Only do
 snd_soc_dai_digital_mute() in hw_free()
Date: Tue, 3 Dec 2013 15:04:23 +0000
Message-ID: <20131203150423.GW27568@sirena.org.uk>
References: <1386062166-29634-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8316584147511701946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 588DD265200
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 16:04:26 +0100 (CET)
In-Reply-To: <1386062166-29634-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8316584147511701946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t/JWjz/Yah8jyPtY"
Content-Disposition: inline


--t/JWjz/Yah8jyPtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2013 at 05:16:06PM +0800, Nicolin Chen wrote:

> @@ -689,7 +684,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *=
substream)
>  	struct snd_soc_platform *platform =3D rtd->platform;
>  	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>  	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> -	struct snd_soc_codec *codec =3D rtd->codec;
> +	bool playback =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK ? =
1 : 0;

Please don't use the ternery operator, you could've just used the result
of the comparison directly here.

>  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
> =20
> @@ -707,7 +702,8 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *=
substream)
>  	}
> =20
>  	/* apply codec digital mute */
> -	if (!codec->active)
> +	if ((playback && codec_dai->playback_active =3D=3D 1) ||
> +			(!playback && codec_dai->capture_active =3D=3D 1))
>  		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);

This is a bit confusing to read due to the strange indentation (the
second line is massively indented with respect to the first line for
some reason).  This hunk also ought to be split out as a separate patch
since it's a bug fix.

--t/JWjz/Yah8jyPtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnfL0AAoJELSic+t+oim9jAUQAJoqcI9qC55OvScYFFbVmJ+1
W+4gVz+xHUA4hVPwShErM82GU7E6Kjm3htJtlnpl8Mv9pLwwMoLb/5B3s1ERqj5X
lu4o0tGL8lkwTweXXmPIFPjf3PSw79/snYWjM0qTDZ8lKfOSjqsQBLBOOUcI9PHQ
KGZf2558s/S+xGrz3aAbrKuXax+5RK2DSBz49oYM5qpwgbaIiWmbwgfhl+lORXpF
Hnf7CDhv7KAh59gMCBUOtajU7vS5BfE56wDfA4HGP3OUvBFCWPJPvQ9Yk2Mo5cKG
pUK2t7qVvBuylbQ2vZHK86jgUwLiFdJIYcCv1oSNncAWA5jSP9JFyxWMvjYLhx6Z
2t5O2e/imJGb+doxzZ+MNaaJ2pD+jdz/b5EpWIJEz0kOHmVk3kTsSGmBH/slM3YP
kFaie0k3lcbTre7262/Afa+ZLIlGmCOCoeYwQGgY1lGIYN2YmvbYUb+fNeJTEcOC
mUjvj58/8nUXkNbhGXOvGF7PeWwytyMJ4EKrQpWH/vEu9aJuc5VICMewI4sXMZzH
yGafRfk4OzOhqdNgQU6b5Q1fU+Wv0J4kXMbWQgU5TDvh9g0iFhpi+Nyy7fsKBM41
wwK8SAWJT0funih9mrdZgWqkr+cx+lVdiWYjp+N4mCAHPJhkGuI915zbiX9DNklN
C9FeuwjIUCeYaSzqyP11
=QPKS
-----END PGP SIGNATURE-----

--t/JWjz/Yah8jyPtY--

--===============8316584147511701946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8316584147511701946==--
