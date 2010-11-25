From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 6/8] ASoC: simone: fix resource leak in
	simone_init	error path
Date: Thu, 25 Nov 2010 10:06:04 +0200
Message-ID: <20101125080604.GL14080@gw.healthdatacare.com>
References: <1290668785.30158.7.camel@mola> <1290669150.30158.18.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 36D3B103BA5
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 09:06:09 +0100 (CET)
Received: by fxm10 with SMTP id 10so523426fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 00:06:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290669150.30158.18.camel@mola>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 25, 2010 at 03:12:30PM +0800, Axel Lin wrote:
> Fix the error path to properly free allocated resources.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>

Thanks for catching this.

> ---
>  sound/soc/ep93xx/simone.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/simone.c b/sound/soc/ep93xx/simone.c
> index 4b0d199..2868179 100644
> --- a/sound/soc/ep93xx/simone.c
> +++ b/sound/soc/ep93xx/simone.c
> @@ -54,24 +54,26 @@ static int __init simone_init(void)
>  
>  	ret = platform_device_add(simone_snd_ac97_device);
>  	if (ret)
> -		goto fail;
> +		goto fail1;
>  
>  	simone_snd_device = platform_device_alloc("soc-audio", -1);
>  	if (!simone_snd_device) {
>  		ret = -ENOMEM;
> -		goto fail;
> +		goto fail2;
>  	}
>  
>  	platform_set_drvdata(simone_snd_device, &snd_soc_simone);
>  	ret = platform_device_add(simone_snd_device);
> -	if (ret) {
> -		platform_device_put(simone_snd_device);
> -		goto fail;
> -	}
> +	if (ret)
> +		goto fail3;
>  
> -	return ret;
> +	return 0;
>  
> -fail:
> +fail3:
> +	platform_device_put(simone_snd_device);
> +fail2:
> +	platform_device_del(simone_snd_ac97_device);
> +fail1:
>  	platform_device_put(simone_snd_ac97_device);
>  	return ret;
>  }
> -- 
> 1.7.2
> 
> 
