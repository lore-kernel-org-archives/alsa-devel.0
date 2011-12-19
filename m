From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 2/2] ASoC: Use dai_fmt in snappercl15
	machine driver
Date: Mon, 19 Dec 2011 11:11:23 +0200
Message-ID: <20111219091123.GA5397@mwesterb-mobl.ger.corp.intel.com>
References: <1324107412.27184.1.camel@phoenix>
	<1324107671.27184.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4033C24575
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 10:11:37 +0100 (CET)
Received: by lago2 with SMTP id o2so2103227lag.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 01:11:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1324107671.27184.4.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 17, 2011 at 03:41:11PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>

> ---
>  sound/soc/ep93xx/snappercl15.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
> index 33901d6..e97cd57 100644
> --- a/sound/soc/ep93xx/snappercl15.c
> +++ b/sound/soc/ep93xx/snappercl15.c
> @@ -33,16 +33,6 @@ static int snappercl15_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	int err;
>  
> -	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> -				  SND_SOC_DAIFMT_NB_IF |
> -				  SND_SOC_DAIFMT_CBS_CFS);
> -
> -	err = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S | 
> -				  SND_SOC_DAIFMT_NB_IF |		  
> -				  SND_SOC_DAIFMT_CBS_CFS);
> -	if (err)
> -		return err;
> -
>  	err = snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, 
>  				     SND_SOC_CLOCK_IN);
>  	if (err)
> @@ -96,6 +86,8 @@ static struct snd_soc_dai_link snappercl15_dai = {
>  	.codec_name	= "tlv320aic23-codec.0-001a",
>  	.platform_name	=  "ep93xx-pcm-audio",
>  	.init		= snappercl15_tlv320aic23_init,
> +	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
> +			  SND_SOC_DAIFMT_CBS_CFS,
>  	.ops		= &snappercl15_ops,
>  };
>  
> -- 
> 1.7.5.4
> 
> 
