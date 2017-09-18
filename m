From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Headset button support in
 kabylake machine driver
Date: Mon, 18 Sep 2017 09:07:40 +0530
Message-ID: <20170918033740.GG30097@localhost>
References: <1505463201-6419-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C683266819
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 05:33:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1505463201-6419-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 15, 2017 at 01:43:21PM +0530, Naveen M wrote:
> Patch adds headset button support for kabylake machine driver
> (kbl_rt5663_max98927).

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Signed-off-by: Naveen M <naveen.m@intel.com>
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> index 7f76074..e45b6fe 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> @@ -17,6 +17,7 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/input.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <sound/core.h>
> @@ -208,6 +209,7 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
>  	int ret;
>  	struct kbl_rt5663_private *ctx = snd_soc_card_get_drvdata(rtd->card);
>  	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_jack *jack;
>  
>  	/*
>  	 * Headset buttons map to the google Reference headset.
> @@ -221,6 +223,13 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
>  		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
>  		return ret;
>  	}
> +
> +	jack = &ctx->kabylake_headset;
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +
>  	rt5663_set_jack_detect(codec, &ctx->kabylake_headset);
>  	return ret;
>  }
> -- 
> 1.9.1
> 

-- 
~Vinod
