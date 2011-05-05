From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 02/19] ASoC: sst_platform: add cpu dai
 driver for moorestown platform
Date: Thu, 05 May 2011 08:53:01 +0530
Message-ID: <1304565781.20953.41.camel@vkoul-udesk3>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134504.32443.60814.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id D5B4A243E0
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 05:55:15 +0200 (CEST)
In-Reply-To: <20110504134504.32443.60814.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lu, Guanqun" <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-05-04 at 19:15 +0530, Lu, Guanqun wrote:
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> ---
>  sound/soc/mid-x86/sst_platform.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
> index 139db15..ce0ac3c 100644
> --- a/sound/soc/mid-x86/sst_platform.c
> +++ b/sound/soc/mid-x86/sst_platform.c
> @@ -110,6 +110,20 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
>  		.formats = SNDRV_PCM_FMTBIT_S24_LE,
>  	},
>  },
> +{
> +	.name = "mrst-cpu-pcm2",
> +	.id = 4,
> +	.playback = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		.rates = (SNDRV_PCM_RATE_48000 |
> +			  SNDRV_PCM_RATE_44100 |
> +			  SNDRV_PCM_RATE_8000),
> +		.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
> +			    SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
> +			    SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
> +	},
> +},
Nope, We cant keep on adding these DAIs for every new platform :(
Even the current way is not best as it just creates 4 instance of DAI
where we could have done with two (as they have same properties)
I would use the current headset DAI and change the ops there, or create
a new one for each type so that it can be reused.

-- 
~Vinod
