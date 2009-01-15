From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR
	compilation error.
Date: Thu, 15 Jan 2009 13:23:09 -0800
Message-ID: <200901151323.09869.david-b@pacbell.net>
References: <20090108121613.1ef53112.hugo@hugovil.com>
	<1232052035-31846-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by alsa0.perex.cz (Postfix) with SMTP id BAC641038A5
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 22:23:12 +0100 (CET)
In-Reply-To: <1232052035-31846-1-git-send-email-hugo@hugovil.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 15 January 2009, Hugo Villeneuve wrote:
> Remove dependency on sffsdr_fpga_set_codec_fs() when the
> SFFSDR FPGA module is not selected.
> 
> Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
> ---

Something looks broken in the config you're building with.
As in, very deeply broken.  You should fix the config instead
of hacking around those bugs with ifdefs.


>  sound/soc/davinci/davinci-sffsdr.c |   20 +++++++++++++++++---
>  1 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
> index 3e8e6cd..e3ea07a 100644
> --- a/sound/soc/davinci/davinci-sffsdr.c
> +++ b/sound/soc/davinci/davinci-sffsdr.c
> @@ -25,7 +25,9 @@
>  #include <asm/gpio.h>
>  #include <asm/dma.h>
>  #include <asm/mach-types.h>
> +#ifdef CONFIG_SFFSDR_FPGA
>  #include <asm/plat-sffsdr/sffsdr-fpga.h>
> +#endif
>  
>  #include <mach/asp.h>
>  #include <mach/edma.h>
> @@ -42,6 +44,17 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
>  	int fs;
>  	int ret = 0;
>  
> +	/* Fsref can be 32000, 44100 or 48000. */
> +	fs = params_rate(params);
> +
> +#ifndef CONFIG_SFFSDR_FPGA
> +	/* Without the FPGA module, the Fs is fixed at 44100 Hz */
> +	if (fs != 44100) {
> +		pr_debug("warning: only 44.1 kHz is supported without SFFSDR FPGA module\n");
> +		return -EINVAL;
> +	}
> +#endif
> +
>  	/* Set cpu DAI configuration:
>  	 * CLKX and CLKR are the inputs for the Sample Rate Generator.
>  	 * FSX and FSR are outputs, driven by the sample Rate Generator. */
> @@ -52,12 +65,13 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Fsref can be 32000, 44100 or 48000. */
> -	fs = params_rate(params);
> -
>  	pr_debug("sffsdr_hw_params: rate = %d Hz\n", fs);
>  
> +#ifndef CONFIG_SFFSDR_FPGA
> +	return 0;
> +#else
>  	return sffsdr_fpga_set_codec_fs(fs);
> +#endif
>  }
>  
>  static struct snd_soc_ops sffsdr_ops = {
> -- 
> 1.5.4.5
> 
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
> 
