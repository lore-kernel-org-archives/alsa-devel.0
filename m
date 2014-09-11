From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] ASoC: mmp-pcm: add NO_PERIOD_WAKEUP
	for PCM INFO
Date: Thu, 11 Sep 2014 10:49:41 +0530
Message-ID: <20140911051941.GE3131@intel.com>
References: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
 <1410338449-13961-2-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D0860265626
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 07:43:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1410338449-13961-2-git-send-email-zhouqiao@marvell.com>
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
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk, tiwai@suse.de, lgirdwood@gmail.com, haojian.zhuang@gmail.com, broonie@kernel.org, zhangfei.gao@gmail.com, dmaengine@vger.kernel.org, eric.y.miao@gmail.com, dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2014 at 04:40:49PM +0800, Qiao Zhou wrote:
> add NO_PERIOD_WAKEUP to PCM INFO, which supports audio no IRQ mode

Applied, thanks

-- 
~Vinod

> 
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
>  sound/soc/pxa/mmp-pcm.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
> index 5e8d813..64e8b94 100644
> --- a/sound/soc/pxa/mmp-pcm.c
> +++ b/sound/soc/pxa/mmp-pcm.c
> @@ -34,7 +34,8 @@ struct mmp_dma_data {
>  		SNDRV_PCM_INFO_MMAP_VALID |	\
>  		SNDRV_PCM_INFO_INTERLEAVED |	\
>  		SNDRV_PCM_INFO_PAUSE |		\
> -		SNDRV_PCM_INFO_RESUME)
> +		SNDRV_PCM_INFO_RESUME |		\
> +		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP)
>  
>  static struct snd_pcm_hardware mmp_pcm_hardware[] = {
>  	{
> -- 
> 1.7.0.4
> 

-- 
