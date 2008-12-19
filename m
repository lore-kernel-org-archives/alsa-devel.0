From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Patch to /sound/soc/pxa/pxa2xx_pcm.c,
	WHO IS INTERESTED?
Date: Fri, 19 Dec 2008 11:57:38 +0000
Message-ID: <20081219115737.GI24129@sirena.org.uk>
References: <494A97CD.7070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 48CA4243B9
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 12:57:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <494A97CD.7070909@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sware <microcontrolfreak@gmail.com>
Cc: ALSA project mailing list <alsa-devel@alsa-project.org>, nicolas pitre <nico@cam.org>, liam girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 18, 2008 at 10:34:53AM -0800, sware wrote:

> Patch is to 2.6.27.9 (yesterday), notice .10 is up today, 
> patch should still apply.

Thanks for your patch.  Unfortunately all this code has been moved about
a lot in the latest code in order to share the code with the non-ASoC
AC97 driver so your patch won't apply - see the topic/asoc branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

for the latest code.  Could you rebase your work against that, please?
Also, please include a Signed-off-by line for patch submissions - for
details see Documentation/SubmittingPatches

> diff -uprN -X linux-2.6.27.9.orig/Documentation/dontdiff linux-2.6.27.9.orig/sound/soc/pxa/pxa2xx-pcm.c linux-2.6.27.9.snd_modified/sound/soc/pxa/pxa2xx-pcm.c
> --- linux-2.6.27.9.orig/sound/soc/pxa/pxa2xx-pcm.c	2008-12-13 15:56:16.000000000 -0800
> +++ linux-2.6.27.9.snd_modified/sound/soc/pxa/pxa2xx-pcm.c	2008-12-17 14:09:02.000000000 -0800
> @@ -137,13 +137,18 @@ static int pxa2xx_pcm_hw_free(struct snd
>  {
>  	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
>  
> -	if (prtd && prtd->params)
> +	if (!prtd)
> +			return 0;
> +	if (!prtd->params)
> +			return 0;
> +

prtd should always be there - the code should at least complain loudly
if it's NULL.  params might potentially be hit, though.

>  		*prtd->params->drcmr = 0;
>  
> -	if (prtd->dma_ch) {
> +	if (prtd->dma_ch >= 0) {
>  		snd_pcm_set_runtime_buffer(substream, NULL);
>  		pxa_free_dma(prtd->dma_ch);
> -		prtd->dma_ch = 0;
> +		prtd->dma_ch = -1;	/* invalid channel */
> +        prtd->params = NULL;
>  	}

This bit is good.

> @@ -266,6 +271,8 @@ static int pxa2xx_pcm_close(struct snd_p
>  	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
>  			      prtd->dma_desc_array, prtd->dma_desc_array_phys);
>  	kfree(prtd);
> +	runtime->private_data = NULL;
> +
>  	return 0;
>  }

As is this.
