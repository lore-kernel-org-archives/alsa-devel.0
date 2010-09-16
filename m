From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/4] ASoC: fsi: modify variable name to
 easy to understand
Date: Thu, 16 Sep 2010 14:25:26 +0100
Message-ID: <1284643526.21170.28.camel@vega>
References: <w3p8w32wbmv.wl%kuninori.morimoto.gx@renesas.com>
	<w3p4odqwbl3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F2FFA243AD
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 15:25:34 +0200 (CEST)
Received: by yxj4 with SMTP id 4so474212yxj.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2010 06:25:31 -0700 (PDT)
In-Reply-To: <w3p4odqwbl3.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-09-16 at 13:34 +0900, Kuninori Morimoto wrote:
> Current FSI driver is using data
> length, width, number, offset for variables.
> But it was a very confusing name.
> 
> This patch rename them to easy to understand,
> and add new functions for it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/fsi.c |  179 +++++++++++++++++++++++++++++-----------------------
>  1 files changed, 99 insertions(+), 80 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 156c73b..06f1e1b 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -101,6 +101,15 @@
>  
>  #define FSI_FMTS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
>  
> +/*
> + * FSI driver use below type name for variable
> + *
> + * xxx_len	: data length
> + * xxx_width	: data width
> + * xxx_ofs	: data offset

Best to keep this as xxx_offset

> + * xxx_num	: number of data
> + */
> +
>  /************************************************************************
>  
> 
> @@ -113,13 +122,13 @@ struct fsi_priv {
>  	struct snd_pcm_substream *substream;
>  	struct fsi_master *master;
>  
> -	int fifo_max;
> -	int chan;
> +	int fifo_max_num;
> +	int chan_num;
>  
> -	int byte_offset;
> -	int period_len;
> -	int buffer_len;
> -	int periods;
> +	int buff_ofs;
> +	int buff_len;
> +	int period_width;

Do you mean the _size_ of the period here in bytes or frames or
something else ?

Fwiw, it's often better to qualify the variable with it's unit of
measurement. e.g. period_bytes or period_frames

> +	int period_num;
>  
>  	u32 mst_ctrl;
>  };
> @@ -329,32 +338,43 @@ static void fsi_stream_push(struct fsi_priv *fsi,
>  			    u32 period_len)
>  {
>  	fsi->substream		= substream;
> -	fsi->buffer_len		= buffer_len;
> -	fsi->period_len		= period_len;
> -	fsi->byte_offset	= 0;
> -	fsi->periods		= 0;
> +	fsi->buff_len		= buffer_len;
> +	fsi->buff_ofs		= 0;
> +	fsi->period_width	= period_len;
> +	fsi->period_num		= 0;
>  }
>  
>  static void fsi_stream_pop(struct fsi_priv *fsi)
>  {
>  	fsi->substream		= NULL;
> -	fsi->buffer_len		= 0;
> -	fsi->period_len		= 0;
> -	fsi->byte_offset	= 0;
> -	fsi->periods		= 0;
> +	fsi->buff_len		= 0;
> +	fsi->buff_ofs		= 0;
> +	fsi->period_width	= 0;
> +	fsi->period_num		= 0;
>  }
>  
> -static int fsi_get_fifo_residue(struct fsi_priv *fsi, int is_play)
> +static int fsi_get_fifo_data_num(struct fsi_priv *fsi, int is_play)
>  {
>  	u32 status;
>  	u32 reg = is_play ? DOFF_ST : DIFF_ST;
> -	int residue;
> +	int data_num;
>  
>  	status = fsi_reg_read(fsi, reg);
> -	residue = 0x1ff & (status >> 8);
> -	residue *= fsi->chan;
> +	data_num = 0x1ff & (status >> 8);
> +	data_num *= fsi->chan_num;
> +
> +	return data_num;
> +}
>  
> -	return residue;
> +static int fsi_len2num(int len, int width)
> +{
> +	return len / width;
> +}
> +
> +#define fsi_num2ofs(a, b) fsi_num2len(a, b)
> +static int fsi_num2len(int num, int width)
> +{
> +	return num * width;
>  }
>  
>  /************************************************************************
> @@ -366,50 +386,50 @@ static int fsi_get_fifo_residue(struct fsi_priv *fsi, int is_play)
>  ************************************************************************/
>  static u8 *fsi_dma_get_area(struct fsi_priv *fsi)
>  {
> -	return fsi->substream->runtime->dma_area + fsi->byte_offset;
> +	return fsi->substream->runtime->dma_area + fsi->buff_ofs;
>  }
>  
> -static void fsi_dma_soft_push16(struct fsi_priv *fsi, int size)
> +static void fsi_dma_soft_push16(struct fsi_priv *fsi, int num)
>  {
>  	u16 *start;
>  	int i;
>  
>  	start  = (u16 *)fsi_dma_get_area(fsi);
>  
> -	for (i = 0; i < size; i++)
> +	for (i = 0; i < num; i++)
>  		fsi_reg_write(fsi, DODT, ((u32)*(start + i) << 8));
>  }
>  
> -static void fsi_dma_soft_pop16(struct fsi_priv *fsi, int size)
> +static void fsi_dma_soft_pop16(struct fsi_priv *fsi, int num)
>  {
>  	u16 *start;
>  	int i;
>  
>  	start  = (u16 *)fsi_dma_get_area(fsi);
>  
> -	for (i = 0; i < size; i++)
> +	for (i = 0; i < num; i++)
>  		*(start + i) = (u16)(fsi_reg_read(fsi, DIDT) >> 8);
>  }
>  
> -static void fsi_dma_soft_push32(struct fsi_priv *fsi, int size)
> +static void fsi_dma_soft_push32(struct fsi_priv *fsi, int num)
>  {
>  	u32 *start;
>  	int i;
>  
>  	start  = (u32 *)fsi_dma_get_area(fsi);
>  
> -	for (i = 0; i < size; i++)
> +	for (i = 0; i < num; i++)
>  		fsi_reg_write(fsi, DODT, *(start + i));
>  }
>  
> -static void fsi_dma_soft_pop32(struct fsi_priv *fsi, int size)
> +static void fsi_dma_soft_pop32(struct fsi_priv *fsi, int num)
>  {
>  	u32 *start;
>  	int i;
>  
>  	start  = (u32 *)fsi_dma_get_area(fsi);
>  
> -	for (i = 0; i < size; i++)
> +	for (i = 0; i < num; i++)
>  		*(start + i) = fsi_reg_read(fsi, DIDT);
>  }
>  
> @@ -512,8 +532,8 @@ static void fsi_fifo_init(struct fsi_priv *fsi,
>  	shift = fsi_master_read(master, FIFO_SZ);
>  	shift >>= fsi_is_port_a(fsi) ? AO_SZ_SHIFT : BO_SZ_SHIFT;
>  	shift &= OUT_SZ_MASK;
> -	fsi->fifo_max = 256 << shift;
> -	dev_dbg(dai->dev, "fifo = %d words\n", fsi->fifo_max);
> +	fsi->fifo_max_num = 256 << shift;
> +	dev_dbg(dai->dev, "fifo = %d words\n", fsi->fifo_max_num);
>  
>  	/*
>  	 * The maximum number of sample data varies depending
> @@ -534,9 +554,10 @@ static void fsi_fifo_init(struct fsi_priv *fsi,
>  	 * 7 channels:  32 ( 32 x 7 = 224)
>  	 * 8 channels:  32 ( 32 x 8 = 256)
>  	 */
> -	for (i = 1; i < fsi->chan; i <<= 1)
> -		fsi->fifo_max >>= 1;
> -	dev_dbg(dai->dev, "%d channel %d store\n", fsi->chan, fsi->fifo_max);
> +	for (i = 1; i < fsi->chan_num; i <<= 1)
> +		fsi->fifo_max_num >>= 1;
> +	dev_dbg(dai->dev, "%d channel %d store\n",
> +		fsi->chan_num, fsi->fifo_max_num);
>  
>  	ctrl = is_play ? DOFF_CTL : DIFF_CTL;
>  
> @@ -565,9 +586,9 @@ static int fsi_data_push(struct fsi_priv *fsi, int startup)
>  	struct snd_pcm_runtime *runtime;
>  	struct snd_pcm_substream *substream = NULL;
>  	u32 status;
> -	int send;
> -	int fifo_free;
> -	int width;
> +	int push_num;
> +	int push_num_max;
> +	int ch_width;
>  	int over_period;
>  
>  	if (!fsi			||
> @@ -582,41 +603,40 @@ static int fsi_data_push(struct fsi_priv *fsi, int startup)
>  	/* FSI FIFO has limit.
>  	 * So, this driver can not send periods data at a time
>  	 */
> -	if (fsi->byte_offset >=
> -	    fsi->period_len * (fsi->periods + 1)) {
> +	if (fsi->buff_ofs >=
> +	    fsi_num2ofs(fsi->period_num + 1, fsi->period_width)) {
>  
>  		over_period = 1;
> -		fsi->periods = (fsi->periods + 1) % runtime->periods;
> +		fsi->period_num = (fsi->period_num + 1) % runtime->periods;
>  
> -		if (0 == fsi->periods)
> -			fsi->byte_offset = 0;
> +		if (0 == fsi->period_num)
> +			fsi->buff_ofs = 0;
>  	}
>  
>  	/* get 1 channel data width */
> -	width = frames_to_bytes(runtime, 1) / fsi->chan;
> +	ch_width = frames_to_bytes(runtime, 1) / fsi->chan_num;
>  
> -	/* get send size for alsa */
> -	send = (fsi->buffer_len - fsi->byte_offset) / width;
> +	/* number of push data */
> +	push_num = fsi_len2num(fsi->buff_len - fsi->buff_ofs, ch_width);
>  
> -	/*  get FIFO free size */
> -	fifo_free = (fsi->fifo_max * fsi->chan) - fsi_get_fifo_residue(fsi, 1);
> +	/* max number of push data */
> +	push_num_max = (fsi->fifo_max_num * fsi->chan_num) -
> +			fsi_get_fifo_data_num(fsi, 1);
>  
> -	/* size check */
> -	if (fifo_free < send)
> -		send = fifo_free;
> +	push_num = min(push_num, push_num_max);
>  
> -	switch (width) {
> +	switch (ch_width) {
>  	case 2:
> -		fsi_dma_soft_push16(fsi, send);
> +		fsi_dma_soft_push16(fsi, push_num);
>  		break;
>  	case 4:
> -		fsi_dma_soft_push32(fsi, send);
> +		fsi_dma_soft_push32(fsi, push_num);
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	fsi->byte_offset += send * width;
> +	fsi->buff_ofs += fsi_num2ofs(push_num, ch_width);
>  
>  	status = fsi_reg_read(fsi, DOFF_ST);
>  	if (!startup) {
> @@ -642,9 +662,9 @@ static int fsi_data_pop(struct fsi_priv *fsi, int startup)
>  	struct snd_pcm_runtime *runtime;
>  	struct snd_pcm_substream *substream = NULL;
>  	u32 status;
> -	int free;
> -	int fifo_fill;
> -	int width;
> +	int pop_num;
> +	int pop_num_max;
> +	int ch_width;
>  	int over_period;
>  
>  	if (!fsi			||
> @@ -659,40 +679,39 @@ static int fsi_data_pop(struct fsi_priv *fsi, int startup)
>  	/* FSI FIFO has limit.
>  	 * So, this driver can not send periods data at a time
>  	 */
> -	if (fsi->byte_offset >=
> -	    fsi->period_len * (fsi->periods + 1)) {
> +	if (fsi->buff_ofs >=
> +	    fsi_num2ofs(fsi->period_num + 1, fsi->period_width)) {
>  
>  		over_period = 1;
> -		fsi->periods = (fsi->periods + 1) % runtime->periods;
> +		fsi->period_num = (fsi->period_num + 1) % runtime->periods;
>  
> -		if (0 == fsi->periods)
> -			fsi->byte_offset = 0;
> +		if (0 == fsi->period_num)
> +			fsi->buff_ofs = 0;
>  	}
>  
>  	/* get 1 channel data width */
> -	width = frames_to_bytes(runtime, 1) / fsi->chan;
> +	ch_width = frames_to_bytes(runtime, 1) / fsi->chan_num;
>  
>  	/* get free space for alsa */
> -	free = (fsi->buffer_len - fsi->byte_offset) / width;
> +	pop_num_max = fsi_len2num(fsi->buff_len - fsi->buff_ofs, ch_width);
>  
>  	/* get recv size */
> -	fifo_fill = fsi_get_fifo_residue(fsi, 0);
> +	pop_num = fsi_get_fifo_data_num(fsi, 0);
>  
> -	if (free < fifo_fill)
> -		fifo_fill = free;
> +	pop_num = min(pop_num_max, pop_num);
>  
> -	switch (width) {
> +	switch (ch_width) {
>  	case 2:
> -		fsi_dma_soft_pop16(fsi, fifo_fill);
> +		fsi_dma_soft_pop16(fsi, pop_num);
>  		break;
>  	case 4:
> -		fsi_dma_soft_pop32(fsi, fifo_fill);
> +		fsi_dma_soft_pop32(fsi, pop_num);
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	fsi->byte_offset += fifo_fill * width;
> +	fsi->buff_ofs += fsi_num2ofs(pop_num, ch_width);
>  
>  	status = fsi_reg_read(fsi, DIFF_ST);
>  	if (!startup) {
> @@ -786,29 +805,29 @@ static int fsi_dai_startup(struct snd_pcm_substream *substream,
>  	switch (fmt) {
>  	case SH_FSI_FMT_MONO:
>  		data = CR_MONO;
> -		fsi->chan = 1;
> +		fsi->chan_num = 1;
>  		break;
>  	case SH_FSI_FMT_MONO_DELAY:
>  		data = CR_MONO_D;
> -		fsi->chan = 1;
> +		fsi->chan_num = 1;
>  		break;
>  	case SH_FSI_FMT_PCM:
>  		data = CR_PCM;
> -		fsi->chan = 2;
> +		fsi->chan_num = 2;
>  		break;
>  	case SH_FSI_FMT_I2S:
>  		data = CR_I2S;
> -		fsi->chan = 2;
> +		fsi->chan_num = 2;
>  		break;
>  	case SH_FSI_FMT_TDM:
> -		fsi->chan = is_play ?
> +		fsi->chan_num = is_play ?
>  			SH_FSI_GET_CH_O(flags) : SH_FSI_GET_CH_I(flags);
> -		data = CR_TDM | (fsi->chan - 1);
> +		data = CR_TDM | (fsi->chan_num - 1);
>  		break;
>  	case SH_FSI_FMT_TDM_DELAY:
> -		fsi->chan = is_play ?
> +		fsi->chan_num = is_play ?
>  			SH_FSI_GET_CH_O(flags) : SH_FSI_GET_CH_I(flags);
> -		data = CR_TDM_D | (fsi->chan - 1);
> +		data = CR_TDM_D | (fsi->chan_num - 1);
>  		break;
>  	case SH_FSI_FMT_SPDIF:
>  		if (master->core->ver < 2) {
> @@ -816,7 +835,7 @@ static int fsi_dai_startup(struct snd_pcm_substream *substream,
>  			return -EINVAL;
>  		}
>  		data = CR_SPDIF;
> -		fsi->chan = 2;
> +		fsi->chan_num = 2;
>  		fsi_spdif_clk_ctrl(fsi, 1);
>  		fsi_reg_mask_set(fsi, OUT_SEL, 0x0010, 0x0010);
>  		break;
> @@ -1018,7 +1037,7 @@ static snd_pcm_uframes_t fsi_pointer(struct snd_pcm_substream *substream)
>  	struct fsi_priv *fsi = fsi_get_priv(substream);
>  	long location;
>  
> -	location = (fsi->byte_offset - 1);
> +	location = (fsi->buff_ofs - 1);
>  	if (location < 0)
>  		location = 0;
>  

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
