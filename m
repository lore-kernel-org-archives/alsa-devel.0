From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/4] ASoC: fsi: Add FIFO size calculate
Date: Wed, 24 Mar 2010 09:46:58 +0000
Message-ID: <1269424018.3798.29.camel@odin>
References: <u1vfa44ls.wl%morimoto.kuninori@renesas.com>
	<uy6hi2q0f.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id F3BFC1037F1
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 10:47:02 +0100 (CET)
Received: by bwz20 with SMTP id 20so8424958bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 02:47:02 -0700 (PDT)
In-Reply-To: <uy6hi2q0f.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-03-17 at 14:26 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  sound/soc/sh/fsi.c |   48 +++++++++++++++++++++++-------------------------
>  1 files changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index db91349..cc41bae 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -46,8 +46,9 @@
>  #define MUTE		0x020C
>  #define CLK_RST		0x0210
>  #define SOFT_RST	0x0214
> +#define FIFO_SZ		0x0218
>  #define MREG_START	INT_ST
> -#define MREG_END	SOFT_RST
> +#define MREG_END	FIFO_SZ
>  
>  /* DO_FMT */
>  /* DI_FMT */
> @@ -85,6 +86,11 @@
>  #define IR		(1 <<  4) /* Interrupt Reset */
>  #define FSISR		(1 <<  0) /* Software Reset */
>  
> +/* FIFO_SZ */
> +#define OUT_SZ_MASK	0x7
> +#define BO_SZ_SHIFT	8
> +#define AO_SZ_SHIFT	0
> +
>  #define FSI_RATES SNDRV_PCM_RATE_8000_96000
>  
>  #define FSI_FMTS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
> @@ -590,11 +596,12 @@ static int fsi_dai_startup(struct snd_pcm_substream *substream,
>  			   struct snd_soc_dai *dai)
>  {
>  	struct fsi_priv *fsi = fsi_get_priv(substream);
> +	struct fsi_master *master = fsi_get_master(fsi);
>  	const char *msg;
>  	u32 flags = fsi_get_info_flags(fsi);
>  	u32 fmt;
>  	u32 reg;
> -	u32 data;
> +	u32 data, i;
>  	int is_play = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
>  	int is_master;
>  	int ret = 0;
> @@ -668,31 +675,22 @@ static int fsi_dai_startup(struct snd_pcm_substream *substream,
>  		dev_err(dai->dev, "unknown format.\n");
>  		return -EINVAL;
>  	}
> -
> -	switch (fsi->chan) {
> -	case 1:
> -		fsi->fifo_max = 256;
> -		break;
> -	case 2:
> -		fsi->fifo_max = 128;
> -		break;
> -	case 3:
> -	case 4:
> -		fsi->fifo_max = 64;
> -		break;
> -	case 5:
> -	case 6:
> -	case 7:
> -	case 8:
> -		fsi->fifo_max = 32;
> -		break;
> -	default:
> -		dev_err(dai->dev, "channel size error.\n");
> -		return -EINVAL;
> -	}
> -
>  	fsi_reg_write(fsi, reg, data);
>  
> +	/* calculate FIFO size */
> +	data = fsi_master_read(master, FIFO_SZ);
> +	data >>= fsi_is_port_a(fsi) ? AO_SZ_SHIFT : BO_SZ_SHIFT;
> +	data &= OUT_SZ_MASK;
> +	fsi->fifo_max = 256;
> +	for (i = 0; i < data; i++)
> +		fsi->fifo_max <<= 1;

You don't really need the for loop here if you calculate the shift size
and perform the shift in 1 operation. e.g.

fsi->fifo_max <<= data;

> +	dev_dbg(dai->dev, "fifo = %d words\n", fsi->fifo_max);
> +
> +	for (i = 1; i < fsi->chan; i *= 2)
> +		if (fsi->chan > i)
> +			fsi->fifo_max >>= 1;

Is the if really needed here. You may also want to calculate the shift
size rather than looping too.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
