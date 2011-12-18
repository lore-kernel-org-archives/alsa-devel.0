From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH 1/2] ASoC: Use dai_fmt in edb93xx machine
	driver
Date: Sun, 18 Dec 2011 09:45:42 +0100
Message-ID: <1324197943.4625.0.camel@r60e>
References: <1324107412.27184.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward2.mail.yandex.net (forward2.mail.yandex.net [77.88.46.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D53F24593
	for <alsa-devel@alsa-project.org>; Sun, 18 Dec 2011 09:45:58 +0100 (CET)
In-Reply-To: <1324107412.27184.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mika Westerberg <mika.westerberg@iki.fi>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello!

Acked-by: Alexander Sverdlin <subaparts@yandex.ru>

On Sat, 2011-12-17 at 15:36 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/ep93xx/edb93xx.c |   14 ++------------
>  1 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/edb93xx.c b/sound/soc/ep93xx/edb93xx.c
> index 6b90c75..9f6fecd 100644
> --- a/sound/soc/ep93xx/edb93xx.c
> +++ b/sound/soc/ep93xx/edb93xx.c
> @@ -48,18 +48,6 @@ static int edb93xx_hw_params(struct snd_pcm_substream *substream,
>  	else
>  		mclk_rate = rate * 64 * 2;
>  
> -	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> -				  SND_SOC_DAIFMT_NB_IF |
> -				  SND_SOC_DAIFMT_CBS_CFS);
> -	if (err)
> -		return err;
> -
> -	err = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> -				  SND_SOC_DAIFMT_NB_IF |
> -				  SND_SOC_DAIFMT_CBS_CFS);
> -	if (err)
> -		return err;
> -
>  	err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk_rate,
>  				     SND_SOC_CLOCK_IN);
>  	if (err)
> @@ -80,6 +68,8 @@ static struct snd_soc_dai_link edb93xx_dai = {
>  	.cpu_dai_name	= "ep93xx-i2s",
>  	.codec_name	= "spi0.0",
>  	.codec_dai_name	= "cs4271-hifi",
> +	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
> +			  SND_SOC_DAIFMT_CBS_CFS,
>  	.ops		= &edb93xx_ops,
>  };
>  
