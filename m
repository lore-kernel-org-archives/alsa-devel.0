From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Use snd_pcm_format_width() in
 snd_soc_params_to_frame_size()
Date: Tue, 01 Feb 2011 14:30:35 +0000
Message-ID: <1296570635.3327.40.camel@odin>
References: <1296567050-32607-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BDB36103944
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:30:40 +0100 (CET)
Received: by wyi11 with SMTP id 11so6685076wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 06:30:40 -0800 (PST)
In-Reply-To: <1296567050-32607-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-01 at 13:30 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-utils.c |   23 +++--------------------
>  1 files changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
> index 1d07b93..3f45e6a 100644
> --- a/sound/soc/soc-utils.c
> +++ b/sound/soc/soc-utils.c
> @@ -28,26 +28,9 @@ int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params)
>  {
>  	int sample_size;
>  
> -	switch (params_format(params)) {
> -	case SNDRV_PCM_FORMAT_S16_LE:
> -	case SNDRV_PCM_FORMAT_S16_BE:
> -		sample_size = 16;
> -		break;
> -	case SNDRV_PCM_FORMAT_S20_3LE:
> -	case SNDRV_PCM_FORMAT_S20_3BE:
> -		sample_size = 20;
> -		break;
> -	case SNDRV_PCM_FORMAT_S24_LE:
> -	case SNDRV_PCM_FORMAT_S24_BE:
> -		sample_size = 24;
> -		break;
> -	case SNDRV_PCM_FORMAT_S32_LE:
> -	case SNDRV_PCM_FORMAT_S32_BE:
> -		sample_size = 32;
> -		break;
> -	default:
> -		return -ENOTSUPP;
> -	}
> +	sample_size = snd_pcm_format_width(params_format(params));
> +	if (sample_size < 0)
> +		return sample_size;
>  
>  	return snd_soc_calc_frame_size(sample_size, params_channels(params),
>  				       1);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
