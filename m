From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Skylake: Add channel
 constraints for refcap
Date: Thu, 19 May 2016 09:09:49 +0530
Message-ID: <20160519033948.GV23734@localhost>
References: <1463503385-4535-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 52247260647
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2016 05:33:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1463503385-4535-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, marc.herbert@intel.com, benzh@chromium.org, broonie@kernel.org, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2016 at 09:43:04AM -0700, Yong Zhi wrote:
> Add constraint for ref DMIC to match with the
> topology firmware config.
> 
> Signed-off-by: Yong Zhi <yong.zhi@intel.com>

Both:

Acked-by: Vinod Koul <vinod.koul@intel.com>

> ---
>  sound/soc/intel/boards/skl_nau88l25_max98357a.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
> index 7cc7251..463f0e5 100644
> --- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
> +++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
> @@ -339,8 +339,22 @@ static struct snd_pcm_hw_constraint_list constraints_16000 = {
>  	.list  = rates_16000,
>  };
>  
> +static const unsigned int ch_mono[] = {
> +	1,
> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_refcap = {
> +	.count = ARRAY_SIZE(ch_mono),
> +	.list  = ch_mono,
> +};
> +
>  static int skylake_refcap_startup(struct snd_pcm_substream *substream)
>  {
> +	substream->runtime->hw.channels_max = 1;
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +					SNDRV_PCM_HW_PARAM_CHANNELS,
> +					&constraints_refcap);
> +
>  	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>  				SNDRV_PCM_HW_PARAM_RATE,
>  				&constraints_16000);
> -- 
> 1.9.1
> 

-- 
~Vinod
