From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 12/18] ASoC: rx51: Use
	snd_pcm_hw_constraint_single()
Date: Sun, 18 Oct 2015 20:19:19 +0300
Message-ID: <5623D497.5010701@bitmer.com>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
 <1445175573-11784-13-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id EB389265361
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 19:19:21 +0200 (CEST)
In-Reply-To: <1445175573-11784-13-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org

On 10/18/2015 04:39 PM, Lars-Peter Clausen wrote:
> Use the new snd_pcm_hw_constraint_single() helper function instead of
> calling snd_pcm_hw_constraint_minmax() with the same value for min and max
> to install a constraint that limits the possible configuration values to a
> single value. Using snd_pcm_hw_constraint_single() makes the indented
> result clearer and is slightly shorter.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/omap/rx51.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index 3bebfb1..20728d0 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -107,8 +107,7 @@ static int rx51_startup(struct snd_pcm_substream *substream)
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_card *card = rtd->card;
>  
> -	snd_pcm_hw_constraint_minmax(runtime,
> -				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
> +	snd_pcm_hw_constraint_single(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>  	rx51_ext_control(&card->dapm);
>  
>  	return 0;
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
