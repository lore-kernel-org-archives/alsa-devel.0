From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 1/3] ASoC: OMAP: data_type and sync_mode
 configurable in audio dma
Date: Fri, 19 Feb 2010 10:35:25 +0000
Message-ID: <1266575725.3236.4.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8F94A4EF@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id A80CD1037EA
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 11:35:32 +0100 (CET)
Received: by ewy5 with SMTP id 5so1938978ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 02:35:32 -0800 (PST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8F94A4EF@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-02-18 at 18:32 -0600, Candelaria Villareal, Jorge wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> Allow client drivers to set the data_type (16, 32) and the
> sync_mode (element, packet, etc) of the audio dma transferences.
> 
> McBSP dai driver configures it for a data type of 16 bits and
> element sync mode.
> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

This looks fine, but I've just one minor comment below.

> ---
>  sound/soc/omap/omap-mcbsp.c |    2 ++
>  sound/soc/omap/omap-pcm.c   |   15 ++++++++-------
>  sound/soc/omap/omap-pcm.h   |    4 +++-
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 6bbbd2a..d297256 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -287,6 +287,8 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
>  	omap_mcbsp_dai_dma_params[id][substream->stream].port_addr = port;
>  	omap_mcbsp_dai_dma_params[id][substream->stream].sync_mode = sync_mode;
> +	omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
> +							OMAP_DMA_DATA_TYPE_S16;
>  	cpu_dai->dma_data = &omap_mcbsp_dai_dma_params[id][substream->stream];
>  
>  	if (mcbsp_data->configured) {
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 9db2770..825db38 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -37,7 +37,8 @@ static const struct snd_pcm_hardware omap_pcm_hardware = {
>  				  SNDRV_PCM_INFO_INTERLEAVED |
>  				  SNDRV_PCM_INFO_PAUSE |
>  				  SNDRV_PCM_INFO_RESUME,
> -	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
> +	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
> +				  SNDRV_PCM_FMTBIT_S32_LE,
>  	.period_bytes_min	= 32,
>  	.period_bytes_max	= 64 * 1024,
>  	.periods_min		= 2,
> @@ -149,6 +150,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  	struct omap_runtime_data *prtd = runtime->private_data;
>  	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
>  	struct omap_dma_channel_params dma_params;
> +	int bytes;
>  
>  	/* return if this is a bufferless transfer e.g.
>  	 * codec <--> BT codec or GSM modem -- lg FIXME */
> @@ -156,11 +158,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  		return 0;
>  
>  	memset(&dma_params, 0, sizeof(dma_params));
> -	/*
> -	 * Note: Regardless of interface data formats supported by OMAP McBSP
> -	 * or EAC blocks, internal representation is always fixed 16-bit/sample
> -	 */

Perhaps this should be rewritten to reflect mcbsp and mcpdm users rather
than deleted.

> -	dma_params.data_type			= OMAP_DMA_DATA_TYPE_S16;
> +	dma_params.data_type			= dma_data->data_type;
>  	dma_params.trigger			= dma_data->dma_req;
>  	dma_params.sync_mode			= dma_data->sync_mode;
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> @@ -170,6 +168,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  		dma_params.src_start		= runtime->dma_addr;
>  		dma_params.dst_start		= dma_data->port_addr;
>  		dma_params.dst_port		= OMAP_DMA_PORT_MPUI;
> +		dma_params.dst_fi		= dma_data->packet_size;
>  	} else {
>  		dma_params.src_amode		= OMAP_DMA_AMODE_CONSTANT;
>  		dma_params.dst_amode		= OMAP_DMA_AMODE_POST_INC;
> @@ -177,6 +176,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  		dma_params.src_start		= dma_data->port_addr;
>  		dma_params.dst_start		= runtime->dma_addr;
>  		dma_params.src_port		= OMAP_DMA_PORT_MPUI;
> +		dma_params.src_fi		= dma_data->packet_size;
>  	}
>  	/*
>  	 * Set DMA transfer frame size equal to ALSA period size and frame
> @@ -184,7 +184,8 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  	 * we can transfer the whole ALSA buffer with single DMA transfer but
>  	 * still can get an interrupt at each period bounary
>  	 */
> -	dma_params.elem_count	= snd_pcm_lib_period_bytes(substream) / 2;
> +	bytes = snd_pcm_lib_period_bytes(substream);
> +	dma_params.elem_count	= bytes >> dma_data->data_type;
>  	dma_params.frame_count	= runtime->periods;
>  	omap_set_dma_params(prtd->dma_ch, &dma_params);
>  
> diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
> index 38a821d..b19975d 100644
> --- a/sound/soc/omap/omap-pcm.h
> +++ b/sound/soc/omap/omap-pcm.h
> @@ -29,8 +29,10 @@ struct omap_pcm_dma_data {
>  	char		*name;		/* stream identifier */
>  	int		dma_req;	/* DMA request line */
>  	unsigned long	port_addr;	/* transmit/receive register */
> -	int		sync_mode;	/* DMA sync mode */
>  	void (*set_threshold)(struct snd_pcm_substream *substream);
> +	int		data_type;	/* data type 8,16,32 */
> +	int		sync_mode;	/* DMA sync mode */
> +	int		packet_size;	/* packet size only in PACKET mode */
>  };
>  
>  extern struct snd_soc_platform omap_soc_platform;

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
