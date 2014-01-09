From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] ASoC: ad1836: Use params_width()
 rather than explicit memory format
Date: Thu, 09 Jan 2014 11:27:27 +0100
Message-ID: <52CE798F.3040201@metafoo.de>
References: <1389207089-23741-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F66265281
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 11:26:59 +0100 (CET)
In-Reply-To: <1389207089-23741-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 01/08/2014 07:51 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>

It would have been nice to have a least a small explanation why this is a
better approach. It might not be immediately obvious to somebody reading the
log later on.

> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

All five patches in this series

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  sound/soc/codecs/ad1836.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
> index d7c983862cf0..77f459868579 100644
> --- a/sound/soc/codecs/ad1836.c
> +++ b/sound/soc/codecs/ad1836.c
> @@ -168,15 +168,15 @@ static int ad1836_hw_params(struct snd_pcm_substream *substream,
>  	int word_len = 0;
>  
>  	/* bit size */
> -	switch (params_format(params)) {
> -	case SNDRV_PCM_FORMAT_S16_LE:
> +	switch (params_width(params)) {
> +	case 16:
>  		word_len = AD1836_WORD_LEN_16;
>  		break;
> -	case SNDRV_PCM_FORMAT_S20_3LE:
> +	case 20:
>  		word_len = AD1836_WORD_LEN_20;
>  		break;
> -	case SNDRV_PCM_FORMAT_S24_LE:
> -	case SNDRV_PCM_FORMAT_S32_LE:
> +	case 24:
> +	case 32:
>  		word_len = AD1836_WORD_LEN_24;
>  		break;
>  	default:
> 
