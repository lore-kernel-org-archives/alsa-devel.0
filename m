From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH] ASoC: da7219: Update the support rate list
Date: Thu, 2 May 2019 10:07:05 +0000
Message-ID: <AM5PR1001MB0994A52E77F12680F71AB08080340@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190502040743.184310-1-yuhsuan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502040743.184310-1-yuhsuan@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 02 May 2019 05:08, Yu-Hsuan Hsu wrote:

> If we want to set rate to 64000 on da7219, it fails and returns
> "snd_pcm_hw_params: Invalid argument".
> We should remove 64000 from support rate list because it is not
> available.
>=20
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7219.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 5f5fa3416af3..7497457cf3d4 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1658,20 +1658,26 @@ static const struct snd_soc_dai_ops da7219_dai_op=
s
> =3D {
>  #define DA7219_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |
> SNDRV_PCM_FMTBIT_S20_3LE |\
>  			SNDRV_PCM_FMTBIT_S24_LE |
> SNDRV_PCM_FMTBIT_S32_LE)
>=20
> +#define DA7219_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025
> |\
> +		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> +		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> +		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> +		      SNDRV_PCM_RATE_96000)
> +
>  static struct snd_soc_dai_driver da7219_dai =3D {
>  	.name =3D "da7219-hifi",
>  	.playback =3D {
>  		.stream_name =3D "Playback",
>  		.channels_min =3D 1,
>  		.channels_max =3D DA7219_DAI_CH_NUM_MAX,
> -		.rates =3D SNDRV_PCM_RATE_8000_96000,
> +		.rates =3D DA7219_RATES,
>  		.formats =3D DA7219_FORMATS,
>  	},
>  	.capture =3D {
>  		.stream_name =3D "Capture",
>  		.channels_min =3D 1,
>  		.channels_max =3D DA7219_DAI_CH_NUM_MAX,
> -		.rates =3D SNDRV_PCM_RATE_8000_96000,
> +		.rates =3D DA7219_RATES,
>  		.formats =3D DA7219_FORMATS,
>  	},
>  	.ops =3D &da7219_dai_ops,
> --
> 2.21.0.593.g511ec345e18-goog
