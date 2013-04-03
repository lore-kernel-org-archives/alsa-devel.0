From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/8] ASoC: dmaengine-pcm: Add a common DAI
	DMA data struct
Date: Wed, 3 Apr 2013 12:07:30 +0200
Message-ID: <515BFF62.9080202@ti.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B5FE265CC9
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 12:07:34 +0200 (CEST)
In-Reply-To: <1364979965-15776-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 11:06 AM, Lars-Peter Clausen wrote:
> This patch adds a common DMA data struct which can be used by DAI drivers=
 to
> communicate their DMA configuration requirements to the DMA pcm driver.  =
Having
> a common data structure for this allows us to implement common functions =
on top
> of them, which can be used by multiple platforms.
> =

> This patch also introduces a new function to initialize certain fields of=
 a
> dma_slave_config struct from the common DAI DMA data struct.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  include/sound/dmaengine_pcm.h | 24 ++++++++++++++++++++++++
>  sound/soc/soc-dmaengine-pcm.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> =

> diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
> index f8a7031..9562042 100644
> --- a/include/sound/dmaengine_pcm.h
> +++ b/include/sound/dmaengine_pcm.h
> @@ -44,4 +44,28 @@ int snd_dmaengine_pcm_close(struct snd_pcm_substream *=
substream);
>  =

>  struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *su=
bstream);
>  =

> +/**
> + * struct snd_dmaengine_dai_dma_data - DAI DMA configuration data
> + * @addr: Address of the DAI data source or destination register.
> + * @addr_width: Width of the DAI data source or destination register.
> + * @maxburst: Maximum number of words(note: words, as in units of the
> + * src_addr_width member, not bytes) that can be send to or received fro=
m the
> + * DAI in one burst.
> + * @slave_id: Slave requester id for the DMA channel.
> + * @filter_data: Custom DMA channel filter data, this will usually be us=
ed when
> + * requesting the DMA channel.
> + */
> +struct snd_dmaengine_dai_dma_data {
> +	dma_addr_t addr;
> +	enum dma_slave_buswidth addr_width;
> +	u32 maxburst;
> +	unsigned int slave_id;
> +	void *filter_data;
> +};
> +
> +void snd_dmaengine_pcm_set_config_from_dai_data(
> +	const struct snd_pcm_substream *substream,
> +	const struct snd_dmaengine_dai_dma_data *dma_data,
> +	struct dma_slave_config *config);
> +
>  #endif
> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
> index 7c24ded..a9a300a 100644
> --- a/sound/soc/soc-dmaengine-pcm.c
> +++ b/sound/soc/soc-dmaengine-pcm.c
> @@ -95,6 +95,43 @@ int snd_hwparams_to_dma_slave_config(const struct snd_=
pcm_substream *substream,
>  }
>  EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
>  =

> +/**
> + * snd_dmaengine_pcm_set_config_from_dai_data() - Initializes a dma slav=
e config
> + *  using DAI DMA data.
> + * @substream: PCM substream
> + * @dma_data: DAI DMA data
> + * @slave_config: DMA slave configuration
> + *
> + * Initializes the {dst,src}_addr, {dst,src}_maxburst, {dst,src}_addr_wi=
dth and
> + * slave_id fields of the DMA slave config from the same fields of the D=
AI DMA
> + * data struct. The src and dst fields will be initialized depending on =
the
> + * direction of the substream. If the substream is a playback stream the=
 dst
> + * fields will be initialized, if it is a capture stream the src fields =
will be
> + * initialized. The {dst,src}_addr_width field will only be initialized =
if the
> + * addr_width field of the DAI DMA data struct is not equal to
> + * DMA_SLAVE_BUSWIDTH_UNDEFINED.
> + */
> +void snd_dmaengine_pcm_set_config_from_dai_data(
> +	const struct snd_pcm_substream *substream,
> +	const struct snd_dmaengine_dai_dma_data *dma_data,
> +	struct dma_slave_config *slave_config)
> +{
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> +		slave_config->dst_addr =3D dma_data->addr;
> +		slave_config->dst_maxburst =3D dma_data->maxburst;
> +		if (dma_data->addr_width !=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +			slave_config->dst_addr_width =3D dma_data->addr_width;
> +	} else {
> +		slave_config->src_addr =3D dma_data->addr;
> +		slave_config->src_maxburst =3D dma_data->maxburst;
> +		if (dma_data->addr_width !=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +			slave_config->src_addr_width =3D dma_data->addr_width;
> +	}
> +
> +	slave_config->slave_id =3D dma_data->slave_id;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
> +
>  static void dmaengine_pcm_dma_complete(void *arg)
>  {
>  	struct snd_pcm_substream *substream =3D arg;
> =



-- =

P=E9ter
