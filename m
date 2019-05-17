From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH][RFC] ASoC: soc-core: WARN() is not related
 to component->driver->probe
Date: Fri, 17 May 2019 08:08:08 -0500
Message-ID: <0ba565ea-2f61-015d-f6e3-63124f94e78a@linux.intel.com>
References: <87imu939x3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A6D6F806E7
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2019 15:08:12 +0200 (CEST)
In-Reply-To: <87imu939x3.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Vinod Koul <vkoul@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 5/17/19 1:06 AM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> soc_probe_component() has WARN() under if (component->driver->probe),
> but, this WARN() check is not related to .probe callback.
> So, it should be called at (B) instead of (A).
> This patch moves it out of if().
> 
> 	if (component->driver->probe) {
> 		ret = component->driver->probe(component);
> 		...
> (A)		WARN(...)
> 	}
> (B)	WARN(...)
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Mark, Pierre-Louis, Vinod, Liam
> 
> I think this patch is correct, but I'm not sure.
> I'm happy someone can confirm it.

This WARN() was added in 2012 by ff541f4b2a75 ('ASoC: core: giving WARN 
when device starting from non-off bias with idle_bias_off')

The commit message hints at an intentional check

"
Just found some cases that some codec drivers set the bias to _STANDBY 
and set idle_bias_off to 1 during probing.
It will cause unpaired runtime_get_sync/put() issue. Also as Mark 
suggested, there is no reason to start from _STANDBY bias with 
idle_bias_off == 1.

So here giving one warning when detected (dapm.idle_bias_off == 1) and
     (dapm.bias_level != SND_SOC_BIAS_OFF) just after driver->probe().
"

My take is that unless we can prove this is incorrect we leave it as is.

> 
>   sound/soc/soc-core.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index cab30ae..7157d67 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1420,12 +1420,11 @@ static int soc_probe_component(struct snd_soc_card *card,
>   				"ASoC: failed to probe component %d\n", ret);
>   			goto err_probe;
>   		}
> -
> -		WARN(dapm->idle_bias_off &&
> -			dapm->bias_level != SND_SOC_BIAS_OFF,
> -			"codec %s can not start from non-off bias with idle_bias_off==1\n",
> -			component->name);
>   	}
> +	WARN(dapm->idle_bias_off &&
> +	     dapm->bias_level != SND_SOC_BIAS_OFF,
> +	     "codec %s can not start from non-off bias with idle_bias_off==1\n",
> +	     component->name);
>   
>   	/* machine specific init */
>   	if (component->init) {
> 
