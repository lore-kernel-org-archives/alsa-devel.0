From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH] ASoC: AMD: Configure master codec on all playback/capture
 cases
Date: Fri, 15 Feb 2019 09:58:32 +0000
Message-ID: <AM5PR1001MB0994E7CBCAF8345EEEAC787E80600@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190215070539.22150-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215070539.22150-1-akshu.agrawal@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Wei Yongjun <weiyongjun1@huawei.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 15 February 2019 07:06, Akshu Agrawal wrote:

> In the system design da7219 is the master codec and clocks are generated =
by it.
> Bclk is to be generated at the required rate for other codecs used when
> da7219 is acting only as clock master. For this call hw_params of da7219 =
during
> playback/capture on non da7219 codecs.
>=20
> Being able to set bclk at lower rate also fixes noise issue observed on s=
ome
> dmics.
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/amd/acp-da7219-max98357a.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-
> da7219-max98357a.c
> index a5daad973ce5..ad327415290a 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -45,6 +45,7 @@
>  #define CZ_PLAT_CLK 48000000
>  #define DUAL_CHANNEL		2
>=20
> +static struct snd_soc_dai *codec_dai;
>  static struct snd_soc_jack cz_jack;
>  static struct clk *da7219_dai_clk;
>  extern int bt_uart_enable;
> @@ -53,8 +54,10 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *=
rtd)
> {
>  	int ret;
>  	struct snd_soc_card *card =3D rtd->card;
> -	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> -	struct snd_soc_component *component =3D codec_dai->component;
> +	struct snd_soc_component *component;
> +
> +	codec_dai =3D rtd->codec_dai;
> +	component =3D codec_dai->component;
>=20
>  	dev_info(rtd->dev, "codec dai name =3D %s\n", codec_dai->name);
>=20
> @@ -255,6 +258,16 @@ static void cz_dmic_shutdown(struct
> snd_pcm_substream *substream)
>  	da7219_clk_disable();
>  }
>=20
> +static static int cz_da7219_hw_params(struct snd_pcm_substream *substrea=
m,
> +				    struct snd_pcm_hw_params *params) {
> +	/* da7219 Codec is clock master so setup as per the needs */
> +	if (codec_dai->driver->ops->hw_params)
> +		return codec_dai->driver->ops->hw_params(substream, params,
> +							 codec_dai);
> +	return 0;
> +}
> +
>  static const struct snd_soc_ops cz_da7219_play_ops =3D {
>  	.startup =3D cz_da7219_play_startup,
>  	.shutdown =3D cz_da7219_shutdown,
> @@ -268,16 +281,19 @@ static const struct snd_soc_ops cz_da7219_cap_ops =
=3D {
> static const struct snd_soc_ops cz_max_play_ops =3D {
>  	.startup =3D cz_max_startup,
>  	.shutdown =3D cz_max_shutdown,
> +	.hw_params =3D cz_da7219_hw_params,
>  };
>=20
>  static const struct snd_soc_ops cz_dmic0_cap_ops =3D {
>  	.startup =3D cz_dmic0_startup,
>  	.shutdown =3D cz_dmic_shutdown,
> +	.hw_params =3D cz_da7219_hw_params,
>  };
>=20
>  static const struct snd_soc_ops cz_dmic1_cap_ops =3D {
>  	.startup =3D cz_dmic1_startup,
>  	.shutdown =3D cz_dmic_shutdown,
> +	.hw_params =3D cz_da7219_hw_params,
>  };
>=20
>  static struct snd_soc_dai_link cz_dai_7219_98357[] =3D {
> --
> 2.17.1
