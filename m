From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [alsa-devel] [PATCH] [ASoC][soc-dapm] : memory leak in the func
 snd_soc_dapm_new_dai
Date: Mon, 29 Jul 2019 09:18:35 +0100
Message-ID: <20190729081835.GE54126@ediswmail.ad.cirrus.com>
References: <20190725161335.4162-1-thakursatendra2003@yahoo.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725161335.4162-1-thakursatendra2003@yahoo.co.in>
Sender: linux-kernel-owner@vger.kernel.org
To: Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 09:43:35PM +0530, Satendra Singh Thakur wrote:
> In the func snd_soc_dapm_new_dai, if the inner func
> snd_soc_dapm_alloc_kcontrol fails, there will be memory leak.
> The label param_fail wont free memory which is allocated by
> the func devm_kcalloc. Hence new label is created for this purpose.
> 
> Signed-off-by: Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
> ---
>  sound/soc/soc-dapm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index f013b24c050a..f62d41ee6d68 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -4095,7 +4095,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
>  						w_param_text, &private_value);
>  		if (!template.kcontrol_news) {
>  			ret = -ENOMEM;
> -			goto param_fail;
> +			goto outfree_w_param;
>  		}
>  	} else {
>  		w_param_text = NULL;
> @@ -4114,6 +4114,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
>  
>  outfree_kcontrol_news:
>  	devm_kfree(card->dev, (void *)template.kcontrol_news);
> +outfree_w_param:
>  	snd_soc_dapm_free_kcontrol(card, &private_value,
>  				   rtd->dai_link->num_params, w_param_text);

This is not necessary snd_soc_dapm_alloc_kcontrol calls
snd_soc_dapm_free_kcontrol on its internal error path.

Thanks,
Charles
