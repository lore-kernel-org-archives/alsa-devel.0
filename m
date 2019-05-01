From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v2] ASoC: da7213: fix DAI_CLK_EN register bit overwrite
Date: Wed, 1 May 2019 16:32:04 +0000
Message-ID: <AM5PR1001MB0994908D0F450CC19DADF69F803B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190501090424.28861-1-logesh.kolandavel@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501090424.28861-1-logesh.kolandavel@timesys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Logesh Kolandavel <logesh.kolandavel@timesys.com>, Support Opensource <Support.Opensource@diasemi.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01 May 2019 10:04, Logesh Kolandavel wrote:

> From: Logesh <logesh.kolandavel@timesys.com>
>=20
> If the da7213 codec is configured as Master with the DAPM power down
> delay time set, 'snd_soc_component_write' function overwrites the
> DAI_CLK_EN bit of DAI_CLK_MODE register which leads to audio play
> only once until it re-initialize after codec power up.
>=20
> Signed-off-by: Logesh <logesh.kolandavel@timesys.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
> Changes in v2:
> -Include the mask DA7213_DAI_BCLKS_PER_WCLK_MASK
>=20
>  sound/soc/codecs/da7213.c | 5 ++++-
>  sound/soc/codecs/da7213.h | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 92d006a5283e..425c11d63e49 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -1305,7 +1305,10 @@ static int da7213_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	/* By default only 64 BCLK per WCLK is supported */
>  	dai_clk_mode |=3D DA7213_DAI_BCLKS_PER_WCLK_64;
>=20
> -	snd_soc_component_write(component, DA7213_DAI_CLK_MODE,
> dai_clk_mode);
> +	snd_soc_component_update_bits(component,
> DA7213_DAI_CLK_MODE,
> +			    DA7213_DAI_BCLKS_PER_WCLK_MASK |
> +			    DA7213_DAI_CLK_POL_MASK |
> DA7213_DAI_WCLK_POL_MASK,
> +			    dai_clk_mode);
>  	snd_soc_component_update_bits(component, DA7213_DAI_CTRL,
> DA7213_DAI_FORMAT_MASK,
>  			    dai_ctrl);
>  	snd_soc_component_write(component, DA7213_DAI_OFFSET,
> dai_offset);
> diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
> index 5a78dba1dcb5..9d31efc3cfe5 100644
> --- a/sound/soc/codecs/da7213.h
> +++ b/sound/soc/codecs/da7213.h
> @@ -181,7 +181,9 @@
>  #define DA7213_DAI_BCLKS_PER_WCLK_256				(0x3 << 0)
>  #define DA7213_DAI_BCLKS_PER_WCLK_MASK
> 	(0x3 << 0)
>  #define DA7213_DAI_CLK_POL_INV					(0x1 << 2)
> +#define DA7213_DAI_CLK_POL_MASK
> 	(0x1 << 2)
>  #define DA7213_DAI_WCLK_POL_INV					(0x1 << 3)
> +#define DA7213_DAI_WCLK_POL_MASK				(0x1 << 3)
>  #define DA7213_DAI_CLK_EN_MASK					(0x1 << 7)
>=20
>  /* DA7213_DAI_CTRL =3D 0x29 */
> --
> 2.21.0
