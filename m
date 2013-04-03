From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/8] ASoC: dmaengine_pcm: Setup device_fc
	in snd_hwparams_to_dma_slave_config
Date: Wed, 3 Apr 2013 12:07:15 +0200
Message-ID: <515BFF53.8050608@ti.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979780-15364-1-git-send-email-lars@metafoo.de>
 <1364979780-15364-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE82265CB0
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 12:07:21 +0200 (CEST)
In-Reply-To: <1364979780-15364-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 11:02 AM, Lars-Peter Clausen wrote:
> Usually device_fc should be set to false for audio DMAs. Initialize it in=
 a
> common place so drivers don't have to do this manually.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/atmel/atmel-pcm-dma.c | 2 --
>  sound/soc/fsl/imx-pcm-dma.c     | 2 --
>  sound/soc/soc-dmaengine-pcm.c   | 2 ++
>  3 files changed, 2 insertions(+), 4 deletions(-)
> =

> diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-=
dma.c
> index b8570e3..bb07989 100644
> --- a/sound/soc/atmel/atmel-pcm-dma.c
> +++ b/sound/soc/atmel/atmel-pcm-dma.c
> @@ -129,8 +129,6 @@ static int atmel_pcm_configure_dma(struct snd_pcm_sub=
stream *substream,
>  		slave_config.src_maxburst =3D 1;
>  	}
>  =

> -	slave_config.device_fc =3D false;
> -
>  	dma_chan =3D snd_dmaengine_pcm_get_chan(substream);
>  	if (dmaengine_slave_config(dma_chan, &slave_config)) {
>  		pr_err("atmel-pcm: failed to configure dma channel\n");
> diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
> index 6832c49..64af573 100644
> --- a/sound/soc/fsl/imx-pcm-dma.c
> +++ b/sound/soc/fsl/imx-pcm-dma.c
> @@ -57,8 +57,6 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substre=
am *substream,
>  	if (ret)
>  		return ret;
>  =

> -	slave_config.device_fc =3D false;
> -
>  	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
>  		slave_config.dst_addr =3D dma_params->dma_addr;
>  		slave_config.dst_maxburst =3D dma_params->burstsize;
> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
> index e8b1215..7c24ded 100644
> --- a/sound/soc/soc-dmaengine-pcm.c
> +++ b/sound/soc/soc-dmaengine-pcm.c
> @@ -89,6 +89,8 @@ int snd_hwparams_to_dma_slave_config(const struct snd_p=
cm_substream *substream,
>  		slave_config->src_addr_width =3D buswidth;
>  	}
>  =

> +	slave_config->device_fc =3D false;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
> =



-- =

P=E9ter
