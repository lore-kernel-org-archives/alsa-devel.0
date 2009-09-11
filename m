From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 2/2] ASoC: Davinci: Fix race with
	cpu_dai->dma_data
Date: Fri, 11 Sep 2009 15:52:20 -0700
Message-ID: <4AAAD4A4.6050608@boundarydevices.com>
References: <1252704543-25580-1-git-send-email-troy.kisky@boundarydevices.com>
	<1252704543-25580-2-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FAC224412
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 00:52:33 +0200 (CEST)
In-Reply-To: <1252704543-25580-2-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Troy Kisky wrote:
> This patch removes references to cpu_dai->dma_data.
> It makes struct davinci_pcm_dma_params part of
> struct davinci_mcbsp_dev or struct davinci_audio_dev.
> 
> It removes the unused name variable from davinci_pcm_dma_params.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  sound/soc/davinci/davinci-i2s.c   |   36 +++++++++---------------------
>  sound/soc/davinci/davinci-mcasp.c |   44 ++++++++----------------------------
>  sound/soc/davinci/davinci-mcasp.h |    7 +++++-
>  sound/soc/davinci/davinci-pcm.c   |    3 +-
>  sound/soc/davinci/davinci-pcm.h   |    1 -
>  5 files changed, 29 insertions(+), 62 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
> index 002808b..359e99e 100644
> --- a/sound/soc/davinci/davinci-pcm.c
> +++ b/sound/soc/davinci/davinci-pcm.c
> @@ -238,7 +238,8 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
>  	struct davinci_runtime_data *prtd;
>  	int ret = 0;
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct davinci_pcm_dma_params *params = rtd->dai->cpu_dai->dma_data;
> +	struct davinci_pcm_dma_params *pa = rtd->dai->cpu_dai->private_data;
> +	struct davinci_pcm_dma_params *params = &pa[substream->stream];
>  	if (!params)
>  		return -ENODEV;
>  
params can no longer be null, so the above 2 line can be deleted as well
