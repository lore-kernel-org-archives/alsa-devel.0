From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] ASoC: Blackfin: add multi-channel
	function support
Date: Thu, 23 Oct 2008 11:55:27 +0100
Message-ID: <20081023105526.GE10280@sirena.org.uk>
References: <1224752520-25668-1-git-send-email-cooloney@kernel.org>
	<1224752520-25668-4-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E00C10385E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 12:55:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1224752520-25668-4-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 05:01:59PM +0800, Bryan Wu wrote:

> This patch provides a option for users to enable multi-channel function support
> in Blackfin ASoC driver. Because Blackfin is without MMU, it is easy for us and
> the user to enable this function at compiling stage not dynamically on the fly.

> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

A few comments below, though.

As a general comment it'd be really helpful if you could split your
changes into more patches than you tend to do - ideally, each patch
should have a single logical change in it which is fully described by
the commit message.  Sometimes it's not worth splitting stuff out if the
changes overlap but it does make review easier if you can.

For example, you've already split out the codec driver change but still
well as the advertised change this patch also renames the mmap() support
define and some coding style cleanups.

> @@ -90,7 +98,7 @@ config SND_BF5XX_HAVE_COLD_RESET
>  	depends on SND_BF5XX_AC97
>  	default y if BFIN548_EZKIT
>  	default n if !BFIN548_EZKIT
> -	
> +

Random whitespace changes.

> -		bf5xx_pcm_to_ac97(
> -			(struct ac97_frame *)sport->tx_dma_buf + sport->tx_pos,
> -			(__u32 *)runtime->dma_area + sport->tx_pos, count);
> +		bf5xx_pcm_to_ac97((struct ac97_frame *)sport->tx_dma_buf +
> +		sport->tx_pos, (__u16 *)runtime->dma_area + sport->tx_pos *
> +		runtime->channels, count, chan_mask);

I'm not sure that the reindentation here is helpful but then the line is
so long that it's hard to do anything.  When revisiting this I'd suggest
using temporary variables to calculate the pointers passed in - that
should help a lot and I'd not expect worse code from the compiler since
the value has to be calculated and stored for passing to the function
anyway.

> +#if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)

Normally just ifdef.
