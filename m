From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Update Freescale i.MX SSI driver
Date: Mon, 24 May 2010 20:32:51 +0100
Message-ID: <20100524193250.GA29620@sirena.org.uk>
References: <20100522120124.GD18017@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B8191037FB
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 21:32:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100522120124.GD18017@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 22, 2010 at 10:01:25PM +1000, Stuart Longland wrote:

> 	Attached is a patch that corrects the i.MX SSI driver so that it
> compiles against the latest ASoC tree.  I'm able to compile the driver
> with this patch, but haven't done any testing beyond this point... the
> update is quite na?ve, based on changes I had seen to other drivers.
> 
> 	I hope to give it a try on Monday, but in the meantime, here's
> the patch for others to try.

Applied, thanks, but please read and follow the instructions for
submitting patches in Documentation/SubmittingPatches - in particular,
please CC maintainers on patches and don't send patches as attachments
to messages especially with non-changelog stuff in the body of the
message.  This ensures your patch doesn't get buried in the mailing list
and makes it much easier to apply changes with tools such as git am.

> -- 
> Stuart Longland (aka Redhatter, VK4MSL)      .'''.
> Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
> . . . . . . . . . . . . . . . . . . . . . .   .'.'
> http://dev.gentoo.org/~redhatter             :.'
> 
> I haven't lost my mind...
>   ...it's backed up on a tape somewhere.

> From 138287fab450440726d6497d2d9ffd3645a0469b Mon Sep 17 00:00:00 2001
> From: Stuart Longland <redhatter@gentoo.org>
> Date: Sat, 22 May 2010 21:10:02 +1000
> Subject: [PATCH] ASoC: Update Freescale i.MX SSI driver DMA parameter handling
> 
> This updates the i.MX SSI driver to make it compatible with the ASoC tree
> following the move of DMA parameters from the DAI to the audio substream
> object.
> 
> Signed-off-by: Stuart Longland <redhatter@gentoo.org>
> ---
>  sound/soc/imx/imx-pcm-dma-mx2.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
> index 2b31ac6..05f19c9 100644
> --- a/sound/soc/imx/imx-pcm-dma-mx2.c
> +++ b/sound/soc/imx/imx-pcm-dma-mx2.c
> @@ -73,7 +73,8 @@ static void snd_imx_dma_err_callback(int channel, void *data, int err)
>  {
>  	struct snd_pcm_substream *substream = data;
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct imx_pcm_dma_params *dma_params = rtd->dai->cpu_dai->dma_data;
> +	struct imx_pcm_dma_params *dma_params = 
> +		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
>  	int ret;
> @@ -102,7 +103,7 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
>  	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
>  	int ret;
>  
> -	dma_params = snd_soc_get_dma_data(rtd->dai->cpu_dai, substream);
> +	dma_params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
>  
>  	iprtd->dma = imx_dma_request_by_prio(DRV_NAME, DMA_PRIO_HIGH);
>  	if (iprtd->dma < 0) {
> @@ -212,7 +213,7 @@ static int snd_imx_pcm_prepare(struct snd_pcm_substream *substream)
>  	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
>  	int err;
>  
> -	dma_params = snd_soc_get_dma_data(rtd->dai->cpu_dai, substream);
> +	dma_params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
>  
>  	iprtd->substream = substream;
>  	iprtd->buf = (unsigned int *)substream->dma_buffer.area;
> -- 
> 1.6.4
> 

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
