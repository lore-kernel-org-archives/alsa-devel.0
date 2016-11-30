From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: rt5670: Enable Braswell platform
 workaround for Dell Wyse 3040
Date: Wed, 30 Nov 2016 22:06:15 +0530
Message-ID: <20161130163615.GG6408@localhost>
References: <20161130161920.10817-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E949266912
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 17:26:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161130161920.10817-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 30, 2016 at 05:19:20PM +0100, Takashi Iwai wrote:
> Dell Wyse 3040 requires the platform workaround for enabling dmic and
> jack detection as defined for Braswell CRB.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> ---
> 
> I guess the platform data should be applied generically to all CHT
> machines instead of DMI matching?  DMI matching doesn't scale,
> obviously.

we ahve been doing this on other RT codecs like RT286/298 as well for combo
jack to work. Yeah a better solution would be welcomed :)

> 
>  sound/soc/codecs/rt5670.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
> index 98c7efbc6ee0..97bafac3bc15 100644
> --- a/sound/soc/codecs/rt5670.c
> +++ b/sound/soc/codecs/rt5670.c
> @@ -2827,6 +2827,13 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
>  			DMI_MATCH(DMI_BOARD_NAME, "Braswell CRB"),
>  		},
>  	},
> +	{
> +		.ident = "Dell Wyse 3040",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Wyse 3040"),
> +		},
> +	},
>  	{}
>  };
>  
> -- 
> 2.10.2
> 

-- 
~Vinod
