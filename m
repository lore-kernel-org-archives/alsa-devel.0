From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH][V2] ASoC: Intel: sst: fix spelling
 mistake: "allocationf" -> "allocation"
Date: Sun, 14 May 2017 18:49:03 +0530
Message-ID: <20170514131903.GO6263@localhost>
References: <20170510102940.18786-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id AD0C22668AC
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 15:16:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170510102940.18786-1-colin.king@canonical.com>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 10, 2017 at 11:29:40AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err message. Also replace "fail"
> with "failure".

Acked-by: Vinod Koul <vinod.koul@intel.com>

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
> +			dev_err(rtd->dev, "dma buffer allocation failure\n");
>  			return retval;
>  		}
>  	}
> -- 
> 2.11.0
> 

-- 
~Vinod
