From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: bxt: Refine the HW contraint
 of Ref capture.
Date: Wed, 13 Dec 2017 09:01:13 +0530
Message-ID: <20171213033113.GI18649@localhost>
References: <20171205192127.16210-1-harry.pan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C33CE26717B
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 04:27:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171205192127.16210-1-harry.pan@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harry Pan <harry.pan@intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, harshapriya.n@intel.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, sathyanarayana.nujella@intel.com, jeeja.kp@intel.com, Adam.Thomson.Opensource@diasemi.com, linux-audio-intel@eclists.intel.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 06, 2017 at 03:21:27AM +0800, Harry Pan wrote:
> The patch restricts the HW contraint of the refcap of WoV stream
> in single channel (mono) and 16k Hz based on platform implementation.
> 
> Such that, the userspace program can rely on correct HW parameters
> through the ALSA library call to manipulate the device.

I think this has been discussed earlier in the context of kbl machine and we
dont want kernel to have such restrictions. User space can request and open
a mono stream..

> 
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> ---
>  sound/soc/intel/boards/bxt_da7219_max98357a.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index ce35ec7884d1..382f71228807 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -338,8 +338,23 @@ static const struct snd_pcm_hw_constraint_list constraints_16000 = {
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
>  static int broxton_refcap_startup(struct snd_pcm_substream *substream)
>  {
> +	substream->runtime->hw.channels_max = 1;
> +
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +					SNDRV_PCM_HW_PARAM_CHANNELS,
> +					&constraints_refcap);
> +
>  	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>  			SNDRV_PCM_HW_PARAM_RATE,
>  			&constraints_16000);
> -- 
> 2.13.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
