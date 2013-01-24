From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 1/3] ASoC: soc-compress: Add missing
 brackets around else
Date: Thu, 24 Jan 2013 02:17:21 -0800
Message-ID: <1359022641.8789.3177.camel@vkoul-udesk3>
References: <1359020670-25684-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id B66D92615E6
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 11:42:15 +0100 (CET)
In-Reply-To: <1359020670-25684-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-01-24 at 09:44 +0000, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-compress.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 5fbfb06..80040f0 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -112,10 +112,11 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
>  			snd_soc_dapm_stream_event(rtd,
>  					SNDRV_PCM_STREAM_PLAYBACK,
>  					SND_SOC_DAPM_STREAM_STOP);
> -		} else
> +		} else {
>  			rtd->pop_wait = 1;
>  			schedule_delayed_work(&rtd->delayed_work,
>  				msecs_to_jiffies(rtd->pmdown_time));
> +		}
>  	} else {
>  		/* capture streams can be powered down now */
>  		snd_soc_dapm_stream_event(rtd,

All three:
Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Jeeja KP <jeeja.kp@intel.com>

We had the similar fixes on our BSP, I have one more, will send shortly

Thanks
-- 
~Vinod
