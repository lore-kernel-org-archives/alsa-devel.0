From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: do not hw_free BE if it's
 still used
Date: Wed, 03 Dec 2014 20:37:31 +0000
Message-ID: <1417639051.2559.37.camel@loki>
References: <1417572823-22420-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A7A062605D7
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 23:03:16 +0100 (CET)
In-Reply-To: <1417572823-22420-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: alsa-devel@alsa-project.org, shangll@marvell.com, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-12-03 at 10:13 +0800, Qiao Zhou wrote:
> Do not free BE hw if it's still used by other FE during dpcm runtime
> shutdown. Otherwise the BE runtime state will be STATE_HW_FREE and
> won't be updated to STATE_CLOSE when shutdown ends, because BE dai
> shutdown function won't close pcm when detecting BE is still under
> use. With STATE_HW_FREE, BE can't be triggered start again.
> 
> This corner case can easily appear when one BE is used by two FE,
> without this patch "ASoC: dpcm: Fix race between FE/BE updates and
> trigger"(ea9d0d771fcd32cd56070819749477d511ec9117). One FE tries to
> shutdown but it's raced against xrun on another FE. It improves the
> be dai hw_free logic.
> 
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

> ---
>  sound/soc/soc-pcm.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 57277dd..70e8088 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1664,6 +1664,10 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
>  		if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
>  				continue;
>  
> +		/* do not free hw if this BE is used by other FE */
> +		if (be->dpcm[stream].users > 1)
> +			continue;
> +
>  		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
>  		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
>  		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
