From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ASoC: Remove special casing for
	registerless widgets
Date: Sat, 2 Apr 2011 16:07:55 +0800
Message-ID: <20110402080755.GG14553@qtel.sh.intel.com>
References: <1301730541-10767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D47B103815
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 10:08:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301730541-10767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 02, 2011 at 03:49:01PM +0800, Mark Brown wrote:
> Since we recently explicitly set the register for registerless widgets
> to no register there is no longer any need to special case power updates
> for them, we can allow them to be handled with the register compression
> code as other widgets are.
> 
> As this is the only remaining user of dapm_generic_apply_power() and
> dapm_update_bits() also remove those functions.
> 
> Noticed-by: Lu Guanqun <guanqun.lu@intel.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> Compile tested only currently, sending it out now as part of discussion
> with Lu Guanqun.

I see the point what you were saying.

But I still don't quite understand the write compression, it aims at
reducing the number of register writes, however in
dapm_seq_run_coalesced, it calls snd_soc_update_bits.

Could you explain a little bit? It's appreciated. I'm vauge in this
part.

> 
>  sound/soc/soc-dapm.c |  100 --------------------------------------------------
>  1 files changed, 0 insertions(+), 100 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index b11d011..c9196d6 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -322,45 +322,6 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
>  	return -ENODEV;
>  }
>  
> -/* update dapm codec register bits */
> -static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
> -{
> -	int change, power;
> -	unsigned int old, new;
> -	struct snd_soc_codec *codec = widget->codec;
> -	struct snd_soc_dapm_context *dapm = widget->dapm;
> -	struct snd_soc_card *card = dapm->card;
> -
> -	/* check for valid widgets */
> -	if (widget->reg < 0 || widget->id == snd_soc_dapm_input ||
> -		widget->id == snd_soc_dapm_output ||
> -		widget->id == snd_soc_dapm_hp ||
> -		widget->id == snd_soc_dapm_mic ||
> -		widget->id == snd_soc_dapm_line ||
> -		widget->id == snd_soc_dapm_spk)
> -		return 0;
> -
> -	power = widget->power;
> -	if (widget->invert)
> -		power = (power ? 0:1);
> -
> -	old = snd_soc_read(codec, widget->reg);
> -	new = (old & ~(0x1 << widget->shift)) | (power << widget->shift);
> -
> -	change = old != new;
> -	if (change) {
> -		pop_dbg(dapm->dev, card->pop_time,
> -			"pop test %s : %s in %d ms\n",
> -			widget->name, widget->power ? "on" : "off",
> -			card->pop_time);
> -		pop_wait(card->pop_time);
> -		snd_soc_write(codec, widget->reg, new);
> -	}
> -	dev_dbg(dapm->dev, "reg %x old %x new %x change %d\n", widget->reg,
> -		old, new, change);
> -	return change;
> -}
> -
>  /* create new dapm mixer control */
>  static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
>  	struct snd_soc_dapm_widget *w)
> @@ -644,57 +605,6 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
>  }
>  EXPORT_SYMBOL_GPL(dapm_reg_event);
>  
> -/* Standard power change method, used to apply power changes to most
> - * widgets.
> - */
> -static int dapm_generic_apply_power(struct snd_soc_dapm_widget *w)
> -{
> -	int ret;
> -
> -	/* call any power change event handlers */
> -	if (w->event)
> -		dev_dbg(w->dapm->dev, "power %s event for %s flags %x\n",
> -			 w->power ? "on" : "off",
> -			 w->name, w->event_flags);
> -
> -	/* power up pre event */
> -	if (w->power && w->event &&
> -	    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
> -		ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	/* power down pre event */
> -	if (!w->power && w->event &&
> -	    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
> -		ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	dapm_update_bits(w);
> -
> -	/* power up post event */
> -	if (w->power && w->event &&
> -	    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
> -		ret = w->event(w,
> -			       NULL, SND_SOC_DAPM_POST_PMU);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	/* power down post event */
> -	if (!w->power && w->event &&
> -	    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
> -		ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  /* Generic check to see if a widget should be powered.
>   */
>  static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
> @@ -981,16 +891,6 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
>  					       NULL, SND_SOC_DAPM_POST_PMD);
>  			break;
>  
> -		case snd_soc_dapm_input:
> -		case snd_soc_dapm_output:
> -		case snd_soc_dapm_hp:
> -		case snd_soc_dapm_mic:
> -		case snd_soc_dapm_line:
> -		case snd_soc_dapm_spk:
> -			/* No register support currently */
> -			ret = dapm_generic_apply_power(w);
> -			break;
> -
>  		default:
>  			/* Queue it up for application */
>  			cur_sort = sort[w->id];
> -- 
> 1.7.4.1
> 

-- 
guanqun
