From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: mrfld: simplify sst_fill_widget_module_info
Date: Mon, 15 Jun 2015 10:38:57 +0530
Message-ID: <20150615050856.GQ28601@localhost>
References: <1433405633-18656-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433405633-18656-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, yang.a.fang@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2015 at 10:13:53AM +0200, Rasmus Villemoes wrote:
> Some tiny improvements, cutting 180 bytes off the generated code.
> 
> - use strchr() for single-character needle
> 
> - compute index using pointer subtraction instead of two strlen()
>   calls
> 
> - factor out the common check for whether the initial part of
>   kctl->id.name (before the space) is identical to w->name.
Acked-by: Vinod Koul <vinod.koul@intel.com

Also Terry did the tests on this patch so would be good to add

Tested-by: Fang, Yang A <yang.a.fang@intel.com>

-- 
~Vinod

> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  sound/soc/intel/atom/sst-atom-controls.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
> index 90aa5c0476f3..16670feeee6a 100644
> --- a/sound/soc/intel/atom/sst-atom-controls.c
> +++ b/sound/soc/intel/atom/sst-atom-controls.c
> @@ -1280,36 +1280,32 @@ static int sst_fill_widget_module_info(struct snd_soc_dapm_widget *w,
>  	down_read(&card->controls_rwsem);
>  
>  	list_for_each_entry(kctl, &card->controls, list) {
> -		idx = strstr(kctl->id.name, " ");
> +		idx = strchr(kctl->id.name, ' ');
>  		if (idx == NULL)
>  			continue;
> -		index  = strlen(kctl->id.name) - strlen(idx);
> +		index = idx - (char*)kctl->id.name;
> +		if (strncmp(kctl->id.name, w->name, index))
> +			continue;
>  
> -		if (strstr(kctl->id.name, "Volume") &&
> -		    !strncmp(kctl->id.name, w->name, index))
> +		if (strstr(kctl->id.name, "Volume"))
>  			ret = sst_fill_module_list(kctl, w, SST_MODULE_GAIN);
>  
> -		else if (strstr(kctl->id.name, "params") &&
> -			 !strncmp(kctl->id.name, w->name, index))
> +		else if (strstr(kctl->id.name, "params"))
>  			ret = sst_fill_module_list(kctl, w, SST_MODULE_ALGO);
>  
>  		else if (strstr(kctl->id.name, "Switch") &&
> -			 !strncmp(kctl->id.name, w->name, index) &&
>  			 strstr(kctl->id.name, "Gain")) {
>  			struct sst_gain_mixer_control *mc =
>  						(void *)kctl->private_value;
>  
>  			mc->w = w;
>  
> -		} else if (strstr(kctl->id.name, "interleaver") &&
> -			 !strncmp(kctl->id.name, w->name, index)) {
> +		} else if (strstr(kctl->id.name, "interleaver")) {
>  			struct sst_enum *e = (void *)kctl->private_value;
>  
>  			e->w = w;
>  
> -		} else if (strstr(kctl->id.name, "deinterleaver") &&
> -			 !strncmp(kctl->id.name, w->name, index)) {
> -
> +		} else if (strstr(kctl->id.name, "deinterleaver")) {
>  			struct sst_enum *e = (void *)kctl->private_value;
>  
>  			e->w = w;
> -- 
> 2.1.3
> 

-- 
