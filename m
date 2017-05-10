From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ASoC: Intel: sst: fix spelling mistake:
 "allocationf" -> "allocation"
Date: Wed, 10 May 2017 18:06:26 +0800 (SGT)
Message-ID: <alpine.DEB.2.20.1705101805310.20213@hadrien>
References: <20170510081655.27123-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 534BD266834
 for <alsa-devel@alsa-project.org>; Wed, 10 May 2017 12:06:33 +0200 (CEST)
In-Reply-To: <20170510081655.27123-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On Wed, 10 May 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in dev_err message.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 21cac1c8dd4c..e74119113713 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -690,7 +690,7 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  			snd_dma_continuous_data(GFP_DMA),
>  			SST_MIN_BUFFER, SST_MAX_BUFFER);
>  		if (retval) {
> -			dev_err(rtd->dev, "dma buffer allocationf fail\n");
> +			dev_err(rtd->dev, "dma buffer allocation fail\n");

Maybe fail -> failure would be nice too?  If the message is useful at all.

julia

>  			return retval;
>  		}
>  	}
> --
> 2.11.0
>
>
