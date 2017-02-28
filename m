From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: bdw-rt5677: Use
 devm_gpiod_get()
Date: Tue, 28 Feb 2017 15:19:38 +0000
Message-ID: <1488295178.2575.24.camel@loki>
References: <20170220174610.47314-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D833261740
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 16:19:43 +0100 (CET)
In-Reply-To: <20170220174610.47314-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-02-20 at 19:46 +0200, Andy Shevchenko wrote:
> Since index is always 0 replace devm_gpiod_get_index() by devm_gpiod_get()
> and apply proper flags.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/intel/boards/bdw-rt5677.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
> index ab383af14ca2..8284a40829be 100644
> --- a/sound/soc/intel/boards/bdw-rt5677.c
> +++ b/sound/soc/intel/boards/bdw-rt5677.c
> @@ -205,13 +205,12 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
>  			RT5677_CLK_SEL_I2S1_ASRC);
>  
>  	/* Request rt5677 GPIO for headphone amp control */
> -	bdw_rt5677->gpio_hp_en = devm_gpiod_get_index(codec->dev,
> -			"headphone-enable", 0, 0);
> +	bdw_rt5677->gpio_hp_en = devm_gpiod_get(codec->dev, "headphone-enable",
> +						GPIOD_OUT_LOW);
>  	if (IS_ERR(bdw_rt5677->gpio_hp_en)) {
>  		dev_err(codec->dev, "Can't find HP_AMP_SHDN_L gpio\n");
>  		return PTR_ERR(bdw_rt5677->gpio_hp_en);
>  	}
> -	gpiod_direction_output(bdw_rt5677->gpio_hp_en, 0);
>  
>  	/* Create and initialize headphone jack */
>  	if (!snd_soc_card_jack_new(rtd->card, "Headphone Jack",

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
