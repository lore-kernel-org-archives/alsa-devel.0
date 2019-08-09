From: Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Add missing include file hdac_hda.h
Date: Fri, 9 Aug 2019 18:52:37 +0800
Message-ID: <da80a1fb-e897-e5a4-0809-2349a92279bb@huawei.com>
References: <20190809095550.71040-1-yuehaibing@huawei.com>
 <s5hh86qhcyg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hh86qhcyg.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com, yang.jie@linux.intel.com, perex@perex.cz, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019/8/9 18:04, Takashi Iwai wrote:
> On Fri, 09 Aug 2019 11:55:50 +0200,
> YueHaibing wrote:
>>
>> Building with SND_SOC_SOF_HDA_AUDIO_CODEC fails:
>>
>> sound/soc/sof/intel/hda-bus.c: In function sof_hda_bus_init:
>> sound/soc/sof/intel/hda-bus.c:16:25: error: implicit declaration of function
>>  snd_soc_hdac_hda_get_ops; did you mean snd_soc_jack_add_gpiods? [-Werror=implicit-function-declaration]
>>  #define sof_hda_ext_ops snd_soc_hdac_hda_get_ops()
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: d4ff1b3917a5 ('ASoC: SOF: Intel: Initialize hdaudio bus properly")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Damn, it seems another oversight.
> 
> And now the inclusion in sound/soc/sof/intel/hda.c is superfluous,
> too, so we should just move like
> 
> diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
> index 0caec3a070d3..2b384134a3db 100644
> --- a/sound/soc/sof/intel/hda-bus.c
> +++ b/sound/soc/sof/intel/hda-bus.c
> @@ -11,6 +11,9 @@
>  #include <sound/hdaudio.h>
>  #include "../sof-priv.h"
>  #include "hda.h"
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
> +#include "../../codecs/hdac_hda.h"
> +#endif
>  
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
>  #define sof_hda_ext_ops	snd_soc_hdac_hda_get_ops()
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 7ca27000c34d..dd6c8ad62b3e 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -23,9 +23,6 @@
>  #include <sound/sof/xtensa.h>
>  #include "../ops.h"
>  #include "hda.h"
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
> -#include "../../codecs/hdac_hda.h"
> -#endif
>  
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
>  #include <sound/soc-acpi-intel-match.h>
> 
> 
> Could you check whether this works instead?

It works well, I can send v2 using this, Thanks!

> 
> 
> BTW, the inclusion of "../../codecs/hdac_hdac.h" is very ugly...
> In general if a header file is referred from another driver, it should
> be in a more public place under include/sound.  If any, we can create
> a subdirectory like include/sound/codecs.
> 

Yes, this can be done in another patch.

> 
> thanks,
> 
> Takashi
> 
> .
> 
