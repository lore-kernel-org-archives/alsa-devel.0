From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: using params_width function
 to simplify code
Date: Tue, 24 Nov 2015 00:52:29 -0800
Message-ID: <20151124085229.GC14109@Asurada-CZ80>
References: <c305d87967734ad68067cca39c9e61c35dacf3b7.1448350220.git.zidan.wang@freescale.com>
 <61c4bd3dd82c40b59d1d2570a400321027ae6abc.1448350220.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 038492614A7
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 09:52:34 +0100 (CET)
Received: by iofh3 with SMTP id h3so13280835iof.3
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 00:52:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <61c4bd3dd82c40b59d1d2570a400321027ae6abc.1448350220.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 03:32:09PM +0800, Zidan Wang wrote:
> using params_width function to simplify code.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_asrc.c | 2 +-
>  sound/soc/fsl/fsl_esai.c | 2 +-
>  sound/soc/fsl/fsl_sai.c  | 2 +-
>  sound/soc/fsl/fsl_ssi.c  | 3 +--
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 9f087d4..6d06366 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -447,7 +447,7 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
>  				  struct snd_soc_dai *dai)
>  {
>  	struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
> -	int width = snd_pcm_format_width(params_format(params));
> +	int width = params_width(params);
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct fsl_asrc_pair *pair = runtime->private_data;
>  	unsigned int channels = params_channels(params);
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 504e731..45d4319 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -510,7 +510,7 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  {
>  	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> -	u32 width = snd_pcm_format_width(params_format(params));
> +	u32 width = params_width(params);
>  	u32 channels = params_channels(params);
>  	u32 pins = DIV_ROUND_UP(channels, esai_priv->slots);
>  	u32 slot_width = width;
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index c01322c..8832901 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -404,7 +404,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	unsigned int channels = params_channels(params);
> -	u32 word_width = snd_pcm_format_width(params_format(params));
> +	u32 word_width = params_width(params);
>  	u32 val_cr4 = 0, val_cr5 = 0;
>  	u32 slots = (channels == 1) ? 2 : channels;
>  	u32 slot_width = word_width;
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 674abf7..e3abad5 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -767,8 +767,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>  	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
>  	struct regmap *regs = ssi_private->regs;
>  	unsigned int channels = params_channels(hw_params);
> -	unsigned int sample_size =
> -		snd_pcm_format_width(params_format(hw_params));
> +	unsigned int sample_size = params_width(hw_params);
>  	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
>  	int ret;
>  	u32 scr_val;
> -- 
> 1.9.1
> 
