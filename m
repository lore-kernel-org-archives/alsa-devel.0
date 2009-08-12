From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 16/20] ASoC: OMAP: Use DMA operating mode
	of McBSP
Date: Wed, 12 Aug 2009 15:38:38 +0300
Message-ID: <20090812153838.d71f3c88.jhnikula__48670.526900287$1250080661$gmane$org@gmail.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-6-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-7-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-8-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-10-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-11-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-12-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-13-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-14-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-15-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-16-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-17-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249995931-26015-17-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Aug 2009 16:05:27 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    8 ++++++--
>  sound/soc/omap/omap-pcm.c   |   13 +++++++++++--
>  sound/soc/omap/omap-pcm.h   |    1 +
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
...
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 0c1ba0f..d8f52e8 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -144,7 +144,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  
>  	memset(&dma_params, 0, sizeof(dma_params));
>  
> -	if (cpu_is_omap34xx())
> +	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
> +	if (cpu_is_omap34xx() &&
> +			(dma_data->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD))
>  		sync_mode = OMAP_DMA_SYNC_FRAME;
>  	else
>  		sync_mode = OMAP_DMA_SYNC_ELEMENT;

Note, you could avoid the compile error if you move this into
omap-mcbsp.c and pass only sync_mode here. Probably as easy as
dma_data->sync_mode since OMAP_DMA_SYNC_ELEMENT is zero.

The McBSP DAI must and can know the DMA parameters (like sync_mode) but
otherwise (like MCBSP_DMA_MODE_xxx) it sounds unnecessary glue between
the drivers.

> @@ -193,9 +195,16 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
>  	unsigned long flags;
>  	int ret = 0;
> -	int samples = snd_pcm_lib_period_bytes(substream) >> 1;
> +	int samples;
>  
>  	spin_lock_irqsave(&prtd->lock, flags);
> +
> +	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
> +	if (dma_data->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
> +		samples = snd_pcm_lib_period_bytes(substream) >> 1;
> +	else
> +		samples = 1;
> +

Can these lines in this patch and in patch 15 to be moved into
omap_mcbsp_trigger? For me it looks it would simplify and remove the
glue between the drivers.


-- 
Jarkko
