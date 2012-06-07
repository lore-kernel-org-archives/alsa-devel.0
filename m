From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASOC: utils: Fix the dummy_codec
Date: Thu, 07 Jun 2012 14:05:58 +0530
Message-ID: <1339058158.1927.15.camel@vkoul-udesk3>
References: <1338969742-14455-1-git-send-email-selma.bensaid@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id E44EC2454F
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 10:42:50 +0200 (CEST)
In-Reply-To: <1338969742-14455-1-git-send-email-selma.bensaid@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Selma Bensaid <selma.bensaid@intel.com>
Cc: sylvain.centelles@intel.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, louis.le.gall@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-06-06 at 10:02 +0200, Selma Bensaid wrote:
> This patch consists in settings the channels_min, rates and formats
> of the dummy codec DAI driver to enable the creation of the PCM streams
> using it.
patch title is not clear what you are fixing in dummy_codec, pls
consider appropriate title.

> 
> Signed-off-by: Selma Bensaid <selma.bensaid@intel.com>
> ---
>  sound/soc/soc-utils.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
> index 6005370..465a094 100644
> --- a/sound/soc/soc-utils.c
> +++ b/sound/soc/soc-utils.c
> @@ -89,9 +89,27 @@ static struct snd_soc_platform_driver dummy_platform = {
>  	.ops = &dummy_dma_ops,
>  };
>  
> +#define NULL_FORMATS \
> +	(SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |\
> +	SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |\
> +	SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32)
Would it make sense to have a CONTINUOUS format macro instead?
As people start using these, I can see this becoming big and ugly.

But are the other formats defined in pcm.h widely used?

> +
>  static struct snd_soc_codec_driver dummy_codec;
>  static struct snd_soc_dai_driver dummy_dai = {
>  	.name = "snd-soc-dummy-dai",
> +	.playback = {
> +		.channels_min = 1,
> +		.channels_max = 16,
> +		.rates = SNDRV_PCM_RATE_CONTINUOUS,
> +		.formats = NULL_FORMATS,
> +	},
> +	.capture = {
> +		.channels_min = 1,
> +		.channels_max = 16,
> +		.rates = SNDRV_PCM_RATE_CONTINUOUS,
> +		.formats = NULL_FORMATS,
> +	},
> +	.ops = NULL,
>  };
>  
>  static __devinit int snd_soc_dummy_probe(struct platform_device *pdev)


-- 
~Vinod
